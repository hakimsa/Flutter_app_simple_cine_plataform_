


import 'dart:convert';

import 'package:cinema/src/pages/models/Actor.dart';
import 'package:http/http.dart' as http;

class ProviderActor{
  String _apiKey = 'cd9f02fa9b75837e14cb04986412e262';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Actor>> getCast( String peliId ) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'  : _apiKey,
      'language' : _language
    });
    final resp = await http.get(url);
    final decodedData = json.decode( resp.body );
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;

  }

}
