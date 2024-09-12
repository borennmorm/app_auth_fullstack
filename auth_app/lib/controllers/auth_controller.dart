import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class AuthController extends GetxController {
  var user = UserModel(id: 0, name: '', email: '', token: '').obs;
  var isLoading = false.obs;

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;

    final response = await http.post(
      Uri.parse('[ip_address]/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      user.value = UserModel.fromJson(data['user']);
      user.value.token = data['token'];
      Get.snackbar('Success', 'User registered successfully');
    } else {
      Get.snackbar('Error', 'Registration failed');
    }
    isLoading.value = false;
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    final response = await http.post(
      Uri.parse('[ip_address]/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      user.value = UserModel.fromJson(data['user']);
      user.value.token = data['token'];
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Error', 'Login failed');
    }
    isLoading.value = false;
  }

  void logout() {
    user.value = UserModel(id: 0, name: '', email: '', token: '');
    Get.offAllNamed('/login');
    Get.snackbar('Success', 'Logged out successfully');
  }
}
