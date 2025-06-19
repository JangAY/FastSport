import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart'; // Import login page

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingContent> onboardingContents = [
    _OnboardingContent(
      image: 'assets/images/surfing.png',
      title: 'Selamat Datang di FastNews',
      subtitle:
          'Nikmati berita olahraga favorit dari seluruh dunia, langsung di genggamanmu.',
    ),
    _OnboardingContent(
      image: 'assets/images/basket.png',
      title: 'Update Setiap Hari',
      subtitle:
          'Dapatkan update skor, jadwal pertandingan, dan berita eksklusif setiap hari.',
    ),
    _OnboardingContent(
      image: 'assets/images/tennis.png',
      title: 'Berita yang Kamu Butuhkan',
      subtitle:
          'FastNews menyajikan informasi yang relevan, cepat, dan sesuai minatmu.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _currentPage == -1
              ? _buildSplashScreen()
              : PageView.builder(
                controller: _pageController,
                itemCount: onboardingContents.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildOnboardingScreen(
                    onboardingContents[index],
                    index,
                  );
                },
              ),
    );
  }

  @override
  void initState() {
    super.initState();
    _showSplashScreen();
  }

  void _showSplashScreen() {
    setState(() {
      _currentPage = -1;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _currentPage = 0;
      });
    });
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget _buildSplashScreen() {
    return Center(
      child: Image.asset(
        'assets/images/logo_FastNews.png',
        width: 500,
        height: 500,
      ),
    );
  }

  Widget _buildOnboardingScreen(_OnboardingContent content, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Image.asset(content.image, height: 280),
          const SizedBox(height: 40),
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            content.subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingContents.length,
              (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == index ? Colors.black : Colors.grey[400],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // Skip langsung ke login page
                  _navigateToLogin();
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (index < onboardingContents.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    // Navigasi ke login page di halaman terakhir
                    _navigateToLogin();
                  }
                },
                child: Text(
                  index == onboardingContents.length - 1
                      ? 'Get Started'
                      : 'Next',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OnboardingContent {
  final String image;
  final String title;
  final String subtitle;

  _OnboardingContent({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
