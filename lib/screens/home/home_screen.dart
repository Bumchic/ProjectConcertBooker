import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import '../admin/admin_dashboard.dart';
import 'list_concert.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(appState.isAdminMode ? 'Admin Dashboard' : 'Concert Booker'),
        actions: [
          IconButton(
            icon: Icon(
              appState.isAdminMode
                  ? Icons.exit_to_app
                  : Icons.admin_panel_settings,
            ),
            onPressed: () => appState.toggleAdminMode(),
          )
        ],
      ),
      body: appState.isAdminMode
          ? const AdminDashboard()
          : FutureBuilder(future: appState.dbmanager.GetConcertList(), builder:
      (context, snapshot){
            Widget widget = CircularProgressIndicator();
            if(snapshot.hasData)
              {
                widget = UserHome(concerts: snapshot.data!);
              }
            if(snapshot.hasError)
              {
                widget = Text(snapshot.error.toString());
              }
            return widget;
      })
    );
  }
}
