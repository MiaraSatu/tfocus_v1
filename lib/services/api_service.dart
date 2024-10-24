import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:tfocus_v_common_2/models/like.dart';
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
    Publication(id: 1, title: "The first publication", content: "Ca va être difficile d'expliquer comment je me trouve dans cet état",
    file: "images/externalisation-de-la-paie.jpg", owner: users[2], date: "22-12-24", likeCount: 24),
    Publication(id: 2, title: "La raison de vivre", content: "Je vais vous expliquer dans un instant comment ça va se passer si vous ne savez pas encore pourquoi vous êtes nés",
    file: "images/avatars/old_man.jpg", owner: users[1], likeCount: 138, date: "23-10-24"),
    Publication(id: 3, link: "https://facebook.com/MiaraSatu", file: "https://facebook.com/MiaraSatu/profilePicture", likeCount: 3, owner: users[0], date: "25-10-24"),
    Publication(id: 4, link: "https://mirabella.hgc/green-day-and-pink-day", file: "https://mirabella.hgc/event/gdpd.png", date: "28-10-24")
  ];

  static List<Comment> comments = [
    Comment(id: 1, content: "Je suis ravi de pouvoir rejoindre votre communauté", publication: publications[1], owner: users[2]),
    Comment(id: 2, content: "Merci, vous êtes tous des bonnes personnes", publication: publications[1], owner: users[3]),
    Comment(id: 3, content: "Je suis ravi de pouvoir rejoindre votre communauté", publication: publications[1], owner: users[2]),
    Comment(id: 4, content: "Merci, vous êtes tous des bonnes personnes", publication: publications[1], owner: users[3]),
  ];

  /*
  * Liste des routes utiles:
  *
  * */
  static String BASE_URL = 'http://192.168.249.83:8000/';
  static String API_URL = BASE_URL+'api';

  static Map<String, String> HEADERS = {
    'Cache-Control': 'no-cache',
    'Pragma': 'no-cache',
    'Expires': '0',
  };

  // SPECIAL FOR PUBLICATION
  static Future<List<Publication>> fetchPublications() async {
    // return publications;
    final response = await http.get(
      Uri.parse(API_URL+"/publications/"),
      headers: HEADERS// localhost:8000/api/publications
    );

    if(200 <= response.statusCode && response.statusCode < 300) {
      // return publications;
      final responseData = jsonDecode(response.body);
      List<Publication> pubs = List<Publication>.from(responseData.map(
        (pubMap) => Publication.fromMap(pubMap as Map<String, dynamic>)
      ));
      return pubs;
    } else {
      print(response.body);
      throw new Exception("Failed to fetch publications");
    }
  }

  static Future<Publication> fetchPublicationDetails(int pubId) async {
    // return publications[2];
    final response = await http.get(
      Uri.parse("$API_URL/publication/$pubId/")
    );
    if(200 <= response.statusCode && response.statusCode < 300) {
      final responseData = jsonDecode(response.body);
      Publication pub = Publication.fromMap(responseData as Map<String, dynamic>);
      return pub;
    } else {
      print("errrrrrroooooooorrr:"+response.body);
      print("status"+response.statusCode.toString());
      throw new Exception("Problem occured! publication not loaded");
    }
  }

  static Future<bool> createPublication(int ownerId, Map<String, dynamic> publication) async {
    final response = await http.post(
      Uri.parse("$API_URL/publication/"), // api/publication POST
      body: publication
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {

      print(response.body);
      /*
      final responseData = jsonDecode(response.body);
      Publication pub = Publication.fromMap(responseData as Map<String, dynamic>);
      return pub;
      */
      return true;
    } else {
      print("erreur du serveur:"+response.body);
      // throw new Exception("Failed to publy post");
      return false;
    }
  }

  static Future<List<Publication>> fetchPublicationsWithFilter(String filter, int userId) async {
    final response = await http.get(
      Uri.parse("$API_URL/user/$userId/publications/$filter")
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final responseData = jsonDecode(response.body);
      List<Publication> publications = List<Publication>.from(responseData.map(
          (pub) => Publication.fromMap(pub as Map<String, dynamic>)
      ));
      return publications;
    } else {
      throw Exception("Failed to ");
    }
  }

  static Future<List<Publication>> searchPublications(String q) async {
    final response = await http.get(
      Uri.parse("$API_URL/search/$q")
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final responseData = jsonDecode(response.body);
      List<Publication> result = List<Publication>.from(responseData.map(
          (res) => Publication.fromMap(res as Map<String, dynamic>)
      ));
      return result;
    } else {
      throw Exception("Failed to fetch: " + response.body);
    }
  }

  static Future<List<Publication>> fetchPublicationsByUser(int userId) async {
    // return publications;
    final response = await http.get(
      Uri.parse("$API_URL/user/$userId/publications/"),
    );
    int status = response.statusCode;

    if(200 <= status && status < 300) {
      final responseData = jsonDecode(response.body);
      print("BODY: "+response.body);
      List<Publication> pubs = List<Publication>.from(responseData.map(
          (pub) => Publication.fromMap(pub as Map<String, dynamic>)
      ));
      return pubs;
    } else {
      throw Exception("ERRORRRRRR: Failed to fetch users's publications");
    }
  }

  // SPECIAL FOR COMMENTS
  static Future<bool> commentPublication(int pubId, String comment) async {
    final response = await http.post(
      Uri.parse("$API_URL/publication/$pubId/comment/"),
      body: jsonEncode({'content': comment}),
      headers: {"Content-Type": "application/json"}
    );

    if(200 <= response.statusCode && response.statusCode < 300) {
      /*
        final jsonResponse = jsonDecode(response.body);
        Comment com = Comment.fromMap(jsonResponse as Map<String, dynamic>);
       */
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Comment>> fetchComments(int pubId) async {
    // return comments;
    final response = await http.post(
      Uri.parse("$API_URL/publication/$pubId/comments/")
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

  // SPECIAL FOR LIKE
  static Future<bool> likePublication(int pubId) async {
    final response = await http.post(
      Uri.parse("$API_URL/publication/$pubId/like/"),
      body: jsonEncode({'publication':pubId})
    );
    if(200 <= response.statusCode && response.statusCode < 300) {
      /*
      final responseData = jsonDecode(response.body);
      Like react = Like.fromMap(responseData as Map<String, dynamic>);
      return react;
       */
      return true;
    } else {
      return false;
      // throw new Exception("Failed to react comment");
    }
  }

  static Future<List<Like>> fetchReactions(int pubId) async {
    final response = await http.get(
      Uri.parse("$API_URL/publication/$pubId/")
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final responseData = jsonDecode(response.body);
      List<Like> reactions = List<Like>.from(responseData.map(
        (react) => Like.fromMap(react as Map<String, dynamic>)
      ));
      return reactions;
    } else {
      throw new Exception("Failed to fetch reactions");
    }
  }

  static Future<Like> reactComment(int commentId, String reaction) async {
    final response = await http.post(
      Uri.parse("$API_URL/comment/$commentId/react/"),
      body: {
        'reaction': reaction
      }
    );
    int status = response.statusCode;
    if(200 <= status && status < 300) {
      final responseData = jsonDecode(response.body);
      Like react = Like.fromMap(responseData as Map<String, dynamic>);
      return react;
    } else {
      throw new Exception("Failed to react comment");
    }
  }

  // SPECIAL FOR DISCUSSION
  static Future<List<Message>> fetchMessages(int userId) async {
    final response = await http.get(
      Uri.parse("$API_URL/discussions/user/$userId/"),
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
      Uri.parse("$API_URL/discussions/user/$userId/other/$otherUserId/")
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
      Uri.parse("$API_URL/user/$senderId/destination/$destinationId/")
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
      Uri.parse("$API_URL/user/$userId/")
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