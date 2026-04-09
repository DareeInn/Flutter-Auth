import 'package:flutter/material.dart';
import '../auth_service.dart';
import 'profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLogin = true;
  String message = '';

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      if (isLogin) {
        await _authService.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        setState(() {
          message = 'Sign in successful';
        });
      } else {
        await _authService.register(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        setState(() {
          message = 'Registration successful';
        });
      }

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        message = e.message ?? 'Authentication error occurred';
      });
    } catch (e) {
      setState(() {
        message = 'Something went wrong: $e';
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Enter a valid email like test@gsu.com';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Sign In' : 'Register'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/vault_bg.png', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyanAccent),
                          ),
                        ),
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyanAccent),
                          ),
                        ),
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.cyanAccent,
                        ),
                        onPressed: _submit,
                        child: Text(isLogin ? 'Sign In' : 'Register'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.cyanAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                            message = '';
                          });
                        },
                        child: Text(
                          isLogin
                              ? 'Create an account'
                              : 'Already have an account? Sign in',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        message,
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
