import 'ability.dart';

class User {
  int id;
  String login;
  String name;
  String avatarUrl;
  Abilities abilities;

  User({this.id, this.login, this.name, this.avatarUrl, this.abilities});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    name = json['name'];
    avatarUrl = json['avatar_url'];
    abilities = json['abilities'] != null
        ? new Abilities.fromJson(json['abilities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['name'] = this.name;
    data['avatar_url'] = this.avatarUrl;
    if (this.abilities != null) {
      data['abilities'] = this.abilities.toJson();
    }
    return data;
  }
}
