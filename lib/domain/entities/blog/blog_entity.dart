import 'package:equatable/equatable.dart';

class BlogEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String url;
  final String? coverImage;
  final String readablePublishDate;
  final List<String> tagList;
  final String authorName;
  final String authorProfileImage;
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
