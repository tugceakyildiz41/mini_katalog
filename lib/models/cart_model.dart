import 'package:flutter/foundation.dart';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems =>
      _items.fold<int>(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold<double>(
        0,
        (sum, item) => sum + item.product.price * item.quantity,
      );

  void add(Product product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index == -1) {
      _items.add(CartItem(product: product));
    } else {
      _items[index].quantity++;
    }
    notifyListeners();
  }

  void decrease(Product product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index == -1) return;
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

// Uygulamanın tamamında kullanılan tek sepet
final CartModel cart = CartModel();