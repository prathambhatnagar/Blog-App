import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/core/usecase/usecase.dart';
import 'package:blog_assignment/domain/entities/auth/user_entity.dart';
import 'package:blog_assignment/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EmailSignUpUsecase extends Usecase<UserEntity, SignUpParam> {
  EmailSignUpUsecase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call({required SignUpParam param}) async {
    return authRepository.signUp(email: param.email, password: param.password);
  }
}

class SignUpParam {
  SignUpParam({required this.email, required this.password});
  String email;
  String password;
}
