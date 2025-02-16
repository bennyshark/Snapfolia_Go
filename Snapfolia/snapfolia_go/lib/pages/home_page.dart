import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<String> carouselItems = [
    "Guide 1: Basic Navigation",
    "Guide 2: Scanning Tips",
    "Guide 3: Using Features",
  ];

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
              icon: const Icon(Icons.arrow_back_ios),
            );
          })
        ],
      ),
      endDrawer: const SideBar(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 30),
        child: RawMaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, '/scan');
          },
          shape: const CircleBorder(),
          elevation: 0,
          fillColor: Colors.transparent,
          child: const Icon(
            Icons.circle_outlined,
            size: 80,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "User Guide",
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withOpacity(.9)),
                  ),
                ),
              ),
              Container(
                height: 450,
                width: double.infinity,
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: CarouselSlider.builder(
                          itemCount: carouselItems.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              margin: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  carouselItems[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: double.infinity,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.8,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(carouselItems.length, (index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.5),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
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
