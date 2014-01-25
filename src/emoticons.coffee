# Description:
#   Return all the emoticons accessible on your Hipchat account.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_HIPCHAT_AUTH_TOKEN
#
#   Get your Hipchat token at https://hipchat.com/account/api
#
# Commands:
#   hubot emoticons?
#   hubot raw emoticons?
#   hubot group emoticons?
#   hubot what emoticons?
#   hubot emoticon me
#   hubot raw emoticon me
#   hubot group emoticon me
#   hubot emoticon me <query>
#   hubot raw emoticon me <query>
#   hubot group emoticon me <query>
#
# Author:
#   Chris Streeter (streeter)
#

auth_token = process.env.HUBOT_HIPCHAT_AUTH_TOKEN


fetchEmoticons = (robot, msg, type, cb, results, url) ->
  # Fetch emoticons from the Hipchat API
  url ?= "https://api.hipchat.com/v2/emoticon"
  robot.http(url)
    .query({auth_token: "#{auth_token}", type: (type ? 'all').trim()})
    .get() (err, res, body) ->
      if err
        msg.send "Got an error fetching the emoticons from Hipchat: #{err}"
        return

      results ?= []
      result = JSON.parse body
      if result? and result.items?.length
        for r in result.items
          results.push r.shortcut
        next = result.links.next
        if next
          fetchEmoticons robot, msg, type, cb, results, next
          return
      cb results


allEmoticons = (robot, msg, type, raw) ->
  # Fetch and print all the emoticons
  fetchEmoticons robot, msg, type, (results) ->
    results = results.join(if raw? then " " else ") (")
    if not raw?
      results = "(#{results})"
    msg.send results


randomEmoticon = (robot, msg, type, raw) ->
  fetchEmoticons robot, msg, type, (results) ->
    # Pick a random result
    single = msg.random results
    msg.send(if raw? then single else "(#{single})")


searchEmoticons = (robot, msg, type, query, raw) ->
  # Fetch and print all the emoticons that match query
  fetchEmoticons robot, msg, type, (results) ->
    # Filter all the results that match query
    query = query.toLowerCase()
    re = new RegExp query
    filtered = (x for x in results when re.test x)
    if filtered and filtered.length
      combined = filtered.join(if raw? then " " else ") (")
      msg.send(if raw? then combined else "(#{combined})")
    else
      msg.send "(failed) No results found."


module.exports = (robot) ->
  robot.respond /(what )?(global |group )?(raw )?emoticons\??/i, (msg) ->
    allEmoticons robot, msg, msg.match[2], msg.match[3]

  robot.respond /random (global |group )?(raw )?emoticon$/i, (msg) ->
    randomEmoticon robot, msg, msg.match[1], msg.match[2]

  robot.respond /(global |group )?(raw )?emoticon me$/i, (msg) ->
    randomEmoticon robot, msg, msg.match[1], msg.match[2]

  robot.respond /(global |group )?(raw )?emoticon me (.*)$/i, (msg) ->
    query = msg.match[3]
    searchEmoticons robot, msg, msg.match[1], query, msg.match[2]

