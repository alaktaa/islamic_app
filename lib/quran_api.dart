// lib/quran_api.dart

import 'dart:convert';

import 'package:http/http.dart' as http;

class QuranAPI {
  static Future<List<String>> fetchSurahAyahs(int surahNumber) async {
    final url = Uri.parse('https://api.alquran.cloud/v1/surah/$surahNumber');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final ayahs = data['data']['ayahs'] as List;
      return ayahs.map((ayah) => ayah['text'] as String).toList();
    } else {
      throw Exception('Failed to load surah');
    }
  }
  static List<Map<String, dynamic>> surahs = [
    {
      "number": 1,
      "englishName": "Al-Fatiha",
      "arabicName": "الفاتحة",
      "numberOfAyahs": 7,
    },
    {
      "number": 2,
      "englishName": "Al-Baqarah",
      "arabicName": "البقرة",
      "numberOfAyahs": 286,
    },
    {
      "number": 3,
      "englishName": "Aal-Imran",
      "arabicName": "آل عمران",
      "numberOfAyahs": 200,
    },
    {
      "number": 4,
      "englishName": "An-Nisa",
      "arabicName": "النساء",
      "numberOfAyahs": 176,
    },
    {
      "number": 5,
      "englishName": "Al-Ma'idah",
      "arabicName": "المائدة",
      "numberOfAyahs": 120,
    },
    // Add more surahs here if needed...
  ];
}
