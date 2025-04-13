import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // FAQ Section
            _buildSection(
              'Frequently Asked Questions',
              [
                _buildFaqItem(
                  'How do I earn gold coins?',
                  'You can earn gold coins by watching ads (5 coins per ad), completing surveys (20-50 coins), and using the daily spinner.',
                ),
                _buildFaqItem(
                  'How many daily spins do I get?',
                  'You get 3 free spins per day. You can earn additional spins by watching ads.',
                ),
                _buildFaqItem(
                  'When do my spins reset?',
                  'Your spins reset at midnight local time every day.',
                ),
                _buildFaqItem(
                  'How can I redeem my gold coins?',
                  'You can redeem your gold coins for gift cards, PayPal cash, or other rewards in the Rewards section (coming soon).',
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Contact Support Section
            const Text(
              'Contact Support',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'If you need additional help, please contact our support team:',
            ),
            const SizedBox(height: 8),
            const Text('Email: support@earningapp.com'),
            const Text('Hours: Monday - Friday, 9am - 5pm EST'),
            
            const SizedBox(height: 24),
            
            // Report Bug Button
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement bug reporting
              },
              icon: const Icon(Icons.bug_report),
              label: const Text('Report a Bug'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer),
        ),
      ],
    );
  }
} 