import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petzy/providers/Bottom_Nav_Provider.dart';
import 'package:petzy/providers/blog_provider.dart';
import 'package:petzy/providers/cart_provider.dart';
import 'package:petzy/providers/order_provider.dart';
import 'package:petzy/providers/product_provider.dart';
import 'package:petzy/screens/Account/account_page.dart';
import 'package:petzy/screens/auth/Register_page.dart';
import 'package:petzy/screens/auth/login_page.dart';
import 'package:petzy/screens/blog/blog_page.dart';
import 'package:petzy/screens/cart/cart_page.dart';
import 'package:petzy/screens/home/home.dart';
import 'package:petzy/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => BlogProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/',
        home: FutureBuilder<User?>(
          future: AuthServices().getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return const Home();
            } else {
              return const Login();
            }
          },
        ),
        routes: {
          '/register': (context) => const Register(),
          '/login': (context) => const Login(),
          '/home': (context) => const Home(),
          '/account': (context) => Account(),
          '/blog': (context) => const BlogPage(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}
