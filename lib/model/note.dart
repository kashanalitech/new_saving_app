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
  bool isFlagged;
  int? position; // Add this line for the position



  NoteEntity({
      this.id,
    required this.title,
    required this.date,
    required this.content,
    this.isFlagged = false,
    this.position = 0, // Default value for the position

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
