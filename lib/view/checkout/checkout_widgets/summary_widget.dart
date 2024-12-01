import 'package:flutter/cupertino.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Summary",
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
