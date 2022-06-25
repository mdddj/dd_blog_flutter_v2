


import 'package:dd_js_util/api/base.dart';
import 'package:logger/logger.dart';

const kDefaultPadding = 12.0;

@Doc(message: '日志打印')
void myPrint(dynamic msg){
  Logger().d(msg);
}