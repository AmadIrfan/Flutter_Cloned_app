import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/model_view/user_model.dart';
import 'package:whatsapp_clone/utils/show_message.dart';

import '../model_view/fire_store_methods.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String dropDownValue = 'Available';
  final _key = GlobalKey<FormFieldState>();
  File? _img;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController __aboutEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    var items = [
      'Hello',
      'Available',
      'Assalam U Alikum',
      'Item 4',
      'Item 5',
    ];
    __aboutEditingController.text = dropDownValue;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Profile',
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: _img == null
                      ? const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage(
                            'Assets/Logo/image.png',
                          ),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          backgroundImage: FileImage(
                            File(_img!.path),
                          ),
                        ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      pickImage();
                    },
                    icon: const Icon(
                      Icons.camera,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              key: _key,
              controller: _textEditingController,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Name can not be empty';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: __aboutEditingController,
              decoration: InputDecoration(
                suffix: DropdownButton(
                  underline: const SizedBox(),
                  // focusColor:,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (newValue) {
                    setState(() {
                      dropDownValue = newValue!;
                      __aboutEditingController.text = dropDownValue;
                    });
                  },
                ),
                label: const Text('About'),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onSave();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 10,
              ),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void pickImage() {
    ImagePicker imgP = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton.icon(
              onPressed: () async {
                final imgPick =
                    await imgP.pickImage(source: ImageSource.gallery);
                if (imgPick != null) {
                  setState(() {
                    _img = File(imgPick.path);
                  });
                }
              },
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
            OutlinedButton.icon(
              onPressed: () async {
                final imgPick = await imgP.pickImage(
                  source: ImageSource.camera,
                );
                if (imgPick != null) {
                  setState(() {
                    _img = File(imgPick.path);
                  });
                }
              },
              icon: const Icon(
                Icons.photo_album,
              ),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }

  onSave() async {
    try {
      User u = _auth.currentUser!;
      if (_key.currentState!.validate()) {
        UserModel user = UserModel(
          about: __aboutEditingController.text,
          name: _textEditingController.text,
          uId: u.uid,
          phoneNumber: u.phoneNumber.toString(),
          profileImage: _img!.path.toString(),
          groupIds: [],
        );
        String img = await Provider.of<FireStoreMethods>(context)
            .uploadImage('${u.uid}/profile image /', _img as File);
      }
    } catch (e) {
      Utils(
        message: e.toString(),
        color: Colors.red,
      );
    }
  }
}
