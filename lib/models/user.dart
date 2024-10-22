class User {
  final int id;
  final String email;
  final String firstName;
  final String? profilePicUrl;
  final List<String> favoriteTopics;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    this.profilePicUrl,
    required this.favoriteTopics,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      email: data['email'],
      firstName: data['firstName'],
      profilePicUrl: data['profilePicUrl'],
      favoriteTopics: List<String>.from(data['favoriteTopics']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'profilePicUrl': profilePicUrl,
      'favoriteTopics': favoriteTopics,
    };
  }
}