import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Terms of Service',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Last updated: [Date]',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 24),
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'By accessing or using this app, you agree to be bound by these Terms of Service and all applicable laws and regulations.',
            ),
            SizedBox(height: 16),
            Text(
              '2. Use of the App',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'You agree to use the app only for lawful purposes and in accordance with these Terms. You agree not to use the app:',
            ),
            SizedBox(height: 8),
            Text('• In any way that violates any applicable law or regulation'),
            Text('• To attempt to manipulate or cheat the reward system'),
            Text('• To engage in any fraudulent activity'),
            SizedBox(height: 16),
            Text(
              '3. Rewards and Payments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'All rewards earned through the app are subject to verification. We reserve the right to withhold rewards if we suspect fraudulent activity.',
            ),
            SizedBox(height: 16),
            Text(
              '4. Termination',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We reserve the right to terminate or suspend your account and access to the app at our sole discretion, without notice, for conduct that we believe violates these Terms or is harmful to other users, us, or third parties, or for any other reason.',
            ),
            SizedBox(height: 16),
            Text(
              '5. Changes to Terms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We reserve the right to modify these terms at any time. We will provide notice of any significant changes by updating the date at the top of these terms.',
            ),
          ],
        ),
      ),
    );
  }
} 