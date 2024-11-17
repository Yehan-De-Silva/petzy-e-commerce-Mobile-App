import 'package:flutter/material.dart';
import 'package:petzy/providers/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:petzy/utils/constants.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    // Fetch orders when the page loads
    Future.delayed(Duration.zero, () => orderProvider.fetchOrders());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor1,
        appBar: AppBar(
          title: const Text(
            "Orders",
            style: AppTextStyles.headline2,
          ),
          backgroundColor: AppColors.backgroundColor1,
        ),
        body: Consumer<OrderProvider>(
          builder: (context, orderProvider, child) {
            final orders = orderProvider.orders;

            if (orders.isEmpty) {
              return const Center(
                child: Text('No orders found'),
              );
            }

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Date: ${order.date}",
                            style: AppTextStyles.buttonText2,
                          ),
                          const SizedBox(height: 15),
                          
                          // Address Row
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: AppColors.primaryColor),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(order.address,
                                  style: AppTextStyles.bodyText2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          // Cart Items 
                         Column(
                            children: order.items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        item.productName,
                                        style: AppTextStyles.blogDescription,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "x${item.quantity}",
                                        style: AppTextStyles.blogDescription,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Rs. ${item.totalPrice.toStringAsFixed(2)}",
                                        style: AppTextStyles.blogDescription,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            ),
                          const Divider(),
                          SizedBox(height: 15,),
                          // Payment Method
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Payment Method:",
                              style: AppTextStyles.blogDescription,),
                              Text(order.paymentMethod,
                              style: AppTextStyles.blogDescription,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          
                          // Subtotal, Delivery Fee, and Total
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Subtotal:",
                              style: AppTextStyles.blogDescription,
                              ),
                              Text("Rs. ${order.subtotal.toStringAsFixed(2)}",
                              style: AppTextStyles.blogDescription,
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Delivery Fee:",
                              style: AppTextStyles.blogDescription,
                              ),
                              Text("Rs. ${order.deliveryFee.toStringAsFixed(2)}",
                              style: AppTextStyles.blogDescription,
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total:",
                                style: AppTextStyles.blogTitle,
                              ),
                              Text(
                                "Rs. ${order.totalAmount.toStringAsFixed(2)}",
                                style: AppTextStyles.blogTitle,
                              )
                            ]  
                          )
                        ]   
                      )
                    )
                  )      
                );
              },
            );
          },
        ),
      ),
    );
  }
}
