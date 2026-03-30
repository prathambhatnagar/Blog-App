import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/core/usecase/usecase.dart';
import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:blog_assignment/domain/repositories/blog/blog_repository.dart';
import 'package:dartz/dartz.dart';

class GetBlogDetailUseCase implements Usecase<BlogEntity, int> {
  final BlogRepository repository;

  GetBlogDetailUseCase(this.repository);

  @override
  Future<Either<Failure, BlogEntity>> call({required int param}) {
    return repository.getBlogById(param);
  }
}
