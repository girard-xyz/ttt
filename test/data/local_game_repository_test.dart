import 'package:checks/checks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttt/data/repositories/local_game_repository.dart';
import 'package:ttt/domain/entities/cell_value.dart';
import 'package:ttt/domain/entities/game.dart';
import 'package:ttt/domain/entities/game_mode.dart';
import 'package:ttt/domain/entities/player.dart';

void main() {
  group('LocalGameRepository bitpacking', () {
    test('encodes and decodes a fresh game', () async {
      SharedPreferences.setMockInitialValues({});
      final repo = LocalGameRepository();

      final game = Game.initial(GameMode.local);
      await repo.save(game);
      final loaded = await repo.load();

      check(loaded).isNotNull();
      check(loaded!.board[0]).equals(CellValue.empty);
      check(loaded.currentPlayer).equals(game.currentPlayer);
      check(loaded.gameMode).equals(game.gameMode);
      check(loaded.humanPlayer).equals(game.humanPlayer);
    });

    test('encodes and decodes vsComputer game with O human', () async {
      SharedPreferences.setMockInitialValues({});
      final repo = LocalGameRepository();

      final game = Game.initial(GameMode.vsComputer, humanPlayer: Player.o);
      await repo.save(game);
      final loaded = await repo.load();

      check(loaded).isNotNull();
      check(loaded!.gameMode).equals(GameMode.vsComputer);
      check(loaded.humanPlayer).equals(Player.o);
    });

    test('encodes and decodes a game with moves', () async {
      SharedPreferences.setMockInitialValues({});
      final repo = LocalGameRepository();

      var game = Game.initial(GameMode.local);
      game = game.makeMove(0);
      game = game.makeMove(4);
      game = game.makeMove(8);

      await repo.save(game);
      final loaded = await repo.load();

      check(loaded).isNotNull();
      check(loaded!.board[0]).equals(CellValue.x);
      check(loaded.board[4]).equals(CellValue.o);
      check(loaded.board[8]).equals(CellValue.x);
      check(loaded.currentPlayer).equals(Player.o);
    });

    test('returns null when no game saved', () async {
      SharedPreferences.setMockInitialValues({});
      final repo = LocalGameRepository();
      final loaded = await repo.load();
      check(loaded).isNull();
    });

    test('clears saved game', () async {
      SharedPreferences.setMockInitialValues({});
      final repo = LocalGameRepository();

      await repo.save(Game.initial(GameMode.local));
      await repo.clear();
      final loaded = await repo.load();

      check(loaded).isNull();
    });
  });
}
