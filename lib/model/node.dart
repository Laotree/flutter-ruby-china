class NodeListData {
  List<Node> nodes;

  NodeListData({this.nodes});

  NodeListData.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = new List<Node>();
      json['nodes'].forEach((v) {
        nodes.add(new Node.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nodes != null) {
      data['nodes'] = this.nodes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Node {
  int id;
  String name;
  int topicsCount;
  String summary;
  int sectionId;
  int sort;
  String sectionName;
  String updatedAt;

  Node(
      {this.id,
        this.name,
        this.topicsCount,
        this.summary,
        this.sectionId,
        this.sort,
        this.sectionName,
        this.updatedAt});

  Node.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    topicsCount = json['topics_count'];
    summary = json['summary'];
    sectionId = json['section_id'];
    sort = json['sort'];
    sectionName = json['section_name'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['topics_count'] = this.topicsCount;
    data['summary'] = this.summary;
    data['section_id'] = this.sectionId;
    data['sort'] = this.sort;
    data['section_name'] = this.sectionName;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
