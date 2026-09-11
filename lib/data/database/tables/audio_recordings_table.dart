import 'package:drift/drift.dart';

@DataClassName('AudioRecordingRow')
class AudioRecordingsTable extends Table {
  @override
  String get tableName => 'audio_recordings';

  TextColumn get id => text()();
  TextColumn get localPath => text()();
  TextColumn get iosSoundFilename => text().nullable()();

  TextColumn get codec => text().withDefault(const Constant('wav'))();
  IntColumn get durationMs => integer()();
  IntColumn get fileSizeBytes => integer().nullable()();

  IntColumn get revision => integer().withDefault(const Constant(1))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
