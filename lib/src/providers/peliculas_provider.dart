import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{

  String _apikey   = '4c35210beddf3cf36973e0e60a7fdc5f';
  String _url      = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>>getEnCines() async{
    
    final url =Uri.http(_url, '3/movie/now_playing',{
      "api_key": _apikey,
      "language": _language
    });

    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>>buscarPelicula(String query) async{
    
    final url =Uri.http(_url, '3/search/movie',{
      "api_key"  : _apikey,
      "language" : _language,
      "query"    : query
    });

    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>>getPopular() async{

    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;
    
    final url =Uri.http(_url, '3/movie/popular',{
      "api_key": _apikey,
      "language": _language,
      "page" : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);
    
    _populares.addAll(resp);

    popularesSink(_populares);

    _cargando = false;
    return resp;
    
    //return await _procesarRespuesta(url);

  }

  Future<List<Actor>>getCast(int movieId) async{

    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      "api_key": _apikey,
      "language": _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;

  }
}