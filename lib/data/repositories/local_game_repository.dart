import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttt/domain/entities/cell_value.dart';
import 'package:ttt/domain/entities/game.dart';
import 'package:ttt/domain/entities/game_mode.dart';
import 'package:ttt/domain/entities/player.dart';
import 'package:ttt/domain/repositories/game_repository.dart';

class LocalGameRepository implements GameRepository {
  static const _key = 'game_state';

  @override
  Future<void> save(Game game) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, _encode(game));
  }

  @override
  Future<Game?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_key);
    if (value == null) return null;
    return _decode(value);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static int _encode(Game game) {
    int data = 0;

    if (game.gameMode == GameMode.vsComputer) data |= 1 << 0;
    if (game.currentPlayer == Player.o) data |= 1 << 1;
    if (game.humanPlayer == Player.o) data |= 1 << 2;

    for (int i = 0; i < 9; i++) {
      final shift = 3 + i * 2;
      switch (game.board[i]) {
        case CellValue.x:
          data |= 1 << shift;
          break;
        case CellValue.o:
          data |= 2 << shift;
          break;
        case CellValue.empty:
          break;
      }
    }

    return data;
  }

  static Game _decode(int data) {
    final gameMode = (data & (1 << 0)) != 0 ? GameMode.vsComputer : GameMode.local;
    final currentPlayer = (data & (1 << 1)) != 0 ? Player.o : Player.x;
    final humanPlayer = (data & (1 << 2)) != 0 ? Player.o : Player.x;

    final board = List<CellValue>.generate(9, (i) {
      final shift = 3 + i * 2;
      final value = (data >> shift) & 3;
      return switch (value) {
        1 => CellValue.x,
        2 => CellValue.o,
        _ => CellValue.empty,
      };
    });

    return Game(
      board: board,
      currentPlayer: currentPlayer,
      gameMode: gameMode,
      humanPlayer: humanPlayer,
    );
  }
}
