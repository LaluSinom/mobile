import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../config/asset.dart';
import '../../controller/api.dart';
import '../../model/user.dart';
import '../../widget/infomessage.dart';

class Register extends StatelessWidget {
  var _controllerName = TextEditingController();
  var _controllerUserName = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _controllerEmail = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _obsecure = true.obs;

  void register() async {
    if (_formKey.currentState!.validate()) {
      User user = User(
        1,
        _controllerName.text,
        _controllerUserName.text,
        _controllerPassword.text,
        _controllerEmail.text,
        "user",
      );
      try {
        var response =
            await http.post(Uri.parse(Api.register), body: user.toJson());
        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          var status = responseBody['status'];
          if (status == 200) {
            var result = responseBody['result'];
            InfoMessage.snackbar(Get.context!, 'Registrasi berhasil');
          } else {
            InfoMessage.snackbar(Get.context!, 'Registrasi Gagal');
          }
        }
      } catch (e) {
        print(e);
        InfoMessage.snackbar(
            Get.context!, 'Terjadi kesalahan saat melakukan registrasi');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Asset.colorBackground,
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.7),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(width: 5, color: Asset.colorAccent),
              ),
              child: Icon(
                Icons.account_circle,
                size: 120,
                color: Asset.colorAccent,
              ),
            ),
          ),
          Positioned(
            child: Text(
              'Register',
              style: TextStyle(
                fontSize: 20,
                color: Asset.colorAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: MediaQuery.of(context).size.height * 0.5 + 15,
            left: 20,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            bottom: 0,
            right: 0,
            left: 0,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.black26,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _controllerName,
                                    validator: (value) => value!.isEmpty
                                        ? "Nama tidak boleh kosong"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Asset.colorPrimary,
                                      ),
                                      hintText: 'Nama',
                                      border: styleBorder(),
                                      enabledBorder: styleBorder(),
                                      focusedBorder: styleBorder(),
                                      disabledBorder: styleBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      fillColor: Asset.colorAccent,
                                      filled: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _controllerUserName,
                                    validator: (value) => value!.isEmpty
                                        ? "Username tidak boleh kosong"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Asset.colorPrimary,
                                      ),
                                      hintText: 'Username',
                                      border: styleBorder(),
                                      enabledBorder: styleBorder(),
                                      focusedBorder: styleBorder(),
                                      disabledBorder: styleBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      fillColor: Asset.colorAccent,
                                      filled: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _controllerPassword,
                                    validator: (value) => value!.isEmpty
                                        ? "Password tidak boleh kosong"
                                        : null,
                                    obscureText: _obsecure.value,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Asset.colorPrimary,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          _obsecure.value = !_obsecure.value;
                                        },
                                        child: Icon(
                                          _obsecure.value
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Asset.colorPrimary,
                                        ),
                                      ),
                                      hintText: 'Password',
                                      border: styleBorder(),
                                      enabledBorder: styleBorder(),
                                      focusedBorder: styleBorder(),
                                      disabledBorder: styleBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      fillColor: Asset.colorAccent,
                                      filled: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _controllerEmail,
                                    validator: (value) => value!.isEmpty
                                        ? "Email tidak boleh kosong"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Asset.colorPrimary,
                                      ),
                                      hintText: 'Email',
                                      border: styleBorder(),
                                      enabledBorder: styleBorder(),
                                      focusedBorder: styleBorder(),
                                      disabledBorder: styleBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      fillColor: Asset.colorAccent,
                                      filled: true,
                                    ),
                                  ),
                                  Material(
                                    color: Asset.colorPrimary,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: register,
                                      borderRadius: BorderRadius.circular(30),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Kembali Ke'),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Asset.colorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  InputBorder styleBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        width: 0,
        color: Asset.colorAccent,
      ),
    );
  }
}
