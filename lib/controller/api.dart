class Api {
  static const _host = 'http://192.168.234.1/mobile_lanjut';
  static const _hostUser = '$_host/user';

  static const deleteUser = '$_hostUser/delData.php';
  static const getUser = '$_hostUser/getData.php';
  static const login = '$_hostUser/login.php';
  static const register = '$_hostUser/insertData.php';
  static const update = '$_hostUser/updateData.php';
}
