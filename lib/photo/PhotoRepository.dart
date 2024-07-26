import 'PhotoObj.dart';

class PhotoRepository {
  static final PhotoRepository _singleton = PhotoRepository._internal();
  List<PhotoObject>? _photos = null;

  factory PhotoRepository() {
    return _singleton;
  }
  
  PhotoRepository._internal();

  void addPhotos(List<String> urls) async {
    for(int i = 0; i < urls.length; i++) {
      if(_photos == null)
      {
        List<PhotoObject> newList = <PhotoObject>[];
        newList.add(PhotoObject(url: urls[i]));
        _photos = newList;
      }
      else {
        _photos?.add(PhotoObject(url: urls[i]));
      }
    }
  }

  Future<List<PhotoObject>?> getPhotos() async {
    return _photos;
  }
}