import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/models/user.dart';

class Hide {
  int id;
  User user;
  Publication publication;

  Hide(this.id, this.user, this.publication);

  factory Hide.fromMap(Map<String, dynamic> map) {
    return Hide(
      map['id'],
      User.fromMap(map['user'] as Map<String, dynamic>),
      Publication.fromMap(map['publication'] as Map<String, dynamic>)
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'user': user.toMap(),
      'publication': publication.toMap()
    };
  }
}