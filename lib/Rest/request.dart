import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:surf_flutter_summer_school_24/photo/PhotoRepository.dart';

const token = 'швейцарская конвенция запретила';

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

Future<void> fillRepository() async {
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
  mapItems.removeWhere((element) => element['media_type'] != 'image');
  List<String> files = mapItems.map((elemement) => elemement['file'] as String).toList();

  PhotoRepository repository = PhotoRepository();
  repository.addPhotos(files);
}