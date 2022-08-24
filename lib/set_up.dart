import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/http/api_client.dart';
import 'services/auth_service.dart';
import 'services/plans_service.dart';
import 'services/transaction_service.dart';
import 'services/utils/jwt_tokens.dart';
import 'services/utils/storage.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  final instance = await SharedPreferences.getInstance();

  locator.registerLazySingleton<SharedPreferences>(
    () => instance,
  );

  locator.registerLazySingleton<Storage>(
    () => Storage(),
  );

  locator.registerLazySingleton<ApiClient>(
    () => ApiClient(),
  );

  locator.registerLazySingleton<JwtTokenUtil>(
    () => JwtTokenUtil(),
  );

  locator.registerLazySingleton<AuthService>(
    () => AuthService(),
  );

  locator.registerLazySingleton<PlanService>(
    () => PlanService(),
  );

  locator.registerLazySingleton<TransactionService>(
    () => TransactionService(),
  );
}
