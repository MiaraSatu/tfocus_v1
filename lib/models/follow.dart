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

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      follower: User.fromMap(map['follower'] as Map<String, dynamic>),
      followed: User.fromMap(map['followed'] as Map<String, dynamic>)
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