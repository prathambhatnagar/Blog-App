import 'package:blog_assignment/core/widgets/error_tile.dart';
import 'package:blog_assignment/core/widgets/loader.dart';
import 'package:blog_assignment/presentation/bookmark/bloc/bookmark_bloc.dart';
import 'package:blog_assignment/presentation/bookmark/bloc/bookmark_state.dart';
import 'package:blog_assignment/presentation/bookmark/widgets/book_mark_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookmarks")),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkLoadingState) {
            return Loader();
          } else if (state is BookmarkErrorState) {
            return ErrorTile(error: state.message);
          } else if (state is BookmarkLoadedState) {
            return BookMarkContent(blogs: state.items);
          } else {
            return ErrorTile();
          }
        },
      ),
    );
  }
}
