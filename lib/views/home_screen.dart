import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/controller/monishi_controller.dart';
import 'package:flutter_quotes_admin_app/controller/monishi_quotes_controller.dart';
import 'package:flutter_quotes_admin_app/controller/quotes_controller.dart';
import 'package:flutter_quotes_admin_app/views/monishi/monishi_quotes_screen.dart';
import 'package:flutter_quotes_admin_app/views/monishi/monishi_screen.dart';
import 'package:flutter_quotes_admin_app/views/quotes/quotes.dart';
import 'package:flutter_quotes_admin_app/views/sliders/slider.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/category_controller.dart';
import '../controller/slider_controller.dart';
import '../controller/themes_controller.dart';
import '../widgets/custom_list_tile.dart';
import 'admob/admob_screen.dart';
import 'category/category_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CategoryController categoryController = Get.put(CategoryController());
  final QuotesController quotesController = Get.put(QuotesController());
  final SliderController sliderController = Get.put(SliderController());
  final MonishiController monishiController = Get.put(MonishiController());
  final MonishiQuotesController monishiQuotesController = Get.put(MonishiQuotesController());

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        centerTitle: true,
        actions: [
          Obx(
                () => IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                themeController.toggleTheme();
              },
            ),
          ),
        ],
      ),

      drawer: Drawer(),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomListTile(
                text: "Categories",
                number: "Total Categories: ${categoryController.categoryList.length.toString()}",
                trailingIcon: Icons.arrow_forward_ios,
                leadingIcon: Icons.category,
                onTap: () {
                  Get.to(CategoryScreen());
                },
              ),

              SizedBox(height: 15),

              CustomListTile(
                text: "Quotes",
                number: "Total Quotes: ${quotesController.quotesList.length.toString()}",
                trailingIcon: Icons.arrow_forward_ios,
                leadingIcon: Icons.text_fields,
                onTap: () {
                  Get.to(QuotesScreen());
                },
              ),

              SizedBox(height: 15),

              CustomListTile(
                text: "Image Slider",
                number: "Total Image Sliders: ${sliderController.imageList.length.toString()}",
                trailingIcon: Icons.arrow_forward_ios,
                leadingIcon: Icons.image,
                onTap: () {
                  Get.to(SliderScreen());
                },
              ),

              SizedBox(height: 15),

              CustomListTile(
                text: "Philosophers",
                number: "Total Philosophers: ${monishiController.monishiList.length.toString()}",
                trailingIcon: Icons.arrow_forward_ios,
                leadingIcon: Icons.person_3_rounded,
                onTap: () {
                  Get.to(MonishiScreen());
                },
              ),

              SizedBox(height: 15),

              CustomListTile(
                text: "Philosophers' Quotes",
                number: "Total Philosophers' Quotes: ${monishiQuotesController.monihsiQuotesList.length.toString()}",
                trailingIcon: Icons.arrow_forward_ios,
                leadingIcon: Icons.text_fields_rounded,
                onTap: () {
                  Get.to(MonishiQuotesScreen());
                },
              ),

              SizedBox(height: 15),

              // CustomListTile(
              //   text: "Google Admob",
              //   number: "OF/ON",
              //   trailingIcon: Icons.arrow_forward_ios,
              //   leadingIcon: Icons.ads_click_outlined,
              //   onTap: () {
              //     Get.to(AdmobScreen());
              //   },
              // ),







            ],
          ),
        ),
      ),
    );
  }
}
