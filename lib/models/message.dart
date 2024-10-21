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

  factory Message.fromJson(Map<String ,dynamic> json) {
    return Message(
      id: json['id'],
      content: json['id'],
      sender: User.fromMap(json['sender']),
      receiver: User.fromMap(json['receiver']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']
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