import 'dart:convert';

import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:tfocus_v_common_2/models/reaction.dart';
import 'package:tfocus_v_common_2/models/message.dart';
import 'package:tfocus_v_common_2/models/user.dart';

import '../models/user.dart';

class ApiService {
  static List<User> users = [
    User(id: 0, email: 'fenitra@example.com', firstName: "Fenitra", favoriteTopics: ["sport"]),
    User(id: 1, email: 'misa@example.com', firstName: 'Misasoa', favoriteTopics: []),
    User(id: 3, email: 'nathan@example.com', firstName: 'Nath', favoriteTopics: []),
    User(id: 4, email: 'tolotra@example.com', firstName: 'Tolotra', favoriteTopics: []),
    User(id: 5, email: 'nidianne@example.com', firstName: 'Nidianne', favoriteTopics: []),
  ];

  static List<Publication> publications = [
    Publication(id: 1, title: "Pub 1", type: "publication", owner: users[0], content: "Je suis ravi de rejoindre vos communauté", file: "images/externalisation-de-la-paie.jpg"),
    Publication(id: 2, title: "Pub 1", type: "publication", owner:users[0] , content: "Lorem ipsum delor sit amet", file: "images/logo-ispm.png"),
    Publication(id: 3, title: "Pub 1", type: "publication", owner: users[1], content: "Amigo dalameta abesitera", file: "images/ion.jpg"),
    Publication(id: 4, title: "Pub 1", type: "publication", owner:users[3] , content: "ipsum alimona dika ninalke", file: "images/ext2.jpg"),
  ];

  /*
  * Liste des routes utiles:
  *
  * */
  static String BASE_URL = 'http://localhost:8000/';
  static String API_URL = BASE_URL+'/api';

  // SPECIAL FOR PUBLICATION
  static Future<List<Publication>> fetchPublications() async {

    return publications;
    final response = await http.get(
      Uri.parse(API_URL+"/publications") // localhost:8000/api/publications
    );

    if(200 <= response.statusCode && response.statusCode < 300) {
      final responseData = jsonDecode(response.body);
      List<Publication> pubs = List<Publication>.from(responseData.map(
        (pubMap) => Publication.fromMap(pubMap as Map<String, dynamic>)
      ));
      return pubs;
    } else {
      return publications;
    }
  }

  static Future<Publication> fetchPublicationDetails(int pubId) async {
    final response = await http.get(
      Uri.parse("$API_URL/publication/$pubId")
    );

    if(200 <= response.statusCode && response.statusCode < 300) {
      final responseData = jsonDecode(response.body);
      Publication pub = Publication.fromMap(responseData as Map<String, dynamic>);
      return pub;
    } else {
      throw new Exception("Problem occured! publication not loaded");
    }
  }

  static Future<Publication> createPublication(int ownerId, Publication publication) async {
    final response = await http.post(
      Uri.parse("$API_URL/publication"), // api/publication POST
      body: publication.toMap()
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final responseData = jsonDecode(response.body);
      Publication pub = Publication.fromMap(responseData as Map<String, dynamic>);
      return pub;
    } else {
      throw new Exception("Failed to publy post");
    }
  }

  // SPECIAL FOR COMMENTS
  static Future<Comment?> commentPublication(int pubId, String comment) async {
    final response = await http.post(
      Uri.parse("$API_URL/publication/$pubId/comment"),
      body: jsonEncode({'content': comment})
    );

    if(200 <= response.statusCode && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);
      Comment com = Comment.fromMap(jsonResponse as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  static Future<List<Comment>> fetchComments(int pubId) async {
    final response = await http.post(
      Uri.parse("$API_URL/publication/$pubId/comments")
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final jsonResponse = jsonDecode(response.body);
      List<Comment> comments = List<Comment>.from(jsonResponse.map(
          (comm) => Comment.fromMap(comm as Map<String, dynamic>)
      ));
      return comments;
    } else {
      throw new Exception("Failed to fetch posts");
    }
  }

  // SPECIAL FOR REACTION
  static Future<Reaction> reactPublication(int pubId, String reaction) async {
    final response = await http.post(
      Uri.parse("$API_URL/publication/$pubId"),
      body: jsonEncode({'reaction': reaction, 'parentType': "publication"})
    );

    if(200 <= response.statusCode && response.statusCode < 300) {
      final responseData = jsonDecode(response.body);
      Reaction react = Reaction.fromMap(responseData as Map<String, dynamic>);
      return react;
    } else {
      throw new Exception("Failed to react comment");
    }
  }

  static Future<List<Reaction>> fetchReactions(int pubId) async {
    final response = await http.get(
      Uri.parse("$API_URL/publication/$pubId")
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final responseData = jsonDecode(response.body);
      List<Reaction> reactions = List<Reaction>.from(responseData.map(
        (react) => Reaction.fromMap(react as Map<String, dynamic>)
      ));
      return reactions;
    } else {
      throw new Exception("Failed to fetch reactions");
    }
  }

  static Future<Reaction> reactComment(int commentId, String reaction) async {
    final response = await http.post(
      Uri.parse("$API_URL/comment/$commentId/react"),
      body: {
        'reaction': reaction
      }
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final responseData = jsonDecode(response.body);
      Reaction react = Reaction.fromMap(responseData as Map<String, dynamic>);
      return react;
    } else {
      throw new Exception("Failed to react comment");
    }
  }

  // SPECIAL FOR DISCUSSION
  static Future<List<Message>> fetchMessages(int userId) async {
    final response = await http.get(
      Uri.parse("$API_URL/discussions/user/$userId"),
    );

    if(200 <= response.statusCode && response.statusCode < 300) {
      final responseData = jsonDecode(response.body);
      List<Message> messages = List<Message>.from(responseData.map(
        (mess) => Message.fromMap(responseData as Map<String, dynamic>))
      );
      return messages;
    } else {
      throw new Exception("Failed to fetch discussions");
    }
  }

  static Future<List<Message>> fetchMessageDetails(int userId, int otherUserId) async {
    final response = await http.get(
      Uri.parse("$API_URL/discussions/user/$userId/other/$otherUserId")
    );

    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final responseJson = jsonDecode(response.body);
      List<Message> messages = List<Message>.from(responseJson.map(
        (mess) => Message.fromMap(mess as Map<String, dynamic>)
      ));

      return messages;
    } else {
      throw new Exception("Failed to fetch discussions details");
    }
  }

  static Future<Message> sendMessage(int senderId, int destinationId, String message) async {
    final response = await http.post(
      Uri.parse("$API_URL/user/$senderId/destination/$destinationId")
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final responseJson = jsonDecode(response.body);
      Message message = Message.fromMap(responseJson as Map<String, dynamic>);
      return message;
    } else {
      throw new Exception("Failed to send message");
    }
  }

  // SPECIAL FOR USER
  static Future<User> fetchUserDetails(int userId) async {
    final response = await http.get(
      Uri.parse("$API_URL/user/$userId")
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final responseData = jsonDecode(response.body);
      User user = User.fromMap(responseData as Map<String, dynamic>);
      return user;
    } else {
      throw new Exception("Faild to fetch user");
    }
  }

}