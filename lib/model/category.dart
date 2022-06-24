

import 'package:dd_blog_flutter/api.dart';
import 'package:dd_blog_flutter/error.dart';
import 'package:dd_blog_flutter/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



final categoryProvide = FutureProvider<ArchiveResult>((ref) async {
  final api = ArchiveApi();
  final result =await api.request();
  if(result == null) {
    throw BizError("获取信息失败");
  }
  return ArchiveResult.fromJson(result);
} );
