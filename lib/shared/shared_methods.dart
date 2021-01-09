part of 'shared.dart';

Future<File> getImage() async {
  final _picker = ImagePicker();

  final pickedFile = await _picker.getImage(source: ImageSource.gallery);
  final File file = File(pickedFile.path);

  return file;
}

Future<String> uploadImage(File imageFile) async {
  String fileName = basename(imageFile.path);

  Reference ref = FirebaseStorage.instance.ref().child(fileName);

  UploadTask task = ref.putFile(imageFile);

  TaskSnapshot snapshot = await task;

  return await snapshot.ref.getDownloadURL();
}
