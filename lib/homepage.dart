import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You are now logged in"),
              SizedBox(
                height: 15.0,
              ),
              OutlineButton(
                child: Text("Logout"),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
