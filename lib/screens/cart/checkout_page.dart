import 'package:flutter/material.dart';
import 'package:petzy/models/order.dart';
import 'package:petzy/providers/cart_provider.dart';
import 'package:petzy/providers/order_provider.dart';
import 'package:petzy/screens/Account/orders_page.dart';
import 'package:petzy/services/auth.dart';
import 'package:petzy/utils/constants.dart';
import 'package:provider/provider.dart';


class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalAmount;

  const CheckoutPage({Key? key, required this.cartItems, required this.totalAmount}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPaymentMethod = 'Cash on delivery';
  final double deliveryFee = 350.00;

  String userAddress = 'Fetching address...';
  final AuthServices _authServices = AuthServices();

   @override
  void initState() {
    super.initState();
    _fetchUserAddress();
  }

// Method to fetch user address from Firestore
  Future<void> _fetchUserAddress() async {
    final address = await _authServices.getUserAddress();
    if (address != null && mounted) {
      setState(() {
        userAddress = address.isNotEmpty ? address : 'Add your address in settings';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor2,
        appBar: AppBar(
          title: const Text('Checkout',
          style: AppTextStyles.headline2,
          ),
          backgroundColor: AppColors.backgroundColor1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Address Row
              SizedBox(height: 5,),
              const Text('Address', style: AppTextStyles.buttonText2),
              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 40,),
                  Icon(Icons.location_on, color: AppColors.primaryColor),
                  SizedBox(width: 8),
                  Text(userAddress, 
                  style: AppTextStyles.bodyText1,
                  overflow: TextOverflow.clip,
                  ),
                ],
              ),
              const SizedBox(height: 20),
      
              // Cart Items Section
              const Text('Items', style: AppTextStyles.buttonText2),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartItems[index];
                    return ListTile(
                      title: Text(item.product.name,
                      style: AppTextStyles.blogDescription,
                      ),
                      subtitle: Text('Quantity: ${item.quantity}',
                      style: AppTextStyles.bodyText1,
                      ),
                      trailing: Text('Rs. ${(item.product.price * item.quantity).toStringAsFixed(2)},',
                      style: AppTextStyles.bodyText1, 
                      ),
                    );
                  },
                  
                ),
              ),
              const SizedBox(height: 20),
      
              // Payment Method Section
              const Text('Payment Method', style: AppTextStyles.buttonText2),
              Column(
                children: [
                  RadioListTile(
                    title: const Text('Cash on delivery',
                    style: AppTextStyles.blogDescription,
                    ),
                    value: 'Cash on delivery',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value as String;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Credit/Debit Card',
                    style: AppTextStyles.blogDescription,
                    ),
                    value: 'Credit/Debit Card',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value as String;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
      
              // Summary Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal', style: AppTextStyles.bodyText1),
                  Text('Rs. ${widget.totalAmount.toStringAsFixed(2)}', style: AppTextStyles.bodyText1),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delivery Fee', style: AppTextStyles.bodyText1),
                  Text('Rs. ${deliveryFee.toStringAsFixed(2)}', style: AppTextStyles.bodyText1),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: AppTextStyles.headline2),
                  Text(
                    'Rs. ${(widget.totalAmount + deliveryFee).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
      
              // Place Order Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                 onPressed: () async {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  final orderProvider = Provider.of<OrderProvider>(context, listen: false);

  // Create a new order
  final Order = order(
    items: cartProvider.toOrderItems(),
    paymentMethod: selectedPaymentMethod,
    address: userAddress,
    subtotal: cartProvider.totalAmount,
    deliveryFee: deliveryFee,
    totalAmount: cartProvider.totalAmount + deliveryFee,
    date: DateTime.now(),
  );

  // Add the order to Firestore and clear the cart
  await orderProvider.addOrder(Order);
  cartProvider.clearCart();

  // Navigate to OrdersPage
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const OrdersPage()),
  );

  // Show success message
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Order Placed Successfully!'),
      duration: Duration(seconds: 2),
    ),
  );
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
