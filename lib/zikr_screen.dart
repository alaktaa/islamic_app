import 'package:flutter/material.dart';
import 'package:quick_app/zikr_item.dart';
import 'zikr_data.dart';
import 'zikr_detail_screen.dart';

class ZikrScreen extends StatelessWidget {
  const ZikrScreen({super.key});

  void openZikr(BuildContext context, String title, List<ZikrItem> zikrList) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ZikrDetailScreen(
          title: title,
          zikrs: zikrList, // ✅ Passing correct type
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zikr'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ZikrCategoryBox(
              title: 'أذكار الصباح',
              onTap: () => openZikr(context, 'أذكار الصباح', morningZikr),
            ),
            ZikrCategoryBox(
              title: 'أذكار المساء',
              onTap: () => openZikr(context, 'أذكار المساء', eveningZikr),
            ),
            ZikrCategoryBox(
              title: 'أذكار النوم',
              onTap: () => openZikr(context, 'أذكار النوم', sleepZikr),
            ),
          ],
        ),
      ),
    );
  }
}

class ZikrCategoryBox extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ZikrCategoryBox({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
        onTap: onTap,
      ),
    );
  }
}
