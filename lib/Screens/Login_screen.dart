import 'package:chatting_app/Screens/Signup_screen.dart';
import 'package:chatting_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/social_button.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.secondaryContainer,
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ).animate().shimmer().scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.1, 1.1),
                        duration: 1000.ms,
                      ),
                  const SizedBox(height: 48),
                  Text(
                    'Welcome Back !',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ).animate().fadeIn().slideY(),
                  const SizedBox(height: 48),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            if (value.length < 3) {
                              return 'Username must be at least 3 characters long';
                            }
                            if (value.length > 20) {
                              return 'Username cannot exceed 20 characters';
                            }
                            // Check if username contains only letters, numbers, and underscores
                            if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                              return 'Username can only contain letters, numbers, and underscores';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ).animate().fadeIn().slideX(),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            if (value.length > 50) {
                              return 'Password cannot exceed 50 characters';
                            }
                            // Check for at least one uppercase letter
                            if (!value.contains(RegExp(r'[A-Z]'))) {
                              return 'Password must contain at least one uppercase letter';
                            }
                            // Check for at least one lowercase letter
                            if (!value.contains(RegExp(r'[a-z]'))) {
                              return 'Password must contain at least one lowercase letter';
                            }
                            // Check for at least one number
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return 'Password must contain at least one number';
                            }
                            // Check for at least one special character
                            if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                              return 'Password must contain at least one special character';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ).animate().fadeIn(delay: 200.ms).slideX(),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : const Text('Login'),
                          ),
                        ).animate().fadeIn(delay: 400.ms).slideY(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignupScreen(),
                                ),
                              ),
                              child: const Text('Sign Up'),
                            ),
                          ],
                        ).animate().fadeIn(delay: 500.ms),
                        const SizedBox(height: 24),
                        const SocialLoginButtons(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Simulate login process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        // Navigate to HomeScreen after successful login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      });
    }
  }
}