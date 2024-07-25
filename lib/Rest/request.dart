import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:surf_flutter_summer_school_24/photo/pageview/PhotoObj.dart';

const token = 'запрещено шведской конвенцией';

Future<void> uploadImageToYandexCloud() async {
  // Получаем изображение
  final picker = ImagePicker();
  final imageFromGallery = await picker.pickImage(source: ImageSource.gallery);
  if (imageFromGallery == null) return;

  // ### Получаем ссылку для загрузки

  final name = imageFromGallery.name;

  final uri = Uri.https(
    'cloud-api.yandex.net',
    'v1/disk/resources/upload',
    {
      "path": name,
    },
  );

  final response = await http.get(
    uri,
    headers: {
      HttpHeaders.authorizationHeader: 'OAuth $token',
    },
  );

  final body = response.body;
  final json = jsonDecode(body);
  json as Map<String, dynamic>;
  final linkToUpload = json['href'] as String;

  // ### Загружаем файл на сервер

  final dio = Dio();
  final file = File(imageFromGallery.path);
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file.path),
  });
  dio.put(linkToUpload, data: formData);
}

Future<void> fillMock() async {
  List<PhotoObject> photos;
  
  // ### Получаем ссылку для загрузки
  final uri = Uri.https(
    'cloud-api.yandex.net',
    'v1/disk/resources/files'
  );

  final response = await http.get(
    uri,
    headers: {
      HttpHeaders.authorizationHeader: 'OAuth $token',
    },
  );
  
  Map<String, dynamic> map = jsonDecode(response.body);
  List<dynamic> mapItems = map['items'];
  List<String> files = mapItems.map((elemement) => elemement['file'] as String).toList();
}