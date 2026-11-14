import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product.dart';

// assets/data/products.json dosyasını okuyup ürün listesine çevirir
Future<List<Product>> loadProducts() async {
  final text = await rootBundle.loadString('assets/data/products.json');
  final List<dynamic> list = json.decode(text) as List<dynamic>;
  return list
      .map((item) => Product.fromJson(item as Map<String, dynamic>))
      .toList();
}