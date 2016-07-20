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

module.exports = (robot) ->
  # Convert Fahrenheit.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(f)([\ \.\,\?]|$)/i, (msg) ->
    unit = msg.match[1]
    converted_unit = convert(unit).from('F').to('C').toFixed(1);

    response = unit + "°F converts to " + converted_unit + "°C"
    msg.send(response)

  # Convert Celsius.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(c)([\ \.\,\?]|$)/i, (msg) ->
    unit = msg.match[1]
    converted_unit = convert(unit).from('C').to('F').toFixed(1);

    response = unit + "°C converts to " + converted_unit + "°F"
    msg.send(response)

  # Convert miles.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(mile(s)?|mi)([\ \.\,\?]|$)/i, (msg) ->
    unit = msg.match[1]
    converted_unit = convert(unit).from('mi').to('km').toFixed(2);

    response = unit + " miles converts to " + converted_unit + " kilometers."
    msg.send(response)

  # Convert kilometers.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(kilometer(s)?|km)([\ \.\,\?]|$)/i, (msg) ->
    unit = msg.match[1]
    converted_unit = convert(unit).from('km').to('mi').toFixed(2);

    response = unit + " kilometers converts to " + converted_unit + " miles."
    msg.send(response)

  # Conversion on demand.
  robot.respond /convert (-?\d+(\.\d+)?)(\s+)?([a-z0-9\-]{1,5}) to ([a-z0-9\-]{1,5})/i, (msg) ->
    value = msg.match[1]
    unit1 = msg.match[4]
    unit2 = msg.match[5]

    try
      converted_value = convert(value).from(unit1).to(unit2).toFixed(2);
      response = value + unit1 + " converts to " + converted_value + unit2;
    catch
      response = "Oh dear.  I don't seem to recognize that conversion. Did you supply the proper units?\n"
      response += "Try one of these: " + convert().possibilities()

    msg.send(response)
