import 'package:dca_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/app_config.dart';
import 'set_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppConfigService.navigatorKey, // set property
      title: 'DCA Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "SpaceGrotesk",
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.white,
          iconTheme: IconThemeData(
            color: AppConfigService.hexToColor("#0F597A"),
          ),
        ),
      ),
      initialRoute: "splash_mobile",
      routes: routes,
    );
  }
}
