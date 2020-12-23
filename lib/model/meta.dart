class Meta {
  bool followed;
  bool liked;
  bool favorited;

  Meta({this.followed, this.liked, this.favorited});

  Meta.fromJson(Map<String, dynamic> json) {
    followed = json['followed'];
    liked = json['liked'];
    favorited = json['favorited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followed'] = this.followed;
    data['liked'] = this.liked;
    data['favorited'] = this.favorited;
    return data;
  }
}