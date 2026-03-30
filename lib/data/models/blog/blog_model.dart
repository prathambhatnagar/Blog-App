import 'package:blog_assignment/domain/entities/blog/blog_entity.dart';

class BlogModel {
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

  const BlogModel({
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

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] ?? '',
      url: json['url'] as String,
      coverImage: json['cover_image'] ?? json['social_image'],
      readablePublishDate: json['readable_publish_date'] as String,
      tagList: List<String>.from(json['tag_list'] ?? []),
      authorName: json['user']['name'] ?? 'Unknown',
      authorProfileImage: json['user']['profile_image'] ?? '',
      readingTimeMinutes: json['reading_time_minutes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'cover_image': coverImage,
      'readable_publish_date': readablePublishDate,
      'tag_list': tagList,
      'author_name': authorName,
      'author_profile_image': authorProfileImage,
      'reading_time_minutes': readingTimeMinutes,
    };
  }
}

extension BlogModelX on BlogModel {
  BlogEntity toEntity() {
    return BlogEntity(
      id: id,
      title: title,
      description: description,
      url: url,
      coverImage: coverImage,
      readablePublishDate: readablePublishDate,
      tagList: tagList,
      authorName: authorName,
      authorProfileImage: authorProfileImage,
      readingTimeMinutes: readingTimeMinutes,
    );
  }
}
