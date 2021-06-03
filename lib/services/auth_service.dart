import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organik/constants.dart';
import 'package:organik/models/user.dart';
import 'package:organik/services/database_service.dart';

class AuthService with ChangeNotifier {
  static const TAG = "AuthService:";

  final _auth = FirebaseAuth.instance;
  final _dbService = new DBService();

  bool _isLoading;
  bool _isLoggedIn;

  AuthService() {
    isLoading = false;
    isLoggedIn = _auth.currentUser != null;
  }

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set isLoggedIn(bool isLoggedIn) {
    this._isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  Stream<User> authChangeStream() {
    return _auth.authStateChanges();
  }

  Future<MyUser> signUpWithEmailAndPassword(
      String name, String email, String password, UserType userType) async {
    isLoading = true;
    try {
      print('$TAG creating account for $email $name ...');
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        print('$TAG created account successfully');

        //set user type depending on the registration flow
        final type = userType == UserType.CUSTOMER
            ? MyUser.USER_CUSTOMER
            : MyUser.USER_SHOP;
        //create new taksici user to push their data to the server
        final _myUser = MyUser(
            id: _auth.currentUser.uid, name: name, email: email, type: type);
        print('$TAG adding user to db');
        await _dbService.createNewUser(_myUser);

        print('$TAG creating new user profile');
        await _dbService.createNewCustomerProfile(_auth.currentUser.uid, name);

        //open new session using the credentials above
        print('$TAG opening new session with user ${_auth.currentUser.uid} ..');
        await signInWithEmailAndPassword(email, password);

        return _myUser;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message);
    } catch (e) {
      print('$TAG $e');
      return Future.error(e);
    } finally {
      isLoading = false;
      isLoggedIn = _auth.currentUser != null;
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    isLoading = true;
    try {
      print('$TAG signing in as $email ...');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        print('$TAG logged in successfully');

        // //update login state so user state triggered and update its data
        // isLoggedIn = _auth.currentUser != null;

        return _auth.currentUser;
      }
      print('$TAG login failed');
      return null;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message);
    } catch (e) {
      print('$TAG $e');
      return Future.error(e);
    } finally {
      isLoading = false;
      isLoggedIn = _auth.currentUser != null;
    }
  }

  Future<void> resetPassword(String email) {
    try {
      print("$TAG sending password reset email to $email");
      return _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("$TAG $e");
      return Future.error(e.message);
    } catch (e) {
      print("$TAG $e");
      return Future.error(e);
    }
  }

  Future<void> logout() async {
    try {
      print('$TAG logging out..');
      await _auth.signOut();

      //update login state so user state triggered and update its data
      isLoggedIn = _auth.currentUser != null;

      print('$TAG logged out successfully');
    } catch (e) {
      print('$TAG $e');
      throw Future.error(e);
    }
  }
}
