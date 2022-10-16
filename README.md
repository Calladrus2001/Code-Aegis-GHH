## Inspiration
Domestic abuse is a severe issue that undermines the basic human rights of an individual. Lately, there have been quite a few eye-grabbing instances for the same: [Incident A](https://timesofindia.indiatimes.com/city/ahmedabad/satellite-woman-57-files-dv-plaint/articleshow/93172369.cms), [Incident B](https://timesofindia.indiatimes.com/city/kolhapur/woman-police-constable-ends-life-mentions-domestic-violence-in-note/articleshow/90900716.cms). Due to these reasons, I felt it was appropriate to develop a solution for this problem. I also saw the [Youtube Video](https://www.youtube.com/watch?v=ZJL_8kNFmTI) of the famous 911-Pizza call and decided to do that, but way better.
## What it does
Our App allows the users to deal with all 3 phases of an event:
- Before (Preventing the incident)
- During (Dealing with the incident)
- After (Ensuring safety in the aftermath)

With the help of our **Chatbot** you can contact your emergency contacts without alerting the abuser by _disguising_ your request as a Pizza Order.  
After suffering such an incident, it's very likely for victims to develop some sort of PTSD. To deal with that, Chatbot can assign UserID's of _therapist_ accounts to Users from where they can **chat**, and even **VideoCall** each other.

So how does this happen? First the user logs in and gets directed to the chatbot screen. Here, I have a glossary which contains randomised keywords which are to be used to make a pizza order. This can be done via Audio/Text input. Then the user accesses the Cart where it can be confirmed if the Order is as it should be, and then the User can send the SMS to all emergency contacts.

I also have a **Helpline** feature where you can call a certain number and your side of the call can be stored as evidence. I also transcribe the call contents and send that to authorities and User's emergency contacts via SMS.

## How I built it
I made the App using Flutter. I used Firebase for Authentication and Firestore as the NoSQL database. I made the chatbot using Dialogflow. I used **Twilio Voice API** to implement the programmable phone calls and the **SMS API** for sending the text messages. I used Node.js-express.js combo to handle the Ibhook calls made by Dialogflow and Twilio. I used Agora RTC SDK for Flutter to implement the video-calling functionality.

## Challenges I ran into
This was the first time I Ire using Twilio's voice API and it gave some Iird sound-looping behaviour initially preventing us from sending transcripts of recordings, though I somehow managed in the end. I Ire getting lots of blank responses for the chatbot Ibhook calls, which as you can see, is the main component of the app and thus I Ire under a lot of pressure to fix it. As it turns out, I just forgot to import _body-parser_.
## Accomplishments that I're proud of
I are especially proud to have made a product that will affect thousands and thousands of people. The use of twilio voice API in this project is something special and can be enhanced further. I successfully implemented "Entities" in dialogflow which made the User experience personalised.

## Use Cases:
- To prevent domestic abuse.
- To prevent and deal with elder abuse.
- To protect tourists from harm.

## What's next for Code:Aegis
- SMS messages can be ignored, a better option would be to use WhatsApp messages instead.
- A provision for witnesses of domestic abuse to report it along with evidence.
- Broadening the scope of keywords to prevent abusers from catching on.
