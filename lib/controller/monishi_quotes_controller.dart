import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_quotes_admin_app/model/monishi_model.dart';
import 'package:flutter_quotes_admin_app/model/monishi_quotes_model.dart';
import 'package:flutter_quotes_admin_app/services/monishi_quotes_service.dart';
import 'package:flutter_quotes_admin_app/services/monishi_service.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MonishiQuotesController extends GetxController {
  var dropdownList = <MonishiModel>[].obs;
  var selectedMonishiId = Rx<int?>(null);
  final quotesText = TextEditingController();

  final MonishiService monishiService = MonishiService();
  final MonishiQuotesService service = MonishiQuotesService();

  var monihsiQuotesList = <Quotes>[].obs;
  var loading = false.obs;

  @override
  void onInit() {
    getDropDown();
    getMonishiQuotes();
    super.onInit();
  }

  void _showToast(String msg, {Color bgColor = Colors.red}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: bgColor,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
    );
  }

  void getDropDown() async {
    dropdownList.clear();
    try {
      final response = await monishiService.getMonishi();
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        for (int i = 0; i < result.length; i++) {
          dropdownList.add(MonishiModel.fromJson(result[i]));
        }
      } else {
        print("Error : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void addMonishiQuote() async {
    if (quotesText.text.trim().isEmpty) {
      _showToast("অনুগ্রহ করে একটি কোট লিখুন");
      return;
    }
    if (selectedMonishiId.value == null) {
      _showToast("অনুগ্রহ করে মনিষি নির্বাচন করুন");
      return;
    }

    MonishiModel? selectedCategory;
    try {
      selectedCategory = dropdownList.firstWhere(
            (cat) => cat.id == selectedMonishiId.value,
      );
    } catch (e) {
      selectedCategory = null;
      _showToast("নির্বাচিত মনিষি পাওয়া যায়নি");
      return;
    }

    final response = await service.addQuotes({
      "monishi_id": selectedCategory.id.toString(),
      "monishi_name": selectedCategory.name!,
      "quote": quotesText.text.trim(),
    });

    if (response.statusCode == 200) {
      _showToast("কোট সফলভাবে যোগ করা হয়েছে", bgColor: Colors.green);
      getMonishiQuotes();
      quotesText.clear();
      Get.back();
    } else {
      _showToast("সার্ভার ত্রুটি: ${response.statusCode}");
    }
  }

  void getMonishiQuotes() async {
    monihsiQuotesList.clear();
    try {
      loading(true);
      final response = await service.getQuotes();

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result["quotes"];
        for (int i = 0; i < data.length; i++) {
          var list = data[i];
          monihsiQuotesList.add(Quotes.fromJson(list));
        }
      } else {
        print("Error : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      loading(false);
    }
  }

  void deleteQuote(int id) async {
    final res = await service.deleteQuote(id);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data["status"] == "success") {
        _showToast("কোট সফলভাবে মোছা হয়েছে", bgColor: Colors.green);
        getMonishiQuotes();
      } else {
        _showToast(data["message"]);
      }
    } else {
      _showToast("সার্ভার ত্রুটি: ${res.statusCode}");
    }
  }

  void updateMonishiQuote(int id) async {
    if (quotesText.text.trim().isEmpty) {
      _showToast("অনুগ্রহ করে একটি কোট লিখুন");
      return;
    }
    if (selectedMonishiId.value == null) {
      _showToast("অনুগ্রহ করে মনিষি নির্বাচন করুন");
      return;
    }

    MonishiModel selectedMonishi = dropdownList.firstWhere(
          (monishi) => monishi.id == selectedMonishiId.value,
    );

    final response = await service.updateQuote({
      "id": id,
      "monishi_id": selectedMonishi.id,
      "monishi_name": selectedMonishi.name,
      "quote": quotesText.text.trim(),
    });

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final res = jsonDecode(response.body);
      if (res["status"] == "success") {
        _showToast("কোট সফলভাবে আপডেট হয়েছে", bgColor: Colors.green);
        getMonishiQuotes();
      } else {
        _showToast(res["message"]);
      }
    } else {
      _showToast("সার্ভার ত্রুটি: ${response.statusCode}");
    }
  }

  void setEditData(Quotes? quotes) {
    if (quotes != null) {
      quotesText.text = quotes.quote ?? "";
      selectedMonishiId.value = int.tryParse(quotes.monishiId ?? "");
    } else {
      quotesText.clear();
      selectedMonishiId.value = null;
    }
  }
}
