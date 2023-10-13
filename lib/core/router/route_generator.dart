import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentation/login_page.dart';
import '../../features/checkout/presentation/checkout_page.dart';
import '../../features/product-detail/presentation/product_detail_page.dart';
import '../../features/product-list/domain/model_product.dart';
import '../../features/product-list/presentation/product_list_page.dart';
import '../../features/product-list/presentation/store/provider_product_list.dart';
import '../../injection.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case '/product-list':
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<ProviderProductList>(
            create: (context) => getIt<ProviderProductList>()..loadProducts(),
            child: const ProductListPage(),
          ),
        );
      case '/product-detail':
        return MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: args as Product,
          ),
        );
      case '/checkout':
        return MaterialPageRoute(
          builder: (context) => const CheckoutPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
    }
  }
}
