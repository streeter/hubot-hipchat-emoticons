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
#   hubot what emoticons?
#   hubot emoticon me
#   hubot random emoticon
#   hubot emoticon me <query>
#
# Author:
#   Chris Streeter (streeter)
#

auth_token = process.env.HUBOT_HIPCHAT_AUTH_TOKEN


fetchEmoticons = (robot, msg, type, cb, results, url) ->

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


allEmoticons = (robot, msg, type) ->
  # Fetch and print all the emoticons
  fetchEmoticons robot, msg, type, (results) ->
    results = results.join ") ("
    msg.send("(#{results})")

randomEmoticon = (robot, msg, type) ->
  fetchEmoticons robot, msg, type, (results) ->
    # Pick a random result
    single = msg.random results
    msg.send("(#{single})")

searchEmoticons = (robot, msg, type, query) ->
  # Fetch and print all the emoticons that match query
  fetchEmoticons robot, msg, type, (results) ->
    # Filter all the results that match query
    query = query.toLowerCase()
    re = new RegExp query
    filtered = (x for x in results when re.test x)
    if filtered and filtered.length
      combined = filtered.join ") ("
      msg.send "(#{combined})"
    else
      msg.send "(failed) No results found."

module.exports = (robot) ->
  robot.respond /(what )?(global |group )?emoticons\??/i, (msg) ->
    allEmoticons robot, msg, msg.match[2]

  robot.respond /random (global |group )?emoticon$/i, (msg) ->
    randomEmoticon robot, msg, msg.match[1]

  robot.respond /(global |group )?emoticon me$/i, (msg) ->
    randomEmoticon robot, msg, msg.match[1]

  robot.respond /(global |group )?emoticon me (.*)$/i, (msg) ->
    query = msg.match[2]
    searchEmoticons robot, msg, msg.match[1], query

