import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../checkout/presentation/store/provider_checkout.dart';
import '../../product-list/domain/model_product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    void checkoutButtonHandler() {
      Navigator.of(context).pushNamed('/checkout');
    }

    void buyButtonHandler() {
      context.read<ProviderCheckout>().addToCart(product);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Product Detail'),
      ),
      floatingActionButton: Consumer<ProviderCheckout>(
        builder: (context, state, child) {
          return Badge(
            label: Text(
              state.checkoutCounter.toString(),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            largeSize: 20,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            backgroundColor: Colors.red,
            textColor: Colors.white,
            isLabelVisible: state.checkoutCounter > 0,
            child: child,
          );
        },
        child: FloatingActionButton(
          onPressed: checkoutButtonHandler,
          child: const Icon(Icons.shopping_bag_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(product.name),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Price'),
                      Text(product.finalPrice.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Dimension'),
                      Text(product.dimension),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Price Unit'),
                      Text(product.unit),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: buyButtonHandler,
              child: const Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
