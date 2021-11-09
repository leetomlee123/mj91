class PlayMovieModel {
  List<EveryUpdate>? everyUpdate;
  List<EveryUpdate>? likes;
  String? resource;

  PlayMovieModel({this.everyUpdate, this.likes, this.resource});

  PlayMovieModel.fromJson(Map<String, dynamic> json) {
    if (json['everyUpdate'] != null) {
      everyUpdate = <EveryUpdate>[];
      json['everyUpdate'].forEach((v) {
        everyUpdate!.add(new EveryUpdate.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <EveryUpdate>[];
      json['likes'].forEach((v) {
        likes!.add(new EveryUpdate.fromJson(v));
      });
    }
    resource = json['resource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.everyUpdate != null) {
      data['everyUpdate'] = this.everyUpdate!.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    data['resource'] = this.resource;
    return data;
  }
}

class EveryUpdate {
  String? cover;
  String? id;
  String? name;

  EveryUpdate({this.cover, this.id, this.name});

  EveryUpdate.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover'] = this.cover;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class MovieRecord {
  String? cover;
  String? id;
  int? position;
  String? name;

  MovieRecord({this.cover, this.id, this.name, this.position});

  MovieRecord.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    id = json['id'];
    name = json['name'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover'] = this.cover;
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    return data;
  }

  Map<String, dynamic> toMap() =>
      {
        'cover': this.cover,
        'id': this.id,
        'name': this.name,
        'position': this.position
      };

  factory MovieRecord.fromMap(Map<String, dynamic>json)=>
      new MovieRecord(id: json["id"],
          name: json["name"],
          cover: json['cover'],
          position: json['position']);
}
