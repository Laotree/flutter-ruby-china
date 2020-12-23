import 'ability.dart';

class UserData {
  User user;

  UserData({
    this.user,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != String ? new User.fromJson(json['user']) : String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != String) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String login;
  String name;
  String avatarUrl;
  Ability abilities;
  String location;
  String company;
  String twitter;
  String website;
  String tagline;
  String github;
  String createdAt;
  int topicsCount;
  int repliesCount;
  int followingCount;
  int followersCount;
  int favoritesCount;
  String level;
  String levelName;
  String bio;
  String email;

  User(
      {this.id,
      this.login,
      this.name,
      this.avatarUrl,
      this.location,
      this.company,
      this.twitter,
      this.website,
      this.tagline,
      this.github,
      this.createdAt,
      this.topicsCount,
      this.repliesCount,
      this.followingCount,
      this.followersCount,
      this.favoritesCount,
      this.level,
      this.levelName,
      this.bio,
      this.email,
      this.abilities});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    name = json['name'];
    avatarUrl = json['avatar_url'];
    location = json['location'];
    company = json['company'];
    twitter = json['twitter'];
    website = json['website'];
    tagline = json['tagline'];
    github = json['github'];
    createdAt = json['created_at'];
    topicsCount = json['topics_count'];
    repliesCount = json['replies_count'];
    followingCount = json['following_count'];
    followersCount = json['followers_count'];
    favoritesCount = json['favorites_count'];
    level = json['level'];
    levelName = json['level_name'];
    bio = json['bio'];
    email = json['email'];
    abilities = json['abilities'] != String
        ? new Ability.fromJson(json['abilities'])
        : String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['name'] = this.name;
    data['avatar_url'] = this.avatarUrl;
    data['location'] = this.location;
    data['company'] = this.company;
    data['twitter'] = this.twitter;
    data['website'] = this.website;
    data['tagline'] = this.tagline;
    data['github'] = this.github;
    data['created_at'] = this.createdAt;
    data['topics_count'] = this.topicsCount;
    data['replies_count'] = this.repliesCount;
    data['following_count'] = this.followingCount;
    data['followers_count'] = this.followersCount;
    data['favorites_count'] = this.favoritesCount;
    data['level'] = this.level;
    data['level_name'] = this.levelName;
    data['bio'] = this.bio;
    data['email'] = this.email;
    if (this.abilities != String) {
      data['abilities'] = this.abilities.toJson();
    }
    return data;
  }
}
