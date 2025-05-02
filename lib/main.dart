import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'zikr_screen.dart';
import 'duas.dart';
import 'full_quran_screen.dart';
import 'gr_duas.dart';
import 'tr_dua.dart';
import 'urdu_duas.dart';

void main() => runApp(const DuaApp());

class DuaApp extends StatelessWidget {
  const DuaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Du\'a',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedLanguage = 'english';

  List<Map<String, String>> getSelectedDuas() {
    if (selectedLanguage == 'german') return grDuas;
    if (selectedLanguage == 'turkish') return trDuas;
    if (selectedLanguage == 'urdu') return urduDuas;
    return duas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/appBackground.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black54,
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Whispers of Faith',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade100,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your daily connection with Allah 🤍',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.teal.shade400,
                    ),
                  ),
                  const SizedBox(height: 24),
                  DropdownButton<String>(
                    value: selectedLanguage,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedLanguage = value;
                        });
                      }
                    },
                    items: const [
                      DropdownMenuItem(value: 'english', child: Text('English')),
                      DropdownMenuItem(value: 'turkish', child: Text('Turkish')),
                      DropdownMenuItem(value: 'german', child: Text('German')),
                      DropdownMenuItem(value: 'urdu', child: Text('Urdu')),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildButton(
                          context,
                          text: 'Quranic Duas',
                          icon: Icons.menu_book,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuranicDuaScreen(duas: getSelectedDuas()),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildButton(
                          context,
                          text: 'Full Quran',
                          icon: Icons.auto_stories,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => FullQuranScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildButton(
                          context,
                          text: 'Qibla',
                          icon: Icons.explore,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen(featureName: 'Qibla')));
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildButton(
                          context,
                          text: 'Calendar',
                          icon: Icons.calendar_month,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen(featureName: 'Calendar')));
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildButton(
                          context,
                          text: 'Zikr',
                          icon: Icons.favorite,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const ZikrScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Made by Mohamad Al Aktaa',
                      style: TextStyle(fontSize: 14, color: Colors.teal.shade300),
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

  Widget _buildButton(BuildContext context, {required String text, required IconData icon, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 8,
          shadowColor: Colors.tealAccent,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        icon: Icon(icon, size: 26),
        label: Text(text),
        onPressed: onPressed,
      ),
    );
  }
}

// The rest of your Dua screens (QuranicDuaScreen, TodayDuaPage, BrowseDuaPage, etc.) remain the same as you've posted.


class QuranicDuaScreen extends StatelessWidget {
  final List<Map<String, String>> duas;
  const QuranicDuaScreen({super.key, required this.duas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quranic Duas')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            _buildMenuButton(context, 'Today\'s Du’a', Icons.today, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => TodayDuaPage(duas: duas)));
            }),
            const SizedBox(height: 16),
            _buildMenuButton(context, 'Browse Du’as', Icons.list, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => BrowseDuaPage(duas: duas)));
            }),
            const SizedBox(height: 16),
            _buildMenuButton(context, 'Random Du’a', Icons.shuffle, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => RandomDuaPage(duas: duas)));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class TodayDuaPage extends StatelessWidget {
  final List<Map<String, String>> duas;
  const TodayDuaPage({super.key, required this.duas});

  @override
  Widget build(BuildContext context) {
    final todayDua = duas[DateTime.now().day % duas.length];
    return Scaffold(
      appBar: AppBar(title: const Text('Today\'s Du’a')),
      body: DuaDisplayCard(dua: todayDua),
    );
  }
}

class BrowseDuaPage extends StatelessWidget {
  final List<Map<String, String>> duas;
  const BrowseDuaPage({super.key, required this.duas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browse Du’as')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: duas.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: DuaContent(dua: duas[index]),
            ),
          );
        },
      ),
    );
  }
}

class RandomDuaPage extends StatefulWidget {
  final List<Map<String, String>> duas;
  const RandomDuaPage({super.key, required this.duas});

  @override
  State<RandomDuaPage> createState() => _RandomDuaPageState();
}

class _RandomDuaPageState extends State<RandomDuaPage> {
  late Map<String, String> randomDua;

  @override
  void initState() {
    super.initState();
    _getRandomDua();
  }

  void _getRandomDua() {
    final random = Random();
    setState(() {
      randomDua = widget.duas[random.nextInt(widget.duas.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    final fullText = '${randomDua['arabic'] ?? ''}\n${randomDua['english'] ?? ''}\nSource: ${randomDua['source'] ?? ''}';
    return Scaffold(
      appBar: AppBar(title: const Text('Random Du’a')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DuaContent(dua: randomDua),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _getRandomDua,
              icon: const Icon(Icons.refresh),
              label: const Text('Get Another'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Share.share(fullText),
              icon: const Icon(Icons.share),
              label: const Text('Share Du’a'),
            ),
          ],
        ),
      ),
    );
  }
}

class DuaDisplayCard extends StatelessWidget {
  final Map<String, String> dua;
  const DuaDisplayCard({super.key, required this.dua});

  @override
  Widget build(BuildContext context) {
    final fullText = '${dua['arabic'] ?? ''}\n${dua['english'] ?? ''}\nSource: ${dua['source'] ?? ''}';
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DuaContent(dua: dua),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Share.share(fullText),
            icon: const Icon(Icons.share),
            label: const Text('Share Du’a'),
          ),
        ],
      ),
    );
  }
}

class DuaContent extends StatelessWidget {
  final Map<String, String> dua;
  const DuaContent({super.key, required this.dua});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dua['arabic'] ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(height: 12),
        Text(
          dua['english'] ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Text(
          dua['source'] ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.teal.shade300),
        ),
      ],
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String featureName;
  const PlaceholderScreen({super.key, required this.featureName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(featureName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pending, size: 64, color: Colors.teal.shade300),
            const SizedBox(height: 24),
            Text(
              '$featureName feature\ncoming soon!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.teal.shade400, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
