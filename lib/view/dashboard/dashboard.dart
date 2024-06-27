import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_semt3/config/asset.dart';
import 'package:mobile_semt3/controller/Controller_User.dart';
import 'package:mobile_semt3/view/dashboard/FragmentHome.dart';
import 'package:mobile_semt3/view/dashboard/FragmentListUser.dart';
import 'package:mobile_semt3/view/dashboard/FragmentProfil.dart';
import 'package:mobile_semt3/view/dashboard/FragmentWishList.dart';

class DashBoard extends StatelessWidget {
  RxInt _index = 0.obs;
  List<Widget> _fragment = [
    FragmentHome(),
    FragmentWishlist(),
    FragmnetListUser(),
    FragmentProfil(),
  ];
  List _navs = [
    {
      'icon_on': Icons.home,
      'icon_off': Icons.home_outlined,
      'label': 'Home',
    },
    {
      'icon_on': Icons.bookmark,
      'icon_off': Icons.bookmark_border,
      'label': 'Wishlist',
    },
    {
      'icon_on': FontAwesomeIcons.listAlt,
      'icon_off': FontAwesomeIcons.listAlt,
      'label': 'Order',
    },
    {
      'icon_on': Icons.account_circle,
      'icon_off': Icons.account_circle_outlined,
      'label': 'Profile',
    },
  ];
  CUser _cUser = Get.put(CUser());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CUser(),
      initState: (state) {
        _cUser.getUser();
      },
      builder: ((controller) {
        return Scaffold(
          body: Obx(() => _fragment[_index.value]),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: _index.value,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Asset.colorTextTitle,
              unselectedItemColor: Asset.colorTextTitle,
              backgroundColor: Color.fromARGB(255, 45, 47, 87),
              type: BottomNavigationBarType.fixed,
              onTap: (value) => _index.value = value,
              items: List.generate(_fragment.length, (index) {
                var nav = _navs[index];
                return BottomNavigationBarItem(
                  icon: Icon(nav['icon_off']),
                  label: nav['label'],
                  activeIcon: Icon(nav['icon_on']),
                );
              }))),
        );
      }),
    );
  }
}
