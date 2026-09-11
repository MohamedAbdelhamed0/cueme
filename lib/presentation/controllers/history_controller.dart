import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers/service_providers.dart';
import '../../core/extensions/date_time_extensions.dart';
import '../../domain/entities/reminder_history_entry.dart';
import '../../domain/enums/reminder_enums.dart';

class HistoryFilterActionNotifier extends Notifier<ReminderAction?> {
  @override
  ReminderAction? build() => null;

  void setFilter(ReminderAction? filter) => state = filter;
}

final historyFilterActionProvider =
    NotifierProvider<HistoryFilterActionNotifier, ReminderAction?>(HistoryFilterActionNotifier.new);

class GroupedHistory {
  final List<ReminderHistoryEntry> today;
  final List<ReminderHistoryEntry> yesterday;
  final List<ReminderHistoryEntry> thisWeek;
  final List<ReminderHistoryEntry> earlier;

  const GroupedHistory({
    required this.today,
    required this.yesterday,
    required this.thisWeek,
    required this.earlier,
  });

  bool get isEmpty =>
      today.isEmpty && yesterday.isEmpty && thisWeek.isEmpty && earlier.isEmpty;
}

final groupedHistoryProvider = StreamProvider<GroupedHistory>((ref) {
  final historyRepo = ref.watch(historyRepositoryProvider);
  final filter = ref.watch(historyFilterActionProvider);

  return historyRepo.watchHistory(filterAction: filter).map((entries) {
    final now = DateTime.now();
    final todayStart = now.startOfDay();
    final yesterdayStart = todayStart.subtract(const Duration(days: 1));
    final weekStart = todayStart.subtract(Duration(days: now.weekday - 1));

    final todayList = <ReminderHistoryEntry>[];
    final yesterdayList = <ReminderHistoryEntry>[];
    final thisWeekList = <ReminderHistoryEntry>[];
    final earlierList = <ReminderHistoryEntry>[];

    for (final entry in entries) {
      final scheduled = entry.scheduledFor;
      if (scheduled.isAfter(todayStart)) {
        todayList.add(entry);
      } else if (scheduled.isAfter(yesterdayStart)) {
        yesterdayList.add(entry);
      } else if (scheduled.isAfter(weekStart)) {
        thisWeekList.add(entry);
      } else {
        earlierList.add(entry);
      }
    }

    return GroupedHistory(
      today: todayList,
      yesterday: yesterdayList,
      thisWeek: thisWeekList,
      earlier: earlierList,
    );
  });
});
