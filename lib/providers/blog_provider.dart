import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogProvider extends ChangeNotifier {
  final List<Map<String, String>> _blogs = [];
  bool _isLoading = false;

  List<Map<String, String>> get blogs => _blogs;
  bool get isLoading => _isLoading;

  Future<void> fetchBlogs() async {
    _isLoading = true;
    notifyListeners();

    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('blogs').get();
      _blogs.clear();
      for (var doc in querySnapshot.docs) {
        _blogs.add({
          'title': doc['title'] ?? 'No Title',
          'description': doc['description'] ?? 'No Description',
        });
      }
    } catch (e) {
      log('Error fetching blogs: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
