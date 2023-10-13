import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../domain/model_checkout.dart';

@lazySingleton
class CheckoutRepository {
  final FirebaseFirestore _firestore;

  CheckoutRepository(this._firestore);

  Future<void> addTransaction(String username, Checkout checkout) {
    final transactionId = const Uuid().v4();
    final order = checkout.toJson();
    return _firestore.collection('transactions').doc(transactionId).set({
      'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
      'transaction_id': transactionId,
      'username': username,
      'order': order,
    }).onError(
      (error, _) => null,
    );
  }
}
