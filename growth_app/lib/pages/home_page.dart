import 'package:flutter/material.dart';
import '../widgets/progress_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ProgressCard(
              title: 'Finance',
              progress: 0.5, // 600/1200
              subtitles: const [
                'Saved \$600 of \$1,200 goal',
                'Monthly target: \$300',
              ],
              progressColor: Colors.blue,
              icon: Icons.account_balance_wallet,
            ),
            const SizedBox(height: 16),
            ProgressCard(
              title: 'Fitness',
              progress: 0.43, // 3/7 workouts
              subtitles: const [
                '3 workouts this week',
                'Avg. sleep: 7h 30m',
              ],
              progressColor: Colors.green,
              icon: Icons.fitness_center,
            ),
            const SizedBox(height: 24),
            const Text(
              'AI Insights',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.lightbulb_outline,
                          color: Colors.white,
                        ),
                      ),
                      title: const Text(
                        'Financial Insight',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'You\'re on track to reach your savings goal in about 2 months. Consider increasing your weekly savings by \$50.',
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.tips_and_updates,
                          color: Colors.white,
                        ),
                      ),
                      title: const Text(
                        'Fitness Tip',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Adding 30 minutes more sleep could improve your workout performance. Try going to bed at ${_suggestBedtime()}.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _suggestBedtime() {
    // Get current time and subtract 8 hours for ideal sleep duration
    final now = TimeOfDay.now();
    final bedtime = TimeOfDay(
      hour: (now.hour - 8 + 24) % 24,
      minute: now.minute,
    );
    // Format time as string
    String period = bedtime.hour >= 12 ? 'PM' : 'AM';
    int displayHour = bedtime.hour > 12 ? bedtime.hour - 12 : bedtime.hour;
    if (displayHour == 0) displayHour = 12;
    String minutes = bedtime.minute.toString().padLeft(2, '0');
    return '$displayHour:$minutes $period';
  }
}