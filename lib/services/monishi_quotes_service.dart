
import 'dart:convert';

import 'package:flutter_quotes_admin_app/constant/utils/api_url.dart';
import 'package:http/http.dart' as http;
class MonishiQuotesService {
  
  
  Future<http.Response> addQuotes(Map data) async {
    
    final body={
      "monishi_id" : data["monishi_id"],
      "monishi_name" : data["monishi_name"],
      "quote" : data["quote"],
    };

    final response = await http.post(
      Uri.parse(ApiUrl.add_monishi_quotes_url),
      body: body,

      headers: {
        "Accept": "application/json",

      },
    );

    return response;

      }

      Future<http.Response> getQuotes () async {


    final response = http.get(
      Uri.parse(ApiUrl.get_monishi_quotes_url),
      headers: {
        "Accept" : "application/json"
      }
    );

    return response;

      }


  Future<http.Response> deleteQuote(int id) async {
    final response = await http.post(
      Uri.parse(ApiUrl.delete_monishi_quotes_url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "id": id,
      }),
    );

    return response;
  }

  Future<http.Response> updateQuote(Map data) async {
    return await http.post(
      Uri.parse(ApiUrl.update_monishi_quotes_url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode(data),
    );
  }



}