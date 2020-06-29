import 'package:flutter/foundation.dart';

class CryptoModel{
  final image;
  final name;
  // ignore: non_constant_identifier_names
  final price_change_24h;

  // ignore: non_constant_identifier_names
  final current_price;
  // ignore: non_constant_identifier_names
  CryptoModel({this.image, this.name, this.price_change_24h, this.current_price});

  factory CryptoModel.fromJson(final json){

    return CryptoModel(
      name: json['name'],
      price_change_24h: json['price_change_24h'],
      current_price: json['current_price'],
      image: json['image'],
    );
  }
}
