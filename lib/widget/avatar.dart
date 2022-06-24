
import 'package:flutter/material.dart';

//头像
class Avatar extends StatelessWidget {
  final double? size;
  const Avatar({Key? key,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.asset('assets/images/avatar.jpeg',width:size ?? 20,height:size ?? 20,),
    );
  }
}
