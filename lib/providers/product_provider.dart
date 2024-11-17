import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];
  String _selectedType = '';

  List<Product> get products {
    if (_selectedType.isEmpty) {
      return _products;
    }
    return _products.where((product) => product.type == _selectedType).toList();
  }

  String get selectedType => _selectedType;

  Future<void> fetchProducts() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('products').get();
    _products.clear();
    for (var doc in querySnapshot.docs) {
      _products.add(Product.fromMap(doc.id, doc.data()));
    }
    notifyListeners();
  }

  void filterByType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  void clearFilter() {
    _selectedType = '';
    notifyListeners();
  }
}
