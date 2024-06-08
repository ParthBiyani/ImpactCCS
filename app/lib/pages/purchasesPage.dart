// ignore_for_file: file_names
import 'package:app/components/billCard.dart';
import 'package:app/pages/addNewBillPage.dart';
import 'package:app/services/bill.dart';
import 'package:app/services/bill_sheets_api.dart';
import 'package:flutter/material.dart';

class PurchasesBillPage extends StatefulWidget {
  List<Bill> bills;
  PurchasesBillPage({super.key, required this.bills});

  @override
  State<PurchasesBillPage> createState() => _PurchasesBillPageState();
}

class _PurchasesBillPageState extends State<PurchasesBillPage> {
  @override
  void initState() {
    super.initState();

    getAllData();

    while (index < widget.bills.length) {
      if (widget.bills[index].type == 'Purchase') {
        setState(() {
          billCardsList.add(
            BillCard(
              amount: widget.bills[index].amount,
              billNo: widget.bills[index].billNo,
              date: widget.bills[index].date,
              time: widget.bills[index].time,
            ),
          );
        });
      }
      index += 1;
    }
  }

  Future getAllData() async {
    final allBills = await BillSheetsApi.getAll();

    // setState(() {
    //   widget.bills = allBills.cast<Bill>();
    // });
    setState(() {
      final billsNew = allBills.cast<Bill>();
      if (billsNew.isNotEmpty) {
        widget.bills = billsNew;
      }
    });
  }

  List<Widget> billCardsList = [];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7C76BB),
        leading: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(
            Icons.menu,
            color: Colors.white,
            size: 32,
          ),
        ),
        title: Center(
          child: Image.asset(
            'images/logo.png',
            height: 42,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: billCardsList,
            // children: [
            //   BillCard(
            //       date: '06/06/2024',
            //       time: '9:45 pm',
            //       billNo: 'B-407',
            //       amount: 'Rs. 450'),
            //   BillCard(
            //       date: '06/06/2024',
            //       time: '9:45 pm',
            //       billNo: 'B-406',
            //       amount: 'Rs. 450'),
            //   BillCard(
            //       date: '06/06/2024',
            //       time: '9:45 pm',
            //       billNo: 'B-405',
            //       amount: 'Rs. 450'),
            //   BillCard(
            //       date: '06/06/2024',
            //       time: '9:45 pm',
            //       billNo: 'B-404',
            //       amount: 'Rs. 450'),
            //   BillCard(
            //       date: '06/06/2024',
            //       time: '9:45 pm',
            //       billNo: 'B-403',
            //       amount: 'Rs. 450'),
            //   BillCard(
            //       date: '06/06/2024',
            //       time: '9:45 pm',
            //       billNo: 'B-402',
            //       amount: 'Rs. 450'),
            //   BillCard(
            //       date: '06/06/2024',
            //       time: '9:45 pm',
            //       billNo: 'B-401',
            //       amount: 'Rs. 450'),
            // ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewBillPage(type: 2),
            ),
          );
        },
        backgroundColor: const Color(0xFF7C76BB),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Add new bill',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
