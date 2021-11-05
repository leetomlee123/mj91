class MovieDetailModel {
  String? cover;
  String? desc;
  String? intro;
  List<Items>? items;
  List<String>? pics;

  MovieDetailModel({this.cover, this.desc, this.intro, this.items, this.pics});

  MovieDetailModel.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    desc = json['desc'];
    intro = json['intro'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items?.add(new Items.fromJson(v));
      });
    }
    pics = json['pics'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover'] = this.cover;
    data['desc'] = this.desc;
    data['intro'] = this.intro;
    if (this.items != null) {
      data['items'] = this.items?.map((v) => v.toJson()).toList();
    }
    data['pics'] = this.pics;
    return data;
  }
}

class Items {
  String? id;
  String? name;

  Items({this.id, this.name});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
