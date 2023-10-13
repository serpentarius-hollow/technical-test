import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../product-list/domain/model_product.dart';
import 'store/provider_checkout.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    void confirmationButtonHandler() {
      context.read<ProviderCheckout>().confirmTransaction();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CHECKOUT'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 16,
            ),
            Consumer<ProviderCheckout>(
              builder: (context, state, _) => Text(
                'Total: ${state.total}',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Consumer<ProviderCheckout>(builder: (context, state, _) {
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) => CheckoutItemContainer(
                    product: state.checkoutItems[index].product,
                    quantity: state.checkoutItems[index].quantity,
                    subtotal: state.checkoutItems[index].subtotal,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: state.checkoutItems.length,
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: confirmationButtonHandler,
                child: const Text('ORDER'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CheckoutItemContainer extends StatelessWidget {
  final Product product;
  final int quantity;
  final Decimal subtotal;

  const CheckoutItemContainer({
    super.key,
    required this.product,
    required this.quantity,
    required this.subtotal,
  });

  @override
  Widget build(BuildContext context) {
    void removeButtonHandler() {
      context.read<ProviderCheckout>().removeFromCart(product);
    }

    void addButtonHandler() {
      context.read<ProviderCheckout>().addToCart(product);
    }

    return Row(
      children: [
        const CircleAvatar(),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name),
              Text('Quantity: $quantity'),
              Text('Subtotal: ${product.currency} $subtotal'),
            ],
          ),
        ),
        IconButton(
          onPressed: addButtonHandler,
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: removeButtonHandler,
          icon: const Icon(Icons.remove),
        ),
      ],
    );
  }
}
