import 'package:flutter/material.dart';
import 'package:habbit_breaker/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import '../providers/auth_provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // Check if user is already authenticated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isAuthenticated()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: () async {
                String? result =
                    await Provider.of<AuthProvider>(context, listen: false)
                        .login(
                  emailController.text,
                  passwordController.text,
                );

                if (result == null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  setState(() {
                    errorMessage = result;
                  });
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    // Navigate to the SignUpScreen when clicked
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
