import 'dart:convert';
import 'dart:io';
import 'package:flutter_quotes_admin_app/model/image_model.dart';
import 'package:flutter_quotes_admin_app/services/slider_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SliderController extends GetxController {

  RxList<Images> imageList = <Images>[].obs;
  RxBool isLoading = false.obs;

  var pickImage = File("").obs;
  final ImagePicker picker = ImagePicker();
  final SliderService service = SliderService();

  @override
  void onInit() {
    getSliderImage();
    super.onInit();
  }

  /// PICK IMAGE
  void bannerPick() async {
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickImage.value = File(image.path);
    } else {
      Get.snackbar("Error", "No image selected");
    }
  }

  /// ADD SLIDER IMAGE
  void addSlider() async {
    if (pickImage.value.path.isEmpty) {
      Get.snackbar("Error", "Please select an image");
      return;
    }

    final response = await service.addSlider({
      "image": pickImage.value.path,
    });

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Slider Added Successfully");
      pickImage.value = File("");
      getSliderImage();
    } else {
      print("Add Slider Error : ${response.body}");
    }
  }

  /// GET SLIDER IMAGES
  void getSliderImage() async {
    try {
      isLoading.value = true;
      imageList.clear();

      final response = await service.getSlider();

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List data = result['images'];

        imageList.value = data.map((e) => Images.fromJson(e)).toList();
      } else {
        print("Get Slider Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// UPDATE SLIDER IMAGE
  void updateSliderImage(String id, String oldImage) async {
    if (pickImage.value.path.isEmpty) {
      Get.snackbar("Error", "Please pick an image first");
      return;
    }

    final response = await service.updateSlider({
      "id": id,
      "image": pickImage.value.path,
      "old_image": oldImage,
    });

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Slider Updated Successfully");
      pickImage.value = File("");
      getSliderImage();
    } else {
      print("Update Error: ${response.body}");
    }
  }

  /// PICK & UPDATE
  void pickForUpdate(String id, String oldImage) async {
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickImage.value = File(image.path);
      updateSliderImage(id, oldImage);
    } else {
      Get.snackbar("Error", "No image selected");
    }
  }

  /// DELETE SLIDER IMAGE
  void deleteImageSlider(String id) async {
    final response = await service.deleteSlider(id);

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Slider Deleted Successfully");
      getSliderImage();
    } else {
      print("Delete Error: ${response.statusCode}");
    }
  }
}
