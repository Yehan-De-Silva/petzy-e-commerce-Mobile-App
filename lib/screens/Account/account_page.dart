import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petzy/screens/Account/orders_page.dart';
import 'package:petzy/screens/Account/settings.dart';
import 'package:petzy/services/auth.dart';
import 'package:petzy/utils/constants.dart';

class Account extends StatelessWidget {
  Account({super.key});
 
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _firebaseAuth.currentUser;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor2,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 350,
          height: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person, size: 40, color: AppColors.primaryColor),
              SizedBox(height: 10),
              Text(
                '${user?.email}',
                style: AppTextStyles.headline2,
              ),
              SizedBox(height: 60),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrdersPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: AppColors.primaryColor,
                  size: 35,
                ),
                label: Text(
                  'Orders',
                  style: AppTextStyles.headline2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.settings,
                  color: AppColors.primaryColor,
                  size: 35,
                ),
                label: Text(
                  'Settings',
                  style: AppTextStyles.headline2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: () {
                   AuthServices().signOut(context);
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: AppColors.primaryColor,
                  size: 35,
                ),
                label: Text(
                  'Logout',
                  style: AppTextStyles.headline2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
