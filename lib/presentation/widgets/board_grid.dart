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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cellSize = constraints.maxWidth / 3;
          return Stack(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  final row = index ~/ 3;
                  final col = index % 3;
                  return Padding(
                    padding: EdgeInsets.only(
                      top: row == 0 ? 0 : 4,
                      bottom: row == 2 ? 0 : 4,
                      left: col == 0 ? 0 : 4,
                      right: col == 2 ? 0 : 4,
                    ),
                    child: CellTile(
                      value: game.board[index],
                      isLastMove: lastMoveIndex == index,
                      isWinningCell: winLine?.contains(index) ?? false,
                      onTap: () => onCellTapped(index),
                    ),
                  );
                },
              ),
              if (winLine != null)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _WinLinePainter(
                      winLine: winLine!,
                      cellSize: cellSize,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _WinLinePainter extends CustomPainter {
  final List<int> winLine;
  final double cellSize;

  _WinLinePainter({required this.winLine, required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final gap = 8.0;
    final cellTotal = cellSize + gap;
    final halfCell = cellSize / 2;

    final startIndex = winLine.first;
    final endIndex = winLine.last;

    final startRow = startIndex ~/ 3;
    final startCol = startIndex % 3;
    final endRow = endIndex ~/ 3;
    final endCol = endIndex % 3;

    final startX = startCol * cellTotal + halfCell;
    final startY = startRow * cellTotal + halfCell;
    final endX = endCol * cellTotal + halfCell;
    final endY = endRow * cellTotal + halfCell;

    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
  }

  @override
  bool shouldRepaint(covariant _WinLinePainter old) => old.winLine != winLine;
}
