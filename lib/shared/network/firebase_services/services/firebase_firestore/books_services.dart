import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moody_app/domain/enums/emotions.dart';
import 'package:moody_app/domain/models/book.dart';
import 'package:moody_app/domain/models/models.dart';
import 'package:moody_app/presentation/resources/constant_values_manager.dart';

import 'fire_firestore.dart';

class BooksServices {
  BooksServices._();
  static BooksServices get instance => BooksServices._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void addBook(Book book)  
  {
    _firestore.collection(FireStorePaths.booksPath).add(
      {
      'description':book.description,
      'author':book.author,
      'title':book.title,
      'id':DateTime.now().millisecondsSinceEpoch.toString(),
      'lang':book.language=='en'?'English':book.language,
      'url':book.url,
      'rate':book.rate,
      'class':book.classEmotion,
      'imageUrl':book.imageUrl,
      });
  }

  Future<void> createInpirationItem(Inspiration inspirationModel) async {
    _firestore
        .collection(FireStorePaths.booksPath)
        .doc(inspirationModel.id)
        .set(inspirationModel.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllBooks() {
    //class represent my mood
    if (myMood == emotions.happy.name || myMood == emotions.sad.name) {
      return _firestore
          .collection(FireStorePaths.booksPath)
          .where(
            'class',
            isEqualTo: myMood,
          )
          .snapshots();
    }
    return _firestore.collection(FireStorePaths.booksPath).snapshots();
  }
  Stream<QuerySnapshot<Map<String,dynamic>>>getAllBooksFav()
  {
    return  _firestore.collection(FireStorePaths.booksPath).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBestBooks() {
    switch (myMood) {
      case 'angry': //get rid of angry
      case 'disgust': //disgust
      case 'fear': //get rid of fear
      case 'neutral':
      case 'surprise':
        return _firestore
            .collection(FireStorePaths.booksPath)
            .where(
              'rate',
              isGreaterThan: "3.5",
            )
            .snapshots();
      default:
        //happy
        //sad
        return _firestore
            .collection(FireStorePaths.booksPath)
            .where('class', isEqualTo: myMood)
            .where(
              'rate',
              isGreaterThan: "3.5",
            )
            .snapshots();
    }
  }

  Future<void> updateOnBook(String id, String fav) async {
    await _firestore.collection(FireStorePaths.booksPath).doc(id).update({
      'usersFav': fav,
    });
  }
}
