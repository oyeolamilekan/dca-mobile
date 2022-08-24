import 'package:flutter/material.dart';
import '../../extension/num.dart';

class PlanConfig extends StatelessWidget {
  final Widget widgetKey;
  final Widget value;

  const PlanConfig({
    Key? key,
    required this.widgetKey,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          widgetKey,
          const Spacer(),
          value,
        ],
      ),
    );
  }
}
