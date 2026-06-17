import 'package:checks/checks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ttt/domain/entities/cell_value.dart';
import 'package:ttt/domain/entities/game.dart';
import 'package:ttt/domain/entities/game_mode.dart';
import 'package:ttt/domain/entities/game_status.dart';
import 'package:ttt/domain/entities/player.dart';

void main() {
  group('Game.initial', () {
    test('creates empty board with X to move', () {
      final game = Game.initial(GameMode.local);
      for (final cell in game.board) {
        check(cell).equals(CellValue.empty);
      }
      check(game.currentPlayer).equals(Player.x);
      check(game.status).equals(GameStatus.playing);
      check(game.gameMode).equals(GameMode.local);
    });
  });

  group('makeMove', () {
    test('places X in the chosen cell', () {
      final game = Game.initial(GameMode.local);
      final result = game.makeMove(4);
      check(result.board[4]).equals(CellValue.x);
    });

    test('switches to O after X moves', () {
      final game = Game.initial(GameMode.local);
      final result = game.makeMove(4);
      check(result.currentPlayer).equals(Player.o);
    });

    test('returns self when cell is occupied', () {
      final game = Game.initial(GameMode.local).makeMove(4);
      final result = game.makeMove(4);
      check(identical(result, game)).isTrue();
    });

    test('returns self when game is over', () {
      final game = Game.initial(GameMode.local)
          .makeMove(0)
          .makeMove(3)
          .makeMove(1)
          .makeMove(4)
          .makeMove(2);
      check(game.status).equals(GameStatus.xWins);
      final result = game.makeMove(5);
      check(identical(result, game)).isTrue();
    });
  });

  group('win detection', () {
    test('detects X win on top row', () {
      final game = Game.initial(GameMode.local)
          .makeMove(0)
          .makeMove(3)
          .makeMove(1)
          .makeMove(4)
          .makeMove(2);
      check(game.status).equals(GameStatus.xWins);
    });

    test('detects O win on diagonal', () {
      var game = Game.initial(GameMode.local);
      game = game.makeMove(3);
      game = game.makeMove(0);
      game = game.makeMove(4);
      game = game.makeMove(1);
      game = game.makeMove(6);
      game = game.makeMove(2);
      check(game.status).equals(GameStatus.oWins);
    });

    test('detects draw', () {
      var game = Game.initial(GameMode.local);
      game = game.makeMove(0);
      game = game.makeMove(3);
      game = game.makeMove(1);
      game = game.makeMove(4);
      game = game.makeMove(6);
      game = game.makeMove(2);
      game = game.makeMove(5);
      game = game.makeMove(8);
      game = game.makeMove(7);
      check(game.status).equals(GameStatus.draw);
    });
  });

  group('winningLine', () {
    test('returns correct indices for top row', () {
      final game = Game.initial(GameMode.local)
          .makeMove(0)
          .makeMove(3)
          .makeMove(1)
          .makeMove(4)
          .makeMove(2);
      final line = game.winningLine!;
      check(line).deepEquals([0, 1, 2]);
    });

    test('returns null when game is still playing', () {
      final game = Game.initial(GameMode.local).makeMove(0);
      check(game.winningLine).isNull();
    });
  });

  group('emptyIndices', () {
    test('returns all 9 indices for new game', () {
      final game = Game.initial(GameMode.local);
      check(game.emptyIndices).length.equals(9);
    });

    test('excludes occupied cells', () {
      final game = Game.initial(GameMode.local).makeMove(4).makeMove(0);
      check(game.emptyIndices).length.equals(7);
      check(game.emptyIndices.contains(4)).isFalse();
      check(game.emptyIndices.contains(0)).isFalse();
    });
  });

  group('isBoardFull', () {
    test('returns false for empty board', () {
      final game = Game.initial(GameMode.local);
      check(game.isBoardFull).isFalse();
    });

    test('returns true for full board', () {
      var game = Game.initial(GameMode.local);
      game = game.makeMove(0);
      game = game.makeMove(3);
      game = game.makeMove(1);
      game = game.makeMove(4);
      game = game.makeMove(6);
      game = game.makeMove(2);
      game = game.makeMove(5);
      game = game.makeMove(8);
      game = game.makeMove(7);
      check(game.isBoardFull).isTrue();
    });
  });

  group('copyWith', () {
    test('creates modified copy', () {
      final game = Game.initial(GameMode.local);
      final modified = game.copyWith(currentPlayer: Player.o);
      check(modified.currentPlayer).equals(Player.o);
      check(game.currentPlayer).equals(Player.x);
    });
  });
}
