import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:blog_assignment/presentation/blog/widgets/blog_card.dart';
import 'package:flutter/material.dart';

class BookMarkContent extends StatelessWidget {
  const BookMarkContent({super.key, required this.blogs});
  final List<BlogEntity> blogs;

  @override
  Widget build(BuildContext context) {
    if (blogs.isEmpty) return emptyBookMarkTile();
    return CustomScrollView(
      slivers: [
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisExtent: 340,
          ),
          itemCount: blogs.length,
          itemBuilder: (context, index) => BlogCard(blogEntity: blogs[index]),
        ),
      ],
    );
  }
}

Widget emptyBookMarkTile() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No Bookmarks Yet",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text("Saved blogs will appear here"),
      ],
    ),
  );
}
