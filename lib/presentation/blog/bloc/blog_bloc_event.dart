abstract class BlogBlocEvent {}

class FetchBlogs extends BlogBlocEvent {
  final String? category;
  FetchBlogs({this.category});
}

class LoadMoreBlogs extends BlogBlocEvent {
  final String? category;
  LoadMoreBlogs({this.category});
}

class SearchBlogs extends BlogBlocEvent {
  final String query;
  SearchBlogs({required this.query});
}
