import 'package:http/http.dart';

import '../network/http/api_client.dart';
import '../set_up.dart';

class MarketService {
  final ApiClient _client = locator<ApiClient>();

  Future<Response> fetchMarkets() async {
    return _client.get(
      "markets/all_markets",
      auth: true,
    );
  }
}
