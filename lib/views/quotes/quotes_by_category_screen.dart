import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/quotes_controller.dart';

class QuotesByCategoryScreen extends StatelessWidget {
  final String categoryName;

  QuotesByCategoryScreen({super.key, required this.categoryName});

  final quotesController = Get.find<QuotesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),

      body: Obx(() {


        if (quotesController.quotesList.isEmpty) {
          return Center(child: Text("No Quotes Found"));
        }
        return ListView.builder(
          itemCount: quotesController.quotesList.length,
          itemBuilder: (context, index) {
            final q = quotesController.quotesList[index];
            return Card(
              child: ListTile(
                title: Text(q.quoteText!),
                subtitle: Text(q.categoryName!),
              ),
            );
          },
        );
      }),
    );
  }
}
