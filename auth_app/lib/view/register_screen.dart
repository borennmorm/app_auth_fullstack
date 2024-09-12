import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'components/my_button.dart';
import 'components/my_textfield.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Create a new account',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: nameController,
                    label: 'Name',
                    hint: 'Enter your name',
                    keyboardType: TextInputType.name,
                    isPassword: false,
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'Enter email',
                    keyboardType: TextInputType.emailAddress,
                    isPassword: false,
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            color: Colors.black,
                            onPressed: () {
                              authController.register(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                              );
                            },
                            text: 'Register',
                          );
                  }),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('Already have an account? '),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => LoginScreen());
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
