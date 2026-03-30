import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc_event.dart';
import 'package:blog_assignment/presentation/blog/bloc/blog_bloc_state.dart';
import 'package:blog_assignment/presentation/blog/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogContent extends StatefulWidget {
  const BlogContent({super.key, required this.blogs});
  final List<BlogEntity> blogs;

  @override
  State<BlogContent> createState() => _BlogContentState();
}

class _BlogContentState extends State<BlogContent> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<BlogBloc>().add(LoadMoreBlogs());
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<BlogBloc>().add(FetchBlogs());
            await context.read<BlogBloc>().stream.firstWhere(
              (state) => state.status != BlogStatus.loading,
            );
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            slivers: [
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 340,
                ),
                itemCount: state.blogs.length,
                itemBuilder: (context, index) =>
                    BlogCard(blogEntity: state.blogs[index]),
              ),
              if (!state.hasReachedMax)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
