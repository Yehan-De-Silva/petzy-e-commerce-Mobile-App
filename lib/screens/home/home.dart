import 'package:flutter/material.dart';
import 'package:petzy/screens/home/product_detail.dart';
import 'package:petzy/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:petzy/screens/Account/account_page.dart';
import 'package:petzy/screens/blog/blog_page.dart';
import 'package:petzy/screens/cart/cart_page.dart';
import 'package:petzy/providers/Bottom_Nav_Provider.dart';
import 'package:petzy/providers/product_provider.dart';
import 'package:petzy/widgets/product_card.dart';
import 'package:petzy/utils/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<String> getUserName() async {
    final AuthServices authServices = AuthServices();
    return await authServices.getUserName() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor2,

        // Bottom Navigation Bar 
        bottomNavigationBar: Consumer<BottomNavProvider>(
          builder: (context, bottomNavProvider, child) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: const Color(0xffC0C0C0),
              currentIndex: bottomNavProvider.selectedIndex,
              onTap: (index) {
                bottomNavProvider.setSelectedIndex(index);
              },
              iconSize: 30,
              selectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_rounded),
                  label: 'Blogs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Account',
                ),
              ],
            );
          },
        ),

        // Body 
        body: Consumer<BottomNavProvider>(
          builder: (context, bottomNavProvider, child) {
            // Dynamically changing AppBar title and content based on the selected screen
            Widget appBarTitle;
            switch (bottomNavProvider.selectedIndex) {
              case 1:
                appBarTitle = const Text(
                  'Blog',
                  style: AppTextStyles.headline2,
                );
                break;
              case 2:
                appBarTitle = const Text(
                  'Cart',
                  style: AppTextStyles.headline2,
                );
                break;
              case 3:
                appBarTitle = const Text(
                  'Account',
                  style: AppTextStyles.headline2,
                );
                break;
              default:
                appBarTitle = const Text(
                  'Shop',
                  style: AppTextStyles.headline2,
                );
            }

            return Column(children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AppBar(
                  backgroundColor: AppColors.backgroundColor2,
                  elevation: 0,
                  title: appBarTitle,
                  actions: bottomNavProvider.selectedIndex == 0
                      ? [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Center(
                              child: FutureBuilder<String>(
                                future: getUserName(),
                                builder: (context, snapshot) {
                                  return Text(
                                     'Hi, ${snapshot.data ?? ''}', // Directly show user's name
                                  style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor,
                                    )
                                  );
                                },
                              ),
                            ),
                          ),
                        ]
                      : null,
                ),
              ),

              // Body Content
              Expanded(
                child: Builder(
                  builder: (context) {
                    switch (bottomNavProvider.selectedIndex) {
                      case 1:
                        return const BlogPage();
                      case 2:
                        return const CartPage();
                      case 3:
                        return Account();
                      default:
                        // Home Page 
                        return Consumer<ProductProvider>(
                          builder: (context, productProvider, child) {
                            return Column(
                              children: [
                                // Search Bar
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.search),
                                      hintText: 'Search',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                                // Filter Buttons
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            productProvider.clearFilter(),
                                        child: const Text(
                                          'All',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => productProvider
                                            .filterByType('PuppyFood'),
                                        child: const Text(
                                          'Puppy Food',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => productProvider
                                            .filterByType('AdultFood'),
                                        child: const Text(
                                          'Adult Food',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => productProvider
                                            .filterByType('Supplements'),
                                        child: const Text(
                                          'Supplements',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Product Grid
                                Expanded(
                                  child: FutureBuilder(
                                    future: productProvider.fetchProducts(),
                                    builder: (context, snapshot) {
                                      if (productProvider.products.isEmpty) {
                                        return const Center(
                                            child: Text('No products found.'));
                                      }
                                      return GridView.builder(
                                        padding: const EdgeInsets.all(16),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 3 / 4,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                        itemCount:
                                            productProvider.products.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetail(
                                                            product:
                                                                productProvider
                                                                        .products[
                                                                    index],
                                                          )));
                                            },
                                            child: ProductCard(
                                                product: productProvider
                                                    .products[index]),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                    }
                  },
                ),
              )
            ]);
          },
        ),
      ),
    );
  }
}
