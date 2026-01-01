import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'app_state.dart';
import 'screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  runApp(const MyApp());
}

Future<void> initDatabase() async {
  await openDatabase(
    join(await getDatabasesPath(), 'concertdb.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('PRAGMA foreign_keys = ON');

      await db.execute('''
        CREATE TABLE Concert (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          date TEXT,
          description TEXT,
          price INTEGER,
          imagelink TEXT
        );
      ''');

      await db.execute('''
        CREATE TABLE Seat (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          concertID INTEGER,
          verticalPos INTEGER NOT NULL,
          horizontalPos INTEGER NOT NULL,
          FOREIGN KEY (concertID) REFERENCES Concert(id)
        );
      ''');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Concert Booker',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
