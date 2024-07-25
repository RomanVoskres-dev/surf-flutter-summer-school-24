import 'PhotoObj.dart';

abstract interface class IPhotoRepository {
  Future <List<PhotoObject>> getPhotos();
  Future<void> fillPhotos(List<PhotoObject> newphotos);
}