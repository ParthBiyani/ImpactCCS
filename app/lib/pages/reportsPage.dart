// ignore_for_file: file_names

import 'package:app/components/billCard.dart';
import 'package:app/components/purchasesButton.dart';
import 'package:app/components/salesButton.dart';
import 'package:app/components/saveBillButton.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/services/bill.dart';
import 'package:app/services/bill_sheets_api.dart';
import 'package:app/services/data.dart';
import 'package:app/services/data_sheets_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController itemCodeController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  List<Bill> bills = [];

  @override
  void initState() {
    super.initState();

    getAllData();
  }

  Future getAllData() async {
    final allBills = await BillSheetsApi.getAll();

    setState(() {
      bills = allBills.cast<Bill>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: (MediaQuery.of(context).size.width / 4) * 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CircleAvatar(
                    radius: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image(
                        image: NetworkImage(user.photoURL!),
                      ),
                    ),
                  ),
                ),
                Text(
                  user.displayName!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            // child: SizedBox(
                            //   height: MediaQuery.of(context).size.height / 2,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 7.5),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: itemCodeController,
                                    decoration: const InputDecoration(
                                      labelText: 'Item Code',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF7C76BB),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF7C76BB),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 7.5),
                                  child: TextField(
                                    controller: itemNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Item Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF7C76BB),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF7C76BB),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 7.5),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: quantityController,
                                    decoration: const InputDecoration(
                                      labelText: 'Quantity',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF7C76BB),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF7C76BB),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 7.5),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: rateController,
                                    decoration: const InputDecoration(
                                      labelText: 'Rate',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF7C76BB),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF7C76BB),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SaveBillButton(
                                  text: 'Save Data',
                                  onPressed: () async {
                                    final data = Data(
                                      itemCode: itemCodeController.text,
                                      itemName: itemNameController.text,
                                      quantity: quantityController.text,
                                      rate: rateController.text,
                                    );
                                    await DataSheetsApi.insert([data.toJson()]);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            // ),
                          );
                        });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Add Items to database",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => AuthService().signOut(),
              child: const Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7C76BB),
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 32,
              ),
            ),
          );
        }),
        title: Center(
          child: Image.asset(
            'images/logo.png',
            height: 42,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Monthly Sales Data',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: BarChart(
                        BarChartData(
                          groupsSpace: 0,
                          barGroups: [
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 10,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 12,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 3,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 7,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 4,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 8,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 5,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 11,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 6,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 10,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 7,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 9,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 8,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 13,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 9,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 10,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 10,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 11,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 11,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 8,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 12,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: 12,
                                  color: const Color(0xFF7C76BB),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // child: Stack(
                  //   children: [
                  //     Placeholder(
                  //       fallbackWidth: MediaQuery.of(context).size.width - 30,
                  //       fallbackHeight: MediaQuery.of(context).size.height / 3,
                  //     ),
                  //     const Center(
                  //       child: Text('Monthly Sales report bar graph'),
                  //     ),
                  //   ],
                  // ),
                ),
              ],
            ),
            SaveBillButton(
                onPressed: () {
                  setState(() {
                    getAllData();
                  });
                },
                text: 'Refresh DB'),
            Row(
              children: [
                SalesButton(bills: bills),
                PurchasesButton(bills: bills),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
