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

module.exports = (robot) ->
  # Convert Fahrenheit.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(f)([\ \.\,\?]|$)/i, (msg) ->
    unit = msg.match[1]
    converted_unit = Math.round((unit - 32) * (5/9))

    response = unit + "°F converts to " + converted_unit + "°C"
    msg.send(response)

  # Convert Celsius.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(c)([\ \.\,\?]|$)/i, (msg) ->
    unit = msg.match[1]
    converted_unit = Math.round((unit * (9/5)) + 32)

    response = unit + "°C converts to " + converted_unit + "°F"
    msg.send(response)

  # Convert miles.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(mile(s)?|mi)([\ \.\,\?]|$)/i, (msg) ->
    unit = msg.match[1]
    converted_unit = (unit * 1.61).toFixed(2)

    response = unit + " miles converts to " + converted_unit + " kilometers."
    msg.send(response)

  # Convert kilometers.
  robot.hear /(-?\d+(\.\d+)?)(\s+)?(kilometer(s)?|km)([\ \.\,\?]|$)/i, (msg) ->
    unit = msg.match[1]
    converted_unit = (unit * 0.62).toFixed(2)

    response = unit + " kilometers converts to " + converted_unit + " miles."
    msg.send(response)
