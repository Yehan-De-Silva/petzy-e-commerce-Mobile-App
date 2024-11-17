

import 'package:flutter/material.dart';
import 'package:petzy/utils/constants.dart';

class BlogCard extends StatelessWidget {
  final String title;
  final String description;

  const BlogCard({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.blogTitle,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.blogDescription,
            ),
          ],
        ),
      ),
    );
  }
}