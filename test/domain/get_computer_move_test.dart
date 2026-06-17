import 'package:checks/checks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ttt/domain/entities/cell_value.dart';
import 'package:ttt/domain/usecases/get_computer_move.dart';

void main() {
  final ai = GetComputerMove();

  List<CellValue> board(List<CellValue?>? cells) {
    final b = List.filled(9, CellValue.empty);
    if (cells != null) {
      for (int i = 0; i < cells.length; i++) {
        if (cells[i] != null) b[i] = cells[i]!;
      }
    }
    return b;
  }

  group('winning moves', () {
    test('takes winning move when available (X)', () {
      final b = board([
        CellValue.x, CellValue.x, null,
        CellValue.o, CellValue.o, null,
        null, null, null,
      ]);
      final move = ai.execute(b, isMaximizing: true);
      check(move).equals(2);
    });

    test('takes winning move when available (O)', () {
      final b = board([
        CellValue.x, CellValue.x, null,
        CellValue.o, CellValue.o, null,
        null, null, null,
      ]);
      final move = ai.execute(b, isMaximizing: false);
      check(move).equals(5);
    });
  });

  group('blocking moves', () {
    test('blocks opponent winning move (X)', () {
      final b = board([
        CellValue.o, CellValue.o, null,
        CellValue.x, null, null,
        null, null, null,
      ]);
      final move = ai.execute(b, isMaximizing: true);
      check(move).equals(2);
    });

    test('blocks opponent winning move (O)', () {
      final b = board([
        CellValue.x, CellValue.x, null,
        null, CellValue.o, null,
        null, null, null,
      ]);
      final move = ai.execute(b, isMaximizing: false);
      check(move).equals(2);
    });
  });

  group('center priority', () {
    test('prefers center on empty board', () {
      final b = board([]);
      final move = ai.execute(b, isMaximizing: true);
      check(move).equals(4);
    });
  });

  group('draw', () {
    test('plays to draw when losing position', () {
      final b = board([
        CellValue.x, CellValue.x, null,
        CellValue.o, CellValue.x, null,
        CellValue.o, null, CellValue.o,
      ]);
      final move = ai.execute(b, isMaximizing: false);
      check(move == 2 || move == 7).isTrue();
    });
  });

  group('invalid moves', () {
    test('never picks occupied cell', () {
      final b = board([
        CellValue.x, null, null,
        null, null, null,
        null, null, null,
      ]);
      final move = ai.execute(b, isMaximizing: false);
      expect(move, isNot(0));
    });
  });
}
