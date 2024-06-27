import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_semt3/config/asset.dart';
import 'package:mobile_semt3/controller/api.dart';
import 'package:mobile_semt3/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_semt3/view/dashboard/dashboard.dart';
import 'package:mobile_semt3/widget/infomessage.dart';

import '../../event/eventpref.dart';

class EditProfil extends StatelessWidget {
  var _controllerName = TextEditingController();
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _obsecure = true.obs;
  EditProfil(
      {required this.idUser,
      required this.userName,
      required this.password,
      required this.email});
  final String userName, password, email;
  final int idUser;
  void edit() async {
    User user = User(idUser, _controllerName.text, _controllerEmail.text,
        _controllerPassword.text, _controllerName.text, "user");
    try {
      var response =
          await http.post(Uri.parse(Api.update), body: user.toJson());
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        var status = jsonDecode(response.body)['status'];
        var result = jsonDecode(response.body)['result'];
        if (status == 200) {
          InfoMessage.snackbar(Get.context!, 'Edit Profile Success $result');
          // saveuser setelah di update
          await EventPref.saveUser(user);
          // pindahkan kehalaman dashboard setelah disave editprofile
          Get.to(DashBoard());
        } else {
          InfoMessage.snackbar(Get.context!, 'Registrasi Failed $result');
        }
      }
    } catch (e) {
      print(e);
      InfoMessage.snackbar(Get.context!, 'coding erorr');
    }
  }

  @override
  Widget build(BuildContext context) {
    _controllerName.text = userName;
    _controllerPassword.text = password;
    _controllerEmail.text = email;
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
                            offset: Offset(0, -3)),
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
                                      controller: _controllerEmail,
                                      validator: (value) =>
                                          value == '' ? "Don't Empty" : null,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Asset.colorPrimary,
                                        ),
                                        hintText: 'Email@email.com',
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
                                      controller: _controllerName,
                                      validator: (value) =>
                                          value == '' ? "Don't Empty" : null,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Asset.colorPrimary,
                                        ),
                                        hintText: 'User Name',
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
                                    Obx(() {
                                      return TextFormField(
                                        validator: (value) =>
                                            value == '' ? "Don't Empty" : null,
                                        obscureText: _obsecure.value,
                                        controller: _controllerPassword,
                                        // obscureText: _controllerPassword.value,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.password,
                                            color: Asset.colorPrimary,
                                          ),
                                          suffixIcon: Obx(() {
                                            return GestureDetector(
                                              onTap: () {
                                                _obsecure.value =
                                                    !_obsecure.value;
                                              },
                                              child: Icon(
                                                _obsecure.value
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Asset.colorPrimary,
                                              ),
                                            );
                                          }),
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
                                      );
                                    }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Obx(() {
                                      return TextFormField(
                                        validator: (value) =>
                                            value == '' ? "Don't Empty" : null,
                                        obscureText: _obsecure.value,
                                        controller: _controllerPassword,
                                        // obscureText: _controllerPassword.value,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.password,
                                            color: Asset.colorPrimary,
                                          ),
                                          suffixIcon: Obx(() {
                                            return GestureDetector(
                                              onTap: () {
                                                _obsecure.value =
                                                    !_obsecure.value;
                                              },
                                              child: Icon(
                                                _obsecure.value
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Asset.colorPrimary,
                                              ),
                                            );
                                          }),
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
                                      );
                                    }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      color: Asset.colorPrimary,
                                      borderRadius: BorderRadius.circular(30),
                                      child: InkWell(
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            edit();
                                            print('Register');
                                          }
                                        },
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
                                        ))
                                  ]),
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
        ));
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
