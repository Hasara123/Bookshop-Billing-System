package lk.hasara.advanceprogrammingassingmentmy.util;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class SMSUtil {

    // Replace with your Twilio account SID and auth token
    public static final String ACCOUNT_SID = "AC271e1bbf36d0a26c369fc3c76e0c3687";
    public static final String AUTH_TOKEN = "c3af11c6ae3c2175460ff75c0f8168ff";
    public static final String FROM_NUMBER = "+15137173198"; // Twilio number

    static {
        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
    }

    public static void sendSMS(String toNumber, String messageBody) {
        Message.creator(
                new PhoneNumber(toNumber),
                new PhoneNumber(FROM_NUMBER),
                messageBody
        ).create();
    }
}
