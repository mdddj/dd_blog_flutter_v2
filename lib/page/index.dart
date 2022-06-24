import 'package:dd_blog_flutter/model/index.dart';
import 'package:dd_js_util/api/base.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    ref.read(indexProvider.notifier).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(indexProvider).postData;
    return Scaffold(
      appBar: AppBar(title: const Text("首页"),),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return PostDataWidget(posts[index]);
      },itemCount: posts.length,),
    );
  }
}

