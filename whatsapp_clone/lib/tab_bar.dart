import 'package:flutter/material.dart';

class TabBarController extends StatefulWidget {
  const TabBarController({super.key});

  @override
  State<TabBarController> createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Whatsapp"),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('new chat'),
                  onTap: () {},
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.camera),
                //              text: "Camera",
              ),
              Tab(
//                icon: Icon(Icons.chat),
                text: "Chats",
              ),
              Tab(
                //  icon: Icon(Icons.status),
                text: "status",
              ),
              Tab(
                //       icon: Icon(Icons.camera),
                text: "Calls",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // CameraScreen(),
            // MyHomePage(),
            // StatusScreen(),
            // PhoneHistory(),
          ],
        ),
      ),
    );
  }
}
