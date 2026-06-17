import 'package:ttt/domain/entities/game.dart';

abstract class GameRepository {
  Future<void> save(Game game);
  Future<Game?> load();
  Future<void> clear();
}
