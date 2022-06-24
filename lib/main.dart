import 'package:dd_check_plugin/dd_check_plugin.dart';
import 'package:dd_js_util/api/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BaseApi.host = "https://itbug.shop";
  DdCheckPlugin.instance.init(BaseApi.getDio());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      builder: FlutterSmartDialog.init(),
    );
  }
}
