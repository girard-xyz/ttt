import 'package:flutter/material.dart';
import 'package:ttt/core/l10n/app_localizations.dart';
import 'package:ttt/domain/entities/cell_value.dart';
import 'package:ttt/domain/entities/game.dart';
import 'package:ttt/presentation/widgets/cell_tile.dart';

class BoardGrid extends StatelessWidget {
  final Game game;
  final int? lastMoveIndex;
  final List<int>? winLine;
  final void Function(int index) onCellTapped;

  const BoardGrid({
    super.key,
    required this.game,
    required this.lastMoveIndex,
    required this.winLine,
    required this.onCellTapped,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Semantics(
      container: true,
      label: l10n.boardLabel,
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            final cellValue = game.board[index];
            final position = _positionLabel(l10n, index);
            final valueLabel = switch (cellValue) {
              CellValue.empty => l10n.cellEmpty,
              CellValue.x => l10n.cellX,
              CellValue.o => l10n.cellO,
            };
            final semanticsLabel = '$position, $valueLabel';
            return CellTile(
              value: cellValue,
              isLastMove: lastMoveIndex == index,
              isWinningCell: winLine?.contains(index) ?? false,
              onTap: () => onCellTapped(index),
              semanticsLabel: semanticsLabel,
            );
          },
        ),
      ),
    );
  }

  static String _positionLabel(AppLocalizations l10n, int index) {
    return switch (index) {
      0 => l10n.cellPos0,
      1 => l10n.cellPos1,
      2 => l10n.cellPos2,
      3 => l10n.cellPos3,
      4 => l10n.cellPos4,
      5 => l10n.cellPos5,
      6 => l10n.cellPos6,
      7 => l10n.cellPos7,
      8 => l10n.cellPos8,
      _ => '',
    };
  }
}
