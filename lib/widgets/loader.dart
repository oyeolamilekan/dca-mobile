import 'package:flutter/material.dart';

class MovecashLoader extends StatelessWidget {
  const MovecashLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
