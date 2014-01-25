Hubot Hipchat Emoticons
=======================

Allow your Hubot instance to query Hipchat and list all the emoticons for you.

Uses the new [v2 API](https://www.hipchat.com/docs/apiv2)
[get_all_emoticons](https://www.hipchat.com/docs/apiv2/method/get_all_emoticons) method on
your account.

[![NPM](https://nodei.co/npm/hubot-hipchat-emoticons.png)](https://nodei.co/npm/hubot-hipchat-emoticons/)


Commands
--------

List all the emoticons:
```
hubot emoticons?
-> (allthethings) (android) ...
hubot what emoticons?
-> (allthethings) (android) ...
```

List all the group emoticons:
```
hubot group emoticons?
-> (custom) ...
hubot what group emoticons?
-> (custom) ...
```

Give me a random emoticon:
```
hubot emoticon me
-> (dealwithit)
hubot random emoticon
-> (sadpanda)
```

Give me a random group emoticon:
```
hubot group emoticon me
-> (custom)
hubot random group emoticon
-> (custom)
```

Give me all the emoticons that match `<query>`:
```
hubot emoticon me dude
-> (yougotitdude)
hubot emoticon me awesome
-> (failed) No results found.
```

Give me all the group emoticons that match `<query>`:
```
hubot group emoticon me cust
-> (custom)
hubot group emoticon me awesome
-> (failed) No results found.

In addition, you can get back unformatted results by prepending any query with `raw`. For example:
```
hubot raw emoticons?
-> allthethings android ...
hubot raw emoticon me
-> dealwithit
hubot raw emoticon me dude
-> yougotitdude
```
```

Installation
------------

Add the dependency to your hubot `package.json` dependencies:

```json
, "hubot-hipchat-emoticons":  ">=1.2.0"
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

Authors
---------

See [contributors][contributors] on GitHub.


License
-------

MIT


[contributors]: https://github.com/streeter/hubot-hipchat-emoticons/graphs/contributors
