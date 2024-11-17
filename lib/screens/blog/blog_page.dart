import 'package:flutter/material.dart';
import 'package:petzy/utils/constants.dart';
import 'package:petzy/widgets/blog_card.dart';
import 'package:provider/provider.dart';
import 'package:petzy/providers/blog_provider.dart';


class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor1,
        body: Consumer<BlogProvider>(
          builder: (context, blogProvider, child) {
            // Fetch blogs if they haven't fetched already
            if (!blogProvider.isLoading && blogProvider.blogs.isEmpty) {
              blogProvider.fetchBlogs();
            }

            return blogProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : blogProvider.blogs.isEmpty
                    ? const Center(child: Text('No blogs available.'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: blogProvider.blogs.length,
                        itemBuilder: (context, index) {
                          final blog = blogProvider.blogs[index];
                          return BlogCard(title: blog['title']!, description: blog['description']!);
                        },
                      );
          },
        ),
      ),
    );
  }
}

