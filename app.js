'use strict'
const http = require('http')
const Bot = require('messenger-bot')
const request = require('request');

let bot = new Bot({
  token: process.env.PAGE_TOKEN,
  verify: process.env.VERIFY_TOKEN
});

bot.on('error', (err) => {
  console.log(err.message)
})

bot.on('message', (payload, reply) => {
  let text = payload.message.text

  console.log(JSON.stringify(payload))

  bot.getProfile(payload.sender.id, (err, profile) => {
    if (err) throw err

    let message;

    // create consultation and get first question
    request.post('http://localhost:5001/answers', {
      json: true,
      body: { facebook_id: payload.sender.id, value: payload.message.text }
    }, (error, res, body) => {
      if (error) {
        console.log(error);
      }

      console.log(JSON.stringify(body));

      message = {
        text: body.text
      }
      console.log('sending message: ' + JSON.stringify(message))
      if (body.sequence_number == 1) {
        reply({
          text: `Hello, ${profile.first_name}, I’m DocBot. Let’s find you a doctor!`,
        }, () => {
          reply(message);
        });
      } else {
        reply(message, (err) => {
          if (err) {
            console.log(err);
            // throw err;
          }
        })
      }
    });

    // if (payload.message.attachments) {
    //   let location = payload.message.attachments[0].payload;
    //   console.log(location);
    //   message = {
    //     text: 'Do you care about question 1?',
    //     quick_replies: [
    //       {
    //         content_type: "text",
    //         title: 'Yes',
    //         payload: JSON.stringify({
    //           question_id: 1,
    //           answer: true
    //         })
    //       },
    //       {
    //         content_type: "text",
    //         title: 'No',
    //         payload: JSON.stringify({
    //           question_id: 1,
    //           answer: false
    //         })
    //       }
    //     ]
    //   }
    // }


  })
})

http.createServer(bot.middleware()).listen(5000)
