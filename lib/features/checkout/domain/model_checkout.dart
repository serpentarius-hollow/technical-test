import 'package:decimal/decimal.dart';

import '../../product-list/domain/model_product.dart';

class Checkout {
  final Decimal total;
  final List<CheckoutItem> items;

  Checkout({
    required this.total,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'total': double.parse(total.toString()),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CheckoutItem {
  final Product product;
  final int quantity;
  final Decimal subtotal;

  CheckoutItem({
    required this.product,
    required this.quantity,
    required this.subtotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_code': product.code,
      'product_name': product.name,
      'quantity': quantity,
      'subtotal': double.parse(subtotal.toString()),
    };
  }
}
