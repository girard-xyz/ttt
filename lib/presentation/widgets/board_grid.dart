import 'package:flutter/material.dart';
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
    return AspectRatio(
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
          return CellTile(
            value: game.board[index],
            isLastMove: lastMoveIndex == index,
            isWinningCell: winLine?.contains(index) ?? false,
            onTap: () => onCellTapped(index),
          );
        },
      ),
    );
  }
}
