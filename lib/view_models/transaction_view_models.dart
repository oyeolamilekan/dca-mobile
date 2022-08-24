import 'dart:convert';

import 'package:dca_mobile/config/app_config.dart';
import 'package:dca_mobile/models/transaction.dart';
import 'package:stacked/stacked.dart';

import '../config/app_state.dart';
import '../services/transaction_service.dart';
import '../set_up.dart';

class TransactionViewModelViewModel extends BaseViewModel {
  late String transactionID;

  late String planName;

  final TransactionService _planService = locator<TransactionService>();

  List<Transaction> transaction = [];

  AppState appState = AppState.loading;

  void assignArguements(Map<String, dynamic> data) {
    transactionID = data['transaction_id'];
    planName = data['plan_name'];
  }

  Future<void> fetchTransactions() async {
    try {
      final response = await _planService.fetchTransaction(transactionID);
      final jsonResponse = json.decode(response.body);
      transaction = Transaction.resolveList(jsonResponse['transactions'] ?? []);
      appState = AppState.none;
      notifyListeners();
    } catch (e) {
      appState = AppState.error;
      notifyListeners();
      AppConfigService.errorSnackBar(e.toString());
    }
  }

  Future<void> reloadAction() async {
    try {
      appState = AppState.loading;
      notifyListeners();
      await fetchTransactions();
    } catch (e) {
      AppConfigService.errorSnackBar(e.toString());
    }
  }
}
