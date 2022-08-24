import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../config/app_config.dart';
import '../config/app_state.dart';
import '../services/auth_service.dart';
import '../services/utils/storage.dart';
import '../set_up.dart';

class AuthViewModelViewModel extends BaseViewModel {
  AppState appState = AppState.none;

  final AuthService _authService = locator<AuthService>();

  final Storage _storage = locator<Storage>();

  final formKey = GlobalKey<FormState>();

  final formKey2 = GlobalKey<FormState>(debugLabel: "formKey2");

  final controller = PageController(initialPage: 0);

  final TextEditingController _apiKeyTextController = TextEditingController();

  final TextEditingController _otpController = TextEditingController();

  TextEditingController get apiKeyTextController => _apiKeyTextController;

  TextEditingController get otpController => _otpController;

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> syncAccountAction(String secretKey) async {
    try {
      appState = AppState.loading;
      notifyListeners();
      final Map<String, String> data = {
        "secretKey": secretKey,
      };
      await _authService.syncAccount(data);
      appState = AppState.none;
      notifyListeners();
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } catch (e) {
      appState = AppState.error;
      notifyListeners();
      AppConfigService.errorSnackBar(e.toString());
    }
  }

  Future<void> authenticateAction(String code) async {
    try {
      appState = AppState.loading;
      notifyListeners();
      final Map<String, String> data = {
        "code": code,
      };
      final response = await _authService.authenticate(data);
      final jsonDecoded = json.decode(response.body);
      String returnedToken = jsonDecoded['data']['user']['token'];
      await _storage.setString("token", returnedToken);
      AppConfigService.offAllNamed("dca_plan");
      appState = AppState.none;
      notifyListeners();
    } catch (e) {
      appState = AppState.error;
      notifyListeners();
      AppConfigService.errorSnackBar(e.toString());
    }
  }
}
