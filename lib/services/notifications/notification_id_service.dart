import 'package:drift/drift.dart';
import '../../data/database/app_database.dart';

class NotificationIdService {
  final AppDatabase _db;
  int _lastAllocated = 0;
  Future<void> _tail = Future<void>.value();

  NotificationIdService(this._db);

  Future<int> allocateNotificationId() {
    final result = _tail.then((_) => _allocate());
    _tail = result.then<void>(
      (_) {},
      onError: (Object error, StackTrace stack) {},
    );
    return result;
  }

  Future<int> _allocate() async {
    if (_lastAllocated == 0) {
      final maxQuery = _db.selectOnly(_db.reminderTimesTable)
        ..addColumns([_db.reminderTimesTable.notificationId.max()]);
      final result = await maxQuery.getSingle();
      final currentMax = result.read(
        _db.reminderTimesTable.notificationId.max(),
      );
      _lastAllocated = currentMax ?? 1000;
    }

    _lastAllocated++;
    // Keep safely within 32-bit positive signed integer
    if (_lastAllocated > 214748360) {
      throw StateError('Notification ID space exhausted');
    }
    return _lastAllocated;
  }
}
