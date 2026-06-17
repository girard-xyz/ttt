import 'package:ttt/domain/entities/cell_value.dart';
import 'package:ttt/domain/entities/game.dart';

class GetComputerMove {
  const GetComputerMove();

  int execute(List<CellValue> board, {bool isMaximizing = true}) {
    int bestScore = isMaximizing ? -1000 : 1000;
    int bestMove = _emptyIndices(board).first;

    for (final index in _orderMoves(board)) {
      final newBoard = List<CellValue>.from(board);
      newBoard[index] = isMaximizing ? CellValue.x : CellValue.o;

      final score = _minimax(
        newBoard,
        depth: 0,
        isMaximizing: !isMaximizing,
        alpha: -1000,
        beta: 1000,
      );

      if (isMaximizing) {
        if (score > bestScore) {
          bestScore = score;
          bestMove = index;
        }
      } else {
        if (score < bestScore) {
          bestScore = score;
          bestMove = index;
        }
      }
    }

    return bestMove;
  }

  int _minimax(
    List<CellValue> board, {
    required int depth,
    required bool isMaximizing,
    required int alpha,
    required int beta,
  }) {
    final status = _evaluate(board);
    if (status == _BoardStatus.xWins) return 10 - depth;
    if (status == _BoardStatus.oWins) return depth - 10;
    if (status == _BoardStatus.draw) return 0;

    if (isMaximizing) {
      int maxEval = -1000;
      for (final index in _orderMoves(board)) {
        final newBoard = List<CellValue>.from(board);
        newBoard[index] = CellValue.x;
        final eval = _minimax(
          newBoard,
          depth: depth + 1,
          isMaximizing: false,
          alpha: alpha,
          beta: beta,
        );
        maxEval = eval > maxEval ? eval : maxEval;
        alpha = eval > alpha ? eval : alpha;
        if (beta <= alpha) break;
      }
      return maxEval;
    } else {
      int minEval = 1000;
      for (final index in _orderMoves(board)) {
        final newBoard = List<CellValue>.from(board);
        newBoard[index] = CellValue.o;
        final eval = _minimax(
          newBoard,
          depth: depth + 1,
          isMaximizing: true,
          alpha: alpha,
          beta: beta,
        );
        minEval = eval < minEval ? eval : minEval;
        beta = eval < beta ? eval : beta;
        if (beta <= alpha) break;
      }
      return minEval;
    }
  }

  List<int> _orderMoves(List<CellValue> board) {
    const center = 4;
    const corners = [0, 2, 6, 8];
    const edges = [1, 3, 5, 7];

    final centerEmpty = <int>[];
    final cornerEmpty = <int>[];
    final edgeEmpty = <int>[];
    final otherEmpty = <int>[];

    for (int i = 0; i < board.length; i++) {
      if (board[i] != CellValue.empty) continue;
      if (i == center) {
        centerEmpty.add(i);
      } else if (corners.contains(i)) {
        cornerEmpty.add(i);
      } else if (edges.contains(i)) {
        edgeEmpty.add(i);
      } else {
        otherEmpty.add(i);
      }
    }

    return [...centerEmpty, ...cornerEmpty, ...edgeEmpty, ...otherEmpty];
  }
}

enum _BoardStatus { playing, xWins, oWins, draw }

_BoardStatus _evaluate(List<CellValue> board) {
  for (final pattern in Game.winPatterns) {
    final first = board[pattern[0]];
    if (first == CellValue.empty) continue;
    if (board[pattern[1]] == first && board[pattern[2]] == first) {
      return first == CellValue.x ? _BoardStatus.xWins : _BoardStatus.oWins;
    }
  }
  if (board.every((c) => c.isOccupied)) return _BoardStatus.draw;
  return _BoardStatus.playing;
}

List<int> _emptyIndices(List<CellValue> board) =>
    [for (int i = 0; i < board.length; i++) if (board[i] == CellValue.empty) i];
