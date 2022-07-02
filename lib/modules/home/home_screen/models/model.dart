import 'package:moody_app/modules/home/home_screen/entities/simple_entity.dart';

class SimpleModel extends SimpleEntity 
{
  const SimpleModel({required String image, required String url})
      : super(image: image, url: url);
  factory SimpleModel.fromJson(Map<String, dynamic> data) 
  {
    return SimpleModel(image: data['imageUrl'], url: data['url']??data['trailer_url']);
  }
}
