import 'package:blog_assignment/domain/usecases/blog/get_blog_detail_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/get_blogs_usecase.dart';
import 'package:blog_assignment/domain/usecases/blog/search_blogs_usecase.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc_event.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogBloc extends Bloc<BlogBlocEvent, BlogState> {
  final GetBlogDetailUseCase getBlogDetailUseCase;
  final GetBlogsUseCase getBlogsUseCase;
  final SearchBlogsUseCase searchBlogsUseCase;

  int _currentPage = 1;
  static const int _perPage = 15;

  BlogBloc({
    required this.getBlogDetailUseCase,
    required this.searchBlogsUseCase,
    required this.getBlogsUseCase,
  }) : super(BlogState()) {
    on<FetchBlogs>(_onFetchBlogs);
    on<LoadMoreBlogs>(_onLoadMoreBlogs);
    on<SearchBlogs>(_onSearchBlogs);
  }

  Future<void> _onFetchBlogs(FetchBlogs event, Emitter<BlogState> emit) async {
    emit(state.copyWith(status: BlogStatus.loading));
    _currentPage = 1;

    try {
      final result = await getBlogsUseCase.call(
        param: GetBlogsParams(page: _currentPage, category: event.category),
      );
      result.fold(
        (failure) {
          state.copyWith(
            status: BlogStatus.failure,
            errorMessage: failure.message,
          );
        },
        (blogs) {
          emit(
            state.copyWith(
              status: BlogStatus.success,
              blogs: blogs,
              hasReachedMax: blogs.length < _perPage,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(status: BlogStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onLoadMoreBlogs(
    LoadMoreBlogs event,
    Emitter<BlogState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      _currentPage++;

      final result = await getBlogsUseCase.call(
        param: GetBlogsParams(page: _currentPage, category: event.category),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(errorMessage: failure.message));
        },
        (blogs) {
          emit(
            blogs.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: BlogStatus.success,
                    blogs: List.of(state.blogs)..addAll(blogs),
                    hasReachedMax: blogs.length < _perPage,
                  ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(status: BlogStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onSearchBlogs(
    SearchBlogs event,
    Emitter<BlogState> emit,
  ) async {
    _currentPage = 1;
    emit(state.copyWith(status: BlogStatus.loading));
    final result = await searchBlogsUseCase.call(param: event.query);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: BlogStatus.failure,
            errorMessage: failure.toString(),
          ),
        );
      },
      (blogs) {
        state.copyWith(
          blogs: blogs,
          status: BlogStatus.success,
          hasReachedMax: blogs.length < _perPage,
        );
      },
    );
  }
}
