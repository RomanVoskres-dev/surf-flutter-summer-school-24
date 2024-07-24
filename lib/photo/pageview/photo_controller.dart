import 'package:surf_flutter_summer_school_24/photo/pageview/MockPhoto.dart';
import 'PhotoObj.dart';

//Singleton
class PhotoController {
  static final PhotoController _singleton = PhotoController._internal();
  
  factory PhotoController() {
    return _singleton;
  }
  
  PhotoController._internal();

  MockPhotoRepository _mockPhotoRepository = new MockPhotoRepository();

  Future<List<PhotoObject>> getPhotos() async {
    final photos = await _mockPhotoRepository.getPhotos();
    return photos;
  }
}