import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class errorDialog extends StatelessWidget {
  final String message;
  const errorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      key: key,
      content: SizedBox(
        child: Column(
          children: [
            Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("حسنا"),
            ),
          ],
        ),
      ),
    );
  }
}
