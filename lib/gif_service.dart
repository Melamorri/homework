import 'dart:convert';
import 'gif_model.dart';
import 'package:http/http.dart' as http;

class GifService {
  Future<List<Gif>> fetchGifs(String query) async {
    var url = Uri.parse(
        'https://api.giphy.com/v1/gifs/search?apiKey=NsdfjJw8WUqdBXpPqPKYx0T8y0oAZiD5&q=$query&limit=12&offset=0&rating=g&lang=en');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final results = jsonDecode(response.body)['data'] as List<dynamic>;
    return results.map((obj) => Gif.fromJson(obj)).toList();
  }
}
