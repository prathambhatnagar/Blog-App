import 'package:blog_assignment/core/usecase/usecase.dart';
import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:blog_assignment/domain/usecases/book_mark/book_marks_usecases.dart';
import 'package:blog_assignment/presentation/bookmark/bloc/bookmark_event.dart';
import 'package:blog_assignment/presentation/bookmark/bloc/bookmark_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final AddBookmarkUseCase addBookmarkUseCase;
  final RemoveBookmarkUseCase removeBookmarkUseCase;
  final GetBookmarksUseCase getBookmarksUseCase;

  BookmarkBloc({
    required this.addBookmarkUseCase,
    required this.removeBookmarkUseCase,
    required this.getBookmarksUseCase,
  }) : super(BookmarkLoadingState()) {
    on<LoadBookmarks>((event, emit) async {
      emit(BookmarkLoadingState());

      final result = await getBookmarksUseCase.call(param: NoParam());
      result.fold(
        (failure) {
          emit(BookmarkErrorState(message: failure.message));
        },
        (blogs) {
          emit(BookmarkLoadedState(items: blogs));
        },
      );
    });

    on<ToggleBookmark>((event, emit) async {
      List<BlogEntity> currentItems = [];
      if (state is BookmarkLoadedState) {
        currentItems = (state as BookmarkLoadedState).items;
      } else {
        final result = await getBookmarksUseCase.call(param: NoParam());
        result.fold((_) => null, (blogs) => currentItems = blogs);
      }
      final isBookmarked = currentItems.any((b) => b.id == event.blog.id);
      if (isBookmarked) {
        await removeBookmarkUseCase(param: event.blog.id);
      } else {
        await addBookmarkUseCase(param: event.blog);
      }
      add(LoadBookmarks());
    });
  }
}
