
import 'dart:convert';


class Cast{

  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    jsonList.forEach((item){
      final actor = Actor.fromJson(item);
      actores.add(actor);
    });

  }

}


Actor actorFromJson(String str) => Actor.fromJson(json.decode(str));

String actorToJson(Actor data) => json.encode(data.toJson());

class Actor {
    int castId;
    String character;
    String creditId;
    int gender;
    int id;
    String name;
    int order;
    String profilePath;

    Actor({
        this.castId,
        this.character,
        this.creditId,
        this.gender,
        this.id,
        this.name,
        this.order,
        this.profilePath,
    });

    factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        order: json["order"],
        profilePath: json["profile_path"],
    );

    Map<String, dynamic> toJson() => {
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "gender": gender,
        "id": id,
        "name": name,
        "order": order,
        "profile_path": profilePath,
    };

    getPhoto(){

      if(profilePath == null){
        return 'https://www.trzcacak.rs/myfile/detail/385-3856300_no-avatar-png.png';
      }else{
        return 'https://image.tmdb.org/t/p/w500/$profilePath';
      }
    }
}
