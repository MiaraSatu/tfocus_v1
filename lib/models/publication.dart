/*
  id,
  link,
  extra,
  type,
  file,
  content
* */
import 'package:tfocus_v_common_2/models/user.dart';

class Publication {
  int id;
  String? title;
  String? content;
  String? link;
  String? file;
  User? owner;
  Map<String, dynamic>? extra;
  String? date;
  int? likeCount = 0;
  String? author;

  Publication({
    required this.id,
    this.title,
    this.content,
    this.link,
    this.file,
    this.extra,
    this.owner,
    this.date,
    this.likeCount,
    this.author
  });

  factory Publication.fromMap(Map<String, dynamic> map) {
    return Publication(
      id: map['pk'],
      title: map['title'],
      content: map['content'],
      link: map['link'],
      file: map['file'],
      extra: map['extra'],
      owner: map['owner'] == "" ? User.fromMap(map['owner'] as Map<String, dynamic>) : null,
      date: map['date'],
      likeCount: map['like_count'],
      author: map['author']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pk': id,
      'content': content,
      'link': link,
      'file': file,
      'extra': extra,
      'date': date,
      'likeCount': likeCount,
      'author': author
    };
  }

}

