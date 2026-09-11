import '../data/database/daos/settings_dao.dart';
import '../data/mappers/database_mappers.dart';
import '../domain/entities/app_settings.dart';
import '../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDao _settingsDao;

  SettingsRepositoryImpl(this._settingsDao);

  @override
  Stream<AppSettings> watchSettings() {
    return _settingsDao.watchSettings().map((row) => row.toDomain());
  }

  @override
  Future<AppSettings> getSettings() async {
    final row = await _settingsDao.getSettings();
    return row.toDomain();
  }

  @override
  Future<void> updateSettings(AppSettings settings) async {
    await _settingsDao.upsertSettings(settings.toCompanion());
  }
}
