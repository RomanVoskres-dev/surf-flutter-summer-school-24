import 'package:surf_flutter_summer_school_24/photo/PhotoObj.dart';
import 'package:surf_flutter_summer_school_24/photo/PhotoRepository.dart';

import '../feature/theme/ui/theme_builder.dart';
import '../feature/theme/domain/theme_controller.dart';
import '../uikit/theme/theme_data.dart';
import '../feature/theme/di/theme_inherited.dart';
import 'package:flutter/material.dart';
import 'watchpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.themeController, super.key});

  final ThemeController themeController;

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
            home: Home(themeController: themeController),
          );
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({required this.themeController, super.key});

  final ThemeController themeController;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PhotoRepository repository = PhotoRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Постограм'),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 30),
        actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            showModalBottomSheet(
              context: context, 
              builder: (context) {
                return Wrap(
                  children: [
                    GestureDetector (
                      onTap: () {
                          ThemeInherited.of(context).switchThemeMode();
                        },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.bolt),
                            Text('Сменить тему')
                          ],
                        ),
                      ),
                    ),
                    GestureDetector (
                      onTap: () {
                          //uploadImageToYandexCloud
                        },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.cloud),
                            Text(' Загрузить изображение')
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
      ),
      body: FutureBuilder(
        future: repository.getPhotos(),
        builder: (context, snapshot)
        {
          List<PhotoObject>? photos = snapshot.data;
          if (photos != null)
          {
            return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: photos.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      child: GridImage(pathImg: photos[index].url),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageViewExampleApp(themeController: widget.themeController, indexImage: index, lengthPhotos: photos.length)),
                      );
                    },
                  );
                }
            );
          }
          else
          {
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
        },
      ),
    );
  }
}

class GridImage extends StatelessWidget {
  const GridImage({
    super.key,
    required this.pathImg,
  });

  final String pathImg;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      pathImg,
      fit: BoxFit.cover,
    );
  }
}