import 'package:blog_assignment/domain/usecases/book_mark/book_marks_usecases.dart';
import 'package:blog_assignment/presentation/bookmark/bloc/bookmark_event.dart';
import 'package:blog_assignment/presentation/bookmark/bloc/bookmark_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final AddBookmarkUseCase addUC;
  final RemoveBookmarkUseCase removeUC;
  final GetBookmarksUseCase getUC;

  BookmarkBloc({
    required this.addUC,
    required this.removeUC,
    required this.getUC,
  }) : super(BookmarkState()) {
    on<LoadBookmarks>((event, emit) {
      emit(BookmarkState(items: getUC()));
    });

    on<ToggleBookmark>((event, emit) async {
      final isBookmarked = state.items.any((b) => b.id == event.blog.id);
      if (isBookmarked) {
        await removeUC(param: event.blog.id);
      } else {
        await addUC(param: event.blog);
      }
      add(LoadBookmarks());
    });
  }
}
