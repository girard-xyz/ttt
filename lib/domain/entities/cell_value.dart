import 'package:ttt/domain/entities/player.dart';

enum CellValue { empty, x, o }

extension CellValueX on CellValue {
  bool get isOccupied => this != CellValue.empty;

  Player? get player => switch (this) {
    CellValue.x => Player.x,
    CellValue.o => Player.o,
    CellValue.empty => null,
  };
}
