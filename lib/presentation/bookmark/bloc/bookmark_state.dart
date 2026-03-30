import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';

class BookmarkState {
  final List<BlogEntity> items;
  BookmarkState({this.items = const []});
}
