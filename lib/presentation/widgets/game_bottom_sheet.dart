import 'package:flutter/material.dart';
import 'package:ttt/core/colors.dart';
import 'package:ttt/domain/entities/game.dart';
import 'package:ttt/domain/entities/game_mode.dart';
import 'package:ttt/domain/entities/game_status.dart';
import 'package:ttt/domain/entities/player.dart';

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
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isInitial) _buildResult(),
          const SizedBox(height: 24),
          _buildModeButton(context, GameMode.local, 'vs Friend'),
          const SizedBox(height: 12),
          _buildModeButton(context, GameMode.vsComputer, 'vs Computer'),
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
                isInitial ? 'Start Game' : 'Play Again',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    final status = finishedGame!.status;
    String message;
    if (status.winner != null) {
      message = status.winner == Player.x ? 'X Wins!' : 'O Wins!';
    } else {
      message = "It's a Draw!";
    }
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
        onPressed: () => onStartGame(mode),
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

  Widget _buildPlayerChoice(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () =>
                onStartGame(GameMode.vsComputer, humanPlayer: Player.x),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Play as X', style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () =>
                onStartGame(GameMode.vsComputer, humanPlayer: Player.o),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Play as O', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
