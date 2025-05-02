import 'package:flutter/material.dart';
import 'zikr_data.dart';

class ZikrDetailScreen extends StatelessWidget {
  final String title;
  final List<ZikrItem> zikrs;

  const ZikrDetailScreen({
    Key? key,
    required this.title,
    required this.zikrs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: zikrs.length,
        itemBuilder: (context, index) {
          final zikr = zikrs[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    zikr.arabic,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Amiri',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Repeat: ${zikr.repeat}'),
                  const SizedBox(height: 4),
                  Text('Ref: ${zikr.reference}', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(zikr.explanation),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
