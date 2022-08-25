import 'package:dca_mobile/pages/plans/dca_plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:stacked/stacked.dart';

import '../../config/app_config.dart';
import '../../view_models/index_view_model.dart';
import '../../extension/num.dart';
import 'transactions.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IndexViewModel>.reactive(
      viewModelBuilder: () => IndexViewModel(),
      onModelReady: (viewModel) => viewModel.fetchAllMarketsAction(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppConfigService.hexToColor("#f8f9f9"),
          body: SafeArea(
            child: IndexedStack(
              index: viewModel.selectedIndex,
              children: [
                const DCAPlan(),
                const Transactions(),
                Container(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (index) => viewModel.onItemTapped(index),
            selectedItemColor: AppConfigService.hexToColor("#035872"),
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 12,
            selectedFontSize: 12,
            currentIndex: viewModel.selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: const Icon(FeatherIcons.folder),
                ),
                label: "Plans",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: const Icon(FeatherIcons.dollarSign),
                ),
                label: "Transaction",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: const Icon(FeatherIcons.user),
                ),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
