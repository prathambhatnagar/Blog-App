import 'package:blog_assignment/core/service_locator/service_locator.dart';
import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:blog_assignment/domain/repositories/auth/auth_repository.dart';
import 'package:blog_assignment/domain/usecases/auth/email_sign_in_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/email_sign_up_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/google_sign_in_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/log_out_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/get_blog_detail_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/get_blogs_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/search_blogs_usecase.dart';
import 'package:blog_assignment/domain/usecases/book_mark/book_marks_usecases.dart';
import 'package:blog_assignment/presentation/auth/bloc/auth_bloc.dart';
import 'package:blog_assignment/presentation/auth/bloc/auth_bloc_event.dart';
import 'package:blog_assignment/presentation/auth/bloc/auth_bloc_state.dart';
import 'package:blog_assignment/presentation/auth/screens/sign_in_screen.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc.dart';
import 'package:blog_assignment/presentation/blog/screens/blog_screen.dart';
import 'package:blog_assignment/presentation/bookmark/bloc/bookmark_bloc.dart';
import 'package:blog_assignment/presentation/bookmark/bloc/bookmark_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(BlogEntityAdapter());
  await Hive.openBox<BlogEntity>('favorite_blogs');
  await Firebase.initializeApp();
  initServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            emailSignInUsecase: serviceLocator<EmailSignInUsecase>(),
            emailSignUpUsecase: serviceLocator<EmailSignUpUsecase>(),
            googleSignInUsecase: serviceLocator<GoogleSignInUsecase>(),
            logOutUsecase: serviceLocator<LogOutUsecase>(),
            authRepository: serviceLocator<AuthRepository>(),
          )..add(AuthCheckRequested()),
        ),

        BlocProvider(
          create: (context) => BlogBloc(
            getBlogDetailUseCase: serviceLocator<GetBlogDetailUseCase>(),
            searchBlogsUseCase: serviceLocator<SearchBlogsUseCase>(),
            getBlogsUseCase: serviceLocator<GetBlogsUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => BookmarkBloc(
            addBookmarkUseCase: serviceLocator<AddBookmarkUseCase>(),
            removeBookmarkUseCase: serviceLocator<RemoveBookmarkUseCase>(),
            getBookmarksUseCase: serviceLocator<GetBookmarksUseCase>(),
          )..add(LoadBookmarks()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthBlocState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return const BlogScreen();
            } else {
              return const SignInPage();
            }
          },
        ),
      ),
    );
  }
}
