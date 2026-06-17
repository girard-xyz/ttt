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
  }

  Future<void> _onCellTapped(CellTapped event, Emitter<GameState> emit) async {
    final game = state.game;
    if (game.status.isGameOver || state.isLoading) return;

    final newGame = game.makeMove(event.index);
    if (newGame == game) return;

    emit(state.copyWith(
      game: newGame,
      lastMoveIndex: event.index,
      winLine: newGame.winningLine,
    ));

    await _persistGame(newGame);

    if (!newGame.status.isGameOver &&
        newGame.gameMode == GameMode.vsComputer &&
        newGame.currentPlayer != newGame.humanPlayer) {
      await _makeAiMove(newGame, emit);
    }
  }

  Future<void> _onNewGame(NewGame event, Emitter<GameState> emit) async {
    final game = Game.initial(event.mode, humanPlayer: event.humanPlayer);
    emit(GameState.initial(event.mode, humanPlayer: event.humanPlayer));
    await _repository.clear();

    if (event.mode == GameMode.vsComputer && game.currentPlayer != game.humanPlayer) {
      await _makeAiMove(game, emit, isMaximizing: true);
    }
  }

  Future<void> _onLoadGame(LoadGame event, Emitter<GameState> emit) async {
    final saved = await _repository.load();
    if (saved != null) {
      emit(state.copyWith(
        game: saved,
        winLine: saved.winningLine,
        isLoaded: true,
      ));
    } else {
      emit(state.copyWith(isLoaded: true));
    }
  }

  Future<void> _persistGame(Game game) async {
    if (game.status.isGameOver) {
      await _repository.clear();
    } else {
      await _repository.save(game);
    }
  }

  Future<void> _makeAiMove(
    Game game,
    Emitter<GameState> emit, {
    bool? isMaximizing,
  }) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 400));

    final maximizing = isMaximizing ?? game.currentPlayer == Player.x;
    final aiMove = _getComputerMove.execute(game.board, isMaximizing: maximizing);
    final gameAfterAi = game.makeMove(aiMove);
    emit(state.copyWith(
      game: gameAfterAi,
      isLoading: false,
      lastMoveIndex: aiMove,
      winLine: gameAfterAi.winningLine,
    ));
    await _persistGame(gameAfterAi);
  }
}
