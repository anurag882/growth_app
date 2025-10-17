import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final double progress;
  final List<String> subtitles;
  final Color progressColor;
  final IconData icon;

  const ProgressCard({
    super.key,
    required this.title,
    required this.progress,
    required this.subtitles,
    this.progressColor = Colors.blue,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 24, color: progressColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: progressColor.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
            ...subtitles.map((subtitle) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}