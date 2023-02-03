import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:app/src/models/albums_model.dart';
class AlbumsApi {
  const AlbumsApi();
  Future<List<Album>> fetchAlbum() async{
  final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
  if(response.statusCode==200)
  {  List jsonResponse = json.decode(response.body);
     return jsonResponse.map((data) => Album.fromJson(data)).toList();
  }
  else{
    throw Exception('Failed to load album');
  }
  }
}