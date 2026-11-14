import 'package:flutter/material.dart';

// 2499.0 -> "2.499 ₺" şeklinde fiyat yazısı üretir
String formatPrice(double price) {
  final digits = price.toStringAsFixed(0);
  final withDots = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
  return '$withDots ₺';
}

// Kategoriye göre simge seçer (görsel yerine kullanıyoruz)
IconData categoryIcon(String category) {
  switch (category) {
    case 'Ses':
      return Icons.headphones;
    case 'Giyilebilir':
      return Icons.watch;
    case 'Bilgisayar':
      return Icons.laptop_mac;
    case 'Telefon':
      return Icons.smartphone;
    case 'Aksesuar':
      return Icons.keyboard;
    default:
      return Icons.devices_other;
  }
}