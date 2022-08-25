import 'dart:convert';

import 'package:dca_mobile/config/app_config.dart';
import 'package:dca_mobile/config/app_state.dart';
import 'package:dca_mobile/models/market.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../services/plans_service.dart';
import '../services/utils/storage.dart';
import '../set_up.dart';

class CreatePlanViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  final PlanService _planService = locator<PlanService>();

  List<Market> markets = [];

  List<String> schedule = ['DAILY', 'WEEKLY', 'MONTHLY'];

  AppState appState = AppState.none;

  final TextEditingController _planNameController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _marketController = TextEditingController();

  final TextEditingController _scheduleController = TextEditingController();

  TextEditingController get planNameTextController => _planNameController;

  TextEditingController get amountTextController => _amountController;

  TextEditingController get marketTextController => _marketController;

  TextEditingController get scheduleTextController => _scheduleController;

  final Storage _storage = locator<Storage>();

  Future<void> createPlan() async {
    try {
      if (formKey.currentState!.validate()) {
        appState = AppState.loading;
        notifyListeners();
        final data = {
          "amount": amountTextController.text,
          "market": marketTextController.text,
          "name": planNameTextController.text,
          "schedule": scheduleTextController.text,
        };
        await _planService.createPlan(data);
        appState = AppState.none;
        AppConfigService.back();
      }
    } catch (e) {
      appState = AppState.error;
      AppConfigService.errorSnackBar(e.toString());
    }
    notifyListeners();
  }

  void initMakets() {
    final List allMarkets = json.decode(_storage.getString("markets") ?? '[]');
    markets = Market.resolveList(allMarkets);
    notifyListeners();
  }

  void onClickMarket(String value) {
    marketTextController.text = value;
    AppConfigService.back();
  }

  void onSchedule(String value) {
    scheduleTextController.text = value;
    AppConfigService.back();
  }
}
