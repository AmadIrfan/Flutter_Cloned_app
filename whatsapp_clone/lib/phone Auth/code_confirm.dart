// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../windows/home_page.dart';
import '../utils/custom_button.dart';
import '../utils/show_message.dart';

class CodeVerify extends StatefulWidget {
  const CodeVerify({
    super.key,
    required this.verifyCode,
  });
  final String verifyCode;
  @override
  State<CodeVerify> createState() => _CodeVerifyState();
}

class _CodeVerifyState extends State<CodeVerify> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _c1 = TextEditingController();
  final TextEditingController _c2 = TextEditingController();
  final TextEditingController _c3 = TextEditingController();
  final TextEditingController _c4 = TextEditingController();
  final TextEditingController _c5 = TextEditingController();
  final TextEditingController _c6 = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Verify Code',
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                      child: TextFormField(
                        controller: _c1,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        obscuringCharacter: '*',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: TextFormField(
                        controller: _c2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        obscureText: true,
                        obscuringCharacter: '*',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: TextFormField(
                        controller: _c3,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        obscureText: true,
                        obscuringCharacter: '*',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: TextFormField(
                        controller: _c4,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        obscuringCharacter: '*',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: TextFormField(
                        controller: _c5,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        obscuringCharacter: '*',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: TextFormField(
                        controller: _c6,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        obscuringCharacter: '*',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 1,
                      ),
                    ),
                  ],
                ),
              ),
              MyButton(
                loading: _loading,
                text: 'Very Code',
                onTap: () async {
                  setState(() {
                    _loading = true;
                  });
                  try {
                    String code = _c1.text +
                        _c2.text +
                        _c3.text +
                        _c4.text +
                        _c5.text +
                        _c6.text;
                    if (kDebugMode) {
                      print(code);
                    }
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                      verificationId: widget.verifyCode.toString(),
                      smsCode: code,
                    );
                    await _auth.signInWithCredential(
                      phoneAuthCredential,
                    );
                    Utils(message: 'Log In Successful').showMessage();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ),
                    );

                    setState(() {
                      _loading = false;
                    });
                  } catch (e) {
                    Utils(message: 'faild').showMessage();
                    setState(() {
                      _loading = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
