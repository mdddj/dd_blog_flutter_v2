import 'package:dd_blog_flutter/page/category.dart';
import 'package:dd_blog_flutter/page/user.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'page/index.dart';


final homeCurrentProvider = StateProvider<int>((ref) => 0);


class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeCurrentProvider);
    return Scaffold(
      body: IndexedStack(
        index:currentIndex,
        children: const [IndexPage(), CategoryPage(), UserPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "归档"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "用户")
        ],
        onTap: (int i) {
          ref.read(homeCurrentProvider.notifier).state = i;
        },
        currentIndex: currentIndex,
      ),
    );
  }
}
