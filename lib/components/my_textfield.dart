import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  const MyTextField({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.justify,
        obscureText: text == 'Enter your password' ? true : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          hintText: text,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Color.fromARGB(255, 13, 15, 20),
          filled: true,
        ),
      ),
    );
  }
}
