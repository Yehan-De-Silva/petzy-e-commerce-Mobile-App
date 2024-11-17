import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  final List<order> _orders = [];
  List<order> get orders => _orders;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch orders for the logged-in user
  Future<void> fetchOrders() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final snapshot = await _firestore
            .collection('orders')
            .where('userId', isEqualTo: user.uid)
            .orderBy('date', descending: true)
            .get();

        _orders.clear();
        for (var doc in snapshot.docs) {
          _orders.add(order.fromFirestore(doc));
        }
        notifyListeners();
      }
    } catch (error) {
      debugPrint('Error fetching orders: $error');
    }
  }

  // Add order to Firestore
  Future<void> addOrder(order order) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('orders').add({
          'userId': user.uid,
          'items': order.items.map((item) => item.toMap()).toList(),
          'paymentMethod': order.paymentMethod,
          'address': order.address,
          'subtotal': order.subtotal,
          'deliveryFee': order.deliveryFee,
          'totalAmount': order.totalAmount,
          'date': order.date.toIso8601String(),
        });

        _orders.add(order);
        notifyListeners();
      }
    } catch (error) {
      debugPrint('Error adding order: $error');
    }
  }
}
