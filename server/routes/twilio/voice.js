require('dotenv').config()
const VoiceResponse = require('twilio').twiml.VoiceResponse;
const client = require('twilio')(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);
const express = require('express');
const bodyParser = require('body-parser');
const router = express.Router();

router.use(bodyParser.urlencoded({
    extended: true
}));

router.post("/voice", (req, res)=>{
    const twiml = new VoiceResponse();
    twiml.say("Good Day! This is Code Aegis, please place your order after this message ends.");
    twiml.record({
        timeout: 5,
        maxLength : 60,
        finishOnKey: '*',
        action : '/handleRecording',
        transcribe: true,
        transcribeCallback: "/handleTranscribe"
    });

    twiml.say("No response recieved, hanging up");
    res.type('text/xml');
    res.send(twiml.toString());
});

router.post("/handleRecording", (req, res)=>{
    const twiml = new VoiceResponse();
    twiml.say("Recording Received, We'll send the SMS shortly.");
    res.type('text/xml');
    res.send(twiml.toString());
});

router.post("/handleTranscribe", (req, res)=>{
    const text = req.body.TranscriptionText;
    console.log(req.body);
    client.messages.create({
            body : `~~Code:Aegis ALERT~~\n${text}`,
            from : '+12565872797',
            to: '+919309392932'
        })
        .then(message => console.log(message.sid));
    res.send("thanks");
});

module.exports = router;