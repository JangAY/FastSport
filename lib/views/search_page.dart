import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> searchResults = [
    {
      'image': 'assets/images/tech.png',
      'title': 'Tech Giants Unveil New AI',
      'category': 'Technology',
      'time': '2d ago',
    },
    {
      'image': 'assets/images/business.png',
      'title': 'Market Reacts to Economic',
      'category': 'Business',
      'time': '1d ago',
    },
    {
      'image': 'assets/images/politics.png',
      'title': 'Government Announces New',
      'category': 'Politics',
      'time': '3d ago',
    },
    {
      'image': 'assets/images/science.png',
      'title': 'Breakthrough in Renewable',
      'category': 'Science',
      'time': '4d ago',
    },
    {
      'image': 'assets/images/health.png',
      'title': 'New Study on Global Health',
      'category': 'Health',
      'time': '5d ago',
    },
    {
      'image': 'assets/images/sport.png',
      'title': 'Sports Team Wins Championship',
      'category': 'Sport',
      'time': '6d ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Theme.of(context).colorScheme.primary;

    return Column( // Mulai langsung dari Column
      children: [
        AppBar( // AppBar kustom
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Search',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        Expanded( // Bungkus sisa konten dengan Expanded
          child: Padding( // Pindahkan padding ke sini
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.poppins(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: Colors.grey[500]),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    onSubmitted: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Searching for: $value')),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Tabs: Top, Latest
                TabBar(
                  controller: _tabController,
                  indicatorColor: primaryBlue,
                  labelColor: primaryBlue,
                  unselectedLabelColor: Colors.grey[600],
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: 'Top'),
                    Tab(text: 'Latest'),
                  ],
                ),
                const SizedBox(height: 16),

                // Search Results List (Expanded agar mengambil sisa ruang)
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final news = searchResults[index];
                          // Pastikan SearchResultItem diakses dengan benar
                          return SearchResultItem(
                            imageUrl: news['image']!,
                            title: news['title']!,
                            category: news['category']!,
                            timeAgo: news['time']!,
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final news = searchResults[index];
                          // Pastikan SearchResultItem diakses dengan benar
                          return SearchResultItem(
                            imageUrl: news['image']!,
                            title: news['title']!,
                            category: news['category']!,
                            timeAgo: news['time']!,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// Widget untuk Setiap Item Hasil Pencarian
// Pindahkan definisi kelas ini ke sini agar dapat diakses oleh _SearchPageState
// =========================================================================
class SearchResultItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String timeAgo;

  const SearchResultItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Gambar Kategori/Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image asset: $imageUrl, Exception: $error');
                return Container(
                  width: 72,
                  height: 72,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, size: 30, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          // Judul dan Detail Berita
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$category • $timeAgo',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
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