import 'package:flutter/material.dart';

class ErrorTile extends StatelessWidget {
  const ErrorTile({super.key, this.error});
  final String? error;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.error_outline_rounded, size: 50, color: Colors.red),
        Text(
          error ?? 'Something Went Wrong',
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
      ],
    );
  }
}
