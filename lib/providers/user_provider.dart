import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  bool _isLoggedIn = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  UserProvider() {
    loadUser();
  }

  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      _user = UserModel.fromJson(json.decode(userData));
      _isLoggedIn = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveUser() async {
    if (_user == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(_user!.toJson()));
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    // This is a mock implementation
    // In a real app, you would make an API call to authenticate the user
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock user data
    _user = UserModel(
      id: '1',
      name: 'User',
      email: email,
      coins: 100,
      achievements: [],
    );

    _isLoggedIn = true;
    _isLoading = false;
    
    // Save to SharedPreferences
    await saveUser();
  }

  Future<void> googleLogin() async {
    // This is a mock implementation
    // In a real app, you would integrate with Google Sign-In
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock user data
    _user = UserModel(
      id: '2',
      name: 'Google User',
      email: 'google@example.com',
      coins: 150,
      achievements: [],
    );

    _isLoggedIn = true;
    _isLoading = false;
    
    // Save to SharedPreferences
    await saveUser();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');

    _user = null;
    _isLoggedIn = false;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateName(String name) async {
    if (_user == null) return;

    _user = _user!.copyWith(name: name);
    await saveUser();
  }

  Future<void> addCoins(int amount) async {
    if (_user == null) return;

    _user = _user!.copyWith(coins: _user!.coins + amount);
    await saveUser();
  }

  Future<void> unlockAchievement(String achievement) async {
    if (_user == null) return;
    
    if (!_user!.achievements.contains(achievement)) {
      final updatedAchievements = List<String>.from(_user!.achievements)..add(achievement);
      _user = _user!.copyWith(achievements: updatedAchievements);
      await saveUser();
    }
  }
} 