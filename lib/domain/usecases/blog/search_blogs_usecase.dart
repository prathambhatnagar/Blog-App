import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/core/usecase/usecase.dart';
import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:blog_assignment/domain/repositories/blog/blog_repository.dart';
import 'package:dartz/dartz.dart';

class SearchBlogsUseCase implements Usecase<List<BlogEntity>, String> {
  final BlogRepository repository;

  SearchBlogsUseCase(this.repository);

  @override
  Future<Either<Failure, List<BlogEntity>>> call({required String param}) {
    return repository.searchBlogs(param);
  }
}
