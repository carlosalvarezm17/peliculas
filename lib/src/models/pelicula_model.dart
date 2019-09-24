// To parse this JSON data, do
//
//     final pelicula = peliculaFromJson(jsonString);

import 'dart:convert';

class Peliculas {

  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final pelicula = new Pelicula.fromJson(item);
      items.add( pelicula );
    }

  }

}

Pelicula peliculaFromJson(String str) => Pelicula.fromJson(json.decode(str));

String peliculaToJson(Pelicula data) => json.encode(data.toJson());

class Pelicula {

    String uniqueId;

    double popularity;
    int voteCount;
    bool video;
    String posterPath;
    int id;
    bool adult;
    String backdropPath;
    String originalLanguage;
    String originalTitle;
    List<int> genreIds;
    String title;
    double voteAverage;
    String overview;
    DateTime releaseDate;

    Pelicula({
        this.popularity,
        this.voteCount,
        this.video,
        this.posterPath,
        this.id,
        this.adult,
        this.backdropPath,
        this.originalLanguage,
        this.originalTitle,
        this.genreIds,
        this.title,
        this.voteAverage,
        this.overview,
        this.releaseDate,
    });

    factory Pelicula.fromJson(Map<String, dynamic> json) => Pelicula(
        popularity: json["popularity"].toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        posterPath: json["poster_path"],
        id: json["id"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
    );

    Map<String, dynamic> toJson() => {
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video,
        "poster_path": posterPath,
        "id": id,
        "adult": adult,
        "backdrop_path": backdropPath,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "title": title,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    };
    
    getPosterImg(){

      if(posterPath == null){
        return 'https://image.shutterstock.com/image-vector/picture-vector-icon-no-image-260nw-1350441335.jpg';
      }else{
        return 'https://image.tmdb.org/t/p/w500/$posterPath';
      }
    }
    
    getBackgroundImg(){

      if(posterPath == null){
        return 'https://image.shutterstock.com/image-vector/picture-vector-icon-no-image-260nw-1350441335.jpg';
      }else{
        return 'https://image.tmdb.org/t/p/w500/$backdropPath';
      }
    }
}
