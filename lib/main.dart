import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juicy_spot/routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static Alice alice = Alice(
    showNotification: true,
    showInspectorOnShake: true,
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Juicy Spot',
      initialRoute: AppRoutes.SPLASHSCREEN,
      getPages: AppPages.routes,
      navigatorKey: alice.getNavigatorKey(),
    );
  }
}
