import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/controller/category_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../constant/utils/api_url.dart';
import '../constant/utils/app_color.dart';
import '../model/category_model.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class UpdateCategoryDialog extends StatelessWidget {
  final CategoryModel category;
  UpdateCategoryDialog({super.key, required this.category});

  final CategoryController controller = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Update Category",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 20),

              // ---------------------
              // IMAGE SECTION
              // ---------------------
              Obx(() {
                return GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue),
                      image: controller.pickedImage.value.path.isNotEmpty
                          ? DecorationImage(
                        image: FileImage(controller.pickedImage.value),
                        fit: BoxFit.cover,
                      )
                          : DecorationImage(
                        image: NetworkImage(
                            "${ApiUrl.category_image_url}${category.image}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),

              SizedBox(height: 15),

              CustomTextField(
                controller: controller.categoryName,
                text: "Category Name",
              ),

              SizedBox(height: 15),

              Obx(() {
                return controller.isLoading.value
                    ? CircularProgressIndicator()
                    : CustomButton(
                  text: "Update Category",
                  onTap: () {
                    controller.editCategory(controller.selectedId.value);
                    Get.back();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}


