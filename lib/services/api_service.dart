import 'dart:convert';

import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:tfocus_v_common_2/models/reaction.dart';
import 'package:tfocus_v_common_2/models/message.dart';

class ApiService {
  /*
  * Liste des routes utiles:
  *
  * */
  static String BASE_URL = 'http://localhost:8000/';
  static String API_URL = BASE_URL+'/api';

  // SPECIAL FOR PUBLICATION
  static Future<List<Publication>> fetchPublications() async {
    final response = await http.get(
      Uri.parse(API_URL+"/publications")
    );

    if(200 <= response.statusCode && response.statusCode < 300) {
      final responseData = jsonDecode(response.body);
      List<Publication> pubs = List<Publication>.from(responseData.map(
        (pubMap) => Publication.fromMap(pubMap as Map<String, dynamic>)
      ));
      return pubs;
    } else {
      throw new Exception("Problem occured! Publications not loaded");
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
      Uri.parse("$API_URL/user/$ownerId/publication"),
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
      throw new Exception("Lost to react comment");
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
      throw new Exception("Error to fetch discussions");
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
      throw new Exception("Faild to fetch discussions details");
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

}