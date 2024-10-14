import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'slider_screen.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SliderScreen()));
            },
          ),
        ],
      ),
      body: Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}