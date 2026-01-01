// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../app_state.dart';
// import 'admin/admin_dashboard.dart';
// import '../Concert.dart';
// import '../ConcertDetail.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final appState = context.watch<AppState>();
//
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//
//       // SỬA LỖI Ở ĐÂY:
//       // Nếu là Admin -> Hiện AppBar chuẩn để có nút thoát.
//       // Nếu là User -> null (để dùng Header tùy chỉnh bên dưới cho đẹp).
//       appBar: appState.isAdminMode
//           ? AppBar(
//         title: const Text("Admin Dashboard"),
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//         actions: [
//           TextButton.icon(
//             onPressed: () => appState.toggleAdminMode(),
//             icon: const Icon(Icons.exit_to_app, color: Colors.white),
//             label: const Text("Exit Admin", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       )
//           : null,
//
//       // Phần thân:
//       body: appState.isAdminMode
//           ? const AdminDashboard()
//           : SafeArea(
//         child: Column(
//           children: [
//             _buildCustomAppBar(context, appState), // Header của User
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//                     _buildSectionTitle("Hot Events 🔥"),
//                     _buildFeaturedSlider(appState, context),
//                     const SizedBox(height: 20),
//                     _buildSectionTitle("Upcoming Concerts 📅"),
//                     _buildVerticalList(appState, context),
//                     const SizedBox(height: 80),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // --- Các Widget con giữ nguyên như cũ ---
//
//   // CẬP NHẬT HÀM NÀY TRONG home_screen.dart
//   Widget _buildCustomAppBar(BuildContext context, AppState appState) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             // --- THAY ĐỔI Ở ĐÂY ---
//             child: InkWell(
//               onTap: () {
//                 // Gọi giao diện tìm kiếm chuyên nghiệp của Flutter
//                 showSearch(
//                   context: context,
//                   delegate: ConcertSearchDelegate(concerts: appState.concerts),
//                 );
//               },
//               borderRadius: BorderRadius.circular(12), // Bo góc hiệu ứng bấm
//               child: Container(
//                 height: 45,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey[300]!), // Thêm viền nhẹ cho rõ
//                 ),
//                 child: const Row(
//                   children: [
//                     SizedBox(width: 15),
//                     Icon(Icons.search, color: Colors.grey),
//                     SizedBox(width: 10),
//                     Text("Search for events...", style: TextStyle(color: Colors.grey)),
//                   ],
//                 ),
//               ),
//             ),
//             // ---------------------
//           ),
//           const SizedBox(width: 15),
//           InkWell(
//             onTap: () => appState.toggleAdminMode(),
//             child: CircleAvatar(
//               backgroundColor: Colors.deepPurple.withOpacity(0.1),
//               child: const Icon(
//                 Icons.admin_panel_settings,
//                 color: Colors.deepPurple,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
//       ),
//     );
//   }
//
//   // Thay thế hàm này trong home_screen.dart
//   Widget _buildFeaturedSlider(AppState appState, BuildContext context) {
//     if (appState.concerts.isEmpty) return _buildEmptyState();
//
//     return SizedBox(
//       height: 220,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.only(left: 20),
//         itemCount: appState.concerts.length,
//         itemBuilder: (context, index) {
//           final concert = appState.concerts[index];
//
//           return Container(
//             width: 300,
//             margin: const EdgeInsets.only(right: 15),
//             // ClipRRect để bo góc cả ảnh lẫn lớp phủ gradient
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Concertdetail(concert: concert)),
//                   );
//                 },
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     // 1. LỚP ẢNH NỀN
//                     Image.network(
//                       concert.imagelink,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => Container(color: Colors.grey[300]),
//                     ),
//
//                     // 2. LỚP PHỦ GRADIENT (QUAN TRỌNG: Giúp chữ luôn nổi bật)
//                     Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       height: 150, // Chiều cao của lớp phủ đen
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.transparent,       // Ở trên trong suốt
//                               Colors.black.withOpacity(0.8), // Ở dưới đen đậm
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     // 3. LỚP NỘI DUNG CHỮ (Đè lên gradient)
//                     Positioned(
//                       bottom: 15,
//                       left: 15,
//                       right: 15,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Tag HOT
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                             decoration: BoxDecoration(
//                                 color: Colors.redAccent,
//                                 borderRadius: BorderRadius.circular(4)
//                             ),
//                             child: const Text(
//                                 "HOT",
//                                 style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//
//                           // Tên Concert
//                           Text(
//                             concert.name,
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 // Thêm bóng đổ nhẹ cho chữ nét hơn nữa
//                                 shadows: [
//                                   Shadow(blurRadius: 4, color: Colors.black, offset: Offset(0, 2))
//                                 ]
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//
//                           // Ngày tháng
//                           const SizedBox(height: 4),
//                           Text(
//                             concert.date,
//                             style: const TextStyle(color: Colors.white70, fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildVerticalList(AppState appState, BuildContext context) {
//     if (appState.concerts.isEmpty) return const SizedBox.shrink();
//
//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       itemCount: appState.concerts.length,
//       itemBuilder: (context, index) {
//         final concert = appState.concerts[index];
//         return Container(
//           margin: const EdgeInsets.only(bottom: 15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
//             ],
//           ),
//           child: InkWell( // Thêm InkWell để có hiệu ứng khi bấm
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Concertdetail(concert: concert)),
//               );
//             },
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
//                   child: Image.network(
//                     concert.imagelink,
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_,__,___) => Container(width: 100, height: 100, color: Colors.grey[300]),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           concert.name,
//                           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Icon(Icons.calendar_month, size: 14, color: Colors.grey[600]),
//                             const SizedBox(width: 4),
//                             Text(concert.date, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "\$${concert.price}",
//                               style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 16),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                               decoration: BoxDecoration(
//                                 color: Colors.deepPurple.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: const Text("Buy", style: TextStyle(color: Colors.deepPurple, fontSize: 12, fontWeight: FontWeight.bold)),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return const Padding(
//       padding: EdgeInsets.all(20.0),
//       child: Center(child: Text("No events found. Switch to Admin to add data!")),
//     );
//   }
// }
// // --- Dán đoạn này xuống cuối file home_screen.dart ---
//
// class ConcertSearchDelegate extends SearchDelegate {
//   final List<dynamic> concerts; // Danh sách dữ liệu gốc
//
//   ConcertSearchDelegate({required this.concerts});
//
//   // 1. Nút xóa (Clear) bên phải thanh tìm kiếm
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = ''; // Xóa từ khóa
//         },
//       ),
//     ];
//   }
//
//   // 2. Nút quay lại (Back) bên trái
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null); // Đóng màn hình tìm kiếm
//       },
//     );
//   }
//
//   // 3. Hiển thị kết quả khi nhấn Enter (Ở đây ta cho hiện luôn khi gõ)
//   @override
//   Widget buildResults(BuildContext context) {
//     return _buildList(context);
//   }
//
//   // 4. Hiển thị danh sách gợi ý khi đang gõ
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return _buildList(context);
//   }
//
//   // Hàm phụ để vẽ danh sách lọc
//   Widget _buildList(BuildContext context) {
//     // Logic lọc: Tên concert chứa từ khóa (không phân biệt hoa thường)
//     final results = concerts.where((concert) {
//       return concert.name.toLowerCase().contains(query.toLowerCase());
//     }).toList();
//
//     if (results.isEmpty) {
//       return Center(
//         child: Text(
//           "No concerts found for '$query'",
//           style: const TextStyle(color: Colors.grey, fontSize: 16),
//         ),
//       );
//     }
//
//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final concert = results[index];
//         return ListTile(
//           leading: Image.network(
//             concert.imagelink,
//             width: 50,
//             height: 50,
//             fit: BoxFit.cover,
//             errorBuilder: (_,__,___) => const Icon(Icons.image),
//           ),
//           title: Text(concert.name, style: const TextStyle(fontWeight: FontWeight.bold)),
//           subtitle: Text(concert.date),
//           trailing: Text("\$${concert.price}", style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
//           onTap: () {
//             close(context, null); // Đóng tìm kiếm
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Concertdetail(concert: concert)),
//             );
//           },
//         );
//       },
//     );
//   }
// }
