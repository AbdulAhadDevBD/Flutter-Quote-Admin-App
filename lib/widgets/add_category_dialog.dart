import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/utils/app_color.dart';
import '../controller/category_controller.dart';
import 'custom_text_field.dart';
import 'custom_button.dart';

class AddCategoryDialog extends StatelessWidget {
  AddCategoryDialog({super.key});

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Category With Image",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

            Obx(() {
              return GestureDetector(
                onTap: () {
                  controller.pickImage();
                },
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColor.primary, width: 1),
                    image: controller.pickedImage.value.path.isNotEmpty
                        ? DecorationImage(
                      image: FileImage(controller.pickedImage.value),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: controller.pickedImage.value.path.isEmpty
                      ? Icon(
                    Icons.image,
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  )
                      : null,
                ),
              );
            }),



            SizedBox(height: 15),

              CustomTextField(
                controller: controller.categoryName,
                text: "Category Name",
              ),

              SizedBox(height: 15),

              CustomButton(
                text: "Add Category",
                onTap: () {
                  controller.add();
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
