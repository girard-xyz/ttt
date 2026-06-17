import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:ttt/core/colors.dart';
import 'package:ttt/domain/entities/game.dart';
import 'package:ttt/domain/entities/game_status.dart';
import 'package:ttt/domain/entities/player.dart';
import 'package:ttt/core/l10n/app_localizations.dart';
import 'package:ttt/presentation/game/bloc/game_bloc.dart';
import 'package:ttt/presentation/game/bloc/game_event.dart';
import 'package:ttt/presentation/game/bloc/game_state.dart';
import 'package:ttt/presentation/widgets/board_grid.dart';
import 'package:ttt/presentation/widgets/game_bottom_sheet.dart';

String _playerName(Player player) => player == Player.x ? 'X' : 'O';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _sheetShown = false;

  @override
  void initState() {
    super.initState();
    context.read<GameBloc>().add(const LoadGame());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_sheetShown) {
      _sheetShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showStartSheet();
      });
    }
  }

  void _showStartSheet() {
    final bloc = context.read<GameBloc>();
    GameBottomSheet.show(
      context: context,
      isInitial: true,
      onStartGame: (mode, {humanPlayer}) {
        bloc.add(NewGame(mode, humanPlayer: humanPlayer ?? Player.x));
      },
    );
  }

  void _showGameOverSheet(Game game) {
    final bloc = context.read<GameBloc>();
    GameBottomSheet.show(
      context: context,
      isInitial: false,
      finishedGame: game,
      onStartGame: (mode, {humanPlayer}) {
        bloc.add(NewGame(mode, humanPlayer: humanPlayer ?? Player.x));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, state) {
            if (state.game.status.isGameOver) {
              if (state.winLine != null) {
                Confetti.launch(
                  context,
                  options: ConfettiOptions(
                    particleCount: 80,
                    spread: 60,
                    colors: [
                      AppColors.oColor,
                      AppColors.grid,
                      AppColors.xColor,
                      Colors.white,
                    ],
                  ),
                );
              }
              Future.delayed(
                state.winLine != null
                    ? const Duration(seconds: 1)
                    : Duration.zero,
                () {
                  if (mounted) _showGameOverSheet(state.game);
                },
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final spinnerHeight = state.isLoading ? 36.0 : 0.0;
                    const nonBoardHeight = 36.0 + 16 + 24;
                    final boardSize = min(
                      constraints.maxWidth,
                      constraints.maxHeight - nonBoardHeight - spinnerHeight,
                    ).clamp(300.0, 640.0);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Semantics(liveRegion: true, child: _buildStatus(state)),
                        SizedBox(height: 24),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: state.isLoading
                                ? Border.all(
                                    color: AppColors.background.withAlpha(128),
                                    width: 6,
                                  )
                                : null,
                          ),
                          child: SizedBox(
                            width: boardSize,
                            height: boardSize,
                            child: BoardGrid(
                              game: state.game,
                              lastMoveIndex: state.lastMoveIndex,
                              winLine: state.winLine,
                              onCellTapped: (index) {
                                context.read<GameBloc>().add(CellTapped(index));
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatus(GameState state) {
    final game = state.game;
    final l10n = AppLocalizations.of(context)!;
    final text = game.status.winner != null
        ? l10n.winnerText(_playerName(game.status.winner!))
        : game.status == GameStatus.draw
        ? l10n.draw
        : l10n.playerTurn(_playerName(game.currentPlayer));
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
