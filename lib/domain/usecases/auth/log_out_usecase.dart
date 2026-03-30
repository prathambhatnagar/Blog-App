import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/core/usecase/usecase.dart';
import 'package:blog_assignment/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogOutUsecase extends Usecase<void, NoParam> {
  LogOutUsecase({required this.authRepository});
  AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call({required NoParam param}) {
    return authRepository.logOut();
  }
}
