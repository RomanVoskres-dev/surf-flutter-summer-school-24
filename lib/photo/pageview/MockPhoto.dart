import 'package:surf_flutter_summer_school_24/photo/pageview/PhotoObj.dart';
import 'package:surf_flutter_summer_school_24/photo/pageview/PhotoRepository.dart';

class MockPhotoRepository implements IPhotoRepository {
  @override
  Future<List<PhotoObject>> getPhotos() async {
    return [
      PhotoObject (
        id: 1,
        url: 'assets/imagesTemp/кавказ.jpg',
        ),
      PhotoObject (
        id: 2,
        url: 'assets/imagesTemp/Питер.jpg',
        ),
      PhotoObject (
        id: 3,
        url: 'assets/imagesTemp/Химки.jpg',
        ),
    ];
  }
  
  @override
  Future<void> fillPhotos(List<PhotoObject> newphotos) {
    // TODO: implement fillPhotos
    throw UnimplementedError();
  }
}