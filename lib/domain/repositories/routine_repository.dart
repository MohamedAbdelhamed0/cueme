import '../entities/routine.dart';

abstract interface class RoutineRepository {
  Stream<List<Routine>> watchActive();
  Stream<List<Routine>> watchArchived();
  Future<List<Routine>> getAllActive();
  Future<Routine?> getById(String id);
  Future<void> saveRoutine(Routine routine);
  Future<void> deleteRoutine(String id);
  Future<void> setActive(String id, bool active);
  Future<void> setArchived(String id, bool archived);
}
