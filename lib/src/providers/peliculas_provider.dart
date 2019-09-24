import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{

  String _apikey   = '4c35210beddf3cf36973e0e60a7fdc5f';
  String _url      = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularesPage = 0;

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

  Future<List<Pelicula>>getPopular() async{

    _popularesPage++;
    
    final url =Uri.http(_url, '3/movie/popular',{
      "api_key": _apikey,
      "language": _language,
      "page" : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);
    
    _populares.addAll(resp);

    popularesSink(_populares);

    return resp;
    
    //return await _procesarRespuesta(url);

  }

}