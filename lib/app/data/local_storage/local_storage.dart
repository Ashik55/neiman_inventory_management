import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final box = GetStorage();

  String username = 'email';
  String password = 'password';
  String isLoggedIn = 'isLoggedIn';
  String sellerId = 'sellerId';
  String lastSelectedCustomerId = 'lastSelectedCustomerId';
  String isCustomer = 'isCustomer';
  String customerID = 'customerID';

  clearStorage() {
    box.erase();
  }

  String? getCustomerID() {
    return box.read(customerID);
  }

  setCustomerID(String? value) {
    box.write(customerID, value);
  }

  bool? getIsCustomer() {
    return box.read(isCustomer) ?? false;
  }

  setIsCustomer(bool? value) {
    box.write(isCustomer, value);
  }

  String? getSellerId() {
    return box.read(sellerId);
  }

  setSellerId(String? value) {
    box.write(sellerId, value);
  }

  String? getLastSelectedCustomerId() {
    return box.read(lastSelectedCustomerId);
  }

  setLastSelectedCustomerId(String? value) {
    box.write(lastSelectedCustomerId, value);
  }

  String? getUserName() {
    return box.read(username);
  }

  setUserName(String? value) {
    box.write(username, value);
  }

  String? getPassword() {
    return box.read(password);
  }

  setPassword(String? value) {
    box.write(password, value);
  }

  bool? getIsLoggedIn() {
    return box.read(isLoggedIn);
  }

  setIsLoggedIn(bool? value) {
    box.write(isLoggedIn, value);
  }
}
