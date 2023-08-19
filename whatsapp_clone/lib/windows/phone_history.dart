import 'package:flutter/material.dart';

class PhoneHistory extends StatefulWidget {
  const PhoneHistory({super.key});

  @override
  State<PhoneHistory> createState() => _PhoneHistoryState();
}

class _PhoneHistoryState extends State<PhoneHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Phone Calls'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'new Calls',
        child: const Icon(
          Icons.call,
        ),
      ),
    );
  }
}
