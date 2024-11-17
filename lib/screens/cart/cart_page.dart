import 'package:flutter/material.dart';
import 'package:petzy/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:petzy/providers/cart_provider.dart';
import 'package:petzy/widgets/cart_item_card.dart';
import 'package:petzy/screens/cart/checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor2,
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            children: [
              // Cart items list
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    return CartItemCard(cartItem: cartProvider.items[index]);
                  },
                ),
              ),
              
              // Total Price Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: AppTextStyles.headline2,
                    ),
                    Text(
                      'Rs. ${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor
                      ),
                    ),
                  ],
                ),
              ),

              // Checkout Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                            cartItems: cartProvider.items,
                            totalAmount: cartProvider.totalAmount,
                             ),
                          ),
                        );
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                ),

                    ),
                    child: const Text('Checkout',
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
            ],
          );
        },
      ),
    );
  }
}
