import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../config/app_config.dart';
import '../config/size_config.dart';
import '../extension/num.dart';
import '../view_models/splash_page_viewmodel.dart';

class SplashMobile extends StatelessWidget {
  const SplashMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SplashViewModelViewModel>.reactive(
      viewModelBuilder: () => SplashViewModelViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Container(
            height: 100.h,
            width: 100.w,
            alignment: Alignment.center,
            color: AppConfigService.hexToColor("#ffb300"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset("assets/png/primary_logo.png"),
                const Spacer(),
                const Text("Proudly powered by quidax."),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
