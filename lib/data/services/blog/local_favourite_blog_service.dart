import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:hive/hive.dart';

abstract class LocalFavoriteBlogService {
  Future<void> addBookmark(BlogEntity blog);
  Future<void> removeBookmark(int id);
  List<BlogEntity> getBookmarks();
}

class LocalFavoriteBlogServiceImpl implements LocalFavoriteBlogService {
  static const String boxName = 'favorite_blogs';

  @override
  Future<void> addBookmark(BlogEntity blog) async {
    final box = Hive.box<BlogEntity>(boxName);
    await box.put(blog.id, blog);
  }

  @override
  Future<void> removeBookmark(int id) async {
    final box = Hive.box<BlogEntity>(boxName);
    await box.delete(id);
  }

  @override
  List<BlogEntity> getBookmarks() {
    final box = Hive.box<BlogEntity>(boxName);
    return box.values.toList();
  }
}
