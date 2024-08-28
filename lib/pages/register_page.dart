import 'package:chat_app/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_dialog.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function() onTap;
  RegisterPage({super.key, required this.onTap});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _auth = AuthService();

  void register() {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      return;
    }
    try {
      _auth.signUpWithEmailAndPassword(email, password);
    } catch (e) {
      MyDialogBox(error: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //welcome message
            Text('Welcome to App.',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 3),

            Text('Login or Sign up to be part of the community.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                )),
            SizedBox(height: 25),

            Divider(
              color: const Color.fromARGB(255, 87, 87, 87),
              thickness: 1,
              indent: 50,
              endIndent: 50,
            ),
            SizedBox(height: 55),
            //email input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Email',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16)),
                ],
              ),
            ),

            SizedBox(height: 7),
            MyTextField(
              text: 'Enter your email',
              controller: emailController,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Password',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16)),
                ],
              ),
            ),

            SizedBox(height: 7),
            //password input
            MyTextField(
              text: 'Enter your password',
              controller: passwordController,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Confirm Password',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16)),
                ],
              ),
            ),
            SizedBox(height: 7),
            MyTextField(
              text: 'Confirm your password',
              controller: confirmPasswordController,
            ),

            SizedBox(height: 45),

            //login button
            MyButton(text: 'SIGN UP', onTap: register),

            // register now
            SizedBox(height: 105),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14)),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: onTap,
                  child: Text('Sign In',
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontSize: 14,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
