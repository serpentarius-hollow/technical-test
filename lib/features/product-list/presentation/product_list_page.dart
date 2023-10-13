import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../checkout/presentation/store/provider_checkout.dart';
import '../domain/model_product.dart';
import 'store/provider_product_list.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    void checkoutButtonHandler() {
      Navigator.of(context).pushNamed('/checkout');
    }

    void logoutButtonHandler() {
      context.read<ProviderCheckout>().clearCart();
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Product List'),
        actions: [
          IconButton(
            onPressed: logoutButtonHandler,
            icon: const Icon(Icons.logout),
          )
        ],
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Consumer<ProviderProductList>(
                  builder: (context, state, child) {
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ProductContainer(
                      product: state.products[index],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  final Product product;

  const ProductContainer({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    void buyButtonHandler() {
      context.read<ProviderCheckout>().addToCart(product);
    }

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        '/product-detail',
        arguments: product,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name),
                if (product.finalPrice != product.basePrice)
                  Text(
                    '${product.currency} ${product.basePrice.toString()}',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Text('${product.currency} ${product.finalPrice.toString()}'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: buyButtonHandler,
            child: const Text('BUY'),
          ),
        ],
      ),
    );
  }
}
