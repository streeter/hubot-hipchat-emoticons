Hubot Hipchat Emoticons
=======================

Allow your Hubot instance to query Hipchat and list all the emoticons for you.

Uses the new [v2 API](https://www.hipchat.com/docs/apiv2)
[get_all_emoticons](https://www.hipchat.com/docs/apiv2/method/get_all_emoticons) method on
your account.


Commands
--------

List all the emoticons:
```
hubot emoticons?
-> (allthethings) (android) ...
```

Give me a random emoticon:
```
hubot emoticon me
-> (dealwithit)
```

Give me all the emiticons that match `<query>`:
```
hubot emoticon me dude
-> (yougotitdude)
```


Installation
------------

Add the dependency to your hubot `package.json` dependencies:

```json
, "hubot-hipchat-emoticons":  ">=1.0.1"
```

Then, edit the `external-scripts.json` file and add this line:

```json
, "hubot-hipchat-emoticons"
```

Now re-deploy your Hubot with the [configuration](#configuration) and it should now be able to query your Hipchat emoticons.


Configuration
-------------

You'll need to have an [auth token](https://hipchat.com/account/api) created. Then set the
environment variable `HUBOT_HIPCHAT_AUTH_TOKEN` to that auth token.


License
-------

MIT

