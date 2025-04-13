import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (!userProvider.isLoggedIn) {
            return const Center(
              child: Text('Please login to view achievements'),
            );
          }

          // List of all possible achievements
          final allAchievements = [
            {
              'id': 'first_login',
              'name': 'Welcome Aboard',
              'description': 'Log in to the app for the first time',
              'icon': Icons.login,
              'reward': 10,
            },
            {
              'id': 'first_spin',
              'name': 'Spinner Winner',
              'description': 'Use the spinner for the first time',
              'icon': Icons.rotate_right,
              'reward': 15,
            },
            {
              'id': 'reach_100_coins',
              'name': 'Coin Collector',
              'description': 'Reach 100 coins',
              'icon': Icons.monetization_on,
              'reward': 20,
            },
            {
              'id': 'reach_500_coins',
              'name': 'Gold Rush',
              'description': 'Reach 500 coins',
              'icon': Icons.diamond,
              'reward': 50,
            },
            {
              'id': 'reach_1000_coins',
              'name': 'Fortune Hunter',
              'description': 'Reach 1000 coins',
              'icon': Icons.attach_money,
              'reward': 100,
            },
            {
              'id': 'daily_streak_7',
              'name': 'Weekly Warrior',
              'description': 'Log in for 7 consecutive days',
              'icon': Icons.calendar_today,
              'reward': 30,
            },
          ];

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // User stats
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Text(
                            userProvider.user!.name.isNotEmpty
                                ? userProvider.user!.name[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userProvider.user!.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${userProvider.user!.coins} coins',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatCard(
                          context, 
                          'Achievements', 
                          '${userProvider.user!.achievements.length}/${allAchievements.length}',
                          Icons.emoji_events,
                        ),
                        _buildStatCard(
                          context, 
                          'Progress', 
                          '${(userProvider.user!.achievements.length / allAchievements.length * 100).toInt()}%',
                          Icons.trending_up,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Achievements title
              const Text(
                'Your Achievements',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Achievements list
              ...allAchievements.map((achievement) {
                final bool isUnlocked = userProvider.user!.achievements.contains(achievement['id']);
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isUnlocked
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                      child: Icon(
                        achievement['icon'] as IconData,
                        color: isUnlocked ? Colors.black : Colors.white54,
                      ),
                    ),
                    title: Text(
                      achievement['name'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isUnlocked ? null : Colors.grey,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement['description'] as String,
                          style: TextStyle(
                            color: isUnlocked ? null : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Reward: ${achievement['reward']} coins',
                          style: TextStyle(
                            color: isUnlocked 
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: isUnlocked
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                    isThreeLine: true,
                  ),
                );
              }).toList(),
              
              // Demo unlock button (for testing)
              if (userProvider.isLoggedIn) ...[
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _unlockRandomAchievement(userProvider, allAchievements);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Achievement unlocked!'),
                      ),
                    );
                  },
                  child: const Text('Unlock Random Achievement (Demo)'),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, 
    String title, 
    String value, 
    IconData icon,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _unlockRandomAchievement(
    UserProvider userProvider, 
    List<Map<String, dynamic>> allAchievements,
  ) {
    // Get list of locked achievements
    final lockedAchievements = allAchievements
        .where((a) => !userProvider.user!.achievements.contains(a['id']))
        .toList();
    
    if (lockedAchievements.isNotEmpty) {
      // Select a random achievement to unlock
      final random = DateTime.now().millisecondsSinceEpoch % lockedAchievements.length;
      final achievementToUnlock = lockedAchievements[random];
      
      // Unlock the achievement
      userProvider.unlockAchievement(achievementToUnlock['id'] as String);
      
      // Add the reward
      userProvider.addCoins(achievementToUnlock['reward'] as int);
    }
  }
} 