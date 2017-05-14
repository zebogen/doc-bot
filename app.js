'use strict'
const http = require('http')
const Bot = require('messenger-bot')

let bot = new Bot({
  token: 'EAAAAAJADyRMBABHZAcunPJPJK3TFJu0vAbyu2oqkwh9kgIy09lJevkRu713lCo9dQpQ7MwAtupc4b5PfnmezNeoJcPS4hv7fcMZAYQtxiyOSsk64Sm1W1UieXAZBWGPEgSv0OozAPsdBZA62aTu4hmLwnfPE4sMdfPCZCYh3ZAZBgZDZD',
  verify: "VERIFY_TOKEN"
});

bot.on('error', (err) => {
  console.log(err.message)
})

bot.on('message', (payload, reply) => {
  console.log(`message received: ${payload}`)
  let text = payload.message.text



// bot.on('message',(payload,reply) => {
//   console.log('messge received: $ {payload}')
//   lat = event.message.attachments[0].payload.coordinates.lat
//   lng = event.message.attachments[0].payload.coordinates.long
// )
// })
  bot.getProfile(payload.sender.id, (err, profile) => {
    if (err) throw err

    reply({ text }, (err) => {
      if (err) throw err

      console.log(`Echoed back to ${profile.first_name} ${profile.last_name}: ${text}`)
    })
  })
})

http.createServer(bot.middleware()).listen(5000)
