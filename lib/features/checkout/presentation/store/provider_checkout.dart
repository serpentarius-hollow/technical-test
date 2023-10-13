import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../auth/domain/model_user.dart';
import '../../../product-list/domain/model_product.dart';
import '../../domain/model_checkout.dart';
import '../../infrastructure/checkout_repository.dart';

class ProviderCheckout extends ChangeNotifier {
  Decimal total = Decimal.zero;
  List<ProviderCheckoutItem> checkoutItems = [];

  final CheckoutRepository _repository;
  final User? _user;

  Checkout get _checkout {
    return Checkout(
      total: total,
      items: checkoutItems
          .map(
            (item) => CheckoutItem(
              product: item.product,
              quantity: item.quantity,
              subtotal: item.subtotal,
            ),
          )
          .toList(),
    );
  }

  int get checkoutCounter {
    return checkoutItems.length;
  }

  ProviderCheckout(
    this._repository, {
    User? user,
  }) : _user = user;

  void addToCart(Product product) {
    final item = checkoutItems
        .singleWhereOrNull((item) => item.product.code == product.code);

    if (item != null) {
      item.addQuantity();
    } else {
      checkoutItems.add(ProviderCheckoutItem(product: product));
    }

    total = checkoutItems.fold(Decimal.zero, (prev, item) {
      return prev + item.subtotal;
    });
    notifyListeners();
  }

  void removeFromCart(Product product) {
    final item = checkoutItems
        .singleWhereOrNull((item) => item.product.code == product.code);

    if (item != null) {
      item.removeQuantity();
      if (item.quantity == 0) {
        checkoutItems.removeWhere((item) => item.product.code == product.code);
      }
    }

    total = checkoutItems.fold(Decimal.zero, (prev, item) {
      return prev + item.subtotal;
    });
    notifyListeners();
  }

  void clearCart() {
    checkoutItems.clear();
    total = Decimal.zero;
    notifyListeners();
  }

  void confirmTransaction() {
    _repository.addTransaction(_user!.username, _checkout);
    clearCart();
  }
}

class ProviderCheckoutItem extends ChangeNotifier {
  int quantity = 1;
  Decimal subtotal = Decimal.zero;

  final Product product;

  ProviderCheckoutItem({required this.product}) {
    subtotal = Decimal.fromInt(quantity) * product.finalPrice;
  }

  void addQuantity({int quantity = 1}) {
    this.quantity += quantity;
    subtotal = Decimal.fromInt(this.quantity) * product.finalPrice;
    notifyListeners();
  }

  void removeQuantity({int quantity = 1}) {
    if (quantity > 0) {
      this.quantity -= quantity;
      subtotal = Decimal.fromInt(this.quantity) * product.finalPrice;
      notifyListeners();
    }
  }
}
