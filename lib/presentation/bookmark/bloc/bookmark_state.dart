import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';

abstract class BookmarkState {}

class BookmarkLoadingState extends BookmarkState {}

class BookmarkErrorState extends BookmarkState {
  BookmarkErrorState({required this.message});
  String message;
}

class BookmarkLoadedState extends BookmarkState {
  final List<BlogEntity> items;
  BookmarkLoadedState({required this.items});
}
