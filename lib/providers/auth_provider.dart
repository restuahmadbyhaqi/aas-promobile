import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final AuthService _authService = AuthService();

  User? get user => _user;

  Future<void> register(String email, String name, String password) async {
    try {
      await _authService.register(email, name, password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      User loggedInUser = await _authService.login(email, password);
      _user = loggedInUser;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<User> fetchUserById(String id) async {
    try {
      User fetchedUser = await _authService.getUserById(id);
      return fetchedUser;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProfile(
      String id, String name, String email, String? image) async {
    try {
      await _authService.updateUser(id, name, email, image);
      _user = User(
        userId: id,
        name: name,
        email: email,
        image: image,
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
