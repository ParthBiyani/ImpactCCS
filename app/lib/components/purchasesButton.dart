// ignore_for_file: file_names
import 'package:app/components/billCard.dart';
import 'package:app/pages/purchasesPage.dart';
import 'package:app/services/bill.dart';
import 'package:flutter/material.dart';

class PurchasesButton extends StatefulWidget {
  List<Bill> bills;
  PurchasesButton({super.key, required this.bills});

  @override
  State<PurchasesButton> createState() => _PurchasesButtonState();
}

class _PurchasesButtonState extends State<PurchasesButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PurchasesBillPage(bills: widget.bills)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(7.5, 0, 15, 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red.shade300,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          width: (MediaQuery.of(context).size.width / 2) - 22.5,
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Text(
                'Purchases',
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
