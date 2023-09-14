import 'package:book_store_app/Models/cart_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/data.dart';


class CartModel extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  late SharedPreferences _prefs;
  var books;

  CartModel() {
    _loadCartFromPrefs();
  }

  List<CartItem> get cartItems => _cartItems;

  Future<void> _loadCartFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final cartData = _prefs.getStringList('cart');
    if (cartData != null) {
      for (var itemData in cartData) {
        final parts = itemData.split(';');
        final bookIndex = int.parse(parts[0]);
        final quantity = int.parse(parts[1]);
        final book = books[bookIndex];
        _cartItems.add(CartItem(book, quantity));
      }
      notifyListeners();
    }
  }

  void _saveCartToPrefs() {
    final cartData = _cartItems
        .map((cartItem) => '${books.indexOf(cartItem.book)};${cartItem.quantity}')
        .toList();
    _prefs.setStringList('cart', cartData);
  }

  void addToCart(Book book) {
    for (var item in _cartItems) {
      if (item.book == book) {
        item.quantity++;
        _saveCartToPrefs();
        notifyListeners();
        return;
      }
    }
    _cartItems.add(CartItem(book, 1));
    _saveCartToPrefs();
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    _saveCartToPrefs();
    notifyListeners();
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (var item in _cartItems) {
      totalPrice += item.book.price * item.quantity;
    }
    return totalPrice;
  }
}