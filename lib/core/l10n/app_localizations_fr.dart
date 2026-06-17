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
  String get localGame => 'Partie locale';

  @override
  String get againstComputer => 'Contre l\'ordinateur';

  @override
  String get startGameTitle => 'Commencer une partie !';

  @override
  String resultWinner(String player) {
    return '$player gagne !';
  }

  @override
  String get resultDraw => 'Match nul !';

  @override
  String get cellPos0 => 'En haut à gauche';

  @override
  String get cellPos1 => 'En haut au centre';

  @override
  String get cellPos2 => 'En haut à droite';

  @override
  String get cellPos3 => 'Au centre à gauche';

  @override
  String get cellPos4 => 'Au centre';

  @override
  String get cellPos5 => 'Au centre à droite';

  @override
  String get cellPos6 => 'En bas à gauche';

  @override
  String get cellPos7 => 'En bas au centre';

  @override
  String get cellPos8 => 'En bas à droite';

  @override
  String get cellEmpty => 'Vide';

  @override
  String get cellX => 'X';

  @override
  String get cellO => 'O';

  @override
  String get boardLabel => 'Plateau de tic-tac-toe';
}
