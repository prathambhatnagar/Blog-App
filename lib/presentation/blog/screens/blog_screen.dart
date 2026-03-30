import 'dart:developer';

import 'package:blog_assignment/core/widgets/error_tile.dart';
import 'package:blog_assignment/core/widgets/loader.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc_event.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc_state.dart';
import 'package:blog_assignment/presentation/blog/widgets/blog_content.dart';
import 'package:blog_assignment/presentation/blog/widgets/profile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<BlogBloc>().add(FetchBlogs());
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search blogs...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                log("serached pressed");
                if (_searchController.text.isNotEmpty) {
                  context.read<BlogBloc>().add(
                    SearchBlogs(query: _searchController.text),
                  );
                }
              },
            ),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              context.read<BlogBloc>().add(SearchBlogs(query: value));
            }
          },
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<BlogBloc, BlogState>(
          builder: (context, state) {
            if (state.status == BlogStatus.initial ||
                (state.status == BlogStatus.loading && state.blogs.isEmpty)) {
              log('showing Loader');
              return const Loader();
            } else if (state.errorMessage != null && state.blogs.isEmpty) {
              return ErrorTile(error: state.errorMessage);
            } else if (state.status == BlogStatus.success &&
                state.blogs.isEmpty) {
              return const Center(child: Text("Blog not Found"));
            } else {
              return BlogContent(blogs: state.blogs);
            }
          },
        ),
      ),
      drawer: ProfileDrawer(),
    );
  }
}
