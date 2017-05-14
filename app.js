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

    let message = {};

    request.post('http://localhost:5001/answers', {
      json: true,
      body: { facebook_id: payload.sender.id, value: payload.message.text }
    }, (error, res, body) => {
      if (error) {
        console.log(error);
      }

      console.log(JSON.stringify(body));

      if (body.status === 422) {
        message.text = "I'm sorry, I don't recognize that complaint. I only work with knee, hip, and back problems.";
      } else {
        message.text = body.text;
      }

      if (body.slug === 'location') {
        message.quick_replies = [
          { content_type: 'location' }
        ]
      }

      if (body.answer_type === 'boolean') {
        message.quick_replies = [
          {
            content_type: 'text',
            title: 'Yes',
            payload: 'true'
          },
          {
            content_type: 'text',
            title: 'No',
            payload: 'false'
          }
        ]
      }

      const doctors = body.recommendations;
      if (doctors) {
        message.text = doctors.reduce((text, doc) => {
          return `${text}${doc.first_name} ${doc.last_name}.\n${doc.distance.toFixed(2)} miles away\n`
        }, `These ${doctors.length} providers are in your network and perform procedures related to your issue:\n`)
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
  })
})

http.createServer(bot.middleware()).listen(5000)
