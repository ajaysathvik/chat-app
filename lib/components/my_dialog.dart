import 'package:flutter/material.dart';

class MyDialogBox extends StatelessWidget {
  final String error;
  const MyDialogBox({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(error),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
