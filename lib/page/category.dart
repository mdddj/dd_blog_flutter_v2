import 'package:dd_blog_flutter/model/category.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController ;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(categoryProvide);
    return Scaffold(
      appBar: AppBar(title: const Text("分类"),
      bottom: PreferredSize(preferredSize: const Size.fromHeight(48),
        child: TabBar(
          isScrollable: true,
          controller: _tabController, tabs: const [
          Tab(text: "按分类",),
          Tab(text: "按时间",),
          Tab(text: "按标签",)
        ],),
      ),
      ),
      body: result.when(data: (dataModal){
        return  TabBarView(controller: _tabController,children: [
          _CategoryList(list: dataModal.data.categoryList),
          _MonthsList(list: dataModal.data.monthsCounts),
          _TagList(list: dataModal.data.tags)
        ],);
      }, error: (err,s){return Text("$s");}, loading: ()=>const CircularProgressIndicator()) ,
    );
  }
}

///按分类展示
class _CategoryList extends StatelessWidget {
  final List<CategoryList> list;
  const _CategoryList({Key? key,required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      final item = list[index];
      return Container(
        color: Colors.white,
        child: ListTile(
          title: Text(item.name),
          trailing: const Icon(Icons.chevron_right,color: Colors.grey,),
        ),
      );
    },itemCount: list.length,);
  }
}




///按时间展示
class _MonthsList extends StatelessWidget {
  final List<MonthsCounts> list;
  const _MonthsList({Key? key,required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      final item = list[index];
      return Container(
        color: Colors.white,
        child: ListTile(
          title: Text(item.months),
          trailing: const Icon(Icons.chevron_right,color: Colors.grey,),
        ),
      );
    },itemCount: list.length,);
  }
}



///按标签展示
class _TagList extends StatelessWidget {
  final List<Tags> list;
  const _TagList({Key? key,required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      final item = list[index];
      return Container(
        color: Colors.white,
        child: ListTile(
          title: Text(item.name),
          trailing: const Icon(Icons.chevron_right,color: Colors.grey,),
        ),
      );
    },itemCount: list.length,);
  }
}
