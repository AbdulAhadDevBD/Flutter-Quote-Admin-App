import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/widgets/custom_button.dart';
import 'package:flutter_quotes_admin_app/widgets/custom_text_field.dart';
import 'package:get/get.dart';

import '../../controller/quotes_controller.dart';

class AddQuotesScreen extends GetView<QuotesController> {
  AddQuotesScreen({super.key});

  @override
  QuotesController get controller => Get.put(QuotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Add New Quote",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Obx(() {
        if (controller.dropdownList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("Write Quote",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),

                      CustomTextField(
                        controller: controller.quotesText,
                        text: "Write your quote...",
                        maxline: 8,
                      ),

                      SizedBox(height: 25),

                      Text("Select Category",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),

                    Obx(() {
                      return   DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        hint: Text("Choose Category"),

                        value: controller.selectedCategoryId.value,

                        items: controller.dropdownList.map((category) {
                          return DropdownMenuItem<int>(
                            value: category.id,
                            child: Text(category.name ?? ""),
                          );
                        }).toList(),

                        onChanged: (value) {
                          controller.selectedCategoryId.value = value;
                        },
                      );

                    })
                    ,


                      SizedBox(height: 25),

                      CustomButton(
                        text: "Submit Quote",
                        onTap: () {
                          controller.insertQuotes();
                        },
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      }),
    );
  }
}

