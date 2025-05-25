import 'package:flutter/material.dart';

import 'custom_expansible_page.dart';
import 'expansion_tile_with_controller_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expansible Examples',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomePage(),
    );
  }
}

// Home Screen with Two Navigation Buttons
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expansible Demo Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomExpansiblePage()),
              ),
              child: const Text('Custom Expansible Widget'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ExpansionTileWithControllerPage(),
                ),
              ),
              child: const Text('ExpansionTile with Controller'),
            ),
          ],
        ),
      ),
    );
  }
}
