import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.attach_money,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Earn Money App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'About Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Earn Money App is a platform where users can earn gold coins by watching ads, '
              'completing surveys, and using the daily spinner. These gold coins can be '
              'redeemed for real-world rewards like gift cards and cash.',
            ),
            const SizedBox(height: 24),
            const Text(
              'How It Works',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildStepCard(
              '1',
              'Watch Ads',
              'Watch short video ads to earn 5 gold coins per ad.',
              Icons.video_library,
            ),
            const SizedBox(height: 8),
            _buildStepCard(
              '2',
              'Complete Surveys',
              'Take short surveys to earn 20-50 gold coins.',
              Icons.assignment,
            ),
            const SizedBox(height: 8),
            _buildStepCard(
              '3',
              'Spin the Wheel',
              'Use the daily spinner for a chance to win up to 100 gold coins.',
              Icons.casino,
            ),
            const SizedBox(height: 8),
            _buildStepCard(
              '4',
              'Redeem Rewards',
              'Exchange your gold coins for real-world rewards.',
              Icons.card_giftcard,
            ),
            const SizedBox(height: 24),
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Website: www.earningapp.com'),
            const Text('Email: contact@earningapp.com'),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                '© 2023 Earn Money App. All rights reserved.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(String number, String title, String description, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: Colors.amber),
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
                  const SizedBox(height: 4),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 