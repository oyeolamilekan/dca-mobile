import 'package:http/http.dart';

import '../network/http/api_client.dart';
import '../set_up.dart';

class TransactionService {
  final ApiClient _client = locator<ApiClient>();

  Future<Response> fetchTransaction(String id) async {
    return _client.get(
      "transaction/transactions/$id",
      auth: true,
    );
  }

  Future<Response> fetchAllTransaction() async {
    return _client.get(
      "transaction",
      auth: true,
    );
  }
}
