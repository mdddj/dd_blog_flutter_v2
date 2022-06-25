import 'package:dd_blog_flutter/page/category.dart';
import 'package:dd_blog_flutter/page/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          BottomNavigationBarItem(icon: NavSvg(svgName: 'home.svg',), label: "首页"),
          BottomNavigationBarItem(icon:  NavSvg(svgName: 'cate.svg',), label: "归档"),
          BottomNavigationBarItem(icon:  NavSvg(svgName: 'me.svg',), label: "用户")
        ],
        onTap: (int i) {
          ref.read(homeCurrentProvider.notifier).state = i;
        },
        currentIndex: currentIndex,
      ),
    );
  }
}


class NavSvg extends StatelessWidget {
  final String svgName;
  const NavSvg({Key? key,required this.svgName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/svgs/$svgName',width: 20,height: 20,);
  }
}
