import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/constant/utils/api_url.dart';
import 'package:flutter_quotes_admin_app/controller/category_controller.dart';
import 'package:flutter_quotes_admin_app/controller/quotes_controller.dart';
import 'package:flutter_quotes_admin_app/widgets/update_category_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

import '../../widgets/add_category_dialog.dart';
import '../quotes/quotes_by_category_screen.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final CategoryController categoryController = Get.put(CategoryController());
  final QuotesController quotesController = Get.put(QuotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category Management")),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          if (categoryController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          if (categoryController.categoryList.isEmpty) {
            return Center(
              child: Text("No categories found"),
            );
          }

          return ListView.separated(
            itemCount: categoryController.categoryList.length,
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemBuilder: (context, index) {
              final category = categoryController.categoryList[index];
              final imageUrl = ApiUrl.category_image_url + category.image!;

              return InkWell(
                onTap: () {
                  quotesController.getQuoteByCategory(category.id.toString());
                  Get.to(
                    QuotesByCategoryScreen(categoryName: category.name!),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: (category.image != null &&
                          category.image!.isNotEmpty)
                          ? Image.network(
                        imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey[300],
                            child: Icon(Icons.image, color: Colors.white),
                          );
                        },
                      )
                          : Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[300],
                        child: Icon(Icons.image, color: Colors.white),
                      ),
                    ),
                    title: Text(
                      category.name ?? "No Name",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            categoryController.setCategoryForEdit(category);
                            categoryController.selectedId.value =
                                category.id.toString();

                            Get.dialog(
                              UpdateCategoryDialog(category: category),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.warning_amber_rounded,
                                          size: 50,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(height: 15),

                                      Text(
                                        "Delete Category",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),

                                      SizedBox(height: 10),

                                      Text(
                                        "Are you sure you want to delete this category?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),

                                      SizedBox(height: 20),

                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () => Get.back(),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Colors.grey[300],
                                                foregroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: Text("Cancel"),
                                            ),
                                          ),

                                          SizedBox(width: 10),

                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                categoryController
                                                    .deleteCategory(
                                                    category.id.toString());
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: Text("Delete"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(AddCategoryDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
