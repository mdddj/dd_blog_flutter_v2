import 'package:dd_blog_flutter/api.dart';
import 'package:dd_blog_flutter/config/config.dart';
import 'package:dd_blog_flutter/models.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

final textProvider = FutureProvider.family.autoDispose<TextModelResult?, String>((ref, String key) async {
  return await TextApi.doRequest(key);
});

///字典页面
class TextPage extends ConsumerWidget {
  final String keyName;
  final String? title;

  const TextPage({Key? key, required this.keyName, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(textProvider(keyName));
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? '标题'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: model.when(
            data: (v) {
              if (v == null) {
                return const Text('无数据');
              }
              return MarkdownWidget(data: v.data.context);
            },
            error: (e, s) => Text('$s'),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
