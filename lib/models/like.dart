import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/models/user.dart';

class Like {
  int id;
  Publication publication;
  User? owner;

  Like({
    required this.id,
    required this.publication,
    this.owner
});

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      id: map['id'],
      publication: map['publication'],
      owner: map['owner']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'publication': publication,
      'owner': owner!.toMap()
    };
  }
}