// ignore_for_file: file_names
import 'package:app/components/addNewItemButton.dart';
import 'package:app/components/item.dart';
import 'package:app/components/saveBillButton.dart';
import 'package:app/services/bill.dart';
import 'package:app/services/bill_sheets_api.dart';
import 'package:app/services/data.dart';
import 'package:app/services/data_sheets_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddNewBillPage extends StatefulWidget {
  int type;
  AddNewBillPage({super.key, required this.type});

  @override
  State<AddNewBillPage> createState() => _AddNewBillPageState();
}

class _AddNewBillPageState extends State<AddNewBillPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController billNoController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();

  int? scanResult;

  List<Data> datas = [];
  List<String> itemsToBeStoredInDB = [];
  List<String> quantitiesToBeStoredInDB = [];

  Function()? onTap() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3 * 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SaveBillButton(
                  onPressed: () async {
                    String scanResult;
                    try {
                      scanResult = await FlutterBarcodeScanner.scanBarcode(
                        "#ff6666",
                        "Cancel",
                        true,
                        ScanMode.BARCODE,
                      );
                    } on PlatformException {
                      scanResult = '-1';
                    }
                    if (!mounted) return;

                    if (scanResult != '-1') {
                      setState(() {
                        this.scanResult = int.parse(scanResult);
                        final result = datas.where((item) {
                          final itemId = item.itemCode;
                          final queryInt = scanResult;

                          return itemId == queryInt;
                        }).toList();

                        final item = result[0];

                        sNo += 1;
                        total = total + int.parse(item.rate);
                        widgetItems.add(
                          Item(
                            sNo: sNo,
                            name: item.itemName,
                            qty: 1,
                            rate: int.parse(item.rate),
                          ),
                        );
                        itemsToBeStoredInDB.add(item.itemName);
                        quantitiesToBeStoredInDB.add('1');
                        Navigator.pop(context);
                      });
                    }
                  },
                  text: 'Scan Barcode',
                ),
                const Text('or'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                  child: TypeAheadField<Data>(
                    suggestionsCallback: (search) {
                      final listOfSuggestions = datas.where((item) {
                        final itemNameLower = item.itemName.toLowerCase();
                        final queryLower = search.toLowerCase();

                        final splittedQueryLower = queryLower.split(' ');
                        bool itemIsSearched = false;
                        int a = 0;
                        for (int queryIndex = 0;
                            queryIndex < splittedQueryLower.length;
                            queryIndex++) {
                          itemIsSearched = false;
                          itemIsSearched = itemNameLower
                              .contains(splittedQueryLower[queryIndex]);
                          if (itemIsSearched) {
                            a = a + 1;
                          }
                        }
                        if (a == splittedQueryLower.length) {
                          itemIsSearched = true;
                        } else {
                          itemIsSearched = false;
                        }
                        return itemIsSearched;
                      }).toList();

                      return listOfSuggestions;
                    },
                    hideOnUnfocus: false,
                    hideWithKeyboard: false,
                    builder: (context, controller, focusNode) {
                      return TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF7C76BB),
                            ),
                          ),
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
                        controller: itemNameController,
                        focusNode: focusNode,
                        autofocus: true,
                      );
                    },
                    itemBuilder: (context, data) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.itemName,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    },
                    onSelected: (item) {
                      setState(() {
                        sNo += 1;
                        total = total + int.parse(item.rate);
                        widgetItems.add(
                          Item(
                            sNo: sNo,
                            name: item.itemName,
                            qty: 1,
                            rate: int.parse(item.rate),
                          ),
                        );
                        itemsToBeStoredInDB.add(item.itemName);
                        quantitiesToBeStoredInDB.add('1');
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    getAllData();
  }

  Future getAllData() async {
    final data = await DataSheetsApi.getAll();

    setState(() {
      datas = data;
    });
  }

  TextEditingController itemNameController = TextEditingController();
  // List<Data> items = [];
  List<Widget> widgetItems = [];
  int sNo = 0;
  int total = 0;

  @override
  Widget build(BuildContext context) {
    // widgetItems.add(AddNewItemButton(onTap: onTap));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7C76BB),
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
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 2) - 30,
                        child: TextField(
                          controller: dateController,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            prefixIcon: Icon(
                              Icons.calendar_today,
                            ),
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
                          readOnly: true,
                          onTap: () {
                            _selectedDate();
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 2) - 30,
                        child: TextField(
                          controller: timeController,
                          decoration: const InputDecoration(
                            labelText: 'Time',
                            prefixIcon: Icon(
                              Icons.access_time,
                            ),
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
                          readOnly: true,
                          onTap: () async {
                            final TimeOfDay? timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                              initialEntryMode: TimePickerEntryMode.dial,
                            );
                            if (timeOfDay != null) {
                              setState(() {
                                selectedTime = timeOfDay;
                                timeController.text =
                                    '${selectedTime.hour}:${selectedTime.minute}';
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: billNoController,
                    decoration: const InputDecoration(
                      labelText: 'Bill No.',
                      prefixIcon: Icon(
                        Icons.inventory_sharp,
                      ),
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
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3 * 1.22,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: widgetItems,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                AddNewItemButton(onTap: onTap),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      child: Text(
                        'Total Amount: ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      child: Text(
                        'Rs. $total',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SaveBillButton(
                  text: 'Save Bill',
                  onPressed: () async {
                    final data = Bill(
                      type: (widget.type == 1) ? 'Sale' : 'Purchase',
                      date: "'${dateController.text}",
                      time: "'${timeController.text}",
                      billNo: billNoController.text,
                      amount: total.toString(),
                      itemCount: sNo.toString(),
                      items: itemsToBeStoredInDB.toString(),
                      quantities: quantitiesToBeStoredInDB.toString(),
                      // items: itemsToBeStoredInDB,
                      // quantities: quantitiesToBeStoredInDB,
                    );
                    // print(itemsToBeStoredInDB);
                    // print(quantitiesToBeStoredInDB);
                    await BillSheetsApi.insert([data.toJson()]);
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectedDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
