import 'package:flutter_auth/model/user.dart';
import 'package:flutter_auth/utils/time_util.dart';

import 'ability.dart';

class TopicListData {
  List<Topic> topics;

  TopicListData({this.topics});

  TopicListData.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != null) {
      topics = new List<Topic>();
      json['topics'].forEach((v) {
        topics.add(new Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topics != null) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopicDetailData {
  Topic topic;

  TopicDetailData({this.topic});

  TopicDetailData.fromJson(Map<String, dynamic> json) {
    topic = json['topic'] != null ? new Topic.fromJson(json['topic']) : null;
    // meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topic != null) {
      data['topic'] = this.topic.toJson();
    }
    // if (this.meta != null) {
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
  Null suggestedAt;
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    excellent = json['excellent'];
    hits = json['hits'];
    abilities = json['abilities'] != null
        ? new Abilities.fromJson(json['abilities'])
        : null;
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
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['excellent'] = this.excellent;
    data['hits'] = this.hits;
    if (this.abilities != null) {
      data['abilities'] = this.abilities.toJson();
    }
    data['body'] = this.body;
    data['body_html'] = this.bodyHtml;
    return data;
  }
}

