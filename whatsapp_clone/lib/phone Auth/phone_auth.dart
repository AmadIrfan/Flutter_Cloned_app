import 'code_confirm.dart';
import 'package:flutter/material.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/custom_button.dart';
import '../utils/show_message.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  bool _isloading = false;
  String _cCode = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                const Icon(
                  Icons.lock,
                  size: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _controller,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '310 012 34 56',
                    contentPadding: const EdgeInsets.all(2),
                    prefix: SizedBox(
                      height: 40,
                      child: CountryCodePicker(
                        initialSelection: '+92',
                        showFlag: false,
                        backgroundColor: Colors.amber,
                        onInit: (value) {
                          _cCode = (value?.dialCode).toString();
                        },
                        // onChanged: ((value) {
                        //   print(value);
                        // }),
                        // hideMainText: true,
                        padding: const EdgeInsets.all(0),
                      ),
                    ),
                    label: const Text(
                      'Phone Number',
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  loading: _isloading,
                  text: 'Next ',
                  onTap: () async {
                    setState(() {
                      _isloading = true;
                    });
                    await _auth.verifyPhoneNumber(
                      phoneNumber: _cCode + _controller.text,
                      verificationCompleted: (vc) {},
                      verificationFailed: (vf) {
                        Utils(message: vf.message.toString()).showMessage();
                      },
                      codeSent: (cs, time) {
                        Utils(
                          message: 'Code sent on $_cCode ${_controller.text} ',
                        ).showMessage();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CodeVerify(verifyCode: cs),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (cart) {},
                    );
                    setState(() {
                      _isloading = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
