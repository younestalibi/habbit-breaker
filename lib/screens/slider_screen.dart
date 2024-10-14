import 'package:flutter/material.dart';
import 'package:habbit_breaker/screens/signin_screen.dart';

class SliderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Center(child: Text('Slider 1')),
          Center(child: Text('Slider 2')),
          Center(child: Text('Slider 3')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignInScreen()));
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
