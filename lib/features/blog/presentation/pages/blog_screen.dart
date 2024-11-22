import 'package:blog_app/core/routes.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App '),
        actions: [
          IconButton(
            onPressed: () => context.push(AddNewBlogScreen.routeName),
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
    );
  }
}
