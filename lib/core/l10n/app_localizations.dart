import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Tic-Tac-Toe'**
  String get appTitle;

  /// Status text when a player wins
  ///
  /// In en, this message translates to:
  /// **'{player} wins!'**
  String winnerText(String player);

  /// Status text when game is a draw
  ///
  /// In en, this message translates to:
  /// **'Draw!'**
  String get draw;

  /// Status text indicating whose turn it is
  ///
  /// In en, this message translates to:
  /// **'{player}\'s turn'**
  String playerTurn(String player);

  /// Button to start a local multiplayer game
  ///
  /// In en, this message translates to:
  /// **'Local Game'**
  String get localGame;

  /// Button to start a game against the computer
  ///
  /// In en, this message translates to:
  /// **'Against Computer'**
  String get againstComputer;

  /// Title shown on the bottom sheet initial state
  ///
  /// In en, this message translates to:
  /// **'Start a game!'**
  String get startGameTitle;

  /// Result text when a player wins (bottom sheet)
  ///
  /// In en, this message translates to:
  /// **'{player} Wins!'**
  String resultWinner(String player);

  /// Result text when game is a draw (bottom sheet)
  ///
  /// In en, this message translates to:
  /// **'It\'s a Draw!'**
  String get resultDraw;

  /// Accessibility label for top-left board cell
  ///
  /// In en, this message translates to:
  /// **'Top left'**
  String get cellPos0;

  /// Accessibility label for top-center board cell
  ///
  /// In en, this message translates to:
  /// **'Top center'**
  String get cellPos1;

  /// Accessibility label for top-right board cell
  ///
  /// In en, this message translates to:
  /// **'Top right'**
  String get cellPos2;

  /// Accessibility label for center-left board cell
  ///
  /// In en, this message translates to:
  /// **'Center left'**
  String get cellPos3;

  /// Accessibility label for center board cell
  ///
  /// In en, this message translates to:
  /// **'Center'**
  String get cellPos4;

  /// Accessibility label for center-right board cell
  ///
  /// In en, this message translates to:
  /// **'Center right'**
  String get cellPos5;

  /// Accessibility label for bottom-left board cell
  ///
  /// In en, this message translates to:
  /// **'Bottom left'**
  String get cellPos6;

  /// Accessibility label for bottom-center board cell
  ///
  /// In en, this message translates to:
  /// **'Bottom center'**
  String get cellPos7;

  /// Accessibility label for bottom-right board cell
  ///
  /// In en, this message translates to:
  /// **'Bottom right'**
  String get cellPos8;

  /// Accessibility label for an empty board cell value
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get cellEmpty;

  /// Accessibility label for cell containing X
  ///
  /// In en, this message translates to:
  /// **'X'**
  String get cellX;

  /// Accessibility label for cell containing O
  ///
  /// In en, this message translates to:
  /// **'O'**
  String get cellO;

  /// Accessibility label for the entire game board
  ///
  /// In en, this message translates to:
  /// **'Tic-tac-toe board'**
  String get boardLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
