import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/views/home_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';

import 'constant/themes/app_themes.dart';
import 'controller/themes_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.currentTheme,
      title: 'Caption App Admin Panel',
      home: HomeScreen(),
    ));
  }
}
