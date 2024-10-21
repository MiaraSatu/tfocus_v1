import 'package:tfocus_v_common_2/models/user.dart';

class Message {
  int id;
  String content;
  User sender;
  User receiver;
  String createdAt;
  String updatedAt;

  Message({
    required this.id,
    required this.content,
    required this.sender,
    required this.receiver,
    required this.createdAt,
    required this.updatedAt
  });

  factory Message.fromJson(Map<String ,dynamic> map) {
    return Message(
      id: map['id'],
      content: map['id'],
      sender: User.fromMap(map['sender']),
      receiver: User.fromMap(map['receiver']),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "content": content,
      "sender": sender.toMap(),
      "receiver": receiver.toMap(),
      "createdAt": createdAt,
      "updatedAt": updatedAt
    };
  }
}