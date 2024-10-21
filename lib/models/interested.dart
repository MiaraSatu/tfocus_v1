import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/models/user.dart';

class Interested {
  int id;
  User user;
  Publication publication;

  Interested({
      required this.id,
      required this.user,
      required this.publication
  });

  factory Interested.fromMap(Map<String, dynamic> map) {
    return Interested(
      id: map['id'],
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      publication: Publication.fromMap(map['publication'] as Map<String, dynamic>)
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