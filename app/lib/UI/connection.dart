import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';


class Connect extends StatelessWidget {
  final supabaseClient = SupabaseClient(
    'https://ldszgfgncolvkopylatk.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxkc3pnZmduY29sdmtvcHlsYXRrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAxNzA1MTcsImV4cCI6MjAyNTc0NjUxN30.3kfpLJnHUclt2NfNbOCz8MtwqJBF3v4M6WN2iDz4Lyg',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationExample(supabaseClient),
    );
  }
}

class AuthenticationExample extends StatefulWidget {
  final SupabaseClient supabaseClient;

  const AuthenticationExample(this.supabaseClient);

  @override
  _AuthenticationExampleState createState() => _AuthenticationExampleState();
}

class _AuthenticationExampleState extends State<AuthenticationExample> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supabase Authentication Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();

                final response = await widget.supabaseClient.auth.signUp(
                  email: email,
                  password: password,
                );

                if (response.error == null) {
                  print('Signed up successfully');
                  // Vous pouvez ici rediriger l'utilisateur vers une autre page par exemple
                } else {
                  setState(() {
                    _errorMessage = response.error!.message;
                  });
                  print('Error signing up: $_errorMessage');
                  // Gérer l'erreur d'inscription
                }
              },
              child: Text('Sign Up'),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}