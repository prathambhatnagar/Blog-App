import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';

abstract class BookmarkEvent {}

class LoadBookmarks extends BookmarkEvent {}

class ToggleBookmark extends BookmarkEvent {
  final BlogEntity blog;
  ToggleBookmark(this.blog);
}
