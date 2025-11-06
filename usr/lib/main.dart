import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

void main() {
  runApp(const SuperSocialMediaApp());
}

class SuperSocialMediaApp extends StatelessWidget {
  const SuperSocialMediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Social Media',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SocialMediaHomePage(),
    );
  }
}

class SocialMediaHomePage extends StatefulWidget {
  const SocialMediaHomePage({super.key});

  @override
  State<SocialMediaHomePage> createState() => _SocialMediaHomePageState();
}

class _SocialMediaHomePageState extends State<SocialMediaHomePage> with SingleTickerProviderStateMixin {
  bool _showStickyAd = false;
  bool _showPremiumCloseButton = false;
  bool _premiumAdVisible = true;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    // Show sticky ad after 5 seconds
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showStickyAd = true;
        });
      }
    });

    // Show premium ad close button after 30 seconds
    Timer(const Duration(seconds: 30), () {
      if (mounted) {
        setState(() {
          _showPremiumCloseButton = true;
        });
      }
    });

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _openSocial(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    color: Colors.black.withOpacity(0.3),
                    child: const SafeArea(
                      bottom: false,
                      child: Text(
                        '🌐 Super Social Media 0.1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  // Social Media Icons
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildSocialCard('Facebook', 'https://cdn-icons-png.flaticon.com/512/733/733547.png', 'https://www.facebook.com'),
                        _buildSocialCard('Instagram', 'https://cdn-icons-png.flaticon.com/512/733/733558.png', 'https://www.instagram.com'),
                        _buildSocialCard('Twitter (X)', 'https://cdn-icons-png.flaticon.com/512/733/733579.png', 'https://www.twitter.com'),
                        _buildSocialCard('YouTube', 'https://cdn-icons-png.flaticon.com/512/1384/1384060.png', 'https://www.youtube.com'),
                        _buildSocialCard('WhatsApp', 'https://cdn-icons-png.flaticon.com/512/733/733585.png', 'https://web.whatsapp.com'),
                        _buildSocialCard('Telegram', 'https://cdn-icons-png.flaticon.com/512/2111/2111646.png', 'https://t.me'),
                        _buildSocialCard('TikTok', 'https://cdn-icons-png.flaticon.com/512/3046/3046125.png', 'https://www.tiktok.com'),
                      ],
                    ),
                  ),

                  // Ad Placeholders
                  _buildAdContainer('Sponsored'),
                  _buildAdContainer('Advertisement'),
                  _buildAdContainer('Ads'),
                  _buildAdContainer('🔥 Ads'),
                  _buildAdContainer('🌟 New Ad'),

                  // Premium Ad
                  if (_premiumAdVisible)
                    _buildPremiumAdContainer(),

                  const SizedBox(height: 20),
                  const Text(
                    'Developed by Rs Riyajul Khan ❤️',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Help Center Button
            Positioned(
              bottom: 90,
              right: 20,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00ffc8).withOpacity(0.4 + (_pulseController.value * 0.4)),
                          blurRadius: 10 + (_pulseController.value * 10),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // Messenger functionality would be implemented here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Opening Messenger...')),
                          );
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF00b2ff), Color(0xFF00ff99)],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Messenger_icon.svg',
                              width: 35,
                              height: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Sticky Ad
            if (_showStickyAd)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: _showStickyAd ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    color: Colors.black.withOpacity(0.85),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 320,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Ad Placeholder',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -12,
                          right: 20,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showStickyAd = false;
                              });
                            },
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(
                                  '×',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialCard(String name, String iconUrl, String url) {
    return GestureDetector(
      onTap: () => _openSocial(url),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              iconUrl,
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image, size: 50);
              },
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFF444444),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdContainer(String title) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: const BoxConstraints(maxWidth: 350),
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Ad Placeholder',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumAdContainer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: const BoxConstraints(maxWidth: 350),
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const Text(
                '💎 Premium Ad',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Premium Ad Placeholder',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
          if (_showPremiumCloseButton)
            Positioned(
              top: -12,
              right: -10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _premiumAdVisible = false;
                  });
                },
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '×',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media'),
        backgroundColor: const Color(0xFF2193b0),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
