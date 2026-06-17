import 'package:flutter/material.dart';
import 'package:ttt/core/colors.dart';
import 'package:ttt/domain/entities/cell_value.dart';
import 'package:ttt/domain/entities/player.dart';

class CellTile extends StatelessWidget {
  final CellValue value;
  final bool isLastMove;
  final bool isWinningCell;
  final VoidCallback onTap;

  const CellTile({
    super.key,
    required this.value,
    required this.isLastMove,
    required this.isWinningCell,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: value == CellValue.empty ? onTap : null,
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: AppColors.grid,
              borderRadius: BorderRadius.circular(12),
              border: isWinningCell
                  ? Border.all(color: Colors.white, width: 3)
                  : null,
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: value == CellValue.empty
                    ? const SizedBox.shrink(key: ValueKey('empty'))
                    : _buildSymbol(value.player!),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSymbol(Player player) {
    final isX = player == Player.x;
    final child = isX
        ? CustomPaint(
            key: const ValueKey('x'),
            painter: _XPainter(color: AppColors.xColor),
          )
        : CustomPaint(
            key: const ValueKey('o'),
            painter: _OPainter(color: AppColors.oColor),
          );
    return FractionallySizedBox(
      widthFactor: 2 / 3,
      heightFactor: 2 / 3,
      child: child,
    );
  }
}

class _XPainter extends CustomPainter {
  final Color color;
  _XPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final inset = size.width * 0.2;
    canvas.drawLine(
      Offset(inset, inset),
      Offset(size.width - inset, size.height - inset),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - inset, inset),
      Offset(inset, size.height - inset),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _XPainter old) => old.color != color;
}

class _OPainter extends CustomPainter {
  final Color color;
  _OPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final rect = Rect.fromLTWH(
      size.width * 0.15,
      size.height * 0.15,
      size.width * 0.7,
      size.height * 0.7,
    );
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _OPainter old) => old.color != color;
}
