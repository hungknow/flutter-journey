// https://api.flutter.dev/flutter/widgets/AutofillGroup-class.html

import 'package:flutter/material.dart';

class AutofillGroupWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AutofillGroupWidgetState();
}

class _AutofillGroupWidgetState extends State<AutofillGroupWidget> {
  bool isSameAddress = true;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  final TextEditingController shippingAddress1 = TextEditingController();
  final TextEditingController shippingAddress2 = TextEditingController();
  final TextEditingController billingAddress1 = TextEditingController();
  final TextEditingController billingAddress2 = TextEditingController();

  final TextEditingController creditCardNumber = TextEditingController();
  final TextEditingController creditCardSecurityCode = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      const Text('Username & Password'),
      AutofillGroup(
          child: Column(children: [
        TextField(
          controller: username,
          autofillHints: const <String>[AutofillHints.username],
        ),
        TextField(
          controller: password,
          autofillHints: const <String>[AutofillHints.password],
        ),
      ])),
      const Text('Shipping address'),
      // The address fields are grouped together as some platforms are
      // capable of autofilling all of these fields in one go.
      AutofillGroup(
          child: Column(children: <Widget>[
        TextField(
          controller: shippingAddress1,
          autofillHints: const <String>[AutofillHints.streetAddressLine1],
        ),
        TextField(
          controller: shippingAddress2,
          autofillHints: const <String>[AutofillHints.streetAddressLine2],
        )
      ])),
      const Text('Billing address'),
      Checkbox(
        value: isSameAddress,
        onChanged: (bool? newValue) {
          if (newValue != null) {
            setState(() {
              isSameAddress = newValue;
            });
          }
        },
      ),
      if (!isSameAddress)
        AutofillGroup(
          child: Column(
            children: <Widget>[
              TextField(
                controller: billingAddress1,
                autofillHints: const <String>[
                  AutofillHints.streetAddressLine1,
                ],
              ),
              TextField(
                controller: billingAddress2,
                autofillHints: const <String>[
                  AutofillHints.streetAddressLine2,
                ],
              ),
            ],
          ),
        ),
      TextField(
        controller: phoneNumber,
        autofillHints: const <String>[AutofillHints.telephoneNumber],
      ),
    ]);
  }
}
