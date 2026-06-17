import 'package:equatable/equatable.dart';
import 'package:ttt/domain/entities/cell_value.dart';
import 'package:ttt/domain/entities/game_mode.dart';
import 'package:ttt/domain/entities/game_status.dart';
import 'package:ttt/domain/entities/player.dart';

class Game extends Equatable {
  final List<CellValue> board;
  final Player currentPlayer;
  final GameMode gameMode;
  final Player humanPlayer;
  final GameStatus status;

  const Game({
    required this.board,
    required this.currentPlayer,
    required this.gameMode,
    required this.humanPlayer,
    this.status = GameStatus.playing,
  });

  static const winPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  static List<int> emptyIndicesOf(List<CellValue> board) =>
      [for (int i = 0; i < board.length; i++) if (board[i] == CellValue.empty) i];

  List<int> get emptyIndices => emptyIndicesOf(board);

  Game copyWith({
    List<CellValue>? board,
    Player? currentPlayer,
    GameMode? gameMode,
    Player? humanPlayer,
    GameStatus? status,
  }) {
    return Game(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      gameMode: gameMode ?? this.gameMode,
      humanPlayer: humanPlayer ?? this.humanPlayer,
      status: status ?? this.status,
    );
  }

  Game makeMove(int index) {
    if (board[index] != CellValue.empty || status.isGameOver) return this;

    final newBoard = List<CellValue>.from(board);
    newBoard[index] = currentPlayer == Player.x ? CellValue.x : CellValue.o;

    final newStatus = evaluateBoard(newBoard);
    return copyWith(
      board: newBoard,
      currentPlayer: currentPlayer.opponent,
      status: newStatus,
    );
  }

  static GameStatus evaluateBoard(List<CellValue> b) {
    for (final pattern in winPatterns) {
      final first = b[pattern[0]];
      if (first == CellValue.empty) continue;
      if (b[pattern[1]] == first && b[pattern[2]] == first) {
        return first == CellValue.x ? GameStatus.xWins : GameStatus.oWins;
      }
    }
    if (b.every((c) => c.isOccupied)) return GameStatus.draw;
    return GameStatus.playing;
  }

  List<int>? get winningLine {
    for (final pattern in winPatterns) {
      final first = board[pattern[0]];
      if (first == CellValue.empty) continue;
      if (board[pattern[1]] == first && board[pattern[2]] == first) {
        return pattern;
      }
    }
    return null;
  }

  factory Game.initial(GameMode mode, {Player humanPlayer = Player.x}) {
    return Game(
      board: List.filled(9, CellValue.empty),
      currentPlayer: Player.x,
      gameMode: mode,
      humanPlayer: humanPlayer,
    );
  }

  @override
  List<Object?> get props => [board, currentPlayer, gameMode, humanPlayer, status];
}
