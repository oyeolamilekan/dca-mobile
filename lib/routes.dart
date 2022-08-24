import 'pages/auth.dart';
import 'pages/plans/dca_plans.dart';
import 'pages/plans/dca_transactions.dart';
import 'pages/plans/transactions.dart';
import 'pages/splash_mobile.dart';

final routes = {
  "authentication": (context) => const Authentication(),
  "splash_mobile": (context) => const SplashMobile(),
  "transactions": (context) => const Transactions(),
  "dca_transaction": (context) => const DCATransactions(),
  "dca_plan": (context) => const DCAPlan()
};
