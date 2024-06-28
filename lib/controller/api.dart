class Api {
  static const _host = 'http://192.168.234.1/mobile_lanjut';
  static const _hostUser = '$_host/user';

  static const deleteUser = '$_hostUser/delData.php';
  static const getUser = '$_hostUser/getData.php';
  static const login = '$_hostUser/login.php';
  static const register = '$_hostUser/insertData.php';
  static const update = '$_hostUser/updateData.php';
}

class Apartement {
  static const _host = 'http://192.168.234.1/mobile_lanjut';
  static const _hostApartement = '$_host/apartemen';
  static const getApartement = '$_hostApartement/getApartement.php';
  static const createApartement = '$_hostApartement/createApartemen.php';
  static const updateApartement = '$_hostApartement/updateApartemen.php';
  static const deleteApartement = '$_hostApartement/deleteApartemen.php';
}
