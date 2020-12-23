class Ability {
  bool update;
  bool destroy;
  bool ban;
  bool normal;
  bool excellent;
  bool unexcellent;
  bool close;
  bool open;

  Ability(
      {this.update,
      this.destroy,
      this.ban,
      this.normal,
      this.excellent,
      this.unexcellent,
      this.close,
      this.open});

  Ability.fromJson(Map<String, dynamic> json) {
    update = json['update'];
    destroy = json['destroy'];
    ban = json['ban'];
    normal = json['normal'];
    excellent = json['excellent'];
    unexcellent = json['unexcellent'];
    close = json['close'];
    open = json['open'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['update'] = this.update;
    data['destroy'] = this.destroy;
    data['ban'] = this.ban;
    data['normal'] = this.normal;
    data['excellent'] = this.excellent;
    data['unexcellent'] = this.unexcellent;
    data['close'] = this.close;
    data['open'] = this.open;
    return data;
  }
}
