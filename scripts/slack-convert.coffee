# Description:
#   Converts between Celsius and Fahrenheit.
#
# Listens for:
#   int [F|C]
#   int[F|C]
#
# Author:
#    KeyboardCowboy
#
module.exports = (robot) ->
  robot.hear /(\-?\d*)\ ?(f|c)([\ \.\,\?])/i, (msg) ->
    unit = msg.match[1]
    scale = msg.match[2]

    if (unit != '' && !isNaN(unit))
      # Fahrenheit to Celsius.
      if (scale == 'F' || scale == 'f')
        converted_unit = Math.round((parseInt(unit) - 32) * (5/9))
        converted_scale = 'C'
      # Celsius to Fahrenheit.
      else
        converted_unit = Math.round(unit * (9/5) + 32)
        converted_scale = 'F'


      response = unit + "°" + scale + " is " + converted_unit + "°" + converted_scale

      msg.send(response)
