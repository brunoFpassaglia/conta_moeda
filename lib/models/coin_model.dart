import 'dart:convert';

class CoinModel {
  final DateTime dateTime;
  final int quantity;
  final double value;
  final String name;
  final String specie;

  CoinModel({
    required this.dateTime,
    required this.quantity,
    required this.value,
    required this.name,
    required this.specie,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.millisecondsSinceEpoch,
      'quantity': quantity,
      'value': value,
      'name': name,
      'specie': specie,
    };
  }

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    return CoinModel(
      dateTime: DateTime.parse(map['Data']),
      quantity: map['Quantidade'],
      value: map['Valor'],
      name: map['Denominacao'],
      specie: map['Especie'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinModel.fromJson(String source) =>
      CoinModel.fromMap(json.decode(source));
}
