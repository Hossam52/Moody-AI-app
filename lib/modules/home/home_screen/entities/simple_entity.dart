import 'package:equatable/equatable.dart';
class SimpleEntity  extends Equatable{
  final String url;
  final String image;
  const SimpleEntity({required this.image, required this.url});

  @override
  List<Object?> get props => [url,image];
}
