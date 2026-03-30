import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/core/usecase/usecase.dart';
import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:blog_assignment/domain/repositories/favourite_blog/favourite_blog_repository.dart';
import 'package:dartz/dartz.dart';

class AddBookmarkUseCase extends Usecase<void, BlogEntity> {
  final BookmarkRepository repository;
  AddBookmarkUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call({required BlogEntity param}) =>
      repository.add(param);
}

class RemoveBookmarkUseCase extends Usecase<void, int> {
  final BookmarkRepository repository;
  RemoveBookmarkUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call({required int param}) =>
      repository.remove(param);
}

class GetBookmarksUseCase extends Usecase<List<BlogEntity>, NoParam> {
  final BookmarkRepository repository;
  GetBookmarksUseCase(this.repository);
  @override
  Future<Either<Failure, List<BlogEntity>>> call({required NoParam param}) =>
      repository.getAll();
}
