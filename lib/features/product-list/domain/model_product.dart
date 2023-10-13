import 'package:decimal/decimal.dart';

class Product {
  final String code;
  final String name;
  final Decimal basePrice;
  final double discount;
  final String currency;
  final String dimension;
  final String unit;

  Product({
    required this.code,
    required this.name,
    required this.basePrice,
    required this.discount,
    required this.currency,
    required this.dimension,
    required this.unit,
  });

  Decimal get finalPrice {
    if (discount > 0) {
      final discFormatted = Decimal.parse(discount.toString());
      final discountPrice = (discFormatted / Decimal.fromInt(100)).toDecimal(scaleOnInfinitePrecision: 4) * basePrice;
      return basePrice - discountPrice;
    }
    
    return basePrice;
  }
}
