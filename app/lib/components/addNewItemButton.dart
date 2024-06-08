// ignore_for_file: file_names
import 'package:app/components/saveBillButton.dart';
import 'package:app/services/data.dart';
import 'package:app/services/data_sheets_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// ignore: must_be_immutable
class AddNewItemButton extends StatefulWidget {
  Function()? onTap;
  AddNewItemButton({super.key, required this.onTap});

  @override
  State<AddNewItemButton> createState() => _AddNewItemButtonState();
}

class _AddNewItemButtonState extends State<AddNewItemButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF7C76BB),
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: Color(0xFF7C76BB),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Add new item",
                  style: TextStyle(
                      color: Color(0xFF7C76BB),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
