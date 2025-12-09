import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constant/utils/api_url.dart';
import '../../controller/monishi_controller.dart';
import '../../model/monishi_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class MonishiAddEditScreen extends StatelessWidget {
  final MonishiModel? monishi;
  MonishiAddEditScreen({super.key, this.monishi});

  final MonishiController controller = Get.find<MonishiController>();

  @override
  Widget build(BuildContext context) {


    if (monishi != null) {
      controller.name.text = monishi!.name ?? "";
      controller.selectedImage.value = File("");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(monishi == null ? "Add Monishi" : "Update Monishi"),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            /// IMAGE PICKER
            Obx(() {
              return GestureDetector(
                onTap: controller.pickedImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                    image: controller.selectedImage.value.path.isNotEmpty
                        ? DecorationImage(
                        image: FileImage(controller.selectedImage.value),
                        fit: BoxFit.cover)
                        : (monishi != null && monishi!.image != null)
                        ? DecorationImage(
                        image: NetworkImage(ApiUrl.monishi_image_url + monishi!.image!),
                        fit: BoxFit.cover)
                        : null,
                  ),
                  child: controller.selectedImage.value.path.isEmpty &&
                      (monishi == null)
                      ? Center(child: Icon(Icons.image, size: 50))
                      : null,
                ),
              );
            }),

            SizedBox(height: 20),

            /// NAME FIELD
            CustomTextField(
              controller: controller.name,
              text: "Enter Name",
            ),

            SizedBox(height: 25),

            /// BUTTON
            CustomButton(
                text: monishi == null ? "Add Monishi" : "Update Monishi",
                onTap: () {
                  if (monishi == null) {
                    controller.insertMonishi();
                  } else {
                    controller.updateMonishi(monishi!.id!);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
