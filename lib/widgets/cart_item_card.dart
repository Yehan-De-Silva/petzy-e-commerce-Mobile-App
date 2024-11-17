import 'package:flutter/material.dart';
import 'package:petzy/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:petzy/providers/cart_provider.dart';


class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Image.network(
                  cartItem.product.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover, 
                ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: AppTextStyles.buttonText2,
                  ),
                  SizedBox(height: 10,),
                  Text('Rs. ${cartItem.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                int newQuantity = cartItem.quantity - 1;
                if (newQuantity > 0) {
                  Provider.of<CartProvider>(context, listen: false)
                      .updateQuantity(cartItem.product, newQuantity);
                }
              },
            ),
            Text(cartItem.quantity.toString(),
                style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor,
                ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .updateQuantity(cartItem.product, cartItem.quantity + 1);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete_rounded, color: Colors.red, size: 28,),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .removeFromCart(cartItem.product);
              },
            ),
          ],
        ),
      ),
    );
  }
}
