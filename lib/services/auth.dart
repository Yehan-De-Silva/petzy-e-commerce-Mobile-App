import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create user with email and password
  Future<User?> createUserWithEmailPassword(
      String email, String password, String name) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // After user is created, save the user's info to Firestore
      await _firestore.collection('users').doc(cred.user?.uid).set({
        'email': email,
        'name': name,
        'address': '',
      });

      log("User created and document saved in Firestore");

      return cred.user;
    } catch (e) {
      log("Authenticate error: $e");
    }
    return null;
  }

  Future<User?> loginUserWithEmailPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Authenticate error:$e");
    }
    return null;
  }

  // Check if a user is currently logged in
  Future<User?> getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.getIdToken(true); 
        return user;
      }
    } catch (e) {
      log("Error getting current user: $e");
    }
    return null;
  }

  // Update address in Firestore
  Future<void> updateUserAddress(String address) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Get the reference to the user's document in Firestore
        DocumentReference userRef =
            _firestore.collection('users').doc(user.uid);

        // Update the address field
        await userRef.update({
          'address': address,
        });

        log("Address updated successfully");
      }
    } catch (e) {
      log("Error updating address: $e");
      rethrow;
    }
  }

  // Update address in Firestore
  Future<void> updateUserName(String name) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Get the reference to the user's document in Firestore
        DocumentReference userRef =
            _firestore.collection('users').doc(user.uid);

        // Update the address field
        await userRef.update({
          'name': name,
        });

        log("name updated successfully");
      }
    } catch (e) {
      log("Error updating name: $e");
      rethrow;
    }
  }

  //get address from Firestore
  Future<String?> getUserAddress() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Fetch the user document from Firestore
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          return userDoc.data()?['address'] ?? '';
        }
      }
    } catch (e) {
      log("Error fetching user address: $e");
    }
    return null;
  }

  //get name from Firestore
  Future<String?> getUserName() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          return userDoc.data()?['name'] ?? '';
        }
      }
    } catch (e) {
      log("Error fetching user name: $e");
    }
    return null;
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      log("Sign out successful");

      // Navigate back to the login screen and remove all previous routes
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } catch (e) {
      log("Sign out error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing out. Please try again.'),
          backgroundColor: Colors.red[400],
        ),
      );
    }
  }
}
