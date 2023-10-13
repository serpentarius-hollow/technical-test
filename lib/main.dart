import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/router/route_generator.dart';
import 'features/auth/presentation/store/provider_auth.dart';
import 'features/checkout/infrastructure/checkout_repository.dart';
import 'features/checkout/presentation/store/provider_checkout.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  configureDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => getIt<ProviderAuth>(),
        ),
        ChangeNotifierProxyProvider<ProviderAuth, ProviderCheckout>(
          create: (context) => ProviderCheckout(
            getIt<CheckoutRepository>(),
            user: context.read<ProviderAuth>().user,
          ),
          update: (_, auth, __) => ProviderCheckout(
            getIt<CheckoutRepository>(),
            user: auth.user,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
