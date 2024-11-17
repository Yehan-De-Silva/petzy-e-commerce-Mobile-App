import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/order.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  double get totalPrice => product.price * quantity;
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void addToCart(Product product, int quantity) {
    var existingItem = _items.indexWhere((item) => item.product.name == product.name);
    if (existingItem >= 0) {
      _items[existingItem].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    var index = _items.indexWhere((item) => item.product.name == product.name);
    if (index >= 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.name == product.name);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }


  List<OrderItem> toOrderItems() {
    return _items.map((item) {
      return OrderItem(
        productName: item.product.name,
        quantity: item.quantity,
        totalPrice: item.totalPrice,
      );
    }).toList();
  }
}



