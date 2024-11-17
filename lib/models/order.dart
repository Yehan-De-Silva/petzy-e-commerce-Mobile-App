import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  final String productName;
  final int quantity;
  final double totalPrice;

  OrderItem({
    required this.productName,
    required this.quantity,
    required this.totalPrice,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  // Convert from Firestore Document
  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productName: map['productName'],
      quantity: map['quantity'],
      totalPrice: map['totalPrice'],
    );
  }
}

class order {
  final List<OrderItem> items;
  final String paymentMethod;
  final String address;
  final double subtotal;
  final double deliveryFee;
  final double totalAmount;
  final DateTime date;

  order({
    required this.items,
    required this.paymentMethod,
    required this.address,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalAmount,
    required this.date,
  });

  // Convert from Firestore Document
  factory order.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return order(
      items: (data['items'] as List)
          .map((item) => OrderItem.fromMap(item))
          .toList(),
      paymentMethod: data['paymentMethod'],
      address: data['address'],
      subtotal: data['subtotal'],
      deliveryFee: data['deliveryFee'],
      totalAmount: data['totalAmount'],
      date: DateTime.parse(data['date']),
    );
  }
}
