// ignore_for_file: file_names
import 'package:flutter/material.dart';

class LetsTalkButton extends StatefulWidget {
  const LetsTalkButton({super.key});

  @override
  State<LetsTalkButton> createState() => _LetsTalkButtonState();
}

class _LetsTalkButtonState extends State<LetsTalkButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF7C76BB),
            width: 4,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Let's Talk",
                style: TextStyle(
                    color: Color(0xFF7C76BB),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.arrow_forward,
                color: Color(0xFF7C76BB),
              )
            ],
          ),
        ),
      ),
    );
  }
}
