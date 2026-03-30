import 'package:flutter/material.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookmarks")),
      body: const Center(
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
      ),
    );
  }
}
