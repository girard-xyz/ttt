import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ttt/domain/entities/game_mode.dart';
import 'package:ttt/domain/entities/player.dart';

part 'game_event.freezed.dart';

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent.cellTapped(int index) = CellTapped;
  const factory GameEvent.newGame(GameMode mode, {@Default(Player.x) Player humanPlayer}) = NewGame;
  const factory GameEvent.loadGame() = LoadGame;
}
