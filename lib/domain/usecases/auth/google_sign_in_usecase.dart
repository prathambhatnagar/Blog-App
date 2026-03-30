import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/core/usecase/usecase.dart';
import 'package:blog_assignment/domain/entities/auth/user_entity.dart';
import 'package:blog_assignment/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GoogleSignInUsecase extends Usecase<UserEntity, NoParam> {
  GoogleSignInUsecase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call({required NoParam param}) async {
    return authRepository.googleSignIn();
  }
}
