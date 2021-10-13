# ZETTA64 - DISCORD LOGGER
## LOG EVERYTHING!
---

Script made for FiveM. It uses Discord WebHooks to log events in the form of embeds.

---

# How to install:

1. Download by clicking on "code" > "download zip".
2. Extract in your resources folder.
3. Add `ensure zetta64_discordlogs` to your server.cfg

# Configuration:
In the **config.lua** file of the resource you can customize certain options:
- `Config.whlink`: default WebHook link. (Value: `Discord WebHook URL`).
- `Config.loginLog`: whether to log when players join and leave or not (Value: `true, false`).
- `Config.loginLogLink`: WebHook link where logins and leaves are logged. (Value: `Discord WebHook URL`). Only applies when `Config.loginLog = true`.
- `Config.whName`: Name of the WebHook to display in Discord. (Value: `Text String`).
- `Config.whLogo`: Avatar of the WebHook to display in Discord. (Value: `Image URL`).

# Configure a new event:

In order to log more than players joining and leaving, you will need a little bit of knowledge about `.lua` strings and concats, as well as variables and events.

## How to do it?

You will need to add this lines wherever you want to trigger a message.

```lua
 local whData = {
 link = 'https://discord.com/api/webhooks/*********',
 title = " This is a title ",
 color = 16774656,
 message = 'This is test message'
 }
 TriggerEvent('z64_logs:sendWebhook', whData)
```

- `link`: The URL of the webhook i want to send the message. If not present, message will be sent to `Config.whlink` by default. (`Discord WebHook URL`)
- `title`: The title of the embed message (`Text string`).
- `color`: The color of the embed message line. (`Decimal Value`). I recommend using [spycolor.com](https://spycolor.com/).
- `message`: The message to be sent.

Result:

![example1](https://carlos55ml.is-horny.wtf/u2qrLseA5m.png)

## Using variables and concatenating:

For example, i'm using `d3x_vehicleshop` script. And i want to log every vehicle is buyed by a player. I find the event where the vehicle is being saved as a personal vehicle and i add this:

```lua
 local whData = {
 link = 'https://discord.com/api/webhooks/*********'
 title = "CAR BUYED",
 color = 62207,
 message =
 '**[User]: **'..plyName..'\n'..
 '**[ID]: **'..xPlayer.identifier..'\n'..
 '**[Model]: **'..model..'\n'..
 '**[Plate]: **'..vehicleProps.plate..'\n'
 }
 TriggerEvent('z64_logs:sendWebhook', whData)
```

Which leads to this result:

![example2](https://carlos55ml.is-horny.wtf/Mq3249nINX.png)

### HOW?

If you know how to format Discord embeded messages you are halfway done.

Let's see the message in one line:

```lua
'**[User]: **'..plyName..'\n'..'**[ID]: **'..xPlayer.identifier..'\n'..'**[Model]: **'..model..'\n'..'**[Plate]: **'..vehicleProps.plate..'\n' 
```

We start with `**[User]: **`, which is bold because it is inside asteriscs `**`. This is because formatting a message in Discord uses [markdown](https://www.markdownguide.org/cheat-sheet/)

Then we used two dots `..` to add something that is not  text to the message, it is a variable.
- `plyName` is defined earlier, which saves the Player Name, in my case, "carlos55ml".

Two dots `..` again to add some text to the string.
- `\n` adds a line break in Discord, which forces to write the next character in the next line.

And then repeat all the proccess again to obtain the desired message.

As said before, to get this type of messages, a little bit of knowledge about `.lua` is required.

# FAQ

- **What can i log?:** Everything! Just find the event for it and add this:
```lua
 local whData = {
 title = " Your Title ",
 color = 16774656,
 message = 'Your message.'
 }
 TriggerEvent('z64_logs:sendWebhook', whData)
```

- **Does it have any default logs?:** Yes. It can log players joins and leave if you want so.
- **Can I modify the format of the embed?:** Sure! if you feel confident about it just go to the file `z64_dl_server_main.lua` and play around!
- **How can I create a new WebHook in my Discord Server?:** Check this [Official Discord Guide](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks). Also check this one! [Birdie0's Guide](https://birdie0.github.io/discord-webhooks-guide/discord_webhook.html).
- **What do I need in order to create a WebHook?:** You need the right permissions in your Discord Server. ![manageWebhooksPermission](https://carlos55ml.is-horny.wtf/uTQWyNnLOe.png)
- **Is this updated?:** Yes!
- **Does it need any other script?:** No. This script has no dependencies.