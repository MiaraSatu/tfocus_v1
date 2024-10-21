import 'package:tfocus_v_common_2/models/user.dart';

class Comment {
  int id;
  User follower;
  User followed;

  Comment({
    required this.id,
    required this.follower,
    required this.followed
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      follower: User.fromMap(json['follower'] as Map<String, dynamic>),
      followed: User.fromMap(json['followed'] as Map<String, dynamic>)
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'follower': follower.toMap(),
      'followed': followed.toMap()
    };
  }
}