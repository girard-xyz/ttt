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
  String get localGame => 'Local Game';

  @override
  String get againstComputer => 'Against Computer';

  @override
  String get startGameTitle => 'Start a game!';

  @override
  String resultWinner(String player) {
    return '$player Wins!';
  }

  @override
  String get resultDraw => 'It\'s a Draw!';

  @override
  String get cellPos0 => 'Top left';

  @override
  String get cellPos1 => 'Top center';

  @override
  String get cellPos2 => 'Top right';

  @override
  String get cellPos3 => 'Center left';

  @override
  String get cellPos4 => 'Center';

  @override
  String get cellPos5 => 'Center right';

  @override
  String get cellPos6 => 'Bottom left';

  @override
  String get cellPos7 => 'Bottom center';

  @override
  String get cellPos8 => 'Bottom right';

  @override
  String get cellEmpty => 'Empty';

  @override
  String get cellX => 'X';

  @override
  String get cellO => 'O';

  @override
  String get boardLabel => 'Tic-tac-toe board';

  @override
  String get loadingLabel => 'Thinking...';
}
