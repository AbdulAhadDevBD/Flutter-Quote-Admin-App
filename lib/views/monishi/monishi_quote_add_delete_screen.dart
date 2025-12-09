import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/model/monishi_quotes_model.dart';
import 'package:get/get.dart';

import '../../controller/monishi_quotes_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class MonishiQuoteAddDeleteScreen extends StatelessWidget {
  final Quotes? quotes;
  MonishiQuoteAddDeleteScreen({super.key, this.quotes});

  final MonishiQuotesController controller = Get.find<MonishiQuotesController>();

  @override
  Widget build(BuildContext context) {
    // Initialize edit data for update mode
    Future.microtask(() => controller.setEditData(quotes));

    return Scaffold(
      appBar: AppBar(
        title: Text(quotes == null ? "Add Monishi Quote" : "Update Monishi Quote"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Write Quote", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: controller.quotesText,
                    text: "Write your quote...",
                    maxline: 6,
                  ),
                  SizedBox(height: 25),
                  Text("Select Monishi", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Obx(() {
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      hint: Text("Choose Monishi"),
                      value: controller.selectedMonishiId.value,
                      items: controller.dropdownList.map((monishi) {
                        return DropdownMenuItem<int>(
                          value: monishi.id,
                          child: Text(monishi.name ?? ""),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedMonishiId.value = value;
                      },
                    );
                  }),
                  SizedBox(height: 25),
                  CustomButton(
                    text: quotes == null ? "Add Quote" : "Update Quote",
                    onTap: () {
                      if (quotes == null) {
                        controller.addMonishiQuote();
                      } else {
                        controller.updateMonishiQuote(quotes!.id!);
                      }

                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
