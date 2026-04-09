import 'package:flutter/material.dart';
import '../auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _newPasswordController = TextEditingController();

  String message = '';

  Future<void> _changePassword() async {
    final newPassword = _newPasswordController.text.trim();

    if (newPassword.length < 6) {
      setState(() {
        message = 'New password must be at least 6 characters';
      });
      return;
    }

    try {
      await _authService.changePassword(newPassword);
      setState(() {
        message = 'Password updated successfully';
      });
      _newPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      setState(() {
        message = e.message ?? 'Password update failed';
      });
    } catch (e) {
      setState(() {
        message = 'Something went wrong: $e';
      });
    }
  }

  Future<void> _logout() async {
    await _authService.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthenticationScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen'), centerTitle: true),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/profile_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay for readability
          Container(color: Colors.black54),
          // Main content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Current User Email: [4m${user?.email ?? "No user logged in"}[0m',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black)],
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _newPasswordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyanAccent),
                    ),
                    filled: true,
                    fillColor: Color(0xAA000000),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.cyanAccent,
                  ),
                  onPressed: _changePassword,
                  child: const Text('Change Password'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.cyanAccent,
                  ),
                  onPressed: _logout,
                  child: const Text('Logout'),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black)],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
