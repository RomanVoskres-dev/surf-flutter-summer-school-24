import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/photo/PhotoObj.dart';
import 'package:surf_flutter_summer_school_24/photo/PhotoRepository.dart';
import '../feature/theme/di/theme_inherited.dart';
import '../feature/theme/domain/theme_controller.dart';
import '../feature/theme/ui/theme_builder.dart';
import '../uikit/theme/theme_data.dart';

class PageViewExampleApp extends StatelessWidget {
  const PageViewExampleApp({required this.themeController, required this.indexImage, required this.lengthPhotos, super.key});

  final ThemeController themeController;
  final int indexImage;
  final int lengthPhotos;

  @override
  Widget build(BuildContext context) {
    return ThemeInherited(
      themeController: themeController,
      child: ThemeBuilder(
        builder: (_, themeMode) {
          return MaterialApp(
            theme: AppThemeData.lightTheme,
            darkTheme: AppThemeData.darkTheme,
            themeMode: themeMode,
            home: PageViewExample(themeController: themeController, indexImage: indexImage, lengthPhotos: lengthPhotos),
          );
        },
      ),
    );
  }
}

class PageViewExample extends StatefulWidget {
  const PageViewExample({required this.themeController, required this.indexImage, required this.lengthPhotos, super.key});

  final ThemeController themeController;
  final int indexImage;
  final int lengthPhotos;

  @override
  State<PageViewExample> createState() => _PageViewExampleState(indexImage: indexImage, lengthPhotos: lengthPhotos);
}

class _PageViewExampleState extends State<PageViewExample> with TickerProviderStateMixin {
  _PageViewExampleState({required this.indexImage, required this.lengthPhotos});

  final int indexImage;
  final int lengthPhotos;

  PhotoRepository repository = PhotoRepository();
  late PageController _pageViewController;
  int _currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: indexImage, viewportFraction: 0.8);
    _currentPageIndex = indexImage+1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_currentPageIndex/$lengthPhotos'),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 30),
      ),
      body: FutureBuilder(
        future: repository.getPhotos(),
        builder: (context, snapshot)
        {
          List<PhotoObject>? photos = snapshot.data;
          if (photos != null)
          {
            return Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(''),
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  child: PageView.builder(
                      itemCount: lengthPhotos,
                      pageSnapping: true,
                      controller: _pageViewController,
                      onPageChanged: (page) {
                        setState(() {
                          _currentPageIndex = page+1;
                        });
                      },
                      itemBuilder: (context, pagePosition) {
                        bool active = pagePosition == _currentPageIndex;
                        return slider(photos,pagePosition,active);
                      }),
                ),
              ],
            );
          } else {
            return Scaffold(
              body: Image.asset(
                "assets/UI/windows.jpg",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            );
          }
        }
      ),
    );
  }

  AnimatedContainer slider(images,pagePosition,active){
    double margin = active ? 10 : 30;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic, 
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(images[pagePosition].url), fit: BoxFit.cover)
      ),
      );
  }
}