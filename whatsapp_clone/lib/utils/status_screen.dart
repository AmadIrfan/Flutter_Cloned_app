import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Status'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'new chats',
        child: const Icon(Icons.add),
      ),
    );
  }
}