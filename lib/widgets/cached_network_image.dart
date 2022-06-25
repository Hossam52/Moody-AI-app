import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget(
      {Key? key, required this.imageUrl, required this.width, this.fit=BoxFit.cover})
      : super(key: key);
  final String imageUrl;
  final double width;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(
        value: downloadProgress.progress,
        color: Colors.white,
      )),
      errorWidget: (context, url, error) => Center(
        child: Icon(
          Icons.error,
          size: 25.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
