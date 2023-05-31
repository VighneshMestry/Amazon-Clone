import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/feautres/address/services/address_services.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address-screen';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController flatHouseController = TextEditingController();
  TextEditingController areaStreetController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController townCityController = TextEditingController();
  final addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = "";
  AddressServices addressServices = AddressServices();

  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
          amount: widget.totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatHouseController.dispose();
    areaStreetController.dispose();
    pincodeController.dispose();
    townCityController.dispose();
  }

  void addressToUsedForPayment(String addressProvided) {
    addressToBeUsed = "";

    bool isForm = flatHouseController.text.isNotEmpty ||
        areaStreetController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        townCityController.text.isNotEmpty;

    if (isForm) {
      if (addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatHouseController.text}, ${areaStreetController.text}, ${townCityController.text} - ${pincodeController.text}";
      } else {
        throw Exception("Enter all the values!");
      }
    } else if (addressProvided.isNotEmpty) {
      addressToBeUsed = addressProvided;
    } else {
      showSnackBar(context, 'ERROR');
    }
    print(addressToBeUsed);
  }

  void onGooglePayResult(res) async {
    if(Provider.of<UserProvider>(context).user.address.isEmpty){
      // await addressServices.saveUserAddress(context: context, address: addressToBeUsed);
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final address = context.watch<UserProvider>().user.address;
    const String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "gatewayMerchantId"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["VISA", "MASTERCARD"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": true
          }
        }
      }
    ],
    "merchantInfo": {
      "merchantId": "01234567890123456789",
      "merchantName": "Example Merchant Name"
    },
    "transactionInfo": {
      "countryCode": "US",
      "currencyCode": "USD"
    }
  }
}''';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            address,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('OR', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatHouseController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaStreetController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: townCityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              // ApplePayButton(
              //   paymentConfiguration: PaymentConfiguration.fromJsonString('gpay.json'),
              //   onPaymentResult: onApplePayResult,
              //   paymentItems: paymentItems,
              // ),
              GooglePayButton(
                onPressed: () => addressToUsedForPayment(address),
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15),
                width: double.infinity,
                height: 50,
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultGooglePay),
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                loadingIndicator: const Center(child: Loader()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
