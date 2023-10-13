import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';

import '../domain/model_product.dart';

@lazySingleton
class ProductListRepository {
  final FirebaseFirestore _firestore;

  ProductListRepository(this._firestore);

  Future<List<Product>> loadProducts() {
    return _firestore.collection('products').get().then(
      (querySnapshot) {
        return querySnapshot.docs
            .map(
              (docSnapshot) => Product(
                code: docSnapshot.data()['product_code'],
                name: docSnapshot.data()['product_name'],
                basePrice:
                    Decimal.parse(docSnapshot.data()['price'].toString()),
                discount: docSnapshot.data()['discount'].toDouble(),
                currency: docSnapshot.data()['currency'],
                dimension: docSnapshot.data()['dimension'],
                unit: docSnapshot.data()['unit'],
              ),
            )
            .toList();
      },
      onError: (e) => <Product>[],
    );
  }
}
