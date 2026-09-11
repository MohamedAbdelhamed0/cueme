import 'dart:math';
import 'package:drift/drift.dart';
import '../../data/database/app_database.dart';

class NotificationIdService {
  final AppDatabase _db;
  int _lastAllocated = 0;

  NotificationIdService(this._db);

  Future<int> allocateNotificationId() async {
    if (_lastAllocated == 0) {
      final maxQuery = _db.selectOnly(_db.reminderTimesTable)
        ..addColumns([_db.reminderTimesTable.notificationId.max()]);
      final result = await maxQuery.getSingle();
      final currentMax = result.read(_db.reminderTimesTable.notificationId.max());
      _lastAllocated = currentMax ?? 1000;
    }

    _lastAllocated++;
    // Keep safely within 32-bit positive signed integer
    if (_lastAllocated > 2147483600) {
      _lastAllocated = 1000 + Random().nextInt(10000);
    }
    return _lastAllocated;
  }
}
