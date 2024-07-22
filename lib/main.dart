import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const PageViewExampleApp());

class PageViewExampleApp extends StatelessWidget {
  const PageViewExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: const PageViewExample(),
      ),
    );
  }
}

class PageViewExample extends StatefulWidget {
  const PageViewExample({super.key});

  @override
  State<PageViewExample> createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Row(
          children: [
            Text('$_currentPageIndex/4', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ],
        ),
        PageView(
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          children: <Widget>[
            ScrollImage(pathImg: 'assets/imagesTemp/кавказ.jpg'),
            ScrollImage(pathImg: 'assets/imagesTemp/Питер.jpg'),
            ScrollImage(pathImg: 'assets/imagesTemp/Химки.jpg'),
            ScrollImage(pathImg: 'assets/imagesTemp/Химки.jpg'),
          ],
        ),
      ],
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    if (!_isOnDesktopAndWeb) {
      _currentPageIndex = currentPageIndex+1;
    }
    else
    {
      _tabController.index = currentPageIndex;
      _currentPageIndex = currentPageIndex;
    }
      setState(() {
      
    });
  }


  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}

class ScrollImage extends StatelessWidget {
  const ScrollImage({
    super.key,
    required this.pathImg,
  });

  final String pathImg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Text(pathImg),
        Image.asset(
          pathImg,
          height: MediaQuery.of(context).size.height-300,
          fit: BoxFit.cover,
        ),
      ],
      ),
    );
  }
}