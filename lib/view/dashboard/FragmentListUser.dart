import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_semt3/controller/Controller_User.dart';
import 'package:mobile_semt3/controller/api.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_semt3/widget/infomessage.dart';

class FragmnetListUser extends StatefulWidget {
  const FragmnetListUser({super.key});
  @override
  State<FragmnetListUser> createState() => _FragmnetListUserState();
}

class _FragmnetListUserState extends State<FragmnetListUser> {
  // object untuk mengambil data pada controler user
  final _cUser = Get.put(CUser());
  // menampung semua data ketika mengambil dari body result
  List _listData = [];
  bool _isLoading = true;
  // ambi get user
  Future _getdata() async {
    try {
      final respon = await http.get(Uri.parse(Api.getUser));
      if (respon.statusCode == 200) {
        // print(respon.body);
        var data = jsonDecode(respon.body)['result'];
        setState(() {
          _listData = data;
          _isLoading = false;
        });
      } else {
        print("HTTP Error: ${respon.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteUser(String idUser) async {
    try {
      var response = await http.post(Uri.parse(Api.deleteUser), body: {
        'id': idUser,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          setState(() {
            _getdata();
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listData.length,
              itemBuilder: (context, index) => Card(
                child: InkWell(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/id/1/200/300'),
                    ),
                    title: Text(_listData[index]['nama']),
                    subtitle: Text(_listData[index]['email']),
                    trailing: ElevatedButton.icon(
                      label: Text(''),
                      icon: Icon(Icons.delete),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          iconColor: MaterialStatePropertyAll(Colors.white)),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          if (_listData[index]['id'] !=
                              _cUser.user.idUser.toString()) {
                            return AlertDialog(
                              title: Text('Hapus'),
                              content: Text('Yakin ingin dihapus?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => setState(() {
                                    // _controller.delete(index);
                                    deleteUser(_listData[index]['id']);
                                    Navigator.pop(context, 'Berhasil');
                                    InfoMessage.snackbar(
                                        Get.context!, 'Delete Berhasil');
                                  }),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          } else {
                            return AlertDialog(
                              title: Text('Info'),
                              content: Text('tidak bisa dihapus!!'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => setState(() {
                                    Navigator.pop(context, 'Berhasil');
                                  }),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
