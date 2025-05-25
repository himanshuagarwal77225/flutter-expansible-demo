import 'package:flutter/material.dart';

class ExpansionTileWithControllerPage extends StatefulWidget {
  const ExpansionTileWithControllerPage({super.key});

  @override
  State<ExpansionTileWithControllerPage> createState() =>
      _ExpansionTileWithControllerPageState();
}

class _ExpansionTileWithControllerPageState
    extends State<ExpansionTileWithControllerPage> {
  // Use ExpansibleController now!
  late final ExpansibleController _standardTileController;

  @override
  void initState() {
    super.initState();
    _standardTileController = ExpansibleController();
    _standardTileController.addListener(_onTileExpansionChanged);
  }

  void _onTileExpansionChanged() {
    print(
      'Standard ExpansionTile state: ${_standardTileController.isExpanded}',
    );
  }

  @override
  void dispose() {
    _standardTileController.removeListener(_onTileExpansionChanged);
    _standardTileController.dispose(); // Don't forget to dispose!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpansionTile with ExpansibleController'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ExpansionTile(
              controller: _standardTileController, // This is the key change!
              title: const Text('Your Regular Material Expansion Tile'),
              subtitle: const Text('Tap or use buttons to control me!'),
              leading: const Icon(Icons.list_alt),
              onExpansionChanged: (bool expanded) {
                // This callback is still useful for reacting to user interactions
                print('ExpansionTile user interaction: $expanded');
              },
              initiallyExpanded: false,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This is the content that expands and collapses within the familiar Material Design style.',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'It still works just like you remember, but with a more modern controller underneath.',
                        style: TextStyle(fontSize: 13.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _standardTileController.expand(),
                  child: const Text('Expand'),
                ),
                ElevatedButton(
                  onPressed: () => _standardTileController.collapse(),
                  child: const Text('Collapse'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_standardTileController.isExpanded) {
                      _standardTileController.collapse();
                    } else {
                      _standardTileController.expand();
                    }
                  },
                  child: const Text('Toggle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
