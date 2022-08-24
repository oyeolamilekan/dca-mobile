import 'package:flutter/material.dart';
import '../../extension/num.dart';

class MoveCashLoadingWidget extends StatelessWidget {
  const MoveCashLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [
          CircularProgressIndicator.adaptive(),
          SizedBox(
            height: 10,
          ),
          Text("Please leave it let it cook"),
        ],
      ),
    );
  }
}
