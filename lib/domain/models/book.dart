import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/books_services.dart';

class Book {
  final String author;
  final String title;
  final String description;
  final String id;
  String? firebaseId;
  final String language;
  final String url;
  final dynamic rate;
  final String classEmotion;
  final String imageUrl;
  String usersFav;
  bool isFav = false;

  Book({
    required this.author,
    required this.title,
    required this.id,
    required this.description,
    this.firebaseId,
    required this.language,
    required this.url,
    required this.rate,
    required this.classEmotion,
    required this.imageUrl,
    required this.usersFav,
  });
  factory Book.fromJson(Map<String, dynamic> data) {
    final book = Book(
      description: data['description'],
      author: data['author'],
      title: data['title'],
      id: data['id'].toString(),
      language: data['lang'],
      url: data['url'] ?? 'amazon',
      rate: data['rate'] is double
          ? data['rate']
          : double.parse(data['rate'].toString()),
      classEmotion: data['class'],
      imageUrl: data['imageUrl'],
      usersFav: data['usersFav'] ?? '',
    );

    book.isFav = book.usersFav.contains('1,');
    return book;
  }
  void addToFavourite() async {
    //1 =>represent my id change to id change it.
    String tempUsersFav = usersFav;
    bool tempFav = isFav;
    try {
      if (usersFav.contains('1,')) {
        int firstIndex = usersFav.indexOf('1,');
        usersFav = usersFav.replaceRange(firstIndex, firstIndex + 2, '');
        isFav = false;
      } else {
        usersFav = usersFav + '1,';
        isFav = true;
      }
      await BooksServices.instance.updateOnBook(firebaseId!, usersFav);
    } catch (e) {
      isFav = tempFav;
      usersFav = tempUsersFav;
      return;
    }
  }
}
