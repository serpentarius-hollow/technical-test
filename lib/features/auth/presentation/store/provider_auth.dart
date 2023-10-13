import 'package:injectable/injectable.dart';

import '../../domain/model_user.dart';
import '../../infrastructure/auth_repository.dart';

@injectable
class ProviderAuth {
  User? user;

  final AuthRepository repository;

  ProviderAuth(this.repository);

  Future<void> login({
    required String username,
    required String password,
  }) {
    return repository.login(username, password).then((user) {
      this.user = user;
    });
  }
}
