import 'dart:io';
import 'package:file_picker/file_picker.dart' as FilePicker;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';
import 'package:take_drug/Common/DialogBox/errorDialog.dart';
import 'package:take_drug/Common/DialogBox/loadingDialog.dart';
import 'package:take_drug/Common/config/config.dart';
import 'package:intl/intl.dart' as DateTimeLibrary;

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? _file;
  String? _uploadedFileURL;
  String fullName =
      "${takeDrug.sharedPreferences!.getString(takeDrug.FristNameUser)} ${takeDrug.sharedPreferences!.getString(takeDrug.SecondNameUser)}";

  String? currentUser = takeDrug.auth?.currentUser?.uid;

  // Pick Files
  Future<void> _pickFile() async {
    FilePicker.FilePickerResult? result =
        await FilePicker.FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      final path = result.files.single.path!;

      setState(() {
        _file = File(path);
      });
    }
  }

  // Upload Files
  _uploadFile() async {
    if (_file != null) {
      showDialog(
        context: context,
        builder: (_) => const LoadingAlertDialog(
          message: "رفع الملفات...",
        ),
      );
      final fileName = Path.basename(_file!.path);
      final destination = 'files/$fileName';
      try {
        final ref = FirebaseStorage.instance.ref(destination);
        TaskSnapshot task = await ref.putFile(_file!).whenComplete(() {});
        // get the download url
        _uploadedFileURL = await task.ref.getDownloadURL();

        // get the file type
        String fileType = Path.extension(_file!.path);
        print("the file type ${fileType}");

        // going to the function
        UploadToFirebaseCloud(fileType, _uploadedFileURL!);

        print("The download link is : ${_uploadedFileURL}");
      } on FirebaseException catch (e) {
        return errorDialog(message: e.toString());
      }
      Navigator.pop(context);
    } else {
      return showDialogFunction();
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName =
        _file != null ? Path.basename(_file!.path) : 'لم يتم اختيار اي شي';
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Upload to Firebase Storage'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/lightBlue.png",
              width: 190,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, // <-- match_parent
                    child: ElevatedButton(
                      onPressed: _pickFile,
                      style: ElevatedButton.styleFrom(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'اختر ملف',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.upload,
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(fileName),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity, // <-- match_parent
                    child: ElevatedButton(
                      onPressed: _uploadFile,
                      style: ElevatedButton.styleFrom(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'رفم ملف',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.cloud,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: const [
                  Text(
                    "تنويه:",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "الرجاء رفع ملفات طبية فقط، في حالة وجود ملقات غير طبية، هذا يعتبر مخالف لسياسات استخدام منصة TakeDrug وقد تودي الى اغلاق حسابك.",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Uploading files to send to database Firebase
  UploadToFirebaseCloud(String fileType, String _uploadedFileURL) async {
    String currentUser = takeDrug.auth!.currentUser!.uid;
    await takeDrug.firebaseFirestore!.collection("filesUploaded").add({
      "userUploadedUID": currentUser.trim().toString(),
      "FullName": fullName,
      "fileType": fileType.trim().toString(),
      "fileURL": _uploadedFileURL.trim().toString(),
      "DateTime": DateTimeLibrary.DateFormat('dd-MM-yyyy')
          .format(DateTime.now())
          .toString(),
    }).then((value) {
      showDialog(
          context: context,
          builder: (_) => const errorDialog(message: "تم رفع الملفات"));
    });
  }

  showDialogFunction() {
    showDialog(
      context: context,
      builder: (_) => const errorDialog(
        message: "قم برفع ملف اولا",
      ),
    );
  }
}
