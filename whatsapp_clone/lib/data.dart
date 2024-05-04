import 'dart:async';

import 'package:dcmg/data/globals.dart';
import 'package:dcmg/screens/nodesOps/service/customer_crud_service.dart';
import 'package:dcmg/screens/role_management/service/customer_user_crud_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../network/models/lookup_crud_model.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog(
      {super.key,
      required this.stream,
      required this.customerCrudList,
      required this.userRoles});
  final StreamController stream;
  final List<String> customerCrudList;
  final List<LookUpCrudModel> userRoles;

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  late String roleValue = 'Admin';
  late String customerValue = 'LUMS';
  late List<String> roleList = ['Admin', 'User', 'Restricted User'];
  StreamController<List<String>> streamController =
      StreamController<List<String>>();

  @override
  initState() {
    print("here");
    loadRoles();
    super.initState();
  }

  Future<int> loadUsers() async {
    var list = await CustomerUserCrudService.getCustomerUserCrud(
        Crud.RA,
        usernameController.text,
        passwordController.text,
        emailController.text,
        phoneNoController.text,
        '',
        '',
        '');
    widget.stream.add(list);
    return 1;
  }

  void loadRoles() {
    if (widget.userRoles.isEmpty) {
      streamController.add(roleList);
      return;
    }
    roleList = [];
    for (var role in widget.userRoles) {
      roleList.add(role.visibleValue!);
    }

    roleValue = roleList.first;

    streamController.add(roleList);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      scrollable: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/user.png',
            height: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Create User',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      titleTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titlePadding: const EdgeInsets.only(top: 40),
      //this right here
      content: SizedBox(
        height: 400.0,
        width: 400.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: size.width * 0.5,
              child: TextFormField(
                controller: usernameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: 'Enter Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[200]),
              ),
            ),
            SizedBox(
              width: size.width * 0.5,
              child: TextFormField(
                controller: passwordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: 'Enter Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[200]),
              ),
            ),
            SizedBox(
              width: size.width * 0.5,
              child: TextFormField(
                controller: emailController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: 'Enter Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[200]),
              ),
            ),
            SizedBox(
              width: size.width * 0.5,
              child: TextFormField(
                controller: phoneNoController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: 'Enter Phone No.',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[200]),
              ),
            ),
            Wrap(
              spacing: 5.0,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_roleDropDown(), _customerDropDown()],
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _addBtn(),
              _closeBtn(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _roleDropDown() {
    return Column(
      children: [
        const Text(
          'Role',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: 150,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: StreamBuilder(
            stream: streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DropdownButton(
                  isExpanded: true,
                  menuMaxHeight: 300,
                  style: const TextStyle(fontSize: 14),
                  underline: const SizedBox(),
                  value: roleValue,
                  onChanged: (newValue) {
                    setState(() {
                      roleValue = newValue.toString();
                    });
                  },
                  items: roleList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              }

              return const Center(
                child: SpinKitThreeBounce(
                  color: Colors.blue,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _customerDropDown() {
    return Column(
      children: [
        const Text(
          'Customer',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: 150,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: DropdownButton(
            isExpanded: true,
            menuMaxHeight: 300,
            style: const TextStyle(fontSize: 14),
            underline: const SizedBox(),
            value: customerValue,
            onChanged: (newValue) {
              setState(() {
                customerValue = newValue.toString();
              });
            },
            items: widget.customerCrudList.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _addBtn() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        )),
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(20)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xff1c313a)),
      ),
      onPressed: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) => const SpinKitThreeBounce(
                  color: Colors.black,
                ));

        var response = await CustomerUserCrudService.createCustomerUserCrud(
            usernameController.text,
            passwordController.text,
            emailController.text,
            phoneNoController.text,
            roleValue == "Admin" ? "Super Admin" : roleValue,
            customerValue,
            customerValue);
        if (response['status'] == '200') {
          const SnackBar snackBar = SnackBar(
              behavior: SnackBarBehavior.floating,
              width: 300,
              duration: Duration(seconds: 2),
              content: Text(
                'User Created Successfully',
                textAlign: TextAlign.center,
              ));
          snackbarKey.currentState?.showSnackBar(snackBar);
        } else {
          final SnackBar snackBar = SnackBar(
              behavior: SnackBarBehavior.floating,
              width: 300,
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
              content: Text(
                response['error'],
                textAlign: TextAlign.center,
              ));
          snackbarKey.currentState?.showSnackBar(snackBar);
        }
        loadUsers();
        Get.back();
        Get.back();
      },
      child: const Text('Add'),
    );
  }

  Widget _closeBtn() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        )),
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(20)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xff1c313a)),
      ),
      onPressed: () {
        Get.back();
      },
      child: const Text('Close'),
    );
  }
}