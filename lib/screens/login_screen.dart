import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to home page instead of exiting the app
        Navigator.pushReplacementNamed(context, '/');
        return false;  // Prevent default back behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          automaticallyImplyLeading: false, // This removes the default back button
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to home page
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App logo or icon
                Icon(
                  Icons.monetization_on,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                
                // App name
                Text(
                  'Gold Earning App',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 48),
                
                // Login form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      
                      // Login button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: userProvider.isLoading 
                              ? null 
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    userProvider.login(
                                      _emailController.text,
                                      _passwordController.text,
                                    ).then((_) {
                                      if (userProvider.isLoggedIn) {
                                        Navigator.pushReplacementNamed(context, '/');
                                      }
                                    });
                                  }
                                },
                          child: userProvider.isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('OR'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Google Sign-In button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.login),
                    label: Text('Sign in with Google'),
                    onPressed: userProvider.isLoading
                        ? null
                        : () {
                            userProvider.googleLogin().then((_) {
                              if (userProvider.isLoggedIn) {
                                Navigator.pushReplacementNamed(context, '/');
                              }
                            });
                          },
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Register link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        // Navigate to registration screen
                        // This is a placeholder as we're not implementing registration now
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Registration will be implemented later'),
                          ),
                        );
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 