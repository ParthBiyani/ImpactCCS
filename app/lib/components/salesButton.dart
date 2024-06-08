// ignore_for_file: file_names

import 'package:app/components/billCard.dart';
import 'package:app/pages/salesPage.dart';
import 'package:app/services/bill.dart';
import 'package:flutter/material.dart';

class SalesButton extends StatefulWidget {
  List<Bill> bills;
  SalesButton({super.key, required this.bills});

  @override
  State<SalesButton> createState() => _SalesButtonState();
}

class _SalesButtonState extends State<SalesButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SalesBillPage(bills: widget.bills)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 7.5, 10),
        child: Container(
          width: (MediaQuery.of(context).size.width / 2) - 22.5,
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Text(
                'Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
