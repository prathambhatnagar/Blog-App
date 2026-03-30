import 'package:blog_assignment/data/models/blog/blog_model.dart';
import 'package:dio/dio.dart';

abstract class BlogRemoteDataSource {
  Future<List<BlogModel>> getBlogs({required int page, String? category});
  Future<BlogModel> getBlogById(int id);
  Future<List<BlogModel>> searchBlogs(String query);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final Dio dio;

  BlogRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<BlogModel>> getBlogs({
    required int page,
    String? category,
  }) async {
    final response = await dio.get(
      'https://dev.to/api/articles',
      queryParameters: {
        'page': page,
        'per_page': 15,
        if (category != null) 'tag': category,
      },
    );

    return (response.data as List)
        .map((json) => BlogModel.fromJson(json))
        .toList();
  }

  @override
  Future<BlogModel> getBlogById(int id) async {
    final response = await dio.get('https://dev.to/api/articles/$id');
    return BlogModel.fromJson(response.data);
  }

  @override
  Future<List<BlogModel>> searchBlogs(String query) async {
    final response = await dio.get(
      'https://dev.to/api/articles',
      queryParameters: {'q': query},
    );

    return (response.data as List)
        .map((json) => BlogModel.fromJson(json))
        .toList();
  }
}
