import 'dart:convert';

import 'package:dca_mobile/config/app_state.dart';
import 'package:dca_mobile/models/plans.dart';
import 'package:dca_mobile/services/plans_service.dart';
import 'package:dca_mobile/set_up.dart';
import 'package:stacked/stacked.dart';

import '../config/app_config.dart';

class PlansViewModels extends BaseViewModel {
  final PlanService _planService = locator<PlanService>();

  AppState appState = AppState.loading;

  List<Plan> plans = [];

  Future<void> reloadAction() async {
    try {
      appState = AppState.loading;
      notifyListeners();
      await fetchAllPlansAction();
    } catch (e) {
      AppConfigService.errorSnackBar(e.toString());
    }
  }

  Future<void> togglePlan(Plan plan) async {
    try {
      plan.isActive = !plan.isActive;
      await _planService.togglePlan(
        plan.id,
        {"isActive": plan.isActive},
      );
      AppConfigService.successSnackBar("Plan successfully updated.");
    } catch (e) {
      AppConfigService.errorSnackBar(e.toString());
    }
    notifyListeners();
  }

  Future<void> fetchAllPlansAction() async {
    try {
      final response = await _planService.getAllPlans();
      final jsonResponse = json.decode(response.body);
      plans = Plan.resolveList(jsonResponse['plans'] ?? []);
      appState = AppState.none;
      notifyListeners();
    } catch (e) {
      appState = AppState.error;
      notifyListeners();
      AppConfigService.errorSnackBar(e.toString());
    }
  }
}
