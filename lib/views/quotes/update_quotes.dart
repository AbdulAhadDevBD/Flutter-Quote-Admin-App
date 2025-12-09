import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/quotes_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../controller/quotes_controller.dart';

class UpdateQuotesScreen extends StatelessWidget {
  final QuotesModel quote;
  final QuotesController quotesController = Get.find();

  UpdateQuotesScreen({required this.quote, super.key}) {
    quotesController.quotesText.text = quote.quoteText!;
    quotesController.selectedCategoryId.value = quote.categoryId;
  }

  @override
  Widget build(BuildContext context) {

       return Scaffold(
      appBar: AppBar(
        title: Text("Update Quote"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(15),
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

                  Text("Write Quote"),
                  SizedBox(height: 10),

                  CustomTextField(
                    controller: quotesController.quotesText,
                    text: "Write your quote...",
                    maxline: 6,
                  ),

                  SizedBox(height: 25),

                  Text("Update Category"),
                  SizedBox(height: 10),

                  Obx(() {
                    return DropdownButtonFormField<int>(
                      value: quotesController.selectedCategoryId.value,
                      hint: Text("Select Category"),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                      ),
                      items: quotesController.dropdownList.map((category) {
                        return DropdownMenuItem<int>(
                          value: category.id,
                          child: Text(category.name ?? ""),
                        );
                      }).toList(),
                      onChanged: (value) {
                        quotesController.selectedCategoryId.value = value;
                      },
                    );
                  }),


                  SizedBox(height: 25),

                  CustomButton(
                    text: "Update Quote",
                    onTap: () {
                      quotesController.updateQuote(quoteId: quote.id!);
                      Get.back();

                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
