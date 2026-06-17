import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttt/data/repositories/local_game_repository.dart';
import 'package:ttt/domain/entities/game.dart';
import 'package:ttt/domain/entities/game_mode.dart';
import 'package:ttt/domain/entities/game_status.dart';
import 'package:ttt/domain/entities/player.dart';
import 'package:ttt/domain/repositories/game_repository.dart';
import 'package:ttt/domain/usecases/get_computer_move.dart';
import 'package:ttt/presentation/game/bloc/game_event.dart';
import 'package:ttt/presentation/game/bloc/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _repository;
  final GetComputerMove _getComputerMove;

  GameBloc({
    GameRepository? repository,
    GetComputerMove? getComputerMove,
  })  : _repository = repository ?? LocalGameRepository(),
        _getComputerMove = getComputerMove ?? const GetComputerMove(),
        super(GameState.initial(GameMode.local)) {
    on<CellTapped>(_onCellTapped);
    on<NewGame>(_onNewGame);
    on<LoadGame>(_onLoadGame);
    on<PlayAgain>(_onPlayAgain);
  }

  Future<void> _onCellTapped(CellTapped event, Emitter<GameState> emit) async {
    final game = state.game;
    if (game.status.isGameOver || state.isLoading) return;

    final newGame = game.makeMove(event.index);
    if (newGame == game) return;

    final winLine = newGame.winningLine;
    emit(state.copyWith(
      game: newGame,
      lastMoveIndex: event.index,
      winLine: winLine,
    ));

    await _repository.save(newGame);

    if (!newGame.status.isGameOver &&
        newGame.gameMode == GameMode.vsComputer &&
        newGame.currentPlayer != newGame.humanPlayer) {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(milliseconds: 400));

      final isMaximizing = newGame.currentPlayer == Player.x;
      final aiMove =
          _getComputerMove.execute(newGame.board, isMaximizing: isMaximizing);

      final gameAfterAi = newGame.makeMove(aiMove);
      final aiWinLine = gameAfterAi.winningLine;
      emit(state.copyWith(
        game: gameAfterAi,
        isLoading: false,
        lastMoveIndex: aiMove,
        winLine: aiWinLine,
      ));
      await _repository.save(gameAfterAi);
    }
  }

  void _onNewGame(NewGame event, Emitter<GameState> emit) async {
    final game = Game.initial(event.mode, humanPlayer: event.humanPlayer);
    emit(GameState.initial(event.mode, humanPlayer: event.humanPlayer));
    await _repository.clear();

    if (event.mode == GameMode.vsComputer && game.currentPlayer != game.humanPlayer) {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(milliseconds: 400));
      final aiMove = _getComputerMove.execute(game.board, isMaximizing: true);
      final gameAfterAi = game.makeMove(aiMove);
      emit(state.copyWith(game: gameAfterAi, isLoading: false, lastMoveIndex: aiMove));
      await _repository.save(gameAfterAi);
    }
  }

  Future<void> _onLoadGame(LoadGame event, Emitter<GameState> emit) async {
    final saved = await _repository.load();
    if (saved != null) {
      final winLine = saved.winningLine;
      emit(state.copyWith(game: saved, winLine: winLine));
    }
  }

  void _onPlayAgain(PlayAgain event, Emitter<GameState> emit) {
    final mode = state.game.gameMode;
    final humanPlayer = state.game.humanPlayer;
    add(NewGame(mode, humanPlayer: humanPlayer));
  }
}
