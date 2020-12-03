import 'package:flutter_auth/model/topic.dart';
import 'package:flutter_auth/model/user.dart';
import 'package:flutter_auth/utils/time_util.dart';

import 'ability.dart';

class RepliesData {
  List<Reply> replies;

  RepliesData({this.replies});

  RepliesData.fromJson(Map<String, dynamic> json) {
    if (json['replies'] != null) {
      replies = new List<Reply>();
      json['replies'].forEach((v) {
        replies.add(new Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reply {
  int id;
  String bodyHtml;
  String body;
  int topicId;
  String createdAt;
  String updatedAt;
  int likesCount;
  String action;
  Null targetType;
  bool deleted;
  User user;
  Abilities abilities;
  Topic mentionTopic;

  Reply(
      {this.id,
      this.bodyHtml,
      this.body,
      this.topicId,
      this.createdAt,
      this.updatedAt,
      this.likesCount,
      this.action,
      this.targetType,
      this.deleted,
      this.user,
      this.abilities,
      this.mentionTopic});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bodyHtml = json['body_html'];
    body = json['body'];
    topicId = json['topic_id'];
    createdAt = datetimeStringFormat(json['created_at']);
    updatedAt = datetimeStringFormat(json['updated_at']);
    likesCount = json['likes_count'];
    action = json['action'] == null ? null : json['action'];
    targetType = null;
    deleted = json['deleted'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    abilities = json['abilities'] != null
        ? new Abilities.fromJson(json['abilities'])
        : null;
    mentionTopic = json['mention_topic'] != null ? new Topic.fromJson(json['mention_topic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body_html'] = this.bodyHtml;
    data['body'] = this.body;
    data['topic_id'] = this.topicId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likes_count'] = this.likesCount;
    data['action'] = this.action;
    data['target_type'] = this.targetType;
    data['deleted'] = this.deleted;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.abilities != null) {
      data['abilities'] = this.abilities.toJson();
    }
    return data;
  }
}
