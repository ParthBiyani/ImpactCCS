import 'dart:convert';
import 'dart:core';

class BillFields {
  static const String type = 'Type';
  static const String date = 'Date';
  static const String time = 'Time';
  static const String billNo = 'BillNo';
  static const String amount = 'Amount';
  static const String itemCount = 'ItemCount';
  static const String items = 'Items';
  static const String quantities = 'Quantities';

  static List<String> getFields() =>
      [type, date, time, billNo, amount, itemCount, items, quantities];
}

class Bill {
  final String type;
  final String date;
  final String time;
  final String billNo;
  final String amount;
  final String itemCount;
  final String items;
  final String quantities;

  const Bill({
    required this.type,
    required this.date,
    required this.time,
    required this.billNo,
    required this.amount,
    required this.itemCount,
    required this.items,
    required this.quantities,
  });

  static Bill fromJson(Map<dynamic, dynamic> json) => Bill(
        type: json[BillFields.type],
        date: json[BillFields.date],
        time: json[BillFields.time],
        billNo: json[BillFields.billNo],
        amount: json[BillFields.amount],
        itemCount: json[BillFields.itemCount],
        items: (json[BillFields.items]),
        quantities: (json[BillFields.quantities]),
      );

  Map<String, dynamic> toJson() => {
        BillFields.type: type,
        BillFields.date: date,
        BillFields.time: time,
        BillFields.billNo: billNo,
        BillFields.amount: amount,
        BillFields.itemCount: itemCount,
        BillFields.items: items,
        BillFields.quantities: quantities,
      };
}
