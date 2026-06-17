import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttt/core/colors.dart';
import 'package:ttt/domain/entities/game.dart';
import 'package:ttt/domain/entities/game_status.dart';
import 'package:ttt/domain/entities/player.dart';
import 'package:ttt/l10n/app_localizations.dart';
import 'package:ttt/presentation/game/game_bloc.dart';
import 'package:ttt/presentation/game/game_event.dart';
import 'package:ttt/presentation/game/game_state.dart';
import 'package:ttt/presentation/widgets/board_grid.dart';
import 'package:ttt/presentation/widgets/game_bottom_sheet.dart';

String _playerName(Player player) =>
    player == Player.x ? 'X' : 'O';

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatus(state),
                    const SizedBox(height: 16),
                    Flexible(
                      child: BoardGrid(
                        game: state.game,
                        lastMoveIndex: state.lastMoveIndex,
                        winLine: state.winLine,
                        onCellTapped: (index) {
                          context.read<GameBloc>().add(CellTapped(index));
                        },
                      ),
                    ),
                    if (state.isLoading)
                      const Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                  ],
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
