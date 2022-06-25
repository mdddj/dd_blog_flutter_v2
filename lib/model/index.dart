import 'package:dd_blog_flutter/api.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models.dart';

const pageSize = 10;

final indexProvider = StateNotifierProvider<IndexModelProvider, IndexState>((ref) => IndexModelProvider());

class IndexModelProvider extends StateNotifier<IndexState> {
  IndexModelProvider() : super(IndexState(postData: []));

  Future<void> loadData({int? page}) async {
    final result = await PostListApi.doRequest(page ?? 1, pageSize);
    if (result == null) {
      return;
    }
    final model = IndexPostResultJson.fromJson(result);
    final datas = state.postData;
    datas.addAll(model.data.list);
    state = state.copyWith(postData: datas);
  }
}

class IndexState with EquatableMixin {
  List<PostData> postData = [];
  IndexState({required this.postData});

  IndexState copyWith({List<PostData>? postData}) => IndexState(postData: postData ?? []);

  @override
  List<Object?> get props => [postData];
}
