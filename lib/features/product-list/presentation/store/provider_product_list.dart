import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model_product.dart';
import '../../infrastructure/product_list_repository.dart';

@injectable
class ProviderProductList extends ChangeNotifier {
  bool isLoading = false;
  List<Product> products = [];

  final ProductListRepository _repository;

  ProviderProductList(this._repository);

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    this.products.clear();
    final products = await _repository.loadProducts();
    this.products.addAll(products);

    isLoading = false;
    notifyListeners();
  }
}