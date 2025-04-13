import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    
    // Initialize with current user name
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.user != null) {
        _nameController.text = userProvider.user!.name;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (!userProvider.isLoggedIn) {
            return const Center(
              child: Text('Please login to view settings'),
            );
          }
          
          return ListView(
            children: [
              // User profile section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                              Text(
                                userProvider.user!.email,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Divider(),
              
              // Edit name
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Player Name'),
                onTap: () {
                  _showEditNameDialog(context, userProvider);
                },
              ),
              
              // Account settings
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Privacy Policy'),
                onTap: () {
                  Navigator.pushNamed(context, '/privacy');
                },
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Terms of Service'),
                onTap: () {
                  Navigator.pushNamed(context, '/terms');
                },
              ),
              
              // Support
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Support',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help & Support'),
                onTap: () {
                  Navigator.pushNamed(context, '/help');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
              
              // Logout
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  _showLogoutConfirmation(context, userProvider);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditNameDialog(BuildContext context, UserProvider userProvider) {
    _nameController.text = userProvider.user!.name;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Player Name'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  userProvider.updateName(_nameController.text);
                  Navigator.of(context).pop();
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Name updated successfully'),
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmation(BuildContext context, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                userProvider.logout();
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
} 