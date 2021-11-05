class UserProfileModel {
  String? email ;
  String? token;
  String? vip ;
  String? username;

  UserProfileModel({this.email, this.token, this.vip, this.username});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    token = json['token'];
    vip = json['vip'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['token'] = this.token;
    data['vip'] = this.vip;
    data['username'] = this.username;
    return data;
  }
}
