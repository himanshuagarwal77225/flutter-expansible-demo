import 'package:flutter/material.dart';

class CustomExpansiblePage extends StatefulWidget {
  const CustomExpansiblePage({super.key});

  @override
  State<CustomExpansiblePage> createState() => _CustomExpansiblePageState();
}

class _CustomExpansiblePageState extends State<CustomExpansiblePage> {
  late final ExpansibleController _myCustomExpansibleController;

  @override
  void initState() {
    super.initState();
    _myCustomExpansibleController = ExpansibleController();
    _myCustomExpansibleController.addListener(_onExpansionStateChanged);
  }

  void _onExpansionStateChanged() {
    print(
      'Custom Expansible state: ${_myCustomExpansibleController.isExpanded}',
    );
    // You can trigger UI updates or other logic here
  }

  @override
  void dispose() {
    _myCustomExpansibleController.removeListener(_onExpansionStateChanged);
    _myCustomExpansibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Expansible Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expansible(
              controller: _myCustomExpansibleController,
              headerBuilder:
                  (BuildContext context, Animation<double> animation) {
                    return GestureDetector(
                      onTap: () {
                        if (_myCustomExpansibleController.isExpanded) {
                          _myCustomExpansibleController.collapse();
                        } else {
                          _myCustomExpansibleController.expand();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade200,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Click Me to Reveal!',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple,
                              ),
                            ),
                            RotationTransition(
                              turns: Tween(
                                begin: 0.0,
                                end: 0.5,
                              ).animate(animation),
                              child: Icon(
                                _myCustomExpansibleController.isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.deepPurple,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
              bodyBuilder: (BuildContext context, Animation<double> animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: -1.0,
                  child: FadeTransition(
                    opacity: animation,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Colors.deepPurple.shade100,
                          width: 2,
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '🎉 Voila! Here\'s your secret content.',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'You can put anything here: forms, images, lists, or even other expandable widgets!',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text('Fully customizable layout'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              expansibleBuilder:
                  (
                    BuildContext context,
                    Widget header,
                    Widget body,
                    Animation<double> animation,
                  ) {
                    // Here, you could apply more complex animations or wrap the header/body
                    // in different widgets based on the expansion state.
                    return Column(children: [header, body]);
                  },
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutQuad,
              reverseCurve: Curves.easeOutCubic,
              maintainState: true, // Keep state even when collapsed
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _myCustomExpansibleController.expand(),
                  child: const Text('Expand'),
                ),
                ElevatedButton(
                  onPressed: () => _myCustomExpansibleController.collapse(),
                  child: const Text('Collapse'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_myCustomExpansibleController.isExpanded) {
                      _myCustomExpansibleController.collapse();
                    } else {
                      _myCustomExpansibleController.expand();
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
