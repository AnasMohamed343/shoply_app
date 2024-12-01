import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shoply/constants.dart';
import 'package:shoply/view/Explore_tab_view/explore_tab_view.dart';
import 'package:status_change/status_change.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  int _processIndex = 0;
  Pages pages = Pages.deliveryTime;

  final _processes = [
    'Order Signed',
    'Order Processed',
    'Shipped',
    'Out for delivery',
    'Delivered',
  ];

  final _content = [
    '20/18',
    '20/18',
    '20/18',
    '20/18',
    '20/18',
  ];

  // Ensure consistent lengths
  @override
  void initState() {
    super.initState();
    assert(
      _processes.length == _content.length,
      "The lengths of `_processes` and `_content` must match!",
    );
  }

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return Colors.teal;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Order Status",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: StatusChange.tileBuilder(
              theme: StatusChangeThemeData(
                direction: Axis.horizontal,
                connectorTheme: const ConnectorThemeData(
                  space: 1.0,
                  thickness: 1.0,
                ),
              ),
              builder: StatusChangeTileBuilder.connected(
                itemWidth: (_) =>
                    MediaQuery.of(context).size.width / _processes.length,
                contentWidgetBuilder: (context, index) {
                  // Ensure index is within bounds
                  if (index >= _content.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      _processes[index],
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  );
                },
                nameWidgetBuilder: (context, index) {
                  if (index >= _content.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      _content[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getColor(index),
                      ),
                    ),
                  );
                },
                indicatorWidgetBuilder: (_, index) {
                  try {
                    if (index > _processIndex) {
                      return const OutlinedDotIndicator(
                        size: 30,
                        borderWidth: 1.0,
                        color: todoColor,
                      );
                    } else {
                      return DotIndicator(
                        size: 35.0,
                        border: Border.all(color: Colors.teal, width: 1),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    print("Error at indicatorWidgetBuilder index $index: $e");
                    return const SizedBox.shrink(); // Fallback widget
                  }
                },
                lineWidgetBuilder: (index) {
                  if (index == 0) return null;
                  if (index == _processIndex) {
                    return DecoratedLineConnector(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [getColor(index - 1), getColor(index)],
                        ),
                      ),
                    );
                  } else {
                    return SolidLineConnector(
                      color: getColor(index),
                    );
                  }
                },
                itemCount: _processes.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_processIndex < _processes.length - 1) {
              _processIndex++;
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExploreTabView(),
                ),
              );
            }
          });
        },
        backgroundColor: inProgressColor,
        child: const Icon(Icons.skip_next),
      ),
    );
  }
}
