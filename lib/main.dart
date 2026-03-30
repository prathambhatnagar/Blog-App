import 'package:blog_assignment/core/service_locator/service_locator.dart';
import 'package:blog_assignment/domain/usecases/auth/email_sign_in_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/email_sign_up_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/google_sign_in_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/log_out_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/get_blog_detail_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/get_blogs_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/search_blogs_usecase.dart';
import 'package:blog_assignment/presentation/auth/bloc/auth_bloc.dart';
import 'package:blog_assignment/presentation/auth/bloc/auth_bloc_state.dart';
import 'package:blog_assignment/presentation/auth/screens/sign_in_screen.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc_event.dart';
import 'package:blog_assignment/presentation/blog/screens/blog_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          ),
        ),

        BlocProvider(
          create: (context) => BlogBloc(
            getBlogDetailUseCase: serviceLocator<GetBlogDetailUseCase>(),
            searchBlogsUseCase: serviceLocator<SearchBlogsUseCase>(),
            getBlogsUseCase: serviceLocator<GetBlogsUseCase>(),
          )..add(FetchBlogs()),
        ),
      ],
      child: MaterialApp(
        home: BlocListener<AuthBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (builder) => BlogScreen()),
              );
            }
          },
          child: SignInPage(),
        ),
      ),
    );
  }
}
