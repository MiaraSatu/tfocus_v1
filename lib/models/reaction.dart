import 'package:tfocus_v_common_2/models/user.dart';

class Reaction {
  int id;
  String reactType;
  User owner;

  Reaction({
    required this.id,
    required this.reactType,
    required this.owner
});

  factory Reaction.fromMap(Map<String, dynamic> map) {
    return Reaction(
      id: map['id'],
      reactType: map['reactType'],
      owner: User.fromMap(map['owner'])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reactType': reactType,
      'owner': owner.toMap()
    };
  }
}