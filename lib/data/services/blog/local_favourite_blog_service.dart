import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';
import 'package:hive/hive.dart';

abstract class LocalFavoriteBlogService {
  Future<void> addBookmark(BlogEntity blog);
  Future<void> removeBookmark(int id);
  List<BlogEntity> getBookmarks();
}

class LocalFavoriteBlogServiceImpl implements LocalFavoriteBlogService {
  static const String boxName = 'favorite_blogs';

  Box<BlogEntity> get _box => Hive.box<BlogEntity>(boxName);

  @override
  Future<void> addBookmark(BlogEntity blog) async {
    await _box.put(blog.id, blog);
  }

  @override
  Future<void> removeBookmark(int id) async {
    await _box.delete(id);
  }

  @override
  List<BlogEntity> getBookmarks() {
    return _box.values.toList();
  }
}
