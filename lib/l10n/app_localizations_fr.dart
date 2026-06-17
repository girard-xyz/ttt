// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tic-Tac-Toe';

  @override
  String winnerText(String player) {
    return '$player gagne !';
  }

  @override
  String get draw => 'Match nul !';

  @override
  String playerTurn(String player) {
    return 'Tour de $player';
  }

  @override
  String get vsFriend => 'vs Ami';

  @override
  String get vsComputer => 'vs Ordinateur';

  @override
  String get startGame => 'Commencer';

  @override
  String get playAgain => 'Rejouer';

  @override
  String resultWinner(String player) {
    return '$player gagne !';
  }

  @override
  String get resultDraw => 'Match nul !';

  @override
  String get playAsX => 'Jouer en X';

  @override
  String get playAsO => 'Jouer en O';
}
