import 'package:flutter/material.dart';


class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Container with Stack'),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blue.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // Positioned Text
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    'Top Left',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Centered Icon
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.star,
                    size: 50,
                    color: Colors.yellow,
                  ),
                ),
                // Positioned Button
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Click Me'),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
