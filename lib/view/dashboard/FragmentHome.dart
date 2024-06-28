import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_semt3/controller/api.dart';

class FragmentHome extends StatefulWidget {
  const FragmentHome({super.key});

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> {
  List _listData = [];
  bool _isLoading = true;

  Future _getApartemen() async {
    try {
      final respon = await http.get(Uri.parse("http://192.168.234.1/mobile_lanjut/apartemen/getApartement.php"));
      if (respon.statusCode == 200) {
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

  @override
  void initState() {
    super.initState();
    _getApartemen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apartemen"),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.0,
                crossAxisCount: 3,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemCount: _listData.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      backgroundImage: NetworkImage(
                     _listData[index]['gambar']
                      ),
                    ),
                    title: Text(_listData[index]['nama_apartemen']),
                    subtitle:  Text(_listData[index]['alamat']),
                    trailing: SizedBox(
                      width: 120.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 12.0,
                            child: Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 9.0,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "1",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 12.0,
                            child: Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 9.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
