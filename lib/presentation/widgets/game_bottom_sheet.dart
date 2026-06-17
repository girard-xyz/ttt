import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttt/core/colors.dart';
import 'package:ttt/domain/entities/game.dart';
import 'package:ttt/domain/entities/game_mode.dart';
import 'package:ttt/domain/entities/game_status.dart';
import 'package:ttt/domain/entities/player.dart';
import 'package:ttt/core/l10n/app_localizations.dart';

class GameBottomSheet extends StatelessWidget {
  final Game? finishedGame;
  final bool isInitial;
  final void Function(GameMode mode, {Player? humanPlayer}) onStartGame;

  const GameBottomSheet({
    super.key,
    this.finishedGame,
    required this.isInitial,
    required this.onStartGame,
  });

  static Future<void> show({
    required BuildContext context,
    required bool isInitial,
    Game? finishedGame,
    required void Function(GameMode mode, {Player? humanPlayer}) onStartGame,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => GameBottomSheet(
        isInitial: isInitial,
        finishedGame: finishedGame,
        onStartGame: onStartGame,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            label: 'Tic-Tac-Toe',
            child: Text(
              'TTT',
              style: GoogleFonts.caveatBrush(fontSize: 56, color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          if (isInitial)
            Text(
              l10n.startGameTitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          else
            _buildResult(context),
          const SizedBox(height: 24),
          _outlinedButton(context, l10n.localGame, GameMode.local),
          const SizedBox(height: 12),
          _filledButton(context, l10n.againstComputer, GameMode.vsComputer),
        ],
      ),
    );
  }

  Widget _buildResult(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final status = finishedGame!.status;
    final message = status.winner != null
        ? l10n.resultWinner(_playerName(status.winner!))
        : l10n.resultDraw;
    return Text(
      message,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _outlinedButton(BuildContext context, String label, GameMode mode) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context).pop();
          onStartGame(mode);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _filledButton(BuildContext context, String label, GameMode mode) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          onStartGame(mode);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.grid,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static String _playerName(Player player) => player == Player.x ? 'X' : 'O';
}
