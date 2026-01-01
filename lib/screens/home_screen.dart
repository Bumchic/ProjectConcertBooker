
import 'package:concertbooker/screens/admin/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concertbooker/app_state.dart';
import 'user/seat_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final concerts = appState.concerts;

        return Scaffold(
          appBar: AppBar(
            title: Text(appState.isAdminMode ? "Admin Panel" : "Concert Booker"),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(
                  appState.isAdminMode ? Icons.admin_panel_settings : Icons.person,
                  size: 28,
                ),
                tooltip: appState.isAdminMode ? "Switch to User Mode" : "Switch to Admin Mode",
                onPressed: () {
                  appState.toggleAdminMode();

                  // Feedback khi chuyển mode
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        appState.isAdminMode ? "🛡️ Admin Mode Activated" : "👤 User Mode",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: appState.isAdminMode ? Colors.red[700] : Colors.deepPurple,
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),

          // Nội dung chính: chuyển đổi theo mode
          body: appState.isAdminMode
              ? const AdminDashboard()
              : concerts.isEmpty
              ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 16),
                Text(
                  "No concerts available yet",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  "Ask admin to create some shows!",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: concerts.length,
            itemBuilder: (context, index) {
              final concert = concerts[index];

              // Tính số ghế còn trống
              int availableSeats = 0;
              for (var row in concert.seats.seatarray) {
                for (var seat in row) {
                  if (seat == 1) availableSeats++;
                }
              }

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => SeatSelectionScreen(concert: concert),
                    //   ),
                    // );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Ảnh concert
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            concert.imagelink,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.music_note, size: 50, color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Thông tin
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                concert.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Total seats: ${concert.seats.Totalseat}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                "Available: $availableSeats seats",
                                style: TextStyle(
                                  color: availableSeats > 0 ? Colors.green[700] : Colors.red[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Nút mũi tên
                        const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}