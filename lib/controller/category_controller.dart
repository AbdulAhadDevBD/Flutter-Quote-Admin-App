import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/category_model.dart';
import '../services/category_service.dart';

class CategoryController extends GetxController {


  var categoryList = <CategoryModel>[].obs;
  var isLoading = false.obs;

  final categoryName = TextEditingController();
  var pickedImage = File("").obs;

  final CategoryService service = CategoryService();
  final ImagePicker picker = ImagePicker();



  var oldImageName = "".obs;
  var selectedId = "".obs;






  @override
  void onInit() {
get();
super.onInit();
  }

  // Pick Image
  void pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage.value = File(image.path);
    } else {


      Fluttertoast.showToast(
          msg: "No image selected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  // Add Category
  Future<void> add() async {
    /// Validation
    if (categoryName.text.isEmpty) {

      Fluttertoast.showToast(
          msg: "Category name required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return;
    }

    if (pickedImage.value.path.isEmpty) {



      Fluttertoast.showToast(
          msg: "Please select an image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return;
    }

    /// API Call
    try {
      final response = await service.addCategory({
        "name": categoryName.text,
        "image": pickedImage.value.path,
      });

      if (response.statusCode == 200) {

        print(response.body);

        Fluttertoast.showToast(
            msg: "Category Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        categoryList.clear();
        get();

        categoryName.clear();
        pickedImage.value = File(""); //

      } else {
        print("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception $e");
    }
  }


  Future<void> get() async {


    try{

      isLoading.value = true;

      final response = await service.getCategory();

      if(response.statusCode == 200 ){
        var result = jsonDecode(response.body);

        List data = result['categories'];

        for(int i =0; i<data.length ; i++  ){
          var list = data[i];
          categoryList.add(CategoryModel.fromJson(list));

        }
      } else{
        print("Error : ${response.statusCode}");
      }

    } catch (e) {
      throw Exception(e.toString());

    } finally{
      isLoading(false);
    }





}


// ------------------------------
  // UPDATE CATEGORY
  // ------------------------------
  Future<void> editCategory(String id) async {


    if (categoryName.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Category name required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }



    try {
      Map data = {
        "id": id,
        "name": categoryName.text,
      };

      // নতুন ছবি যদি বাছাই করা হয়
      if (pickedImage.value.path.isNotEmpty) {
        data["image"] = pickedImage.value.path;
      } else {
        data["old_image"] = oldImageName.value;
      }

      final response = await service.updateCategory(data);

      if (response.statusCode == 200) {

        Fluttertoast.showToast(
            msg: "Category Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

       categoryList.clear();
    get();


      } else {
        print("Server Error: ${response.statusCode}");
      }
    } catch(e){
      throw Exception(e.toString());
    }
  }




  void setCategoryForEdit(CategoryModel category) {
    categoryName.text = category.name ?? "";

    // পুরনো image নাম backend এ পাঠানোর জন্য
    oldImageName.value = category.image ?? "";

    // Flutter যেন কখনো server image কে File না ভাবে
    pickedImage.value = File("");
  }



  Future<void> deleteCategory(String id) async {
    try {


      final response = await service.deleteCategory(id);

      if (response.statusCode == 200) {



        Fluttertoast.showToast(
            msg: "Category Deleted Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        categoryList.clear();
        get();
      } else {
        print("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    }
  }








}
