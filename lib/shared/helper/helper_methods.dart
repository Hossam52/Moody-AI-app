import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moody_app/modules/profiles/friend_profile.dart';
import 'package:moody_app/modules/profiles/my_profile_screen.dart';
import 'package:moody_app/presentation/resources/color_manager.dart';
import 'package:moody_app/presentation/resources/font_manager.dart';
import 'package:moody_app/presentation/resources/navigation_manager.dart';
import 'package:moody_app/presentation/resources/styles_manager.dart';
import 'package:moody_app/presentation/resources/values_manager.dart';
import 'package:moody_app/shared/cubits/app_cubit/app_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

void closeKeyboard(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<File?> getImage({
  ImageSource source = ImageSource.camera,
}) async {
  ImagePicker _picker = ImagePicker();

  final image = await _picker.pickImage(
    source: source,
  );
  if (image != null) return File(image.path);
  return null;
}

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatStringDate(String stringDate) {
  final date = DateTime.tryParse(stringDate) ?? DateTime.now();
  return formatDate(date);
}

void showSnackBar({
  required BuildContext context,
  required String text,
  Color backgroundColor = Colors.red,
}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(text),
      backgroundColor: backgroundColor,
    ),
  );
}

double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

double getWidthFraction(BuildContext context, double ratio) =>
    getWidth(context) * ratio;
double getHeightFraction(BuildContext context, double ratio) =>
    getHeight(context) * ratio;

void navigateToProfile(BuildContext context, String profileId) {
  final user = AppCubit.get(context).getUser;
  if (user.id == profileId) {
    navigateTo(context, const MyProfileScreen());
  } else {
    navigateTo(context, FriendProfile(userId: profileId));
  }
}

Future<File?> testCompressAndGetFile(File file, {int? quality}) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path +
      '/' +
      DateTime.now().millisecondsSinceEpoch.toString() +
      '.' +
      'jpeg';
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    tempPath,
    quality: quality ?? 80,
  );
  log('compress');
  log(file.lengthSync().toString());
  log(result!.lengthSync().toString());

  return result;
}
