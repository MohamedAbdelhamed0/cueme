import '../data/database/daos/reminder_history_dao.dart';
import '../data/mappers/database_mappers.dart';
import '../domain/entities/reminder_history_entry.dart';
import '../domain/enums/reminder_enums.dart';
import '../domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final ReminderHistoryDao _historyDao;

  HistoryRepositoryImpl(this._historyDao);

  @override
  Stream<List<ReminderHistoryEntry>> watchHistory({
    ReminderAction? filterAction,
    DateTime? from,
    DateTime? to,
  }) {
    return _historyDao
        .watchHistory(
          action: filterAction?.name,
          from: from,
          to: to,
        )
        .map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  @override
  Future<List<ReminderHistoryEntry>> getTodayEntries() async {
    final rows = await _historyDao.getTodayEntries();
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<void> addEntry(ReminderHistoryEntry entry) async {
    await _historyDao.insertEntry(entry.toCompanion());
  }

  @override
  Future<void> clearHistory() async {
    await _historyDao.clearHistory();
  }
}
