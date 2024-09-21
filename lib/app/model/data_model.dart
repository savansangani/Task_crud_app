class Data {
  String itemName;
  String description;

  Data({
    required this.itemName,
    required this.description,
  });

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      itemName: map['item_name'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item_name': itemName,
      'description': description,
    };
  }
}
