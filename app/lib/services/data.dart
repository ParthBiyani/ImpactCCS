class DataFields {
  static const String itemCode = 'ItemCode';
  static const String itemName = 'ItemName';
  static const String quantity = 'Quantity';
  static const String rate = 'Rate';

  static List<String> getFields() => [itemCode, itemName, quantity, rate];
}

class Data {
  final String itemCode;
  final String itemName;
  final String quantity;
  final String rate;

  const Data({
    required this.itemCode,
    required this.itemName,
    required this.quantity,
    required this.rate,
  });

  static Data fromJson(Map<String, dynamic> json) => Data(
        itemCode: json[DataFields.itemCode],
        itemName: json[DataFields.itemName],
        quantity: json[DataFields.quantity],
        rate: json[DataFields.rate],
      );

  Map<String, dynamic> toJson() => {
        DataFields.itemCode: itemCode,
        DataFields.itemName: itemName,
        DataFields.quantity: quantity,
        DataFields.rate: rate,
      };
}
