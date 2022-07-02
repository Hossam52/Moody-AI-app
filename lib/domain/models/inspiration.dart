import 'dart:convert';

class Inspiration {
  String? id;
  String text;
  String date;
  String userName;
  String userId;
  String? userPic;
  String mood;
  String? imagePost;
  int likes;
  Inspiration({
    required this.id,
    required this.text,
    required this.date,
    required this.userName,
    required this.userId,
    required this.userPic,
    required this.mood,
    required this.likes,
    this.imagePost,
  });
  Inspiration.createNewInspirationn({
    required this.text,
    required this.date,
    required this.userName,
    required this.userId,
    required this.userPic,
    required this.mood,
    this.imagePost,
  }) : likes = 0;
  void toggleLike(bool isIncrease) {
    if (isIncrease) {
      likes++;
    } else {
      likes--;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'date': date,
      'userName': userName,
      'userId': userId,
      'userPic': userPic,
      'mood': mood,
      'likes': likes,
      'imagePost':imagePost,
    };
  }

  factory Inspiration.fromMap(Map<String, dynamic> map) {
    return Inspiration(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      date: map['date'] ?? '',
      userName: map['userName'] ?? '',
      userId: map['userId'] ?? '',
      userPic: map['userPic'] ?? '',
      mood: map['mood'] ?? '',
      likes: map['likes']?.toInt() ?? 0,
      imagePost: map['imagePost'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Inspiration.fromJson(String source) =>
      Inspiration.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Inspiration(id: $id, text: $text, date: $date, userName: $userName, userId: $userId, userPic: $userPic, mood: $mood, likes: $likes)';
  }
}
