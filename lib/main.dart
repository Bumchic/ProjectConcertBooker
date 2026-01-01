import 'package:concertbooker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite_dev.dart';

void main() {
  InitDatabase();
  runApp(const MyApp());
}

Future<Database> InitDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
  return openDatabase(
    join(await getDatabasesPath(), 'concertdb.db'),
    onCreate: (db, version) {
      db.execute("PRAGMA foreign_keys = ON");
      db.execute(
        'create table Concert(id integer num AUTOINCREMENT primary key, name text not null, date text, description text, price integer, imagelink text);',
      );
      db.execute(
        'create table seat(id integer AUTOINCREMENT primary key, concertID integer, verticalPos integer not null, horizontalPos integer not null'
        'foreign key (concertID) references Concert(id))',
      );
    },
    version: 1
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
