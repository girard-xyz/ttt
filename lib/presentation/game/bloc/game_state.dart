import 'package:equatable/equatable.dart';
import 'package:ttt/domain/entities/game.dart';
import 'package:ttt/domain/entities/game_mode.dart';
import 'package:ttt/domain/entities/player.dart';

class GameState extends Equatable {
  final Game game;
  final bool isLoading;
  final bool isLoaded;
  final int? lastMoveIndex;
  final List<int>? winLine;

  const GameState({
    required this.game,
    required this.isLoading,
    this.isLoaded = false,
    this.lastMoveIndex,
    this.winLine,
  });

  factory GameState.initial(GameMode mode, {Player humanPlayer = Player.x}) {
    return GameState(
      game: Game.initial(mode, humanPlayer: humanPlayer),
      isLoading: false,
    );
  }

  GameState copyWith({
    Game? game,
    bool? isLoading,
    bool? isLoaded,
    int? lastMoveIndex,
    List<int>? winLine,
  }) {
    return GameState(
      game: game ?? this.game,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      lastMoveIndex: lastMoveIndex ?? this.lastMoveIndex,
      winLine: winLine ?? this.winLine,
    );
  }

  @override
  List<Object?> get props => [game, isLoading, isLoaded, lastMoveIndex, winLine];
}
