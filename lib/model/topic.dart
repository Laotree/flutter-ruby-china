import 'package:flutter_auth/model/user.dart';
import 'package:flutter_auth/utils/time_util.dart';

import 'ability.dart';

class TopicListData {
  List<Topic> topics;

  TopicListData({this.topics});

  TopicListData.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != String) {
      topics = new List<Topic>();
      json['topics'].forEach((v) {
        topics.add(new Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topics != String) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopicDetailData {
  Topic topic;

  TopicDetailData({this.topic});

  TopicDetailData.fromJson(Map<String, dynamic> json) {
    topic =
        json['topic'] != String ? new Topic.fromJson(json['topic']) : String;
    // meta = json['meta'] != String ? new Meta.fromJson(json['meta']) : String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topic != String) {
      data['topic'] = this.topic.toJson();
    }
    // if (this.meta != String) {
    //   data['meta'] = this.meta.toJson();
    // }
    return data;
  }
}

class Topic {
  int id;
  String title;
  String createdAt;
  String updatedAt;
  String repliedAt;
  int repliesCount;
  String nodeName;
  int nodeId;
  int lastReplyUserId;
  String lastReplyUserLogin;
  String grade;
  int likesCount;
  String suggestedAt;
  String closedAt;
  bool deleted;
  User user;
  int excellent;
  int hits;
  Abilities abilities;

  // in detail
  String body;
  String bodyHtml;

  Topic({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.repliedAt,
    this.repliesCount,
    this.nodeName,
    this.nodeId,
    this.lastReplyUserId,
    this.lastReplyUserLogin,
    this.grade,
    this.likesCount,
    this.suggestedAt,
    this.closedAt,
    this.deleted,
    this.user,
    this.excellent,
    this.hits,
    this.abilities,
    this.body,
    this.bodyHtml,
  });

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = datetimeStringFormat(json['created_at']);
    updatedAt = datetimeStringFormat(json['updated_at']);
    repliedAt = json['replied_at'];
    repliesCount = json['replies_count'];
    nodeName = json['node_name'];
    nodeId = json['node_id'];
    lastReplyUserId = json['last_reply_user_id'];
    lastReplyUserLogin = json['last_reply_user_login'];
    grade = json['grade'];
    likesCount = json['likes_count'];
    suggestedAt = json['suggested_at'];
    closedAt = json['closed_at'];
    deleted = json['deleted'];
    user = json['user'] != String ? new User.fromJson(json['user']) : String;
    excellent = json['excellent'];
    hits = json['hits'];
    abilities = json['abilities'] != String
        ? new Abilities.fromJson(json['abilities'])
        : String;
    body = json['body'];
    bodyHtml = json['body_html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['replied_at'] = this.repliedAt;
    data['replies_count'] = this.repliesCount;
    data['node_name'] = this.nodeName;
    data['node_id'] = this.nodeId;
    data['last_reply_user_id'] = this.lastReplyUserId;
    data['last_reply_user_login'] = this.lastReplyUserLogin;
    data['grade'] = this.grade;
    data['likes_count'] = this.likesCount;
    data['suggested_at'] = this.suggestedAt;
    data['closed_at'] = this.closedAt;
    data['deleted'] = this.deleted;
    if (this.user != String) {
      data['user'] = this.user.toJson();
    }
    data['excellent'] = this.excellent;
    data['hits'] = this.hits;
    if (this.abilities != String) {
      data['abilities'] = this.abilities.toJson();
    }
    data['body'] = this.body;
    data['body_html'] = this.bodyHtml;
    return data;
  }
}
