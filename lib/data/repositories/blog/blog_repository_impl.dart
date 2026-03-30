import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/data/models/blog/blog_model.dart';
import 'package:blog_assignment/data/services/blog/blog_service.dart';
import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:blog_assignment/domain/repositories/blog/blog_repository.dart';
import 'package:dartz/dartz.dart';

class BlogRepositoryImpl implements BlogRepository {
  BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl({required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, List<BlogEntity>>> getBlogs({
    required int page,
    String? category,
  }) async {
    try {
      final blogModels = await blogRemoteDataSource.getBlogs(page: page);
      final blogs = blogModels.map((e) => e.toEntity()).toList();
      return Right(blogs);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BlogEntity>> getBlogById(int id) async {
    try {
      final blogModel = await blogRemoteDataSource.getBlogById(id);
      return Right(blogModel.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> searchBlogs(String query) async {
    try {
      final blogModels = await blogRemoteDataSource.searchBlogs(query);
      final blogs = blogModels.map((e) => e.toEntity()).toList();
      return Right(blogs);
    } catch (e) {
      return Left(ServerFailure("Search failed"));
    }
  }
}
