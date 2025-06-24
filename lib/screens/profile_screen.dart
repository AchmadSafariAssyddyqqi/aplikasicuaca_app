import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 150,
                backgroundImage: AssetImage('assets/Spiderman.jpeg'),
                backgroundColor: Colors.white,
                
              ),
              const SizedBox(height: 20),
              const Text(
                'ACHMAD SAFARI ASSYDDYQQI',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(blurRadius: 4.0, color: Colors.black38, offset: Offset(2.0, 2.0)),
                  ],
                ),
              ),
              const Text(
                'TEKNIK INFORMATIKA',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Email: assyddyqqi1@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const Text(
                'GitHub: github.com/AchmadSafariAssyddyqqi',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}