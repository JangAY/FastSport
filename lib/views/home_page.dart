import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import halaman-halaman lain untuk BottomNavBar (belum dibuat, hanya placeholder)
import 'search_page.dart';
import 'bookmarks_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Untuk mengontrol BottomNavigationBar

  // Daftar halaman untuk BottomNavigationBar
  static final List<Widget> _widgetOptions = <Widget>[
    _HomePageContent(), // Konten Home Page yang sebenarnya
    SearchPage(),
    BookmarksPage(),
    ProfilePage(), // Placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Anda bisa menambahkan navigasi ke halaman lain di sini
    // if (index == 1) { Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage())); }
    // dan seterusnya untuk setiap tab
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Sesuaikan dengan warna background keseluruhan
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF6B73FF), // Warna biru dari desain Anda
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Penting agar semua item terlihat
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
      ),
    );
  }
}

// =========================================================================
// Konten Utama Halaman Home (Dipisah agar lebih rapi)
// =========================================================================
class _HomePageContent extends StatelessWidget {
  const _HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: FastNews & Tagline
            Text(
              'FastNews',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Kabar Terkini, Dari Kami untuk Negeri',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),

            // Trending News Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trending news',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle "See all" trending news
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('See all trending news clicked')),
                    );
                  },
                  child: Text(
                    'See all',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color(0xFF6B73FF), // Warna biru dari desain Anda
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Horizontal Trending News List
            SizedBox(
              height: 250, // Tinggi tetap untuk ListView horizontal
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Contoh 5 item trending news
                itemBuilder: (context, index) {
                  return TrendingNewsCard(
                    // Data dummy, ganti dengan data dari API
                    imageUrl:
                        index == 0
                            ? 'assets/images/persib.png' // Pastikan gambar ini ada di assets
                            : 'https://via.placeholder.com/150', // Placeholder umum
                    category: index == 0 ? 'Sepak Bola' : 'Otomotif',
                    title:
                        index == 0
                            ? 'Persib Juara Liga 1, Rahasia Bojan Hodak Benahi Maung Bandung'
                            : 'Hasil F1 GP Australia: Verstappen Pimpin Latihan, Lando Norris di Urutan Kedua',
                    date: index == 0 ? '24 Mei, 2025' : '23 Mei, 2025',
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // Recommendation Section
            Text(
              'Recommendation',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Vertical Recommendation List
            // Menggunakan Column dan tidak SingleChildScrollView di sini karena sudah ada di parent.
            // Jika data sangat banyak, Anda bisa menggunakan ListView.builder secara langsung di sini
            // dan mengatur PrimaryScrollPhysics-nya.
            Column(
              children: List.generate(
                10, // Contoh 10 item rekomendasi
                (index) => RecommendationNewsItem(
                  // Data dummy, ganti dengan data dari API
                  avatarUrl:
                      'https://via.placeholder.com/50', // Placeholder avatar
                  publisherName: index == 0 ? 'PSSI' : 'CNN Indonesia',
                  isVerified: index == 0 ? true : false,
                  title:
                      index == 0
                          ? 'PSSI Tegaskan Tak Ada Pemain Titipan di Tim Pencari Bakat'
                          : 'Kabar Gempa Hari Ini di Bandung Magnitudo 5.2, Tidak Berpotensi Tsunami',
                  category: index == 0 ? 'Sepak Bola' : 'Nasional',
                ),
              ),
            ),
            const SizedBox(height: 24), // Tambahkan sedikit padding di bawah
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// Widget untuk Kartu Berita Trending
// =========================================================================
class TrendingNewsCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final String date;

  const TrendingNewsCard({
    Key? key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // Lebar kartu
      margin: const EdgeInsets.only(right: 16), // Jarak antar kartu
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  // Fallback to network image if asset fails
                  'https://via.placeholder.com/150',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF6B73FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    category,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B73FF),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// Widget untuk Item Berita Rekomendasi
// =========================================================================
class RecommendationNewsItem extends StatelessWidget {
  final String avatarUrl;
  final String publisherName;
  final bool isVerified;
  final String title;
  final String category;

  const RecommendationNewsItem({
    Key? key,
    required this.avatarUrl,
    required this.publisherName,
    this.isVerified = false,
    required this.title,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(avatarUrl),
                backgroundColor: Colors.grey[200], // Fallback color
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          publisherName,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 4),
                          Icon(
                            Icons.check_circle,
                            color: Color(0xFF6B73FF),
                            size: 14,
                          ),
                        ],
                      ],
                    ),
                    Text(
                      'Jun 11, 2023', // Tanggal berita, bisa dijadikan parameter jika perlu
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                onPressed: () {
                  // Handle more options
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('More options clicked for $publisherName'),
                    ),
                  );
                },
              ),
              // Tambahkan tombol Follow jika diperlukan
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Color(0xFF6B73FF),
              //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //     minimumSize: Size.zero, // Make button size wrap content
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              //   ),
              //   child: Text('Follow', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
              // ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFF6B73FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              category,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B73FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}