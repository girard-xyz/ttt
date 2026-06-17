import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttt/presentation/game/game_bloc.dart';
import 'package:ttt/presentation/game/game_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TttApp());
}

class TttApp extends StatelessWidget {
  const TttApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: BlocProvider(
        create: (_) => GameBloc(),
        child: const GamePage(),
      ),
    );
  }
}
