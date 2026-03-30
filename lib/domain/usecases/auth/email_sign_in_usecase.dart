import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/core/usecase/usecase.dart';
import 'package:blog_assignment/domain/entities/auth/user_entity.dart';
import 'package:blog_assignment/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EmailSignInUsecase extends Usecase<UserEntity, SignInParam> {
  EmailSignInUsecase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call({required SignInParam param}) async {
    return authRepository.signIn(email: param.email, password: param.password);
  }
}

class SignInParam {
  SignInParam({required this.email, required this.password});
  String email;
  String password;
}
