import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:supabase_flutter/supabase_flutter.dart';
import 'authscreen.dart';
import '../main.dart' show MyApp;

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    // Listen for auth state changes (sign in, sign out, etc.)
    _supabase.auth.onAuthStateChange.listen((data) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check the current session
    final session = _supabase.auth.currentSession;

    // If the user is logged in (session != null), show the main app
    if (session != null) {
      return const MyApp();
    }

    // Otherwise, show the sign in / sign up screen
    return const MaterialApp(home: AuthScreen());
  }
}
