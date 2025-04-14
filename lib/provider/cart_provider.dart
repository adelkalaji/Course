/*
import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/course.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final List<Course> _cart = [];
  List<Course> get cart => _cart;
  void toggleFavorite(Course product) {
    if (_cart.contains(product)) {
      /*
      for (Course element in _cart) {
        element.quantity++;
      }
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }
*/
      incrementQtn(int index) {
        _cart[index].quantity++;
        notifyListeners();
      }

      decrementQtn(int index) {
        if (_cart[index].quantity <= 1) {
          return;
        }
        _cart[index].quantity--;
        notifyListeners();
      }

      totalPrice() {
        double total1 = 0.0;
        for (Product element in _cart) {
          total1 += element.price * element.quantity;
        }
        return total1;
      }
/*
  static CartProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<CartProvider>(
      context,
      listen: listen,
    );
    */
    }
  }

  static of(BuildContext context) {}
}
*/
