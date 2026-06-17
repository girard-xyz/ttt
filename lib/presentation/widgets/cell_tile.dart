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
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.grid,
              borderRadius: BorderRadius.circular(12),
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
    if (isX) {
      return CustomPaint(
        key: const ValueKey('x'),
        size: const Size.square(48),
        painter: _XPainter(color: AppColors.xColor),
      );
    }
    return CustomPaint(
      key: const ValueKey('o'),
      size: const Size.square(48),
      painter: _OPainter(color: AppColors.oColor),
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
