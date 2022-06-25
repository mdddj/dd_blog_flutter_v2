
import 'package:dd_blog_flutter/models.dart';
import 'package:dd_js_util/api/base.dart';

abstract class PostDataListPageDesign {
  
  @Doc(message: "加载博客列表")
  Future<List<PostData>> initPost();
  
  @Doc(message: "刷新博客列表")
  Future<void> refresh();
  
  @Doc(message: "加载下一页")
  Future<void> loadNextPage();
}