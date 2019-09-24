import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  final listado1 = [
    'Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco', 'Seis', 'Siete'
  ];
  final listado2 = [
    'Uno', 'Dos', 'Tres'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen al tipear

    if(query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        final peliculas = snapshot.data;

        if(snapshot.hasData) {
          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50,
                  fit: BoxFit.contain
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
      },
    );


  }

  /*@override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen al tipear

    final listaSugerida = (query.isEmpty) 
                            ? listado2 
                            : listado1.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      },
    );
  }*/



}