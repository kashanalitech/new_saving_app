// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorNoteDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NoteDatabaseBuilder databaseBuilder(String name) =>
      _$NoteDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NoteDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$NoteDatabaseBuilder(null);
}

class _$NoteDatabaseBuilder {
  _$NoteDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$NoteDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$NoteDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<NoteDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$NoteDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$NoteDatabase extends NoteDatabase {
  _$NoteDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NoteEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `date_millis` INTEGER NOT NULL, `content` TEXT NOT NULL, `isFlagged` INTEGER NOT NULL, `position` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _noteEntityInsertionAdapter = InsertionAdapter(
            database,
            'NoteEntity',
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'date_millis': _dateTimeConverter.encode(item.date),
                  'content': item.content,
                  'isFlagged': item.isFlagged ? 1 : 0,
                  'position': item.position
                }),
        _noteEntityUpdateAdapter = UpdateAdapter(
            database,
            'NoteEntity',
            ['id'],
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'date_millis': _dateTimeConverter.encode(item.date),
                  'content': item.content,
                  'isFlagged': item.isFlagged ? 1 : 0,
                  'position': item.position
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteEntity> _noteEntityInsertionAdapter;

  final UpdateAdapter<NoteEntity> _noteEntityUpdateAdapter;

  @override
  Future<List<NoteEntity>> getNotes() async {
    return _queryAdapter.queryList('SELECT * FROM NoteEntity',
        mapper: (Map<String, Object?> row) => NoteEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            date: _dateTimeConverter.decode(row['date_millis'] as int),
            content: row['content'] as String,
            isFlagged: (row['isFlagged'] as int) != 0,
            position: row['position'] as int?));
  }

  @override
  Future<void> updateNoteTitle(
    int noteId,
    String newTitle,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE NoteEntity SET title = ?2 WHERE id = ?1',
        arguments: [noteId, newTitle]);
  }

  @override
  Future<void> updateFlagStatus(
    int noteId,
    bool isFlagged,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE NoteEntity SET isFlagged = ?2 WHERE id = ?1',
        arguments: [noteId, isFlagged ? 1 : 0]);
  }

  @override
  Future<void> updateNotePosition(
    int noteId,
    int position,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE NoteEntity SET position = ?2 WHERE id = ?1',
        arguments: [noteId, position]);
  }

  @override
  Future<void> saveNote(NoteEntity note) async {
    await _noteEntityInsertionAdapter.insert(note, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    await _noteEntityUpdateAdapter.update(note, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
