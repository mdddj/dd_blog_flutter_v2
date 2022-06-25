import 'package:dd_js_util/api/base.dart';

@Doc(message: "博客列表Api")
class PostListApi extends BaseApi {
  PostListApi() : super("/api/blog/list");

  set page(int page) => params['page'] = page;

  set pageSize(int pageSize) => params['pageSize'] = pageSize;

  @Doc(message: "博客列表Api: 发起请求")
  static Future<dynamic> doRequest(int page, int pageSize) async {
    final api = PostListApi()
      ..page = page
      ..pageSize = pageSize;
    final result = await api.request();
    return result;
  }
}

@Doc(message: "归档Api")
class ArchiveApi extends BaseApi {
  ArchiveApi() : super("/api/blog/statistics");
}

@Doc(message: '月份,标签,分类通用api')
class PostListBaseApi extends BaseApi {
  final String apiUrl;

  static PostListBaseApi get tagApi => PostListBaseApi('/api/blog/tag/blogs');

  static PostListBaseApi get categoryApi => PostListBaseApi('/api/blog/category/blogs');

  static PostListBaseApi get monthApi => PostListBaseApi('/api/blog/month/blogs');

  PostListBaseApi(this.apiUrl) : super(apiUrl);

  set page(int page) => params['page'] = page;

  set pageSize(int pageSize) => params['pageSize'] = pageSize;

  set month(String month) => params['month'] = month; //如果是月份需要设置这个属性
  set tagId(String tagId) => params['tagId'] = tagId; //如果是标签需要设置这个属性
  set categoryId(String categoryId) => params['categoryId'] = categoryId; //如果是分类需要设置这个ID
}
