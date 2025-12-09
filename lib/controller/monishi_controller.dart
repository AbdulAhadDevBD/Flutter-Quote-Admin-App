import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/model/monishi_model.dart';
import 'package:flutter_quotes_admin_app/services/monishi_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MonishiController extends GetxController {
  var monishiList = <MonishiModel>[].obs;
  var isLoading = false.obs;

  final name = TextEditingController();
  var selectedImage = File("").obs;
  final ImagePicker picker = ImagePicker();

  final MonishiService monishiService = MonishiService();

  @override
  void onInit() {
    fetchMonishi();
    super.onInit();
  }

  void pickedImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    } else {
      Fluttertoast.showToast(
        msg: "No Image Selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void insertMonishi() async {
    try {
      if (name.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Enter Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }

      if (selectedImage.value.path.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please select an image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      final response = await monishiService.addMonishi({
        "name": name.text.trim(),
        "image": selectedImage.value.path,
      });

      if (response.statusCode == 200) {
        fetchMonishi();
        Fluttertoast.showToast(
          msg: "Monishi Add Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        name.clear();
        selectedImage.value = File("");
      } else {
        print("Error : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void fetchMonishi() async {


    try {
      isLoading.value = true;

      final response = await monishiService.getMonishi();

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        print("Decoded Result: $result");
        print("Result Type: ${result.runtimeType}");

        if (result is List) {
          monishiList.clear();

          for (int i = 0; i < result.length; i++) {
            monishiList.add(MonishiModel.fromJson(result[i]));
          }

        }
        else {
          print("API did not return a List");
        }

      } else {
        print("Error: ${response.statusCode}");
      }

    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }


  void updateMonishi(int id) async {
    try {
      if (name.text.isEmpty) {
        Fluttertoast.showToast(msg: "Enter Name");
        return;
      }

      final imgPath = selectedImage.value.path;

      final response = await monishiService.updateMonishi({
        "id": id.toString(),
        "name": name.text.trim(),
        "image": imgPath.isNotEmpty ? imgPath : null
      });

      if (response.statusCode == 200) {
        fetchMonishi();
        Fluttertoast.showToast(
            msg: "Updated Successfully",
            backgroundColor: Colors.green,
            textColor: Colors.white);
        Get.back();
      } else {
        print("Update Failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Update Error: $e");
    }
  }


  void deleteMonishi(int id) async {
    try {
      // ✅ Show confirmation dialog
      bool? confirm = await Get.defaultDialog<bool>(
        title: "Confirm Delete",
        middleText: "Are you sure you want to delete this Monishi?",
        textConfirm: "Yes",
        textCancel: "No",
        confirmTextColor: Colors.white,
        cancelTextColor: Colors.black,
        buttonColor: Colors.red,
        onConfirm: () => Get.back(result: true),
        onCancel: () => Get.back(result: false),
      );

      if (confirm != true) return; // User cancelled

      // ✅ Call delete API
      final response = await monishiService.deleteMonishi(id);

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final res = jsonDecode(response.body);

        if (res["success"] == true) {
          monishiList.removeWhere((element) => element.id == id);

          Fluttertoast.showToast(
            msg: "Deleted Successfully",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
          );
        } else {
          Fluttertoast.showToast(
            msg: res["error"] ?? "Delete Failed",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Server Error: ${response.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      // ✅ Handle unexpected errors gracefully
      Fluttertoast.showToast(
        msg: "Error: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      print("Delete Error: $e");
    }
  }



}
