import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/models/user.dart';

class Comment {
  int id;
  String content;
  Publication publication;
  User owner;
  String date;
  int likeCount;
  /*String createdAt;
  String updatedAt;*/

  Comment({
    required this.id,
    required this.content,
    required this.publication,
    required this.owner,
    this.date = "25-10-24",
    this.likeCount = 12,
    /*required this.createdAt,
    required this.updatedAt*/
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      content: map['content'],
      publication: Publication.fromMap(map['publication'] as Map<String, dynamic>),
      owner: User.fromMap(map['owner'] as Map<String, dynamic>),
      date: map['date'] != null ?? map['date'],
      likeCount: map['likeCount'] != null ?? map['likeCount']
      /*createdAt: map['createdAt'],
      updatedAt: map['updatedAt']*/
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'content': content,
      'publication': publication.toMap(),
      'owner': owner.toMap(),
      'date': date
      /*"createdAt": createdAt,
      "updatedAt": updatedAt*/
    };
  }
}