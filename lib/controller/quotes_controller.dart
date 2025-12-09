import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/services/category_service.dart';
import 'package:flutter_quotes_admin_app/services/quotes_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../model/category_model.dart';
import '../model/quotes_model.dart';

class QuotesController extends GetxController {

  var dropdownList = <CategoryModel>[].obs;

  var selectedCategoryId = Rx<int?>(null);

  final CategoryService categoryService = CategoryService();
  final QuotesService quotesService = QuotesService();

  final quotesText = TextEditingController();

  var quotesList = <QuotesModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getDropDown();
    getAllQuote();
    super.onInit();
  }

  void getDropDown() async {
    dropdownList.clear();
    try {
      final response = await categoryService.getCategory();
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['categories'];
        for (var item in data) {
          dropdownList.add(CategoryModel.fromJson(item));
        }
      } else {
        print("Error : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void insertQuotes() async {


    if (quotesText.text
        .trim()
        .isEmpty) {


      Fluttertoast.showToast(
          msg: "Please enter a quote",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


      return;
    }
    if (selectedCategoryId.value == null) {


      Fluttertoast.showToast(
          msg: "Please select a category",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


      return;
    }


    CategoryModel? selectedCategory;
    try {
      selectedCategory = dropdownList.firstWhere(
            (cat) => cat.id == selectedCategoryId.value,
      );
    } catch (e) {
      Get.snackbar("Error", "Selected category not found");
      return;
    }

    final response = await quotesService.addQuote({
      "category_id": selectedCategory.id.toString(),
      "category_name": selectedCategory.name!.trim(),
      "quote_text": quotesText.text.trim(),
    });

    if (response.statusCode == 200) {



      Fluttertoast.showToast(
          msg: "Quote added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


      quotesText.clear();
      selectedCategoryId.value = null;
      getAllQuote();
    } else {
      Get.snackbar("Error", "Failed to add quote");
    }
  }


  void getAllQuote() async {

    quotesList.clear();
    try {
      final response = await quotesService.getQuote();

      if(response.statusCode==200){
        var result = jsonDecode(response.body);

        List data = result['quotes'];

        for(int i=0; i<data.length;i++){
          var list = data[i];
          quotesList.add(QuotesModel.fromJson(list));
          print(list);
        }

      }

      else
      {
        print("Error : ${response.statusCode}");
      }

    }

    catch(e){
      print(e.toString());
      throw Exception(e.toString());
    }

    }


  // UPDATE Quote
  void updateQuote({required int quoteId}) async {

    quotesList.clear();
    if (quotesText.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter a quote",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }
    if (selectedCategoryId.value == null) {
      Fluttertoast.showToast(
          msg: "Please select a category",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    final category = dropdownList.firstWhere(
            (c) => c.id == selectedCategoryId.value);

    final response = await quotesService.updateQuotes({
      "id": quoteId,
      "category_id": category.id,
      "category_name": category.name,
      "quote_text": quotesText.text.trim(),
    });

    if (response.statusCode == 200) {

      Fluttertoast.showToast(
          msg: "Quote updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


      quotesText.clear();
      selectedCategoryId.value = null;
      quotesList.clear();
      getAllQuote();

    } else {
      Get.snackbar("Error", "Failed to update quote");
    }
  }


  void deleteQuote(String id) async {

    final response = await quotesService.deleteQuote(id);

    if (response.statusCode == 200) {

      Fluttertoast.showToast(
          msg: "Quote Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      quotesList.clear();
      getAllQuote();
    } else {

      print("${response.statusCode}");
    }
  }


  void getQuoteByCategory (String categoryId) async {

    quotesList.clear();

    final response = await quotesService.getQuotesByCategory(categoryId);

    if(response.statusCode==200){
      var result = jsonDecode(response.body);

      List data = result['quotes'];

      for(int i=0;i<data.length;i++){
        var list = data[i];
  quotesList.add(QuotesModel.fromJson(list));
      }
    }
     else{
       print(response.statusCode);
    }

  }










}



