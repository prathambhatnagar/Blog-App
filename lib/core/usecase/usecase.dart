import 'package:blog_assignment/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class Usecase<ReturnType, Param> {
  Future<Either<Failure, ReturnType>> call({required Param param});
}
