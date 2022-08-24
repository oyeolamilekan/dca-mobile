import 'package:http/http.dart';

import '../network/http/api_client.dart';
import '../set_up.dart';

class AuthService {
  final ApiClient _client = locator<ApiClient>();

  Future<Response> syncAccount(Map data) async {
    return _client.post(
      "user/syncAccount",
      data,
    );
  }

  Future<Response> authenticate(Map data) async {
    return _client.post(
      "user/authenticate",
      data,
    );
  }
}
