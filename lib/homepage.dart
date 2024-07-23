import '../feature/theme/ui/theme_builder.dart';
import '../feature/theme/domain/theme_controller.dart';
import '../uikit/theme/theme_data.dart';
import '../feature/theme/di/theme_inherited.dart';
import '../feature/theme/data/theme_repository.dart';
import '../storage/theme/theme_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../watchpage.dart';
import '../listImage.dart';

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
            home: const Home(),
          );
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Постограм'),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
        backgroundColor: Color.fromARGB(10, 15, 15, 15),
        actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          color: Colors.white,
          onPressed: () {
            showModalBottomSheet(
              context: context, 
              builder: (context) {
                return Wrap(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                              ThemeInherited.of(context).switchThemeMode();
                            }, 
                          icon: const Icon(Icons.bolt),
                          ),
                        Text('Сменить тему')
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                              print('Пользователь хочет загрузить изображение, но я не разрешу <3');
                            }, 
                          icon: const Icon(Icons.cloud),
                          ),
                        Text('Загрзуить изображение'), 
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
      ),
      backgroundColor: Color.fromARGB(143, 73, 73, 73),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: paths.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                child: GridImage(pathImg: paths[index]),
              );
            }
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
    return Image.asset(
      pathImg,
      fit: BoxFit.cover,
    );
  }
}