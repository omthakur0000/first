import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/spinner_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/terms_screen.dart';
import 'screens/help_screen.dart';
import 'screens/about_screen.dart';
import 'screens/login_screen.dart';
import 'screens/achievements_screen.dart';
import 'theme/app_theme.dart';
import 'providers/user_provider.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    return MaterialApp(
      title: 'Gold Earning App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/spinner': (context) => SpinnerScreen(
          onRewardEarned: (reward) {
            // Handle reward earned
            final userProvider = Provider.of<UserProvider>(context, listen: false);
            userProvider.addCoins(reward);
            
            // Check if this is the first spin
            if (!userProvider.user!.achievements.contains('first_spin')) {
              userProvider.unlockAchievement('first_spin');
            }
            
            // Check if user reached coin thresholds
            if (userProvider.user!.coins >= 100 && 
                !userProvider.user!.achievements.contains('reach_100_coins')) {
              userProvider.unlockAchievement('reach_100_coins');
            }
            
            if (userProvider.user!.coins >= 500 && 
                !userProvider.user!.achievements.contains('reach_500_coins')) {
              userProvider.unlockAchievement('reach_500_coins');
            }
            
            if (userProvider.user!.coins >= 1000 && 
                !userProvider.user!.achievements.contains('reach_1000_coins')) {
              userProvider.unlockAchievement('reach_1000_coins');
            }
          },
          onSpinUsed: () {
            // Handle spin used
            print('Spin used');
          },
          canSpin: true,
        ),
        '/settings': (context) => const SettingsScreen(),
        '/privacy': (context) => const PrivacyPolicyScreen(),
        '/terms': (context) => const TermsScreen(),
        '/help': (context) => const HelpScreen(),
        '/about': (context) => const AboutScreen(),
        '/achievements': (context) => const AchievementsScreen(),
      },
    );
  }
}
