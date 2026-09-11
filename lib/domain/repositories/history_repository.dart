import '../entities/reminder_history_entry.dart';
import '../enums/reminder_enums.dart';

abstract interface class HistoryRepository {
  Stream<List<ReminderHistoryEntry>> watchHistory({
    ReminderAction? filterAction,
    DateTime? from,
    DateTime? to,
  });
  Future<List<ReminderHistoryEntry>> getTodayEntries();
  Future<void> addEntry(ReminderHistoryEntry entry);
  Future<void> clearHistory();
}
