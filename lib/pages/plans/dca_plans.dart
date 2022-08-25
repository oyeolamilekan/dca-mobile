import 'package:dca_mobile/config/app_config.dart';
import 'package:dca_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:stacked/stacked.dart';

import '../../view_models/plans_view_models.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widgtet.dart';
import '../../widgets/plan_config.dart';
import '../../widgets/plan_status.dart';
import '../../widgets/suspense.dart';
import '../../extension/string.dart';
import '../../extension/num.dart';
import '../../widgets/ternary_container.dart';

class DCAPlan extends StatelessWidget {
  const DCAPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlansViewModels>.reactive(
      viewModelBuilder: () => PlansViewModels(),
      onModelReady: (viewModel) => viewModel.fetchAllPlansAction(),
      builder: (context, viewModel, child) => Suspense(
        appState: viewModel.appState,
        loadingWidget: const MoveCashLoadingWidget(),
        errorWidget: SuspenseErrorWidget(
          message: "Omo, something happ[ened kindly click the refesh button.",
          reload: () => viewModel.reloadAction(),
        ),
        successWidget: (context) => Stack(
          children: [
            DCATernary(
              condition: viewModel.plans.isEmpty,
              trueWidget: const Center(
                child: Text("No transactions."),
              ),
              falseWidget: SizedBox(
                child: ListView.builder(
                  itemCount: viewModel.plans.length,
                  itemBuilder: (context, index) {
                    final plan = viewModel.plans[index];
                    return InkWell(
                      onTap: () => AppConfigService.bottomSheet(
                        StatefulBuilder(
                          builder: (
                            BuildContext context,
                            StateSetter setState,
                          ) =>
                              SizedBox(
                            height: 92.h,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 30,
                                horizontal: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            plan.name,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 4.8.text,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.9.h,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${(plan.market.quoteUnit).toUpperCase()} ${plan.amount} ${(plan.market.baseUnit).toUpperCase()} Purchase',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 7,
                                          horizontal: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          color: plan.isActive
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          plan.isActive ? "Active" : "Inactive",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  const Divider(),
                                  PlanConfig(
                                    widgetKey: const Text("Name:"),
                                    value: Text(plan.name),
                                  ),
                                  const Divider(),
                                  PlanConfig(
                                    widgetKey: const Text("Asset:"),
                                    value: Text(
                                      plan.market.baseUnit.toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  PlanConfig(
                                    widgetKey: const Text("Amount:"),
                                    value: Text(plan.amount),
                                  ),
                                  const Divider(),
                                  PlanConfig(
                                    widgetKey: const Text("Schedule:"),
                                    value: Text(plan.schedule),
                                  ),
                                  const Divider(),
                                  PlanConfig(
                                    widgetKey: const Text("Creation Date"),
                                    value: Text(plan.createdAt
                                        .turnStringToDate("dd, MMM, yyyy.")),
                                  ),
                                  const Divider(),
                                  PlanConfig(
                                    widgetKey: const Text("Is Active"),
                                    value: Switch(
                                      value: plan.isActive,
                                      onChanged: (bool value) {
                                        viewModel.togglePlan(plan);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  const Spacer(),
                                  DCAButton(
                                    color:
                                        AppConfigService.hexToColor("#ffb300"),
                                    onPressed: () {
                                      AppConfigService.back();
                                      AppConfigService.pushNamed(
                                        "dca_transaction",
                                        arguments: {
                                          "transaction_id": plan.id,
                                          "plan_name": plan.name,
                                        },
                                      );
                                    },
                                    child: const Text(
                                      "Purchase History",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        true,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            PlanStatus(
                              status: plan.isActive,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                '${(plan.market.quoteUnit).toUpperCase()} ${plan.amount.toString()}',
                                          ),
                                          const TextSpan(
                                            text: ' - ',
                                          ),
                                          TextSpan(
                                            text: (plan.market.baseUnit)
                                                .toUpperCase(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(plan.name),
                              ],
                            ),
                            const Spacer(),
                            Text(plan.createdAt
                                .turnStringToDate("dd, MMM, yyyy."))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () => AppConfigService.pushNamed("create_plan")!.then(
                  (value) => viewModel.reloadAction(),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 7.h,
                  width: 6.7.h,
                  color: AppConfigService.hexToColor("#ffb300"),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(FeatherIcons.plus),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
