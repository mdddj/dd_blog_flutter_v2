import 'dart:convert';
import 'dart:developer';

import 'package:dd_js_util/api/base.dart';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();
  static T? Function<T extends Object?>(dynamic value) convert =
  <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class IndexPostResultJson extends BaseModel<IndexPostResultJson> {
  IndexPostResultJson({
    required this.data,
    required this.message,
    required this.state,
  });

  factory IndexPostResultJson.fromJson(Map<String, dynamic> jsonRes) => IndexPostResultJson(
    data: Data.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])!),
    message: asT<String>(jsonRes['message'])!,
    state: asT<int>(jsonRes['state'])!,
  );

  Data data;
  String message;
  int state;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'message': message,
    'state': state,
  };

  IndexPostResultJson copy() {
    return IndexPostResultJson(
      data: data.copy(),
      message: message,
      state: state,
    );
  }

  @override
  IndexPostResultJson fromJson(Map<String, dynamic> map) {
    return IndexPostResultJson.fromJson(map);
  }
}

class Data {
  Data({
    required this.list,
    required this.page,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) {
    final List<PostData>? list = jsonRes['list'] is List ? <PostData>[] : null;
    if (list != null) {
      for (final dynamic item in jsonRes['list']!) {
        if (item != null) {
          tryCatch(() {
            list.add(PostData.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Data(
      list: list!,
      page: PageModel.fromJson(asT<Map<String, dynamic>>(jsonRes['page'])!),
    );
  }

  List<PostData> list;
  PageModel page;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'list': list,
    'page': page,
  };

  Data copy() {
    return Data(
      list: list.map((PostData e) => e.copy()).toList(),
      page: page.copy(),
    );
  }
}

class PostData {
  PostData({
    required this.aliasString,
    required this.author,
    required this.category,
    required this.content,
    required this.createTime,
    required this.dateString,
    required this.id,
    required this.tags,
    required this.thumbnail,
    required this.title,
  });

  factory PostData.fromJson(Map<String, dynamic> jsonRes) {
    final List<Tags>? tags = jsonRes['tags'] is List ? <Tags>[] : null;
    if (tags != null) {
      for (final dynamic item in jsonRes['tags']!) {
        if (item != null) {
          tryCatch(() {
            tags.add(Tags.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return PostData(
      aliasString: asT<String>(jsonRes['aliasString'])!,
      author: asT<String>(jsonRes['author'])!,
      category:
      Category.fromJson(asT<Map<String, dynamic>>(jsonRes['category'])!),
      content: asT<String>(jsonRes['content'])!,
      createTime: asT<int>(jsonRes['createTime'])!,
      dateString: asT<String>(jsonRes['dateString'])!,
      id: asT<int>(jsonRes['id'])!,
      tags: tags!,
      thumbnail: asT<String>(jsonRes['thumbnail'])!,
      title: asT<String>(jsonRes['title'])!,
    );
  }

  String aliasString;
  String author;
  Category category;
  String content;
  int createTime;
  String dateString;
  int id;
  List<Tags> tags;
  String thumbnail;
  String title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'aliasString': aliasString,
    'author': author,
    'category': category,
    'content': content,
    'createTime': createTime,
    'dateString': dateString,
    'id': id,
    'tags': tags,
    'thumbnail': thumbnail,
    'title': title,
  };

  PostData copy() {
    return PostData(
      aliasString: aliasString,
      author: author,
      category: category.copy(),
      content: content,
      createTime: createTime,
      dateString: dateString,
      id: id,
      tags: tags.map((Tags e) => e.copy()).toList(),
      thumbnail: thumbnail,
      title: title,
    );
  }
}

class Category {
  Category({
    required this.createTime,
    required this.id,
    required this.intro,
    required this.logo,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> jsonRes) => Category(
    createTime: asT<String>(jsonRes['createTime'].toString())!,
    id: asT<int>(jsonRes['id'])!,
    intro: asT<String>(jsonRes['intro'])!,
    logo: asT<String>(jsonRes['logo'])!,
    name: asT<String>(jsonRes['name'])!,
  );

  String createTime;
  int id;
  String intro;
  String logo;
  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'createTime': createTime,
    'id': id,
    'intro': intro,
    'logo': logo,
    'name': name,
  };

  Category copy() {
    return Category(
      createTime: createTime,
      id: id,
      intro: intro,
      logo: logo,
      name: name,
    );
  }
}

class Tags {
  Tags({
    required this.id,
    required this.name,
  });

  factory Tags.fromJson(Map<String, dynamic> jsonRes) => Tags(
    id: asT<int>(jsonRes['id'])!,
    name: asT<String>(jsonRes['name'])!,
  );

  int id;
  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
  };

  Tags copy() {
    return Tags(
      id: id,
      name: name,
    );
  }
}

class PageModel {
  PageModel({
    required this.currentPage,
    required this.hasPrevious,
    required this.maxPage,
    required this.pageSize,
    required this.paged,
    required this.total,
  });

  factory PageModel.fromJson(Map<String, dynamic> jsonRes) => PageModel(
    currentPage: asT<int>(jsonRes['currentPage'])!,
    hasPrevious: asT<bool>(jsonRes['hasPrevious'])!,
    maxPage: asT<int>(jsonRes['maxPage'])!,
    pageSize: asT<int>(jsonRes['pageSize'])!,
    paged: asT<bool>(jsonRes['paged'])!,
    total: asT<int>(jsonRes['total'])!,
  );

  int currentPage;
  bool hasPrevious;
  int maxPage;
  int pageSize;
  bool paged;
  int total;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'currentPage': currentPage,
    'hasPrevious': hasPrevious,
    'maxPage': maxPage,
    'pageSize': pageSize,
    'paged': paged,
    'total': total,
  };

  PageModel copy() {
    return PageModel(
      currentPage: currentPage,
      hasPrevious: hasPrevious,
      maxPage: maxPage,
      pageSize: pageSize,
      paged: paged,
      total: total,
    );
  }
}


//---------


class ArchiveResult {
  ArchiveResult({
    required this.data,
    required this.message,
    required this.state,
  });

  factory ArchiveResult.fromJson(Map<String, dynamic> jsonRes) => ArchiveResult(
    data: AllData.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])!),
    message: asT<String>(jsonRes['message'])!,
    state: asT<int>(jsonRes['state'])!,
  );

  AllData data;
  String message;
  int state;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'message': message,
    'state': state,
  };

  ArchiveResult copy() {
    return ArchiveResult(
      data: data.copy(),
      message: message,
      state: state,
    );
  }
}

class AllData {
  AllData({
    required this.archiveModels,
    required this.blogCount,
    required this.cateCount,
    required this.categoryList,
    required this.monthsCounts,
    required this.tagCount,
    required this.tags,
  });

  factory AllData.fromJson(Map<String, dynamic> jsonRes) {
    final List<ArchiveModels>? archiveModels =
    jsonRes['archiveModels'] is List ? <ArchiveModels>[] : null;
    if (archiveModels != null) {
      for (final dynamic item in jsonRes['archiveModels']!) {
        if (item != null) {
          tryCatch(() {
            archiveModels
                .add(ArchiveModels.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<CategoryList>? categoryList =
    jsonRes['categoryList'] is List ? <CategoryList>[] : null;
    if (categoryList != null) {
      for (final dynamic item in jsonRes['categoryList']!) {
        if (item != null) {
          tryCatch(() {
            categoryList
                .add(CategoryList.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<MonthsCounts>? monthsCounts =
    jsonRes['monthsCounts'] is List ? <MonthsCounts>[] : null;
    if (monthsCounts != null) {
      for (final dynamic item in jsonRes['monthsCounts']!) {
        if (item != null) {
          tryCatch(() {
            monthsCounts
                .add(MonthsCounts.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<Tags>? tags = jsonRes['tags'] is List ? <Tags>[] : null;
    if (tags != null) {
      for (final dynamic item in jsonRes['tags']!) {
        if (item != null) {
          tryCatch(() {
            tags.add(Tags.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return AllData(
      archiveModels: archiveModels!,
      blogCount: asT<int>(jsonRes['blogCount'])!,
      cateCount: asT<int>(jsonRes['cateCount'])!,
      categoryList: categoryList!,
      monthsCounts: monthsCounts!,
      tagCount: asT<int>(jsonRes['tagCount'])!,
      tags: tags!,
    );
  }

  List<ArchiveModels> archiveModels;
  int blogCount;
  int cateCount;
  List<CategoryList> categoryList;
  List<MonthsCounts> monthsCounts;
  int tagCount;
  List<Tags> tags;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'archiveModels': archiveModels,
    'blogCount': blogCount,
    'cateCount': cateCount,
    'categoryList': categoryList,
    'monthsCounts': monthsCounts,
    'tagCount': tagCount,
    'tags': tags,
  };

  AllData copy() {
    return AllData(
      archiveModels: archiveModels.map((ArchiveModels e) => e.copy()).toList(),
      blogCount: blogCount,
      cateCount: cateCount,
      categoryList: categoryList.map((CategoryList e) => e.copy()).toList(),
      monthsCounts: monthsCounts.map((MonthsCounts e) => e.copy()).toList(),
      tagCount: tagCount,
      tags: tags.map((Tags e) => e.copy()).toList(),
    );
  }
}

class ArchiveModels  {
  ArchiveModels({
    required this.blogs,
    required this.count,
    required this.months,
  });

  factory ArchiveModels.fromJson(Map<String, dynamic> jsonRes) {
    final List<SimpleBlog>? blogs =
    jsonRes['blogs'] is List ? <SimpleBlog>[] : null;
    if (blogs != null) {
      for (final dynamic item in jsonRes['blogs']!) {
        if (item != null) {
          tryCatch(() {
            blogs.add(SimpleBlog.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return ArchiveModels(
      blogs: blogs!,
      count: asT<int>(jsonRes['count'])!,
      months: asT<String>(jsonRes['months'])!,
    );
  }

  List<SimpleBlog> blogs;
  int count;
  String months;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'blogs': blogs,
    'count': count,
    'months': months,
  };

  ArchiveModels copy() {
    return ArchiveModels(
      blogs: blogs.map((SimpleBlog e) => e.copy()).toList(),
      count: count,
      months: months,
    );
  }
}

class SimpleBlog {
  SimpleBlog({
    required this.createTime,
    this.decoratedClass,
    required this.id,
    required this.target,
    required this.targetClass,
    required this.title,
  });

  factory SimpleBlog.fromJson(Map<String, dynamic> jsonRes) => SimpleBlog(
    createTime: asT<int>(jsonRes['createTime'])!,
    decoratedClass: asT<Object?>(jsonRes['decoratedClass']),
    id: asT<int>(jsonRes['id'])!,
    target: Target.fromJson(asT<Map<String, dynamic>>(jsonRes['target'])!),
    targetClass: asT<String>(jsonRes['targetClass'])!,
    title: asT<String>(jsonRes['title'])!,
  );

  int createTime;
  Object? decoratedClass;
  int id;
  Target target;
  String targetClass;
  String title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'createTime': createTime,
    'decoratedClass': decoratedClass,
    'id': id,
    'target': target,
    'targetClass': targetClass,
    'title': title,
  };

  SimpleBlog copy() {
    return SimpleBlog(
      createTime: createTime,
      decoratedClass: decoratedClass,
      id: id,
      target: target.copy(),
      targetClass: targetClass,
      title: title,
    );
  }
}

class Target {
  Target({
    required this.title,
    required this.createTime,
    required this.id,
  });

  factory Target.fromJson(Map<String, dynamic> jsonRes) => Target(
    title: asT<String>(jsonRes['title']??'')!,
    createTime: asT<int>(jsonRes['CreateTime'])!,
    id: asT<int>(jsonRes['id'])!,
  );

  String title;
  int createTime;
  int id;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'CreateTime': createTime,
    'id': id,
  };

  Target copy() {
    return Target(
      title: title,
      createTime: createTime,
      id: id,
    );
  }
}

class CategoryList {
  CategoryList({
    required this.createTime,
    required this.id,
    required this.intro,
    required this.logo,
    required this.name,
  });

  factory CategoryList.fromJson(Map<String, dynamic> jsonRes) => CategoryList(
    createTime: asT<int?>(jsonRes['createTime']),
    id: asT<int>(jsonRes['id'])!,
    intro: asT<String>(jsonRes['intro'])!,
    logo: asT<String>(jsonRes['logo'])!,
    name: asT<String>(jsonRes['name'])!,
  );

  int? createTime;
  int id;
  String intro;
  String logo;
  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'createTime': createTime,
    'id': id,
    'intro': intro,
    'logo': logo,
    'name': name,
  };

  CategoryList copy() {
    return CategoryList(
      createTime: createTime,
      id: id,
      intro: intro,
      logo: logo,
      name: name,
    );
  }
}

class MonthsCounts {
  MonthsCounts({
    required this.count,
    this.decoratedClass,
    required this.months,
    required this.targetClass,
  });

  factory MonthsCounts.fromJson(Map<String, dynamic> jsonRes) => MonthsCounts(
    count: asT<int>(jsonRes['count'])!,
    decoratedClass: asT<Object?>(jsonRes['decoratedClass']),
    months: asT<String>(jsonRes['months'])!,
    targetClass: asT<String>(jsonRes['targetClass'])!,
  );

  int count;
  Object? decoratedClass;
  String months;
  String targetClass;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'decoratedClass': decoratedClass,
    'months': months,
    'targetClass': targetClass,
  };

  MonthsCounts copy() {
    return MonthsCounts(
      count: count,
      decoratedClass: decoratedClass,
      months: months,
      targetClass: targetClass,
    );
  }
}

class MonthsModel {
  MonthsModel({
    required this.count,
    required this.months,
  });

  factory MonthsModel.fromJson(Map<String, dynamic> jsonRes) => MonthsModel(
    count: asT<int>(jsonRes['count'])!,
    months: asT<String>(jsonRes['months'])!,
  );

  int count;
  String months;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'count': count,
    'months': months,
  };

  MonthsModel copy() {
    return MonthsModel(
      count: count,
      months: months,
    );
  }
}
