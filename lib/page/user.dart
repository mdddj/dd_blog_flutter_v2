import 'package:dd_blog_flutter/config/config.dart';
import 'package:dd_blog_flutter/page/text.dart';
import 'package:dd_blog_flutter/widget/avatar.dart';
import 'package:dd_js_util/ext/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserPage extends ConsumerWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //头部导航区域
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(kDefaultPadding * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Avatar(
                      size: 100,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "典典博客",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Flutter开发工程师,主要使用语言: Flutter,Dart,Java,Koltin,Typescript等等,目前在广州一家公司做全职Flutter开发",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),

              //统计信息
              const StatisticsComponent(),
              _renderMenus(context),

              const SizedBox(height: kDefaultPadding),
              ElevatedButton(
                  onPressed: () {
                    'https://github.com/mdddj/dd_blog_flutter_v2'.browser();
                  },
                  child: const Text('APP开源地址'))
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderMenus(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          _renderMenuItem('ds.svg', '打赏', context, keyName: 'blog-ds'),
          _renderMenuItem('github.svg', 'Github', context, keyName: 'github'),
          _renderMenuItem('photo.svg', '相册', context, keyName: 'images'),
          _renderMenuItem('about.svg', '关于', context, keyName: 'about')
        ],
      ),
    );
  }

  ///渲染菜单item
  Widget _renderMenuItem(String svgName, String title, BuildContext context, {String? keyName}) {
    return ListTile(
      leading: SvgPicture.asset(
        'assets/svgs/$svgName',
        width: 20,
        height: 20,
        color: Colors.grey,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.blueGrey),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: keyName == null
          ? null
          : () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TextPage(
                            keyName: keyName,
                            title: title,
                          )));
            },
    );
  }
}

class StatisticsComponent extends ConsumerWidget {
  const StatisticsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _renderItem("博客", "0", Icons.file_copy_outlined, Colors.orange),
          _renderItem("分类", "1", Icons.category, Colors.blue),
          _renderItem("标签", "2", Icons.tag, Colors.green),
          _renderItem("友链", "3", Icons.link, Colors.greenAccent),
        ],
      ),
    );
  }

  Widget _renderItem(String title, String value, IconData iconData, Color valueColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(color: valueColor, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 14,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
