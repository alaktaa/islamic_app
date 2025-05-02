class ZikrItem {
  final String arabic;
  final String reference;
  final int repeat;
  final String explanation;

  ZikrItem({
    required this.arabic,
    required this.reference,
    required this.repeat,
    required this.explanation,
  });
}

final List<ZikrItem> morningZikr = [
  ZikrItem(
    arabic: 'اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ...',
    reference: 'Abu Dawood 5077, Tirmidhi 3529',
    repeat: 1,
    explanation: 'If one recites it in the morning and dies before evening, he will enter Paradise.',
  ),
  ZikrItem(
    arabic: 'رَضيـتُ بِاللهِ رَبَّـاً، وَبِالإسْلامِ ديـناً ...',
    reference: 'Abu Dawood 5072',
    repeat: 3,
    explanation: 'Whoever says this three times in the morning will be pleased on the Day of Judgment.',
  ),
  ZikrItem(
    arabic: 'اللّهـمَّ ما أَصْبَـحَ بي مِـن نِّعْـمَةٍ ...',
    reference: 'Abu Dawood 5073',
    repeat: 1,
    explanation: 'Acknowledges Allah’s blessings and shows gratitude.',
  ),
];

final List<ZikrItem> eveningZikr = [
  ZikrItem(
    arabic: 'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا ...',
    reference: 'Tirmidhi 3391',
    repeat: 1,
    explanation: 'Affirms that evening and morning are by the will of Allah.',
  ),
  ZikrItem(
    arabic: 'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ ...',
    reference: 'Ahmad 17808',
    repeat: 1,
    explanation: 'Declares witness to Allah, His angels, and His books.',
  ),
];

final List<ZikrItem> sleepZikr = [
  ZikrItem(
    arabic: 'بِاسْمِكَ اللّهُـمَّ أَمـوتُ وَأَحْـيا',
    reference: 'Sahih Bukhari 6324',
    repeat: 1,
    explanation: 'Surrendering the soul to Allah before sleep.',
  ),
  ZikrItem(
    arabic: 'اللّهُـمَّ قِنـي عَذابَـكَ يَـوْمَ تَـبْعَثُ عِبـادَك',
    reference: 'Tirmidhi 3398',
    repeat: 1,
    explanation: 'Seeking protection from Hellfire before sleep.',
  ),
];
