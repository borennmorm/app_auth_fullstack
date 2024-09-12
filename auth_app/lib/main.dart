import 'package:auth_app/view/home_screen.dart';
import 'package:auth_app/view/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'middlewares/auth_middleware.dart';
import 'view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(
          name: '/register',
          page: () => const RegisterScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
    );
  }
}
