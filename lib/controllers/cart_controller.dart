import 'package:eemart/consts/consts.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  // calculate total price
  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  // text controllers for shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }
}
