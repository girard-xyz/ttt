import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttt/domain/entities/cell_value.dart';
import 'package:ttt/domain/entities/game_mode.dart';
import 'package:ttt/domain/entities/game_status.dart';
import 'package:ttt/presentation/game/bloc/game_bloc.dart';
import 'package:ttt/presentation/game/bloc/game_event.dart';
import 'package:ttt/presentation/game/bloc/game_state.dart';

void main() {
  group('GameBloc', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    blocTest<GameBloc, GameState>(
      'emits initial state with local mode',
      build: () => GameBloc(),
      expect: () => [],
    );

    blocTest<GameBloc, GameState>(
      'places X on cell tap',
      build: () => GameBloc(),
      act: (bloc) => bloc.add(const CellTapped(4)),
      expect: () => [
        isA<GameState>().having(
          (s) => s.game.board[4],
          'cell 4 is X',
          CellValue.x,
        ),
      ],
    );

    blocTest<GameBloc, GameState>(
      'starts new game in local mode',
      build: () => GameBloc(),
      act: (bloc) {
        bloc.add(const NewGame(GameMode.local));
      },
      expect: () => [
        isA<GameState>().having(
          (s) => s.game.gameMode,
          'game mode local',
          GameMode.local,
        ),
      ],
    );

    blocTest<GameBloc, GameState>(
      'cannot tap occupied cell',
      build: () => GameBloc(),
      act: (bloc) {
        bloc.add(const CellTapped(4));
        bloc.add(const CellTapped(4));
      },
      expect: () => [
        isA<GameState>().having(
          (s) => s.game.board[4],
          'cell 4 is X',
          CellValue.x,
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.game.board[4], CellValue.x);
      },
    );

    blocTest<GameBloc, GameState>(
      'detects win and shows win line',
      build: () => GameBloc(),
      act: (bloc) {
        bloc.add(const CellTapped(0));
        bloc.add(const CellTapped(3));
        bloc.add(const CellTapped(1));
        bloc.add(const CellTapped(4));
        bloc.add(const CellTapped(2));
      },
      expect: () => [
        isA<GameState>(),
        isA<GameState>(),
        isA<GameState>(),
        isA<GameState>(),
        isA<GameState>()
            .having((s) => s.game.status, 'status', GameStatus.xWins)
            .having((s) => s.winLine, 'winLine', [0, 1, 2]),
      ],
    );
  });
}
