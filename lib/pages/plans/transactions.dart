import 'package:dca_mobile/extension/num.dart';
import 'package:dca_mobile/extension/string.dart';
import 'package:dca_mobile/widgets/ternary_container.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../config/app_config.dart';
import '../../view_models/all_transactions_view_model.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widgtet.dart';
import '../../widgets/plan_config.dart';
import '../../widgets/suspense.dart';
import 'dca_transactions.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AllTransactionsViewModel>.reactive(
      viewModelBuilder: () => AllTransactionsViewModel(),
      onModelReady: (viewModel) => viewModel.fetchAllTransactionAction(),
      builder: (context, viewModel, child) => Suspense(
        appState: viewModel.appState,
        loadingWidget: const MoveCashLoadingWidget(),
        errorWidget: SuspenseErrorWidget(
          message: "Omo, something happ[ened kindly click the refesh button.",
          reload: () => viewModel.reloadAction(),
        ),
        successWidget: (context) => Container(
          child: DCATernary(
            condition: viewModel.transaction.isEmpty,
            trueWidget: const Center(
              child: Text("No transactions."),
            ),
            falseWidget: ListView.builder(
              itemCount: viewModel.transaction.length,
              itemBuilder: (context, index) {
                final transaction = viewModel.transaction[index];
                return InkWell(
                  onTap: () => AppConfigService.bottomSheet(
                    Container(
                      height: 71.h,
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          PlanConfig(
                            widgetKey: const Text(
                              "Asset:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            value: Text(transaction.receive.unit),
                          ),
                          const Divider(),
                          PlanConfig(
                            widgetKey: const Text(
                              "Amount:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            value: Text(
                                '${transaction.total.unit.toUpperCase()} ${double.parse(transaction.total.amount).toStringAsFixed(3)}'),
                          ),
                          const Divider(),
                          PlanConfig(
                            widgetKey: const Text(
                              "Received:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            value: Text(
                                "${double.parse(transaction.receive.amount).toStringAsFixed(10)} ${transaction.receive.unit}"),
                          ),
                          const Divider(),
                          PlanConfig(
                            widgetKey: const Text(
                              "Fee",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            value: Text(
                                "${double.parse(transaction.fee.amount).toStringAsFixed(10)} ${transaction.fee.unit}"),
                          ),
                          const Divider(),
                          PlanConfig(
                            widgetKey: const Text(
                              "Status:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            value: TransactionStatusText(
                              status: transaction.status,
                              title: transaction.status,
                            ),
                          ),
                          const Divider(),
                          PlanConfig(
                            widgetKey: const Text(
                              "Creation Date:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            value: Text(transaction.createdAt
                                .turnStringToDate("dd MMM yyyy.")),
                          ),
                        ],
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
                        TransactionStatus(
                          status: transaction.status,
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
                                            '${transaction.total.unit.toUpperCase()} ${double.parse(transaction.total.amount).toStringAsFixed(3)}',
                                      ),
                                      const TextSpan(
                                        text: ' - ',
                                      ),
                                      TextSpan(
                                        text: transaction.status,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(double.parse(transaction.receive.amount)
                                .toStringAsFixed(10))
                          ],
                        ),
                        const Spacer(),
                        Text(transaction.createdAt
                            .turnStringToDate("dd, MMM, yyyy."))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
