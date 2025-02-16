import 'package:flutter/material.dart';

import '../data/leaf_data.dart';
import '../widgets/leaf.dart';

class AlmanacPage extends StatefulWidget {
  const AlmanacPage({super.key});

  @override
  State<AlmanacPage> createState() => _AlmanacPageState();
}

class _AlmanacPageState extends State<AlmanacPage> {
  // State variable to track the selected leaf
  Map<String, dynamic>? selectedLeaf;
  // Create a ScrollController for the SingleChildScrollView
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed.
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        title: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Text(
            "ALMANAC",
            style: TextStyle(
              fontSize: screenWidth * .05,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Main Card (displays selected leaf details)
          SizedBox(
            height: screenHeight * 0.57,
            width: screenWidth * 0.95,
            child: Card(
              elevation: 4,
              color: const Color(0xff282828),
              child: selectedLeaf == null
                  ? Center(
                child: Text(
                  "Select a leaf to view details",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              )
                  : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image
                        SizedBox(
                          width: screenWidth * 0.4638,
                          height: screenHeight * 0.28,
                          child: Image.asset(
                            selectedLeaf!['imageUrl'],
                            width: screenWidth * 0.4,
                          ),
                        ),
                        // Text Column
                        SizedBox(
                          width: screenWidth * 0.4638,
                          height: screenHeight * 0.28,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedLeaf!['name'],
                                style: TextStyle(
                                  fontSize: screenWidth * 0.08,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                selectedLeaf!['scientificName'],
                                style: TextStyle(
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                selectedLeaf!['location'],
                                style: TextStyle(
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Definition
                    SizedBox(
                      width: screenWidth * 0.95,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(Icons.info_outline_rounded),
                              const SizedBox(width: 10),
                              Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 17),
                            child: Text(
                              selectedLeaf!['definition'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(Icons.event_note_outlined),
                              const SizedBox(width: 10),
                              Text(
                                "Uses",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 17),
                            child: Text(
                              selectedLeaf!['uses'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // GridView for leaf selection
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.035,
                screenWidth * 0.025,
                screenWidth * 0.035,
                screenWidth * 0.025,
              ),
              child: GridView.builder(
                itemCount: leaves.length,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: screenWidth * 0.03,
                  crossAxisSpacing: screenWidth * 0.025,
                ),
                itemBuilder: (context, index) {
                  final leaf = leaves[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLeaf = leaf;
                      });
                      // Reset scroll position to the top of the main card
                      _scrollController.jumpTo(0);
                    },
                    child: LeafInfo(
                      name: leaf['name'] as String,
                      image: leaf['imageUrl'] as String,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
