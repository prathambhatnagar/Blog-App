import 'package:blog_assignment/data/repositories/auth/auth_repository_imp.dart';
import 'package:blog_assignment/data/repositories/blog/blog_repository_impl.dart';
import 'package:blog_assignment/data/services/auth/firebase_auth_service.dart';
import 'package:blog_assignment/data/services/blog/blog_service.dart';
import 'package:blog_assignment/domain/repositories/auth/auth_repository.dart';
import 'package:blog_assignment/domain/repositories/blog/blog_repository.dart';
import 'package:blog_assignment/domain/usecases/auth/email_sign_in_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/email_sign_up_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/google_sign_in_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/log_out_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/get_blog_detail_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/get_blogs_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/search_blogs_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;
void initServiceLocator() async {
  serviceLocator.registerSingleton<Dio>(Dio());

  serviceLocator.registerSingleton<BlogRemoteDataSource>(
    BlogRemoteDataSourceImpl(dio: serviceLocator<Dio>()),
  );

  serviceLocator.registerSingleton<BlogRepository>(
    BlogRepositoryImpl(
      blogRemoteDataSource: serviceLocator<BlogRemoteDataSource>(),
    ),
  );

  serviceLocator.registerSingleton<GetBlogsUseCase>(
    GetBlogsUseCase(serviceLocator<BlogRepository>()),
  );

  serviceLocator.registerSingleton<GetBlogDetailUseCase>(
    GetBlogDetailUseCase(serviceLocator<BlogRepository>()),
  );

  serviceLocator.registerSingleton<SearchBlogsUseCase>(
    SearchBlogsUseCase(serviceLocator<BlogRepository>()),
  );

  serviceLocator.registerSingleton<FirebaseAuthService>(
    FirebaseAuthServiceImpl(),
  );

  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImp(
      firebaseAuthService: serviceLocator<FirebaseAuthService>(),
    ),
  );

  serviceLocator.registerSingleton<EmailSignInUsecase>(
    EmailSignInUsecase(authRepository: serviceLocator<AuthRepository>()),
  );

  serviceLocator.registerSingleton<EmailSignUpUsecase>(
    EmailSignUpUsecase(authRepository: serviceLocator<AuthRepository>()),
  );

  serviceLocator.registerSingleton<GoogleSignInUsecase>(
    GoogleSignInUsecase(authRepository: serviceLocator<AuthRepository>()),
  );
  serviceLocator.registerSingleton<LogOutUsecase>(
    LogOutUsecase(authRepository: serviceLocator<AuthRepository>()),
  );
}
