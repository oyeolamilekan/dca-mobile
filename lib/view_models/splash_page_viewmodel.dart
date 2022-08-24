import 'package:stacked/stacked.dart';

import '../config/app_config.dart';
import '../services/utils/jwt_tokens.dart';
import '../services/utils/storage.dart';
import '../set_up.dart';

class SplashViewModelViewModel extends BaseViewModel {
  final Storage _storage = locator<Storage>();

  final JwtTokenUtil _jwtTokenUtil = locator<JwtTokenUtil>();

  Future<void> init() async {
    final String? userToken = _storage.getString("token");
    await Future.delayed(const Duration(seconds: 4));

    if (_jwtTokenUtil.hasExpired(userToken)) {
      await _storage.removeKey("token");
      AppConfigService.offAllNamed("authentication");
    } else {
      AppConfigService.offAllNamed("dca_plan");
    }
  }
}
