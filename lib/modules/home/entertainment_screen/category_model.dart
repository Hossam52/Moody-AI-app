import 'package:moody_app/presentation/resources/values_manager.dart';

class CategoryModel {
  final String imagePath;
  final String name;

  final String imageUrl;
  final int id;
  CategoryModel(
      {required this.id,
      required this.imageUrl,
      required this.imagePath,
      required this.name});
}

List<CategoryModel> categories = [
  CategoryModel(
      id: 1,
      imageUrl: 'imageUrl',
      imagePath: ValuesManager.moviesImagePath,
      name: 'Movies'),
  CategoryModel(
      id: 2,
      imageUrl: 'imageUrl',
      imagePath: ValuesManager.booksImagePath,
      name: 'Books'),
  CategoryModel(
      id: 3,
      imageUrl: 'imageUrl',
      imagePath: ValuesManager.musicImagePath,
      name: 'Music'),
  // CategoryModel(
  //     id: 4,
  //     imageUrl: 'imageUrl',
  //     imagePath: 'assets/images/X.PNG',
  //     name: 'Clothes'),
  // CategoryModel(
  //     id: 5,
  //     imageUrl: 'imageUrl',
  //     imagePath: 'assets/images/song4.jpg',
  //     name: 'Clothes'),

  // CategoryModel(id: 3, imageUrl: 'imageUrl', name: 'songs'),
  // CategoryModel(id: 4, imageUrl: 'imageUrl', name: 'series'),
];
