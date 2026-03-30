import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, void>> add(BlogEntity blog);
  Future<Either<Failure, void>> remove(int id);
  Future<Either<Failure, List<BlogEntity>>> getAll();
}
