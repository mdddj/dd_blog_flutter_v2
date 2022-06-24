import 'package:dd_blog_flutter/config/config.dart';
import 'package:dd_blog_flutter/widget/avatar.dart';
import 'package:flutter/material.dart';
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
                  children:const [
                    Avatar(size: 100,),
                    SizedBox(height: 30,),
                    Text("典典博客",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    SizedBox(height: 30,),
                    Text("Flutter开发工程师,主要使用语言: Flutter,Dart,Java,Koltin,Typescript等等,目前在广州一家公司做全职Flutter开发",textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.grey
                    ),)
                  ],
                ),
              ),


              //统计信息
              StatisticsComponent()
            ],
          ),
        ),
      ),
    );
  }

}


class StatisticsComponent extends ConsumerWidget {
  const StatisticsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: GridView.count(crossAxisCount: 4,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),children: [
        _renderItem("博客","0",Icons.file_copy_outlined,Colors.orange),
        _renderItem("分类","1",Icons.category,Colors.blue),
        _renderItem("标签","2",Icons.tag,Colors.green),
        _renderItem("友链","3",Icons.link,Colors.greenAccent),
      ],),
    );
  }

  Widget _renderItem(String title,String value,IconData iconData,Color valueColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text(value,style: TextStyle(color: valueColor,fontSize: 28,fontWeight: FontWeight.bold),),
      const SizedBox(height: 5,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData,size: 14,color: Colors.grey,),
          const SizedBox(width: 2,),
          Text(title,style: TextStyle(color: Colors.grey),),
        ],
      )
    ],);
  }

}