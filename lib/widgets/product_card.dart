import 'package:flutter/material.dart';
import 'package:petzy/utils/constants.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 500, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover, 
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Text(
                  'Rs ${product.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}