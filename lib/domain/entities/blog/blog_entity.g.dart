// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlogEntityAdapter extends TypeAdapter<BlogEntity> {
  @override
  final int typeId = 0;

  @override
  BlogEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlogEntity(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      url: fields[3] as String,
      coverImage: fields[4] as String?,
      readablePublishDate: fields[5] as String,
      tagList: (fields[6] as List).cast<String>(),
      authorName: fields[7] as String,
      authorProfileImage: fields[8] as String,
      readingTimeMinutes: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BlogEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.coverImage)
      ..writeByte(5)
      ..write(obj.readablePublishDate)
      ..writeByte(6)
      ..write(obj.tagList)
      ..writeByte(7)
      ..write(obj.authorName)
      ..writeByte(8)
      ..write(obj.authorProfileImage)
      ..writeByte(9)
      ..write(obj.readingTimeMinutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlogEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
