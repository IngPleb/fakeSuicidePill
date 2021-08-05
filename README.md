# SUICIDE & FAKE PILL

This resource adds a fake pill that can allow you to fake your death for a certain ammount of time or you can configure the resource to the point where players can choose when to wake up!  
And adds a normal suicide pill too!

This is rework of oblivionPill from Dix // Jérémy  https://github.com/xDixUnderscore/dix-oblivionpill
I just wanted to add features that I think were missing and fix a bug  
Please contribute on github :)

This is my first time publishing a resource.

If there are any issues open an issue on github or contact me directly trough discord Mr. PLEB#0001  

**Features**
* Suicide pill with animations (You can configure how many seconds before the pill kills you and If you want the animation)
* Fake suicide pill with animations and gta death effects (You can configure how manny seconds befote the pill takes effect, What type of fake suicide it will be duration -> player needs to wait certain ammount of time before waking up | control -> player can chose when to wake up, you can disable animations)

**Preview**  
https://streamable.com/u4ue3t  
*Fake suicide pill with timer - you can configure if the timer is shown or how many seconds does it take to wake up + or you can change to "control" mode where player needs to press certain key to wake up*

https://streamable.com/pa4y99  
*Suicide pill - kills you*  

**Everthing you need to configure is in config.lua**

**Dependencies**
* ESX (es_extended)
* If you want the revive command to work -> esx_ambulancejob

**Installation**

1. Download resource from releases
2. Import SQL file of your choosing
3. Put the resource into resources/
4. And add this to your server.cfg -> `ensure fakeSuicidePill`
5. Restart your server
6. Give yourself the pills (`/giveitem <id> suicidePill 1`   |    `/giveitem <id> fakeSuicidePill 1`)
