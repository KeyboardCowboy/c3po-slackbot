# Description:
#   Converts between Celsius and Fahrenheit.
#
# Listens for:
#   int [F|C]
#   int[F|C]
#
# Author:
#    KeyboardCowboy <chris@lullabot.com>
#
convert = require('convert-units')

response = [
  '%1 converts to %2',
  '%1 is the same as %2',
  '%1 equals %2',
  '%1 is equal to %2',
  '%1 is equivalent to %2',
  '%1 could be written as %2',
  '%1 is %2',
  '%1 == %2',
  '%1 or %2. Choose wisely, master %3',
  'I say %1, R2 says %2',
  "%3, are you quite sure you didn't mean %2?"
]

# Parse messages to print to slack.
parse_response = (slack, value1, unit1, value2, unit2) ->
  res = slack.random response
  res = res.replace '%1', value1 + unit1
  res = res.replace '%2', value2 + unit2
  res = res.replace '%3', slack.message.user.name
  res

module.exports = (robot) ->
  # Convert Fahrenheit.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(f)([\ \.\,\?]|$)/i, (msg) ->
    value = msg.match[1]
    converted_value = convert(value).from('F').to('C').toFixed(1);
    msg.send parse_response msg, value, '°F', converted_value, '°C'

  # Convert Celsius.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(c)([\ \.\,\?]|$)/i, (msg) ->
    value = msg.match[1]
    converted_value = convert(value).from('C').to('F').toFixed(1);
    msg.send parse_response msg, value, '°C', converted_value, '°F'

  # Convert miles.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(mile(s)?|mi)([\ \.\,\?]|$)/i, (msg) ->
    value = msg.match[1]
    converted_value = convert(value).from('mi').to('km').toFixed(2);
    msg.send parse_response msg, value, ' miles', converted_value, ' kilometers'

  # Convert kilometers.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(kilometer(s)?|km)([\ \.\,\?]|$)/i, (msg) ->
    value = msg.match[1]
    converted_value = convert(value).from('km').to('mi').toFixed(2);
    msg.send parse_response msg, value, ' kilometers', converted_value, ' miles'

  # Conversion on demand.
  robot.respond /convert (-?\d+(\.\d+)?)(\s+)?([a-z0-9\-]{1,5}) to ([a-z0-9\-]{1,5})/i, (msg) ->
    value = msg.match[1]
    unit1 = msg.match[4]
    unit2 = msg.match[5]

    try
      converted_value = convert(value).from(unit1).to(unit2).toFixed(2);
      msg.send parse_response msg, value, ' ' + unit1, converted_value, ' ' + unit2
    catch
      response = "Oh dear.  I don't seem to recognize that conversion.  Did you supply the proper units?\n"
      response += "Try one of these: " + convert().possibilities()
      msg.send(response)
