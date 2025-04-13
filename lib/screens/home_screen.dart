import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int spinsLeft = 3;
  bool canSpin = true;
  
  void _navigateToSpinner() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.isLoggedIn) {
      Navigator.pushNamed(context, '/spinner');
    } else {
      // Show dialog to prompt login
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Required'),
          content: const Text('You need to login to spin the wheel. Would you like to login now?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        // Remove login check and redirect
        
        // Only check for achievements if logged in
        if (userProvider.isLoggedIn && !userProvider.user!.achievements.contains('first_login')) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            userProvider.unlockAchievement('first_login');
            userProvider.addCoins(10);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Achievement Unlocked: Welcome Aboard!'),
                duration: Duration(seconds: 3),
              ),
            );
          });
        }

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: const Text('Gold Earning App'),
            elevation: 0,
            actions: [
              // Show login button if not logged in
              if (!userProvider.isLoggedIn)
                IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              // Only show these buttons if logged in
              if (userProvider.isLoggedIn) ...[
                IconButton(
                  icon: const Icon(Icons.emoji_events),
                  onPressed: () {
                    Navigator.pushNamed(context, '/achievements');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // User Profile Section - Show different UI based on login status
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: userProvider.isLoggedIn
                  ? Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: Text(
                              userProvider.user!.name.isNotEmpty
                                  ? userProvider.user!.name[0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userProvider.user!.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  userProvider.user!.email,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.attach_money,
                                  color: Colors.black,
                                ),
                                Text(
                                  '${userProvider.user!.coins}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  : Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Guest User',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Login to save your progress',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Daily Tasks Section
                      const Text(
                        'Daily Tasks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTaskCard(
                              'Watch Ads',
                              '5 coins per ad',
                              Icons.video_library,
                              () {
                                // Add coins
                                userProvider.addCoins(5);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Earned 5 coins from watching an ad!'),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTaskCard(
                              'Take Survey',
                              '20-50 coins',
                              Icons.assignment,
                              () {
                                // Add coins (random amount between 20-50)
                                final int reward = 20 + (DateTime.now().millisecondsSinceEpoch % 31);
                                userProvider.addCoins(reward);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Earned $reward coins from survey!'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      
                      // Spin Wheel Section
                      const SizedBox(height: 20),
                      const Text(
                        'Spin and Win',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: _navigateToSpinner,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              Icon(
                                Icons.rotate_right,
                                size: 80,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Spin the Wheel',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Win up to 100 coins!',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: _navigateToSpinner,
                                      child: const Text('Spin Now'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                      
                      // Achievements Section
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Achievements',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/achievements');
                            },
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildAchievementCard(
                              'Welcome Aboard',
                              Icons.login,
                              userProvider.isLoggedIn && userProvider.user?.achievements.contains('first_login') == true,
                            ),
                            _buildAchievementCard(
                              'Spinner Winner',
                              Icons.rotate_right,
                              userProvider.isLoggedIn && userProvider.user?.achievements.contains('first_spin') == true,
                            ),
                            _buildAchievementCard(
                              'Coin Collector',
                              Icons.monetization_on,
                              userProvider.isLoggedIn && userProvider.user?.achievements.contains('reach_100_coins') == true,
                            ),
                            _buildAchievementCard(
                              'Gold Rush',
                              Icons.diamond,
                              userProvider.isLoggedIn && userProvider.user?.achievements.contains('reach_500_coins') == true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaskCard(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          // Remove login restriction for ads and surveys, but handle coins differently
          if (userProvider.isLoggedIn) {
            // For logged-in users, execute the callback directly
            onTap();
          } else {
            // For guest users, show appropriate messaging
            if (title == 'Watch Ads') {
              // Guest can watch ads but won't earn coins
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Watched ad! Login to earn and save coins.'),
                ),
              );
            } else if (title == 'Take Survey') {
              // Guest can take surveys but won't earn coins
              final int reward = 20 + (DateTime.now().millisecondsSinceEpoch % 31);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Survey completed! Login to earn $reward coins.'),
                ),
              );
            } else {
              // For other tasks that might be added in the future, prompt login
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Login Required'),
                  content: const Text('You need to login to earn rewards. Would you like to login now?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              );
            }
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementCard(String title, IconData icon, bool unlocked) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: unlocked
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: unlocked ? Theme.of(context).colorScheme.primary : Colors.grey,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: unlocked ? Theme.of(context).colorScheme.primary : Colors.grey,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: unlocked ? Theme.of(context).colorScheme.onSurface : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          if (unlocked)
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 16,
            )
          else
            const Icon(
              Icons.lock,
              color: Colors.grey,
              size: 16,
            ),
        ],
      ),
    );
  }
} 