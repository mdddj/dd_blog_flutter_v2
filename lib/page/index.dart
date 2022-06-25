import 'package:dd_blog_flutter/model/index.dart';
import 'package:dd_js_util/api/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/post.dart';

@Doc(message: "首页")
class IndexPage extends ConsumerStatefulWidget {
  const IndexPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _IndexPageState();
}

class _IndexPageState extends ConsumerState<IndexPage> {
  final EasyRefreshController _easyRefreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(indexProvider).postData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("首页"),
      ),
      body: EasyRefresh.custom(
        firstRefresh: true,
          header: MaterialHeader(),
          footer: MaterialFooter(),
          controller: _easyRefreshController,
          onLoad: _nextPage,
          onRefresh: _refresh,
          slivers: [SliverList(delegate: SliverChildBuilderDelegate((context, index) => PostDataWidget(posts[index]), childCount: posts.length))]),
    );
  }

  @Doc(message: '加载下一页')
  Future<void> _nextPage() async {
    final hasNextPage = await ref.read(indexProvider.notifier).nextPageLoad();
    _easyRefreshController.finishLoad(success: true, noMore: hasNextPage);
  }

  @Doc(message: '刷新数据')
  Future<void> _refresh() async {
    final hasNextPage = await ref.read(indexProvider.notifier).refresh();
    _easyRefreshController.finishRefresh(success: true, noMore: hasNextPage);
  }
}
