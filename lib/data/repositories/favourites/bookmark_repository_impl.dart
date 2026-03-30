import 'dart:developer';

import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/data/services/blog/local_favourite_blog_service.dart';
import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:blog_assignment/domain/repositories/bookmark_blog/bookmark_blog_repository.dart';
import 'package:dartz/dartz.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final LocalFavoriteBlogService localFavoriteBlogService;
  BookmarkRepositoryImpl({required this.localFavoriteBlogService});

  @override
  Future<Either<Failure, void>> add(BlogEntity blog) async {
    try {
      return Right(await localFavoriteBlogService.addBookmark(blog));
    } catch (e) {
      return Left(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> remove(int id) async {
    try {
      return Right(localFavoriteBlogService.removeBookmark(id));
    } catch (e) {
      return Left(DataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAll() async {
    try {
      return Right(localFavoriteBlogService.getBookmarks());
    } catch (e) {
      log(e.toString());
      return Left(DataBaseFailure());
    }
  }
}
