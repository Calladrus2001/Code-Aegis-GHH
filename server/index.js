const bodyParser = require('body-parser');
const express = require('express');
const app = express();

const voiceRouter = require('./routes/twilio/voice');

app.use(bodyParser.json());
app.use(voiceRouter);


app.listen(3000, ()=>{
    console.log("Server started listening on port 3000");
});