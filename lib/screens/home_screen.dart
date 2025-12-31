import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app_state.dart';
import 'admin/admin_dashboard.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});
  Widget build(BuildContext context){
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Concert Booking"),
        actions: [
          IconButton(
            icon: Icon(
              appState.isAdminMode ? Icons.admin_panel_settings: Icons.person,
            ),
            onPressed: () {
              appState.toggleAdminMode();
            },
          ),
        ],
      ),
      body: appState.isAdminMode
          ? const AdminDashboard()
          : const Center(child: Text("User Mode")),
    );
  }
}