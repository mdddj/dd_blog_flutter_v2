import 'package:dd_blog_flutter/config/config.dart';
import 'package:dd_blog_flutter/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api.dart';
import '../config/design.dart';
import '../widget/post.dart';

const _kPageSize = 10;

enum MyListType { tag, month, category }

final pageStateProvider = StateProvider<int>((ref) => 1);
final postsState = StateProvider<List<PostData>>((ref) => []);

class PostListComponents extends ConsumerStatefulWidget {
  final String? title;
  final PostListBaseApi api;
  final MyListType type;
  final String paramValue;

  const PostListComponents({Key? key, this.title, required this.api, required this.type, required this.paramValue}) : super(key: key);

  //tag导航
  static Future<void> navWithTag(BuildContext context, String tagId, {String? title}) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PostListComponents(
                  paramValue: tagId,
                  type: MyListType.tag,
                  api: PostListBaseApi.tagApi,
                  title: title,
                )));
  }

  //月份导航
  static Future<void> navWithMonth(BuildContext context, String month, {String? title}) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PostListComponents(
                  paramValue: month,
                  type: MyListType.month,
                  api: PostListBaseApi.monthApi,
                  title: title,
                )));
  }

  //分类导航
  static Future<void> navWithCategory(BuildContext context, String categoryId, {String? title}) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PostListComponents(
                  paramValue: categoryId,
                  type: MyListType.category,
                  api: PostListBaseApi.categoryApi,
                  title: title,
                )));
  }

  @override
  ConsumerState createState() => _PostListComponentsState();
}

class _PostListComponentsState extends ConsumerState<PostListComponents> implements PostDataListPageDesign {
  final EasyRefreshController _easyRefreshController = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      //设置默认为第一页
      ref.read(pageStateProvider.notifier).state = 1;
      ref.read(postsState.notifier).state = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "博客列表"),
      ),
      body: EasyRefresh.custom(
          header: MaterialHeader(),
          footer: MaterialFooter(),
          controller: _easyRefreshController,
          firstRefresh: true,
          onRefresh: refresh,
          onLoad: loadNextPage,
          slivers: [SliverList(delegate: SliverChildBuilderDelegate(_renderItem, childCount: ref.watch(postsState).length))]),
    );
  }

  Widget _renderItem(BuildContext context, int index) {
    final item = ref.read(postsState)[index];
    return PostDataWidget(item);
  }

  int get _currentPage => ref.read(pageStateProvider);

  List<PostData> get _postData => ref.read(postsState);

  @override
  Future<List<PostData>> initPost() async {
    final api = widget.api
      ..pageSize = _kPageSize
      ..page = _currentPage;
    switch (widget.type) {
      case MyListType.tag:
        api.tagId = widget.paramValue;
        break;
      case MyListType.category:
        api.categoryId = widget.paramValue;
        break;
      case MyListType.month:
        api.month = widget.paramValue;
        break;
      default:
        break;
    }
    final result = await api.request(showDefaultLoading: false);
    if (result == null) return [];
    final model = IndexPostResultJson.fromJson(result);
    _easyRefreshController.finishLoad(success: true, noMore: model.data.page.paged);
    return model.data.list;
  }

  @override
  Future<void> loadNextPage() async {
    myPrint('加载下一页');
    ref.read(pageStateProvider.notifier).state = _currentPage + 1;
    final posts = await initPost();
    ref.read(postsState.notifier).state = [..._postData, ...posts];
  }

  @override
  Future<void> refresh() async {
    ref.read(pageStateProvider.notifier).state = 1;
    ref.read(postsState.notifier).state.clear();
    final posts = await initPost();
    ref.read(postsState.notifier).state = posts;
  }
}
