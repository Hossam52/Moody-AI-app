
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moody_app/domain/models/models.dart';
import 'package:moody_app/shared/network/firebase_services/services/firebase_firestore/inspiration_services.dart';

class InspirationData {
  List<Inspiration>? _inspirationItems;
  QueryDocumentSnapshot<Map<String, dynamic>>?
      _lastRecentInspiration; //To get the next posts

  List<Inspiration> get inspirationItems => _inspirationItems ?? [];
  QueryDocumentSnapshot<Map<String, dynamic>>? get lastItem =>
      _lastRecentInspiration;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;
  void setData(QuerySnapshot<Map<String, dynamic>> allData) {
    final allDocs = allData.docs.map((e) {
      return Inspiration.fromMap(e.data());
    }).toList();
    if (allDocs.isEmpty || allDocs.length != paginationSize) _isLastPage = true;
    if (_inspirationItems == null) {
      _inspirationItems = allDocs;
    } else {
      _inspirationItems!.addAll(allDocs);
    }
    //For saving last item and use in pagination
    if (allDocs.isNotEmpty) _lastRecentInspiration = allData.docs.last;
  }

  void insertItem(Inspiration post, int position) {
    _inspirationItems?.insert(position, post);
  }
}

class FollowingInspirationData extends InspirationData {
  final int _maxFilterElements = 10;
  int _partitionNumber = 1;
  List<String>? _followingItems;
  set setFollowingList(List<String> items) {
    _followingItems ??= items;
  }

  int _from = 0;
  bool get fetchNewList {
    return _isLastPostsPage;
  }

  int get to {
    if (_from + _maxFilterElements > _followingItems!.length) {
      return _followingItems!.length;
    }
    return _from + _maxFilterElements;
  }

  List<String> get getCurrentSubList {
    return _followingItems!.sublist(_from, to);
  }

  bool _isLastPostsPage = false;
  @override
  bool get isLastPage {
    if (_followingItems != null &&
        (_followingItems!.isEmpty ||
            _isLastPostsPage && _from >= _followingItems!.length)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void setData(QuerySnapshot<Map<String, dynamic>> allData) {
    if (allData.docs.length < paginationSize) {
      _partitionNumber++;
      _from = to;
      _isLastPostsPage = true;
    } else {
      _isLastPostsPage = false;
    }
    super.setData(allData);
  }
}
