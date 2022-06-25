import 'package:dd_blog_flutter/config/config.dart';
import 'package:dd_blog_flutter/models.dart';
import 'package:dd_js_util/api/base.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

class DetailPage extends ConsumerWidget {
  final PostData postData;

  const DetailPage({Key? key, required this.postData}) : super(key: key);

  @Doc(message: '跳转到详情页面')
  static Future<void> navTo(BuildContext context, PostData postData) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => DetailPage(
                  postData: postData,
                )));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(postData.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: MarkdownWidget(data: postData.content),
      ),
    );
  }
}
