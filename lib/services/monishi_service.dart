import 'package:flutter_quotes_admin_app/constant/utils/api_url.dart';
import 'package:http/http.dart' as http;

class MonishiService {


  Future<http.Response> addMonishi(Map data) async {

    try{
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(ApiUrl.add_monishi_url),
      );

      request.fields["name"] = data["name"];

      request.files.add(
        await http.MultipartFile.fromPath("image", data["image"]),
      );

      request.headers.addAll({"Accept": "application/json"});

      final streamRequest = await request.send();
      final response = http.Response.fromStream(streamRequest);


      return response;
    } catch(e){
      throw Exception(e.toString());
    }

  }


  Future<http.Response> getMonishi () async {

    final response = await http.get(
      Uri.parse(ApiUrl.get_monishi_url),
      headers: {
        "Accept" : "application/json"
      }
    );

    return response;

  }

  Future<http.Response> updateMonishi(Map data) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(ApiUrl.update_monishi_url),
      );

      request.fields["monishi_id"] = data["id"];
      request.fields["name"] = data["name"];

      if (data["image"] != null && data["image"].toString().isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath("image", data["image"]),
        );
      }

      request.headers.addAll({"Accept": "application/json"});

      final stream = await request.send();
      return http.Response.fromStream(stream);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<http.Response> deleteMonishi(int id) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.delete_monishi_url),
        headers: {"Accept": "application/json"},
        body: {"monishi_id": id.toString()},
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }



}
