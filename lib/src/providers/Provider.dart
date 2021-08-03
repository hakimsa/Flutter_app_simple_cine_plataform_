import 'dart:async';
import 'dart:convert';

import 'package:cinema/src/pages/models/Pelicula.dart';
import 'package:http/http.dart' as http;

class Provider {
  int poulares_page = 0;
  bool _estaCargando = false;
  String _apiKey = 'cd9f02fa9b75837e14cb04986412e262';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  List<Pelicula> _populares ;
  //tuberia
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _prosecarpeticiones(Uri url) async {
    final respuesta = await http.get(url);
    final descodeData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(descodeData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    var uri = Uri.http(_url, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await _prosecarpeticiones(uri);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_estaCargando) return [];
    _estaCargando = true;
    poulares_page++;
    var uri = Uri.http(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': poulares_page.toString()
    });
    final resp = await _prosecarpeticiones(uri);
    _populares.addAll(resp);
    popularesSink(_populares);
    _estaCargando = false;
    return resp;
  }


  Future<List<Pelicula>> buscarPelicula( String query ) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : query
    });

    return await _prosecarpeticiones(url);

  }
}

//Provider _provider = new Provider();
