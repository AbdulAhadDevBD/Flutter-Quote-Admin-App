import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/constant/utils/api_url.dart';
import 'package:http/http.dart' as http;

class QuotesService {


  Future<http.Response> getCategory() async {
    final response = await http.get(
      Uri.parse(ApiUrl.get_category_url),
      headers: {"Accept": "application.json"},
    );

    return response;
  }


  Future<http.Response> addQuote(Map data) async {
    try {
      final body = {
        "category_id": data["category_id"].toString(),
        "category_name": data["category_name"],
        "quote_text": data["quote_text"],
      };

      final response = await http.post(
        Uri.parse(ApiUrl.add_quotes_url),
        body: body,
        headers: {
          "Accept": "application/json",

        },
      );

      return response;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }


  Future<http.Response> getQuote () async {

    final response = http.get(
        (Uri.parse(ApiUrl.get_quotes_url)),
      headers: {
          "Accept" : "application/json"
      },


    );

    return response;


  }


  Future<http.Response> updateQuotes (Map data) async {

    final body = {
      "id" : data["id"],
      "category_id" : data["category_id"],
      "category_name" : data["category_name"],
      "quote_text" : data["quote_text"],
    };

    final response = await http.put(
        (Uri.parse(ApiUrl.update_quotes_url)),
      body: jsonEncode(body),
      headers: {
          "Content-Type": "application/json"
      },
    ) ;
    return response;
  }

  Future<http.Response> deleteQuote(String id) async {
    final body = jsonEncode({"id": id});
    final response = await http.delete(
      Uri.parse(ApiUrl.delete_quotes_url),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    return response;
  }

  Future<http.Response> getQuotesByCategory(String categoryId) async{

    final url = Uri.parse("${ApiUrl.get_quotes_by_category_url}?category_id=$categoryId");

    final response = await http.get(url);

    return response;

  }










}
