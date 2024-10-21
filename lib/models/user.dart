class User {
  final String uid;
  final String email;
  final String firstName;
  final String profilePicUrl;
  final List<String> favoriteTopics;

  User({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.profilePicUrl,
    required this.favoriteTopics,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      email: data['email'],
      firstName: data['firstName'],
      profilePicUrl: data['profilePicUrl'],
      favoriteTopics: List<String>.from(data['favoriteTopics']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'profilePicUrl': profilePicUrl,
      'favoriteTopics': favoriteTopics,
    };
  }
}