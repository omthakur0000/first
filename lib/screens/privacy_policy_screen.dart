import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Privacy Policy',
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
              '1. Information We Collect',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We collect information that you provide directly to us, including:',
            ),
            SizedBox(height: 8),
            Text('• Account information (email, username)'),
            Text('• Device information'),
            Text('• Usage data'),
            SizedBox(height: 16),
            Text(
              '2. How We Use Your Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We use the information we collect to:',
            ),
            SizedBox(height: 8),
            Text('• Provide and maintain our services'),
            Text('• Process your rewards and payments'),
            Text('• Send you important updates and notifications'),
            SizedBox(height: 16),
            Text(
              '3. Data Security',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We implement appropriate security measures to protect your personal information.',
            ),
            SizedBox(height: 16),
            Text(
              '4. Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions about this Privacy Policy, please contact us at:',
            ),
            SizedBox(height: 8),
            Text('support@earningapp.com'),
          ],
        ),
      ),
    );
  }
} 