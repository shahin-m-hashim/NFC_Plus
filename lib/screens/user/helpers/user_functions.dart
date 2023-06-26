import 'dart:math';

String generateRandomTransactionId() {
  final random = Random();
  const alphanumeric = '0123456789';
  const length = 10;
  String transactionId = '';

  for (int i = 0; i < length; i++) {
    final index = random.nextInt(alphanumeric.length);
    transactionId += alphanumeric[index];
  }

  return transactionId;
}
