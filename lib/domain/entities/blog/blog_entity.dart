import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'blog_entity.g.dart';

@HiveType(typeId: 0)
class BlogEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String? coverImage;
  @HiveField(5)
  final String readablePublishDate;
  @HiveField(6)
  final List<String> tagList;
  @HiveField(7)
  final String authorName;
  @HiveField(8)
  final String authorProfileImage;
  @HiveField(9)
  final int readingTimeMinutes;

  const BlogEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    this.coverImage,
    required this.readablePublishDate,
    required this.tagList,
    required this.authorName,
    required this.authorProfileImage,
    required this.readingTimeMinutes,
  });

  @override
  List<Object?> get props => [id, title, url];
}
