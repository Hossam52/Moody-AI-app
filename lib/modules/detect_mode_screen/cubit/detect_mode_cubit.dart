import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody_app/presentation/resources/constant_values_manager.dart';
import 'package:moody_app/shared/network/locale/cache_helper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
part 'detect_mode_state.dart';

class DetectModeCubit extends Cubit<DetectModeState> {
  DetectModeCubit() : super(DetectModeInitial());
  static DetectModeCubit get(context) => BlocProvider.of(context);
  Future<File?> testCompressAndGetFile(File file) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.' +
        'jpeg';
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      tempPath,
      quality: 80,
    );
    log('compress');
    log(file.lengthSync().toString());
    log(result!.lengthSync().toString());

    return result;
  }

  void detectMode(File image) async {
    // File file = File(r'D:\Work\Projects\GP\Multi Modal Emotion Recognition\API\dart_application_1\bin\2.jpg');
    emit(DetectModeLoading());
    try {
      final Dio dio = Dio();
      File? file = await testCompressAndGetFile(image);
      List<int> imageBytes = file!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      log(base64Image);
      Map<String, String> postBody = {"img": base64Image};
      final response = await dio.postUri(
          Uri.parse('https://evening-ridge-42710.herokuapp.com/'),
          data: postBody,
          options: Options(
            headers: {"Content-type": "application/json"},
            sendTimeout: 60 * 1000,
            receiveDataWhenStatusError: true,
            receiveTimeout: 60 * 1000,
          ),
          onSendProgress: (s, w) {});

      log('Response');
      await CacheHelper.saveDate(key: moodKey, value: response.data);
      //my mood
      myMood = response.data;
      log(response.data.toString());
      emit(DetectModeSuccess('Your mode is $myMood'));
    } catch (e) {
      emit(DetectModeError());
      rethrow;
    }
  }
}
