import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/core/usecase/usecase.dart';
import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:blog_assignment/domain/repositories/blog/blog_repository.dart';
import 'package:dartz/dartz.dart';

class GetBlogsUseCase implements Usecase<List<BlogEntity>, GetBlogsParams> {
  final BlogRepository repository;

  GetBlogsUseCase(this.repository);

  @override
  Future<Either<Failure, List<BlogEntity>>> call({
    required GetBlogsParams param,
  }) {
    return repository.getBlogs(page: param.page, category: param.category);
  }
}

class GetBlogsParams {
  final int page;
  final String? category;
  GetBlogsParams({required this.page, this.category});
}
