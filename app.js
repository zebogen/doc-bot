'use strict'
const http = require('http')
const Bot = require('messenger-bot')

let bot = new Bot({
  token: process.env.PAGE_TOKEN,
  verify: process.env.VERIFY_TOKEN
});

bot.on('error', (err) => {
  console.log(err.message)
})

bot.on('message', (payload, reply) => {
  console.log(`message received: ${payload}`)
  let text = payload.message.text

  bot.getProfile(payload.sender.id, (err, profile) => {
    if (err) throw err

    reply({ text }, (err) => {
      if (err) throw err

      console.log(`Echoed back to ${profile.first_name} ${profile.last_name}: ${text}`)
    })
  })
})

http.createServer(bot.middleware()).listen(5000)
