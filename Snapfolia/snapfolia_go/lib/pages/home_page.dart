import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snapfolia Go"),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.arrow_back_ios));
          })
        ],
      ),
      endDrawer: const SideBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [GestureDetector
              (
                onTap: (){
                  Navigator.pushNamed(context, '/scan');
                },
                child: const Icon(Icons.circle_outlined, size: 80,))],
          ),
        ),
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 150,
      child: ListView(
        padding: const EdgeInsets.only(top: 48),
        children: [
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            title: const Text('Almanac'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/almanac');
            },
          ),
          ListTile(
            title: const Text('Developers'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/developers');
            },
          ),
        ],
      ),
    );
  }
}
