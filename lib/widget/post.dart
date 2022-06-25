

import 'package:dd_blog_flutter/config/config.dart';
import 'package:dd_blog_flutter/page/detail.dart';
import 'package:dd_js_util/api/base.dart';
import 'package:flutter/material.dart';

import '../models.dart';
import 'avatar.dart';

///博客列表组件
class PostDataWidget extends StatelessWidget {
  final PostData postData;
  const PostDataWidget(this.postData,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const subStringStyle = TextStyle(fontSize: 11,color: Colors.grey);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(postData.title),

            const SizedBox(height: 10,),

            Row(children: [
              const Avatar(size: 25,),
              const SizedBox(width: 6),
              Text(postData.author,style: subStringStyle),
              const SizedBox(width: 6,),
              Text(postData.dateString,style: subStringStyle)
            ],),

            const SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.folder_copy_outlined,size: 15,),
                    const SizedBox(width: 3,),
                    Text(postData.category.name,style: const TextStyle(fontSize: 12),),
                  ],
                ),),
              
              const Text("继续阅读 >",style: TextStyle(fontSize: 12),)
            ],)
          ],
        ),
      ),
    ).click(() {
      DetailPage.navTo(context, postData);
    });
  }
}
