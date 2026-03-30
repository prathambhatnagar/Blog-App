import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BlogRepository {
  Future<Either<Failure, List<BlogEntity>>> getBlogs({
    required int page,
    String? category,
  });

  Future<Either<Failure, BlogEntity>> getBlogById(int id);

  Future<Either<Failure, List<BlogEntity>>> searchBlogs(String query);
}
