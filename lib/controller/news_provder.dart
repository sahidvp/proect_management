import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsProvider extends ChangeNotifier {
  List<dynamic> articles = [];
  bool isLoading = false;

  Future<void> fetchNews() async {
    final apiKey = 'c030d7aaa47541c6b160cf343fb458bf';
    final url = 'https://newsapi.org/v2/everything?q=construction&apiKey=$apiKey';

    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        articles = data['articles'];
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
