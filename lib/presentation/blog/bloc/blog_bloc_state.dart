import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';

enum BlogStatus { initial, loading, success, failure, isLoadingMore }

class BlogState {
  final BlogStatus status;
  final List<BlogEntity> blogs;
  final bool hasReachedMax;
  final String? errorMessage;
  BlogState({
    this.status = BlogStatus.initial,
    this.blogs = const [],
    this.hasReachedMax = false,
    this.errorMessage,
  });

  BlogState copyWith({
    BlogStatus? status,
    List<BlogEntity>? blogs,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return BlogState(
      status: status ?? this.status,
      blogs: blogs ?? this.blogs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
