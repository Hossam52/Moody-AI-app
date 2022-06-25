import 'package:flutter/material.dart';
import 'package:moody_app/widgets/loading_widget.dart';

class LoadMoreData extends StatelessWidget {
  const LoadMoreData(
      {Key? key, required this.onLoadingMore, this.isLoading = false})
      : super(key: key);
  final VoidCallback onLoadingMore;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onLoadingMore,
      child: isLoading ? const LoadingWidget() : const Text('Show more'),
    );
  }
}
