import 'dart:convert';

import 'package:flutter_quotes_admin_app/constant/utils/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SliderService {
  Future<http.Response> addSlider(Map data) async {
    try {
      final resuest = http.MultipartRequest(
        "POST",
        Uri.parse(ApiUrl.upload_Slide_rurl),
      );

      resuest.files.add(
        await http.MultipartFile.fromPath('image', data['image']),
      );

      resuest.headers.addAll({
        "Accept": "application/json",
        "Content-Type": "application/json",
      });

      final streamResponse = await resuest.send();
      final response = await http.Response.fromStream(streamResponse);
      return response;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<http.Response> getSlider() async {
    final response = http.get(
      Uri.parse(ApiUrl.get_Slider_url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    return response;
  }

  Future<http.Response> updateSlider(Map data) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(ApiUrl.update_Slider_url),
    );

    request.fields["id"] = data["id"];
    request.fields["old_image"] = data["old_image"];

    if (data["image"] != null) {
      request.files.add(
        await http.MultipartFile.fromPath("image", data["image"]),
      );
    }

    final res = await request.send();
    return http.Response.fromStream(res);
  }



  Future<http.Response> deleteSlider(String id) async {
    final response = await http.post(
      Uri.parse(ApiUrl.delete_Slider_url),
      body: {"id": id},
    );
    return response;
  }
}
