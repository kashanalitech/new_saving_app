// note.dart

import 'package:floor/floor.dart';

@Entity(tableName: 'NoteEntity')
class NoteEntity {
  // @PrimaryKey()
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  @TypeConverters([DateTimeConverter])
  @ColumnInfo(name: 'date_millis')
   final DateTime date;
  final String content;
  int isFlagged;
  int? position; // Add this line for the position



  NoteEntity({
      this.id,
    required this.title,
    required this.date,
    required this.content,
    required this.isFlagged,
     this.position,
  });
}

// datetime_converter.dart

class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}
