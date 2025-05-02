import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FullQuranScreen extends StatefulWidget {
  const FullQuranScreen({super.key});

  @override
  State<FullQuranScreen> createState() => _FullQuranScreenState();
}

class _FullQuranScreenState extends State<FullQuranScreen> {
  List<dynamic> surahs = [];
  List<dynamic> filteredSurahs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    final url = Uri.parse('https://api.alquran.cloud/v1/quran/quran-uthmani');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        surahs = data['data']['surahs'];
        filteredSurahs = surahs;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load Quran data');
    }
  }

  String removeArabicHarakats(String input) {
    final diacriticRegex = RegExp(r'[\u064B-\u0652\u0670\u06D6-\u06ED]');
    return input.replaceAll(diacriticRegex, '');
  }

  void filterSurahs(String query) {
    final lowerQuery = query.toLowerCase();
    final strippedQuery = removeArabicHarakats(query);

    final results =
        surahs.where((surah) {
          final english = surah['englishName'].toLowerCase();
          final arabic = surah['name'];
          final arabicStripped = removeArabicHarakats(arabic);
          final number = surah['number'].toString();
          return english.contains(lowerQuery) ||
              arabicStripped.contains(strippedQuery) ||
              number.contains(lowerQuery);
        }).toList();

    setState(() {
      filteredSurahs = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Full Quran')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      onChanged: filterSurahs,
                      decoration: InputDecoration(
                        hintText: 'Search Surah...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredSurahs.length,
                      itemBuilder: (context, index) {
                        final surah = filteredSurahs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.teal.shade100,
                                child: Text(
                                  surah['number'].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              title: Text(
                                surah['englishName'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                surah['name'],
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'KFGQPC',
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SurahView(surah: surah),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}

class SurahView extends StatelessWidget {
  final Map<String, dynamic> surah;

  const SurahView({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final int surahNumber = surah['number'];
    final List<dynamic> ayahs = List.from(surah['ayahs']);
    final List<Widget> content = [];

    final isFatiha = surahNumber == 1;
    const bismillahText = 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ';

    if (isFatiha) {
      content.add(_buildAyahCard(ayahs[0]['numberInSurah'], ayahs[0]['text']));
      for (int i = 1; i < ayahs.length; i++) {
        final ayah = ayahs[i];
        content.add(_buildAyahCard(ayah['numberInSurah'], ayah['text']));
      }
    } else {
      content.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              bismillahText,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

      if ((ayahs[0]['text'] as String).startsWith(bismillahText)) {
        ayahs[0]['text'] =
            (ayahs[0]['text'] as String).replaceFirst(bismillahText, '').trim();
      }

      for (int i = 0; i < ayahs.length; i++) {
        final ayah = ayahs[i];
        content.add(_buildAyahCard(ayah['numberInSurah'], ayah['text']));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('${surah['englishName']} (${surah['name']})')),
      body: ListView(padding: const EdgeInsets.all(16), children: content),
    );
  }

  Widget _buildAyahCard(int number, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
          // Subtle cream gold gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFD4AF37), width: 1.5), // Golden edge
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD4AF37).withOpacity(0.4), // Golden glow
            blurRadius: 12,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Decorative top line (like a small motif or Bismillah)
            const Divider(
              color: Color(0xFFD4AF37),
              thickness: 1.2,
              indent: 50,
              endIndent: 50,
            ),
            const SizedBox(height: 6),

            // Ayah number badge
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                color: Color(0xFFD4AF37),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'آية $number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 16),

            // Arabic text
            Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                height: 1.8,
                fontFamily: 'KFGQPC',
                // Optional: your Arabic Quran font
                color: Colors.black87,
                shadows: [
                  Shadow(
                    blurRadius: 1,
                    color: Colors.black12,
                    offset: Offset(0.5, 0.5),
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
