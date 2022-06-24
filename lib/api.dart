

import 'package:dd_blog_flutter/models.dart';
import 'package:dd_js_util/api/base.dart';

@Doc(message: "博客列表Api")
class PostListApi extends BaseApi {
  PostListApi():super("/api/blog/list");
  set page(int page)=>params['page'] = page;
  set pageSize(int pageSize)=>params['pageSize'] = pageSize;

  @Doc(message: "博客列表Api: 发起请求")
  static Future<dynamic> doRequest(int page,int pageSize) async {
    final api = PostListApi()..page = page..pageSize = pageSize;
    final result =await api.request();
   return result;
  }

}

@Doc(message: "归档Api")
class ArchiveApi extends BaseApi {

  ArchiveApi():super("/api/blog/statistics");

}