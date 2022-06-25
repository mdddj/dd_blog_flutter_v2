import 'package:dd_blog_flutter/api.dart';
import 'package:dd_js_util/api/base.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models.dart';

const pageSize = 10;

final indexProvider = StateNotifierProvider<IndexModelProvider, IndexState>((ref) => IndexModelProvider());

class IndexModelProvider extends StateNotifier<IndexState> {
  IndexModelProvider() : super(IndexState(postData: [], page: 1));

  Future<bool> loadData({int? page}) async {
    final result = await PostListApi.doRequest(page ?? 1, pageSize,);
    if (result == null) {
      return false;
    }
    final model = IndexPostResultJson.fromJson(result);
    final datas = state.postData;
    datas.addAll(model.data.list);
    state = state.copyWith(postData: datas, p: page);
    return model.data.page.paged;
  }

  @Doc(message: '加载下一页,返回值表示是否还要下一页数据')
  Future<bool> nextPageLoad() async {
    final nextPage = state.page + 1;
    return await loadData(page: nextPage);
  }

  @Doc(message: '刷新博客列表')
  Future<bool> refresh() async {
    state = IndexState(postData: [], page: 1);
    return await loadData();
  }
}

class IndexState with EquatableMixin {
  List<PostData> postData = [];
  int page = 1;

  IndexState({required this.postData, required this.page});

  IndexState copyWith({List<PostData>? postData, int? p}) => IndexState(
        postData: postData ?? [],
        page: p ?? page,
      );

  @override
  List<Object?> get props => [postData];
}
