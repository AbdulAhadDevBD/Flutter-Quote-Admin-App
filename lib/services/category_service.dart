import 'package:http/http.dart' as http;

import '../constant/utils/api_url.dart';

class CategoryService {



  Future<http.Response> addCategory(Map categoryData) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(ApiUrl.add_category_url),
      );

        request.fields['name'] = categoryData['name'];

        request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          categoryData['image'], 
        ),
      );


      request.headers.addAll({
        "Accept": "application/json",
      });

     
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);

      return response;
    } catch (e) {
      throw Exception("Upload failed: $e");
    }
  }

  Future<http.Response> getCategory() async {

    http.Response response = await http.get(
      Uri.parse(ApiUrl.get_category_url),

      headers: {
        "Accept" : "application/json"
      }

    );
     return response;
  }



  Future<http.Response> updateCategory(Map data) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(ApiUrl.update_category_url),
    );

    request.fields['id'] = data['id'];
    request.fields['name'] = data['name'];

    // NEW image selected
    if (data["image"] != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', data['image']),
      );
    } else {
      // old image send to backend
      request.fields['old_image'] = data['old_image'];
    }

    final res = await request.send();
    return http.Response.fromStream(res);
  }


  Future<http.Response> deleteCategory(String id) async {
    final response = await http.post(
      Uri.parse(ApiUrl.delete_category_url),
      body: {
        "id": id,
      },
      headers: {

        "Accept": "application/json"},
    );

    return response;
  }









}
