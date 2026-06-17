import 'package:ttt/domain/entities/player.dart';

enum GameStatus { playing, xWins, oWins, draw }

extension GameStatusX on GameStatus {
  bool get isGameOver => this != GameStatus.playing;

  Player? get winner => switch (this) {
    GameStatus.xWins => Player.x,
    GameStatus.oWins => Player.o,
    _ => null,
  };
}
