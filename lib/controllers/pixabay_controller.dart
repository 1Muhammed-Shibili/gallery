import 'dart:convert';
import 'package:gallery/models/image_card.dart';
import 'package:http/http.dart' as http;

class PixabayService {
  final String _baseUrl = 'https://pixabay.com/api/';
  final String _apiKey = '46349662-8b4d45dcb41a0404d38c92b7e';

  Future<List<PixabayImage>> fetchImages(int page) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl?key=$_apiKey&image_type=photo&per_page=20&page=$page'),
      );

      print('API Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['hits'];
        return data.map((json) => PixabayImage.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load images: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching images: $e');
      throw Exception('Failed to load images');
    }
  }
}
