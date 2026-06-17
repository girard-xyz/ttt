import 'package:flutter/material.dart';
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
          if (!isInitial) _buildResult(context),
          const SizedBox(height: 24),
          _buildModeButton(context, GameMode.local, l10n.vsFriend),
          const SizedBox(height: 12),
          _buildModeButton(context, GameMode.vsComputer, l10n.vsComputer),
          const SizedBox(height: 12),
          if (isInitial) ...[
            _buildPlayerChoice(context),
            const SizedBox(height: 12),
          ],
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isInitial) {
                  onStartGame(GameMode.local);
                } else {
                  onStartGame(
                    finishedGame!.gameMode,
                    humanPlayer: finishedGame!.humanPlayer,
                  );
                }
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
                isInitial ? l10n.startGame : l10n.playAgain,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
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

  Widget _buildModeButton(BuildContext context, GameMode mode, String label) {
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

  static String _playerName(Player player) =>
      player == Player.x ? 'X' : 'O';

  Widget _buildPlayerChoice(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onStartGame(GameMode.vsComputer, humanPlayer: Player.x);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(l10n.playAsX, style: const TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onStartGame(GameMode.vsComputer, humanPlayer: Player.o);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(l10n.playAsO, style: const TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
