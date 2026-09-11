import 'package:drift/drift.dart';
import '../../../core/extensions/date_time_extensions.dart';
import '../app_database.dart';
import '../tables/reminder_history_table.dart';

part 'reminder_history_dao.g.dart';

@DriftAccessor(tables: [ReminderHistoryTable])
class ReminderHistoryDao extends DatabaseAccessor<AppDatabase> with _$ReminderHistoryDaoMixin {
  ReminderHistoryDao(super.db);

  Stream<List<ReminderHistoryRow>> watchHistory({
    String? action,
    DateTime? from,
    DateTime? to,
  }) {
    final query = select(reminderHistoryTable);
    if (action != null) {
      query.where((tbl) => tbl.action.equals(action));
    }
    if (from != null) {
      query.where((tbl) => tbl.scheduledFor.isBiggerOrEqualValue(from));
    }
    if (to != null) {
      query.where((tbl) => tbl.scheduledFor.isSmallerOrEqualValue(to));
    }
    query.orderBy([(tbl) => OrderingTerm.desc(tbl.scheduledFor)]);
    return query.watch();
  }

  Future<List<ReminderHistoryRow>> getTodayEntries() async {
    final now = DateTime.now();
    final start = now.startOfDay();
    final end = now.endOfDay();

    final query = select(reminderHistoryTable)
      ..where((tbl) => tbl.scheduledFor.isBetweenValues(start, end))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.scheduledFor)]);
    return query.get();
  }

  Future<void> insertEntry(ReminderHistoryTableCompanion entry) async {
    await into(reminderHistoryTable).insert(entry);
  }

  Future<void> clearHistory() async {
    await delete(reminderHistoryTable).go();
  }
}
