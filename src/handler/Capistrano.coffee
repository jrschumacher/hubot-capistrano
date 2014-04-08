spawn   = require('child_process').spawn
carrier = require 'carrier'

class Capistrano
  execute: (project, command, msg) ->
    console.log "Running `cap -f #{process.env.HUBOT_CAP_DIR}/#{project}/Capfile #{command}"
    cap = spawn 'cap', ['-f', "#{process.env.HUBOT_CAP_DIR}/#{project}/Capfile", command]
    @streamResult cap, msg

  streamResult: (cap, msg) ->
    capOut = carrier.carry cap.stdout
    capErr = carrier.carry cap.stderr

    capOut.on 'line', (line) ->
      msg.send "capOut > #{line}"

    capErr.on 'line', (line) ->
      msg.send "capErr> #{line}"

module.exports = Capistrano
