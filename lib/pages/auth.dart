import 'package:dca_mobile/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import '../config/app_state.dart';
import '../extension/num.dart';
import '../view_models/auth_view_models.dart';
import '../widgets/button.dart';
import '../widgets/input.dart';
import '../widgets/ternary_container.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfigService.hexToColor("#f9f9f9"),
      body: ViewModelBuilder<AuthViewModelViewModel>.reactive(
        viewModelBuilder: () => AuthViewModelViewModel(),
        builder: (context, viewModel, child) => SafeArea(
          child: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 18.h,
                        child: PageView(
                          controller: viewModel.controller,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (int index) =>
                              viewModel.changeIndex(index),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sync Account",
                                  style: TextStyle(
                                    fontSize: 6.text,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Form(
                                  key: viewModel.formKey,
                                  child: DCATextFormField(
                                    title: 'Quidax Secret Key',
                                    textEditingController:
                                        viewModel.apiKeyTextController,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'A.P.I key is required boss';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Enter OTP",
                                  style: TextStyle(
                                    fontSize: 6.text,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Form(
                                  key: viewModel.formKey2,
                                  child: DCATextFormField(
                                    title: 'OTP',
                                    textEditingController:
                                        viewModel.otpController,
                                    textInputType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'OTP is required boss';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      DCAButton(
                        onPressed: () async {
                          if (viewModel.controller.page == 0) {
                            if (viewModel.formKey.currentState!.validate()) {
                              await viewModel.syncAccountAction(
                                viewModel.apiKeyTextController.text,
                              );
                            }
                          } else {
                            if (viewModel.formKey2.currentState!.validate()) {
                              await viewModel.authenticateAction(
                                viewModel.otpController.text,
                              );
                            }
                          }
                        },
                        color:
                            AppConfigService.hexToColor("#ffb300").withOpacity(
                          viewModel.appState == AppState.loading ? 0.5 : 1,
                        ),
                        child: DCATernary(
                          condition: viewModel.appState == AppState.loading,
                          trueWidget:
                              const CircularProgressIndicator.adaptive(),
                          falseWidget: const Text(
                            "LOG IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
