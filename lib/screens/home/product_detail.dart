import 'package:flutter/material.dart';
import 'package:petzy/models/product.dart';
import 'package:petzy/providers/cart_provider.dart';
import 'package:petzy/utils/constants.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _quantity = 1;

  // Method to calculate the total price based on quantity
  double get totalPrice => _quantity * widget.product.price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor2,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor2,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.product.image,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover, 
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  widget.product.name,
                  style: AppTextStyles.headline2,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30,),
                  Text(
                'Rs. ${widget.product.price}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(width: 30,),
                  const Text(
                    'Quantity:',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor
                      
                      ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline,
                                    size: 25,
                                    color: AppColors.textColor,
                    ),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() {
                          _quantity--;
                        });
                      }
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                       size: 25,
                       color: AppColors.textColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(
                widget.product.description,
                style: const TextStyle(fontSize: 18, color: AppColors.textColor2),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: SizedBox(
          width: double.infinity,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .addToCart(widget.product, _quantity);

                // Show confirmation massage
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.product.name} added to cart.'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                'Add to Cart . Rs . ${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
