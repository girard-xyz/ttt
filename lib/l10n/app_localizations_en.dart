// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tic-Tac-Toe';

  @override
  String winnerText(String player) {
    return '$player wins!';
  }

  @override
  String get draw => 'Draw!';

  @override
  String playerTurn(String player) {
    return '$player\'s turn';
  }

  @override
  String get vsFriend => 'vs Friend';

  @override
  String get vsComputer => 'vs Computer';

  @override
  String get startGame => 'Start Game';

  @override
  String get playAgain => 'Play Again';

  @override
  String resultWinner(String player) {
    return '$player Wins!';
  }

  @override
  String get resultDraw => 'It\'s a Draw!';

  @override
  String get playAsX => 'Play as X';

  @override
  String get playAsO => 'Play as O';
}
