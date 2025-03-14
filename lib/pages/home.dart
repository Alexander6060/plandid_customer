import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:swipe_cards/swipe_cards.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> demoData = [
    {
      'name': 'Alice',
      'images': [
        'https://picsum.photos/id/1011/400/600',
        'https://picsum.photos/id/1018/400/600',
        'https://picsum.photos/id/1021/400/600',
      ],
      'description': 'Loves hiking and outdoor adventures.',
    },
    {
      'name': 'Bob',
      'images': [
        'https://picsum.photos/id/1015/400/600',
        'https://picsum.photos/id/1016/400/600',
      ],
      'description': 'Avid reader and coffee enthusiast.',
    },
    {
      'name': 'Charlie',
      'images': [
        'https://picsum.photos/id/1027/400/600',
        'https://picsum.photos/id/1028/400/600',
        'https://picsum.photos/id/1035/400/600',
      ],
      'description': 'Techie, gamer, and sci-fi geek.',
    },
  ];

  late final List<SwipeItem> _swipeItems;
  late final MatchEngine _matchEngine;

  @override
  void initState() {
    super.initState();

    // Build a list of SwipeItems
    _swipeItems =
        demoData.map((userData) {
          return SwipeItem(
            content: userData,
            likeAction: () => debugPrint('Like: ${userData['name']}'),
            nopeAction: () => debugPrint('Nope: ${userData['name']}'),
            superlikeAction: () => debugPrint('Superlike: ${userData['name']}'),
          );
        }).toList();

    // Create a MatchEngine with the list of SwipeItems
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // The core widget from the package that displays the cards
            Expanded(
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  final userData =
                      _swipeItems[index].content as Map<String, dynamic>;
                  // Return our custom card widget that shows multiple images + indicator
                  return CardContentWidget(userData: userData);
                },
                onStackFinished: () {
                  debugPrint('Finished swiping the stack.');
                },
                itemChanged: (SwipeItem item, int index) {
                  debugPrint('Item changed: Index $index');
                },
                upSwipeAllowed: true,
                fillSpace: true,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.grey[850],
                    foregroundColor: Colors.white,
                    heroTag: 'left',
                    onPressed: () => _matchEngine.currentItem?.nope(),
                    child: const Icon(Icons.close),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.grey[850],
                    foregroundColor: Colors.white,
                    heroTag: 'up',
                    onPressed: () => _matchEngine.currentItem?.superLike(),
                    child: const Icon(Icons.star),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.grey[850],
                    foregroundColor: Colors.white,
                    heroTag: 'right',
                    onPressed: () => _matchEngine.currentItem?.like(),
                    child: const Icon(Icons.favorite),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContentWidget extends StatefulWidget {
  final Map<String, dynamic> userData;
  const CardContentWidget({super.key, required this.userData});

  @override
  State<CardContentWidget> createState() => _CardContentWidgetState();
}

class _CardContentWidgetState extends State<CardContentWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Listen for page changes to update indicator
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.userData['images'] as List<dynamic>;
    final name = widget.userData['name'] as String;
    final description = widget.userData['description'] as String;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Stack(
        children: [
          // PageView for multiple images
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),
          ),

          // Bottom overlay for name + description
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Text(
              '$name : $description',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Simple textual page indicator (e.g. "1/3")
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '${_currentPage + 1} / ${images.length}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [Shadow(offset: Offset(1, 1), blurRadius: 4)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
