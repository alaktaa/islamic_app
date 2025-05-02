// lib/zikr_data.dart

import 'package:quick_app/zikr_item.dart';



final List<ZikrItem> morningZikr = [
  ZikrItem(
    arabic: 'اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ...',
    reference: 'Abu Dawood 5077, Tirmidhi 3529',
    repeat: 1,
    explanation: 'If one recites it in the morning and dies before evening, he will enter Paradise.',
  ),
  // Add more morning Zikr items here
];

final List<ZikrItem> eveningZikr = [
  ZikrItem(
    arabic: 'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا ...',
    reference: 'Tirmidhi 3391',
    repeat: 1,
    explanation: 'Affirms that evening and morning are by the will of Allah.',
  ),
  // Add more evening Zikr items here
];

final List<ZikrItem> sleepZikr = [
  ZikrItem(
    arabic: 'بِاسْمِكَ اللّهُـمَّ أَمـوتُ وَأَحْـيا',
    reference: 'Sahih Bukhari 6324',
    repeat: 1,
    explanation: 'Surrendering the soul to Allah before sleep.',
  ),
  // Add more sleep Zikr items here
];
