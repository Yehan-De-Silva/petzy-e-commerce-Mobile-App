import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:petzy/utils/constants.dart';
import 'package:petzy/services/auth.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.backgroundColor1,
            appBar: AppBar(
              title: const Text(
                "Settings",
                style: AppTextStyles.headline2,
              ),
              backgroundColor: AppColors.backgroundColor1,
            ),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      //change email
                                      const Text(
                                        'Change Name',
                                        style: AppTextStyles.bodyText1,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // Name field
                                      TextFormField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a valid email';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 20,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: _changeName,
                                        child: Text(
                                          'Change',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),

                                      //change address
                                      const Text(
                                        'Change Address',
                                        style: AppTextStyles.bodyText1,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // Name field
                                      TextFormField(
                                        controller: _addressController,
                                        decoration: InputDecoration(
                                          labelText: 'Address',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          labelStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 20,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: _changeAddress,
                                        child: Text(
                                          'Change',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]),
                              ))
                        ])))));
  }

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // Change Address method
  void _changeAddress() async {
    String newAddress = _addressController.text.trim();

    if (newAddress.isNotEmpty) {
      try {
        await _authServices.updateUserAddress(newAddress);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Address updated successfully"),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to update address"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Change Name method
  void _changeName() async {
    String newName = _nameController.text.trim();

    if (newName.isNotEmpty) {
      try {
        await _authServices.updateUserName(newName);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Name updated successfully"),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        log("Failed to update Name: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to update Name"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
