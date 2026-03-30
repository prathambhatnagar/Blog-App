import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/domain/entities/auth/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  UserEntity? getCurrentUser();
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> googleSignIn();

  Future<Either<Failure, void>> logOut();
}
