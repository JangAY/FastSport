import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  // Data dummy untuk daftar bookmark
  final List<Map<String, String>> bookmarkedArticles = [
    {
      'image': 'assets/images/tech.png', // Ganti dengan gambar thumbnail atau placeholder
      'title': 'Tech Giants Unveil New AI',
      'category': 'Technology',
      'time': '2d ago',
    },
    {
      'image': 'assets/images/science.png',
      'title': 'Breakthrough Discovery in',
      'category': 'Science',
      'time': '3d ago',
    },
    {
      'image': 'assets/images/business.png',
      'title': 'Global Markets React to',
      'category': 'Business',
      'time': '4d ago',
    },
    {
      'image': 'assets/images/politics.png',
      'title': 'Government Announces New',
      'category': 'Politics',
      'time': '5d ago',
    },
    {
      'image': 'assets/images/sport.png',
      'title': 'Local Team Wins',
      'category': 'Sports',
      'time': '6d ago',
    },
    {
      'image': 'assets/images/health.png',
      'title': 'Health Research Progress',
      'category': 'Health',
      'time': '1w ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
            'Bookmarks',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        Expanded( // Bungkus konten list dengan Expanded
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: bookmarkedArticles.isEmpty
                ? Center(
                    child: Text(
                      'No bookmarks yet. Start saving articles!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: bookmarkedArticles.length,
                    itemBuilder: (context, index) {
                      final article = bookmarkedArticles[index];
                      // Pastikan BookmarkedArticleItem diakses dengan benar
                      return BookmarkedArticleItem(
                        imageUrl: article['image']!,
                        title: article['title']!,
                        category: article['category']!,
                        timeAgo: article['time']!,
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// Widget untuk Setiap Item Artikel yang Di-bookmark
// Pindahkan definisi kelas ini ke sini agar dapat diakses oleh _BookmarksPageState
// =========================================================================
class BookmarkedArticleItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String timeAgo;

  const BookmarkedArticleItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped on: $title')),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl.startsWith('http')
                  ? Image.network(
                      imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading network image: $imageUrl, Exception: $error');
                        return Container(
                          width: 90,
                          height: 90,
                          color: Colors.grey[200],
                          child: const Icon(Icons.collections_bookmark_outlined, size: 40, color: Colors.grey),
                        );
                      },
                    )
                  : Image.asset(
                      imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading asset image: $imageUrl, Exception: $error');
                        return Container(
                          width: 90,
                          height: 90,
                          color: Colors.grey[200],
                          child: const Icon(Icons.collections_bookmark_outlined, size: 40, color: Colors.grey),
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
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
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
      ),
    );
  }
}