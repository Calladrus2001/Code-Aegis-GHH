import 'package:code_margerita/secrets.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioSMS {
  void sendSMS(String body) {
    TwilioFlutter twilioFlutter;
    twilioFlutter = TwilioFlutter(
      accountSid: twilio_sid,
      authToken: auth_token,
      twilioNumber: mobile,
    );
    twilioFlutter.sendSMS(toNumber: mobile2, messageBody: body);
  }
}
