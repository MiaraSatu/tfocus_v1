/*
  id,
  link,
  extra,
  type,
  file,
  content
* */
import 'dart:ffi';

import 'package:tfocus_v_common_2/models/user.dart';

class Publication {
  int id;
  String link;
  String type;
  String file;
  User owner;
  Map<String, dynamic> extra;

  Publication({
    required this.id,
    required this.link,
    required this.type,
    required this.file,
    required this.extra,
    required this.owner
  });

  factory Publication.fromMap(Map<String, dynamic> map) {
    return Publication(
      id: map['id'],
      link: map['link'],
      type: map['type'],
      file: map['file'],
      extra: map['extra'],
      owner: User.fromMap(map['owner'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'link': link,
      'type': type,
      'file': file,
      'extra': extra,
    };
  }

}

