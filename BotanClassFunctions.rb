def help_text(event,bot,command=nil,subcommand=nil)
  command='' if command.nil?
  subcommand='' if subcommand.nil?
  k=0
  k=event.server.id unless event.server.nil?
  if ['help','commands','command_list','commandlist'].include?(command.downcase)
    event.respond "The `#{command.downcase}` command displays this message:"
    command=''
  end
  if command.downcase=='reboot'
    create_embed(event,'**reboot**',"Reboots this shard of the bot, installing any updates.\n\n**This command is only able to be used by Rot8er_ConeX**",0x008b8b)
  elsif command.downcase=='prefix'
    create_embed(event,'**prefix** __new prefix__',"Sets the server's custom prefix to `prefix`.\n\n**This command can only be used by server mods.**",0xC31C19)
  elsif ['reload'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Reloads specified data.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['update'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**",'Shows my data input person how to remotely update for during the period where my developer is gone.',0xED619A)
  elsif ['exp','level','xp'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get from level `start` to level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from level 1 to specified level, and EXP to get from specified level to max level.\nIf no level is listed, will show EXP required to get from level 1 to max level.\n\nIn PM, shows everything unless you specify a particular type of EXP.\nOtherwise, only works if you specify a particular type of EXP:\n- Player\n- Adventurer\n- Dragon\n- Dragon Bond\n- Wyrmprint\n- Weapon",0xCE456B)
  elsif ['plxp','plexp','pllevel','plevel','pxp','pexp'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get a player from level `start` to level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from level 1 to specified level, and EXP to get from specified level to max level.\nIf no level is listed, will show EXP required to get from level 1 to max level.",0xCE456B)
  elsif ['advxp','advexp','advlevel','alevel','axp','aexp'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get an adventurer from level `start` to level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from level 1 to specified level, and EXP to get from specified level to max level.\nIf no level is listed, will show EXP required to get from level 1 to max level.",0xCE456B)
  elsif ['drgxp','drgexp','drglevel','dlevel','dxp','dexp'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get a dragon from level `start` to level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from level 1 to specified level, and EXP to get from specified level to max level.\nIf no level is listed, will show EXP required to get from level 1 to max level.",0xCE456B)
  elsif ['bxp','bexp','blevel','dbxp','dbexp','dblevel','bondlevel','bondxp','bondexp'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get a dragon from bond level `start` to bond level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from bond level 1 to specified bond level, and EXP to get from specified bond level to max bond level.\nIf no level is listed, will show EXP required to get from level 1 to max level.",0xCE456B)
  elsif ['wrxp','wrexp','wrlevel','wyrmxp','wyrmexp','wyrmlevel'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get a wyrmprint from level `start` to level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from level 1 to specified level, and EXP to get from specified level to max level.\nIf no level is listed, will show EXP required to get from level 1 to max level.",0xCE456B)
  elsif ['wpxp','wpexp','wplevel','weaponxp','weaponexp','weaponlevel'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Shows how much EXP to get a weapon from level `start` to level `end`.\nIf the levels are in the wrong order, will auto-switch them.\n\nIf only one level is listed, will show *both* EXP to get from level 1 to specified level, and EXP to get from specified level to max level.\nIf no level is listed, will show EXP required to get from level 1 to max level.",0xCE456B)
  elsif ['wxp','wexp','wlevel'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __start__ __end__","Acts simultaneously as the `wyrmprintexp` and `weaponexp`.",0xCE456B)
  elsif ['sp'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __type__","Shows SP gains for adventurers with the weapon type `type`.\nIf an adventurer's or dragon's name is listed, shows their SP gains.\nIf a weapon's name is listed, shows SP gains for that weapon's type.\nIf no type, adventurer, dragon, or weapon is specified, and in PM, shows the entire SP gains table.",0xCE456B)
  elsif ['dmg','damage','combo'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __type__","Shows damage modifiers for adventurers with the weapon type `type`.\nIf an adventurer's name is listed, shows their damage modifiers.\nIf a weapon's name is listed, shows damage modifiers for that weapon's type.\nIf no type, adventurer, or weapon is specified, and in PM, shows the entire damage modifiers table.",0xCE456B)
  elsif ['donation','donate'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**",'Responds with information regarding potential donations to my developer.',0xCE456B)
  elsif command.downcase=='sendmessage'
    create_embed(event,'**sendmessage** __channel id__ __*message__',"Sends the message `message` to the channel with id `channel`\n\n**This command is only able to be used by Rot8er_ConeX**, and only in PM.",0x008b8b)
  elsif command.downcase=='sendpm'
    create_embed(event,'**sendpm** __user id__ __*message__',"Sends the message `message` to the user with id `user`\n\n**This command is only able to be used by Rot8er_ConeX**, and only in PM.",0x008b8b)
  elsif command.downcase=='ignoreuser'
    create_embed(event,'**ignoreuser** __user id__',"Causes me to ignore the user with id `user`\n\n**This command is only able to be used by Rot8er_ConeX**, and only in PM.",0x008b8b)
  elsif command.downcase=='leaveserver'
    create_embed(event,'**leaveserver** __server id number__',"Forces me to leave the server with the id `server id`.\n\n**This command is only able to be used by Rot8er_ConeX**, and only in PM.",0x008b8b)
  elsif ['banner','banners'].include?(command.downcase)
    create_embed(event,"**#{command}** \\*args","If an adventurer's, dragon's, or wyrmprint's name is included, shows all banners that they have been on.\nIn PM, also shows all other entities that were rate-up on those banners.\n\nIf a banner's name is specified, shows all rate-ups on that banner, and any associated event's facilities.\n\nIf neither of the above is true, shows rate-ups and event facilities associated with the current banner.",0xCE456B)
  elsif ['shard','attribute'].include?(command.downcase)
    create_embed(event,'**shard**','Returns the shard that this server is served by.',0xCE456B)
  elsif ['bugreport','suggestion','feedback'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __*message__",'PMs my developer with your username, the server, and the contents of the message `message`',0xCE456B)
  elsif command.downcase=='addalias'
    create_embed(event,'**addalias** __new alias__ __name__',"Adds `new alias` to `name`'s aliases.\nIf the arguments are listed in the opposite order, the command will auto-switch them.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n~~- Facilities\n- Materials~~\n\nInforms you if the alias already belongs to someone/something.\nAlso informs you if the thing you wish to give the alias to does not exist.\n\n**This command is only able to be used by server mods**.",0xC31C19)
  elsif ['alts','alt'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__",'Responds with a list of alts that the character has in *Dragalia Lost*.',0xCE456B)
  elsif ['deletealias','removealias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __alias__","Removes `alias` from the list of aliases, regardless of who/what it was for.\n\n**This command is only able to be used by server mods**.",0xC31C19)
  elsif ['backupaliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Backs up the alias list.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['restorealiases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Restores the the alias, from last backup.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['safe','spam','safetospam','safe2spam','long','longreplies'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __toggle__","Responds with whether or not the channel the command is invoked in is one in which I can send extremely long replies.\n\nIf the channel does not fill one of the many molds for acceptable channels, server mods can toggle the ability with the words \"on\", \"semi\", and \"off\".",0xCE456B)
  elsif ['affliction','ailment'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows what the status named `name` does.",0xCE456B)
  elsif ['team','backpack'].include?(command.downcase) || (['synergy','synergize'].include?(command.downcase) && ['adventurer','adventurers','adv','advs','unit','units'].include?(subcommand.downcase))
    create_embed(event,"**#{command.downcase}#{" #{subcommand.downcase}" if ['synergy','synergize'].include?(subcommand.downcase)}** __\*names__","Creates a team out of the adventurers listed in `names`, and then calculates the totals of that team's coabilities and chaincoabilities.",0xCE456B)
  elsif ['prints','weapprints','wepprints','weaponprints','wpnprints','weaprints','weprints','weapprint','wepprint','weaponprint','wpnprint','weaprint','weprint'].include?(command.downcase) || (['synergy','synergize'].include?(command.downcase) && ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(subcommand.downcase))
    create_embed(event,"**#{command.downcase}#{" #{subcommand.downcase}" if ['synergy','synergize'].include?(subcommand.downcase)}** __\*names__","Inserts the wyrmprints found in `names` into slots onto a weapon, and then calculates the totals of the abilities of the prints that stuck.",0xCE456B)
  elsif ['synergy','synergize'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __mode__ __\*names__","If `mode` is \"adventurers\" or any derivative thereof, creates a team out of the adventurers listed in `names`, and then calculates the totals of that team's coabilities and chaincoabilities.\n\nIf `mode` is \"wyrmprints\" or any derivative thereof, inserts the wyrmprints found in `names` into slots onto a weapon, and then calculates the totals of the abilities of the prints that stuck.",0xCE456B)
  elsif ['avvie','avatar'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Shows my current avatar, status, and reason for such.\n\nWhen used by my developer with a message following it, sets my status to that message.",0xCE456B)
  elsif ['status'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows what the status named `name` does.\n\nWhen given invalid inputs, shows my current avatar, status, and reason for such.\nWhen used by my developer with a message following it, sets my status to that message.",0xCE456B)
  elsif ['enemy','boss'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the stats of the enemy named `name`, any skills or abilities they may have, and other bosses from the same event.",0xCE456B)
  elsif ['stats','stat','smol'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","If `name` is an adventurer or a weapon, shows `name`'s stats at all possible rarities.\nIf `name` is a dragon or wyrmprint, shows default data.",0xCE456B)
  elsif ['adventurer','adv','unit'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats, skills, and abilities.\n\nIn PM, shows stats at all possible rarities, as well as skill descriptions.\nOtherwise, shows stats at default rarity, and skill names only.  Other rarities can be specified to be shown instead.",0xCE456B)
  elsif ['dragon','drg'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats, skills, and abilities.",0xCE456B)
  elsif ['wyrmprint','wyrm','print'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats and abilities.",0xCE456B)
  elsif ['weapon','weap','wep','wpn'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats and skills.\n\nAlternatively, you can look a weapon up by the complete list of:\n- Rarity\n- Element\n- Weapon type\n- Upgrade tier\n- Additional modifier (Agito, Chimera, etc.)\nIf looked up in this way, all applicable weapons will be displayed as long as the list is short enough.",0xCE456B)
  elsif ['lineage','craft','crafting'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the weapons that `name` directly promotes from, as well as the materials required to craft this weapon from it.",0xCE456B)
  elsif command.downcase=='invite'
    create_embed(event,'**invite**','PMs the invoker with a link to invite me to their server.',0xCE456B)
  elsif ['skill','skil'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the skill named `name` does.  Also shows all adventurers and dragons that know the skill, and any weapons that have it imbued.\n\nAlternatively, you can look a skill up by listing the name of the adventurer or dragon that knows the skill, or the weapon that has it imbued, and the skill slot that the skill is in.",0xCE456B)
  elsif ['ability','abil'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the ability named `name` does.  Also shows all adventurers and dragons that have the ability, and any wyrmprints that have it imbued.\n\nAlternatively, you can look an ability up by listing the name of the adventurer or dragon that has it, or the wyrmprint that has it imbued, and the ability slot that the ability is in.",0xCE456B)
  elsif ['facility','faculty','fac'].include?(command.downcase)
    create_embed(event,"**#{command.downcase.gsub('faculty','facility')}** __name__","Shows `name`'s size and description.\nIn PM, also shows mats required to promote the facility's level.",0xCE456B)
  elsif ['mat','material','item'].include?(command.downcase)
    create_embed(event,"**#{command.downcase.gsub('faculty','facility')}** __name__","Shows `name`'s in-game description and rarity.\nIn PM, also shows obtainment methods and uses.",0xCE456B)
  elsif ['coability','coabil','coab'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the co-abilities named `name` does.  Also shows all adventurers that have the co-ability.\nIn PM, will also show the chain co-ability named `name`.",0xCE456B)
  elsif ['aura'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the aura named `name` does.  Also shows all dragons that have the aura.",0xCE456B)
  elsif ['chain','cca','cc','chaincoab'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the chain co-ability named `name` does.  Also shows all adventurers that have the chain co-ability.",0xCE456B)
  elsif ['roost'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the current day's Dragon Roost Bond gift, as well as all the dragons that get an extra bond increase from the gift.\n\nYou can include the word \"tomorrow\" to instead show the data for tomorrow.\nYou can also include a day of the week to instead show data on that day of the week.",0xCE456B)
  elsif ['shop','store'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the current day's shop mats.\n\nYou can include the word \"tomorrow\" to instead show the data for tomorrow.\nYou can also include a day of the week to instead show data on that day of the week.",0xCE456B)
  elsif ['ruin','ruins'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the current day's Expert Ruins, what difficulties are available, and what orbs and other mats come out of those.\n\nYou can include the word \"tomorrow\" to instead show the data for tomorrow.\nYou can also include a day of the week to instead show data on that day of the week.",0xCE456B)
  elsif ['reset'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the time until the next High Dragon and Void Treasure Trade resets.\n\nYou can include the word \"tomorrow\" to instead show the data for tomorrow.\nYou can also include a day of the week to instead show data on that day of the week.",0xCE456B)
  elsif ['today','now','daily','dailies','today_in_dl','todayindl'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the current day's Dragon Roost Bond gift, as well as all the dragons that get an extra bond increase from the gift.\nAlso shows the current day's Expert Ruins, what difficulties are available, and what orbs and other mats come out of those.\nAlso shows the current day's shop mats.",0xCE456B)
  elsif ['tomorrow','tomorow','tommorrow','tommorow'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the next day's Dragon Roost Bond gift, as well as all the dragons that get an extra bond increase from the gift.\nAlso shows the next day's Expert Ruins, what difficulties are available, and what orbs and other mats come out of those.\nAlso shows the current day's shop mats.",0xCE456B)
  elsif ['limit','limits','stack','stacks'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Shows the limits for ability stacking of all abilities.",0xCE456B)
  elsif ['next','schedule'].include?(command.downcase)
    t=Time.now
    timeshift=7
    timeshift-=1 unless (t-24*60*60).dst?
    t-=60*60*timeshift
    create_embed(event,"**#{command.downcase}** __type__","Shows the next time in-game daily events of the type `type` will happen.\nIf in PM and `type` is unspecified, shows the entire schedule.\n\n__*Accepted Inputs*__#{"\nRuin(s)" unless t.year>2020 || t.month>6 || t.day>24}\nMat(s)\nShop, Store\nBond(s), Dragon(s)",0xCE456B)
  elsif ['art'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __target__","Shows `target`'s art.  Target can be:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Enemies\n- Stickers\n- NPCs",0xCE456B)
    if safe_to_spam?(event)
      lookout=[]
      if File.exist?("#{$location}devkit/DLSkillSubsets.txt")
        lookout=[]
        File.open("#{$location}devkit/DLSkillSubsets.txt").each_line do |line|
          lookout.push(eval line)
        end
      end
      w=lookout.reject{|q| !q[2].include?('Art')}
      w2=w.reject{|q| q[2]!='Art' && q[2]!='Art/Adventurer'}.map{|q| q[0]}.sort.uniq.join("\n")
      w3=w.reject{|q| q[2]!='Art' && q[2]!='Art/Dragon'}.map{|q| q[0]}.sort.uniq.join("\n")
      w4=w.reject{|q| q[2]!='Art' && q[2]!='Art/NPC'}.map{|q| q[0]}.sort.uniq.join("\n")
      create_embed(event,'Available modifiers','',0x40C0F0,nil,nil,[['Adventurer-exclusive',w2],['Dragon-exclusive',w3],['NPC-exclusive',w4]]) if safe_to_spam?(event)
    end
  elsif ['embed','embeds'].include?(command.downcase)
    event << '**embed**'
    event << ''
    event << 'Toggles whether I post as embeds or plaintext when the invoker triggers a response from me.  By default, I display embeds for everyone.'
    event << 'This command is useful for people who, in an attempt to conserve phone data, disable the automatic loading of images, as this setting also affects their ability to see embeds.'
    unless $embedless.include?(event.user.id) || was_embedless_mentioned?(event)
      event << ''
      event << 'This help window is not in an embed so that people who need this command can see it.'
    end
    return nil
  elsif ['share','shared','skillshare','skilshare'].include?(command.downcase)
    create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Finds all adventurers that fit `filters`, removes any that lack shareable skills, and sorts by their shareable skill(s)' share cost and/or SP when shared.\n\nYou can search by:\n- Element\n- Weapon type\n- Class\n- Availability\n\nIf too many adventurers are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.  I will instead show only the top ten results.",0xCE456B)
  elsif ['seegroups','groups','checkgroups'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**",'Shows all the existing groups, and their members.',0xCE456B)
  elsif ['sort','list'].include?(command.downcase)
    subcommand='' if subcommand.nil?
    if ['adventurer','adventurers','adv','advs','unit','units'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Finds all adventurers that fit `filters`, and sorts by specified stats.\n\nYou can search by:\n- Element\n- Weapon type\n- Class\n- Availability\n\nYou can sort by:\n- HP\n- Strength\n- Defense\n\nYou can adjust the stats being sorted by using the following modifiers:\n- Rarity\n- Absolute max stats (using the word \"max\")\n\nIf too many adventurers are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.  I will instead show only the top ten results.",0xCE456B)
    elsif ['dragon','dragons'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Finds all dragons that fit `filters`, and sorts by specified stats.\n\nYou can search by:\n- Rarity\n- Element\n- Dragon Roost Bond Gift preference\n- Whether or not the dragon turns to face damage sources\n- Whether or not the dragon is a ranged attacker\n- Availability\n\nYou can sort by:\n- HP\n- Strength\n\nIf too many dragons are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.  I will instead show only the top ten results.",0xCE456B)
    elsif ['wyrmprint','wyrm','print'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Finds all wyrmprints that fit `filters`, and sorts by specified stats.\n\nYou can search by:\n- Rarity\n- Amulet type\n- Availability\n\nYou can sort by:\n- HP\n- Strength\n\nIf too many wyrmprints are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Finds all weapons that fit `filters`, and sorts by specified stats..\n\nYou can search by:\n- Rarity\n- Crafting tier\n- Element\n- Weapon type\n- Availability\n\nYou can sort by:\n- HP\n- Strength\n\nYou can sort at the following unbind marks:\n- 0 Unbind\n- Max Unbind\n- (for Void weapons only) Boss that gives needed mats\n\nIf too many weapons are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.  I will instead show only the top ten results.",0xCE456B)
    else
      create_embed(event,"**#{command.downcase}** __\*filters__","Finds all adventurers that fit `filters`, and sorts by specified stats.\n\nYou can search by:\n- Element\n- Weapon type\n- Class\n- Availability\n\nYou can sort by:\n- HP\n- Strength\n- Defense\n\nYou can adjust the stats being sorted by using the following modifiers:\n- Rarity\n- Absolute max stats (using the word \"max\")\n\nIf too many adventurers are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.  I will instead show only the top ten results.",0xCE456B,"Sorting is also available for dragons, wyrmprints, and weapons.")
    end
  elsif ['find','search','lookup'].include?(command.downcase)
    subcommand='' if subcommand.nil?
    if ['adventurer','adventurers','adv','advs','unit','units'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all adventurers that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Weapon type\n- Class\n- Availability\n- Gender\n- Race\n\nIf too many adventurers are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['dragon','dragons','drg','drgs'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all dragons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Dragon Roost Bond Gift preference\n- Whether or not the dragon turns to face damage sources\n- Whether or not the dragon is a ranged attacker\n- Availability\n- Gender\n\nIf too many dragons are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['banner','banners','summon','summoning','summons','summonings'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all banners that fit `filters`.\n\nYou can search by:\n- Element\n- Tags\n\nIf too many banners are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
      lookout=[]
      if File.exist?("#{$location}devkit/DLSkillSubsets.txt")
        lookout=[]
        File.open("#{$location}devkit/DLSkillSubsets.txt").each_line do |line|
          lookout.push(eval line)
        end
      end
      w=lookout.reject{|q| q[2]!='Banner'}.map{|q| q[0]}.sort
      create_embed(event,'Tags','',0x40C0F0,nil,nil,triple_finish(w)) if safe_to_spam?(event)
    elsif ['wyrmprint','wyrm','print'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all wyrmprints that fit `filters`.\n\nYou can search by:\n- Rarity\n- Amulet type\n- Availability\n\nIf too many wyrmprints are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all weapons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Crafting tier\n- Element\n- Weapon type\n- Availability\n- (for Void weapons only) Boss that gives needed mats\n\nIf too many weapons are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['mat','mats','material','materials','item','items'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all materials and items that fit `filters`.\n\nYou can search by:\n- Rarity\n- Pouch Rarity\n- Tags\n\nIf too many materials and items are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
      lookout=[]
      if File.exist?("#{$location}devkit/DLSkillSubsets.txt")
        lookout=[]
        File.open("#{$location}devkit/DLSkillSubsets.txt").each_line do |line|
          lookout.push(eval line)
        end
      end
      w=lookout.reject{|q| q[2]!='Mat'}.map{|q| q[0]}.sort
      create_embed(event,'Tags','',0x40C0F0,nil,nil,triple_finish(w)) if safe_to_spam?(event)
    elsif ['skill','skills','skls','skl','skil','skils'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all skills that fit `filters`.\n\nYou can search by:\n- Element\n- Tags\n\nIf too many skills are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
      lookout=[]
      if File.exist?("#{$location}devkit/DLSkillSubsets.txt")
        lookout=[]
        File.open("#{$location}devkit/DLSkillSubsets.txt").each_line do |line|
          lookout.push(eval line)
        end
      end
    elsif ['abil','abilities','ability','abils','abilitys'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all abilities, dragon auras, co-abilities, and chain co-abilities that fit `filters`.\n\nYou can search by:\n- Ability Class (ability/aura/coability/chain)\n- Element\n- Tags\n\nIf too many abilities are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
      lookout=[]
      if File.exist?("#{$location}devkit/DLSkillSubsets.txt")
        lookout=[]
        File.open("#{$location}devkit/DLSkillSubsets.txt").each_line do |line|
          lookout.push(eval line)
        end
      end
    elsif ['enemies','boss','enemy','bosses','enemie','enemys','bosss'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all enemies that fit `filters`.\n\nYou can search by:\n- Element\n- Tribe\n\nIf too many enemies are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['facility','facilities','facilitys','fac','facs','faculties','faculty','facultys'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all facilities that fit `filters`.\n\nYou can search by:\n- Element\n- Weapon type\n- Facility Type\n\nIf too many facilities are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    else
      create_embed(event,"**#{command.downcase}** __\*filters__","Displays all adventurers, dragons, wyrmprints, and weapons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Weapon type\n- Class / Amulet type\n- Availability\n- Gender (for adventurers and dragons)\n\nIn addition, adventurers can be sorted by:\n- Race\n\nIn addition, dragons can be sorted by:\n- Dragon Roost Bond Gift preference\n- Whether or not the dragon turns to face damage sources\n- Whether or not the dragon is a ranged attacker\n\nIn addition, weapons can be sorted by:\n- Crafting tier\n\nIf too much data is trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    end
    lookout=[]
    if File.exist?("#{$location}devkit/DLSkillSubsets.txt")
      lookout=[]
      File.open("#{$location}devkit/DLSkillSubsets.txt").each_line do |line|
        lookout.push(eval line)
      end
    end
    w=lookout.reject{|q| q[2]!='Askillity'}.map{|q| q[0]}.sort
    create_embed(event,'Tags','',0x40C0F0,nil,nil,triple_finish(w)) if safe_to_spam?(event) && !['banner','banners','summon','summoning','summons','summonings','mat','mats','material','materials','item','items','enemies','boss','enemy','bosses','enemie','enemys','bosss'].include?(subcommand.downcase)
  elsif ['aliases','checkaliases','seealiases','alias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s aliases.\nIf no name is listed, responds with a list of all aliases and who/what they are for.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Chain CoAbilities\n- Facilities\n- Materials\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
  elsif ['saliases','serveraliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s server-specific aliases.\nIf no name is listed, responds with a list of all server-specific aliases and who/what they are for.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Chain CoAbilities\n- Facilities\n- Materials\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
  elsif ['tools','links','resources','tool','link','resource'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Responds with a list of links useful to players of *Dragalia Lost*.",0xCE456B)
  elsif ['mats','materials','nodes','node','spiral'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","If `name` is an adventurer, displays all of the mats required for their mana nodes.\nIf `name` is a weapon, displays all the mats for its various features.\nIf `name` is a rariy + element combo, treats it as an adventurer.",0xCE456B)
  elsif ['affinity','resonance'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Displays the effects of using multiple wyrmprints with the same affinity.",0xCE456B)
  elsif command.downcase=='snagstats'
    subcommand='' if subcommand.nil?
    if ['server','servers','member','members','shard','shards','users','user'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**",'Returns the number of servers and unique members each shard reaches.',0xCE456B)
    elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of adventurers sorted in each of the following ways:\n- Rarity\n- Element\n- Weapon type\n- Class\n- Obtainability (in PM)",0xCE456B)
    elsif ['dragon','dragons','drag','drags','drg','drgs'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of dragons sorted in each of the following ways:\n- Rarity\n- Element\n- Bondfood preference\n- damage reaction\n- Range\n- Obtainability (in PM)",0xCE456B)
    elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of wyrmprints sorted in each of the following ways:\n- Rarity\n- Amulet\n- Obtainability (in PM)",0xCE456B)
    elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of weapons sorted in each of the following ways:\n- Weapon type\n- Rarity\n- Element\n- Obtainability (in PM)",0xCE456B)
    elsif ['alts','alt','alternate','alternates','alternative','alternatives'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**",'Returns the number of adventurers and dragons within each type of alt, as well as specifics about adventurers and dragons with the most alts.',0xCE456B)
    elsif ['alias','aliases','name','names','nickname','nicknames'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of aliases in each of the two categories - global single-servant, and server-specific single-servant.\nAlso returns specifics about the most frequent instances of each category",0xCE456B)
    elsif ['code','lines','line','sloc'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the specifics about my code, including number of commands and functions, as well as - if in PM - loops, statements, and conditionals.",0xCE456B)
    else
      create_embed(event,"**#{command.downcase}**","Returns:\n- the number of servers I'm in\n- the numbers of servants in the game\n- the numbers of aliases I keep track of\n- how long of a file I am.\n\nYou can also include the following words to get more specialized data:\nServer(s), Member(s), Shard(s), User(s)\nAdventurer(s), Unit(s)\nDragon(s)\nWyrmprint(s), Print(s)\nWeapon(s)\nAlt(s)\nAlias(es), Name(s), Nickname(s)\nGroup(s)\nCode, Line(s), SLOC#{"\n\nAs the bot developer, you can also include a server ID number to snag the shard number, owner, and my nickname in the specified server." if event.user.id==167657750971547648}",0xCE456B)
    end
  else
    x=0
    x=1 unless safe_to_spam?(event)
    if command.downcase=='here'
      x=0
      command=''
    end
    event.respond "#{command.downcase} is not a command" if command!='' && command.downcase != 'devcommands'
    str="__**Game Data**__"
    str="#{str}\n`adventurer` __name__ - for data on an adventurer (*also `adv`*)"
    str="#{str}\n`mats` __name__ - for data on an adventurer's mana nodes (*also `nodes`*)"
    str="#{str}\n`dragon` __name__ - for data on a dragon (*also `drg`*)"
    str="#{str}\n`wyrmprint` __name__ - for data on a wyrmprint (*also `wyrm` or `print`*)"
    str="#{str}\n`weapon` __name__ - for data on a weapon (*also `weap` or `wep`*)"
    str="#{str}\n`enemy` __name__ - for data on an enemy (*also `boss`*)"
    str="#{str}\n`status` __name__ - for data on a status ailment"
    str="#{str}\n\n`skill` __name__ - for data on a particular skill"
    str="#{str}\n`ability` __name__ - for data on a particular ability or co-ability"
    str="#{str}\n`limits` - for ability stacking limits (*also `stack`*)"
    str="#{str}\n`affinity` - for abilities gained from wyrmprint affinities"
    str="#{str}\n\n`facility` __name__ - for data on a particular facility"
    str="#{str}\n`material` __name__ - for data on a particular material (*also `mat`*)"
    str="#{str}\n\n`stats` __target__ - for only an entity's stats"
    str="#{str}\n`alts` __target__ - to show all alts of a particular character"
    str="#{str}\n`craft` __name__ - for data on a weapon's crafting materials"
    str="#{str}\n`aliases` __target__ - to show all aliases of a particular entity (*also `checkaliases` or `seealiases`*)"
    str="#{str}\n`serveraliases` __target__- to show all server-specific aliases of a particular entity (*also `saliases`*)"
    str="#{str}\n\n`find` __\*filters__ - to find specific adventurers, dragons, wyrmprints, or weapons (*also `search`*)"
    str="#{str}\n`sort` __\*filters__ - to sort adventurers by specified stats (*also `list`*)"
    str="#{str}\n`today` - to show data on current events (*also `daily` or `todayInDL`*)"
    str="#{str}\n`level` - to show costs of getting certain entities to certain levels."
    str="#{str}\n`next` - to show data on cyclical events (*also `schedule`*)"
    str="#{str}\n`art` __target__ - to show an adventurer's, dragon's, or wyrmprint's art"
    str="#{str}\n`team` __\*names__ - shows collapsed chain/coabilities for teams"
    str="#{str}\n`prints` __\*names__ - shows collapsed abilities for groups of wyrmprints"
    str="#{str}\n`sp` __types__ - shows SP gains for weapon types or adventurers/dragons"
    str="#{str}\n`damage` __types__ - shows damage modifiers for weapon types or adventurers"
    create_embed([event,x],"Global Command Prefixes: `DL!` `DL?`#{"\nServer Command Prefix: `#{@prefixes[event.server.id]}`" if !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0}\nYou can also use `DL!help CommandName` to learn more on a particular command.\n__**Botan Bot help**__",str,0xCE456B)
    str="__**Meta Data**__"
    str="#{str}\n`tools` - for a list of tools other than me that can help you"
    str="#{str}\n`invite` - for a link to invite me to your server"
    str="#{str}\n`snagstats` __type__ - to receive relevant bot stats"
    str="#{str}\n`spam` - to determine if the current location is safe for me to send long replies to (*also `safetospam` or `safe2spam`*)"
    str="#{str}\n`shard`"
    str="#{str}\n`groups`"
    str="#{str}\n\n__**Developer Information**__"
    str="#{str}\n`bugreport` __\\*message__ - to send my developer a bug report"
    str="#{str}\n`suggestion` __\\*message__ - to send my developer a feature suggestion"
    str="#{str}\n`feedback` __\\*message__ - to send my developer other kinds of feedback"
    str="#{str}\n~~the above three commands are actually identical, merely given unique entries to help people find them~~"
    str="#{str}\n`whybotan` - for an explanation as to how Botan was chosen as the face of the bot"
    create_embed([event,x],'',str,0xCE456B)
    str="__**Aliases**__"
    str="#{str}\n`addalias` __new alias__ __target__ - Adds a new server-specific alias"
    str="#{str}\n~~`aliases` __target__ (*also `checkaliases` or `seealiases`*)~~"
    str="#{str}\n~~`serveraliases` __target__ (*also `saliases`*)~~"
    str="#{str}\n`deletealias` __alias__ (*also `removealias`*) - deletes a server-specific alias"
    str="#{str}\n\n__**Channels**__"
    str="#{str}\n`spam` __toggle__ - to allow the current channel to be safe to send long replies to (*also `safetospam` or `safe2spam`*)"
    str="#{str}\n\n__**Customization**__"
    str="#{str}\n`prefix` __chars__ - to create or edit the server's custom command prefix"
    create_embed([event,x],"__**Server Admin Commands**__",str,0xC31C19) if is_mod?(event.user,event.server,event.channel)
    str="__**Mjolnr, the Hammer**__"
    str="#{str}\n`ignoreuser` __user id number__ - makes me ignore a user"
    str="#{str}\n`leaveserver` __server id number__ - makes me leave a server"
    str="#{str}\n\n__**Communication**__"
    str="#{str}\n`status` __\\*message__ - sets my status"
    str="#{str}\n`sendmessage` __channel id__ __\\*message__ - sends a message to a specific channel"
    str="#{str}\n`sendpm` __user id number__ __\\*message__ - sends a PM to a user"
    str="#{str}\n\n__**Server Info**__"
    str="#{str}\n`snagstats` - snags relevant bot stats"
    str="#{str}\n\n__**Shards**__"
    str="#{str}\n`reboot` - reboots this shard"
    str="#{str}\n\n__**Meta Data Storage**__"
    str="#{str}\n`backupaliases` - backs up the alias list"
    str="#{str}\n`restorealiases` - restores the alias list from last backup"
    str="#{str}\n`sortaliases` - sorts the alias list by type of alias"
    create_embed([event,x],"__**Bot Developer Commands**__",str,0x008b8b) if (event.server.nil? || event.channel.id==283821884800499714 || Shardizard==4 || command.downcase=='devcommands') && event.user.id==167657750971547648
    event.respond "If the you see the above message as only three lines long, please use the command `DL!embeds` to see my messages as plaintext instead of embeds.\n\nGlobal Command Prefixes: `DL!` `DL?`#{"\nServer Command Prefix: `#{@prefixes[event.server.id]}`" if !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0}\nYou can also use `DL!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name" unless x==1
    event.user.pm("If the you see the above message as only three lines long, please use the command `DL!embeds` to see my messages as plaintext instead of embeds.\n\nGlobal Command Prefixes: `DL!` `DL?`#{"\nServer Command Prefix: `#{@prefixes[event.server.id]}`" if !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0}\nYou can also use `DL!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name") if x==1
    event.respond "A PM has been sent to you.\nIf you would like to show the help list in this channel, please use the command `DL!help here`." if x==1
  end
end

$max_rarity=[5, 5, 5, 6] # adventurer, dragon, print, weapon
$abilimits=["Affliction Guard \u2192 III (3x)",
            "*Affliction Punisher* \u2192 30%",
            "*Affliction Res* \u2192 100%",
            "Blindness Res \u2192 100%",
            "Bog Res \u2192 100%",
            "Broken Punisher \u2192 30%",
            "Buff Skill Time \u2192 30%",
            "Burn Res \u2192 100%",
            "Burning Punisher \u2192 30%",
            "Crit Damage \u2192 25%",
            "Crit Rate \u2192 15%",
            "Curse Res \u2192 100%",
            "Defense +% \u2192 20%",
            "Dragon Time \u2192 20%",
            "Element Res \u2192 15%",
            "Energy Prep \u2192 V (5)",
            "Event Score \u2192 250%",
            "Facility Material Intake \u2192 125%",
            "Force Strike \u2192 50%",
            "Freeze Res \u2192 100%",
            "Frostbitten Punisher \u2192 30%",
            "Gauge Accelerator \u2192 35%",
            "Healing Doublebuff \u2192 III (3%)",
            "Last Offense \u2192 60%",
            "Paralysis Res \u2192 100%",
            "Player XP \u2192 10%",
            "Poison Punisher \u2192 30%",
            "Poison Res \u2192 100%",
            "Recovery Potency \u2192 20%",
            "Shapeshift \u2192 10%",
            "Shield Prep \u2192 III (30%)",
            "Skill Damage \u2192 40%",
            "Skill Haste \u2192 15%",
            "Skill Prep \u2192 100%",
            "Slayer's Strength \u2192 6%",
            "Sleep Res \u2192 100%",
            "Strength +% \u2192 20%",
            "Striking Haste \u2192 15%",
            "Stun Res \u2192 100%",
            "United Haste \u2192 I (8%)"]
$punishments=[['Paralysis','ParalyzedPunisher'],
              ['Poison','PoisonedPunisher'],
              ['Blind','BlindedPunisher'],
              ['Stun','StunnedPunisher'],
              ['Broken','BrokenPunisher'],
              ['Burn','BurningPunisher'],
              ['Overdrive','OverdrivePunisher'],
              ['Frostbite','FrostbitePunisher'],
              ['Freeze','FrozenPunisher'],
              ['Sleep','SleepingPunisher'],
              ['Bleed','BleedingPunisher'],
              ['Bog','BogPunisher'],
              ['ReducedDefense','ReducedDefensePunisher'],
              ['Zone','ZonePunisher'],
              ['Scorchrend','ScorchrentPunisher']]
$cleaning=[['Paralysis','ParalysisCleanse'],
           ['Poison','PoisonCleanse','Antidote'],
           ['Blind','BlindnessCleanse','Glasses'],
           ['Stun','StunCleanse'],
           ['Bog','BogCleanse'],
           ['Broken','BrokenCleanse','Fixer'],
           ['Burn','BurnCleanse','Water'],
           ['Overdrive','OverdriveCleanse','Underdrive'],
           ['Frostbite','FrostbiteCleanse'],
           ['Freeze','FreezeCleanse','Defrosting'],
           ['Sleep','SleepCleanse','WakeUpSlap'],
           ['Bleed','BleedCleanse','Bandage'],
           ['Curse','CurseCleanse'],
           ['Scorchrend','ScorchrendCleaner']]
$resonance=[['Crown',nil,nil,'Skill Damage +10%'],
            ['Axe',nil,nil,'Broken Punisher +10%'],
            ['Sword',nil,nil,'Strength +8%'],
            ['Bow',nil,'Skill Haste +6%','Skill Haste +10%'],
            ['Lance','Force Strike +5%','Force Strike +8%','Force Strike +15%'],
            ['Dragon','Dragon Damage +10%','Dragon Damage +18%','Dragon Damage +30%'],
            ['Eagle','Burn Res +100%'],
            ['Wolf','Stun Res +100%'],
            ['Bull','Paralysis Res +100%'],
            ['Serpent','Curse Res +100%'],
            ['Staff','Buff Skill Time +5%','Buff Skill Time +8%','Buff Skill Time +15%']]

class DLSentient
  def pronoun(possessive=nil)
    return 'he' if @gender=='M' && possessive==false
    return 'she' if @gender=='F' && possessive==false
    return 'his' if @gender=='M' && possessive==true
    return 'him' if @gender=='M'
    return 'her' if @gender=='F'
    return 'their' if possessive==true
    return 'they' if possessive==false
    return 'them'
  end
end

class DLAdventurer
  def isManakete?
    return true if ['Mega Man','Lathna','Gala Mym','Mym(Halloween)'].include?(@name)
    return true if ['Gala Leonidas','Chelle'].include?(@name)
    return false if ['Reginn','Fafnir(FE)','Otr'].include?(@name)
    m=$dragons.reject{|q| q.name != @name || !q.isPseudodragon?}
    return true if m.length>0
    return false
  end
  
  def rar_row(r=0)
    r=@rarity if r<=@rarity
    return generate_rarity_row(r,$max_rarity[0],@games[0])
  end
  
  def portrait(event,args=nil,forcerar=nil)
    args=event.message.text.downcase.split(' ') if args.nil?
    rar=0
    lookout=$skilltags.reject{|q| q[2]!='Art' && q[2]!='Art/Adventurer'}
    rarval=[]
    for i in 0...$max_rarity[0]+1
      rarval.push(i)
    end
    for i in 0...args.length
      rar=args[i].to_i if rar==0 && args[i].to_i.to_s==args[i] && args[i].to_i>2 && args[i].to_i<$max_rarity[0]+1
      rar=args[i].to_i if rar==0 && args[i][1,1]=='*' && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>2 && args[i][0,1].to_i<$max_rarity[0]+1
      for j in 0...lookout.length
        rar=lookout[j][0] if rarval.include?(rar) && lookout[j][1].include?(args[i].downcase)
      end
    end
    rar=forcerar unless forcerar.nil?
    rar='Dress_Blue' if args.map{|q| q.downcase}.include?('dress') && !rar.is_a?(String)
    if @name=='Xainfried' && rar=='Animal' && has_any?(['christmas','winter','dy','dragonyule','santa'],args.map{|q| q.downcase})
      k=$adventurers.find_index{|q| q.name=='Xainfried(Dragonyule)'}
      unless k.nil?
        k=$adventurers[k].clone
        m=k.portrait(event,'Animal')
        return [m[0],'Animals dressed for Dragonyule']
      end
    end
    rar=@rarity if rar==0
    dispname=@name.gsub(' ','_')
    if rar.is_a?(String)
      m=false
      art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Adventurers/#{dispname}_#{rar}.png"
      IO.copy_stream(open(art), "#{$location}devkit/DLTemp#{Shardizard}.png") rescue m=true
      if File.size("#{$location}devkit/DLTemp#{Shardizard}.png")<=100 || m
        disp="#{self.rar_row}"
      elsif rar=='NPC'
        rar=1
        disp="#{self.rar_row(1)}"
      else
        disp="#{rar.gsub('Dress_Blue','Blue dress').gsub('Dress_Red','Red dress')} design"
      end
    else
      rar=@rarity if rar<@rarity || rar>$max_rarity[0]
      disp="#{self.rar_row(rar)}"
    end
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Adventurers/#{dispname}_#{rar}.png"
    return [art,disp]
  end
  
  def artist; return nil; end
  
  def hasCustomCombo?
    return false if (@sp_override.nil? || @sp_override.length<=0) && (@damage_override.nil? || @damage_override.length<=0)
    if @sp_override.nil? || @sp_override.length<=2
    elsif @sp_override.length==1
      return true unless @sp_override[0].length<=3
    else
      return true
    end
    if @damage_override.nil? || @damage_override.length<=2
    elsif @damage_override.length==1
      return true unless @damage_override[0].length<=3
    else
      return true
    end
    return false
  end
  
  def hasCustomForceStrike?
    return false if (@sp_override.nil? || @sp_override.length<=0) && (@damage_override.nil? || @damage_override.length<=0)
    if @sp_override.nil? || @sp_override.length<=2
    elsif @sp_override.length==1
      return true unless ['Dash','DA'].include?(@sp_override[0][0])
    else
      return true
    end
    if @damage_override.nil? || @damage_override.length<=2
    elsif @damage_override.length==1
      return true unless ['Dash','DA'].include?(@damage_override[0][0])
    else
      return true
    end
    return false
  end
  
  def sp_embed(event,bot)
    if !@sp_override.nil? && @sp_override.length>0
      f=[]
      m=[0,'First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth','Tenth','Eleventh','Twelfth','Thirteenth','Fourteenth','Fifteenth','16th','17th','18th','19th',
         '20th','21st','22nd','23rd','24th','25th','26th','27th','28th','29th','30th','31st','32nd','33rd','34th','35th','36th','37th','38th','39th','40th','41st','42nd','43rd','44th',
         '45th','46th','47th','48th','49th','50th']
      k2=[1,2,3,4,5,6,7]
      k2=[150,150,196,265,391,143,345,1152] if @weapon=='Sword'
      k2=[130,130,220,360,900,104,200,1740] if @weapon=='Blade'
      k2=[144,144,264,288,480,132,288,1128] if @weapon=='Dagger'
      k2=[200,240,360,380,420,160,300,1600] if @weapon=='Axe'
      k2=[120,240,120,480,600,111,400,1560] if @weapon=='Lance'
      k2=[184,92,276,414,529,208,460,1495] if @weapon=='Bow'
      k2=[130,200,240,430,600,156,400,1600] if @weapon=='Wand'
      k2=[232,232,348,464,696,300,580,1972] if @weapon=='Staff'
      k2=[545,545,0,400] if @weapon=='Manacaster' && @weapon2=='Rifle'
      k2=[464,464,0,400] if @weapon=='Manacaster' && @weapon2=='Shotgun'
      k2=[300,464,464,0,400] if @weapon=='Manacaster' && @weapon2=='Machine Gun'
      ff=[]
      t=0
      if @sp_override.length==1
        if ['Dash','DA'].include?(@sp_override[0][0])
          k2[-2]=@sp_override[0][-1]
        else
          k2[-1]=@sp_override[0][-1]
          k2[-2]=@sp_override[0][-2] if @sp_override[0].length>2
        end
        if @sp_override[0].length>3
          for i2 in 1...@sp_override[0].length-2
            ff.push("*#{m[i2]} Hit:* #{@sp_override[0][i2]}")
            if @sp_override[0][i2].to_i.to_s==@sp_override[0][i2] && t>=0
              t+=@sp_override[0][i2].to_i
            else
              t=-1
            end
          end
          if t<0
            ff.push("~~*Total cannot be calculated dynamically*~~")
          else
            ff.push("\u30FC *Total:* #{t}")
          end
          ff.push("\n**Dash Attack:** #{@sp_override[0][-2]}")
          ff.push("**Force Strike:** #{@sp_override[0][-1]}")
          f=nil
          disp=ff.join("\n")
        elsif @weapon=='Manacaster'
          disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}#{"\n*Third Hit:* #{k2[2]}" if k2.length>4 && k2[2]>0}\n\u30FC *Total:* #{k2[0,k2.length-2].inject(0){|sum,x| sum + x }}\n\n**Dash Attack:** #{k2[-2]}\n**Force Strike** #{k2[-1]}"
        else
          disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\u30FC *Total: #{k2[7]}*\n\n**Dash Attack:** #{k2[5]}\n**Force Strike** #{k2[6]}"
        end
      else
        for i2 in 0...k2.length-2
          ff.push("*#{m[i2]} Hit:* #{k2[i2]}")
          if k2[i2].to_i.to_s==k2[i2] && t>=0
            t+=k2[i2].to_i
          else
            t=-1
          end
        end
        if t<0
          ff.push("~~*Total cannot be calculated dynamically*~~")
        else
          ff.push("\u30FC *Total:* #{t}")
        end
        ff.push("\n**Dash Attack:** #{k2[-2]}")
        ff.push("\n**Force Strike:** #{k2[-1]}")
        disp=ff.join("\n")
      end
      if @sp_override.length>1
        for i in 0...@sp_override.length-2
          if @sp_override[i].length>1
            ff=["__**Combo**__"]
            t=0
            for i2 in 1...@sp_override[i].length
              ff.push("*#{m[i2]} Hit:* #{@sp_override[i][i2]}")
              if @sp_override[i][i2].to_i.to_s==@sp_override[i][i2] && t>=0
                t+=@sp_override[i][i2].to_i
              else
                t=-1
              end
            end
            if t<0
              ff.push("~~*Total cannot be calculated dynamically*~~")
            else
              ff.push("\u30FC *Total:* #{t}")
            end
            ff.push("\n**Dash Attack:** #{@sp_override[i][-2]}")
            ff.push("**Force Strike:** #{@sp_override[i][-1]}")
            if @sp_override[i][0][0,1]=='*' && i==0
              disp=ff.join("\n")
              k2[5]=@sp_override[i][-2]
              k2[6]=@sp_override[i][-1]
            else
              f.push([@sp_override[i][0],ff.join("\n")])
            end
          end
        end
      else
        f=nil
      end
      create_embed(event,"__SP gains for **#{@name}#{self.emotes(bot)}**__",disp,self.disp_color,nil,self.thumbnail,f)
      return nil
    elsif @weapon=='Manacaster'
      return @weapon2
    else
      return @weapon
    end
  end
  
  def damage_embed(event,bot)
    if !@damage_override.nil? && @damage_override.length>0
      f=[]
      m=[0,'First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth','Tenth','Eleventh','Twelfth','Thirteenth','Fourteenth','Fifteenth','16th','17th','18th','19th',
         '20th','21st','22nd','23rd','24th','25th','26th','27th','28th','29th','30th','31st','32nd','33rd','34th','35th','36th','37th','38th','39th','40th','41st','42nd','43rd','44th',
         '45th','46th','47th','48th','49th','50th']
      k2=[1,2,3,4,5,6,7]
      k2=[108,115,137,144,'216% x2',95,'104% L1, 115% L2'] if @weapon=='Sword'
      k2=[128,128,'75% x2',155,'172% x2',94,"83% L1, 92% L2"] if @weapon=='Blade'
      k2=[108,'56% x2','78% x2',171,216,85,"43.2% x3 L1, 47% x3 L2"] if @weapon=='Dagger'
      k2=[151,161,270,285,301,73,"173% L1, 192% L2"] if @weapon=='Axe'
      k2=[111,'59% x2',143,198,147,89,"27% x5 L1, 30% x5 L2"] if @weapon=='Lance'
      k2=['44% x3','55% x2','63% x3','95% x2','53% x5','30% x3',"28% x8 L1, 31% x8 L2"] if @weapon=='Bow'
      k2=[136,'74% x2','49% x3','108% x2','85% x1 + 49% x4',100,"81% x2 L1, 90% x2 L2"] if @weapon=='Wand'
      k2=[124,144,'81% x2',270,353,80,"55% x4 L1, 61% x4 L2"] if @weapon=='Staff'
      k2=['67% x5','67% x5',0,180] if @weapon=='Manacaster' && @weapon2=='Rifle'
      k2=['48% x8','48% x8','40% x8','35% x10 + 40%'] if @weapon=='Manacaster' && @weapon2=='Shotgun'
      k2=['45% x3','150% x3','150% x5',0,90] if @weapon=='Manacaster' && @weapon2=='Machine Gun'
      if @damage_override.length==1
        if ['Dash','DA'].include?(@damage_override[0][0])
          k2[5]=@damage_override[0][-1]
        else
          k2[6]=@damage_override[0][-1]
          k2[5]=@damage_override[0][-2] if @damage_override[0].length>2
        end
      end
      for i in 0...k2.length
        k2[i]="#{k2[i]}%" unless k2[i].is_a?(String) && k2[i].to_i.to_s != k2[i]
      end
      if @damage_override.length==1
        if @damage_override[0].length>3
          ff=[]
          for i2 in 1...@damage_override[0].length-2
            ff.push("*#{m[i2]} Hit:* #{@damage_override[0][i2]}#{'%' if @damage_override[0][i2].to_i.to_s==@damage_override[0][i2]}")
          end
          ff.push("\n**Dash Attack:** #{@damage_override[0][-2]}#{'%' if @damage_override[0][-2].to_i.to_s==@damage_override[0][-2]}")
          ff.push("**Force Strike:** #{@damage_override[0][-1]}#{'%' if @damage_override[0][-1].to_i.to_s==@damage_override[0][-1]}")
          disp=ff.join("\n")
        elsif @weapon=='Manacaster'
          disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}#{"\n*Third Hit:* #{k2[2]}" if k2.length>4 && k2[2].to_i>0}\n\n**Dash Attack:** #{k2[-2]}\n**Force Strike:** #{k2[-1]}"
        else
          disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\n**Dash Attack:** #{k2[5]}\n**Force Strike:** #{k2[6]}"
        end
      elsif @weapon=='Manacaster'
        ff=[]
        for i2 in 0...k2.length-2
          ff.push("*#{m[i2+1]} Hit:* #{k2[i2]}#{'%' if k2[i2].to_i.to_s==k2[i2]}")
        end
        disp=ff.join("\n")
        disp="#{disp}\n\n**Dash Attack:** #{k2[-2]}#{'%' if k2[-2].to_i.to_s==k2[-2]}\n**Force Strike:** #{k2[-1]}#{'%' if k2[-1].to_i.to_s==k2[-1]}"
      else
        disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\n**Dash Attack:** #{k2[5]}\n**Force Strike:** #{k2[6]}"
      end
      if @damage_override.length>1
        sltz=[5,6]
        sltz=[-2,-1] if @weapon=='Manacaster'
        for i in 0...@damage_override.length
          if @damage_override[i].length>1
            ff=["__**Combo**__"]
            for i2 in 1...@damage_override[i].length-2
              ff.push("*#{m[i2]} Hit:* #{@damage_override[i][i2]}#{'%' if @damage_override[i][i2].to_i.to_s==@damage_override[i][i2]}")
            end
            ff.push("\n**Dash Attack:** #{@damage_override[i][-2]}#{'%' if @damage_override[i][i2].to_i.to_s==@damage_override[i][i2]}") unless @damage_override[i][-2].to_s.gsub('%','')==k2[sltz[0]].to_s.gsub('%','')
            ff.push("#{"\n" if @damage_override[i][-2].to_s.gsub('%','')==k2[sltz[0]].to_s.gsub('%','')}**Force Strike:** #{@damage_override[i][-1]}#{'%' if @damage_override[i][i2].to_i.to_s==@damage_override[i][i2]}") unless @damage_override[i][-1].to_s.gsub('%','')==k2[sltz[1]].to_s.gsub('%','')
            if @damage_override[i][0][0,1]=='*' && i==0
              disp=ff.join("\n")
              k2[5]=@damage_override[i][-2]
              k2[6]=@damage_override[i][-1]
            else
              f.push([@damage_override[i][0],ff.join("\n")])
            end
          end
        end
      else
        f=nil
      end
      create_embed(event,"__Damage modifiers for **#{@name}#{self.emotes(bot)}**__",disp,self.disp_color,nil,self.thumbnail,f)
      return nil
    elsif @weapon=='Manacaster'
      return @weapon2
    else
      return @weapon
    end
  end
end

class DLDragon
  def rar_row(r=0)
    str=generate_rarity_row(@rarity,0,@games[0])
    if ['Bronze Fafnir','Silver Fafnir','Gold Fafnir'].include?(@name)
      m=0
      m=3 if @name=='Bronze Fafnir'
      m=4 if @name=='Silver Fafnir'
      m=5 if @name=='Gold Fafnir'
      emt=$rarity_stars[0][m]
      emt=FEH_rarity_stars[m] if @games[0]=='FEH'
      emt=FGO_rarity_stars[m] if @games[0]=='FGO'
      str=emt*@rarity
    end
    return str
  end
  
  def portrait(event,args=nil,forcerar=nil)
    args=event.message.text.downcase.split(' ') if args.nil?
    lookout=$skilltags.reject{|q| q[2]!='Art' && q[2]!='Art/Dragon'}
    for i in 0...args.length
      for j in 0...lookout.length
        rar=lookout[j][0] if rar.nil? && lookout[j][1].include?(args[i].downcase)
      end
    end
    dispname=@name.gsub(' ','_')
    disp="#{self.rar_row}"
    rar='Human' if rar.nil? && @name=='Brunhilda' && args.include?('mym')
    if !rar.nil? && rar.is_a?(String)
      art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Dragons/#{dispname}#{"_#{rar}" unless rar.nil?}.png"
      m=false
      IO.copy_stream(open(art), "#{$location}devkit/DLTemp#{Shardizard}.png") rescue m=true
      if File.size("#{$location}devkit/DLTemp#{Shardizard}.png")<=100 || m
        rar=nil
      else
        disp="#{disp}\n#{rar} design\n"
      end
    end
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Dragons/#{dispname}#{"_#{rar}" unless rar.nil?}.png"
    return[art,disp,rar]
  end
  
  def artist; return nil; end
  
  def damage_embed(event,bot)
    if @damage_override.nil? || @damage_override.length<=0
      event.respond "**#{@name}**#{self.emotes(bot)} does not have any damage modifiers stored."
      return nil
    end
    m=[0,'First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth','Tenth','Eleventh','Twelfth','Thirteenth','Fourteenth','Fifteenth','16th','17th','18th','19th',
       '20th','21st','22nd','23rd','24th','25th','26th','27th','28th','29th','30th','31st','32nd','33rd','34th','35th','36th','37th','38th','39th','40th','41st','42nd','43rd','44th',
       '45th','46th','47th','48th','49th','50th']
    for i in 0...@damage_override.length
      for i2 in 1...@damage_override[i].length
        @damage_override[i][i2]="#{@damage_override[i][i2]}%" unless @damage_override[i][i2].is_a?(String) && @damage_override[i][i2].to_i.to_s != @damage_override[i][i2]
        @damage_override[i][i2]="*#{m[i2]} Hit:* #{@damage_override[i][i2]}"
      end
    end
    f=nil
    disp=''
    if @damage_override.length==1
      disp=@damage_override[0][1,@damage_override[0].length-1].join("\n")
    else
      f=[]
      for i in 0...@damage_override.length
        f.push(@damage_override[i][0],@damage_override[i][1,@damage_override[i].length-1].join("\n"))
      end
    end
    create_embed(event,"__Damage modifiers for **#{@name}#{self.emotes(bot)}**__",disp,self.disp_color,nil,self.thumbnail,f)
   return nil
  end
end

class DLWyrmprint
  def isMultiprint?
    return true if @name=='Wily Warriors'
    return true if @name=='Greatwyrm'
    return true if @name=='Her Beloved'
    return true if @name=='Mask of Determination'
    return false
  end
  
  def multiprintText
    return nil unless self.isMultiprint?
    pr=$wyrmprints.reject{|q| !q.name.include?("#{@name} ")}.map{|q| q.name.gsub("#{@name} ",'')}.uniq
    str="This print entry only exists to contain the combined art of the #{@name} series of wyrmprints.  For individual pieces of this series, use their subtitles:\n#{pr.join("\n")}"
    if ['Her Beloved','Mask of Determination'].include?(@name)
      pr=$wyrmprints.reject{|q| !q.name.include?("#{@name} ")}.map{|q| q.name}.uniq
      str="This print entry only exists as a disambiguation page for the multiple prints of the same name.  For individual prints, use their boons:\n#{pr.join("\n")}"
    end
    str="\n#{str}" if !@obtain.nil? && @obtain.length>0
    return str
  end
  
  def rar_row(r=0)
    return '<:Dominion:819854169128435742>' if !@availability.nil? && @availability.include?('x')
    return generate_rarity_row(@rarity,0,@games[0])
  end
  
  def portrait(event,args=nil,forcerar=nil)
    args=event.message.text.downcase.split(' ') if args.nil?
    dispname=@name.gsub(' ','_')
    l=1
    l=2 if has_any?(['mub','unbind','unbound','refined','refine','refinement','2ub','3ub'],args)
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Wyrmprints/#{dispname}_#{l}.png"
    if @name.split(' (')[-1][-8,8]=="'s Boon)"
      m=false
      IO.copy_stream(open(art), "#{$location}devkit/DLTemp#{Shardizard}.png") rescue m=true
      dispname=@name.split(' (')[0].gsub(' ','_') if File.size("#{$location}devkit/DLTemp#{Shardizard}.png")<=100 || m
    end
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Wyrmprints/#{dispname}_#{l}.png"
    emtz=['','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>']
    emtz=['','<:Limited:574682514585550848>','<:LimitBroken:574682514921095212>'] if @games[0]=='FEH'
    halfemote="\u200B  \u200B  \u200B  \u200B"
    disprar=@rarity*1
    disprar=2 if !@availability.nil? && @availability.include?('x')
    disp="#{halfemote*(4-disprar) if disprar<4}#{" \u200B" if disprar<3}#{self.rar_row}"
    disp="#{disp}\n#{"#{halfemote*(disprar-4)} \u200B" if disprar>=5}#{emtz[l]*4}"
    return [art,disp]
  end
  
  def voice_na; return nil; end
  def voice_jp; return nil; end
  def tid; return 0; end
end

class DLWeapon
  def rar_row(r=0)
    return generate_rarity_row(@rarity,0,@games[0])
  end
end

class DLEnemy
  def isBaby?
    return true if ['Wandering Shroom, Clone Wave 1','Wandering Shroom, Clone Wave 2'].include?(@name)
    return true if ['Gust Shroom, Clone Wave 1','Gust Shroom, Clone Wave 2'].include?(@name)
    return true if ['Scalding Shroom, Clone Wave 1','Scalding Shroom, Clone Wave 2'].include?(@name)
    return true if ['Jingu Bang','Mini Dasheng'].include?(@name)
    return true if ['Gift Basket','Astral Gift Basket'].include?(@name)
    return true if ['Blood Moon'].include?(@name)
    return false
  end
  
  def babies
    x=[]
    x=['Wandering Shroom, Clone Wave 1','Wandering Shroom, Clone Wave 2'] if @name=='Wandering Shroom'
    x=['Gust Shroom, Clone Wave 1','Gust Shroom, Clone Wave 2'] if @name=='Gust Shroom'
    x=['Scalding Shroom, Clone Wave 1','Scalding Shroom, Clone Wave 2'] if @name=='Scalding Shroom'
    x=['Jingu Bang','Mini Dasheng'] if @name=='Qitian Dasheng'
    x=['Gift Basket'] if @name=='Shishimai'
    x=['Astral Gift Basket'] if @name=='Astral Shishimai'
    x=['Blood Moon'] if @name=='Volk'
    return [] if x.length<=0
    m=$enemies.reject{|q| !x.include?(q.name)}.map{|q| q.clone}
    return m
  end
  
  def rar_row(r=0)
    return ''
  end
  
  def portrait(event,args=nil,forcerar=nil)
    args=event.message.text.downcase.split(' ') if args.nil?
    lookout=$skilltags.reject{|q| q[2]!='Art' && q[2]!='Art/Enemy'}
    dispname=@name.gsub(' ','_')
    for i in 0...args.length
      for j in 0...lookout.length
        rar=lookout[j][0] if rar.nil? && lookout[j][1].include?(args[i].downcase)
      end
    end
    disp=''
    if !rar.nil? && rar.is_a?(String)
      art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Bosses/#{dispname}#{"_#{rar}" unless rar.nil?}.png"
      IO.copy_stream(open(art), "#{$location}devkit/DLTemp#{Shardizard}.png") rescue m=true
      if File.size("#{$location}devkit/DLTemp#{Shardizard}.png")<=100 || m
        rar=nil
      else
        disp="#{disp}\n#{rar} design\n"
      end
    end
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Bosses/#{dispname}#{"_#{rar}" unless rar.nil?}.png"
    return [art,disp]
  end
  
  def artist; return nil; end
  def voice_na; return nil; end
  def voice_jp; return nil; end
end

class DLFacility
  def stat_buffs(lvl)
    if ['Dual Altar','Event Dual Altar','Dual Dojo','Event Dual Dojo'].include?(@subtype)
      alta=[(lvl+1)/2,lvl/2]
      alta[0]*=0.3
      alta[1]*=0.3
      alta[0]+=0.5
      alta[1]+=0.5
      if lvl>=29
        x=lvl-29
        alta=[5.0+(x/5).to_i,5.0+(x/5).to_i]
        alta[1]+=0.3 if x%5>=1
        alta[0]+=0.3 if x%5>=2
        alta[1]+=0.4 if x%5>=3
        alta[0]+=0.4 if x%5>=4
      end
      return alta
    elsif !@tags.nil? && @tags.include?('Tree')
      alta=[lvl+2.0,lvl+2.0]
      if lvl<9
        x=lvl/4
        alta=[x*3.0+3.0,x*3.0+3.0]
        if lvl%4>0
          alta[0]+=1.0
          alta[1]+=0.5
        end
        if lvl%4>1
          alta[1]+=1.0
          alta[0]+=0.5
        end
        if lvl%4>2
          alta[0]+=1.0
          alta[1]+=0.5
        end
      end
      return alta
    elsif @subtype=='Dracolith'
      return [lvl+1.0] if lvl<20
      return [20.0+3*(lvl-19)]
    elsif @subtype=='Altar'
      alta=[(lvl+1)/2,lvl/2]
      alta=[lvl-17,lvl-17] if lvl>34
      alta=[(lvl+7)/2,lvl/2+3] if lvl>40
      alta=alta.map{|q| q*0.5+0.5}
      return alta
    elsif ['Dojo','Fafnir'].include?(@subtype)
      alta=[(lvl+1)/2,lvl/2]
      alta=alta.map{|q| q*0.5+3.0}
      for i2 in 0...((lvl+1)/15+1)
        if lvl>15*i2+14 && i2%2==0
          alta[0]+=1+i2
          alta[1]+=1.5+i2
        elsif lvl>15*i2+14 && i2%2==1
          alta[0]+=1.5+i2
          alta[1]+=1+i2
        end
      end
      alta[1]+=0.5 if lvl>34
      return alta
    elsif @subtype=='Event Altar'
      alta=[(lvl+1)/2,lvl/2]
      alta=alta.map{|q| q*0.5}
      alta[0]+=1
      return alta
    end
    return []
  end
end

class DL_NPC
  def rar_row(r=0)
    g=''
    g='FEH' if ['Loki','Thorr'].include?(@name)
    r=@rarity*1
    unless @rarity<3
      r/=2
      r=2 if r>2
    end
    r=6 if @name=='Notte'
    m=$max_rarity[0,2].max
    str=generate_rarity_row(r,m,g)
    str=generate_rarity_row(r,0,g) if @lock
    unless r==@rarity
      x=$rarity_stars[0].map{|q| q}
      x=FEH_rarity_stars.map{|q| q} if g=='FEH'
      x=FGO_rarity_stars.map{|q| q} if g=='FGO'
      str=x[r]*@rarity
      unless @lock
        x=$rarity_stars[1][r]
        x='<:Icon_Rarity_Empty:631460895851282433>' if g=='FEH'
        x='<:FGO_rarity_inverted:544568437029208094>' if g=='FGO'
        str="#{str}#{x*(m-@rarity)}"
      end
    end
    return str
  end
  
  def portrait(event,args=nil,forcerar=nil)
    args=event.message.text.downcase.split(' ') if args.nil?
    lookout=$skilltags.reject{|q| q[2]!='Art' && q[2]!='Art/NPC'}
    dispname=@name.gsub(' ','_')
    for i in 0...args.length
      for j in 0...lookout.length
        rar=lookout[j][0] if rar.nil? && lookout[j][1].include?(args[i].downcase)
      end
    end
    disp=self.rar_row
    if !rar.nil? && rar.is_a?(String)
      art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Misc/#{dispname}#{"_#{rar}" unless rar.nil?}.png"
      m=false
      IO.copy_stream(open(art), "#{$location}devkit/DLTemp#{Shardizard}.png") rescue m=true
      if File.size("#{$location}devkit/FGOTemp#{Shardizard}.png")<=100 || m
        rar=nil
      else
        disp="#{disp}\n#{rar} design\n"
      end
    end
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Misc/#{dispname}#{"_#{rar}" unless rar.nil?}.png"
    return [art,disp]
  end
  
  def artist; return nil; end
end

class DLSticker
  def rar_row(r=0)
    return ''
  end
  
  def portrait(event,args=nil,forcerar=nil)
    args=event.message.text.downcase.split(' ') if args.nil?
    nme=@name.gsub(' ','_').gsub('!','').gsub('?','')
    nme="#{nme}(JP)" if has_any?(args,['jp','japan'])
    art="https://github.com/Rot8erConeX/BotanBot/blob/master/Art/Stickers/#{nme}.png?raw=true"
    return [art,'']
  end
  
  def artist; return nil; end
  def voice_na; return nil; end
  def voice_jp; return nil; end
end

class DLBanner
  def disp_embed(event,bot,mode=0,msg='')
    adv=$adventurers.map{|q| q}
    drg=$dragons.map{|q| q}
    wrm=$wyrmprints.map{|q| q}
    aaa=@advs.map{|q| q}
    f=[]
    for i in 0...aaa.length
      a=adv.find_index{|q| q.name==aaa[i].gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')}
      if @advs.length+@drgs.length+@prints.length<=10
        aaa[i]="#{aaa[i]}#{adv[a].emotes(bot)}" unless a.nil?
      elsif a.nil?
        aaa[i]="~~#{aaa[i]}~~"
      end
    end
    f.push(['Adventurers',aaa.join("\n")]) unless aaa.length<=0
    aaa=@drgs.map{|q| q}
    for i in 0...aaa.length
      a=drg.find_index{|q| q.name==aaa[i].gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')}
      if @advs.length+@drgs.length+@prints.length<=10
        aaa[i]="#{aaa[i]}#{drg[a].emotes(bot)}" unless a.nil?
      elsif a.nil?
        aaa[i]="~~#{aaa[i]}~~"
      end
    end
    f.push(['Dragons',aaa.join("\n")]) unless aaa.length<=0
    aaa=@prints.map{|q| q}
    for i in 0...aaa.length
      a=wrm.find_index{|q| q.name==aaa[i].gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')}
      if @advs.length+@drgs.length+@prints.length<=10
        aaa[i]="#{aaa[i]}#{wrm[a].emotes(bot)}" unless a.nil?
      elsif a.nil?
        aaa[i]="~~#{aaa[i]}~~"
      end
    end
    f.push(['Wyrmprints',aaa.join("\n")]) unless aaa.length<=0
    f=nil if f.length<=0
    if !@end_date.nil? && mode==1
      t=Time.now
      timeshift=7
      timeshift-=1 unless (t-24*60*60).dst?
      t-=60*60*timeshift
      t2=@end_date.map{|q| q}
      t2=Time.new(t2[2],t2[1],t2[0])+24*60*60
      t2=t2-t
      if t2/(24*60*60)>1
        str2=" - #{(t2/(24*60*60)).floor} days left"
      elsif t2/(60*60)>1
        str2=" - #{(t2/(60*60)).floor} hours left"
      elsif t2/60>1
        str2=" - #{(t2/60).floor} minutes left"
      elsif t2>1
        str2=" - #{(t2).floor} seconds left"
      end
    elsif mode==0 && !@start_date.nil? && !@end_date.nil?
      kk=[@start_date,@end_date].map{|q| "#{q[0]} #{['','Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'][q[1]]} #{q[2]}"}
      str2="**Real-world date:** #{kk[0]} - #{kk[1]}\n(assuming reset is at midnight)"
    else
      str2=''
    end
    ftr=nil
    ftr="Associated Facility: #{@facilities.join(', ')}" unless @facilities.nil? || @facilities.length<=0
    create_embed(event,"#{msg}__**#{@name}**__",str2,self.disp_color,ftr,[nil,self.thumbnail],f)
  end
  
  def description(event,itm=nil,fulldesc=false)
    kk=[@start_date,@end_date].map{|q| "#{q[0]}#{['','Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'][q[1]]}#{q[2]}"}
    if safe_to_spam?(event) || fulldesc
      str="__*#{@name}*__"
      str="#{str}\n*Real-world date:* #{kk[0]} - #{kk[1]}"
      sprk=false
      a=@advs.map{|q| q.gsub('*','')}
      d=@drgs.map{|q| q.gsub('*','')}
      p=@prints.map{|q| q.gsub('*','')}
      unless itm.nil?
        sprk=true if itm.is_a?(DLAdventurer) && has_any?(@advs.map{|q| q.gsub('*')},["#{itm.name} <:Wyrmsigil:759937956672045066>","#{itm.name}<:Wyrmsigil:759937956672045066>"])
        sprk=true if itm.is_a?(DLDragon) && has_any?(@drgs.map{|q| q.gsub('*')},["#{itm.name} <:Wyrmsigil:759937956672045066>","#{itm.name}<:Wyrmsigil:759937956672045066>"])
        sprk=true if itm.is_a?(DLWyrmprint) && has_any?(@prints.map{|q| q.gsub('*')},["#{itm.name} <:Wyrmsigil:759937956672045066>","#{itm.name}<:Wyrmsigil:759937956672045066>"])
        str="#{str}\n<:Wyrmsigil:759937956672045066> *#{itm.name} is sparkable*" if sprk
        a=a.reject{|q| q.gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')==itm.name} if itm.is_a?(DLAdventurer)
        d=d.reject{|q| q.gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')==itm.name} if itm.is_a?(DLDragon)
        p=p.reject{|q| q.gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')==itm.name} if itm.is_a?(DLWyrmprint)
      end
      str="#{str}\n*Focus Adventurers:* #{a.sort.join(', ')}" unless a.length<=0
      str="#{str}\n*Focus Dragons:* #{d.sort.join(', ')}" unless d.length<=0
      str="#{str}\n*Focus Wyrmprints:* #{p.sort.join(', ')}" unless p.length<=0
      str="#{str}\n*Associated Facility:* #{@facilities.join(', ')}" unless @facilities.nil? || @facilities.length<=0
    else
      str="*#{@name}*  (#{kk[0]}-#{kk[1]})"
    end
    return str
  end
  
  def hasFocus?(itm)
    if itm.is_a?(DLAdventurer)
      return true if @advs.map{|q| q.gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')}.include?(itm.name)
    elsif itm.is_a?(DLDragon)
      return true if @drgs.map{|q| q.gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')}.include?(itm.name)
    elsif itm.is_a?(DLWyrmprint)
      return true if @false.map{|q| q.gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')}.include?(itm.name)
    end
    return false
  end
end

class DLGroup
  def adventurer_list
    return [] if @advs.nil?
    m=$adventurers.reject{|q| !@advs.include?(q.name)}
    m.push($adventurers.reject{|q| !q.isManakete?}) if @name=='Custom Shapeshift'
    m.push($adventurers.reject{|q| !q.name.include?('(Dragonyule)')}) if @name=='Dragonyule'
    m.push($adventurers.reject{|q| !q.name.include?('(Halloween)')}) if @name=='Halloween'
    m.push($adventurers.reject{|q| !q.name.include?('(NewYears)')}) if @name=="New Year's"
    m.push($adventurers.reject{|q| !q.name.include?('(Valentines)')}) if @name=="Valentine's"
    m.push($adventurers.reject{|q| !q.name.include?('(Summer)')}) if @name=='Summer'
    m.push($adventurers.reject{|q| !q.hasCustomCombo?}) if @name=='Custom Combo'
    m.push($adventurers.reject{|q| !q.hasCustomForceStrike?}) if @name=='Custom Force Strike'
    m.push($adventurers.reject{|q| !q.name.include?('(Wedding)') && !q.name.include?('(Bride)') && !q.name.include?('(Groom)')}) if @name=='Wedding'
    m.flatten!
    return m
  end
  
  def dragon_list
    return [] if @drgs.nil?
    m=$dragons.reject{|q| !@drgs.include?(q.name)}
    m.push($dragons.reject{|q| !q.isPseudodragon?}) if @name=='Custom Shapeshift'
    m.push($dragons.reject{|q| !q.name.include?('(Dragonyule)')}) if @name=='Dragonyule'
    m.push($dragons.reject{|q| !q.name.include?('(Halloween)')}) if @name=='Halloween'
    m.push($dragons.reject{|q| !q.name.include?('(NewYears)')}) if @name=="New Year's"
    m.push($dragons.reject{|q| !q.name.include?('(Valentines)')}) if @name=="Valentine's"
    m.push($dragons.reject{|q| !q.name.include?('(Summer)')}) if @name=='Summer'
    m.push($dragons.reject{|q| !q.name.include?('(Wedding)') && !q.name.include?('(Bride)') && !q.name.include?('(Groom)')}) if @name=='Wedding'
    m.flatten!
    return m
  end
  
  def wyrmprint_list
    return [] if @prints.nil?
    m=$wyrmprints.reject{|q| !@prints.include?(q.name)}
    m.flatten!
    return m
  end
  
  def weapon_list
    return [] if @weps.nil?
    m=$weapons.reject{|q| !@weps.include?(q.name)}
    m.flatten!
    return m
  end
  
  def total_size
    return self.adventurer_list.length+self.dragon_list.length+self.wyrmprint_list.length+self.weapon_list.length
  end
  
  def isDynamic?(total=false)
    x=[false,false,false,false]
    x[0]=true if !@advs.nil? && self.adventurer_list.length>@advs.length
    x[1]=true if !@drgs.nil? && self.dragon_list.length>@drgs.length
    x[2]=true if !@prints.nil? && self.wyrmprint_list.length>@prints.length
    x[3]=true if !@weps.nil? && self.weapon_list.length>@weps.length
    return true if x.include?(true) && total
    return false if total
    return x
  end
  
  def fullName
    return "\u{1F458} New Year's" if @name=="New Year's" # kimono
    return "\u{1F498} Valentine's" if @name=="Valentine's" # heart with arrow
    return "\u{1F470} Wedding" if @name=='Wedding' # bride with veil
    return ':sunny: Summer' if @name=='Summer'
    return "\u{1F383} Halloween" if @name=='Halloween' # jack-o-lantern
    return "\u{1F384} Dragonyule" if @name=='Dragonyule' # Christmas tree
    return "\u{1F977} Ninjas / Assassins" if @name=='Ninjas / Assassins' # ninja
    return "\u{1F483} Dancers" if @name=='Dancers'
    return @name
  end
  
  def quantities
    m=[]
    if @advs.nil? || self.adventurer_list.length<=0
    elsif @advs.length<=0 && self.adventurer_list.length>0
      m.push("*#{self.adventurer_list.length}* adventurer#{'s' unless self.adventurer_list.length==1}")
    elsif @advs.length>=self.adventurer_list.length
      m.push("#{self.adventurer_list.length} adventurer#{'s' unless self.adventurer_list.length==1}")
    else
      m.push("#{@advs.length}*+#{self.adventurer_list.length-@advs.length}* adventurers")
    end
    if @drgs.nil? || self.dragon_list.length<=0
    elsif @drgs.length<=0 && self.dragon_list.length>0
      m.push("*#{self.dragon_list.length}* dragon#{'s' unless self.dragon_list.length==1}")
    elsif @drgs.length>=self.dragon_list.length
      m.push("#{self.dragon_list.length} dragon#{'s' unless self.dragon_list.length==1}")
    else
      m.push("#{@drgs.length}*+#{self.dragon_list.length-@drgs.length}* dragons")
    end
    if @prints.nil? || self.wyrmprint_list.length<=0
    elsif @prints.length<=0 && self.wyrmprint_list.length>0
      m.push("*#{self.wyrmprint_list.length}* wyrmprint#{'s' unless self.wyrmprint_list.length==1}")
    elsif @prints.length>=self.wyrmprint_list.length
      m.push("#{self.wyrmprint_list.length} wyrmprint#{'s' unless self.wyrmprint_list.length==1}")
    else
      m.push("#{@prints.length}*+#{self.wyrmprint_list.length-@prints.length}* wyrmprints")
    end
    if @weps.nil? || self.weapon_list.length<=0
    elsif @weps.length<=0 && self.weapon_list.length>0
      m.push("*#{self.weapon_list.length}* weapon#{'s' unless self.weapon_list.length==1}")
    elsif @weps.length>=self.weapon_list.length
      m.push("#{self.weapon_list.length} weapon#{'s' unless self.weapon_list.length==1}")
    else
      m.push("#{@weps.length}*+#{self.weapon_list.length-@weps.length}* weapons")
    end
    return 'empty' if m.length<=0
    return m.join(', ')
  end
  
  def contents
    m=[]
    if @advs.nil? || self.adventurer_list.length<=0
    elsif self.adventurer_list.length>25 || self.total_size>50
      m.push("**#{self.adventurer_list.length} adventurers**")
    else
      m.push("**Adventurers:** #{self.adventurer_list.map{|q| "#{'*' unless @advs.include?(q.name)}#{q.name}#{'*' unless @advs.include?(q.name)}"}.join(', ')}")
    end
    if @drgs.nil? || self.dragon_list.length<=0
    elsif self.dragon_list.length>25 || self.total_size>50
      m.push("**#{self.dragon_list.length} dragons**")
    else
      m.push("**Dragons:** #{self.dragon_list.map{|q| "#{'*' unless @drgs.include?(q.name)}#{q.name}#{'*' unless @drgs.include?(q.name)}"}.join(', ')}")
    end
    if @prints.nil? || self.wyrmprint_list.length<=0
    elsif self.wyrmprint_list.length>25 || self.total_size>50
      m.push("**#{self.wyrmprint_list.length} wyrmprints**")
    else
      m.push("**Wyrmprints:** #{self.wyrmprint_list.map{|q| "#{'*' unless @prints.include?(q.name)}#{q.name}#{'*' unless @prints.include?(q.name)}"}.join(', ')}")
    end
    if @weps.nil? || self.weapon_list.length<=0
    elsif self.weapon_list.length>25 || self.total_size>50
      m.push("**#{self.weapon_list.length} weapons**")
    else
      m.push("**Weapons:** #{self.weapon_list.map{|q| "#{'*' unless @weps.include?(q.name)}#{q.name}#{'*' unless @weps.include?(q.name)}"}.join(', ')}")
    end
    return m.join("\n")
  end
end

# maliable data displays

def disp_dragon_stats(bot,event,args=nil,juststats=false,preload=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  drg=$dragons.map{|q| q}; adv=$adventurers.map{|q| q}
  mym=nil
  mym='Gala' if (has_any?(args,['super','gala']) && has_any?(args,['mym','brunhilda'])) || has_any?(args,['supermym','superbrunhilda','brunhildasuper','mymsuper','galamym','galabrunhilda','brunhildagala','mymgala','mymhilda'])
  mym='Halloween' if (has_any?(args,['halloween','spooky','spoopy','scary']) && has_any?(args,['mym','brunhilda'])) || has_any?(args,['halloweenmym','halloweenbrunhilda','brunhildahalloween','mymhalloween','spookymym','spookybrunhilda','brunhildaspooky','mymspooky','spoopymym','spoopybrunhilda','brunhildaspoopy','mymspoopy','scarymym','scarybrunhilda','brunhildascary','mymscary','mymhilda'])
  if preload.nil? || !preload.is_a?(DLDragon)
    if !mym.nil?
      d=drg.find_index{|q| q.name=='Brunhilda'}
      d=drg[d].clone
      a=adv.find_index{|q| q.name=="Mym(#{mym})"}
      a=adv.find_index{|q| q.name=="Gala Mym"} if mym=='Gala'
      d.rarity="#{adv[a].rarity}#{adv[a].availability}"
      d.name="#{mym} Brunhilda"
      d.hp='0, 0'; d.str='0, 0'; d.sell_price='0, 0'
      d.skills="Muspelheim(#{mym})"
      d.skills='Infernal Ray' if mym=='Gala'
      d.auras=''
      d.thumbforce="Adventurers/Mym(#{mym})_5"
      d.thumbforce="Adventurers/Gala_Mym_5" if mym=='Gala'
      disp_dragon_stats(bot,event,args,juststats,d)
      return nil
    elsif (has_any?(args,['shiny']) && has_any?(args,['nyarlathotep'])) || has_any?(args,['shinynyarlathotep','lathna'])
      d=drg.find_index{|q| q.name=='Nyarlathotep'}
      d=drg[d].clone
      a=adv.find_index{|q| q.name=='Lathna'}
      d.rarity="#{adv[a].rarity}#{adv[a].availability}"
      d.name='Shiny Nyarlathotep'
      d.hp='0, 0'; d.str='0, 0'; d.sell_price='0, 0'
      d.skills='All-Encompassing Darkness (Yang)'
      d.auras=''
      d.thumbforce='Dragons/Shiny_Nyarlathotep_5'
      disp_dragon_stats(bot,event,args,juststats,d)
      return nil
    elsif (has_any?(args,['mega','rock']) && has_any?(args,['man'])) || has_any?(args,['megaman','rockman'])
      args=['rush']
    end
    k=find_data_ex(:find_dragon,args.join(' '),event)
  else
    k=preload.clone
  end
  if k.nil?
    args.unshift('dragon')
    if !find_data_ex(:find_skill,args.join(' '),event).nil?
      disp_skill_data(bot,event,args)
    elsif !find_data_ex(:find_ability,args.join(' '),event).nil?
      disp_ability_data(bot,event,args)
    else
      event.respond "No matches found."
    end
    return nil
  end
  data_load(['skills'])
  s2s=false
  s2s=true if safe_to_spam?(event)
  hdr="__**#{k.name}**__"
  title=k.class_header(bot,0,true)
  str=''
  if s2s || juststats
    c=k.stat_emotes.map{|q| q}
    unless k.isPseudodragon?
      str="**Lv.1:**  #{c[0]}#{k.hp[0]}  #{c[1]}#{k.str[0]}"
      str="#{str}\n**Lv.#{k.rarity*20}:**  #{c[0]}#{k.hp[1]}  #{c[1]}#{k.str[1]}"
      str="#{str}\n**Lv.#{k.rarity*20+15}:**  #{c[0]}#{k.hp[2]}  #{c[1]}#{k.str[2]}" if k.hp.length>2 && k.str.length>2
    end
  else
    title=k.mini_header(bot)
    hdr="#{hdr} #{k.rar_row}"
  end
  if title.length>250
    h=title.split("\n")
    title=[h[0],'']
    j=0
    for i in 1...h.length
      if "#{title[j]}\n#{h[i]}".length>250 && j==0
        j+=1
        title[j]="#{h[i]}"
      else
        title[j]="#{title[j]}\n#{h[i]}"
      end
    end
  end
  unless k.speed.nil? || k.speed.length<=1 || !(s2s || juststats)
    str="#{str}\n\n#{k.stat_emotes[2]}**Speed:**  *Dash:*\u00A0\u00A0#{k.speed[0]}  *Turn:*\u00A0\u00A0#{k.speed[1]}"
    str="#{str}\n*Automatically turns to damage direction*" if k.dmg_turn
    if k.longrange
      str="#{str}\n*Long range attacks*"
    else
      str="#{str}\n*Short range attacks*"
    end
  end
  sklz=$skills.map{|q| q}
  unless juststats || k.skills.nil? || k.skills.length<=0
    skl1=sklz.find_index{|q| q.name==k.skills[0]}
    skl1=sklz[skl1] unless skl1.nil?
    skl2=sklz.find_index{|q| q.name==k.skills[1]}
    skl2=sklz[skl2] unless skl2.nil?
    str2=''
    if k.skills[0].nil? || k.skills[0].length<=0 || k.skills[0]=='-'
    elsif skl1.nil?
      str2="**#{k.skills[0]}** - LOAD ERROR"
    elsif s2s
      str2="__**#{skl1.name}** (#{'%.1f' % skl1.invulnerability} sec. invul#{", #{skl1.energy_display}" if skl1.energy_display.length>0})__"
      str2="#{str2} - #{skl1.sp_display(1)} SP" unless skl1.sp_display(0).uniq.length>1 || skl1.sp_display(1)[0]=='-'
      if skl1.mass_description.nil?
        for i in 0...skl1.description.length
          str2="#{str2}\n*#{skl1.level_text(i+1,-1)}:* #{skl1.description[i]}"
        end
      else
        str2="#{str2}\n#{skl1.mass_description}"
        if skl1.sp_display(0).uniq.length>1
          str2="#{str2}\n#{skl1.level_text(1,-1)}"
          for i in 1...skl1.description.length
            str2="#{str2} \u2192 #{skl1.level_text(i+1,-1)}"
          end
        end
      end
    else
      lvl=skl1.description.length
      str2="*#{skl1.name}#{skl1.energy_display(false)} [#{skl1.level_text(lvl,-1,true)}]*#{" - #{skl1.sp_display(lvl)} SP" unless skl1.sp_display(lvl)[0]=='-'}"
      str2="#{str2}\n#{skl1.description[lvl-1]}"
    end
    if k.skills[1].nil? || k.skills[1].length<=0 || k.skills[1]=='-'
    elsif skl2.nil?
      str2="#{str2}\n\n**#{k.skills[1]}** - LOAD ERROR"
    elsif s2s
      str2="#{str2}\n\n__**#{skl2.name}** (#{'%.1f' % skl2.invulnerability} sec. invul#{", #{skl2.energy_display}" if skl2.energy_display.length>0})__"
      str2="#{str2} - #{skl2.sp_display(1)} SP" unless skl2.sp_display(0).uniq.length>1 || skl2.sp_display(1)[0]=='-'
      if skl2.mass_description.nil?
        for i in 0...skl2.description.length
          str2="#{str2}\n*#{skl2.level_text(i+1,-1)}:* #{skl2.description[i]}"
        end
      else
        str2="#{str2}\n#{skl2.mass_description}"
        if skl2.sp_display(0).uniq.length>1
          str2="#{str2}\n#{skl2.level_text(1,-1)}"
          for i in 1...skl2.description.length
            str2="#{str2} \u2192 #{skl2.level_text(i+1,-1)}"
          end
        end
      end
    else
      lvl=skl2.description.length
      str2="#{str2}\n\n*#{skl2.name}#{skl2.energy_display(false)} [#{skl2.level_text(lvl,-1,true)}]*#{" - #{skl2.sp_display(lvl)} SP" unless skl2.sp_display(lvl)[0]=='-'}"
      str2="#{str2}\n#{skl2.description[lvl-1]}"
    end
    str2=str2["\n".length,str2.length-"\n".length] if str2[0,"\n".length]=="\n"
    str2=str2["\n".length,str2.length-"\n".length] if str2[0,"\n".length]=="\n"
    str="#{str}\n;;;;;"
  end
  bemoji=['<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>']
  bemoji=['<:Limited:574682514585550848>','<:LimitBroken:574682514921095212>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>'] if k.games[0]=='FGO'
  bemoji=['<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Really_Sacred_Coin:571011997609754624>','<:Resource_Structure:510774545154572298>'] if k.games[0]=='FEH'
  # Mana Spiral Pink = 0xE9438F
  unless juststats || k.auras.nil? || k.auras.length<=0
    str="#{str}\n\n**Aura:**\n#{bemoji[0]*4}#{k.auras.map{|q| q[0]}.reject{|q| q.nil? || q.length<=0}.join(', ')}"
    if k.auras.map{|q| q.length}.max>2
      if safe_to_spam?(event)
        str="#{str}\n#{bemoji[1]*1}#{bemoji[0]*3}#{k.auras.map{|q| q[[q.length-1,1].min]}.reject{|q| q.nil? || q.length<=0}.join(', ')}" if k.auras.map{|q| q.length}.max>3
        qq=1
        qq=2 if k.auras.map{|q| q.length}.max>3
        str="#{str}\n#{bemoji[1]*2}#{bemoji[0]*2}#{k.auras.map{|q| q[[q.length-1,qq].min]}.reject{|q| q.nil? || q.length<=0}.join(', ')}"
        str="#{str}\n#{bemoji[1]*3}#{bemoji[0]*1}#{k.auras.map{|q| q[[q.length-1,3].min]}.reject{|q| q.nil? || q.length<=0}.join(', ')}" if k.auras.map{|q| q.length}.max>3
      end
      str="#{str}\n#{bemoji[1]*4}#{k.auras.map{|q| q[-1]}.reject{|q| q.nil? || q.length<=0}.join(', ')}"
    else
      str="#{str}\n#{bemoji[1]*4}#{k.auras.map{|q| q[1]}.reject{|q| q.nil? || q.length<=0}.join(', ')}"
    end
  end
  str="#{str}\n\n**Sells for:** #{longFormattedNumber(k.sell_price[0])}#{bemoji[2]} #{longFormattedNumber(k.sell_price[1])}#{bemoji[3]}" unless juststats || k.sell_price.nil? || k.sell_price.length<=0 || k.sell_price.max<=0
  str="#{str}\n\n**Bond gift preference:** #{['Golden Chalice (Sunday)','Juicy Meat (Monday)','Kaleidoscope (Tuesday)','Floral Circlet (Wednesday)','Compelling Book (Thursday)','Mana Essence (Friday)','Golden Chalice (Saturday)'][k.favorite]}"
  if str.gsub(';;;;;',"\n#{str2}").length>=1900 && !s2s
    str=str.gsub(';;;;;',"\n~~The description makes this data too long.  Please try again in PM.~~")
  else
    str=str.gsub(';;;;;',"\n#{str2}")
  end
  str=str["\n".length,str.length-"\n".length] if str[0,"\n".length]=="\n"
  str=str["\n".length,str.length-"\n".length] if str[0,"\n".length]=="\n"
  ftr=k.footer
  f=nil
  if str.length>1900 && safe_to_spam?(event)
    str=str.split("\n\n__**")
    str[-1]="__**#{str[-1]}".split("\n\n**Aura")
    str[0]="#{str[0]}\n\n**Aura#{str[-1][1]}"
    if str.length>2 && "__**#{str[1]}\n\n#{str[2][0]}".length<=1900
      str[2][0]="__**#{str[1]}\n\n#{str[2][0]}"
      str[1]=nil
      str.compact!
    end
    create_embed(event,["__**#{k.name}**__",title],str[0],k.disp_color,nil,k.thumbnail)
    create_embed(event,'',"__**#{str[1]}",k.disp_color) if str.length>2
    create_embed(event,'',str[-1][0],k.disp_color,ftr)
  else
    create_embed(event,[hdr,title],str,k.disp_color,ftr,k.thumbnail)
  end
end

def disp_gauntlet_data(bot,event,args=nil,name=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if name.nil?
    k=find_data_ex(:find_enemy,args.join(' '),event)
  else
    k=find_data_ex(:find_enemy,name,event)
  end
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  gaunt=$gauntlets.reject{|q| q.name != k.name}
  xelement=''
  level=0
  for i in 0...args.length
    xelement='Flame' if ['flame','fire','flames','fires'].include?(args[i].downcase) && xelement.length<=0
    xelement='Water' if ['water','waters'].include?(args[i].downcase) && xelement.length<=0
    xelement='Wind' if ['wind','air','winds','airs'].include?(args[i].downcase) && xelement.length<=0
    xelement='Wind' if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920 && xelement.length<=0
    xelement='Light' if ['light','lights'].include?(args[i].downcase) && xelement.length<=0
    xelement='Shadow' if ['shadow','dark','shadows','darks'].include?(args[i].downcase) && xelement.length<=0
  end
  gaunt=gaunt.reject{|q| q.element != xelement} if xelement.length>0
  for i in 0...args.length
    level=args[i].to_i if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<=gaunt.map{|q| q.stage}.max && level<=0
  end
  gaunt=gaunt.reject{|q| q.stage != level} if level>0
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  title=''; str=''; flds=nil
  ftr='For more detailed information, look up a single element/stage combination.'
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{gaunt[0].element.gsub('None','Null')}"}
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{gaunt[0].element.gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Null')}"} if !k.event.nil? && k.event[0,11]=='Fire Emblem'
  title="#{moji[0].mention unless moji.length<=0} **Element:** #{gaunt[0].element}" unless ['High Dragon','Void','Imperial Order'].include?(k.subdata) || gaunt.map{|q| q.element}.uniq.length>1
  title="#{moji[0].mention unless moji.length<=0} **#{gaunt[0].element}**" unless ['High Dragon','Void','Imperial Order'].include?(k.subdata) || gaunt.map{|q| q.element}.uniq.length>1 || s2s
  if gaunt.map{|q| q.element}.uniq.length<2 && gaunt.map{|q| q.stage}.uniq.length<2 && !s2s
    title="#{title}   Stage **#{gaunt[0].stage}**" unless gaunt.map{|q| q.stage}.uniq.length>1
  else
    title="#{title}\n**Stage:** #{gaunt[0].stage}" unless gaunt.map{|q| q.stage}.uniq.length>1
  end
  title=title.gsub("\n",'') if title[0,"\n".length]=="\n"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{k.tribe}"}
  if !k.event.nil? && k.event[0,11]=='Fire Emblem'
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Icon_Move_Infantry"}
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Icon_Move_Armor"} if !k.name.include?('(Enemy)')
  end
  title="#{title}#{"\n **Tribe:**" if s2s && title.length>0}#{'  ' unless s2s || title.length<=0}#{moji[0].mention unless moji.length<=0} #{k.tribe}"
  lng=title.length
  if title.length>250
    h=title.split("\n")
    title=[h[0],'']
    j=0
    for i in 1...h.length
      if "#{title[j]}\n#{h[i]}".length>250 && j==0
        j+=1
        title[j]="#{h[i]}"
      else
        title[j]="#{title[j]}\n#{h[i]}"
      end
    end
  end
  if !k.event.nil? && !k.isBaby?
    m=$enemies.reject{|q| q.name==k.name || q.event.nil? || q.event != k.event || q.isBaby?}
    str="#{str}#{"\n" if k.stats.length>1 || m.length>0}\n**Event Name:** #{k.event}"
    str="#{str}\n*Other bosses from this event:* #{m.map{|q| "#{q.emotes(bot)}#{q.name}"}.join(', ')}" if m.length>0 && !ignoresub
  end
  str="#{str}\n"
  if gaunt.map{|q| q.element}.uniq.length<2 && gaunt.map{|q| q.stage}.uniq.length<2
    if s2s
      str="#{str}\n#{k.stat_emotes[0]}*Maximum HP*: #{longFormattedNumber(gaunt[0].hp.to_i)}\n#{k.stat_emotes[1]}*#{k.stat_emotes[2]}*: #{longFormattedNumber(gaunt[0].str.to_i)}#{"\n*Reward*: #{gaunt[0].reward}" unless gaunt[0].reward.nil? || gaunt[0].reward.length<=0}"
      flds=[]
      flds.push(['Resistances',gaunt[0].weaknesses.gsub(', ',"\n")]) unless gaunt[0].weaknesses.nil? || gaunt[0].weaknesses.length<=0
      flds.push(['Afflictions',gaunt[0].afflictions.gsub(', ',"\n")]) unless gaunt[0].afflictions.nil? || gaunt[0].afflictions.length<=0
    else
      title="#{title}\n#{k.stat_emotes[0]}*HP*: #{longFormattedNumber(gaunt[0].hp.to_i)}   #{k.stat_emotes[1]}*#{k.stat_emotes[2]}*: #{longFormattedNumber(gaunt[0].str.to_i)}"
      str="#{str}\n*Reward*: #{gaunt[0].reward}" unless gaunt[0].reward.nil? || gaunt[0].reward.length<=0
      str="#{str}\n**Resistances:** #{gaunt[0].weaknesses}"
      str="#{str}\n**Afflictions:** #{gaunt[0].afflictions}"
    end
    ftr=nil
  elsif gaunt.map{|q| q.element}.uniq.length<2
    for i in 0...gaunt.length
      str="#{str}\n*Stage #{gaunt[i].stage}*: #{k.stat_emotes[0]}HP: #{longFormattedNumber(gaunt[i].hp.to_i)}  #{k.stat_emotes[1]}#{k.stat_emotes[2][0,3]}: #{longFormattedNumber(gaunt[i].str.to_i)}#{" - Reward: #{gaunt[i].reward}" unless gaunt[i].reward.nil? || gaunt[i].reward.length<=0}" if [0,19,39,59,79,99,gaunt.length-1].include?(i) || s2s
    end
  elsif gaunt.map{|q| q.stage}.uniq.length<2
    for i in 0...gaunt.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{gaunt[i].element.gsub('None','Null')}"}
      moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{gaunt[i].element.gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Null')}"} if !k.event.nil? && k.event[0,11]=='Fire Emblem'
      str="#{str}\n#{moji[0].mention if moji.length>0}*#{gaunt[i].element}*: #{k.stat_emotes[0]}HP: #{longFormattedNumber(gaunt[i].hp.to_i)}  #{k.stat_emotes[1]}#{k.stat_emotes[2][0,3]}: #{longFormattedNumber(gaunt[i].str.to_i)}#{" - Reward: #{gaunt[i].reward}" unless gaunt[i].reward.nil? || gaunt[i].reward.length<=0}"
    end
  else
    flds=[]
    f=gaunt.map{|q| q.element}.uniq
    for i in 0...f.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{f[i].gsub('None','Null')}"}
      moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{f[i].element.gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Null')}"} if !k.event.nil? && k.event[0,11]=='Fire Emblem'
      f2=gaunt.reject{|q| q.element != f[i]}
      f2=f2.sort{|a,b| a.stage<=>b.stage}
      f3="*Stage #{f2[0].stage}*: #{k.stat_emotes[0]}HP: #{longFormattedNumber(f2[0].hp.to_i)}  #{k.stat_emotes[1]}#{k.stat_emotes[2][0,3]}: #{longFormattedNumber(f2[0].str.to_i)}"
      f3="#{f3}\n*Stage #{f2[-1].stage}*: #{k.stat_emotes[0]}HP: #{longFormattedNumber(f2[-1].hp.to_i)}  #{k.stat_emotes[1]}#{k.stat_emotes[2][0,3]}: #{longFormattedNumber(f2[-1].str.to_i)}#{" - Reward: #{f2[-1].reward}" unless f2[-1].reward.nil? || f2[-1].reward.length<=0}"
      flds.push(["#{moji[0].mention unless moji.length<=0}#{f[i]}",f3])
    end
    lng+=flds.map{|q| "__#{q[0]}__\n#{q[1]}"}.join("\n\n").length
  end
  hdr="__**#{k.name}**__"
  if lng+hdr.length+str.length>1900
    m=[0,str.split("\n\n")]
    for i in 0...m[1].length
      m[1][i]=m[1][i].split("\n") if m[1][i].length>=1900
    end
    m[1]=m[1].flatten
    str=''
    for i in 0...m[1].length
      if "#{str}\n\n#{m[1][i]}".length>=1900
        if m[0]==0
          create_embed(event,[name,title],str,k.disp_color,nil,k.thumbnail)
        else
          create_embed(event,'',str,k.disp_color)
        end
        m[0]+=1
        str="#{m[1][i]}"
      else
        str="#{str}#{"\n" unless !str.split("\n")[-1].nil? && str.split("\n")[-1][0,7]=='*Stage '}\n#{m[1][i]}"
      end
    end
    if m[0]==0
      create_embed(event,[hdr,title],str,k.disp_color,nil,k.thumbnail)
    elsif flds.nil?
      create_embed(event,'',str,k.disp_color,ftr)
    else
      create_embed(event,'',str,k.disp_color)
    end
    create_embed(event,'','',k.disp_color,ftr,nil,flds) unless flds.nil?
  else
    create_embed(event,[hdr,title],str,k.disp_color,ftr,k.thumbnail,flds)
  end
end

# searching functions

def find_in_adventurers(bot,event,args=nil,mode=0,allowstr=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_adventurers(bot,event,sn.split(' '),13,0)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  rar=[]
  elem=[]
  wpn=[]
  clzzz=[]
  fltr=[]
  xtags=[]
  genders=[]
  races=[]
  crossgames=[]
  cygames=[]
  launch=false
  mana=false
  share=false
  lookout=$skilltags.map{|q| q}
  lookout2=lookout.reject{|q| q[2]!='Race'}
  lookout3=lookout.reject{|q| q[2]!='Cygame'}
  lookout4=lookout.reject{|q| q[2]!='Availability' && q[2]!='Availability/Adventurer'}
  lookout=lookout.reject{|q| q[2]!='Askillity'}
  lookout=lookout.reject{|q| ['Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff','Manacaster','Flame','Water','Wind','Light','Shadow','Attack','Defense','Support','Healer'].include?(q[0])}
  for i in 0...args.length
    launch=true if ['launch'].include?(args[i].downcase)
    notlaunch=true if ['notlaunch','nonlaunch'].include?(args[i].downcase)
    mana=true if ['mana','spiral','manaspiral','70','70node','70mc','70ms'].include?(args[i].downcase)
    share=true if ['share','shared','skillshare','shareskill'].include?(args[i].downcase) && allowstr%4<2
    rar.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<$max_rarity.max+1 && allowstr%2==0
    rar.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<$max_rarity.max+1 && allowstr%2==0
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    wpn.push('Sword') if ['sword','swords'].include?(args[i].downcase)
    wpn.push('Blade') if ['blade','blades','sabers','saber','katana','katanas'].include?(args[i].downcase)
    wpn.push('Dagger') if ['dagger','daggers','knife','knifes','knives'].include?(args[i].downcase)
    wpn.push('Axe') if ['axes','axe'].include?(args[i].downcase)
    wpn.push('Bow') if ['bow','bows','arrow','arrows','archer','archers'].include?(args[i].downcase)
    wpn.push('Lance') if ['lance','lances','pitchfork','pitchforks','trident','tridents','spear','spears'].include?(args[i].downcase)
    wpn.push('Wand') if ['wand','wands','rod','rods'].include?(args[i].downcase)
    wpn.push('Staff') if ['staff','staffs','staves'].include?(args[i].downcase)
    wpn.push('Manacaster') if ['manacaster','manacasters','caster','casters','gun','guns','managun','managuns','manchester','manchesters','gunner','gunners'].include?(args[i].downcase)
    clzzz.push('Attack') if ['attack','atk','att','attacking'].include?(args[i].downcase)
    clzzz.push('Defense') if ['defense','defence','def','defending','defensive','defencive'].include?(args[i].downcase)
    clzzz.push('Support') if ['support','supports','supportive','supporting'].include?(args[i].downcase)
    clzzz.push('Healer') if ['heal','healing','heals','healer','healers'].include?(args[i].downcase)
    fltr.push('Gala') if ['gala','galadragalia'].include?(args[i].downcase)
    fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
    fltr.push('NonLimited') if ['summon','summons','summonable','summonables','nonlimited','non-limited'].include?(args[i].downcase)
    fltr.push('Limited') if ['limited','limit'].include?(args[i].downcase)
    fltr.push('Collab') if ['collab','collaboration','collabs','crossover','collaborations','crossovers'].include?(args[i].downcase)
    for i2 in 0...lookout4.length
      fltr.push(lookout4[i2][0]) if lookout4[i2][1].include?(args[i].downcase)
    end
    crossgames.push('FEH') if ['feh','fe'].include?(args[i].downcase)
    crossgames.push('MM') if ['megaman','rockman','mega'].include?(args[i].downcase)
    crossgames.push('MH') if ['monster','hunter','monsterhunter','monhun'].include?(args[i].downcase)
    crossgames.push('PC') if ['princessconnect','princess_connect','pcrd','redive','re_dive','re:dive','priconne'].include?(args[i].downcase)
    crossgames.push('P5S') if ['persona5','p5','strikers','p5s','scramble','persona5scramble','persona5strikers'].include?(args[i].downcase)
    genders.push('M') if ['male','boy','m','males','boys','man'].include?(args[i].downcase)
    genders.push('F') if ['female','woman','girl','f','females','women','girls'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      xtags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i].downcase)
    end
    for i2 in 0...lookout2.length
      races.push(lookout2[i2][0]) if lookout2[i2][1].include?(args[i].downcase)
    end
    for i2 in 0...lookout3.length
      cygames.push(lookout3[i2][0]) if lookout3[i2][1].include?(args[i].downcase)
    end
    xtags.push('StrengthSkill') if ['strength','str'].include?(args[i].downcase) && allowstr>1
  end
  groups=$groups.reject{|q| !has_any?(q.aliases,args.map{|q2| q2.downcase})}
  textra=''
  rar.uniq!
  elem.uniq!
  wpn.uniq!
  clzzz.uniq!
  xtags.uniq!
  xtags=xtags.reject{|q| q=='SP'} if allowstr%4>1
  genders.uniq!
  races.uniq!
  cygames.uniq!
  char=$adventurers.map{|q| q.clone}
  search=[]
  emo=[]
  if rar.length>0
    char=char.reject{|q| !rar.include?(q.rarity)}.uniq
    search.push("*Rarities*: #{rar.map{|q| "#{q}#{$rarity_stars[0][q]}"}.join(', ')}")
    emo.push($rarity_stars[0][rar[0]]) if rar.length<2
  end
  if elem.length>0
    char=char.reject{|q| !elem.include?(q.element)}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if wpn.length>0
    char=char.reject{|q| !wpn.include?(q.weapon)}.uniq
    for i in 0...wpn.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[i]}"}
      emo.push(moji[0].mention) if wpn.length<2 && moji.length>0
      wpn[i]="#{moji[0].mention}#{wpn[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn.join(', ')}")
  end
  if clzzz.length>0
    char=char.reject{|q| !clzzz.include?(q.clzz)}.uniq
    for i in 0...clzzz.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{clzzz[i].gsub('Healer','Healing')}"}
      emo.push(moji[0].mention) if clzzz.length<2 && moji.length>0
      clzzz[i]="#{moji[0].mention}#{clzzz[i]}" if moji.length>0
    end
    search.push("*Classes*: #{clzzz.join(', ')}")
  end
  if launch
    search.push('*Game Launch*')
    b=$banners[0]
    char=char.reject{|q| !b.advs.include?(q[0])}
  end
  if groups.length>0
    char=char.reject{|q| !groups.map{|q2| q2.adventurer_list}.flatten.map{|q| q.name}.include?(q.name)}.uniq
    search.push("*Groups*: #{groups.map{|q| q.fullName}.join(', ')}")
  end
  if mana
    search.push('*<:Rarity_Mana:706612079783575607>Mana Spiral*')
    char=char.reject{|q| !q.hasManaSpiral?}
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Seasonal')
      m.push('s')
      m.push('f')
      emo.push('(s)') if fltr.length<2
    end
    if fltr.include?('NonLimited')
      m.push('f')
      emo.push('(p)') if fltr.length<2
    end
    if fltr.include?('Collab')
      m.push('c')
      emo.push('(c)') if fltr.length<2
    end
    for i2 in 0...lookout4.length
      if fltr.include?(lookout4[i2][0])
        m.push(lookout4[i2][3])
        if fltr.length<2
        elsif lookout4[i2][4].nil?
          emo.push("(#{lookout[i2][3]})")
        elsif lookout4[i2][4].include?('<')
          emo.push(lookout[i2][4])
        else
          emo.push("(#{lookout[i2][4]})")
        end
      end
    end
    search.push("*Filters*: #{fltr.join(', ')}")
    if fltr.include?('Limited')
      m.push('c')
      m.push('s')
      m.push('z')
      emo.push('(L)') if fltr.length<2
      fltr.push('PseudoCollab')
    end
    emo.push('(g)') if fltr.length<2 && fltr.include?('Gala')
    char=char.reject{|q| !has_any?(m,q.availability) && !(fltr.include?('NonLimited') && !q.availability.nil? && q.availability.length>0) && !(fltr.include?('Collab') && !q.games.nil? && q.games.length>0) && !(fltr.include?('PseudoCollab') && !q.availability?('u') && !q.games.nil? && q.games.length>0) && !(fltr.include?('Gala') && q.name[0,5]=='Gala ')}.uniq
  end
  if genders.length>0
    char=char.reject{|q| !genders.include?(q.gender)}.uniq
    for i in 0...genders.length
      genders[i]='Male' if genders[i]=='M'
      genders[i]='Female' if genders[i]=='F'
      genders[i]='Genderless' if genders[i]=='G'
    end
    search.push("*Genders*: #{genders.join(', ')}")
  end
  if races.length>0
    char=char.reject{|q| !races.include?(q.race)}.uniq
    textra="#{textra}\n\nThis is showing adventurers from the Human race.\nFor enemies from the Human tribe, try `DL!find boss human`." if races.include?('Human')
    search.push("*Races*: #{races.join(', ')}")
  end
  if cygames.length>0
    char=char.reject{|q| !cygames.map{|q2| q2[0]}.include?(q.cygame)}.uniq
    search.push("*Cygames Origin*: #{cygames.map{|q2| q2[1]}.join(', ')}")
  end
  if crossgames.length>0
    char=char.reject{|q| q.games.nil? || !has_any?(crossgames,q.games)}.uniq
    for i in 0...crossgames.length
      crossgames[i]='<:Great_Badge_Golden:443704781068959744>Fire Emblem Heroes' if crossgames[i]=='FEH'
      crossgames[i]='<:Bond:613804021119189012>Fate/Grand Order' if crossgames[i]=='FGO'
      crossgames[i]='<:Mega_Man:641484836304846857>Mega Man' if crossgames[i]=='MM'
      crossgames[i]='<:MH_Rathalos:669319247670804506>Monster Hunter' if crossgames[i]=='MH'
      crossgames[i]='<:Priconne:782554046887493652>Princess Connect Re:Dive' if crossgames[i]=='PC'
      crossgames[i]='<:Take_Your_Heart:782553893204262923>Persona 5 Strikers' if crossgames[i]=='P5S'
    end
    search.push("*Crossover Specifics*: #{crossgames.join(', ')}")
  end
  if xtags.length>0 || allowstr%4>1 || share
    if xtags.include?('Punisher') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$punishments.length
        if xtags.include?($punishments[i][0]) && !xtags.include?($punishments[i][1])
          xtags.push("#{$punishments[i][1]}")
          tags2.push("#{$punishments[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those xtags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Punisher tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Punisher tag, remove #{mm}.\nTo search for just #{mm}, remove the Punisher tag."
      end
    end
    if xtags.include?('Cleanse') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$cleaning.length
        if xtags.include?($cleaning[i][0]) && !xtags.include?($cleaning[i][1])
          xtags.push("#{$cleaning[i][1]}")
          tags2.push("#{$cleaning[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Cleanse'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Cleanse tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Cleanse tag, remove #{mm}.\nTo search for just #{mm}, remove the Cleanse tag."
      end
    end
    search.push("<:SkillShare:714597012733034547>*Adventurers with Shareable Skills*") if share
    search.push("*Skill/Ability Tags*: #{xtags.join(', ')}") unless xtags.length<=0
    sklz=$skills.map{|q| q}
    abilz=$abilities.map{|q| q}
    for i in 0...char.length
      skl1=(sklz.find_index{|q| q.name==char[i].skills[0]} rescue nil)
      skl1=sklz[skl1] unless skl1.nil?
      skl2=(sklz.find_index{|q| q.name==char[i].skills[1]} rescue nil)
      skl2=sklz[skl2] unless skl2.nil?
      if allowstr%4<2
        coab=(abilz.find_index{|q| q.type=='CoAbility' && q.name==char[i].coability.split(' ')[0,char[i].coability.split(' ').length-1].join(' ')} rescue nil)
        coab=abilz[coab] unless coab.nil?
        cha=(abilz.find_index{|q| q.type=='Chain' && q.name==char[i].chain.split(' ')[0,char[i].chain.split(' ').length-1].join(' ')} rescue nil)
        cha=abilz[cha] unless cha.nil?
        ab1=(abilz.find_index{|q| q.type=='Ability' && q.fullName==char[i].abilities[0][-1]} rescue nil)
        ab1=abilz[ab1] unless ab1.nil?
        ab2=(abilz.find_index{|q| q.type=='Ability' && q.fullName==char[i].abilities[1][-1]} rescue nil)
        ab2=abilz[ab2] unless ab2.nil?
        ab3=(abilz.find_index{|q| q.type=='Ability' && q.fullName==char[i].abilities[2][-1]} rescue nil)
        ab3=abilz[ab3] unless ab3.nil?
      else
        coab=nil
        cha=nil
        ab1=nil
        ab2=nil
        ab3=nil
        skl1=nil unless !skl1.nil? && !skl1.sharing.nil? && skl1.sharing.length>0 && skl1.sharing.max>0
        skl2=nil unless !skl2.nil? && !skl2.sharing.nil? && skl2.sharing.length>0 && skl2.sharing.max>0
      end
      char[i].sort_data="#{skl1.tags.join("\n") unless skl1.nil?}\n#{skl2.tags.join("\n") unless skl2.nil?}\n#{coab.tags.join("\n") unless coab.nil?}\n#{cha.tags.join("\n") unless cha.nil?}\n#{ab1.tags.join("\n") unless ab1.nil?}\n#{ab2.tags.join("\n") unless ab2.nil?}\n#{ab3.tags.join("\n") unless ab3.nil?}".split("\n")
      char[i].sort_data='~~reject me~~' if share && (skl1.nil? || skl1.sharing.nil? || skl1.sharing.length<=0 || skl1.sharing.max<=0) && (skl2.nil? || skl2.sharing.nil? || skl2.sharing.length<=0 || skl2.sharing.max<=0)
      if (args.include?('any') || xtags.length==1) && xtags.length>0
        x=[[],[],[],[]]
        x[0].push('1') if !skl1.nil? && has_any?(xtags,skl1.tags)
        x[0].push('2') if !skl2.nil? && has_any?(xtags,skl2.tags)
        x[1].push('o') if !coab.nil? && has_any?(xtags,coab.tags)
        x[2].push('o') if !cha.nil? && has_any?(xtags,cha.tags)
        x[3].push('1') if !ab1.nil? && has_any?(xtags,ab1.tags)
        x[3].push('2') if !ab2.nil? && has_any?(xtags,ab2.tags)
        x[3].push('3') if !ab3.nil? && has_any?(xtags,ab3.tags)
        x[0]="S#{x[0].join('/')}" if x[0].length>0
        x[1]='Co' if x[1].length>0
        x[2]='Ch' if x[2].length>0
        x[3]="A#{x[3].join('/')}" if x[3].length>0
        x=x.reject{|q| q.length<=0}
        x.compact!
        char[i].name="#{char[i].name} *[#{x.join('+')}]*" if x.length>0
      elsif share || allowstr%4>1
        x=[]
        x.push('1') unless skl1.nil? || skl1.sharing.nil? || skl1.sharing.length<=0 || skl1.sharing.max<=0
        x.push('2') unless skl2.nil? || skl2.sharing.nil? || skl2.sharing.length<=0 || skl2.sharing.max<=0
        char[i].name="#{char[i].name} *[S#{x.join('/')}]*" if x.length>0
      end
    end
    char=char.reject{|q| q.sort_data=='~~reject me~~'}
    if xtags.length<=0
    elsif args.include?('any')
      search[-1]="#{search[-1]}\n(searching for adventurers with any listed tag in their skills and abilities)" if xtags.length>1
      char=char.reject{|q| !has_any?(xtags,q.sort_data)}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for adventurers with all listed tags in their skills and abilities)" if xtags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for adventurers with all listed tags.\nTo search for adventurers with any of the listed tags, perform the search again with the word \"any\" in your message." if xtags.length>1
      for i in 0...xtags.length
        char=char.reject{|q| !q.sort_data.include?(xtags[i])}.uniq
      end
    end
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[1].map{|q| q.name}.include?(q.name.split(' *[')[0])}
  end
  unless mode==13
    for i in 0...char.length
      unless char[i].availability.nil? || char[i].availability.length<=0
        char[i].name="~~#{char[i].name}~~" if char[i].availability.include?('-') && char[i].name.include?('*')
        char[i].name="*#{char[i].name}*" if char[i].availability.include?('-') && !char[i].name.include?('*')
      end
      char[i].name="*#{char[i].name}*" if char[i].name=='Puppy'
    end
  end
  if (char.length>50 || char.map{|q| q.name}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_in_dragons(bot,event,args=nil,mode=0,allowstr=true)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_dragons(bot,event,sn.split(' '),13,allowstr)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  t=Time.now
  timeshift=7
  timeshift-=1 unless t.dst?
  t-=60*60*timeshift
  rar=[]
  elem=[]
  fltr=[]
  wday=[]
  wpn=[]
  turn=[]
  ranged=[]
  xtags=[]
  genders=[]
  cygames=[]
  crossgames=[]
  races=[]
  launch=false
  ess=false
  lookout=$skilltags.map{|q| q}
  lookout2=lookout.reject{|q| q[2]!='Cygame'}
  lookout4=lookout.reject{|q| q[2]!='Availability' && q[2]!='Availability/Dragon'}
  lookout5=lookout.reject{|q| q[2]!='Race'}
  lookout=lookout.reject{|q| q[2]!='Askillity'}
  lookout=lookout.reject{|q| ['Flame','Water','Wind','Light','Shadow'].include?(q[0])}
  groups=$groups.reject{|q| !has_any?(q.aliases,args.map{|q2| q2.downcase})}
  for i in 0...args.length
    launch=true if ['launch'].include?(args[i].downcase)
    notlaunch=true if ['notlaunch','nonlaunch'].include?(args[i].downcase)
    ess=true if ['essence','essance','freemerge','essences','essances','freemerges'].include?(args[i].downcase)
    rar.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<$max_rarity.max+1
    rar.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<$max_rarity.max+1
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    wpn.push('Sword') if ['sword','swords'].include?(args[i].downcase)
    wpn.push('Blade') if ['blade','blades','sabers','saber','katana','katanas'].include?(args[i].downcase)
    wpn.push('Dagger') if ['dagger','daggers','knife','knifes','knives'].include?(args[i].downcase)
    wpn.push('Axe') if ['axes','axe'].include?(args[i].downcase)
    wpn.push('Bow') if ['bow','bows','arrow','arrows','archer','archers'].include?(args[i].downcase)
    wpn.push('Lance') if ['lance','lances','pitchfork','pitchforks','trident','tridents','spear','spears'].include?(args[i].downcase)
    wpn.push('Wand') if ['wand','wands','rod','rods'].include?(args[i].downcase)
    wpn.push('Staff') if ['staff','staffs','staves'].include?(args[i].downcase)
    wpn.push('Manacaster') if ['manacaster','manacasters','caster','casters','gun','guns','managun','managuns','manchester','manchesters','gunner','gunners'].include?(args[i].downcase)
    wpn.push('Share') if ['share','shared','skillshare','shareskill'].include?(args[i].downcase)
    wday.push(1) if ['mo','monday','mondae','mon','m','juicymeat','meat'].include?(args[i].downcase)
    wday.push(2) if ['tu','tuesday','tuesdae','tues','tue','t','kaleidoscope','kscope','k-scope'].include?(args[i].downcase)
    wday.push(3) if ['we','wednesday','wednesdae','wednes','wed','w','floralcirclet','flower','floral','circlet','circle'].include?(args[i].downcase)
    wday.push(4) if ['th','thursday','thursdae','thurs','thu','thur','h','r','compellingbook','book'].include?(args[i].downcase)
    wday.push(5) if ['fr','friday','fridae','fri','fryday','frydae','fry','f','manaessence','manaessance','mana'].include?(args[i].downcase)
    wday.push(t.wday) if ['today','now'].include?(args[i].downcase)
    turn.push('Yes') if ['turn','damagedirection'].include?(args[i].downcase)
    turn.push('No') if ['noturn','anchor'].include?(args[i].downcase)
    ranged.push('Yes') if ['long','longrange','ranged'].include?(args[i].downcase)
    ranged.push('no') if ['short','shortrange','melee'].include?(args[i].downcase)
    fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
    fltr.push('Gala') if ['gala','galadragalia'].include?(args[i].downcase)
    fltr.push('NonLimited') if ['summon','summons','summonable','summonables','nonlimited','non-limited'].include?(args[i].downcase)
    fltr.push('Limited') if ['limited','limit'].include?(args[i].downcase)
    fltr.push('Collab') if ['collab','collaboration','collabs','crossover','collaborations','crossovers'].include?(args[i].downcase)
    for i2 in 0...lookout4.length
      fltr.push(lookout4[i2][0]) if lookout4[i2][1].include?(args[i].downcase)
    end
    crossgames.push('FEH') if ['feh','fe'].include?(args[i].downcase)
    crossgames.push('MM') if ['megaman','rockman','mega'].include?(args[i].downcase)
    crossgames.push('MH') if ['monster','hunter','monsterhunter','monhun'].include?(args[i].downcase)
    crossgames.push('PC') if ['princessconnect','princess_connect','pcrd','redive','re_dive','re:dive','priconne'].include?(args[i].downcase)
    crossgames.push('P5S') if ['persona5','p5','strikers','p5s','scramble','persona5scramble','persona5strikers'].include?(args[i].downcase)
    genders.push('M') if ['male','boy','m','males','boys','man'].include?(args[i].downcase)
    genders.push('F') if ['female','woman','girl'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      xtags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i].downcase)
    end
    for i2 in 0...lookout5.length
      races.push(lookout5[i2][0]) if lookout5[i2][1].include?(args[i].downcase)
    end
    races.push('Spiralian') if ['mana','spiral','manaspiral','70','70node','70mc','70ms'].include?(args[i].downcase)
    for i2 in 0...lookout2.length
      cygames.push(lookout2[i2][0]) if lookout2[i2][1].include?(args[i].downcase)
    end
    xtags.push('StrengthSkill') if ['strength','str'].include?(args[i].downcase) && allowstr
  end
  textra=''
  rar.uniq!
  elem.uniq!
  wpn.uniq!
  wday.uniq!
  turn.uniq!
  ranged.uniq!
  races.uniq!
  fltr.uniq!
  xtags.uniq!
  cygames.uniq!
  char=$dragons.reject{|q| q.name=='Puppy'}.map{|q| q.clone}
  search=[]
  emo=[]
  if rar.length>0
    char=char.reject{|q| !rar.include?(q.rarity)}.uniq
    search.push("*Rarities*: #{rar.map{|q| "#{q}#{$rarity_stars[0][q]}"}.join(', ')}")
    emo.push($rarity_stars[0][rar[0]]) if rar.length<2
  end
  if elem.length>0
    char=char.reject{|q| !elem.include?(q.element)}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  char=[] if wpn.length>0 && mode>1
  if launch
    search.push('*Game Launch*')
    b=$banners[0]
    char=char.reject{|q| !b.drgs.include?(q.name)}
  end
  if groups.length>0
    char=char.reject{|q| !groups.map{|q2| q2.dragon_list}.flatten.map{|q| q.name}.include?(q.name)}.uniq
    search.push("*Groups*: #{groups.map{|q| q.fullName}.join(', ')}")
  end
  if ess
    search.push('*Essence Dragons*')
    char=char.reject{|q| q.essence.nil? || !q.essence}
  end
  if wday.length>0
    char=char.reject{|q| !wday.include?(q.favorite)}.uniq
    wday=wday.map{|q| ['Golden Chalice (Sunday)','Juicy Meat (Monday)','Kaleidoscope (Tuesday)','Floral Circlet (Wednesday)','Compelling Book (Thursday)','Mana Essence (Friday)','Golden Chalice (Saturday)'][q]}
    search.push("*Bond gift preference*: #{wday.join(', ')}")
  end
  if turn.length==1
    char=char.reject{|q| !turn.include?(q.dmg_turn)}.uniq
    for i in 0...turn.length
      turn[i]='Turned to damage direction' if turn[i]=='Yes'
      turn[i]='Not turned to damage direction' if turn[i]=='No'
    end
    search.push("*Turn data*: #{turn.join(', ')}")
  end
  if ranged.length==1
    char=char.reject{|q| !ranged.include?(q.longrange)}.uniq
    for i in 0...ranged.length
      ranged[i]='Long' if ranged[i]=='Yes'
      ranged[i]='Short' if ranged[i]=='No'
    end
    search.push("*Range*: #{ranged.join(', ')}")
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Seasonal')
      m.push('s')
      m.push('f')
      emo.push('(s)') if fltr.length<2
    end
    if fltr.include?('NonLimited')
      m.push('f')
      emo.push('(p)') if fltr.length<2
    end
    if fltr.include?('Collab')
      m.push('c')
      emo.push('(c)') if fltr.length<2
    end
    for i2 in 0...lookout4.length
      if fltr.include?(lookout4[i2][0])
        m.push(lookout4[i2][3])
        if fltr.length<2
        elsif lookout4[i2][4].nil?
          emo.push("(#{lookout[i2][3]})")
        elsif lookout4[i2][4].include?('<')
          emo.push(lookout[i2][4])
        else
          emo.push("(#{lookout[i2][4]})")
        end
      end
    end
    search.push("*Filters*: #{fltr.join(', ')}")
    if fltr.include?('Limited')
      m.push('c')
      m.push('s')
      m.push('z')
      emo.push('(L)') if fltr.length<2
      fltr.push('PseudoCollab')
    end
    emo.push('(g)') if fltr.length<2 && fltr.include?('Gala')
    char=char.reject{|q| !has_any?(m,q.availability) && !(fltr.include?('NonLimited') && !q.availability.nil? && q.availability.length>0) && !(fltr.include?('Collab') && !q.games.nil? && q.games.length>0) && !(fltr.include?('PseudoCollab') && !q.availability?('u') && !q.games.nil? && q.games.length>0) && !(fltr.include?('Gala') && q.name[0,5]=='Gala ')}.uniq
  end
  if genders.length>0
    char=char.reject{|q| !genders.include?(q.gender)}.uniq
    for i in 0...genders.length
      genders[i]='Male' if genders[i]=='M'
      genders[i]='Female' if genders[i]=='F'
      genders[i]='Genderless' if genders[i]=='G'
    end
    search.push("*Genders*: #{genders.join(', ')}")
  end
  if cygames.length>0
    char=char.reject{|q| !cygames.map{|q2| q2[0]}.include?(q.cygame)}.uniq
    search.push("*Cygames Origin*: #{cygames.map{|q2| q2[1]}.join(', ')}")
  end
  if crossgames.length>0
    char=char.reject{|q| q.games.nil? || !has_any?(crossgames,q.games)}.uniq
    for i in 0...crossgames.length
      crossgames[i]='<:Great_Badge_Golden:443704781068959744>Fire Emblem Heroes' if crossgames[i]=='FEH'
      crossgames[i]='<:Bond:613804021119189012>Fate/Grand Order' if crossgames[i]=='FGO'
      crossgames[i]='<:Mega_Man:641484836304846857>Mega Man' if crossgames[i]=='MM'
      crossgames[i]='<:MH_Rathalos:669319247670804506>Monster Hunter' if crossgames[i]=='MH'
      crossgames[i]='<:Priconne:782554046887493652>Princess Connect Re:Dive' if crossgames[i]=='PC'
      crossgames[i]='<:Take_Your_Heart:782553893204262923>Persona 5 Strikers' if crossgames[i]=='P5S'
    end
    search.push("*Crossover Specifics*: #{crossgames.join(', ')}")
  end
  if xtags.length>0
    if xtags.include?('Punisher') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$punishments.length
        if xtags.include?($punishments[i][0]) && !xtags.include?($punishments[i][1])
          xtags.push("#{$punishments[i][1]}")
          tags2.push("#{$punishments[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Punisher tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Punisher tag, remove #{mm}.\nTo search for just #{mm}, remove the Punisher tag."
      end
    end
    if xtags.include?('Cleanse') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$cleaning.length
        if xtags.include?($cleaning[i][0]) && !xtags.include?($cleaning[i][1])
          xtags.push("#{$cleaning[i][1]}")
          tags2.push("#{$cleaning[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Cleanse'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Cleanse tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Cleanse tag, remove #{mm}.\nTo search for just #{mm}, remove the Cleanse tag."
      end
    end
    search.push("*Skill/Ability Tags*: #{xtags.join(', ')}")
    sklz=$skills.map{|q| q}
    abilz=$abilities.map{|q| q}
    for i in 0...char.length
      skl1=(sklz.find_index{|q| q.name==char[i].skills[0]} rescue nil)
      skl1=sklz[skl1] unless skl1.nil?
      skl2=(sklz.find_index{|q| q.name==char[i].skills[1]} rescue nil)
      skl2=sklz[skl2] unless skl2.nil?
      ab1=nil
      ab1=sklz.find_index{|q| ['Ability','Aura'].include?(q.type) && q.fullName==char[i].auras[0][-1]} unless char[i].auras.length<1
      ab1=sklz[ab1] unless ab1.nil?
      ab2=nil
      ab2=sklz.find_index{|q| ['Ability','Aura'].include?(q.type) && q.fullName==char[i].auras[1][-1]} unless char[i].auras.length<2
      ab2=sklz[ab2] unless ab2.nil?
      ab3=nil
      ab3=sklz.find_index{|q| ['Ability','Aura'].include?(q.type) && q.fullName==char[i].auras[2][-1]} unless char[i].auras.length<3
      ab3=sklz[ab3] unless ab3.nil?
      if args.include?('any') || xtags.length<=1
        x=[[],[],[]]
        x[0].push('1') if !skl1.nil? && has_any?(xtags,skl1.tags)
        x[0].push('2') if !skl2.nil? && has_any?(xtags,skl2.tags)
        x[2].push('1') if !ab1.nil? && has_any?(xtags,ab1.tags)
        x[2].push('2') if !ab2.nil? && has_any?(xtags,ab2.tags)
        x[2].push('3') if !ab3.nil? && has_any?(xtags,ab3.tags)
        x[0]="S" if x[0].length>0 && skl2.nil?
        x[0]="S#{x[0].join('/')}" if x[0].length>0 && !skl2.nil?
        x[1]='Co' if x[1].length>0
        x[2]="A#{x[2].join('/')}" if x[2].length>0
        x=x.reject{|q| q.length<=0}
        x.compact!
        char[i][0]="#{char[i][0]} *[#{x.join('+')}]*" if x.length>0
      end
      char[i].sort_data="#{skl1.tags.join("\n") unless skl1.nil?}\n#{skl2.tags.join("\n") unless skl2.nil?}\n#{ab1.tags.join("\n") unless ab1.nil?}\n#{ab2.tags.join("\n") unless ab2.nil?}\n#{ab3.tags.join("\n") unless ab3.nil?}".split("\n")
    end
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for dragons with any listed tag in their skills and abilities)" if xtags.length>1
      char=char.reject{|q| !has_any?(xtags,q.sort_data)}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for dragons with all listed tags in their skills and abilities)" if xtags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for dragons with all listed tags.\nTo search for dragons with any of the listed tags, perform the search again with the word \"any\" in your message." if xtags.length>1
      for i in 0...xtags.length
        char=char.reject{|q| !q.sort_data.include?(xtags[i])}.uniq
      end
    end
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[1].map{|q| q.name}.include?(q.name.split(' *[')[0])}
  end
  return nil if races.length>0 && search.length<=0 && mode%4>1
  if (char.length>50 || char.map{|q| q.name}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_in_wyrmprints(bot,event,args=nil,mode=0,allowstr=true)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_wyrmprints(bot,event,sn.split(' '),13,allowstr)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  rar=[]
  affinities=[]
  clzz=[]
  fltr=[]
  crossgames=[]
  launch=false
  notlaunch=false
  xtags=[]
  lookout=$skilltags.map{|q| q}
  lookout4=lookout.reject{|q| q[2]!='Availability' && q[2]!='Availability/Wyrmprint'}
  lookout=lookout.reject{|q| q[2]!='Askillity'}
  lookout=lookout.reject{|q| ['Attack','Defense','Support','Healer'].include?(q[0])}
  groups=$groups.reject{|q| !has_any?(q.aliases,args.map{|q2| q2.downcase})}
  ign=false
  for i in 0...args.length
    launch=true if ['launch'].include?(args[i].downcase)
    notlaunch=true if ['notlaunch','nonlaunch'].include?(args[i].downcase)
    ign=true if ['share','shared','skillshare','shareskill'].include?(args[i].downcase)
    rar.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<$max_rarity.max+1
    rar.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<$max_rarity.max+1
    rar.push('x') if ['x'].include?(args[i].downcase)
    affinities.push('Crown') if ['queen','crown','queens','crowns','crowned'].include?(args[i].downcase)
    affinities.push('Axe') if ['hatchet','axs','axes','hatchets','ax','axe'].include?(args[i].downcase)
    affinities.push('Sword') if ['duel','dual','swords','sword'].include?(args[i].downcase)
    affinities.push('Bow') if ['barrage','arrows','bows','bow'].include?(args[i].downcase)
    affinities.push('Dragon') if ['draco','dragon','draco','dragons','draconic'].include?(args[i].downcase)
    affinities.push('Lance') if ['trident','tridents','fork','forks','aether','lance','lances','spear','spears'].include?(args[i].downcase)
    affinities.push('Eagle') if ['phoenix','pheonix','wright','eagle','eagles','bird','birds','phoenixes','pheonixes','phoenixs','pheonixs'].include?(args[i].downcase)
    affinities.push('Wolf') if ['wolf','wolfs','wolves','unicorn','unicorns'].include?(args[i].downcase)
    affinities.push('Bull') if ['bull','bulls','cow','cows','minotaur','minotaurs'].include?(args[i].downcase)
    affinities.push('Serpent') if ['serpent','serpents','snake','snakes','snek','sneks','serpentine'].include?(args[i].downcase)
    affinities.push('Staff') if ['divinity','divine','eclipse','eclipse','holy','staff','staffs','staves'].include?(args[i].downcase)
    affinities.push('None') if ['noaffinity','empty','affinityless'].include?(args[i].downcase)
    clzz.push('Attack') if ['attack','atk','att','attacking'].include?(args[i].downcase)
    clzz.push('Defense') if ['defense','defence','def','defending','defensive','defencive'].include?(args[i].downcase)
    clzz.push('Support') if ['support','supports','supportive','supporting'].include?(args[i].downcase)
    clzz.push('Healing') if ['heal','healing','heals','healer','healers'].include?(args[i].downcase)
    fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
    fltr.push('NonLimited') if ['nonlimited','non-limited'].include?(args[i].downcase)
    fltr.push('Limited') if ['limited','limit'].include?(args[i].downcase)
    fltr.push('Collab') if ['collab','collaboration','collabs','crossover','collaborations','crossovers'].include?(args[i].downcase)
    for i2 in 0...lookout4.length
      fltr.push(lookout4[i2][0]) if lookout4[i2][1].include?(args[i].downcase)
    end
    crossgames.push('FEH') if ['feh','fe'].include?(args[i].downcase)
    crossgames.push('MM') if ['megaman','rockman','mega'].include?(args[i].downcase)
    crossgames.push('MH') if ['monster','hunter','monsterhunter','monhun'].include?(args[i].downcase)
    crossgames.push('PC') if ['princessconnect','princess_connect','pcrd','redive','re_dive','re:dive','priconne'].include?(args[i].downcase)
    crossgames.push('P5S') if ['persona5','p5','strikers','p5s','scramble','persona5scramble','persona5strikers'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      xtags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i].downcase)
    end
  end
  textra=''
  rar.uniq!
  affinities.uniq!
  clzz.uniq!
  fltr.uniq!
  xtags.uniq!
  char=$wyrmprints.reject{|q| q.isMultiprint?}.map{|q| q.clone}
  search=[]
  emo=[]
  char=[] if ign
  if rar.length>0
    char=char.reject{|q| !rar.include?(q.rarity) && !(rar.include?('x') && !q.availability.nil? && q.availability.include?('x'))}.uniq
    search.push("*Rarities*: #{rar.map{|q| "#{"#{q}#{$rarity_stars[0][q]}" unless q=='x'}#{'<:Dominion:819854169128435742>' if q=='x'}"}.join(', ')}")
    if rar.length==1
      if rar[0]=='x'
        emo.push('<:Dominion:819854169128435742>')
      else
        emo.push($rarity_stars[0][rar[0]]) if rar.length<2
      end
    end
  end
  if affinities.length>0
    aff=['Crown','Axe','Sword','Bow','Dragon','Lance','Eagle','Wolf','Bull','Serpent','Staff']
    char=char.reject{|q| !affinities.include?(q.affinity) && !(affinities.include?('None') && q.affinity.nil?)}.uniq
    for i in 0...affinities.length
      moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{affinities[i]}"}
      emo.push(moji[0].mention) if affinities.length<2 && moji.length>0
      affinities[i]="#{moji[0].mention}#{affinities[i]}" if moji.length>0
    end
    search.push("*Affinities*: #{affinities.join(', ')}")
  end
  if clzz.length>0
    char=char.reject{|q| !clzz.include?(q.amulet)}.uniq
    for i in 0...clzz.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{clzz[i]}"}
      emo.push(moji[0].mention) if clzz.length<2 && moji.length>0
      clzz[i]="#{moji[0].mention}#{clzz[i]}" if moji.length>0
    end
    search.push("*Amulet Types*: #{clzz.join(', ')}")
  end
  if launch
    search.push('*Game Launch*')
    b=$banners[0]
    char=char.reject{|q| !b.prints.include?(q.name)}
  end
  if groups.length>0
    char=char.reject{|q| !groups.map{|q2| q2.wyrmprint_list}.flatten.map{|q| q.name}.include?(q.name)}.uniq
    search.push("*Groups*: #{groups.map{|q| q.name}.join(', ')}")
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Seasonal')
      m.push('s')
      m.push('f')
      emo.push('(s)') if fltr.length<2
    end
    if fltr.include?('NonLimited')
      m.push('f')
      emo.push('(p)') if fltr.length<2
    end
    if fltr.include?('Collab')
      m.push('c')
      emo.push('(c)') if fltr.length<2
    end
    for i2 in 0...lookout4.length
      if fltr.include?(lookout4[i2][0])
        m.push(lookout4[i2][3])
        if fltr.length<2
        elsif lookout4[i2][4].nil?
          emo.push("(#{lookout[i2][3]})")
        elsif lookout4[i2][4].include?('<')
          emo.push(lookout[i2][4])
        else
          emo.push("(#{lookout[i2][4]})")
        end
      end
    end
    search.push("*Filters*: #{fltr.join(', ')}")
    if fltr.include?('Limited')
      m.push('c')
      m.push('s')
      m.push('z')
      emo.push('(L)') if fltr.length<2
      fltr.push('PseudoCollab')
    end
    char=char.reject{|q| !has_any?(m,q.availability) && !(fltr.include?('Collab') && !q.games.nil? && q.games.length>0)}.uniq
  end
  if crossgames.length>0
    char=char.reject{|q| q.games.nil? || !has_any?(crossgames,q.games)}.uniq
    for i in 0...crossgames.length
      crossgames[i]='<:Great_Badge_Golden:443704781068959744>Fire Emblem Heroes' if crossgames[i]=='FEH'
      crossgames[i]='<:Bond:613804021119189012>Fate/Grand Order' if crossgames[i]=='FGO'
      crossgames[i]='<:Mega_Man:641484836304846857>Mega Man' if crossgames[i]=='MM'
      crossgames[i]='<:MH_Rathalos:669319247670804506>Monster Hunter' if crossgames[i]=='MH'
      crossgames[i]='<:Priconne:782554046887493652>Princess Connect Re:Dive' if crossgames[i]=='PC'
      crossgames[i]='<:Take_Your_Heart:782553893204262923>Persona 5 Strikers' if crossgames[i]=='P5S'
    end
    search.push("*Crossover Specifics*: #{crossgames.join(', ')}")
  end
  if xtags.length>0
    if xtags.include?('Punisher') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$punishments.length
        if xtags.include?($punishments[i][0]) && !xtags.include?($punishments[i][1])
          xtags.push("#{$punishments[i][1]}")
          tags2.push("#{$punishments[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Punisher tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Punisher tag, remove #{mm}.\nTo search for just #{mm}, remove the Punisher tag."
      end
    end
    if xtags.include?('Cleanse') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$cleaning.length
        if xtags.include?($cleaning[i][0]) && !xtags.include?($cleaning[i][1])
          xtags.push("#{$cleaning[i][1]}")
          tags2.push("#{$cleaning[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Cleanse'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Cleanse tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Cleanse tag, remove #{mm}.\nTo search for just #{mm}, remove the Cleanse tag."
      end
    end
    search.push("*Skill/Ability Tags*: #{xtags.join(', ')}")
    sklz=$abilities.map{|q| q}
    for i in 0...char.length
      ab1=nil
      ab1=sklz.find_index{|q| q.type=='Ability' && q.fullName==char[i].abilities[0][-1]} unless char[i].abilities.length<1
      ab1=sklz[ab1] unless ab1.nil?
      ab2=nil
      ab2=sklz.find_index{|q| q.type=='Ability' && q.fullName==char[i].abilities[1][-1]} unless char[i].abilities.length<2
      ab2=sklz[ab2] unless ab2.nil?
      ab3=nil
      ab3=sklz.find_index{|q| q.type=='Ability' && q.fullName==char[i].abilities[2][-1]} unless char[i].abilities.length<3
      ab3=sklz[ab3] unless ab3.nil?
      if args.include?('any') || xtags.length<=1
        x=[[],[],[]]
        x[2].push('1') if !ab1.nil? && has_any?(xtags,ab1.tags)
        x[2].push('2') if !ab2.nil? && has_any?(xtags,ab2.tags)
        x[2].push('3') if !ab3.nil? && has_any?(xtags,ab3.tags)
        x[0]="S" if x[0].length>0
        x[1]='Co' if x[1].length>0
        x[2]="A#{x[2].join('/')}" if x[2].length>0
        x=x.reject{|q| q.length<=0}
        x.compact!
        char[i].name="#{char[i].name} *[#{x.join('+')}]*" if x.length>0
      end
      char[i].sort_data="#{ab1.tags.join("\n") unless ab1.nil?}\n#{ab2.tags.join("\n") unless ab2.nil?}\n#{ab3.tags.join("\n") unless ab3.nil?}".split("\n")
    end
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for wyrmprints with any listed tag in their abilities)" if xtags.length>1
      char=char.reject{|q| !has_any?(xtags,q.sort_data)}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for wyrmprints with all listed tags in their abilities)" if xtags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for wyrmprints with all listed tags.\nTo search for wyrmprints with any of the listed tags, perform the search again with the word \"any\" in your message." if xtags.length>1
      for i in 0...xtags.length
        char=char.reject{|q| !q.sort_data.include?(xtags[i])}.uniq
      end
    end
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[1].map{|q| q.name}.include?(q.name.split(' *[')[0])}
  end
  char=[] if search.length==1 && search[0]=='*Game Launch*' && mode%4>1
  if (char.length>50 || char.map{|q| q.name}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_in_weapons(bot,event,args=nil,mode=0,allowstr=true,juststats=false)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_weapons(bot,event,sn.split(' '),13,allowstr)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  rar=[]
  tier=[]
  rarity_tier=[]
  rarity_tier_2=[]
  elem=[]
  wpn=[]
  fltr=[]
  xtags=[]
  crossgames=[]
  launch=false
  notlaunch=false
  lookout=$skilltags.map{|q| q}
  lookout3=lookout.reject{|q| q[2]!='Availability' && q[2]!='Availability/Weapon'}
  lookout=lookout.reject{|q| q[2]!='Askillity'}
  lookout=lookout.reject{|q| ['Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff','Manacaster','Flame','Water','Wind','Light','Shadow'].include?(q[0])}
  groups=$groups.reject{|q| !has_any?(q.aliases,args.map{|q2| q2.downcase})}
  args2=args.map{|q| q}
  ign=false
  for i in 0...args.length
    launch=true if ['launch'].include?(args[i].downcase)
    notlaunch=true if ['notlaunch','nonlaunch'].include?(args[i].downcase)
    rar.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<$max_rarity.max+1
    rar.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<$max_rarity.max+1
    tier.push(args[i][1,args[i].length-1].to_i) if args[i][0,1].downcase=='t' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0 && args[i][1,args[i].length-1].to_i<4
    tier.push(args[i][4,args[i].length-4].to_i) if ['tier','teir'].include?(args[i][0,4].downcase) && args[i][4,args[i].length-4].to_i.to_s==args[i][4,args[i].length-4] && args[i][4,args[i].length-4].to_i>0 && args[i][4,args[i].length-4].to_i<4
    rarity_tier.push(args[i].downcase) if args[i][1,1]=='t' && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<$max_rarity.max+1 && args[i][2,args[i].length-2].to_i.to_s==args[i][2,args[i].length-2] && args[i][2,args[i].length-2].to_i>0 && args[i][2,args[i].length-2].to_i<4
    rarity_tier_2.push('HDT1') if ['hdt1','hd1'].include?(args[i].downcase)
    rarity_tier_2.push('HDT2') if ['hdt2','hd2'].include?(args[i].downcase)
    rarity_tier_2.push('HDT3') if ['hdt3','hd3'].include?(args[i].downcase)
    rarity_tier_2.push('ChT1') if ['ct1','chm1','cht1'].include?(args[i].downcase)
    rarity_tier_2.push('ChT2') if ['ct2','chm2','cht2'].include?(args[i].downcase)
    rarity_tier_2.push('ChT3') if ['ct3','chm3','cht3'].include?(args[i].downcase)
    rarity_tier_2.push('AGT1') if ['agito1','agt1','at1'].include?(args[i].downcase)
    rarity_tier_2.push('AGT2') if ['agito2','agt2','at2'].include?(args[i].downcase)
    rarity_tier_2.push('AGT3') if ['agito3','agt3','at3'].include?(args[i].downcase)
    ign=true if ['share','shared','skillshare','shareskill'].include?(args[i].downcase)
    if ['flame','fire','flames','fires'].include?(args[i].downcase)
      args2[i]=nil unless elem.include?('Flame')
      elem.push('Flame')
    end
    if ['water','waters'].include?(args[i].downcase)
      args2[i]=nil unless elem.include?('Water')
      elem.push('Water')
    end
    if ['wind','air','winds','airs'].include?(args[i].downcase)
      args2[i]=nil unless elem.include?('Wind')
      elem.push('Wind')
    end
    if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
      args2[i]=nil unless elem.include?('Wind')
      elem.push('Wind')
    end
    if ['light','lights'].include?(args[i].downcase)
      args2[i]=nil unless elem.include?('Light')
      elem.push('Light')
    end
    if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
      args2[i]=nil unless elem.include?('Shadow')
      elem.push('Shadow')
    end
    if ['none','no-element','no_element','noelement','elementless','null','neutral'].include?(args[i].downcase)
      args2[i]=nil unless elem.include?('None')
      elem.push('None')
    end
    if ['sword','swords'].include?(args[i].downcase)
      args2[i]=nil unless wpn.include?('Sword')
      wpn.push('Sword')
    end
    if ['blade','blades','sabers','saber','katana','katanas'].include?(args[i].downcase)
      args2[i]=nil unless wpn.include?('Blade')
      wpn.push('Blade')
    end
    if ['dagger','daggers','knife','knifes','knives'].include?(args[i].downcase)
      args2[i]=nil unless wpn.include?('Dagger')
      wpn.push('Dagger')
    end
    if ['axes','axe'].include?(args[i].downcase)
      args2[i]=nil unless wpn.include?('Axe')
      wpn.push('Axe')
    end
    if ['bow','bows','arrow','arrows','archer','archers'].include?(args[i].downcase)
      args2[i]=nil unless wpn.include?('Bow')
      wpn.push('Bow')
    end
    if ['lance','lances','pitchfork','pitchforks','trident','tridents','spear','spears'].include?(args[i].downcase)
      args2[i]=nil unless wpn.include?('Lance')
      wpn.push('Lance')
    end
    if ['wand','wands','rod','rods'].include?(args[i].downcase)
      args2[i]=nil unless wpn.include?('Wand')
      wpn.push('Wand')
    end
    if ['staff','staffs','staves'].include?(args[i].downcase)
      args2[i]=nil unless wpn.include?('Staff')
      wpn.push('Staff')
    end
    if ['manacaster','manacasters','caster','casters','gun','guns','managun','managuns','manchester','manchesters','gunner','gunners'].include?(args[i].downcase)
      args2[i]=nil unless wpn.include?('Manacaster')
      wpn.push('Manacaster') 
    end
    for i2 in 0...lookout3.length
      if lookout3[i2][1].include?(args[i].downcase)
        args2[i]=nil unless fltr.include?(lookout3[i2][0])
        fltr.push(lookout3[i2][0])
      end
    end
    if ['core','cores'].include?(args[i].downcase)
      args2[i]=nil unless fltr.include?('Core')
      fltr.push('Core')
    end
    unless juststats
      fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
      fltr.push('Limited') if ['limited','limit'].include?(args[i].downcase)
      fltr.push('Collab') if ['collab','collaboration','collabs','crossover','collaborations','crossovers'].include?(args[i].downcase)
      crossgames.push('FEH') if ['feh','fe'].include?(args[i].downcase)
      crossgames.push('MM') if ['megaman','rockman','mega'].include?(args[i].downcase)
      crossgames.push('MH') if ['monster','hunter','monsterhunter','monhun'].include?(args[i].downcase)
      crossgames.push('PC') if ['princessconnect','princess_connect','pcrd','redive','re_dive','re:dive','priconne'].include?(args[i].downcase)
      crossgames.push('P5S') if ['persona5','p5','strikers','p5s','scramble','persona5scramble','persona5strikers'].include?(args[i].downcase)
      for i2 in 0...lookout.length
        xtags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
      end
      xtags.push('StrengthSkill') if ['strength','str'].include?(args[i].downcase) && allowstr
    end
  end
  args2.compact!
  textra=''
  rar.uniq!
  tier.uniq!
  rarity_tier.uniq!
  elem.uniq!
  wpn.uniq!
  fltr.uniq!
  xtags.uniq!
  char=$weapons.map{|q| q.clone}
  search=[]
  emo=[]
  char=[] if ign
  if rar.length>0 || tier.length>0 || rarity_tier.length>0 || rarity_tier_2.length>0
    if rar.length>0
      search.push("*Rarities*: #{rar.map{|q| "#{q}#{$rarity_stars[0][q]}"}.join(', ')}")
      emo.push($rarity_stars[0][rar[0]]) if rar.length==1
    elsif tier.length>0
      rar=[1,2,3,4,5,6]
    end
    if tier.length>0
      search.push("*Crafting Tiers*: #{tier.join(', ')}")
      emo.push("T#{tier[0]}") if tier.length==1
    elsif rar.length>0
      tier=[0,1,2,3]
    end
    search.push("*Combined Rarity/Tiers*: #{rarity_tier.map{|q| "#{q[0,1]}#{$rarity_stars[0][q[0,1].to_i]}-T#{q[2,1]}"}.join(', ') if rarity_tier.length>0}#{', ' if rarity_tier.length>0 && rarity_tier_2.length>0}#{rarity_tier_2.map{|q| "#{'High Dragon' if q[0,3]=='HDT'}#{'Chimeratech' if q[0,3]=='ChT'}#{'Agito' if q[0,3]=='AGT'}-T#{q[3,1]}"}.join(', ')}") if rarity_tier.length>0 || rarity_tier_2.length>0
    for i in 0...rar.length
      for i2 in 0...tier.length
        rarity_tier.push("#{rar[i]}t#{tier[i2]}")
      end
    end
    rarity_tier.uniq!
    char2=[]
    char2=char.reject{|q| !rarity_tier_2.include?("HDT#{q.tier}") || !q.availability.include?('h')}.uniq if rarity_tier_2.length>0
    char3=[]
    char3=char.reject{|q| !rarity_tier_2.include?("ChT#{q.tier}") || !q.availability.include?('m')}.uniq if rarity_tier_2.length>0
    char4=[]
    char4=char.reject{|q| !rarity_tier_2.include?("AGT#{q.tier}") || !q.availability.include?('a')}.uniq if rarity_tier_2.length>0
    char=char.reject{|q| !rarity_tier.include?("#{q.rarity}t#{q.tier}")}.uniq
    char.push(char2)
    char.push(char3)
    char.push(char4)
    char.flatten!
  end
  if wpn.length>0
    char=char.reject{|q| !wpn.include?(q.type)}.uniq
    for i in 0...wpn.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[i]}"}
      emo.push(moji[0].mention) if wpn.length<2 && moji.length>0
      wpn[i]="#{moji[0].mention}#{wpn[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn.join(', ')}")
  end
  if elem.length>0
    char=char.reject{|q| !elem.include?(q.element)}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if launch
    search.push('*Game Launch*')
    char=char.reject{|q| q.id<8 || q.id>211}
  end
  if groups.length>0
    char=char.reject{|q| !groups.map{|q2| q2.weapon_list}.flatten.map{|q| q.name}.include?(q.name)}.uniq
    search.push("*Groups*: #{groups.map{|q| q.name}.join(', ')}")
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Seasonal')
      m.push('s')
      m.push('f')
      emo.push('(s)') if fltr.length<2
    end
    for i2 in 0...lookout3.length
      if fltr.include?(lookout3[i2][0])
        m.push(lookout3[i2][3])
        if fltr.length<2
        elsif lookout3[i2][4].nil?
          emo.push("(#{lookout[i2][3]})")
        elsif lookout3[i2][4].include?('<')
          emo.push(lookout[i2][4])
        else
          emo.push("(#{lookout[i2][4]})")
        end
      end
    end
    if fltr.include?('Collab')
      m.push('c')
      emo.push('(clb)') if fltr.length<2
    end
    if fltr.include?('Former')
      m.push('f')
      emo.push('(f)') if fltr.length<2
    end
    search.push("*Filters*: #{fltr.map{|q| q.gsub('Void','<:Element_Void:548467446734913536> Void')}.join(', ')}")
    if fltr.include?('Limited')
      m.push('c')
      m.push('s')
      m.push('z')
      emo.push('(L)') if fltr.length<2
      fltr.push('PseudoCollab')
    end
    char=char.reject{|q| !has_any?(m,q.availability) && !(fltr.include?('Collab') && !q.games.nil? && q.games.length>0)}.uniq
  end
  if crossgames.length>0
    char=char.reject{|q| q.games.nil? || !has_any?(crossgames,q.games)}.uniq
    for i in 0...crossgames.length
      crossgames[i]='<:Great_Badge_Golden:443704781068959744>Fire Emblem Heroes' if crossgames[i]=='FEH'
      crossgames[i]='<:Bond:613804021119189012>Fate/Grand Order' if crossgames[i]=='FGO'
      crossgames[i]='<:Mega_Man:641484836304846857>Mega Man' if crossgames[i]=='MM'
      crossgames[i]='<:MH_Rathalos:669319247670804506>Monster Hunter' if crossgames[i]=='MH'
      crossgames[i]='<:Priconne:782554046887493652>Princess Connect Re:Dive' if crossgames[i]=='PC'
      crossgames[i]='<:Take_Your_Heart:782553893204262923>Persona 5 Strikers' if crossgames[i]=='P5S'
    end
    search.push("*Crossover Specifics*: #{crossgames.join(', ')}")
  end
  if xtags.length>0
    if xtags.include?('Punisher') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$punishments.length
        if xtags.include?($punishments[i][0]) && !xtags.include?($punishments[i][1])
          xtags.push("#{$punishments[i][1]}")
          tags2.push("#{$punishments[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Punisher tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Punisher tag, remove #{mm}.\nTo search for just #{mm}, remove the Punisher tag."
      end
    end
    if xtags.include?('Cleanse') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$cleaning.length
        if xtags.include?($cleaning[i][0]) && !xtags.include?($cleaning[i][1])
          xtags.push("#{$cleaning[i][1]}")
          tags2.push("#{$cleaning[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Cleanse'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Cleanse tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Cleanse tag, remove #{mm}.\nTo search for just #{mm}, remove the Cleanse tag."
      end
    end
    search.push("*Skill/Ability Tags*: #{xtags.join(', ')}")
    sklz=$skills.map{|q| q}
    abilz=$abilities.map{|q| q}
    for i in 0...char.length
      skl1=(sklz.find_index{|q| q.name==char[i].skills[0]} rescue nil)
      skl1=sklz[skl1] unless skl1.nil?
      ab1=nil
      ab2=nil
      ab3=nil
      unless char[i].abilities.nil?
        ab1=(abilz.find_index{|q| q.type=='Ability' && q.fullName==char[i].abilities[0][-1]} rescue nil)
        ab1=abilz[ab1] unless ab1.nil?
        ab2=(abilz.find_index{|q| q.type=='Ability' && q.fullName==char[i].abilities[1][-1]} rescue nil)
        ab2=abilz[ab2] unless ab2.nil?
        ab3=(abilz.find_index{|q| q.type=='Ability' && q.fullName==char[i].abilities[2][-1]} rescue nil)
        ab3=abilz[ab3] unless ab3.nil?
      end
      if args.include?('any') || xtags.length<=1
        x=[[],[],[]]
        x[0].push('3') if !skl1.nil? && has_any?(xtags,skl1.tags)
        x[2].push('1') if !ab1.nil? && has_any?(xtags,ab1.tags)
        x[2].push('2') if !ab2.nil? && has_any?(xtags,ab2.tags)
        x[2].push('3') if !ab3.nil? && has_any?(xtags,ab3.tags)
        x[0]="S#{x[0].join('/')}" if x[0].length>0
        x[1]='Co' if x[1].length>0
        x[2]="A#{x[2].join('/')}" if x[2].length>0
        x=x.reject{|q| q.length<=0}
        x.compact!
        char[i].name="#{char[i].name} *[#{x.join('+')}]*" if x.length>0
      end
      char[i].sort_data="#{skl1.tags.join("\n") unless skl1.nil?}\n#{ab1.tags.join("\n") unless ab1.nil?}\n#{ab2.tags.join("\n") unless ab2.nil?}\n#{ab3.tags.join("\n") unless ab3.nil?}".split("\n")
    end
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for weapons with any listed tag in their skills and abilities)" if xtags.length>1
      char=char.reject{|q| !has_any?(xtags,q.sort_data)}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for weapons with all listed tags in their skills and abilities)" if xtags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for weapons with all listed tags.\nTo search for weapons with any of the listed tags, perform the search again with the word \"any\" in your message." if xtags.length>1
      for i in 0...xtags.length
        char=char.reject{|q| !q.sort_data.include?(xtags[i])}.uniq
      end
    end
  end
  if !juststats && !find_data_ex(:find_enemy,args.join(' '),event,true).nil? && find_data_ex(:find_enemy,args.join(' '),event,true).name[0,8]!='Mega Man'
    args2=args2.reject{|q| q.to_i.to_s==q || q.gsub('*','').to_i.to_s==q.gsub('*','')}
    k2=find_data_ex(:find_enemy,args.join(' '),event,true)
    unless k2.nil? || k2.length<=0
      search.push("*Uses Mats from:* #{k2.emotes(bot)}#{k2.name}")
      char=char.reject{|q| q.boss_tags.nil? || q.boss_tags !=k2.name}
    end
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[1].map{|q| q.name}.include?(q.name.split(' *[')[0])}
  end
  if juststats
    return nil if char.uniq.length>=$weapons.uniq.length
    return char
  elsif (char.length>50 || char.map{|q| q.name}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_in_enemies(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_enemies(bot,event,sn.split(' '),13)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  elem=[]
  tribes=[]
  for i in 0...args.length
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    elem.push('None') if ['none','no-element','no_element','noelement','elementless'].include?(args[i].downcase)
    tribes.push('Thaumian') if ['thaumian','thaumians'].include?(args[i].downcase)
    tribes.push('Physian') if ['physian','physians','physicians','physician'].include?(args[i].downcase)
    tribes.push('Therion') if ['therion','therions'].include?(args[i].downcase)
    tribes.push('Dragon') if ['dragon','dragons','drgs','drg','draco','dracos','draconic'].include?(args[i].downcase)
    tribes.push('Demon') if ['demon','demons','demonic'].include?(args[i].downcase)
    tribes.push('Demihuman') if ['demihuman','demihumans','halfhuman','halfhumans'].include?(args[i].downcase)
    tribes.push('Human') if ['human','humans','humanoid','humanoids'].include?(args[i].downcase)
    tribes.push('Undead') if ['undead','undeads','zombie','zombies'].include?(args[i].downcase)
  end
  elem.uniq!
  tribes.uniq!
  emo=[]
  search=[]
  char=$enemies.reject{|q| q.name=='Matilda'}.map{|q| q.clone}
  textra=''
  if elem.length>0
    char=char.reject{|q| !elem.include?(q.element)}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if tribes.length>0
    char=char.reject{|q| !tribes.include?(q.tribe)}.uniq
    for i in 0...tribes.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{tribes[i]}"}
      emo.push(moji[0].mention) if tribes.length<2 && moji.length>0
      tribes[i]="#{moji[0].mention}#{tribes[i]}" if moji.length>0
    end
    search.push("*Tribes*: #{tribes.join(', ')}")
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[1].map{|q| q.name}.include?(q.name.split(' *[')[0])}
  end
  if (char.length>50 || char.map{|q| q.name}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,'',textra]
  end
end

def find_in_skills(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_skills(bot,event,sn.split(' '),13)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  elem=[]
  wpn2=[]
  xtags=[]
  lookout=$skilltags.reject{|q| q[2]!='Askillity'}
  for i in 0...args.length
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    elem.push('None') if ['none','no-element','no_element','noelement','elementless'].include?(args[i].downcase)
    wpn2.push('Sword') if ['sword','swords'].include?(args[i].downcase)
    wpn2.push('Blade') if ['blade','blades','sabers','saber','katanas','katana'].include?(args[i].downcase)
    wpn2.push('Dagger') if ['dagger','daggers','knife','knifes','knives'].include?(args[i].downcase)
    wpn2.push('Axe') if ['axes','axe'].include?(args[i].downcase)
    wpn2.push('Bow') if ['bow','bows','arrow','arrows','archer','archers'].include?(args[i].downcase)
    wpn2.push('Lance') if ['lance','lances','pitchfork','pitchforks','trident','tridents','spear','spears'].include?(args[i].downcase)
    wpn2.push('Wand') if ['wand','wands','rod','rods'].include?(args[i].downcase)
    wpn2.push('Staff') if ['staff','staffs','staves'].include?(args[i].downcase)
    wpn2.push('Manacaster') if ['manacaster','manacasters','caster','casters','gun','guns','managun','managuns','manchester','manchesters','gunner','gunners'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      xtags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  elem.uniq!
  wpn2.uniq!
  xtags.uniq!
  emo=[]
  search=[]
  char=$skills.map{|q| q.clone}
  adv=$adventurers.map{|q| q}
  drg=$dragons.map{|q| q}
  wpn=$weapons.map{|q| q}
  textra=''
  if elem.length>0
    for i in 0...char.length
      char[i].sort_data=[]
      m=adv.find_index{|q| q.skills.include?(char[i].name)}
      char[i].sort_data.push(adv[m].element) unless m.nil?
      m=drg.find_index{|q| q.skills.include?(char[i].name)}
      char[i].sort_data.push(drg[m].element) unless m.nil?
      m=wpn.find_index{|q| q.skills.include?(char[i].name)}
      char[i].sort_data.push(wpn[m].element) unless m.nil?
    end
    char=char.reject{|q| !has_any?(elem,q.sort_data)}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if wpn2.length>0
    for i in 0...char.length
      char[i].sort_data=[]
      m=adv.find_index{|q| q.skills.include?(char[i].name)}
      char[i].sort_data.push(adv[m].weapon) unless m.nil?
      m=wpn.find_index{|q| q.skills.include?(char[i].name)}
      char[i].sort_data.push(wpn[m].type) unless m.nil?
    end
    char=char.reject{|q| !has_any?(wpn2,q.sort_data)}.uniq
    for i in 0...wpn2.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn2[i]}"}
      emo.push(moji[0].mention) if wpn2.length<2 && moji.length>0
      wpn2[i]="#{moji[0].mention}#{wpn2[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn2.join(', ')}")
  end
  if xtags.length>0
    if xtags.include?('Punisher') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$punishments.length
        if xtags.include?($punishments[i][0]) && !xtags.include?($punishments[i][1])
          xtags.push("#{$punishments[i][1]}")
          tags2.push("#{$punishments[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Punisher tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Punisher tag, remove #{mm}.\nTo search for just #{mm}, remove the Punisher tag."
      end
    end
    if xtags.include?('Cleanse') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$cleaning.length
        if xtags.include?($cleaning[i][0]) && !xtags.include?($cleaning[i][1])
          xtags.push("#{$cleaning[i][1]}")
          tags2.push("#{$cleaning[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Cleanse'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Cleanse tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Cleanse tag, remove #{mm}.\nTo search for just #{mm}, remove the Cleanse tag."
      end
    end
    search.push("*Tags*: #{xtags.join(', ')}")
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for skills with any listed tag)" if xtags.length>1
      char=char.reject{|q| q.tags.nil? || !has_any?(xtags,q.tags)}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for skills with all listed tags)" if xtags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for skills with all listed tags.\nTo search for skills with any of the listed tags, perform the search again with the word \"any\" in your message." if xtags.length>1
      for i in 0...xtags.length
        char=char.reject{|q| q.tags.nil? || !q.tags.include?(xtags[i])}.uniq
      end
    end
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[1].map{|q| q.name}.include?(q.name.split(' *[')[0])}
  end
  if (char.length>50 || char.map{|q| q.name}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,'',textra]
  end
end

def find_in_abilities(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_abilities(bot,event,sn.split(' '),13)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  elem=[]
  wpn=[]
  xtags=[]
  abiltypes=[]
  lookout=$skilltags.reject{|q| q[2]!='Askillity'}
  for i in 0...args.length
    abiltypes.push('Ability') if ['ability','abil','abilitys','abils','abilities'].include?(args[i].downcase)
    abiltypes.push('Aura') if ['aura','auras','drg','dragon'].include?(args[i].downcase)
    abiltypes.push('CoAbility') if ['coability','coabil','coab','coabilitys','coabils','coabilities','co','team'].include?(args[i].downcase)
    abiltypes.push('Chain') if ['chain','chaincoability','chaincoabil','chaincoab','chaincoabilitys','chaincoabils','chaincoabilities','chainco','cca','cc'].include?(args[i].downcase)
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    elem.push('None') if ['none','no-element','no_element','noelement','elementless'].include?(args[i].downcase)
    wpn.push('Sword') if ['sword','swords'].include?(args[i].downcase)
    wpn.push('Blade') if ['blade','blades','sabers','saber','katanas','katana'].include?(args[i].downcase)
    wpn.push('Dagger') if ['dagger','daggers','knife','knifes','knives'].include?(args[i].downcase)
    wpn.push('Axe') if ['axes','axe'].include?(args[i].downcase)
    wpn.push('Bow') if ['bow','bows','arrow','arrows','archer','archers'].include?(args[i].downcase)
    wpn.push('Lance') if ['lance','lances','pitchfork','pitchforks','trident','tridents','spear','spears'].include?(args[i].downcase)
    wpn.push('Wand') if ['wand','wands','rod','rods'].include?(args[i].downcase)
    wpn.push('Staff') if ['staff','staffs','staves'].include?(args[i].downcase)
    wpn.push('Manacaster') if ['manacaster','manacasters','caster','casters','gun','guns','managun','managuns','manchester','manchesters','gunner','gunners'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      xtags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  elem.uniq!
  wpn.uniq!
  abiltypes.uniq!
  xtags.uniq!
  emo=[]
  search=[]
  char=$abilities.map{|q| q.clone}
  textra=''
  if elem.length>0
    char=char.reject{|q| !has_any?(elem,q.tags)}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if wpn.length>0
    char=char.reject{|q| !has_any?(wpn,q.tags)}.uniq
    for i in 0...wpn.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[i]}"}
      emo.push(moji[0].mention) if wpn.length<2 && moji.length>0
      wpn[i]="#{moji[0].mention}#{wpn[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn.join(', ')}")
  end
  if abiltypes.length>0
    char=char.reject{|q| !abiltypes.include?(q.type)}.uniq
    search.push("*Categories*: #{abiltypes.join(', ')}")
  end
  if xtags.length>0
    if xtags.include?('Punisher') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$punishments.length
        if xtags.include?($punishments[i][0]) && !xtags.include?($punishments[i][1])
          xtags.push("#{$punishments[i][1]}")
          tags2.push("#{$punishments[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Punisher tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Punisher tag, remove #{mm}.\nTo search for just #{mm}, remove the Punisher tag."
      end
    end
    if xtags.include?('Cleanse') && xtags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...$cleaning.length
        if xtags.include?($cleaning[i][0]) && !xtags.include?($cleaning[i][1])
          xtags.push("#{$cleaning[i][1]}")
          tags2.push("#{$cleaning[i][0]}")
        end
      end
      if tags2.length>0
        xtags=xtags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Cleanse tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Cleanse tag, remove #{mm}.\nTo search for just #{mm}, remove the Cleanse tag."
      end
    end
    search.push("*Tags*: #{xtags.join(', ')}")
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for abilities with any listed tag)" if xtags.length>1
      char=char.reject{|q| !has_any?(xtags,q.tags)}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for abilities with all listed tags)" if xtags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for abilities with all listed tags.\nTo search for abilities with any of the listed tags, perform the search again with the word \"any\" in your message." if xtags.length>1
      for i in 0...xtags.length
        char=char.reject{|q| q.tags.nil? || !q.tags.include?(xtags[i])}.uniq
      end
    end
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[1].map{|q| q.name}.include?(q.name.split(' *[')[0])}
  end
  if (char.length>50 || char.map{|q| q.tags}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,'',textra]
  end
end

def find_in_facilities(bot,event,args=nil,mode=0,allowstr=true)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_facilities(bot,event,sn.split(' '),13,allowstr)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  elem=[]
  wpn=[]
  tags=[]
  typ1=[]
  typ2=[]
  evn=false
  lookout=$skilltags.reject{|q| q[2]!='Facility'}
  for i in 0...args.length
    evn=true if ['event','events','limited','limit','limiteds','limits'].include?(args[i].downcase)
    void=true if ['void','voids'].include?(args[i].downcase)
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    wpn.push('Sword') if ['sword','swords'].include?(args[i].downcase)
    wpn.push('Blade') if ['blade','blades','sabers','saber','katana','katanas'].include?(args[i].downcase)
    wpn.push('Dagger') if ['dagger','daggers','knife','knifes','knives'].include?(args[i].downcase)
    wpn.push('Axe') if ['axes','axe'].include?(args[i].downcase)
    wpn.push('Bow') if ['bow','bows','arrow','arrows','archer','archers'].include?(args[i].downcase)
    wpn.push('Lance') if ['lance','lances','pitchfork','pitchforks','trident','tridents','spear','spears'].include?(args[i].downcase)
    wpn.push('Wand') if ['wand','wands','rod','rods'].include?(args[i].downcase)
    wpn.push('Staff') if ['staff','staffs','staves'].include?(args[i].downcase)
    wpn.push('Manacaster') if ['manacaster','manacasters','caster','casters','gun','guns','managun','managuns','manchester','manchesters','gunner','gunners'].include?(args[i].downcase)
    typ1.push('Adventurer') if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[i].downcase)
    typ1.push('Dragon') if ['dragon','dragons','drg','drag','drgs','drags'].include?(args[i].downcase)
    typ1.push('Decorative') if ['decorative','decoration','decor','deco','decoratives','decorations','decors','decos'].include?(args[i].downcase)
    typ1.push('General') if ['general','denerals','gen'].include?(args[i].downcase)
    typ1.push('Production') if ['production','produce','productive','productives','producing','producings','produces','productions'].include?(args[i].downcase)
    typ2.push('Altar') if ['altar','alter','altars','alters'].include?(args[i].downcase)
    typ2.push('Dojo') if ['dojo','dojos'].include?(args[i].downcase)
    typ2.push('Dracolith') if ['dracolith','dracoliths'].include?(args[i].downcase)
    typ2.push('Fafnir') if ['fafnir','fafnirs'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  search=[]
  char=$facilities.reject{|q| !q.level.nil? && ![0,1].include?(q.level)}.map{|q| q.clone}
  ccc=$facilities.map{|q| q}
  for i in 0...char.length
    if char[i].level==1
      k=ccc.reject{|q| q.name !=char[i].name}.map{|q| q.level}
      char[i].name="#{char[i].name} #{k.min}#{"-#{k.max}" unless k.min==k.max}"
    end
  end
  if elem.length>0
    char=char.reject{|q| !has_any?(q.tags,elem)}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Element*: #{elem.join(', ')}")
  end
  if wpn.length>0
    char=char.reject{|q| !has_any?(q.tags,wpn)}.uniq
    for i in 0...wpn.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[i]}"}
      wpn[i]="#{moji[0].mention}#{wpn[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn.join(', ')}")
  end
  if typ1.length>0
    char=char.reject{|q| !typ1.include?(q.type)}
    search.push("*Primary type:* #{typ1.join(', ')}")
  end
  if typ2.length>0
    char=char.reject{|q| q.subtype.nil?}
    char=char.reject{|q| !typ2.include?(q.subtype) && !(q.subtype.include?(' ') && typ2.include?(q.subtype.split(' ')[-1]))}
    search.push("*Secondary type:* #{typ2.join(', ')}")
  end
  if tags.length>0
    char=char.reject{|q| !has_any?(q.tags,tags)}
    search.push("*Additional tags:* #{tags.join(', ')}")
  end
  if evn
    char=char.reject{|q| q.subtype.nil? || !q.subtype.include?('Event ')}
    search.push('*Event Facilities*')
  end
  if void
    char=char.reject{|q| q.subtype.nil? || !q.subtype.include?('Void ')}
    search.push('*Void Facilities*')
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[1].map{|q| q.name}.include?(q.name.split(' *[')[0])}
  end
  if (char.length>50 || char.map{|q| q.name}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.uniq.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,'','']
  end
end

def find_in_mats(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_mats(bot,event,sn.split(' '),13)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  rar=[]
  pouch=[]
  xtags=[]
  lookout=$skilltags.reject{|q| q[2]!='Mat'}
  for i in 0...args.length
    rar.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>1 && args[i].to_i<6
    rar.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>1 && args[i][0,1].to_i<6
    pouch.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>=0 && args[i].to_i<2
    pouch.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>=0 && args[i][0,1].to_i<2
    pouch.push(0) if ['common','commons'].include?(args[i])
    pouch.push(1) if ['rare','rares'].include?(args[i])
    pouch.push(2) if ['legend','legendary','legends','legendarys','legendaries'].include?(args[i])
    for i2 in 0...lookout.length
      xtags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  rar.uniq!
  pouch.uniq!
  xtags.uniq!
  char=$mats.map{|q| q.clone}
  textra=''
  search=[]
  if rar.length>0
    char=char.reject{|q| !rar.include?(q.rarity)}.uniq
    search.push("*Rarities*: #{rar.map{|q| "#{q}#{$rarity_stars[0][q]}"}.join(', ')}")
  end
  if pouch.length>0
    char=char.reject{|q| !pouch.include?(q.pouchrar.to_i)}.uniq
    search.push("*Pouch Rarities*: #{pouch.map{|q| "#{['<:Pouch_1:622140100679303189> Common','<:Pouch_2:622140100960190475> Rare','<:Pouch_3:622140100888756237> Legendary'][q]}"}.join(', ')}")
  end
  if xtags.length>0
    search.push("*Tags*: #{xtags.join(', ')}")
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for materials or items with any listed tag)" if xtags.length>1
      char=char.reject{|q| !has_any?(xtags,q.tags)}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for materials or items with all listed tags)" if xtags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for materials and items with all listed tags.\nTo search for materials or items with any of the listed tags, perform the search again with the word \"any\" in your message." if xtags.length>1
      for i in 0...xtags.length
        char=char.reject{|q| q.tags.nil? || !q.tags.include?(xtags[i])}.uniq
      end
    end
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[1].map{|q| q.name}.include?(q.name.split(' *[')[0])}
  end
  if (char.length>50 || char.map{|q| q.name}.join("\n").length+search.join("\n").length+textra.length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,'',textra]
  end
end

def find_in_banners(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  crsoff=nil
  if args.join(' ').include?('~~')
    s=args.join(' ')
    sy=args.join(' ')
    while sy.include?('~~')
      sy=remove_format(sy,'~~')
    end
    args=sy.split(' ')
    sn="~~#{s.gsub('~~',' ~~ ')}~~"
    while sn.include?('~~')
      sn=remove_format(sn,'~~')
    end
    crsoff=find_in_banners(bot,event,sn.split(' '),13)
    crsoff=nil unless crsoff.is_a?(Array)
  end
  elem=[]
  xtags=[]
  lookout=$skilltags.reject{|q| q[2]!='Banner'}
  for i in 0...args.length
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    elem.push('None') if ['none','no-element','no_element','noelement','elementless'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      xtags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  elem.uniq!
  xtags.uniq!
  emo=[]
  search=[]
  char=$banners.map{|q| q.clone}
  if elem.length>0
    char=char.reject{|q| !has_any?(elem,q.tags)}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if xtags.length>0
    char=char.reject{|q| !has_any?(xtags,q.tags)}.uniq
    search.push("*Tags*: #{xtags.join(', ')}")
  end
  unless crsoff.nil?
    search.push("\n__**Excludes matches from this search**__")
    search.push(crsoff[0].join("\n"))
    char=char.reject{|q| crsoff[1].map{|q| q.name}.include?(q.name.split(' *[')[0])}
  end
  if (char.length>50 || char.map{|q| q.name}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,'','']
  end
end

# functions for the find command

def display_adventurers(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_adventurers(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a.name.gsub('*','').gsub('~~','')<=>b.name.gsub('*','').gsub('~~','')}
  textra=k[3]
  flds=nil
  noload=false
  unless char.length<=0
    if char.map{|q| q.element}.uniq.length>1
      flds=[]
      flds.push(['<:Element_Flame:532106087952810005>Flame',char.reject{|q| q.element !='Flame'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Water:532106088221376522>Water',char.reject{|q| q.element !='Water'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Wind:532106087948746763>Wind',char.reject{|q| q.element !='Wind'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Light:532106088129101834>Light',char.reject{|q| q.element !='Light'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Shadow:532106088154267658>Shadow',char.reject{|q| q.element !='Shadow'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Null',char.reject{|q| ['Flame','Water','Wind','Light','Shadow'].include?(q.element)}.map{|q| q.name}.uniq.join("\n")])
    elsif char.map{|q| q.weapon}.uniq.length>1
      flds=[]
      flds.push(['<:Weapon_Sword:532106114540634113>Sword',char.reject{|q| q.weapon !='Sword'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Blade:532106114628714496>Blade',char.reject{|q| q.weapon !='Blade'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Dagger:532106116025286656>Dagger',char.reject{|q| q.weapon !='Dagger'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Axe:532106114188443659>Axe',char.reject{|q| q.weapon !='Axe'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Bow:532106114909732864>Bow',char.reject{|q| q.weapon !='Bow'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Lance:532106114792423448>Lance',char.reject{|q| q.weapon !='Lance'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Wand:532106114985099264>Wand',char.reject{|q| q.weapon !='Wand'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Staff:532106114733441024>Staff',char.reject{|q| q.weapon !='Staff'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Manacaster:758905122448867338>Manacaster',char.reject{|q| q.weapon !='Manacaster'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Other',char.reject{|q| ['Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff','Manacaster'].include?(q.weapon)}.map{|q| q.name}.uniq.join("\n")])
    elsif char.reject{|q| q.weapon != 'Manacaster'}.length<=0 && char.map{|q| q.weapon2}.uniq.length>1
      flds=[]
      flds.push(['<:MC_Rifle:772800760068046859>Rifles',char.reject{|q| q.weapon2 !='Rifle'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:MC_Shotgun:772800760055726080>Shotguns',char.reject{|q| q.weapon2 !='Shotgun'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:MC_Machine_Gun:772800760081023017>Machine Guns',char.reject{|q| q.weapon2 !='Machine Gun'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Other',char.reject{|q| ['Rifle','Shotgun','Machine Gun'].include?(q.weapon2)}.map{|q| q.name}.uniq.join("\n")])
    elsif char.map{|q| q.rarity}.uniq.length>1
      flds=[]
      mrar=[]
      for i in 0...$max_rarity[0]+1
        flds.push([generate_rarity_row(i,$max_rarity[0],''),char.reject{|q| q.rarity !=i}.map{|q| q.name}.uniq.join("\n")])
        mrar.push(i)
      end
      flds.push(['Unknown rarity',char.reject{|q| mrar.include?(q.rarity)}.map{|q| q.name}.uniq.join("\n")])
    elsif char.map{|q| q.clzz}.uniq.length>1
      flds=[]
      flds.push(['<:Type_Attack:532107867520630784>Attack',char.reject{|q| q.clzz !='Attack'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Type_Defense:532107867264909314>Defense',char.reject{|q| q.clzz !='Defense'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Type_Support:532107867575156747>Support',char.reject{|q| q.clzz !='Support'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Type_Healing:532107867348533249>Healing',char.reject{|q| q.clzz !='Healing'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Other',char.reject{|q| ['Attack','Defense','Support','Healing'].include?(q.clzz)}.map{|q| q.name}.uniq.join("\n")])
    else
      flds=triple_finish(char.map{|q| q.name}.uniq)
      noload=true
    end
    flds=flds.reject{|q| q[1].length<=0}
  end
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.map{|q| q.name}.uniq.join("\n").length+search.join("\n").length>=1900
    str="__**Adventurer Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i].name,event)
    end
    str=extend_message(str,"#{char.uniq.length} total#{", #{char.reject{|q| q.name.gsub('*[','').gsub(']*','').include?('*')}.length} available to players" unless char.reject{|q| !q.name.gsub('*[','').gsub(']*','').include?('*')}.length<=0}",event,2)
    event.respond str
  else
    textra="**No adventurers match your search**" if char.length<=0
    if textra.length<=0 && char.length<=10 && noload
      textra=char.map{|q| q.name}.uniq.join("\n")
      flds=nil
    end
    create_embed(event,"__**Adventurer Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.uniq.length} total#{", #{char.reject{|q| q.name.gsub('*[','').gsub(']*','').include?('*')}.length} available to players" unless char.reject{|q| !q.name.gsub('*[','').gsub(']*','').include?('*')}.length<=0}",nil,flds)
  end
end

def display_dragons(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_dragons(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a.name<=>b.name}
  textra=k[3]
  flds=nil
  noload=false
  unless char.length<=0
    if char.map{|q| q.element}.uniq.length>1
      flds=[]
      flds.push(['<:Element_Flame:532106087952810005>Flame',char.reject{|q| q.element !='Flame'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Water:532106088221376522>Water',char.reject{|q| q.element !='Water'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Wind:532106087948746763>Wind',char.reject{|q| q.element !='Wind'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Light:532106088129101834>Light',char.reject{|q| q.element !='Light'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Shadow:532106088154267658>Shadow',char.reject{|q| q.element !='Shadow'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Null',char.reject{|q| ['Flame','Water','Wind','Light','Shadow'].include?(q.element)}.map{|q| q.name}.uniq.join("\n")])
    elsif char.map{|q| q.rarity}.uniq.length>1
      flds=[]
      mrar=[]
      for i in 0...$max_rarity[1]+1
        flds.push([generate_rarity_row(i,0,''),char.reject{|q| q.rarity !=i}.map{|q| q.name}.uniq.join("\n")])
        mrar.push(i)
      end
      flds.push(['Unknown rarity',char.reject{|q| mrar.include?(q.rarity)}.map{|q| q.name}.uniq.join("\n")])
    else
      flds=triple_finish(char.map{|q| q.name}.uniq)
      noload=true
    end
    flds=flds.reject{|q| q[1].length<=0}
  end
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.map{|q| q.name}.uniq.join("\n").length+search.join("\n").length>=1900
    str="__**Dragon Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i].name,event)
    end
    str=extend_message(str,"#{char.uniq.length} total#{", #{char.reject{|q| q.name.include?('*')}.length} available to players" unless char.reject{|q| !q.name.gsub('*[','').gsub(']*','').include?('*')}.length<=0}",event,2)
    event.respond str
  else
    textra="**No dragons match your search**" if char.length<=0
    if textra.length<=0 && char.length<=10 && noload
      textra=char.map{|q| q.name}.uniq.join("\n")
      flds=nil
    end
    create_embed(event,"__**Dragon Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.uniq.length} total#{", #{char.reject{|q| q.name.gsub('*[','').gsub(']*','').include?('*')}.length} available to players" unless char.reject{|q| !q.name.include?('*')}.length<=0}",nil,flds)
  end
end

def display_wyrmprints(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_wyrmprints(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a.name<=>b.name}
  textra=k[3]
  flds=nil
  noload=false
  unless char.length<=0
    if char.map{|q| q.rarity}.uniq.length>1
      flds=[]
      mrar=[]
      for i in 0...$max_rarity[2]+1
        flds.push([generate_rarity_row(i,0,''),char.reject{|q| q.rarity !=i}.map{|q| q.name}.uniq.join("\n")])
        mrar.push(i)
      end
      flds.push(['<:Dominion:819854169128435742>',char.reject{|q| q.availability.nil? || !q.availability.include?('x')}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['Unknown rarity',char.reject{|q| mrar.include?(q.rarity) || (!q.availability.nil? && q.availability.include?('x'))}.map{|q| q.name}.uniq.join("\n")])
    elsif char.map{|q| q.amulet}.uniq.length>1
      flds=[]
      flds.push(['<:Type_Attack:532107867520630784>Attack',char.reject{|q| q.amulet !='Attack'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Type_Defense:532107867264909314>Defense',char.reject{|q| q.amulet !='Defense'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Type_Support:532107867575156747>Support',char.reject{|q| q.amulet !='Support'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Type_Healing:532107867348533249>Healing',char.reject{|q| q.amulet !='Healing'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Other',char.reject{|q| ['Attack','Defense','Support','Healing'].include?(q.amulet)}.map{|q| q.name}.uniq.join("\n")])
    else
      flds=triple_finish(char.map{|q| q.rarity}.uniq)
      noload=true
    end
    flds=flds.reject{|q| q[1].length<=0}
  end
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.map{|q| q.name}.uniq.join("\n").length+search.join("\n").length>=1900
    str="__**Wyrmprint Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i].name,event)
    end
    str=extend_message(str,"#{char.uniq.length} total#{", #{char.reject{|q| q.name.include?('*')}.length} available to players" unless char.reject{|q| !q.name.gsub('*[','').gsub(']*','').include?('*')}.length<=0}",event,2)
    event.respond str
  else
    textra="**No wyrmprints match your search**" if char.length<=0
    if textra.length<=0 && char.length<=10 && noload
      textra=char.map{|q| q.name}.uniq.join("\n")
      flds=nil
    end
    create_embed(event,"__**Wyrmprint Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.uniq.length} total#{", #{char.reject{|q| q.name.gsub('*[','').gsub(']*','').include?('*')}.length} available to players" unless char.reject{|q| !q.name.include?('*')}.length<=0}",nil,flds)
  end
end

def display_weapons(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_weapons(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a.name<=>b.name}
  textra=k[3]
  flds=nil
  noload=false
  unless char.length<=0
    if char.map{|q| q.type}.uniq.length>1
      flds=[]
      flds.push(['<:Weapon_Sword:532106114540634113>Sword',char.reject{|q| q.type !='Sword'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Blade:532106114628714496>Blade',char.reject{|q| q.type !='Blade'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Dagger:532106116025286656>Dagger',char.reject{|q| q.type !='Dagger'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Axe:532106114188443659>Axe',char.reject{|q| q.type !='Axe'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Bow:532106114909732864>Bow',char.reject{|q| q.type !='Bow'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Lance:532106114792423448>Lance',char.reject{|q| q.type !='Lance'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Wand:532106114985099264>Wand',char.reject{|q| q.type !='Wand'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Staff:532106114733441024>Staff',char.reject{|q| q.type !='Staff'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Weapon_Manacaster:758905122448867338>Manacaster',char.reject{|q| q.type !='Manacaster'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Other',char.reject{|q| ['Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff','Manacaster'].include?(q.type)}.map{|q| q.name}.uniq.join("\n")])
    elsif char.map{|q| q.element}.uniq.length>1
      flds=[]
      flds.push(['<:Element_Flame:532106087952810005>Flame',char.reject{|q| q.element !='Flame'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Water:532106088221376522>Water',char.reject{|q| q.element !='Water'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Wind:532106087948746763>Wind',char.reject{|q| q.element !='Wind'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Light:532106088129101834>Light',char.reject{|q| q.element !='Light'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Shadow:532106088154267658>Shadow',char.reject{|q| q.element !='Shadow'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Null',char.reject{|q| ['Flame','Water','Wind','Light','Shadow'].include?(q.element)}.map{|q| q.name}.uniq.join("\n")])
    elsif char.map{|q| q.rarity}.uniq.length>1
      flds=[]
      mrar=[]
      for i in 0...$max_rarity[3]+1
        flds.push([generate_rarity_row(i,0,''),char.reject{|q| q.rarity !=i}.map{|q| q.name}.uniq.join("\n")])
        mrar.push(i)
      end
      flds.push(['Unknown rarity',char.reject{|q| mrar.include?(q.rarity)}.map{|q| q.name}.uniq.join("\n")])
    elsif char.map{|q| q.tier}.uniq.length>1
      flds=[]
      flds.push(['Tier 0 weapons',char.reject{|q| q.tier !=0}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['Tier 1 weapons',char.reject{|q| q.tier !=1}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['Tier 2 weapons',char.reject{|q| q.tier !=2}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['Tier 3 weapons',char.reject{|q| q.tier !=3}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['Unknown tier',char.reject{|q| [0,1,2,3].include?(q.tier)}.map{|q| q.name}.uniq.join("\n")])
    else
      flds=triple_finish(char.map{|q| q.name}.uniq)
      noload=true
    end
    flds=flds.reject{|q| q[1].length<=0}
  end
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.map{|q| q.name}.uniq.join("\n").length+search.join("\n").length>=1900
    str="__**Weapon Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i].name,event)
    end
    str=extend_message(str,"#{char.uniq.length} total#{", #{char.reject{|q| q.name.include?('*')}.length} available to players" unless char.reject{|q| !q.name.gsub('*[','').gsub(']*','').include?('*')}.length<=0}",event,2)
    event.respond str
  else
    textra="**No weapons match your search**" if char.length<=0
    if textra.length<=0 && char.length<=10 && noload
      textra=char.map{|q| q.name}.uniq.join("\n")
      flds=nil
    end
    create_embed(event,"__**Weapons Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.uniq.length} total#{", #{char.reject{|q| q.name.gsub('*[','').gsub(']*','').include?('*')}.length} available to players" unless char.reject{|q| !q.name.include?('*')}.length<=0}",nil,flds)
  end
end

def display_enemies(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_enemies(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  textra=k[3]
  char=char.sort{|a,b| a.name<=>b.name}.uniq
  flds=nil
  noload=false
  unless char.length<=0
    if char.map{|q| q.element}.uniq.length>1
      flds=[]
      flds.push(['<:Element_Flame:532106087952810005>Flame',char.reject{|q| q.element !='Flame'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Water:532106088221376522>Water',char.reject{|q| q.element !='Water'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Wind:532106087948746763>Wind',char.reject{|q| q.element !='Wind'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Light:532106088129101834>Light',char.reject{|q| q.element !='Light'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Shadow:532106088154267658>Shadow',char.reject{|q| q.element !='Shadow'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Null',char.reject{|q| ['Flame','Water','Wind','Light','Shadow'].include?(q.element)}.map{|q| q.name}.uniq.join("\n")])
    elsif char.map{|q| q.tribe}.uniq.length>1
      flds=[]
      flds.push(['<:Tribe_Thaumian:549698154602168322>Thaumian',char.reject{|q| q.tribe !='Thaumian'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Tribe_Physian:549698154707288085>Physian',char.reject{|q| q.tribe !='Physian'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Tribe_Therion:549702939309113354>Therion',char.reject{|q| q.tribe !='Therion'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Tribe_Dragon:549947361745567754>Dragon',char.reject{|q| q.tribe !='Dragon'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Tribe_Demon:549716599788011521>Demon',char.reject{|q| q.tribe !='Demon'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Tribe_Demihuman:584222665376792586>Demihuman',char.reject{|q| q.tribe !='Demihuman'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Tribe_Human:573588507331657766>Human',char.reject{|q| q.tribe !='Human'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Tribe_Undead:550712824230313985>Undead',char.reject{|q| q.tribe !='Undead'}.map{|q| q.name}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Null',char.reject{|q| ['Thaumian','Physian','Therion','Dragon','Demon','Demihuman','Human','Undead'].include?(q.tribe)}.map{|q| q.name}.uniq.join("\n")])
    else
      flds=triple_finish(char.map{|q| q.name},true)
      noload=true
    end
    flds=flds.reject{|q| q[1].length<=0}
  end
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.map{|q| q.name}.join("\n").length+search.join("\n").length>=1900
    str="__**Enemy Search**__\n#{search.join("\n")}#{"\n\n__**Notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i][0],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    textra="#{textra}\n\n**No materials/items match your search**" if char.length<=0
    if textra.length<=0 && char.length<=10 && noload
      textra=char.map{|q| q.name}.uniq.join("\n")
      flds=nil
    end
    create_embed(event,"__**Enemy Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

def display_abilities(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_abilities(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  textra=k[3]
  subchar=char.map{|q| [q.name,q.type]}.uniq
  m=char.map{|q| q}
  char=[]
  for i in 0...subchar.length
    k=m.reject{|q| q.level=='example' || q.name !=subchar[i][0] || q.type !=subchar[i][1]}
    k.uniq!
    ccc='/'
    ccc=', ' unless k.find_index{|q| q.level.include?('/')}.nil?
    if k.length>3
      ccc=' -> '
      k=[k[0],k[k.length-1]]
    end
    name="#{k[0].name} #{'+' if k[0].level.include?('%')}#{k.map{|q| q.level}.join(ccc)}"
    name="#{k.map{|q| q.level}.join(ccc)} #{k[0].name}" if k[0].name[0,7]=='Hits = '
    name="#{k[0].name}" if k[0].level.nil? || k[0].level=='-'
    char.push([name,k[0].type])
  end
  flds=nil
  totals=[0,0,0,0]
  unless char.length<=0
    flds=[]
    c=char.reject{|q| q[1]!='Ability'}.map{|q| q[0]}.join("\n")
    flds.push(['Abilities',c]) if c.length>0
    totals[0]=c.split("\n").length
    c=char.reject{|q| q[1]!='Aura'}.map{|q| q[0]}.join("\n")
    flds.push(['Dragon Auras',c]) if c.length>0
    totals[1]=c.split("\n").length
    c=char.reject{|q| q[1]!='CoAbility'}.map{|q| q[0]}.join("\n")
    flds.push(['CoAbilities',c]) if c.length>0
    totals[2]=c.split("\n").length
    c=char.reject{|q| q[1]!='Chain'}.map{|q| q[0]}.join("\n")
    flds.push(['Chain CoAbilities',c]) if c.length>0
    totals[3]=c.split("\n").length
    flds=nil if flds.length<=0
  end
  f=0
  f=flds.map{|q| "__*#{q[0]}*__\n#{q[1]}"}.join("\n\n").length unless flds.nil?
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || f+search.join("\n").length>=1500
    str="__**Ability Search**__\n#{search.join("\n")}#{"\n\n__**Notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
    flds=flds.map{|q| ["__*#{q[0]}*__",q[1].split("\n")]}
    for i in 0...flds.length
      str=extend_message(str,flds[i][0],event,2)
      for i2 in 0...flds[i][1].length
        str=extend_message(str,flds[i][1][i2],event)
      end
    end
    str=extend_message(str,"#{char.length} total (#{totals[0]} abilities, #{totals[1]} auras, #{totals[2]} coabilities, #{totals[3]} chain coabilities)",event,2)
    event.respond str
  else
    flds=triple_finish(flds[0][1].split("\n")) if !flds.nil? && flds.length==1
    textra="#{textra}\n\n**No abilities match your search**" if char.length<=0 || flds.nil?
    create_embed(event,"__**Ability Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total (#{totals[0]} abilities, #{totals[1]} auras, #{totals[2]} coabilities, #{totals[3]} chain coabilities)",nil,flds)
  end
end

def display_thing(thing,bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=nil
  k=find_in_skills(bot,event,args) if thing=='Skill'
  k=find_in_facilities(bot,event,args) if thing=='Facility'
  k=find_in_mats(bot,event,args) if thing=='Material'
  k=find_in_banners(bot,event,args) if thing=='Banner'
  return nil if k.nil? || k.is_a?(String)
  thing='Material/Item' if thing=='Material'
  search=k[0]
  char=k[1]
  textra=k[3]
  if thing=='Banner'
    for i in 0...char.length
      kk=[char[i].start_date,char[i].end_date].compact.map{|q| "#{q[0]}#{['','Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'][q[1]]}#{q[2]}"}
      char[i].name="#{char[i].name} (#{kk.join(' - ')})" unless kk.length<=0
    end
    char=char.map{|q| q.name}.uniq
  else
    char=char.sort{|a,b| a.name<=>b.name}.map{|q| q.name}.uniq
  end
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length>=1900
    str="__**#{thing} Search**__\n#{search.join("\n")}#{"\n\n__**Notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.uniq.length} total",event,2)
    event.respond str
  else
    flds=nil
    flds=triple_finish(char) unless char.length<=0
    if (textra.length<=0 && char.length<=10) || thing=='Banner'
      textra=char.uniq.join("\n")
      flds=nil
    end
    m="#{thing.downcase}s"
    m="#{thing[0,thing.length-1]}ies".downcase if thing[-1,1]=='y'
    m='materials/items' if thing=='Material/Item'
    textra="#{textra}\n\n**No #{m} match your search**" if char.length<=0
    create_embed(event,"__**#{thing} Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.uniq.length} total",nil,flds)
  end
end

def display_skills(bot,event,args=nil); return display_thing('Skill',bot,event,args); end
def display_facilities(bot,event,args=nil); return display_thing('Facility',bot,event,args); end
def display_mats(bot,event,args=nil); return display_thing('Material',bot,event,args); end
def display_banners(bot,event,args=nil); return display_thing('Banner',bot,event,args); end

def display_search_results(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  if args.nil? || args.length<=0
  elsif ['help'].include?(args[0].downcase)
    subcommand=nil
    subcommand=args[0] unless args.nil? || args.length.zero?
    subcommand='' if subcommand.nil?
    help_text(event,bot,'find',subcommand)
    return nil
  elsif ['love'].include?(args[0].downcase) || ['true love'].include?("#{args[0]} #{args[1]}".downcase)
    event.respond "Aren't we all?"
    return nil
  elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    args.shift
    display_adventurers(bot,event,args)
    return nil
  elsif ['dragon','dragons','drg','drag','drgs','drags'].include?(args[0].downcase)
    args.shift
    display_dragons(bot,event,args)
    return nil
  elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
    args.shift
    display_wyrmprints(bot,event,args)
    return nil
  elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(args[0].downcase)
    args.shift
    display_weapons(bot,event,args)
    return nil
  elsif ['skill','skills','skls','skl','skil','skils'].include?(args[0].downcase)
    args.shift
    display_skills(bot,event,args)
    return nil
  elsif ['abil','ability','abilitys','abilities','abils'].include?(args[0].downcase)
    args.shift
    display_abilities(bot,event,args)
    return nil
  elsif ['aura','auras'].include?(args[0].downcase)
    args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc','ccas'].include?(q)}
    display_abilities(bot,event,args)
    return nil
  elsif ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs'].include?(args[0].downcase)
    args=args.reject{|q| ['aura','auras','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','cca','cc','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','ccas'].include?(q)}
    display_abilities(bot,event,args)
    return nil
  elsif ['chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc','ccas'].include?(args[0].downcase)
    args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','aura','auras'].include?(q)}
    display_abilities(bot,event,args)
    return nil
  elsif ['facility','facilities','facilitys','fac','facs','faculties','faculty','facultys','facils','facil'].include?(args[0].downcase)
    args.shift
    display_facilities(bot,event,args)
    return nil
  elsif ['mat','mats','materials','material','item','items'].include?(args[0].downcase)
    args.shift
    display_mats(bot,event,args)
    return nil
  elsif ['banner','banners','summon','summoning','summons','summonings'].include?(args[0].downcase)
    args.shift
    display_banners(bot,event,args)
    return nil
  elsif ['enemies','boss','enemy','bosses','enemie','enemys','bosss'].include?(args[0].downcase)
    args.shift
    display_enemies(bot,event,args)
    return nil
  else
    f=['vanille','van']
    m=bot.user(141260274144509952).on(event.server.id).display_name.gsub(' ','')
    f.push(m)
    f.push(m[0,args[0].length]) unless args[0].length<=5 || args[0].length>m.length
    if f.include?(args[0].downcase)
      args.shift
      t=Time.now
      if t-$last_multi_reload[2]>10*60
        $last_multi_reload[2]=t
        event.respond 'I found Van here!  See?  <@141260274144509952>'
        return nil
      elsif args.length<=0
        event.respond "I'm not showing everything, you jerk!"
        return nil
      end
    end
  end
  adv=find_in_adventurers(bot,event,args,2)
  drg=find_in_dragons(bot,event,args,2)
  wrm=find_in_wyrmprints(bot,event,args,2)
  wpn=find_in_weapons(bot,event,args,2)
  adv=nil if !adv.nil? && adv[1].length>=$adventurers.length
  drg=nil if !drg.nil? && drg[1].length>=$dragons.reject{|q| q.name=='Puppy'}.length
  wrm=nil if !wrm.nil? && wrm[1].length>=$wyrmprints.reject{|q| q.isMultiprint?}.uniq.length
  wpn=nil if !wpn.nil? && wpn[1].length>=$weapons.length
  if adv.nil? && drg.nil? && wrm.nil? && wpn.nil?
    event.respond "I'm not showing everything, you jerk!"
    return nil
  elsif adv.nil? && wrm.nil? && wpn.nil?
    find_dragons(bot,event,args)
    return nil
  elsif drg.nil? && wrm.nil? && wpn.nil?
    find_adventurers(bot,event,args)
    return nil
  elsif drg.nil? && adv.nil? && wpn.nil?
    find_wyrmprints(bot,event,args)
    return nil
  elsif drg.nil? && adv.nil? && wrm.nil?
    find_weapons(bot,event,args)
    return nil
  end
  adv=[[],[],[],''] if adv.nil?
  drg=[[],[],[],''] if drg.nil?
  wrm=[[],[],[],''] if wrm.nil?
  wpn=[[],[],[],''] if wpn.nil?
  wrm[4]=wrm[1].length
  adv[1]=adv[1].sort{|a,b| a.name.gsub('*','')<=>b.name.gsub('*','')}.map{|q| q.name}.uniq
  drg[1]=drg[1].sort{|a,b| a.name<=>b.name}.map{|q| q.name}.uniq
  wrm[1]=wrm[1].sort{|a,b| a.name<=>b.name}.map{|q| q.name}.uniq
  wpn[1]=wpn[1].sort{|a,b| a.name<=>b.name}.map{|q| q.name}.uniq
  search="#{adv[0].join("\n\n").gsub('adventurers','items')}\n\n#{drg[0].join("\n\n").gsub('dragons','items')}\n\n#{wrm[0].join("\n\n").gsub('wyrmprints','items')}\n\n#{wpn[0].join("\n\n").gsub('weapons','items')}".split("\n\n")
  search=search.reject{|q| count_in(search,q)<2}.uniq
  adv[0]=adv[0].reject{|q| search.include?(q.gsub('adventurers','items'))}
  drg[0]=drg[0].reject{|q| search.include?(q.gsub('dragons','items'))}
  wrm[1]=[] if wrm[0].length==1 && wrm[0][0][0,11]=='*Rarities*:' && search.length>1
  wrm[0]=wrm[0].reject{|q| search.include?(q.gsub('wyrmprints','items').gsub('abilities','skills and abilities'))}
  wpn[0]=wpn[0].reject{|q| search.include?(q.gsub('weapons','items'))}
  str=''
  str="__**Overall Search**__\n#{search.join("\n")}" if search.length>0
  str="#{str}\n\n__**Adventurer Search**__\n#{adv[0].join("\n")}" if adv[0].length>0
  str="#{str}\n\n__**Dragon Search**__\n#{drg[0].join("\n")}" if drg[0].length>0
  str="#{str}\n\n__**Wyrmprint Search**__\n#{wrm[0].join("\n")}" if wrm[0].length>0
  str="#{str}\n\n__**Weapon Search**__\n#{wpn[0].join("\n")}" if wpn[0].length>0
  str="#{str}\n\n__**Results**__"
  m=[adv[2].join(''),drg[2].join(''),wrm[2].join(''),wpn[2].join('')]
  m[2]='' if wrm[4]>wrm[1].length
  m=m.reject{|q| q.length<=0}.uniq
  if m.length<2
    adv[2]=[]
    drg[2]=[]
    wrm[2]=[]
    wpn[2]=[]
  end
  textra=''
  adv[3]=adv[3].split("\n\n")
  drg[3]=drg[3].split("\n\n")
  wrm[3]=wrm[3].split("\n\n")
  wpn[3]=wpn[3].split("\n\n")
  textra="#{adv[3].join("\n\n").gsub('adventurers','items')}\n\n#{drg[3].join("\n\n").gsub('dragons','items')}\n\n#{wrm[3].join("\n\n").gsub('wyrmprints','items')}\n\n#{wpn[3].join("\n\n").gsub('weapons','items')}".split("\n\n")
  textra=textra.reject{|q| count_in(textra,q)<2}.uniq
  adv[3]=adv[3].reject{|q| textra.include?(q.gsub('adventurers','items'))}
  drg[3]=drg[3].reject{|q| textra.include?(q.gsub('dragons','items'))}
  wrm[3]=wrm[3].reject{|q| textra.include?(q.gsub('wyrmprints','items'))}
  wpn[3]=wpn[3].reject{|q| textra.include?(q.gsub('weapons','items'))}
  textra="#{textra.join("\n\n")}#{"\n\n#{adv[3].join("\n\n").gsub('adventurers','items')}" unless adv[3].nil? || adv[3].length<=0}#{"\n\n#{drg[3].join("\n\n").gsub('dragons','items')}" unless drg[3].nil? || drg[3].length<=0}#{"\n\n#{wrm[3].join("\n\n").gsub('wyrmprints','items')}" unless wrm[3].nil? || wrm[3].length<=0}#{"\n\n#{wpn[3].join("\n\n").gsub('weapons','items')}" unless wpn[3].nil? || wpn[3].length<=0}"
  textra='' if textra.gsub("\n",'').length<=0
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || str.length+adv[1].join("\n").length+drg[1].join("\n").length+wrm[1].join("\n").length+wpn[1].join("\n").length+"Totals: #{adv[1].length} adventurers, #{drg[1].length} dragons, #{wrm[4]} wyrmprints#{' (not shown)' if wrm[4]>wrm[1].length}, #{wpn[1].length} weapons".length+textra.length>=1800
    unless safe_to_spam?(event)
      str=str.split("\n\n")
      str=str[0,str.length-1]
      if str.length>1
        for i in 1...str.length
          str[i]=str[i].gsub('__','').gsub("\n",' - ')
        end
      end
      str=str.join("\n").gsub("\n\n",'')
      str=extend_message(str,"__**Note**__\nToo much data is trying to be displayed.  Please use this command in PM.",event,2)
      wrm[4]=$wyrmprints.reject{|q| ['Wily Warriors','Greatwyrm'].include?(q[0])}.uniq.length if wrm[0].length<=0 && wrm[1].length<=0 && search.length<=0
      wpn[1]=$weapons.uniq if wpn[0].length<=0 && wpn[1].length<=0
      str=extend_message(str,"Totals: #{adv[1].length} adventurers, #{drg[1].length} dragons, #{wrm[4]} wyrmprints, #{wpn[1].length} weapons",event,2)
      event.respond str.gsub("\n\n\n","\n\n")
      return nil
    end
    str="#{str}\n*Adventurers #{adv[2].join('')}:* #{adv[1][0]}"
    for i in 1...adv[1].length
      str=extend_message(str,adv[1][i],event,1,', ')
    end
    str=extend_message(str,"*Dragons #{drg[2].join('')}:* #{drg[1][0]}",event)
    for i in 1...drg[1].length
      str=extend_message(str,drg[1][i],event,1,', ')
    end
    str=extend_message(str,"*Wyrmprints #{wrm[2].join('')}:* #{wrm[1][0]}",event)
    for i in 1...wrm[1].length
      str=extend_message(str,wrm[1][i],event,1,', ')
    end
    str=extend_message(str,"*Weapons #{wpn[2].join('')}:* #{wpn[1][0]}",event)
    for i in 1...wpn[1].length
      str=extend_message(str,wpn[1][i],event,1,', ')
    end
    str=extend_message(str,"Totals: #{adv[1].reject{|q| q.gsub('*[','').gsub(']*','').include?('*')}.length}#{" (#{adv[1].length})" unless adv[1].reject{|q| !q.gsub('*[','').gsub(']*','').include?('*')}.length<=0} adventurers, #{drg[1].reject{|q| q.gsub('*[','').gsub(']*','').include?('*')}.length}#{" (#{drg[1].length})" unless drg[1].reject{|q| !q.gsub('*[','').gsub(']*','').include?('*')}.length<=0} dragons, #{wrm[4]} wyrmprints#{' (not shown)' if wrm[4]>wrm[1].length}, #{wpn[1].reject{|q| q.gsub('*[','').gsub(']*','').include?('*')}.length}#{" (#{wpn[1].length})" unless wpn[1].reject{|q| !q.gsub('*[','').gsub(']*','').include?('*')}.length<=0} weapons",event,2)
    str=extend_message(str,"Wyrmprints have been removed from the displayed search results because only the rarity filter applies.",event,2) if wrm[4]>wrm[1].length
    event.respond str
  else
    flds=nil
    flds=[] unless adv[1].length<=0 && drg[1].length<=0 && wrm[1].length<=0 && wpn[1].length<=0
    flds.push(["**Adventurers** #{adv[2].join('')}",adv[1].join("\n")]) if adv[1].length>0
    flds.push(["**Dragons** #{drg[2].join('')}",drg[1].join("\n")]) if drg[1].length>0
    flds.push(["**Wyrmprints** #{wrm[2].join('')}",wrm[1].join("\n")]) if wrm[1].length>0
    flds.push(["**Weapons** #{wpn[2].join('')}",wpn[1].join("\n")]) if wpn[1].length>0
    textra="**No data matches your search**" if adv[1].length<=0 && drg[1].length<=0 && wrm[1].length<=0 && wpn[1].length<=0
    textra="#{textra}\n\nWyrmprints have been removed from the displayed search results because only the rarity filter applies." if wrm[4]>wrm[1].length
    create_embed(event,str,textra,0xCE456B,"Totals: #{adv[1].reject{|q| q.gsub('*[','').gsub(']*','').include?('*')}.length}#{" (#{adv[1].length})" unless adv[1].reject{|q| !q.gsub('*[','').gsub(']*','').include?('*')}.length<=0} adventurers, #{drg[1].reject{|q| q.gsub('*[','').gsub(']*','').include?('*')}.length}#{" (#{drg[1].length})" unless drg[1].reject{|q| !q.gsub('*[','').gsub(']*','').include?('*')}.length<=0} dragons, #{wrm[4]} wyrmprints#{' (not shown)' if wrm[4]>wrm[1].length}, #{wpn[1].reject{|q| q.gsub('*[','').gsub(']*','').include?('*')}.length}#{" (#{wpn[1].length})" unless wpn[1].reject{|q| !q.gsub('*[','').gsub(']*','').include?('*')}.length<=0} weapons",nil,flds)
  end
end

# functions for the sort command

def sort_adventurers(bot,event,args=nil,mode=0)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_adventurers(bot,event,args,2,1)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a.name.gsub('*','')<=>b.name.gsub('*','')}.uniq
  textra=k[3]
  srt=[1,1,1,1,1,1]
  srtt=0
  lvl=-1
  rar=-1
  for i in 0...args.length
    rar=args[i].to_i if rar<0 && args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<$max_rarity[0]+1
    rar=args[i][0,1].to_i if rar<0 && args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<$max_rarity[0]+1
    rar=$max_rarity[0]+1 if ['base'].include?(args[i].downcase)
    lvl=0 if ['default'].include?(args[i].downcase)
    lvl=1 if ['truemax','max','maximum','truemaximum','trumax','trumaximum'].include?(args[i].downcase)
    if ['hp','health'].include?(args[i].downcase) && !srt.include?(3)
      srt[srtt]=3
      srtt+=1
    elsif ['strength','str','atkstat','attstat','attackstat','statatk','statatt','statattack','statk','statt','stattack','statstr'].include?(args[i].downcase) && !srt.include?(4)
      srt[srtt]=4
      srtt+=1
    elsif ['defstat','defensestat','defencestat','def','defense','defence'].include?(args[i].downcase)
      srt[srtt]=5
      srtt+=1
    elsif ['skill','skillshare','share','shared','sharing','skl','skills','sklz'].include?(args[i].downcase)
      srt[srtt]=7
      srtt+=1
    elsif ['banner','banners','focus','focuses','summon','summons','summoning','summonings'].include?(args[i].downcase)
      srt[srtt]=8
      srtt+=1
    end
  end
  textra="**No adventurers match your search**" if char.length<=0
  if lvl<0
    lvl=0
    if srt.reject{|q| q<3}.length>0
      if rar>$max_rarity[0]
        textra="#{textra}#{"\n\n" if textra.length>0}Sorting at default max level.\nIf you want to sort at absolute max stats, include the word \"max\" in your message."
      elsif rar==$max_rarity[0]
        textra="#{textra}#{"\n\n" if textra.length>0}Sorting at level #{30+10*rar} with no modifiers.\nIf you want to sort at absolute max stats, include the word \"max\" in your message."
      end
    end
  end
  if rar<0
    rar=$max_rarity[0]+1-lvl
    textra="#{textra}#{"\n\n" if textra.length>0}Sorting at each adventurer's default available rarity.\nIf you want to sort at a specific rarity, include that rarity in your message." unless rar==$max_rarity[0] || srt.reject{|q| q<3}.length<=0
  end
  srt[srtt]=0
  char=char.reject{|q| q.name[0,1]=='*'}
  char=char.reject{|q| q.rarity>rar} unless rar>$max_rarity[0] || args.map{|q| q.downcase}.include?('alladv')
  stats=['Name','','','HP','Strength','Defense','','Capacity','Banners']
  for i in 0...char.length
    m=rar-3
    m=char[i].rarity-3 if rar>$max_rarity[0]
    m+=lvl if m==2
    char[i].sort_data=[]
    char[i].sort_data[3]=char[i].hp[1][m]
    char[i].sort_data[4]=char[i].str[1][m]
    char[i].sort_data[5]=char[i].dispDefense
    char[i].sort_data[7]=char[i].skill_points
    char[i].sort_data[8]=$banners.reject{|q| q.name=='Launch' || !q.advs.include?(char[i].name)}.length
    m2=[]
    for i2 in 0...srt.length
      unless srt[i2]<3
        if rar>$max_rarity[0] && m==3
          m2.push("#{char[i].sort_data[srt[i2]]} max #{stats[srt[i2]]}")
        elsif rar>$max_rarity[0]
          m2.push("#{char[i].sort_data[srt[i2]]} #{stats[srt[i2]]}")
        else
          m2.push("#{char[i].sort_data[srt[i2]]} #{stats[srt[i2]]}")
        end
      end
    end
    char[i].sort_data[0]="**#{char[i].name}**#{char[i].emotes(bot)}"
    char[i].sort_data[0]="#{char[i].sort_data[0]}#{" (Lv#{30+10*char[i].rarity})" if rar==6 && m != 3 && srt.reject{|q| [3,4,5].include?(q)}.length<0} - #{m2.join(', ')}" if m2.length>0
  end
  char=char.map{|q| q.sort_data}.uniq
  char.sort!{|b,a| (supersort(a,b,srt[0])==0 ? (supersort(a,b,srt[1])==0 ? (supersort(a,b,srt[2])==0 ? (supersort(a,b,srt[3])==0 ? (supersort(a,b,srt[4])==0 ? supersort(a,b,srt[5]) : supersort(a,b,srt[4])) : supersort(a,b,srt[3])) : supersort(a,b,srt[2])) : supersort(a,b,srt[1])) : supersort(a,b,srt[0]))}
  tx=0
  bx=0
  for i in 0...args.length
    if args[i].downcase[0,3]=='top' && tx.zero?
      tx=[args[i][3,args[i].length-3].to_i,char.length].min
    elsif args[i].downcase[0,6]=='bottom' && bx.zero?
      bx=[args[i][6,args[i].length-6].to_i,char.length].min
    end
  end
  if tx>0
    char=char[0,tx]
  elsif bx>0
    char=char[char.length-bx,bx]
  end
  if !safe_to_spam?(event) && char.length>10
    textra="#{textra}#{"\n\n" if textra.length>0}Too much data is trying to be displayed.  Showing top ten results.\nYou can also make things easier by making the list shorter with words like `top#{rand(10)+1}` or `bottom#{rand(10)+1}`"
    char=char[0,10]
  end
  fpop=$rarity_stars[0][0,$max_rarity[0]+1]
  fpop[fpop.length-1]="#{fpop[fpop.length-1]}, absolute max stats" if lvl==1
  fpop.push('Default rarity')
  stats=['Name','','','<:HP:573344832307593216>HP','<:Strength:573344931205349376>Strength','<:Defense:573344832282689567>Defense','','<:SkillShare:714597012733034547>Skill Share capacity','Banners']
  disp="__**Adventurer Search**__\n#{search.join("\n")}#{"\n" unless search.length<=0}*Sorted By:* #{srt.map{|q| stats[q]}.reject{|q| q.length<=0}.join(', ')}\n*Sorted at:* #{rar unless rar>$max_rarity[0]}#{fpop[rar]}#{"\n#{$max_rarity[0]}#{$rarity_stars[0][$max_rarity[0]]}s will be shown with absolute max stats" if rar>$max_rarity[1] && lvl==1}"
  disp=extend_message(disp,"__**Notes**__\n#{textra}",event,2) if textra.length>0
  disp=extend_message(disp,"__**Results**__",event,2) if char.length>0
  for i in 0...char.length
    disp=extend_message(disp,char[i][0],event)
  end
  disp=extend_message(disp,"No subcommand was specified.  Defaulted to adventurer sorting.\nDragons, Wyrmprints, and Weapons are also available as subcommands.",event,2) if mode==1
  event.respond disp
end

def sort_dragons(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_dragons(bot,event,args,2,false)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a.name.gsub('*','')<=>b.name.gsub('*','')}.uniq
  textra=k[3]
  srt=[1,1,1,1,1]
  srtt=0
  for i in 0...args.length
    if ['hp','health'].include?(args[i].downcase) && !srt.include?(3)
      srt[srtt]=3
      srtt+=1
    elsif ['strength','str','atkstat','attstat','attackstat','statatk','statatt','statattack','statk','statt','stattack','statstr','attack','att','atk'].include?(args[i].downcase) && !srt.include?(4)
      srt[srtt]=4
      srtt+=1
    elsif ['banner','banners','focus','focuses','summon','summons','summoning','summonings'].include?(args[i].downcase)
      srt[srtt]=5
      srtt+=1
    end
  end
  textra="**No dragons match your search**" if char.length<=0
  srt[srtt]=0
  char=char.reject{|q| q.name[0,1]=='*'}
  stats=['Name','','','HP','Strength','Banners']
  for i in 0...char.length
    char[i].sort_data=[]
    char[i].sort_data[3]=char[i].hp[-1]
    char[i].sort_data[4]=char[i].str[-1]
    char[i].sort_data[5]=$banners.reject{|q| q.name=='Launch' || !q.drgs.include?(char[i].name)}.length
    m2=[]
    for i2 in 0...srt.length
      m2.push("#{char[i].sort_data[srt[i2]]} #{stats[srt[i2]]}") unless srt[i2]<3
    end
    char[i].sort_data[0]="**#{char[i].name}**#{char[i].emotes(bot)}"
    char[i].sort_data[0]="#{char[i].sort_data[0]} - #{m2.join(', ')}" if m2.length>0
  end
  char=char.map{|q| q.sort_data}.uniq
  char.sort!{|b,a| (supersort(a,b,srt[0])==0 ? (supersort(a,b,srt[1])==0 ? (supersort(a,b,srt[2])==0 ? (supersort(a,b,srt[3])==0 ? supersort(a,b,srt[4]) : supersort(a,b,srt[3])) : supersort(a,b,srt[2])) : supersort(a,b,srt[1])) : supersort(a,b,srt[0]))}
  tx=0
  bx=0
  for i in 0...args.length
    if args[i].downcase[0,3]=='top' && tx.zero?
      tx=[args[i][3,args[i].length-3].to_i,char.length].min
    elsif args[i].downcase[0,6]=='bottom' && bx.zero?
      bx=[args[i][6,args[i].length-6].to_i,char.length].min
    end
  end
  if tx>0
    char=char[0,tx]
  elsif bx>0
    char=char[char.length-bx,bx]
  end
  if !safe_to_spam?(event) && char.length>10
    textra="#{textra}#{"\n\n" if textra.length>0}Too much data is trying to be displayed.  Showing top ten results.\nYou can also make things easier by making the list shorter with words like `top#{rand(10)+1}` or `bottom#{rand(10)+1}`"
    char=char[0,10]
  end
  stats=['Name','','','<:HP:573344832307593216>HP','<:Strength:573344931205349376>Strength','Banners']
  disp="__**Dragon Search**__\n#{search.join("\n")}\n*Sorted By:* #{srt.map{|q| stats[q]}.reject{|q| q.length<=0}.join(', ')}"
  disp=extend_message(disp,"__**Notes**__\n#{textra}",event,2) if textra.length>0
  disp=extend_message(disp,"__**Results**__",event,2) if char.length>0
  for i in 0...char.length
    disp=extend_message(disp,char[i][0],event)
  end
  event.respond disp
end

def sort_wyrmprints(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_wyrmprints(bot,event,args,2,false)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a.name.gsub('*','')<=>b.name.gsub('*','')}.uniq
  textra=k[3]
  srt=[1,1,1,1,1]
  srtt=0
  for i in 0...args.length
    if ['hp','health'].include?(args[i].downcase) && !srt.include?(3)
      srt[srtt]=3
      srtt+=1
    elsif ['strength','str','atkstat','attstat','attackstat','statatk','statatt','statattack','statk','statt','stattack','statstr','attack','att','atk'].include?(args[i].downcase) && !srt.include?(4)
      srt[srtt]=4
      srtt+=1
    elsif ['banner','banners','focus','focuses','summon','summons','summoning','summonings'].include?(args[i].downcase)
      srt[srtt]=5
      srtt+=1
    end
  end
  textra="**No wyrmprints match your search**" if char.length<=0
  srt[srtt]=0
  char=char.reject{|q| q.name[0,1]=='*'}
  stats=['Name','','','HP','Strength','Banners']
  for i in 0...char.length
    char[i].sort_data=[]
    char[i].sort_data[3]=char[i].hp[2]
    char[i].sort_data[4]=char[i].str[2]
    char[i].sort_data[5]=$banners.reject{|q| q.name=='Launch' || !q.prints.include?(char[i].name)}.length
    m2=[]
    for i2 in 0...srt.length
      m2.push("#{char[i].sort_data[srt[i2]]} #{stats[srt[i2]]}") unless srt[i2]<3
    end
    char[i].sort_data[0]="**#{char[i].name}**#{char[i].emotes(bot)}"
    char[i].sort_data[0]="#{char[i].sort_data[0]} - #{m2.join(', ')}" if m2.length>0
  end
  char=char.map{|q| q.sort_data}.uniq
  char.sort!{|b,a| (supersort(a,b,srt[0])==0 ? (supersort(a,b,srt[1])==0 ? (supersort(a,b,srt[2])==0 ? (supersort(a,b,srt[3])==0 ? supersort(a,b,srt[4]) : supersort(a,b,srt[3])) : supersort(a,b,srt[2])) : supersort(a,b,srt[1])) : supersort(a,b,srt[0]))}
  tx=0
  bx=0
  for i in 0...args.length
    if args[i].downcase[0,3]=='top' && tx.zero?
      tx=[args[i][3,args[i].length-3].to_i,char.length].min
    elsif args[i].downcase[0,6]=='bottom' && bx.zero?
      bx=[args[i][6,args[i].length-6].to_i,char.length].min
    end
  end
  if tx>0
    char=char[0,tx]
  elsif bx>0
    char=char[char.length-bx,bx]
  end
  if !safe_to_spam?(event) && char.length>10
    textra="#{textra}#{"\n\n" if textra.length>0}Too much data is trying to be displayed.  Showing top ten results.\nYou can also make things easier by making the list shorter with words like `top#{rand(10)+1}` or `bottom#{rand(10)+1}`"
    char=char[0,10]
  end
  stats=['Name','','','<:HP:573344832307593216>HP','<:Strength:573344931205349376>Strength','Banners']
  disp="__**Wyrmprint Search**__\n#{search.join("\n")}\n*Sorted By:* #{srt.map{|q| stats[q]}.reject{|q| q.length<=0}.join(', ')}"
  disp=extend_message(disp,"__**Notes**__\n#{textra}",event,2) if textra.length>0
  disp=extend_message(disp,"__**Results**__",event,2) if char.length>0
  for i in 0...char.length
    disp=extend_message(disp,char[i][0],event)
  end
  event.respond disp
end

def sort_weapons(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_weapons(bot,event,args,2,false)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a.name.gsub('*','')<=>b.name.gsub('*','')}.uniq
  textra=k[3]
  srt=[1,1,1,1]
  srtt=0
  x=0
  for i in 0...args.length
    if ['hp','health'].include?(args[i].downcase) && !srt.include?(4)
      srt[srtt]=4
      srtt+=1
    elsif ['strength','str','atkstat','attstat','attackstat','statatk','statatt','statattack','statk','statt','stattack','statstr','attack','att','atk'].include?(args[i].downcase) && !srt.include?(5)
      srt[srtt]=5
      srtt+=1
    end
    x=1 if x<=0 && ['base','0ub','oub','default'].include?(args[i].downcase)
    x=2 if x<=0 && ['mub','unbind','unbound','refined','refine','refinement','max'].include?(args[i].downcase)
  end
  textra="**No weapons match your search**" if char.length<=0
  if x==0
    x=1
    textra="#{textra}#{"\n\n" if textra.length>0}Searching defaults to stats at 0UB.\nYou can sort by stats at MUB by including the word \"MUB\" in your message."
  end
  srt[srtt]=0
  char=char.reject{|q| q.name[0,1]=='*'}
  stats=['Name','','','','HP','Strength']
  for i in 0...char.length
    char[i].sort_data=[]
    char[i].sort_data[4]=char[i].hp[x]
    char[i].sort_data[5]=char[i].str[x]
    m2=[]
    for i2 in 0...srt.length
      m2.push("#{char[i].sort_data[srt[i2]]} #{stats[srt[i2]]}") unless srt[i2]<3
    end
    char[i].sort_data[0]="**#{char[i].name}**#{char[i].emotes(bot)}"
    char[i].sort_data[0]="#{char[i].sort_data[0]} - #{m2.join(', ')}" if m2.length>0
  end
  char=char.map{|q| q.sort_data}.uniq
  char.sort!{|b,a| (supersort(a,b,srt[0])==0 ? (supersort(a,b,srt[1])==0 ? (supersort(a,b,srt[2])==0 ? supersort(a,b,srt[3]) : supersort(a,b,srt[2])) : supersort(a,b,srt[1])) : supersort(a,b,srt[0]))}
  tx=0
  bx=0
  for i in 0...args.length
    if args[i].downcase[0,3]=='top' && tx.zero?
      tx=[args[i][3,args[i].length-3].to_i,char.length].min
    elsif args[i].downcase[0,6]=='bottom' && bx.zero?
      bx=[args[i][6,args[i].length-6].to_i,char.length].min
    end
  end
  if tx>0
    char=char[0,tx]
  elsif bx>0
    char=char[char.length-bx,bx]
  end
  if !safe_to_spam?(event) && char.length>10
    textra="#{textra}#{"\n\n" if textra.length>0}Too much data is trying to be displayed.  Showing top ten results.\nYou can also make things easier by making the list shorter with words like `top#{rand(10)+1}` or `bottom#{rand(10)+1}`"
    char=char[0,10]
  end
  stats=['Name','','','','<:HP:573344832307593216>HP','<:Strength:573344931205349376>Strength']
  disp="__**Weapon Search**__\n#{search.join("\n")}\n*Sorted By:* #{srt.map{|q| stats[q]}.reject{|q| q.length<=0}.join(', ')}\n*Sorted at:* #{['',"#{'<:NonUnbound:534494090876682264>'*4} 0UB","#{'<:Unbind:534494090969088000>'*4} MUB"][x]}"
  disp=extend_message(disp,"__**Notes**__\n#{textra}",event,2) if textra.length>0
  disp=extend_message(disp,"__**Results**__",event,2) if char.length>0
  for i in 0...char.length
    disp=extend_message(disp,char[i][0],event)
  end
  event.respond disp
end

def sort_shareable_skills(event,args,bot,forcelist=false)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_in_adventurers(bot,event,args,2,2)
  unless forcelist
    k2=find_data_ex(:find_adventurer,args.join(' '),event,true)
    k2=find_data_ex(:find_adventurer,args.join(' '),event) if k2.nil? && !(!k.nil? && k.length>0 && k[1].length>0 && k[1].length<$adventurers.length)
  end
  sklz=$skills.map{|q| q}
  unless k2.nil?
    skl1=sklz.find_index{|q| q.name==k2.skills[0]}
    skl1=sklz[skl1].clone unless skl1.nil?
    skl2=sklz.find_index{|q| q.name==k2.skills[1]}
    skl2=sklz[skl2].clone unless skl2.nil?
    if (skl1.nil? || skl1.sharing.nil? || skl1.sharing.length<=0 || skl1.sharing.max<=0) && (skl2.nil? || skl2.sharing.nil? || skl2.sharing.length<=0 || skl2.sharing.max<=0)
      event.respond "#{k2.emotes(bot)}*#{k2.name}* does not have any skills that can be shared."
      return nil
    end
    disp_skill_data(bot,event,k2.skills[0].split(' '),(args.include?('tags')),topstr=["#{k2.emotes(bot)}*#{k2.name}* [S1]",k2.disp_color]) unless skl1.nil? || skl1.sharing.nil? || skl1.sharing.length<=0 || skl1.sharing.max<=0
    disp_skill_data(bot,event,k2.skills[1].split(' '),(args.include?('tags')),topstr=["#{k2.emotes(bot)}*#{k2.name}* [S2]",k2.disp_color]) unless skl2.nil? || skl2.sharing.nil? || skl2.sharing.length<=0 || skl2.sharing.max<=0
    return nil
  end
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a.name.gsub('*','')<=>b.name.gsub('*','')}.uniq
  textra=k[3]
  textra="**No adventurers match your search**" if char.length<=0
  char2=[]
  for i in 0...char.length
    if char[i].name.include?(' *[S1/2]*') || char[i].name.include?(' *[S1]*')
      skz=sklz.find_index{|q| q.name==char[i].skills[0]}
      unless skz.nil?
        skz=sklz[skz].clone
        skz.sort_data=["#{char[i].emotes(bot)}#{char[i].name.split(' *[')[0]} *[S2]*: #{skz.name} - #{skz.sharing[0]}<:SkillShare:714597012733034547>, #{skz.sharing[1]} SP","#{char[i].name.split(' *[')[0]} - #{skz.name}",skz.sharing[0],skz.sharing[1]]
        char2.push(skz)
      end
    end
    if char[i].name.include?(' *[S1/2]*') || char[i].name.include?(' *[S2]*')
      skz=sklz.find_index{|q| q.name==char[i].skills[1]}
      unless skz.nil?
        skz=sklz[skz].map{|q| q}
        skz.sort_data=["#{char[i].emotes(bot)}#{char[i].name.split(' *[')[0]} *[S2]*: #{skz.name} - #{skz.sharing[0]}<:SkillShare:714597012733034547>, #{skz.sharing[1]} SP","#{char[i].name.split(' *[')[0]} - #{skz.name}",skz.sharing[0],skz.sharing[1]]
        char2.push(skz)
      end
    end
  end
  tx=0
  bx=0
  costlimit=[0,100]
  splimit=[0,100000]
  sortbysp=false
  for i in 0...args.length
    sortbysp=true if ['sp'].include?(args[i].downcase)
    if args[i].downcase[0,3]=='top' && tx.zero?
      tx=[args[i][3,args[i].length-3].to_i,char.length].min
    elsif args[i].downcase[0,6]=='bottom' && bx.zero?
      bx=[args[i][6,args[i].length-6].to_i,char.length].min
    elsif args[i].downcase[0,6]=='cost>=' && args[i][6,args[i].length-6].to_i.to_s==args[i][6,args[i].length-6] && args[i][6,args[i].length-6].to_i<10
      costlimit[0]=args[i][6,args[i].length-6].to_i unless args[i][6,args[i].length-6].to_i<costlimit[0]
    elsif args[i].downcase[0,6]=='cost<=' && args[i][6,args[i].length-6].to_i.to_s==args[i][6,args[i].length-6] && args[i][6,args[i].length-6].to_i>0
      costlimit[1]=args[i][6,args[i].length-6].to_i unless args[i][6,args[i].length-6].to_i>costlimit[1]
    elsif args[i].downcase[0,5]=='cost>' && args[i][5,args[i].length-5].to_i.to_s==args[i][5,args[i].length-5] && args[i][5,args[i].length-5].to_i<10
      costlimit[0]=args[i][5,args[i].length-5].to_i+1 unless args[i][5,args[i].length-5].to_i+1<costlimit[0]
    elsif args[i].downcase[0,5]=='cost<' && args[i][5,args[i].length-5].to_i.to_s==args[i][5,args[i].length-5] && args[i][5,args[i].length-5].to_i>0
      costlimit[1]=args[i][5,args[i].length-5].to_i-1 unless args[i][5,args[i].length-5].to_i-1>costlimit[1]
    elsif args[i].downcase[0,5]=='cost=' && args[i][5,args[i].length-5].to_i.to_s==args[i][5,args[i].length-5] && args[i][5,args[i].length-5].to_i>0
      costlimit[0]=args[i][5,args[i].length-5].to_i unless args[i][5,args[i].length-5].to_i<costlimit[0]
      costlimit[1]=args[i][5,args[i].length-5].to_i unless args[i][5,args[i].length-5].to_i>costlimit[1]
    elsif ['sp>','sp<','sp='].include?(args[i].downcase[0,3])
      var=args[i].downcase.gsub(',','') # removing commas
      var=var[2,var.length-2]
      var="#{var[0,var.length-1]}000" if var[-1]=='k' # adjusting k for thousands
      if var[0,2]=='>=' && var[2,var.length-2].to_i.to_s==var[2,var.length-2]
        splimit[0]=var[2,var.length-2].to_i unless var[2,var.length-2].to_i<splimit[0]
      elsif var[0,2]=='<=' && var[2,var.length-2].to_i.to_s==var[2,var.length-2]
        splimit[1]=var[2,var.length-2].to_i unless var[2,var.length-2].to_i>splimit[1]
      elsif var[0,1]=='>' && var[1,var.length-1].to_i.to_s==var[1,var.length-1]
        splimit[0]=var[1,var.length-1].to_i+1 unless var[1,var.length-1].to_i+1<splimit[0]
      elsif var[0,1]=='<' && var[1,var.length-1].to_i.to_s==var[1,var.length-1]
        splimit[1]=var[1,var.length-1].to_i+1 unless var[1,var.length-1].to_i-1>splimit[1]
      elsif var[0,1]=='=' && var[1,var.length-1].to_i.to_s==var[1,var.length-1]
        splimit[0]=var[2,var.length-2].to_i unless var[2,var.length-2].to_i<splimit[0]
        splimit[1]=var[1,var.length-1].to_i unless var[1,var.length-1].to_i>splimit[1]
      end
    end
  end
  costlimit.reverse! if costlimit[0]>costlimit[1]
  splimit.reverse! if splimit[0]>splimit[1]
  char=char2.map{|q| q.sort_data}
  char=char.reject{|q| q[2]<costlimit[0] || q[2]>costlimit[1] || q[3]<splimit[0] || q[3]>splimit[1]}
  char=char.sort{|a,b| (supersort(a,b,2)==0) ? (supersort(b,a,1)) : (supersort(a,b,2))}
  char=char.sort{|a,b| (supersort(a,b,3)==0) ? ((supersort(a,b,2)==0) ? (supersort(b,a,1)) : (supersort(a,b,2))) : (supersort(a,b,3))} if sortbysp
  if tx>0
    char=char[0,tx]
  elsif bx>0
    char=char[char.length-bx,bx]
  end
  if !safe_to_spam?(event) && char.length>10
    textra="#{textra}#{"\n\n" if textra.length>0}Too much data is trying to be displayed.  Showing top ten results.\nYou can also make things easier by making the list shorter with words like `top#{rand(10)+1}` or `bottom#{rand(10)+1}`"
    char=char[0,10]
  end
  if costlimit[0]!=0 && costlimit[1]!=100
    if costlimit.uniq.length<2
      search.push("*Cost of #{longFormattedNumber(costlimit[1])}*")
    else
      search.push("*Cost between #{costlimit.map{|q| longFormattedNumber(q)}.join(' and ')} (inclusive)*")
    end
  elsif costlimit[0]!=0
    search.push("*Cost >= #{longFormattedNumber(costlimit[0])}*")
  elsif costlimit[1]!=100
    search.push("*Cost <= #{longFormattedNumber(costlimit[1])}*")
  end
  if splimit[0]!=0 && splimit[1]!=100000
    if splimit.uniq.length<2
      search.push("*SP of #{longFormattedNumber(splimit[1])}*")
    else
      search.push("*SP between #{splimit.map{|q| longFormattedNumber(q)}.join(' and ')} (inclusive)*")
    end
  elsif splimit[0]!=0
    search.push("*SP >= #{longFormattedNumber(splimit[0])}*")
  elsif splimit[1]!=100000
    search.push("*SP <= #{longFormattedNumber(splimit[1])}*")
  end
  search.push("*Sorted By:* #{'SP cost, ' if sortbysp}<:SkillShare:714597012733034547>Skill Share cost, Adventurer name")
  disp="__**Adventurer Search**__\n#{search.join("\n")}"
  disp=extend_message(disp,"__**Notes**__\n#{textra}",event,2) if textra.length>0
  disp=extend_message(disp,"__**Results**__",event,2) if char.length>0
  for i in 0...char.length
    disp=extend_message(disp,char[i][0],event)
  end
  event.respond disp
end

def sort_things(bot,event,args)
  if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    args.shift
    sort_adventurers(bot,event,args)
  elsif ['skill','share','shared','skillshare'].include?(args[0].downcase)
    args.shift
    sort_shareable_skills(event,args,bot,true)
  elsif ['dragon','dragons','drg','drag','drgs','drags'].include?(args[0].downcase)
    args.shift
    sort_dragons(bot,event,args)
  elsif ['wyrmprint','wyrm','print','wyrmprint','wyrm','print'].include?(args[0].downcase)
    args.shift
    sort_wyrmprints(bot,event,args)
  elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(args[0].downcase)
    args.shift
    sort_weapons(bot,event,args)
  end
  return nil
end

# additional commands

def disp_art(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    args.shift
    k=find_data_ex(:find_adventurer,args.join(' '),event)
  elsif ['dragon','dragons','drg'].include?(args[0].downcase) && !(!find_data_ex(:find_wyrmprint,args.join(' '),event,true).nil? && find_data_ex(:find_wyrmprint,args.join(' '),event,true).name[0,7].downcase=='dragon '.downcase)
    args.shift
    k=find_data_ex(:find_dragon,args.join(' '),event)
  elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
    args.shift
    k=find_data_ex(:find_wyrmprint,args.join(' '),event)
  elsif ['enemy','boss'].include?(args[0].downcase)
    args.shift
    k=find_data_ex(:find_enemy,args.join(' '),event)
  elsif ['emote','emoji','sticker'].include?(args[0].downcase)
    args.shift
    k=find_data_ex(:find_sticker,args.join(' '),event)
  elsif ['npc'].include?(args[0].downcase)
    args.shift
    k=find_data_ex(:find_npc,args.join(' '),event)
  else
    k=find_best_match(args.join(' '),bot,event,false,true,2)
  end
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  hdr="__**#{k.name}**__#{k.emotes(bot)}"
  mx=k.portrait(event)
  title=mx[1]
  xpic=[nil,mx[0]]
  rar=mx[2]
  ftr=nil
  str=''
  if k.is_a?(DLWyrmprint)
    title=nil
    str=mx[1]
    if k.charas.nil?
    elsif has_any?(['mub','unbind','unbound','refined','refine','refinement','2ub','3ub'],evn)
      c=k.charas[-1].map{|q| q}
    else
      c=k.charas[0].map{|q| q}
      ftr='Include the word "refined" for MUB art.'
    end
  elsif k.is_a?(DLSticker)
    ftr='Include the word "JP" to show the Japanese version of this emote.' unless has_any?(['jp','japan'],evn)
    c=k.charas.map{|q| q} unless k.charas.nil?
  end
  flds=[]
  xartist=''; vana=[]; vajp=[]; m=[]
  m.push("**Artist:** #{k.artist.split(' & ').map{|q| q.split(' as ')[-1]}.join(' & ')}") unless k.artist.nil?
  m.push("**VA (English):** #{k.voice_na.split(' & ').map{|q| q.split(' as ')[-1]}.join(' & ')}") unless k.voice_na.nil?
  m.push("**VA (Japanese):** #{k.voice_jp.split(' & ').map{|q| q.split(' as ')[-1]}.join(' & ')}") unless k.voice_jp.nil?
  xartist=k.artist.split(' as ')[0] unless k.artist.nil?
  vana=k.voice_na.split(' & ').map{|q| q.split(' as ')[0]} unless k.voice_na.nil? || k.voice_na.length<=0
  vajp=k.voice_jp.split(' & ').map{|q| q.split(' as ')[0]} unless k.voice_jp.nil? || k.voice_jp.length<=0
  str="#{str}#{"\n\n" if str.length>0}#{m.join("\n")}"
  toload=['feh']
  toload.push('fgo') if event.server.nil? || !bot.user(502288364838322176).on(event.server.id).nil? || Shardizard==4
  data_load(toload)
  fehunits=[]
  fehunits=$feh_units.map{|q| q.clone} # if event.server.nil? || !bot.user(312451658908958721).on(event.server.id).nil? || !bot.user(627511537237491715).on(event.server.id).nil? || Shardizard==4
  fgosrv=[]; fgoce=[]
  if toload.include?('fgo')
    fgosrv=$fgo_servants.reject{|q| q.id.to_i != q.id.to_f}.map{|q| q.clone}
    fgoce=$fgo_crafts.map{|q| q.clone}
  end
  if k.is_a?(DLSentient)
    adv=[$adventurers,$dragons,$npcs,fehunits,fgosrv].flatten.map{|q| q.clone}.uniq
    voices=[]
    for i in 0...adv.length
      a=adv[i].clone
      a.name="*[FEH]* #{a.name}" if a.is_a?(FEHUnit)
      a.name="*[FGO-Srv #{a.tid}]* #{a.name}" if a.is_a?(FGOServant)
      vana2=[]; vajp2=[]
      if a.is_a?(FEHUnit)
        vana2=a.voice_na unless a.voice_na.nil?
        if a.id==110 && vana.include?('Sara Beth')
          a.voice_na='Sara Beth'
          a.name=a.name.gsub('*[FEH]*','*[FEH-Resplendent]*')
        elsif vana.include?('Alexis Tipton') && vana2.include?('Laura Bailey')
          a.voice_na=a.voice_na.map{|q| q.gsub('Laura Bailey','Alexis Tipton')}.join(' & ')
          a.name=a.name.gsub('*[FEH]*','*[FEH-Resplendent]*')
        end
        vajp2=a.voice_jp unless a.voice_jp.nil?
      else
        vana2=a.voice_na.split(' & ') unless a.voice_na.nil?
        vajp2=a.voice_jp.split(' & ') unless a.voice_jp.nil?
      end
      if a.name==k.name && (k.objt==a.objt || (k.is_a?(DLDragon) && a.is_a?(DLAdventurer) && k.isPseudodragon?))
      elsif vana.length<2 && vajp.length<2
        if !k.voice_na.nil? && !k.voice_jp.nil? && k.voice_na==a.voice_na && k.voice_jp==adv[i].voice_jp
          a.name="#{a.name} *[Both]*"
          voices.push(a)
        elsif !k.voice_na.nil? && k.voice_na==a.voice_na
          a.name="#{a.name} *[English]*"
          voices.push(a)
        elsif !k.voice_jp.nil? && k.voice_jp==a.voice_jp
          a.name="#{a.name} *[Japanese]*"
          voices.push(a)
        end
      elsif vana2.length<2 && vajp2.length<2
        vana2=vana2[0]; vajp2=vajp2[0]
        e=[]; j=[]
        for i2 in 0...vana.length
          e.push("#{i2+1}") if vana[i2]==vana2
        end
        for i2 in 0...vajp.length
          j.push("#{i2+1}") if vajp[i2]==vajp2
        end
        v=e.reject{|q| !j.include?(q)}
        e=e.reject{|q| v.include?(q)}
        j=j.reject{|q| v.include?(q)}
        m=[]
        if e.length<=0 && j.length<=0 && v.length>0
          m.push("Voice #{v.join('+')}")
        elsif e.length<=0 && j.length>0 && v.length<=0
          m.push("Japanese #{j.join('+')}")
        elsif e.length>0 && j.length<=0 && v.length<=0
          m.push("English #{e.join('+')}")
        else
          m.push("voice #{v.join('+').downcase}") if v.length>0
          m.push("E#{e.join('+').downcase}") if e.length>0
          m.push("J#{j.join('+').downcase}") if j.length>0
        end
        a.name="#{a.name} *[#{m.join(', ')}]*"
        voices.push(a) if m.length>0
      end
    end
    unless voices.length<=0
      m='Same VA'
      if voices.reject{|q| q.name.split('*[')[-1]==voices[0].name.split('*[')[-1]}.length<=0
        m="Same VA (#{voices[0].name.split('*[')[-1].gsub(']*','')})"
      end
      voices=voices.sort{|a,b| (a.objt<=>b.objt)==0 ? ((a.tid<=>b.tid)==0 ? (a.name<=>b.name) : (a.tid<=>b.tid)) : (a.objt<=>b.objt)}
      voices.uniq!
      voices=voices.map{|q| q.name}
      voices=voices.map{|q| q.split('*[')[0]} if m.include?('(')
      flds.push([m,voices.uniq.join("\n")])
    end
    adv=[$wyrmprints.reject{|q| q.isMultiprint?},$stickers].flatten.map{|q| q.clone}.uniq
    appearances=[]
    nnn="#{k.name}"
    nnn="Mym" if k.name=='Brunhilda' && ['Human','Kimono','Damaged'].include?(rar)
    for i in 0...adv.length
      a=adv[i].clone
      if a.charas.nil?
      elsif a.is_a?(DLSticker)
        a.name="#{a.name} *[Sticker]*"
        appearances.push(a) if a.charas.include?(nnn)
      elsif a.charas[0].include?(nnn) && a.charas[-1].include?(nnn)
        appearances.push(a)
      elsif a.charas[0].include?(nnn)
        a.name="#{a.name} *[Base]*"
        appearances.push(a)
      elsif a.charas[-1].include?(nnn)
        a.name="#{a.name} *[Refined]*"
        appearances.push(a)
      end
    end
    unless appearances.length<=0
      m='Appears in the following'
      if appearances.reject{|q| q.name.include?('*[Sticker]*')}.length<=0
        m='Appears in the following stickers'
      elsif appearances.reject{|q| !q.name.include?('*[Sticker]*')}.length<=0
        m='Appears in the following wyrmprints'
      end
      appearances=appearances.sort{|a,b| (a.objt<=>b.objt)==0 ? (a.name<=>b.name) : (b.objt<=>a.objt)}
      appearances.uniq!
      appearances=appearances.map{|q| q.name}
      appearances=appearances.map{|q| q.gsub(' *[Sticker]*','')} if m=='Appears in the following stickers'
      flds.push([m,appearances.uniq.join("\n")])
    end
  elsif k.is_a?(DLWyrmprint) && xartist.length>0
    adv=[$wyrmprints.reject{|q| q.isMultiprint?},fehunits,fgosrv,fgoce].flatten.map{|q| q.clone}.uniq
    artists=[]
    for i in 0...adv.length
      a=adv[i].clone
      a.name="*[FGO-Srv #{a.tid}]* #{a.name}" if a.is_a?(FGOServant)
      a.name="*[FGO-CE #{a.tid}]* #{a.name}" if a.is_a?(FGO_CE)
      if a.artist.nil? || a.artist.length<=0 || (a.is_a?(DLWyrmprint) && a.name==k.name)
      elsif a.is_a?(FEHUnit)
        if a.artist[0].split(' as ')[0]==xartist
          a.name="*[FEH]* #{a.name}"
          artists.push(a)
        elsif a.artist.length>1 && a.artist[1].split(' as ')[0]==xartist
          a.name="*[FEH-Resplendent]* #{a.name}"
          artists.push(a)
        end
      else
        artists.push(a) if a.artist.split(' as ')[0]==xartist
      end
    end
    unless artists.length<=0
      artists=artists.sort{|a,b| (a.objt<=>b.objt)==0 ? ((a.tid<=>b.tid)==0 ? (a.name<=>b.name) : (a.tid<=>b.tid)) : (a.objt<=>b.objt)}.map{|q| q.name}.uniq
      flds.push(['Same artist',artists.uniq.join("\n")])
    end
  end
  unless c.nil? || c.length<=0
    flds.push(['Characters in art',c.sort.join("\n")]) unless k.is_a?(DLSticker)
    str="#{str}#{"\n\n" if str.length>0}**Characters in art:** #{c.sort.join(', ')}" if k.is_a?(DLSticker)
  end
  m=flds.map{|q| q[1].split("\n").length}
  flds=flds.map{|q| q[0,2]} if flds.length<3
  titlength=0
  titlength=title.length unless title.nil?
  if m.inject(0){|sum,x2| sum + x2 }>25 && !safe_to_spam?(event)
    str="#{str}\n\nThere were too many datapoints to display them all.  Please use this command in PM."
    flds=[]
  elsif flds.length<=0
  elsif flds.length<=1 && !($embedless.include?(event.user.id) || was_embedless_mentioned?(event)) && flds[0][1].split("\n").length<=5
    str="#{str}\n\n__*#{flds[0][0]}*__\n#{flds[0][1]}"
    flds=[]
  elsif flds.length<=1 && !($embedless.include?(event.user.id) || was_embedless_mentioned?(event))
    str="#{str}\n\n#{flds[0][0]}"
    flds=triple_finish(flds[0][1].split("\n"),true)
  elsif $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || hdr.length+titlength+str.length+flds.map{|q| "__*#{q[0]}*__\n#{q[1]}"}.join("\n\n").length>1900 || m.max>25
    str2=''
    for i in 0...flds.length
      if "**#{flds[i][0]}:** #{flds[i][1].gsub("\n",' - ')}".length>1500
        flds[i][1]=flds[i][1].split("\n")
        str2=extend_message(str2,"**#{flds[i][0]}:** #{flds[i][1][0]}",event)
        for i2 in 1...flds[i][1].length
          str2=extend_message(str2,flds[i][1][i2],event,1,' - ')
        end
      else
        str2=extend_message(str2,"**#{flds[i][0]}:** #{flds[i][1].gsub("\n",' - ')}",event)
      end
    end
    event.respond str2
    flds=[]
  end
  flds=nil if flds.length<=0
  create_embed(event,[hdr,title],str,k.disp_color,ftr,xpic,flds)
  event.respond xpic[1] if $embedless.include?(event.user.id) || was_embedless_mentioned?(event)
end

def disp_alts(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    args.shift
    kx=find_data_ex(:find_adventurer,args.join(' '),event)
  elsif ['dragon','dragons','drg'].include?(args[0].downcase)
    args.shift
    kx=find_data_ex(:find_dragon,args.join(' '),event)
  else
    kx=find_best_match(args.join(' '),bot,event,false,false,4)
  end
  if kx.nil?
    event.respond 'No matches found.'
    return nil
  end
  dname=kx.alts[0].gsub('*','')
  k=[$adventurers,$dragons].flatten.reject{|q| q.alts.nil? || q.alts[0].nil? || q.alts[0].gsub('*','')!=dname}.uniq
  untz2=[]
  color=[]
  for i in 0...k.length
    color.push(k[i].disp_color)
    m=[]
    m.push('default') if k[i].name==k[i].alts[0] || k[i].alts[0][k[i].alts[0].length-1,1]=='*'
    m.push('default') if k[i].alts[0][0,1]=='*' && k[i].alts.length>1
    m.push('sensible') if k[i].alts[0][0,1]=='*' && k[i].alts.length<2
    m.push('seasonal') if k[i].availability.include?('s')
    m.push('~~seasonal~~') if k[i].availability.include?('f')
    m.push('Gala') if k[i].name[0,5]=='Gala ' && m.length<=0
    m.push('out-of-left-field') if m.length<=0
    n=''
    unless k[i].name==k[i].alts[0] || k[i].alts[k[i].alts.length-1,1]=='*'
      k2=k.reject{|q| q.alts[0].gsub('*','')!=k[i].alts[0].gsub('*','') || q.name==k[i].name || !(q.name==q.alts[0] || q.alts[0].include?('*'))}
      n='x' if k2.length<=0
    end
    if kx.objt==k[i].objt
      untz2.push(["#{k[i].name}#{k[i].emotes(bot)} - #{m.uniq.join(', ')}",k[i].alts.map{|q| q.gsub('*','')}])
    elsif k[i].is_a?(DLAdventurer)
      untz2.push(["*[Adv]* #{k[i].name}#{k[i].emotes(bot)} - #{m.uniq.join(', ')}",k[i].alts.map{|q| q.gsub('*','')}])
    elsif k[i].is_a?(DLDragon)
      untz2.push(["*[Drg]* #{k[i].name}#{k[i].emotes(bot)} - #{m.uniq.join(', ')}",k[i].alts.map{|q| q.gsub('*','')}])
    end
  end
  if color.length.zero?
    color=0xFFD800
  else
    color=avg_color(color)
  end
  k2=k.map{|q| q.alts.length}
  k=k.map{|q| q.alts}
  str=''
  if k2.max>1
    k2=k.map{|q| q[1]}.uniq.map{|q| ["#{dname}(#{q})",[],q]}
    for i in 0...untz2.length
      for j in 0...k2.length
        k2[j][1].push(untz2[i][0]) if k2[j][2]==untz2[i][1][1]
      end
    end
    for i in 0...k2.length
      k2[i][0]="**Facet #{i+1}: #{k2[i][0]}**"
      k2[i][1]=k2[i][1].join("\n")
      k2[i][2]=1
      k2[i].compact!
      k2[i]=nil if k2[i][1].length<=0
    end
    k2.compact!
  else
    str=untz2.map{|q| q[0]}.join("\n")
    k2=nil
  end
  create_embed(event,"__**#{dname}**__",str,color,nil,nil,k2,2)
end

def list_aliases(bot,event,args=nil,saliases=false,dispdata=false)
  if args.nil? || args.length.zero?
    args=event.message.text.downcase.split(' ')
    args.shift
  end
  data_load()
  nicknames_load()
  easylist=['adventurer','adventurers','adv','advs','dragon','dragons','drag','drags','drg','drgs','wyrmprint','wyrm','print','wyrmprints','wyrms','prints','weapon','weapons','wpns',
            'wpnz','wpn','weps','wepz','wep','weaps','weapz','weap','enemies','boss','enemy','bosses','enemie','enemys','bosss','gauntlet','npc','npcs','emote','emotes','sticker',
            'stickers','facility','faculty','fac','facilitys','faculty','facs','facilities','faculties','mat','mats','materials','material','item','items','status','ailment','skls',
            'affliction','skill','skills','skl','skil','skils','abil','ability','abilitys','abilities','abils','coabil','coability','coabilitys','coabilities','coabils','coab','coabs',
            'aura','auras','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains',
            'chain','coabilchains','coabchain','coabchains','cca','cc','ccas','banner','banners','focus','focuses','summon','summons','summoning','summonings']
  len=3
  len=5 if (args.length<=0 || easylist.include?(args[0].downcase)) && safe_to_spam?(event) && !dispdata
  (event.channel.send_temporary_message('Calculating data, please wait...',len) rescue nil) unless dispdata
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=nil
  k=find_best_match(args.join(' '),bot,event,false,false,0) unless (args.length<=0 || easylist.include?(args[0].downcase))
  k=k[0] if !k.nil? && k.is_a?(Array)
  args=[''] if args.nil? || args.length<=0
  if k.nil? && (!safe_to_spam?(event) || event.server.id==350067448583553024) && !(saliases && !event.server.nil? && $aliases.reject{|q| q[3].nil? || !q[3].include?(event.server.id)}.length<=20)
    alz=args.join(' ')
    alz='>censored mention<' if alz.include?('@')
    str="The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Enemies\n- Skills\n- Abilities (including Auras, CoAbilities, Chain CoAbilities)\n- Facilities\n- Materials\n- Stickers\n- NPCs\n- Statuses"
    str="#{str}\n\n*#{alz}* does not fall into any of these categories." if alz.length>0
    str="#{str}\n\nPlease include what you wish to look up the aliases for, or use this command in PM.\nBut if you do that, prepare to be getting messages for a long time.  There's #{longFormattedNumber($aliases.length)} of them." if alz.length<=0
    event.respond str
    return nil
  elsif ['banner','banners','focus','focuses','summon','summons','summoning','summonings'].include?(args[0].downcase)
    f=["__**#{'Server-specific ' if saliases}Banner Aliases**__"]
    b=$banners.map{|q| q}
    unless saliases
      for i in 0...b.length
        for i2 in 0...b[i].aliases.length
          f.push("#{b[i].aliases[i2]} = #{b[i].name}")
        end
      end
    end
  elsif easylist.include?(args[0].downcase)
    alztyp=''
    alztyp='Adventurer' if ['adventurer','adventurers','adv','advs'].include?(args[0].downcase)
    alztyp='Dragon' if ['dragon','dragons','drag','drags','drg','drgs'].include?(args[0].downcase)
    alztyp='Wyrmprint' if ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
    alztyp='Weapon' if ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(args[0].downcase)
    alztyp='Enemy' if ['enemies','boss','enemy','bosses','enemie','enemys','bosss','gauntlet'].include?(args[0].downcase)
    alztyp='NPC' if ['npc','npcs'].include?(args[0].downcase)
    alztyp='Sticker' if ['emote','emotes','sticker','stickers'].include?(args[0].downcase)
    alztyp='Facility' if ['facility','faculty','fac','facilitys','faculty','facs','facilities','faculties'].include?(args[0].downcase)
    alztyp='Material' if ['mat','mats','materials','material','item','items'].include?(args[0].downcase)
    alztyp='Status' if ['status','ailment','affliction'].include?(args[0].downcase)
    alztyp='Skill' if ['skill','skills','skls','skl','skil','skils'].include?(args[0].downcase)
    alztyp='Ability' if ['abil','ability','abilitys','abilities','abils','coabil','coability','coabilitys','coabilities','coabils','coab','coabs','aura','auras','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc','ccas'].include?(args[0].downcase)
    x=$aliases.reject{|q| q[0]!=alztyp}
    x=x.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    x=x.reject{|q| q[3].nil?} if saliases
    f=["__**#{'Server-specific ' if saliases}#{alztyp} Aliases**__"]
    if event.server.nil?
      for i in 0...x.length
        str="#{x[i][1].gsub('`',"\`").gsub('*',"\*")} = #{x[i][2]}"
        if q[3].nil?
          f.push(str)
        else
          f2=[]
          for j in 0...x[i][3].length
            srv=(bot.server(x[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f2.push("*#{bot.server(x[i][3][j]).name}*") unless event.user.on(x[i][3][j]).nil?
            end
          end
          f.push("#{str} (in the following servers: #{list_lift(f2,'and')})") unless f2.length<=0
        end
      end
    else
      f=x.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")} = #{q[2]}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
      f.unshift("__**#{'Server-specific ' if saliases}#{alztyp} Aliases**__")
    end
  elsif args.length>0 && args[0].length>0 && k.nil?
    alz=args.join(' ')
    alz='>censored mention<' if alz.include?('@')
    str="The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Enemies\n- Skills\n- Abilities (including Auras, CoAbilities, Chain CoAbilities)\n- Facilities\n- Materials\n- Stickers\n- NPCs\n- Statuses"
    str="#{str}\n\n*#{alz}* does not fall into any of these categories."
    event.respond str
    return nil
  elsif k.nil?
    nicknames_load()
    f=list_aliases(bot,event,['adventurers'],saliases,true)
    f.push(' ')
    f.push(list_aliases(bot,event,['dragons'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['wyrmprint'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['weapon'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['enemy'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['skill'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['ability'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['facility'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['mat'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['sticker'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['npc'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['status'],saliases,true))
    f.push(' ')
    f.push(list_aliases(bot,event,['banner'],saliases,true))
    f.flatten!
  else
    f=k.alias_list(bot,event,saliases)
  end
  return f if dispdata
  if (f.join("\n").length>1900 || f.length>50) && !safe_to_spam?(event)
    event.respond "There are so many aliases that I don't want to spam the server.  Please use the command in PM."
    return nil
  end
  str=f[0]
  for i in 1...f.length
    str=extend_message(str,f[i],event)
  end
  event.respond str
end

def get_multiple_things(callback,bot,event,args=[],maxthings=0,includeunaffected=false)
  args=event.message.text.downcase.split(' ') if args.nil? || args.length<=0
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  data_load()
  event.channel.send_temporary_message('Calculating data, please wait...',5) rescue nil
  a=true
  s=args.join(' ')
  s2="#{s}"
  k=[]
  u=0
  while a && s.length>0
    args=s.split(' ')
    x=find_data_ex(callback,args.join(' '),event,false,false,true)
    if x.nil? || x.length<=0
      a=false
    else
      k.push(x[0])
      s=first_sub(s,x[1],'')
      u+=1
      s2=first_sub(s2,x[1],x[0].name.gsub(' ','_'))
    end
    a=false if maxthings>0 && u>=maxthings
  end
  return [k.flatten,s2] if includeunaffected
  return k.flatten
end

def adv_chain_list(event,args,bot)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=get_multiple_things(:find_adventurer,bot,event,args,0,true)
  if k.nil? || k.length<=0 || k[0].nil? || k[0].length<=0
    event.respond "No matches found."
    return nil
  end
  s=k[1].split(' ')
  k=k[0]
  limit=false
  str='__***Team***__'
  k4=[]
  xseed=['HP','Strength']
  for i in 0...k.length
    if k4.length>=4
      if limit
        str=extend_message(str,"~~#{k[i].name}#{k[i].emotes(bot)}~~",event)
      else
        limit=true
        str=extend_message(str,"~~#{k[i].name}#{k[i].emotes(bot)}~~ - team limit reached",event)
      end
    elsif k4.map{|q| q.alts[0]}.include?(k[i].alts[0]) && !has_any?(['altteam','alteam'],s)
      alta=k[i].alts[0]
      alta='Mym' if alta=='Brunhilda'
      alta='Latha' if alta=='Nyarlathotep'
      str=extend_message(str,"~~#{k[i].name}#{k[i].emotes(bot)}~~ - #{alta} already on team",event)
    else
      str=extend_message(str,"**#{k[i].name}#{k[i].emotes(bot)}**",event)
      xseed.push("(#{k[i].element}) HP"); xseed.push("(#{k[i].element}) Strength")
      xseed.push("(#{k[i].weapon}) HP"); xseed.push("(#{k[i].weapon}) Strength")
      k4.push(k[i].clone)
    end
  end
  xseed.uniq!
  romanums=['Ox0','I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII','XVIII','XIX','XX','XXI','XXII','XXIII','XXIV','XXV','XXVI','XXVII',
            'XXVIII','XXIX','XXX','XXXI','XXXII','XXXIII','XXXIV','XXXV','XXXVI','XXXVII','XXXVIII','XXXIX','XL','XLI','XLII','XLII','XLIII','XLIV','XLV','XLVI','XLVII','XLVIII',
            'XLIX','L']
  coabilities=[]; chains=[]
  for i in 0...k4.length
    co=k4[i].coability
    if co.include?(' & ')
      co=co.split(' ')
      co=[co[0,co.length-1].join(' ').split(' & '),co[-1]]
      if co[0].include?('HP') || co[0].include?('Strength') || co[0].include?('Defense')
        co[0]=co[0].join(' & ')
        coabilities.push(co.join(' '))
      elsif co[0][0,co[0].length-1].reject{|q| !q.include?('%') && !q.include?('/')}.length>0
        co[0][-1]="#{co[0][-1]} #{co[-1]}"
        coabilities.push(co[0])
      elsif co[-1].include?('%') || co[-1].include?('/') || co[-1].to_i.to_s==co[-1]
        coabilities.push(co[0].map{|q| "#{q} #{co[-1]}"})
      else
        co[0][-1]="#{co[0][-1]} #{co[-1]}"
        coabilities.push(co[0])
      end
    else
      coabilities.push(co)
    end
    cc=k4[i].chain
    if cc.include?(' & ')
      cc=cc.split(' ')
      cc=[cc[0,cc.length-1].join(' ').split(' & '),cc[-1]]
      if cc[0].include?('HP') || cc[0].include?('Strength') || cc[0].include?('Defense')
        cc[0]=cc[0].join(' & ')
        chains.push(cc.join(' '))
      elsif cc[0][0,cc[0].length-1].reject{|q| !q.include?('%') && !q.include?('/')}.length>0
        cc[0][-1]="#{cc[0][-1]} #{cc[-1]}"
        chains.push(cc[0])
      elsif cc[-1].include?('%') || cc[-1].include?('/') || cc[-1].to_i.to_s==cc[-1]
        chains.push(cc[0].map{|q| "#{q} #{cc[-1]}"})
      else
        cc[0][-1]="#{cc[0][-1]} #{cc[-1]}"
        chains.push(cc[0])
      end
    else
      chains.push(cc)
    end
  end
  coabilities.flatten!; chains.flatten!
  for i in 0...coabilities.length
    coabilities[i]=coabilities[i].gsub("(#{k4[0].element}) ",'') if k4.map{|q| q.element}.uniq.length<=1
    coabilities[i]=coabilities[i].gsub("(#{k4[0].weapon}) ",'') if k4.map{|q| q.weapon}.uniq.length<=1
    coabilities[i]=coabilities[i].gsub('Divine Grace ','Recovery Potency ')
    coabilities[i]=coabilities[i].gsub(' Boost ',' Damage ') if ['Flame Boost','Water Boost','Wind Boost','Light Boost','Shadow Boost'].include?(coabilities[i].split(' ')[0,2].join(' '))
    coabilities[i]=coabilities[i].split(' ')
    if coabilities[i][-1].include?('/')
      coabilities[i][-1]=coabilities[i][-1].split('/')[-1].gsub('+','')
      if coabilities[i][-1].include?('%')
        coabilities[i]=[coabilities[i][0,coabilities[i].length-1].join(' '),coabilities[i][-1].gsub('%','').to_i,'Percent']
      elsif !romanums.find_index{|q| q==coabilities[i][-1]}.nil?
        coabilities[i]=[coabilities[i][0,coabilities[i].length-1].join(' '),coabilities[i][-1],'Roman']
      elsif coabilities[i][-1].to_i.to_s==coabilities[i][-1]
        coabilities[i]=[coabilities[i][0,coabilities[i].length-1].join(' '),coabilities[i][-1].to_i,'Number']
      else
        coabilities[i]=[coabilities[i].join(' '),nil,'']
      end
    elsif coabilities[i][-1].include?('%')
      coabilities[i]=[coabilities[i][0,coabilities[i].length-1].join(' '),coabilities[i][-1].gsub('%','').gsub('+','').to_i,'Percent']
    elsif !romanums.find_index{|q| q==coabilities[i][-1]}.nil?
      coabilities[i]=[coabilities[i][0,coabilities[i].length-1].join(' '),coabilities[i][-1],'Roman']
    elsif coabilities[i][-1].to_i.to_s==coabilities[i][-1]
      coabilities[i]=[coabilities[i][0,coabilities[i].length-1].join(' '),coabilities[i][-1].to_i,'Number']
    else
      coabilities[i]=[coabilities[i].join(' '),nil,'']
    end
    coabilities[i][0]="#{coabilities[i][0]} [Coab]" if xseed.include?(coabilities[i][0])
  end
  for i in 0...chains.length
    chains[i]=chains[i].gsub("(#{k4[0].element}) ",'') if k4.map{|q| q.element}.uniq.length<=1
    chains[i]=chains[i].gsub("(#{k4[0].weapon}) ",'') if k4.map{|q| q.weapon}.uniq.length<=1
    chains[i]=chains[i].gsub('Divine Grace ','Recovery Potency ')
    chains[i]=chains[i].gsub(' Boost ',' Damage ') if ['Flame Boost','Water Boost','Wind Boost','Light Boost','Shadow Boost'].include?(chains[i].split(' ')[0,2].join(' '))
    chains[i]=chains[i].split(' ')
    if chains[i][-1].include?('/')
      chains[i][-1]=chains[i][-1].split('/')[-1].gsub('+','')
      if chains[i][-1].include?('%')
        chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1].gsub('%','').to_i,'Percent']
      elsif !romanums.find_index{|q| q==chains[i][-1]}.nil?
        chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1],'Roman']
      elsif chains[i][-1].to_i.to_s==chains[i][-1]
        chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1].to_i,'Number']
      else
        chains[i]=[chains[i].join(' '),nil,'']
      end
    elsif chains[i][-1].include?('%')
      chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1].gsub('%','').gsub('+','').to_i,'Percent']
    elsif !romanums.find_index{|q| q==chains[i][-1]}.nil?
      chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1],'Roman']
    elsif chains[i][-1].to_i.to_s==chains[i][-1]
      chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1].to_i,'Number']
    else
      chains[i]=[chains[i].join(' '),nil,'']
    end
    chains[i][0]="#{chains[i][0]} [Chain]" if xseed.include?(chains[i][0])
  end
  str2=[]
  str2.push("#{k4[0].rarity}#{$rarity_stars[0][k4[0].rarity]}") if k4.map{|q| q.rarity}.uniq.length<=1
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k4[0].element}"}
  str2.push("#{moji[0].mention unless moji.length<=0}#{k4[0].element}") if k4.map{|q| q.element}.uniq.length<=1
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k4[0].weapon}"}
  str2.push("#{moji[0].mention unless moji.length<=0}#{k4[0].weapon}") if k4.map{|q| q.weapon}.uniq.length<=1
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k4[0].clzz.gsub('Healer','Healing')}"}
  str2.push("#{moji[0].mention unless moji.length<=0}#{k4[0].clzz}") if k4.map{|q| q.clzz}.uniq.length<=1
  str=extend_message(str,"**#{str2.join(' ')} Synergy**",event) if str2.length>0 && k4.length>1
  m=coabilities.map{|q| [q[0],0,q[2]]}.uniq
  for i in 0...m.length
    if m[i][2].length<=0
      chains.push([m[i][0],nil,m[i][2]])
    else
      chains.push([m[i][0],coabilities.reject{|q| q[0]!=m[i][0] || q[2]!=m[i][2]}.map{|q| q[1]}.max,m[i][2]])
    end
  end
  m=chains.map{|q| [q[0],0,q[2]]}.uniq
  for i in 0...m.length
    if m[i][2].length<=0
      m[i]=m[i][0]
    else
      m2=chains.reject{|q| q[0]!=m[i][0] || q[2]!=m[i][2]}.map{|q| q[1]}
      x=''
      x='**' if m2.length>1
      m2=m2.inject(0){|sum,x| sum + x } unless m[i][2]=='Roman'
      m[i][1]=m2*1
    end
  end
  mmm=m.map{|q| q}
  elem_stats=[['',      0,0,0,0,0,0],
              ['Flame', 0,0,0,0,0,0],['Water', 0,0,0,0,0,0],['Wind',       0,0,0,0,0,0],['Light', 0,0,0,0,0,0],['Shadow', 0,0,0,0,0,0],
              ['Sword', 0,0,0,0,0,0],['Blade', 0,0,0,0,0,0],['Dagger',     0,0,0,0,0,0],['Axe',   0,0,0,0,0,0],['Bow',    0,0,0,0,0,0],['Lance', 0,0,0,0,0,0],
              ['Wand',  0,0,0,0,0,0],['Staff', 0,0,0,0,0,0],['Manacaster', 0,0,0,0,0,0]]
  for i in 0...m.length
    m[i][0]=m[i][0].gsub(' [Chain]','') unless mmm.map{|q| q[0].split(') ')[-1]}.include?(m[i][0].split(') ')[-1].gsub('~~','').gsub(' [Chain]',' [Coab]'))
    m[i][0]=m[i][0].gsub(' [Coab]','') unless mmm.map{|q| q[0].split(') ')[-1]}.include?(m[i][0].split(') ')[-1].gsub('~~','').gsub(' [Coab]',' [Chain]'))
    skillname=m[i][0].gsub(' [Chain]','').gsub(' [Coab]','')
    if m[i][2].length<=0
      m[i]=m[i][0]
    else
      m2=chains.reject{|q| q[0]!=m[i][0] || q[2]!=m[i][2]}.map{|q| q[1]}
      x=''
      x='**' if m2.length>1
      xx=''
      if m[i][2]=='Percent'
        xx="#{m[i][0]} #{x}+#{mmm[i][1]}%#{x}"
      elsif m[i][2]=='Roman'
        xx="#{m[i][0]} #{x}#{mmm[i][1].join('+')}#{x}"
      else
        xx="#{m[i][0]} #{x}#{mmm[i][1]}#{x}"
      end
      if m[i][0][0]=='('
        m3=m[i][0].split(') ')[-1]
        m4=chains.reject{|q| q[0]!=m3 || q[2]!=m[i][2]}.map{|q| q[1]}
        if m4.length<=0 || m[i][0].include?(' [Chain]') || m[i][0].include?(' [Coab]')
        elsif m[i][2]=='Roman'
          m5=m[i][0].split(') ')[0].gsub('(','')
          xx="#{xx}\n  \u00B7  For #{m5} adventurers, this sorta stacks with *#{m3}*"
        else
          m4=m4.inject(0){|sum,x| sum + x }
          m4+=mmm[i][1]
          m5=m[i][0].split(') ')[0].gsub('(','')
          xx="#{xx}\n  \u00B7  For #{m5} adventurers, this stacks with *#{m3}* for a total buff of"
          if m[i][2]=='Percent'
            xx="#{xx} **+#{m4}%**"
          else
            xx="#{xx} **#{m4}**"
          end
        end
      end
      m[i]="#{xx}"
    end
    m[i]="~~#{m[i]}~~" if (m[i].include?(' [Chain]') || m[i].include?(' [Coab]')) && (mmm.map{|q| q[0]}.include?(m[i][0].gsub('~~','').gsub(' [Chain]',' [Coab]')) || mmm.map{|q| q[0]}.include?(m[i][0].gsub('~~','').gsub(' [Coab]',' [Chain]')))
    if m[i].include?(' [Coab]')
      mx=mmm.find_index{|q| q[0]=="#{skillname} [Chain]"}
      my=mmm.find_index{|q| q[0]=="#{skillname} [Coab]"}
      if mx.nil? || my.nil? || elem_stats.map{|q| q[0]}.include?(m[i].split(') ')[0].gsub('(',''))
        p=m[i].gsub(' [Coab]','')
        p=m[i].split(') ')[1].gsub(' [Coab]','') if m[i].include?(') ')
        p2=0
        p2=1 if p.include?('HP')
        p2=2 if p.include?('Strength')
        p2=3 if p.include?('Defense')
        if elem_stats.map{|q| q[0]}.include?(m[i].split(') ')[0].gsub('(',''))
          p1=elem_stats.find_index{|q| q[0]==m[i].split(') ')[0].gsub('(','')}
          elem_stats[p1][p2]+=mmm[my][1]
        else
          elem_stats[0][p2]+=mmm[my][1]
        end
      else
        mx=mmm[mx][1]+100
        my=mmm[my][1]+100
        mz=mx*my/100.0-100
        m[i]="#{m[i]}\nThe above two, due to applying at different times in calculation, combine to effectively produce:\n#{skillname} **+#{'%.2f' % mz}%**"
      end
    elsif m[i].include?(' [Chain]')
      mx=mmm.find_index{|q| q[0]=="#{skillname} [Chain]"}
      p=m[i].gsub(' [Chain]','')
      p=m[i].split(') ')[1].gsub(' [Chain]','') if m[i].include?(') ')
      p2=0
      p2=4 if p.include?('HP')
      p2=5 if p.include?('Strength')
      p2=3 if p.include?('Defense')
      if elem_stats.map{|q| q[0]}.include?(m[i].split(') ')[0].gsub('(',''))
        p1=elem_stats.find_index{|q| q[0]==m[i].split(') ')[0].gsub('(','')}
        elem_stats[p1][p2]+=mmm[mx][1]
      else
        elem_stats[0][p2]+=mmm[mx][1]
      end
    elsif m[i][0,4]=='HP +'
      mx=mmm.find_index{|q| q[0]==skillname}
      elem_stats[0][1]+=mmm[mx][1]
    elsif m[i][0,10]=='Strength +'
      mx=mmm.find_index{|q| q[0]==skillname}
      elem_stats[0][2]+=mmm[mx][1]
    elsif m[i][0,9]=='Defense +'
      mx=mmm.find_index{|q| q[0]==skillname}
      elem_stats[0][3]+=mmm[mx][1]
    elsif m[i].split(') ')[-1][0,4]=='HP +' && elem_stats.map{|q| q[0]}.include?(m[i].split(') ')[0].gsub('(',''))
      p1=elem_stats.find_index{|q| q[0]==m[i].split(') ')[0].gsub('(','')}
      mx=mmm.find_index{|q| q[0]==skillname}
      elem_stats[p1][1]+=mmm[mx][1]
    elsif m[i].split(') ')[-1][0,10]=='Strength +' && elem_stats.map{|q| q[0]}.include?(m[i].split(') ')[0].gsub('(',''))
      p1=elem_stats.find_index{|q| q[0]==m[i].split(') ')[0].gsub('(','')}
      mx=mmm.find_index{|q| q[0]==skillname}
      elem_stats[p1][2]+=mmm[mx][1]
    elsif m[i].split(') ')[-1][0,9]=='Defense +' && elem_stats.map{|q| q[0]}.include?(m[i].split(') ')[0].gsub('(',''))
      p1=elem_stats.find_index{|q| q[0]==m[i].split(') ')[0].gsub('(','')}
      mx=mmm.find_index{|q| q[0]==skillname}
      elem_stats[p1][3]+=mmm[mx][1]
    elsif m[i].include?(' & ')
      mx=mmm.find_index{|q| q[0]==skillname}
      mmx=mmm[mx][0].split(' & ')
      p1=elem_stats.find_index{|q| q[0]==m[i].split(') ')[0].gsub('(','')}
      p1=0 if p1.nil?
      elem_stats[p1][1]+=mmm[mx][1] if mmx.include?('HP')
      elem_stats[p1][2]+=mmm[mx][1] if mmx.include?('Strength')
      elem_stats[p1][3]+=mmm[mx][1] if mmx.include?('Defense')
    end
  end
  m.sort!{|a,b| a.gsub('~~','')<=>b.gsub('~~','')}
  str=extend_message(str,'__***Calculated Chain Abilities***__',event,2)
  for i in 0...m.length
    str=extend_message(str,m[i],event)
  end
  if elem_stats[1,elem_stats.length-1].map{|q| q[1,q.length-1].max}.reject{|q| q<=0}.length>0 || m.reject{|q| !q.include?(' & ')}.length>0
    str=extend_message(str,'__***Calculated Buffs***__',event,2)
    for i in 0...k4.length
      str3=[]
      m1=elem_stats[0].map{|q| q}
      m2=elem_stats.find_index{|q| q[0]==k4[i].element}
      m2=elem_stats[m2].map{|q| q} unless m2.nil?
      m2=['',0,0,0,0,0,0] if m2.nil?
      m3=elem_stats.find_index{|q| q[0]==k4[i].weapon}
      m3=elem_stats[m3].map{|q| q} unless m3.nil?
      m3=['',0,0,0,0,0,0] if m3.nil?
      for i2 in 1...m1.length
        m1[i2]+=m2[i2]+m3[i2]
      end
      m2=m1[1]+100
      m3=m1[4]+100
      m2=m2*m3/100.0-100
      str3.push("#{k4[i].stat_emotes[0]}+#{'%.2f' % m2}%") if m2>=1
      m2=m1[2]+100
      m3=m1[5]+100
      m2=m2*m3/100.0-100
      str3.push("#{k4[i].stat_emotes[1]}+#{'%.2f' % m2}%") if m2>=1
      m2=m1[3]+100
      m3=m1[6]+100
      m2=m2*m3/100.0-100
      str3.push("#{k4[i].stat_emotes[2]}+#{'%.2f' % m2}%") if m2>=1
      str=extend_message(str,"**#{k4[i].name}** - #{str3.join('  ')}",event) if str3.length>0
    end
  end
  event.respond str
end

def print_overlap_list(event,args,bot)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=get_multiple_things(:find_wyrmprint,bot,event,args,0,true)
  if k.nil? || k.length<=0 || k[0].nil? || k[0].length<=0
    event.respond "No matches found."
    return nil
  end
  s=k[1].split(' ')
  k=k[0]
  limit=[false,false,false]
  k4=[]
  silvergold=[0,0,0]
  slots=[$weapons.map{|q| q.print_slots[0]}.max,$weapons.map{|q| q.print_slots[1]}.max,2]
  maxslots=$weapons.map{|q| q.print_slots.inject(0){|sum,x| sum + x }}.max+2
  str='__***Wyrmprints***__'
  for i in 0...k.length
    m=1
    m=0 if k[i].rarity>4
    m=2 if !k[i].availability.nil? && k[i].availability.include?('x')
    if k4.length>=maxslots
      if limit[0]
        str=extend_message(str,"~~#{k[i].name}#{k[i].emotes(bot)}~~",event)
      else
        limit[0]=true
        limit[m+1]=true if silvergold[m]>=slots[m]
        str=extend_message(str,"~~#{k[i].name}#{k[i].emotes(bot)}~~ - overall limit reached",event)
      end
    elsif silvergold[m]>=slots[m]
      if limit[m+1]
        str=extend_message(str,"~~#{k[i].name}#{k[i].emotes(bot)}~~",event)
      else
        limit[m+1]=true
        str=extend_message(str,"~~#{k[i].name}#{k[i].emotes(bot)}~~ - #{['gold','silver','X'][m]} slot limit reached",event)
      end
    else
      silvergold[m]+=1
      k4.push(k[i].clone)
      str=extend_message(str,"#{['<:Fill_Gold:759999913962110978>','<:Fill_Silver:759999914062774302>','<:Dominion:819854169128435742>'][m]} **#{k[i].name}#{k[i].emotes(bot)}**",event)
    end
  end
  str2=[]
  if k.reject{|q| !q.availability.nil? && q.availability.include?('x')}.length<=0
    str2.push('<:Dominion:819854169128435742>')
  elsif k.reject{|q| q.availability.nil? || !q.availability.include?('x')}.length<=0
    str2.push("#{k4[0].rarity}#{$rarity_stars[0][k4[0].rarity]}") if k4.map{|q| q.rarity}.uniq.length<=1
  end
  moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{k4[0].affinity}"}
  str2.push("#{moji[0].mention unless moji.length<=0}#{k4[0].affinity}") if k4.map{|q| q.affinity}.uniq.length<=1 && !k4[0].affinity.nil?
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k4[0].amulet.gsub('Healer','Healing')}"}
  str2.push("#{moji[0].mention unless moji.length<=0}#{k4[0].amulet}") if k4.map{|q| q.amulet}.uniq.length<=1
  str=extend_message(str,"**#{str2.join(' ')} Synergy**",event) if str2.length>0 && k4.length>1
  romanums=['Ox0','I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII','XVIII','XIX','XX','XXI','XXII','XXIII','XXIV','XXV','XXVI','XXVII',
            'XXVIII','XXIX','XXX','XXXI','XXXII','XXXIII','XXXIV','XXXV','XXXVI','XXXVII','XXXVIII','XXXIX','XL','XLI','XLII','XLII','XLIII','XLIV','XLV','XLVI','XLVII','XLVIII',
            'XLIX','L']
  k5=k4.map{|q| q.abilities.map{|q2| q2[-1]}}.flatten
  chains=[]
  for i in 0...k5.length
    if k5[i].include?(' & ')
      k5[i]=k5[i].split(' ')
      k5[i]=[k5[i][0,k5[i].length-1].join(' ').split(' & '),k5[i][-1]]
      if k5[i][0].include?('HP') || k5[i][0].include?('Strength') || k5[i][0].include?('Defense')
        k5[i][0]=k5[i][0].join(' & ')
        chains.push(k5[i].join(' '))
      elsif k5[i][0][0,k5[i][0].length-1].reject{|q| !q.include?('%') && !q.include?('/')}.length>0
        k5[i][0][-1]="#{k5[i][0][-1]} #{k5[i][-1]}"
        chains.push(k5[i][0])
      elsif k5[i][-1].include?('%') || k5[i][-1].include?('/') || k5[i][-1].to_i.to_s==k5[i][-1]
        chains.push(k5[i][0].map{|q| "#{q} #{k5[i][-1]}"})
      else
        k5[i][0][-1]="#{k5[i][0][-1]} #{k5[i][-1]}"
        chains.push(k5[i][0])
      end
    else
      chains.push(k5[i])
    end
  end
  for i in 0...chains.length
    chains[i]=chains[i].split(' ')
    if chains[i][-1].include?('/')
      chains[i][-1]=chains[i][-1].split('/')[-1].gsub('+','')
      if chains[i][-1].include?('%')
        chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1].gsub('%','').to_i,'Percent']
      elsif !romanums.find_index{|q| q==chains[i][-1]}.nil?
        chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1],'Roman']
      elsif chains[i][-1].to_i.to_s==chains[i][-1]
        chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1].to_i,'Number']
      else
        chains[i]=[chains[i].join(' '),nil,'']
      end
    elsif chains[i][-1].include?('%')
      chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1].gsub('%','').gsub('+','').to_i,'Percent']
    elsif !romanums.find_index{|q| q==chains[i][-1]}.nil?
      chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1],'Roman']
    elsif chains[i][-1].to_i.to_s==chains[i][-1]
      chains[i]=[chains[i][0,chains[i].length-1].join(' '),chains[i][-1].to_i,'Number']
    else
      chains[i]=[chains[i].join(' '),nil,'']
    end
  end
  rez=[]
  str=extend_message(str,'__***Resonance***__',event,2)
  for i in 0...$resonance.length
    if k4.reject{|q| q.affinity != $resonance[i][0]}.length>1
      f=k4.reject{|q| q.affinity != $resonance[i][0]}.length
      if chains.map{|q| q[0]}.include?("#{$resonance[i][0]}'s Psalm")
        for i2 in 0...chains.length
          if chains[i2][0]=="#{$resonance[i][0]}'s Psalm"
            if chains[i2][2]=='Number'
              f+=chains[i2][1]
            elsif chains[i2][2]=='Roman'
              f+=romanums.find_index{|q| q==chains[i2][1]}
            end
          end
        end
      end
      f=[$resonance[i].length,f].min
      xx=$resonance[i][1,f-1].compact
      unless xx.length<=0
        rez.push(xx[-1])
        moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{$resonance[i][0]}"}
        str=extend_message(str,"#{moji[0].mention unless moji.length<=0}#{"#{$resonance[i][0]} " if moji.length<=0}x#{f} - #{xx[-1]}",event)
      end
    end
  end
  m=chains.map{|q| [q[0],0,q[2]]}.uniq
  for i in 0...m.length
    if m[i][2].length<=0
      m[i]=m[i][0]
    else
      m2=chains.reject{|q| q[0]!=m[i][0] || q[2]!=m[i][2]}.map{|q| q[1]}
      x=''
      x='**' if m2.length>1
      m2=m2.inject(0){|sum,x| sum + x } unless m[i][2]=='Roman'
      m[i][1]=m2*1
      xx=$abilimits.find_index{|q| q.split(" \u2192 ")[0]==m[i][0]}
      unless xx.nil?
        xx=$abilimits[xx].split(" \u2192 ")[1].split(' (')[0].gsub('+','').gsub('%','')
        if !romanums.find_index{|q| q==xx}.nil? || m[i][2]=='Roman'
          c=romanums.find_index{|q| q==xx}
          c2=m[i][1].map{|q| romanums.find_index{|q2| q2==q}}.compact.inject(0){|sum,x| sum + x }
          if c<c2
            m[i][3]=m[i][1].map{|q| q}
            m[i][1]=[xx]
          end
        else
          m[i][3]=m[i][1] if m[i][1]>xx.to_i
          m[i][1]=[m[i][1],xx.to_i].min
        end
      end
      xx=rez.find_index{|q| q.split(' ')[0,q.split(' ').length-1].join(' ')==m[i][0]}
      unless xx.nil? || m[i][2]=='Roman'
        m[i][1]+=rez[xx].split(' ')[-1].gsub('+','').gsub('%','').to_i
        m[i][4]=rez[xx].split(' ')[-1].gsub('+','').gsub('%','').to_i
      end
    end
  end
  rez=rez.reject{|q| m.map{|q2| q2[0]}.include?(q.split(' ')[0,q.split(' ').length-1].join(' '))}
  for i in 0...rez.length
    m.push([rez[i],0,'',false,true])
    chains.push([rez[i].split(' ')[0,rez[i].split(' ').length-1].join(' '),0,'Percent'])
  end
  mmm=m.map{|q| q}
  str=extend_message(str,'__***Abilities***__',event,2)
  for i in 0...m.length
    if m[i][2].length<=0
      m[i]=m[i][0]
      m[i]="#{m[i]} - resonance" if m[i][4]
    else
      m2=chains.reject{|q| q[0]!=m[i][0] || q[2]!=m[i][2]}.map{|q| q[1]}
      x=''
      x='**' if m2.length>1
      xx=''
      if m[i][3].nil?
        if m[i][4].nil?
          xx="#{m[i][0]}"
        elsif m[i][2]=='Percent'
          xx="#{m[i][0]} ~~*+#{m[i][1]-m[i][4]}%*~~"
        elsif m[i][2]=='Roman'
          xx="#{m[i][0]}"
        else
          xx="#{m[i][0]} ~~*#{m[i][1]-m[i][4]}*~~"
        end
      elsif m[i][2]=='Percent'
        xx="#{m[i][0]} ~~+#{mmm[i][3]}%#{"\u2192*+#{m[i][1]-m[i][4]}%*" unless m[i][4].nil?}~~"
      elsif m[i][2]=='Roman'
        xx="#{m[i][0]} ~~#{mmm[i][3].join('+')}~~"
      else
        xx="#{m[i][0]} ~~#{mmm[i][3]}#{"\u2192*#{m[i][1]-m[i][4]}*" unless m[i][4].nil?}~~"
      end
      if m[i][2]=='Percent'
        xx="#{xx} #{x}+#{mmm[i][1]}%#{x}"
      elsif m[i][2]=='Roman'
        xx="#{xx} #{x}#{mmm[i][1].join('+')}#{x}"
      else
        xx="#{xx} #{x}#{mmm[i][1]}#{x}"
      end
      xx2=[]
      xx2.push('stack limit reached') if m[i][3]
      xx2.push('resonance added') if m[i][4]
      xx="#{xx} - #{xx2.join(', ')}" if xx2.length>0
      m[i]="#{xx}"
    end
  end
  for i in 0...m.length
    str=extend_message(str,m[i].to_s,event)
  end
  event.respond str
end

def upgrade_mats(event,args,bot,forcespiral=false)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    args.shift
    k=find_data_ex(:find_adventurer,args.join(' '),event)
  elsif ['weapon','wpn','wep','weap'].include?(args[0].downcase)
    args.shift
    k=find_data_ex(:find_weapon,args.join(' '),event)
  else
    k=find_best_match(args.join(' '),bot,event,true,false,6)
  end
  name=''
  nums=[]
  mana=false
  if k.nil?
    mana=true if forcespiral
    elem=''; rar=-1
    for i in 0...args.length
      rar=args[i][0,1].to_i if args[i][1,1]=='*' && args[i][0,1].to_i>3 && args[i][0,1].to_i<$max_rarity[0]+1
      elem='Flame' if ['flame','fire','flames','fires'].include?(args[i].downcase) && elem.length<=0
      elem='Water' if ['water','waters'].include?(args[i].downcase) && elem.length<=0
      elem='Wind' if ['wind','air','winds','airs'].include?(args[i].downcase) && elem.length<=0
      elem='Wind' if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920 && elem.length<=0
      elem='Light' if ['light','lights'].include?(args[i].downcase) && elem.length<=0
      elem='Shadow' if ['shadow','dark','shadows','darks'].include?(args[i].downcase) && elem.length<=0
      nums.push(args[i].to_i) if args[i].to_i.to_s==args[i]
    end
    if (nums.length<=0 && rar<0) || elem.length<=0
      k=find_best_match(args.join(' '),bot,event,false,false,6)
      if k.nil?
        event.respond "You need either an element and a rarity, or an adventurer name."
        return nil
      end
    end
  end
  if k.nil?
    for i in 0...nums.length
      if rar<0 && nums[i]>2 && nums[i]<6
        rar=nums[i]*1
        nums[i]=nil
      elsif nums[i]<0 || nums[i]>100
        nums[i]=nil
      end
    end
    if rar<0
      event.respond "You need either an element and a rarity, or an adventurer name."
      return nil
    end
    nums.compact!
    nums_mean=[]
    k=DLAdventurer.new('')
    k.element=elem
    k.rarity=rar.to_s
    k.hp='0'; k.str='0'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem}"}
    name="#{rar}#{$rarity_stars[0][rar]} #{elem}#{moji[0].mention unless moji.length<=0} Adventurer"
  elsif k.is_a?(DLWeapon)
    f=[]
    m=k.costs.map{|q| longFormattedNumber(q)}
    m.push(0); m.push(0); m.push(0); m.push(0); m.push(0); m.push(0); m.push(0)
    f.push(['Crafting Materials',"#{k.craft_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[0]}<:Resource_Rupies:532104504372363274>"]) unless k.craft_mats.nil? || k.craft_mats.length<=0
    if k.post_refine_unbind_mats.nil? || k.post_refine_unbind_mats.length<=0
      f.push(['Unbind Materials',"#{k.unbind_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[1]}<:Resource_Rupies:532104504372363274>"]) unless k.unbind_mats.nil? || k.unbind_mats.length<=0
    elsif k.unbind_mats.nil? || k.unbind_mats.length<=0
      f.push(["Unbind Materials\nAfter refinement","#{k.post_refine_unbind_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[7]}<:Resource_Rupies:532104504372363274>"]) unless k.post_refine_unbind_mats.nil? || k.post_refine_unbind_mats.length<=0
    else
      b="#{k.unbind_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[1]}<:Resource_Rupies:532104504372363274>"
      a="#{k.post_refine_unbind_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[7]}<:Resource_Rupies:532104504372363274>"
      f.push(['Unbind Materials',"__*Before Refinement*__\n#{b}\n\n__*After Refinement*__\n#{a}"])
    end
    f.push(['Slot Materials',"#{k.slot_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[2]}<:Resource_Rupies:532104504372363274>"]) unless k.slot_mats.nil? || k.slot_mats.length<=0
    f.push(['Copy Materials',"#{k.copy_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[3]}<:Resource_Rupies:532104504372363274>"]) unless k.copy_mats.nil? || k.copy_mats.length<=0
    f.push(['Ability Materials',"#{k.ability_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[4]}<:Resource_Rupies:532104504372363274>"]) unless k.ability_mats.nil? || k.ability_mats.length<=0
    f.push(['WeaponBonus Materials',"#{k.bonus_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[5]}<:Resource_Rupies:532104504372363274>"]) unless k.bonus_mats.nil? || k.bonus_mats.length<=0
    f.push(['Refinement Materials',"#{k.refinement_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[6]}<:Resource_Rupies:532104504372363274>"]) unless k.refinement_mats.nil? || k.refinement_mats.length<=0
    f.push(['<:Dominion:819854169128435742> Materials',"#{k.x_mats.map{|q| q.join(' x')}.join("\n")}\n\nCost: #{m[7]}<:Resource_Rupies:532104504372363274>"]) unless k.x_mats.nil? || k.x_mats.length<=0
    str=''
    str='No materials required' if f.length<=0
    create_embed(event,"__**#{k.name}**#{k.emotes(bot)}'s materials__",str,k.disp_color,nil,k.thumbnail,f)
    return nil
  else
    name="#{k.name}#{k.emotes(bot)}"
    for i in 0...args.length
      nums.push(args[i].to_i) if args[i].to_i.to_s==args[i]
    end
    mana=true if k.hasManaSpiral?
  end
  nums_mean=[]
  if nums.length>0
    for i in 0...nums.length
      if nums[i]<6 && i<=0
        nums_mean.push("Floor #{nums[i]}")
        nums[i]=nums[i]*10-10
      elsif nums[i]<6
        nums_mean.push("Floor #{nums[i]}")
        nums[i]=nums[i]*10
      elsif nums[i]<51 && nums[i]%10==0
        nums_mean.push("Floor #{nums[i]/10}")
      elsif nums[i]<51
        nums[i]=(nums[i]/10+1)*10
        nums_mean.push("Floor #{nums[i]/10}")
      elsif nums[i]<=70
        nums_mean.push("Node #{nums[i]}")
      end
    end
  end
  nums.push(0) if nums.length<1
  nums.push(100) if nums.length<2
  nums=nums[0,2].uniq.sort
  nums.push(100) if nums.length<2
  if forcespiral && !mana
    event.respond "This adventurer does not have a mana spiral."
    return nil
  elsif forcespiral
    nums=[50,100]
    nums_mean=[]
  end
  if nums_mean.length>1
    nums_mean="from #{nums_mean[0]} to #{nums_mean[1]}"
  elsif nums_mean.length>0
    nums_mean="from #{nums_mean[0]} onwards"
  else
    nums_mean=''
  end
  f=[]
  xx=[0,10,10,20,20,30,30,40,40,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,100]
  if k.name=='Euden'
    f=["Mana x3950","Bronze Orb x7","Bronze Orb x15, Silver Orb x2, Mana x14300","Bronze Orb x12, Silver Orb x3",
       "Bronze Orb x30, Silver Orb x3, Gold Orb x1, Samewyrm's Scale x5, Samewyrm's Superscale x1, Mana x32100",
       "Silver Orb x5, Gold Orb x3, Rainbow Orb x1, Samewyrm's Scale x15, Samewyrm's Superscale x5",
       "Bronze Orb x75, Silver Orb x10, Gold Orb x1, Samewyrm's Scale x13, Samewyrm's Superscale x4, Mana x51400",
       "Gold Orb x4, Rainbow Orb x1, Samewyrm's Scale x10, Samewyrm's Superscale x7, Knight's Testament x2",
       "Silver Orb x12, Gold Orb x7, Rainbow Orb x2, Samewyrm's Scale x25, Samewyrm's Superscale x7, Knight's Testament x1, Champion's Testament x1, Mana x86000, Eldwater x73000","Gold Orb x8, Rainbow Orb x16, Samewyrm's Superscale x12, Knight's Testament x2, Void Seed x8","Mana x16000",
       "Gold Orb x8, Incandescence Orb x4, Rainbow Orb x4, Mana x24000","Mana x16000","Mana x16000",
       "Incandescence Orb x4, Knight's Testament x3, Longing Heart x5, Mana x30000",
       "Incandescence Orb x3, Samewyrm's Superscale x14, Void Heart x4, Mana x56000","Mana x16000","Mana x16000",
       "Gold Orb x12, Incandescence Orb x4, Rainbow Orb x4, Mana x36000","Incandescence Orb x4, HighDragon Tail x5, Champion's Testament x1, Mana x60000",
       "Mana x16000","Mana x16000","Gold Orb x16, Incandescence Orb x4, Rainbow Orb x4, Mana x24000","Mana x16000",
       "Incandescence Orb x4, Weakwyrm's Greatsphere x4, Champion's Testament x1, Mana x90000","Mana x16000",
       "Incandescence Orb x4, Rainbow Orb x4, Samewyrm's Superscale x16, Mana x36000","Mana x16000","Mana x16000",
       "Incandescence Orb x8, Rainbow Orb x4, Weakwyrm's Greatsphere x4, Mana x120000"]
  elsif k.rarity==5
    f=["Mana x5700","Bronze Orb x10, Silver Orb x1","Bronze Orb x15, Silver Orb x3, Mana x20250","Bronze Orb x20, Silver Orb x5, Gold Orb x1",
       "Bronze Orb x50, Silver Orb x7, Gold Orb x2, Rainbow Orb x1, Samewyrm's Scale x8, Samewyrm's Superscale x3, Mana x45900",
       "Silver Orb x10, Gold Orb x5, Rainbow Orb x1, Samewyrm's Scale x25, Samewyrm's Superscale x10",
       "Bronze Orb x115, Silver Orb x15, Gold Orb x3, Samewyrm's Scale x20, Samewyrm's Superscale x7, Mana x72800",
       "Gold Orb x7, Rainbow Orb x3, Samewyrm's Scale x30, Samewyrm's Superscale x12, Champion's Testament x1",
       "Silver Orb x20, Gold Orb x10, Rainbow Orb x3, Samewyrm's Scale x35, Samewyrm's Superscale x12, Champion's Testament x2, Eldwater x73000, Mana x111000","Gold Orb x10, Rainbow Orb x20, Samewyrm's Superscale x15, Void Seed x3, Champion's Testament x1","Mana x20000",
       "Gold Orb x10, Platinum Orb x5, Rainbow Orb x5, Mana x30000","Mana x20000","Mana x20000",
       "Platinum Orb x5, Rainbow Orb x3, Champion's Testament x1, Mana x37500","Platinum Orb x3, Samewyrm's Superscale x17, Longing Heart x6, Mana x70000",
       "Mana x20000","Mana x20000","Gold Orb x15, Platinum Orb x5, Rainbow Orb x5, Mana x45000",
       "Platinum Orb x5, Void Heart x5, Champion's Testament x1, Mana x75000","Mana x20000","Mana x20000",
       "Gold Orb x20, Platinum Orb x5, Rainbow Orb x5, Mana x30000","Mana x20000",
       "Platinum Orb x5, Weakwyrm's Greatsphere x5, Champion's Testament x1, Mana x112500","Mana x20000",
       "Platinum Orb x5, Rainbow Orb x5, Samewyrm's Superscale x20, Mana x45000","Mana x20000","Mana x20000",
       "Platinum Orb x10, Rainbow Orb x5, High Weakwyrm's Tail x1, Mana x150000"]
  elsif k.element==4
    f=["Mana x4550","Bronze Orb x8, Silver Orb x1","Bronze Orb x12, Silver Orb x2, Mana x16150","Bronze Orb x15, Silver Orb x4, Gold Orb x1",
       "Bronze Orb x37, Silver Orb x5, Gold Orb x1, Samewyrm's Scale x6, Samewyrm's Superscale x2, Mana x36900",
       "Silver Orb x8, Gold Orb x4, Rainbow Orb x1, Samewyrm's Scale x20, Samewyrm's Superscale x8",
       "Bronze Orb x90, Silver Orb x12, Gold Orb x2, Samewyrm's Scale x16, Samewyrm's Superscale x5, Mana x57500",
       "Gold Orb x5, Rainbow Orb x2, Samewyrm's Scale x25, Samewyrm's Superscale x10, Knight's Testament x2",
       "Silver Orb x15, Gold Orb x8, Rainbow Orb x2, Champion's Testament x1, Samewyrm's Scale x30, Samewyrm's Superscale x10, Knight's Testament x1, Mana x95000, Eldwater x73000","Gold Orb x8, Rainbow Orb x16, Samewyrm's Superscale x12, Void Seed x8, Knight's Testament x2","Mana x16000",
       "Gold Orb x8, Platinum Orb x4, Rainbow Orb x4, Mana x24000","Mana x16000","Mana x16000",
       "Platinum Orb x4, Knight's Testament x3, Longing Heart x5, Mana x30000","Platinum Orb x3, Samewyrm's Superscale x14, Void Heart x4, Mana x56000",
       "Mana x16000","Mana x16000","Gold Orb x12, Platinum Orb x4, Rainbow Orb x4, Mana x36000",
       "Platinum Orb x4, HighDragon Tail x5, Champion's Testament x1, Mana x60000","Mana x16000","Mana x16000",
       "Gold Orb x16, Platinum Orb x4, Rainbow Orb x4, Mana x24000","Mana x16000",
       "Platinum Orb x4, Weakwyrm's Greatsphere x4, Champion's Testament x1, Mana x90000","Mana x16000",
       "Platinum Orb x4, Rainbow Orb x4, Samewyrm's Superscale x16, Mana x36000","Mana x16000","Mana x16000",
       "Platinum Orb x8, Rainbow Orb x4, Weakwyrm's Greatsphere x4, Mana x120000"]
  else
    f=["Mana x2650","Bronze Orb x5","Bronze Orb x8, Silver Orb x1, Mana x10050","Bronze Orb x10, Silver Orb x3",
       "Bronze Orb x25, Silver Orb x3, Samewyrm's Scale x3, Mana x23100","Silver Orb x5, Gold Orb x1, Samewyrm's Scale x10, Samewyrm's Superscale x3",
       "Bronze Orb x70, Silver Orb x10, Gold Orb x1, Samewyrm's Scale x10, Samewyrm's Superscale x2, Mana x36500",
       "Gold Orb x4, Rainbow Orb x1, Samewyrm's Scale x15, Samewyrm's Superscale x5, Knight's Testament x1",
       "Silver Orb x12, Gold Orb x7, Rainbow Orb x2, Samewyrm's Scale x15, Samewyrm's Superscale x7, Knight's Testament x1, Champion's Testament x1, Mana x70000, Eldwater x73000","Gold Orb x6, Rainbow Orb x12, Samewyrm's Superscale x9, Void Seed x6, Knight's Testament x1","Mana x12000",
       "Gold Orb x6, Platinum Orb x3, Rainbow Orb x3, Mana x18000","Mana x12000","Mana x12000",
       "Platinum Orb x3, Longing Heart x4, Knight's Testament x1, Mana x22500","Platinum Orb x2, Samewyrm's Superscale x11, Void Heart x2, Mana x42000",
       "Mana x12000","Mana x12000","Gold Orb x9, Platinum Orb x3, Rainbow Orb x3, Mana x27000",
       "Platinum Orb x3, HighDragon Tail x3, Knight's Testament x2, Mana x45000","Mana x12000","Mana x12000",
       "Gold Orb x12, Platinum Orb x3, Rainbow Orb x3, Mana x18000","Mana x12000",
       "Platinum Orb x3, Weakwyrm's Greatsphere x2, Champion's Testament x1, Mana x67500","Mana x12000",
       "Platinum Orb x3, Rainbow Orb x3, Samewyrm's Superscale x12, Mana x27000","Mana x12000","Mana x12000",
       "Platinum Orb x6, Rainbow Orb x3, Weakwyrm's Greatsphere x2, Mana x90000"]
  end
  for i in 0...f.length
    if k.element=='Flame'
      f[i]=f[i].gsub("Bronze Orb","Flame Orb").gsub("Silver Orb","Blaze Orb").gsub("Gold Orb","Inferno Orb").gsub("Platinum Orb","Incandescence Orb")
      f[i]=f[i].gsub("Samewyrm's Scale","Flamewyrm's Scale").gsub("Samewyrm's Superscale","Flamewyrm's Scaldscale")
      f[i]=f[i].gsub("Void Heart","Burning Heart").gsub("HighDragon Tail","Blazing Ember")
      f[i]=f[i].gsub("Weakwyrm's Greatsphere","Windwyrm's Greatsphere").gsub("High Weakwyrm's Tail","High Windwyrm's Tail")
    elsif k.element=='Water'
      f[i]=f[i].gsub("Bronze Orb","Water Orb").gsub("Silver Orb","Stream Orb").gsub("Gold Orb","Deluge Orb").gsub("Platinum Orb","Tsunami Orb")
      f[i]=f[i].gsub("Samewyrm's Scale","Waterwyrm's Scale").gsub("Samewyrm's Superscale","Waterwyrm's Glistscale")
      f[i]=f[i].gsub("Void Heart","Azure Heart").gsub("HighDragon Tail","Oceanic Crown")
      f[i]=f[i].gsub("Weakwyrm's Greatsphere","Flamewyrm's Greatsphere").gsub("High Weakwyrm's Tail","High Flamewyrm's Tail")
    elsif k.element=='Wind'
      f[i]=f[i].gsub("Bronze Orb","Wind Orb").gsub("Silver Orb","Storm Orb").gsub("Gold Orb","Maelstrom Orb").gsub("Platinum Orb","Tempest Orb")
      f[i]=f[i].gsub("Samewyrm's Scale","Windwyrm's Scale").gsub("Samewyrm's Superscale","Windwyrm's Squallscale")
      f[i]=f[i].gsub("Void Heart","Verdant Heart").gsub("HighDragon Tail","Zephyr Rune")
      f[i]=f[i].gsub("Weakwyrm's Greatsphere","Waterwyrm's Greatsphere").gsub("High Weakwyrm's Tail","High Waterwyrm's Tail")
    elsif k.element=='Light'
      f[i]=f[i].gsub("Bronze Orb","Light Orb").gsub("Silver Orb","Radiance Orb").gsub("Gold Orb","Refulgence Orb").gsub("Platinum Orb","Resplendence Orb")
      f[i]=f[i].gsub("Samewyrm's Scale","Lightwyrm's Scale").gsub("Samewyrm's Superscale","Lightwyrm's Glowscale")
      f[i]=f[i].gsub("Void Heart","Coronal Heart").gsub("HighDragon Tail","Abyssal Standard")
      f[i]=f[i].gsub("Weakwyrm's Greatsphere","Shadowwyrm's Greatsphere").gsub("High Weakwyrm's Tail","High Shadowwyrm's Tail")
    elsif k.element=='Shadow'
      f[i]=f[i].gsub("Bronze Orb","Shadow Orb").gsub("Silver Orb","Nightfall Orb").gsub("Gold Orb","Nether Orb").gsub("Platinum Orb","Abaddon Orb")
      f[i]=f[i].gsub("Samewyrm's Scale","Shadowwyrm's Scale").gsub("Samewyrm's Superscale","Shadowwyrm's Darkscale")
      f[i]=f[i].gsub("Void Heart","Ebony Heart").gsub("HighDragon Tail","Ruinous Wing")
      f[i]=f[i].gsub("Weakwyrm's Greatsphere","Lightwyrm's Greatsphere").gsub("High Weakwyrm's Tail","High Lightwyrm's Tail")
    end
  end
  if f.length>0
    f=f[0,9] unless mana
    f2=[]
    for i in 0...f.length
      m=f[i].split(', ')
      for i2 in 0...m.length
        m[i2]=m[i2].split(' ')
        m[i2]=[m[i2][0,m[i2].length-1].join(' '),m[i2][m[i2].length-1].gsub('x','').to_i]
        f2.push(m[i2].map{|q| q}) unless i<xx.find_index{|q| q>=nums[0]} || i>xx.find_index{|q| q>=nums[1]} || (i==9 && nums[1]==50)
        if m[i2][0]=='Mana'
          m[i2]="#{longFormattedNumber(m[i2][1])}<:Resource_Mana:532104503852400640>"
        elsif m[i2][0]=='Eldwater'
          m[i2]="#{longFormattedNumber(m[i2][1])}<:Resource_Eldwater:532104503777034270>"
        else
          m[i2]="#{m[i2][0]} x#{longFormattedNumber(m[i2][1])}"
        end
      end
      f[i]=m.join("\n")
    end
    if safe_to_spam?(event) && !has_any?(args.map{|q| q.downcase},['total','totals','summary'])
      f2=[]
      f2.push([1,"#{f[0] if nums[0]<10}\n\n__*Floor 2 unbind*__\n#{f[1]}"]) if nums[0]<20 && nums[1]>=10
      f2.push([2,"#{f[2] if nums[0]<20}\n\n__*Floor 3 unbind*__\n#{f[3]}"]) if nums[0]<30 && nums[1]>=20
      f2.push([3,"#{f[4] if nums[0]<30}#{"\n\n__*Promotion to 4<:Rarity_4:532086056301101067>*__\n2,500<:Resource_Eldwater:532104503777034270>" if k.rarity<4}\n\n__*Floor 4 unbind*__\n#{f[5]}"]) if nums[0]<40 && nums[1]>=30
      f2.push([4,"#{f[6] if nums[0]<40}#{"\n\n__*Promotion to 5<:Rarity_5:532086056737177600>*__\n25,000<:Resource_Eldwater:532104503777034270>" if k.rarity<5}\n\n__*Floor 5 unbind*__\n#{f[7]}"]) if nums[0]<50 && nums[1]>=40
      f2.push([5,"#{f[8] if nums[0]<50}#{"\n\n__*Mana Spiral unlock*__\n#{f[9]}" if mana && nums[0]<=49}"]) if nums[0]<=50 && nums[1]>=50
      xcolor=k.disp_color
      disp="__**#{name}**'s Mana Spiral mats#{" (#{nums_mean})" if nums_mean.length>0}__"
      if f2.length>0 && !f2[0][1].nil? && f2[0][1].length>0 && !forcespiral
        if f2[0][1].length<=0
        elsif f2[0][1].split("\n").reject{|q| q.length<=0}[0].include?('unbind')
          f2[1][1]="#{f2[0][1]}\n\n#{f2[1][1]}"
          f2[0]=nil
          f2.compact!
        end
        create_embed(event,"__**#{name}**'s mats#{" (#{nums_mean})" if nums_mean.length>0}__",'',xcolor,'Floors are given totals as nodes can be unlocked in any order',k.thumbnail,f2.map{|q| ["Floor #{q[0]}",q[1]]})
        xcolor=0xB14ABC
        disp='Mana Spiral'
        xpic=nil
      end
      if mana
        f2=[]
        for i in 10...f.length
          if f[i].include?("\n")
            f2.push([i+41,"\n__*Node #{i+41}*__\n#{f[i]}\n"])
          else
            f2.push([i+41,"*Node #{i+41}:* #{f[i]}"])
          end
        end
        f2=f2.reject{|q| q[0]<nums[0] || q[0]>nums[1]}
        f3=[]
        f3.push([5,"__*Mana Spiral unlock*__\n#{f[9]}"]) if forcespiral
        f3.push([6,f2.reject{|q| q[0]>60}.map{|q| q[1]}.join("\n").gsub("\n\n\n","\n\n")])
        f3.push([7,f2.reject{|q| q[0]<61}.map{|q| q[1]}.join("\n").gsub("\n\n\n","\n\n")])
        f3=f3.reject{|q| q[1].nil? || q[1].length<=0}
        create_embed(event,disp,'',xcolor,nil,xpic,f3.map{|q| ["Floor #{q[0]}",q[1]]}) if f3.length>0
      end
    else
      f3=f2.map{|q| q[0]}.uniq.map{|q| [q,0]}
      for i in 0...f3.length
        f4=f2.reject{|q| q[0]!=f3[i][0]}
        for i2 in 0...f4.length
          f3[i][1]+=f4[i2][1]
          f3[i][1]+=2500 if k.rarity<4 && f3[i][0]=='Eldwater' 
          f3[i][1]+=25000 if k.rarity<5 && f3[i][0]=='Eldwater' 
        end
        if f3[i][0]=='Mana'
          f3[i]="\u00B7  #{longFormattedNumber(f3[i][1])}<:Resource_Mana:532104503852400640>"
        elsif f3[i][0]=='Eldwater'
          f3[i]="\u00B7  #{longFormattedNumber(f3[i][1])}<:Resource_Eldwater:532104503777034270>"
        else
          f3[i]="#{f3[i][0]} x**#{longFormattedNumber(f3[i][1])}**"
        end
      end
      f3=f3.sort!
      create_embed(event,"__**#{name}**'s mat totals#{" (#{nums_mean})" if nums_mean.length>0}__",'',k.disp_color,nil,k.thumbnail,triple_finish(f3,true))
    end
    return nil
  end
  event.respond "**Element:** #{element_emote(elem,bot)}\n**Rarity:** #{generate_rarity_row(rar)}#{"\n**Mana Spiral**" if mana}#{"\n**Additional Numbers:** #{nums[0,[nums.length,2].min].join(', ')}" if nums.length>0}"
end

def disp_sp_table(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  wpn=[]
  for i in 0...args.length
    wpn.push('Sword') if ['sword','swords'].include?(args[i].downcase)
    wpn.push('Blade') if ['blade','blades','sabers','saber'].include?(args[i].downcase)
    wpn.push('Dagger') if ['dagger','daggers','knife','knifes','knives'].include?(args[i].downcase)
    wpn.push('Axe') if ['axes','axe'].include?(args[i].downcase)
    wpn.push('Bow') if ['bow','bows','arrow','arrows','archer','archers'].include?(args[i].downcase)
    wpn.push('Lance') if ['lance','lances','pitchfork','pitchforks','trident','tridents','spear','spears'].include?(args[i].downcase)
    wpn.push('Wand') if ['wand','wands'].include?(args[i].downcase)
    wpn.push('Staff') if ['staff','staffs','staves'].include?(args[i].downcase)
    wpn.push('Manacaster') if ['manacaster','manacasters','caster','casters','gun','guns','managun','managuns','manchester','manchesters','gunner','gunners'].include?(args[i].downcase)
  end
  if wpn.length<=0
    k=find_best_match(args.join(' '),bot,event,true,false,6)
    if k.nil?
    elsif k.is_a?(DLAdventurer)
      k2=k.sp_embed(event,bot)
      return nil if k2.nil?
      wpn.push(k2)
    elsif k.is_a?(DLWeapon)
      wpn.push(k.type)
    end
  end
  if wpn.length<=0 && !safe_to_spam?(event)
    event.respond "The complete table is too large.  Please either specify a weapon type or use this command in PM."
  elsif wpn.length<=0
    kx=[[150,150,196,265,391,143,345,1152],[130,130,220,360,900,104,200,1740],[144,144,264,288,480,132,288,1128],[200,240,360,380,420,160,300,1600],
        [120,240,120,480,600,111,400,1560],[184,92,276,414,529,208,460,1495],[130,200,240,430,600,156,400,1600],[232,232,348,464,696,300,580,1972]]
    k=kx.map{|q| "__**Combo:**__\n*First Hit:* #{q[0]}\n*Second Hit:* #{q[1]}\n*Third Hit:* #{q[2]}\n*Fourth Hit:* #{q[3]}\n*Fifth Hit:* #{q[4]}\n\u30FC *Total:* #{q[7]}\n\n**Dash Attack:** #{q[5]}\n**Force Strike** #{q[6]}"}
    k2=['<:Weapon_Sword:532106114540634113>Swords','<:Weapon_Blade:532106114628714496>Blades','<:Weapon_Dagger:532106116025286656>Daggers',
        '<:Weapon_Axe:532106114188443659>Axes','<:Weapon_Lance:532106114792423448>Lances','<:Weapon_Bow:532106114909732864>Bows',
        '<:Weapon_Wand:532106114985099264>Wands','<:Weapon_Staff:532106114733441024>Staves','<:Weapon_Manacaster:758905122448867338>Manacasters']
    f=[]
    for i in 0...k.length
      f.push([k2[i],k[i]])
    end
    f.push(['-','-'])
    kx=[[545,545,300,400],[464,464,300,400],[200,200,200,300,'90 per hit']]
    k=kx.map{|q| "__**Combo:**__\n*First Hit:* #{q[0]}\n*Second Hit:* #{q[1]}#{"\n*Third Hit:* #{q[2]}" if q.length>4}\n\u30FC *Total:* #{q[0,q.length-2].inject(0){|sum,x| sum + x }}\n\n**Dash Attack:** #{q[-2]}\n**Force Strike** #{q[-1]}"}
    k2=['<:Weapon_Manacaster:758905122448867338>Manacaster <:MC_Rifle:772800760068046859>Rifles','<:Weapon_Manacaster:758905122448867338>Manacaster <:MC_Shotgun:772800760055726080>Shotguns','<:Weapon_Manacaster:758905122448867338>Manacaster <:MC_Machine_Gun:772800760081023017>Machine Guns']
    for i in 0...k.length
      f.push([k2[i],k[i]])
    end
    create_embed(event,"__**SP gains**__",'',0xCE456B,nil,nil,f)
  elsif wpn[0]=='Manacaster'
    f=[]
    f.push(['<:MC_Rifle:772800760068046859>Rifle',"*First Hit:* 545\n*Second Hit:* 545\n\u30FC *Total: 1090*\n\n**Dash Attack:** 300\n**Force Strike:** 400"])
    f.push(['<:MC_Shotgun:772800760055726080>Shotgun',"*First Hit:* 464\n*Second Hit:* 464\n\u30FC *Total: 928*\n\n**Dash Attack:** 300\n**Force Strike:** 400"])
    f.push(['<:MC_Machine_Gun:772800760081023017>Machine Gun',"*First Hit:* 200\n*Second Hit:* 200\n*Third Hit:* 200\n\u30FC *Total: 600*\n\n**Dash Attack:** 300\n**Force Strike:** 90 per hit"])
    m=''
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[0]}"}
    m=moji[0].mention unless moji.length<=0
    create_embed(event,"__SP gains for **#{m}#{wpn[0]}** users__",'',0xCE456B,nil,nil,f)
  elsif ['Rifle','Shotgun','Machine Gun'].include?(wpn[0])
    k=[1,2,3,4,5,6,7]
    k=[545,545,300,400] if wpn[0]=='Rifle'
    k=[464,464,300,400] if wpn[0]=='Shotgun'
    k=[200,200,200,300,'90 per hit'] if wpn[0]=='Machine Gun'
    disp="__**Combo:**__\n*First Hit:* #{k[0]}\n*Second Hit:* #{k[1]}"
    disp="#{disp}\n*Third Hit:* #{k[2]}" unless k[4].nil?
    disp="#{disp}\n\u30FC *Total: #{k.inject(0){|sum,x| sum + x }}*"
    disp="#{disp}\n\n**Dash Attack:** #{k[-2]}"
    disp="#{disp}\n**Force Strike:** #{k[-1]}"
    moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "MC_#{wpn[0].gsub(' ','_')}"}
    create_embed(event,"__SP gains for **#{moji[0].mention unless moji.length<=0}#{wpn[0]} [Manacaster]** users__",disp,0xCE456B)
  else
    k=[1,2,3,4,5,6,7]
    k=[150,150,196,265,391,143,345,1152] if wpn[0]=='Sword'
    k=[130,130,220,360,900,104,200,1740] if wpn[0]=='Blade'
    k=[144,144,264,288,480,132,288,1128] if wpn[0]=='Dagger'
    k=[200,240,360,380,420,160,300,1600] if wpn[0]=='Axe'
    k=[120,240,120,480,600,111,400,1560] if wpn[0]=='Lance'
    k=[184,92,276,414,529,208,460,1495] if wpn[0]=='Bow'
    k=[130,200,240,430,600,156,400,1600] if wpn[0]=='Wand'
    k=[232,232,348,464,696,300,580,1972] if wpn[0]=='Staff'
    m=''
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[0]}"}
    m=moji[0].mention unless moji.length<=0
    disp="__**Combo:**__\n*First Hit:* #{k[0]}\n*Second Hit:* #{k[1]}\n*Third Hit:* #{k[2]}\n*Fourth Hit:* #{k[3]}\n*Fifth Hit:* #{k[4]}\n\u30FC *Total: #{k[7]}*\n\n**Dash Attack:** #{k[5]}\n\n**Force Strike** #{k[6]}"
    create_embed(event,"__SP gains for **#{m}#{wpn[0]}** users__",disp,0xCE456B)
  end
end

def disp_damage_modifiers(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  wpn=[]
  for i in 0...args.length
    wpn.push('Sword') if ['sword','swords'].include?(args[i].downcase)
    wpn.push('Blade') if ['blade','blades','sabers','saber'].include?(args[i].downcase)
    wpn.push('Dagger') if ['dagger','daggers','knife','knifes','knives'].include?(args[i].downcase)
    wpn.push('Axe') if ['axes','axe'].include?(args[i].downcase)
    wpn.push('Bow') if ['bow','bows','arrow','arrows','archer','archers'].include?(args[i].downcase)
    wpn.push('Lance') if ['lance','lances','pitchfork','pitchforks','trident','tridents','spear','spears'].include?(args[i].downcase)
    wpn.push('Wand') if ['wand','wands'].include?(args[i].downcase)
    wpn.push('Staff') if ['staff','staffs','staves'].include?(args[i].downcase)
    wpn.push('Manacaster') if ['manacaster','manacasters','caster','casters','gun','guns','managun','managuns','manchester','manchesters','gunner','gunners'].include?(args[i].downcase)
  end
  if wpn.length<=0
    k=find_best_match(args.join(' '),bot,event,true,false,7)
    if k.nil?
    elsif k.name=='Puppy'
      kn=$dragons[$dragons.find_index{|q| q.name=='Puppy'}]
      if k.damage_override.length==1
        if k.damage_override[0].length>3
          ff=[]
          for i2 in 1...k.damage_override[0].length-2
            ff.push("*#{m[i2]} Hit:* #{k.damage_override[0][i2]}#{'%' if k.damage_override[0][i2].to_i.to_s==k.damage_override[0][i2]}")
          end
          ff.push("\n**Dash Attack:** #{k.damage_override[0][-2]}#{'%' if k.damage_override[0][-2].to_i.to_s==k.damage_override[0][-2]}")
          ff.push("\n**Force Strike:** #{k.damage_override[0][-1]}#{'%' if k.damage_override[0][-1].to_i.to_s==k.damage_override[0][-1]}")
          disp=ff.join("\n")
        else
          disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
        end
      else
        disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
      end
      for i in 0...kx.damage_override.length
        for i2 in 1...kx.damage_override[i].length
          kx.damage_override[i][i2]="#{k.damage_override[i][i2]}%" unless kx.damage_override[i][i2].is_a?(String) && kx.damage_override[i][i2].to_i.to_s != kx.damage_override[i][i2]
          kx.damage_override[i][i2]="*#{m[i2]} Hit:* #{kx.damage_override[i][i2]}"
        end
      end
      disp2=kx.damage_override[0][1,kx.damage_override[0].length-1].join("\n")
      create_embed(event,"__Damage modifiers for **#{k.name}#{k.emotes(bot)}**__",'',k.disp_color,nil,k.thumbnail,[['Adventurer',disp],['Dragon',disp2]])
      return nil
    elsif k.is_a?(DLAdventurer) || k.is_a?(DLDragon)
      k2=k.damage_embed(event,bot)
      return nil if k2.nil?
      wpn.push(k2)
    elsif k.is_a?(DLWeapon)
      wpn.push(k.type)
    end
  end
  if wpn.length<=0 && !safe_to_spam?(event)
    event.respond "The complete table is too large.  Please either specify a weapon type or use this command in PM."
  elsif wpn.length<=0
    kx=[[108,115,137,144,'216% x2',95,'104% L1, 115% L2'],
        [128,128,'75% x2',155,'172% x2',94,"83% L1, 92% L2"],
        [108,'56% x2','78% x2',171,216,85,"43.2% x3 L1, 47% x3 L2"],
        [151,161,270,285,301,73,"173% L1, 192% L2"],
        [111,'59% x2',143,198,147,89,"27% x5 L1, 30% x5 L2"],
        ['44% x3','55% x2','63% x3','95% x2','53% x5','30% x3',"28% x8 L1, 31% x8 L2"],
        [136,'74% x2','49% x3','108% x2','85% x1 + 49% x4',100,"81% x2 L1, 90% x2 L2"],
        [124,144,'81% x2',270,353,80,"55% x4 L1, 61% x4 L2"]]
    for i in 0...kx.length
      for i2 in 0...kx[i].length
        kx[i][i2]="#{kx[i][i2]}%" unless kx[i][i2].is_a?(String)
      end
    end
    k=kx.map{|q| "__**Combo:**__\n*First Hit:* #{q[0]}\n*Second Hit:* #{q[1]}\n*Third Hit:* #{q[2]}\n*Fourth Hit:* #{q[3]}\n*Fifth Hit:* #{q[4]}\n\n**Dash Attack:** #{q[5]}\n**Force Strike** #{q[6]}"}
    k2=['<:Weapon_Sword:532106114540634113>Swords','<:Weapon_Blade:532106114628714496>Blades','<:Weapon_Dagger:532106116025286656>Daggers',
        '<:Weapon_Axe:532106114188443659>Axes','<:Weapon_Lance:532106114792423448>Lances','<:Weapon_Bow:532106114909732864>Bows',
        '<:Weapon_Wand:532106114985099264>Wands','<:Weapon_Staff:532106114733441024>Staves']
    f=[]
    for i in 0...k.length
      f.push([k2[i],k[i]])
    end
    f.push(['<:Weapon_Manacaster:758905122448867338>Manacaster <:MC_Rifle:772800760068046859>Rifles',"*First Hit:* 67% x5\n*Second Hit:* 67% x5\n\n**Dash Attack:** \n**Force Strike:** 180%"])
    f.push(['<:Weapon_Manacaster:758905122448867338>Manacaster <:MC_Shotgun:772800760055726080>Shotguns',"*First Hit:* 48% x8\n*Second Hit:* 48% x8\n\n**Dash Attack:** 40% x8\n**Force Strike:** 35% x10 + 40% x1"])
    f.push(['<:Weapon_Manacaster:758905122448867338>Manacaster <:MC_Machine_Gun:772800760081023017>Machine Guns',"*First Hit:* 45% x3\n*Second Hit:* 150% x3\n*Third Hit:* 150% x5\n\n**Dash Attack:** \n**Force Strike:** 90%"])
    create_embed(event,"__**Damage modifiers**__",'',0xCE456B,nil,nil,f)
  elsif wpn[0]=='Manacaster'
    f=[]
    f.push(['<:MC_Rifle:772800760068046859>Rifle',"*First Hit:* 67% x5\n*Second Hit:* 67% x5\n\n**Dash Attack:** \n**Force Strike:** 180%"])
    f.push(['<:MC_Shotgun:772800760055726080>Shotgun',"*First Hit:* 48% x8\n*Second Hit:* 48% x8\n\n**Dash Attack:** 40% x8\n**Force Strike:** 35% x10 + 40% x1"])
    f.push(['<:MC_Machine_Gun:772800760081023017>Machine Gun',"*First Hit:* 45% x3\n*Second Hit:* 150% x3\n*Third Hit:* 150% x5\n\n**Dash Attack:** \n**Force Strike:** 90%"])
    m=''
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[0]}"}
    m=moji[0].mention unless moji.length<=0
    create_embed(event,"__Damage modifiers for **#{m}#{wpn[0]}** users__",'',0xCE456B,nil,nil,f)
  elsif ['Rifle','Shotgun','Machine Gun'].include?(wpn[0])
    k=[1,2,3,4,5,6,7]
    k=['67% x5','67% x5',0,180] if wpn[0]=='Rifle'
    k=['48% x8','48% x8','40% x8','35% x10 + 40%'] if wpn[0]=='Shotgun'
    k=['45% x3','150% x3','150% x5',0,90] if wpn[0]=='Machine Gun'
    for i in 0...k.length
      k[i]="#{k[i]}%" unless k[i].is_a?(String)
    end
    disp="__**Combo:**__\n*First Hit:* #{k[0]}\n*Second Hit:* #{k[1]}"
    disp="#{disp}\n*Third Hit:* #{k[2]}" unless k[4].nil?
    disp="#{disp}\n\n**Dash Attack:** #{k[-2]}"
    disp="#{disp}\n**Force Strike:** #{k[-1]}"
    moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "MC_#{wpn[0].gsub(' ','_')}"}
    create_embed(event,"__Damage modifiers for #{moji[0].mention unless moji.length<=0}**#{wpn[0]} [Manacaster]** users__",disp,0xCE456B)
  else
    k=[1,2,3,4,5,6,7]
    k=[108,115,137,144,'216% x2',95,'104% L1, 115% L2'] if wpn[0]=='Sword'
    k=[128,128,'75% x2',155,'172% x2',94,"83% L1, 92% L2"] if wpn[0]=='Blade'
    k=[108,'56% x2','78% x2',171,216,85,"43.2% x3 L1, 47% x3 L2"] if wpn[0]=='Dagger'
    k=[151,161,270,285,301,73,"173% L1, 192% L2"] if wpn[0]=='Axe'
    k=[111,'59% x2',143,198,147,89,"27% x5 L1, 30% x5 L2"] if wpn[0]=='Lance'
    k=['44% x3','55% x2','63% x3','95% x2','53% x5','30% x3',"28% x8 L1, 31% x8 L2"] if wpn[0]=='Bow'
    k=[136,'74% x2','49% x3','108% x2','85% x1 + 49% x4',100,"81% x2 L1, 90% x2 L2"] if wpn[0]=='Wand'
    k=[124,144,'81% x2',270,353,80,"55% x4 L1, 61% x4 L2"] if wpn[0]=='Staff'
    for i in 0...k.length
      k[i]="#{k[i]}%" unless k[i].is_a?(String)
    end
    m=''
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[0]}"}
    m=moji[0].mention unless moji.length<=0
    disp="__**Combo:**__\n*First Hit:* #{k[0]}\n*Second Hit:* #{k[1]}\n*Third Hit:* #{k[2]}\n*Fourth Hit:* #{k[3]}\n*Fifth Hit:* #{k[4]}\n\n**Dash Attack:** #{k[5]}\n\n**Force Strike** #{k[6]}"
    create_embed(event,"__Damage modifiers for **#{m}#{wpn[0]}** users__",disp,0xCE456B)
  end
end

def disp_groups(event)
  data_load(['groups'])
  grp=$groups.map{|q| q}
  grp=grp.sort{|a,b| a.name<=>b.name}
  s2s=false
  s2s=true if safe_to_spam?(event)
  str=''
  if s2s
    for i in 0...grp.length
      str=extend_message(str,"__**#{grp[i].fullName}**__\n#{grp[i].contents}",event,2)
    end
    str=extend_message(str,'~~Italic names are added to these groups dynamically~~',event,2)
    event.respond str
  else
    for i in 0...grp.length
      str="#{str}#{"\n" if str.length>0}#{grp[i].name} - #{grp[i].quantities}"
    end
    create_embed(event,"__**Available Groups**__",str,0xCE456B)
  end
end

def disp_banner(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  data_load()
  p=[]
  xcolor=0x849294
  xpic=nil
  evn=event.message.text.downcase.split(' ')
  kx=find_best_match(args.join(' '),bot,event,false,false,5)
  if kx.nil?
    current_banner(bot,event,args,"No matches found.  Showing current banner instead.\n\n",false)
    return nil
  elsif kx.is_a?(DLBanner)
    old_banner(bot,event,args,kx)
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  bnr=[]
  bbb=$banners.map{|q| q}
  bnr.push("*Launch #{kx.objt}*") if bbb[0].hasFocus?(kx)
  for i in 1...bbb.length
    bnr.push(bbb[i].description(event,kx,bnr.length<=0)) if bbb[i].hasFocus?(kx)
  end
  if bnr.length>16 && !s2s && bnr[0]=="*Launch #{p[1]}*"
    bnr=[bnr[0],"Has appeared on #{bnr.length-1} banners since"]
  elsif bnr.length>16 && !s2s
    bnr[0]="__**Debut Banner**__\n#{bnr[0]}"
    bnr=[bnr[0],"...as well as #{bnr.length-1} additional banners since then"]
  elsif bnr.length>0
    bnr[0]="__**Debut Banner**__\n#{bnr[0]}"
    bnr[1]="#{"\n" unless s2s}__**Other Banners**__\n#{bnr[1]}" if bnr.length>1
  else
    bnr.push('~~None~~')
  end
  if "__**#{kx.name}**'s Banners__".length+bnr.join("#{"\n" if s2s}\n").length>=1900 || Shardizard==4
    hdr="__**#{kx.name}**'s Banners__"
    xpic=kx.thumbnail
    j=0; m=0
    for i in 1...bnr.length
      if "#{bnr[j]}#{"\n" if s2s || i==1}\n#{bnr[i]}".length>=1900
        create_embed(event,hdr,bnr[j],kx.disp_color(m),nil,xpic)
        j=i*1; hdr=nil; xpic=nil; m+=1
      else
        bnr[j]="#{bnr[j]}#{"\n" if s2s || i==1}\n#{bnr[i]}"
        bnr[i]=nil
      end
    end
    create_embed(event,hdr,bnr[j],kx.disp_color(m),'All banners display dates as if reset is at midnight.',xpic)
  else
    create_embed(event,"__**#{kx.name}**'s Banners__",bnr.join("#{"\n" if s2s}\n"),kx.disp_color,'All banners display dates as if reset is at midnight.',kx.thumbnail)
  end
end

def old_banner(bot,event,args=nil,bnr=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  data_load()
  if bnr.nil?
    b=find_data_ex(:find_banner,args.join(' '),event)
  else
    b=bnr.clone
  end
  if b.nil?
    event.respond "No matches found."
  else
    b.disp_embed(event,bot,0)
  end
  return nil
end

def current_banner(bot,event,args=nil,msg='',showerr=true)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  data_load()
  t=Time.now
  timeshift=7
  timeshift-=1 unless (t-24*60*60).dst?
  t-=60*60*timeshift
  tm="#{t.year}#{'0' if t.month<10}#{t.month}#{'0' if t.day<10}#{t.day}".to_i
  bb=$banners.reject{|q| !q.isCurrent?}
  if bb.length<=0
    event.respond "No matches found." if showerr
  else
    for iq in 0...bb.length
      bb[iq].disp_embed(event,bot,1,msg) unless !safe_to_spam?(event) && iq>0
    end
  end
  return nil
end

def today_in_dl(event,bot,args=nil,ignoreinputs=false,mode=0)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.map{|q| q.downcase}
  t=Time.now
  timeshift=7
  timeshift-=1 unless (t-24*60*60).dst?
  t-=60*60*timeshift
  sftday=-2
  for i in 0...args.length
    stfday=t.wday if ['today','now'].include?(args[i]) && sftday<-1
    sftday=-1 if ['tomorrow','tommorrow','tomorow','tommorow','next'].include?(args[i]) && sftday<-1
    sftday=0 if ['sunday','sundae','sun','su','sonday','sondae','son','u'].include?(args[i]) && sftday<-1
    sftday=1 if ['mo','monday','mondae','mon','m'].include?(args[i]) && sftday<-1
    sftday=2 if ['tu','tuesday','tuesdae','tues','tue','t'].include?(args[i]) && sftday<-1
    sftday=3 if ['we','wednesday','wednesdae','wednes','wed','w'].include?(args[i]) && sftday<-1
    sftday=4 if ['th','thursday','thursdae','thurs','thu','thur','h','r'].include?(args[i]) && sftday<-1
    sftday=5 if ['fr','friday','fridae','fri','fryday','frydae','fry','f'].include?(args[i]) && sftday<-1
    sftday=6 if ['sa','saturday','saturdae','sat','saturnday','saturndae','saturn','satur'].include?(args[i]) && sftday<-1
  end
  sftday=t.wday if sftday<-1 || ignoreinputs
  sftday=ignoreinputs*1 if ignoreinputs.is_a?(Numeric)
  str="Time elapsed since #{"today's " if sftday==t.wday}reset: #{"#{t.hour} hours, " if t.hour>0}#{"#{'0' if t.min<10}#{t.min} minutes, " if t.hour>0 || t.min>0}#{'0' if t.sec<10}#{t.sec} seconds"
  str="#{str}\nTime until #{"tomorrow's " if sftday==t.wday}reset: #{"#{23-t.hour} hours, " if 23-t.hour>0}#{"#{'0' if 59-t.min<10}#{59-t.min} minutes, " if 23-t.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
  t2=Time.new(2018,9,27)-60*60
  t2=t-t2
  date=(((t2.to_i/60)/60)/24)
  str="#{str}\n"
  str="#{str}\n#{'~~' unless sftday==t.wday}Date assuming reset is at midnight: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]})"
  str="#{str}\nDays since game release: #{longFormattedNumber(date)}"
  if t.wday==1
    m=0
  else
    m=8-t.wday
  end
  t3=t+m*24*60*60
  t3=Time.new(t3.year,t3.month,t3.day)
  t3+=60*60 if t3.dst? && !t.dst?
  t3=(t3-t).to_i
  t4=[]
  k=t3/86400
  kx=k*1
  kx+=7 if kx<0
  t4.push("#{longFormattedNumber(kx)} days") if k%7>0
  t3-=k*86400
  k=t3/3600
  t4.push("#{k} hours") if k>0
  t3-=k*3600
  k=t3/60
  t4.push("#{k} minutes") if k>0
  t3-=k*60
  t4.push("#{t3} seconds") if t3>0
  str="#{str}\nTime until High Dragon bonus chest reset: #{t4.join(', ')}" if [4,0].include?(mode)
  if t.month==12
    t3=Time.new(t.year+1,1,1)
  else
    t3=Time.new(t.year,t.month+1,1)
  end
  t3+=60*60 if t3.dst? && !t.dst?
  t3=(t3-t).to_i
  t4=[]
  k=t3/86400
  t4.push("#{longFormattedNumber(k)} days") if k>0
  t3-=k*86400
  k=t3/3600
  t4.push("#{k} hours") if k>0
  t3-=k*3600
  k=t3/60
  t4.push("#{k} minutes") if k>0
  t3-=k*60
  t4.push("#{t3} seconds") if t3>0
  str="#{str}\nTime until Void Treasure Trade reset: #{t4.join(', ')}" if [3,4,0].include?(mode)
  str="#{str}~~" unless sftday==t.wday
  str3=''
  if sftday<0
    t+=24*60*60
    t2=Time.new(2018,9,27)-60*60
    t2=t-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n\nTomorrow's date: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]})"
    str="#{str}\nDays since game release, come tomorrow: #{longFormattedNumber(date)}"
    if t.wday==1
      m=0
    else
      m=8-t.wday
    end
    t3=t+m*24*60*60
    t3=Time.new(t3.year,t3.month,t3.day)
    t3+=60*60 if t3.dst? && !t.dst?
    t3=(t3-t).to_i
    t4=[]
    k=t3/86400
    kx=k*1
    kx+=7 if kx<0
    t4.push("#{longFormattedNumber(kx)} days") if k%7>0
    t3-=k*86400
    k=t3/3600
    t4.push("#{k} hours") if k>0
    t3-=k*3600
    k=t3/60
    t4.push("#{k} minutes") if k>0
    t3-=k*60
    t4.push("#{t3} seconds") if t3>0
    str="#{str}\nTime until High Dragon bonus chest reset, come tomorrow: #{t4.join(', ')}" if [4,0].include?(mode)
    if t.month==12
      t3=Time.new(t.year+1,1,1)
    else
      t3=Time.new(t.year,t.month+1,1)
    end
    t3+=60*60 if t3.dst? && !t.dst?
    t3=(t3-t).to_i
    t4=[]
    k=t3/86400
    t4.push("#{longFormattedNumber(k)} days") if k>0
    t3-=k*86400
    k=t3/3600
    t4.push("#{k} hours") if k>0
    t3-=k*3600
    k=t3/60
    t4.push("#{k} minutes") if k>0
    t3-=k*60
    t4.push("#{t3} seconds") if t3>0
    str="#{str}\nTime until Void Treasure Trade reset, come tomorrow: #{t4.join(', ')}" if [3,4,0].include?(mode)
    str3='Tomorrow'
  elsif sftday != t.wday
    tmw=(sftday==t.wday+1)
    tmw=true if sftday==0 && t.wday==6
    t+=7*24*60*60 if sftday<t.wday
    t+=(sftday-t.wday)*24*60*60
    t2=Time.new(2018,9,27)-60*60
    t2=t-t2
    date=(((t2.to_i/60)/60)/24)
    str3="Next #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]}"
    str="#{str}\n\n#{str3}'s date: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} #{'(Tomorrow)' if tmw}"
    str="#{str}\nDays since game release, come next #{str3.split(' ')[1]}: #{longFormattedNumber(date)}"
    if t.wday==1
      m=0
    else
      m=8-t.wday
    end
    t3=t+m*24*60*60
    t3=Time.new(t3.year,t3.month,t3.day)
    t3+=60*60 if t3.dst? && !t.dst?
    t3=(t3-t).to_i
    t4=[]
    k=t3/86400
    kx=k*1
    kx+=7 if kx<0
    t4.push("#{longFormattedNumber(kx)} days") if k%7>0
    t3-=k*86400
    k=t3/3600
    t4.push("#{k} hours") if k>0
    t3-=k*3600
    k=t3/60
    t4.push("#{k} minutes") if k>0
    t3-=k*60
    t4.push("#{t3} seconds") if t3>0
    str="#{str}\nTime until High Dragon bonus chest reset, come next #{str3.split(' ')[1]}: #{t4.join(', ')}" if [4,0].include?(mode)
    if t.month==12
      t3=Time.new(t.year+1,1,1)
    else
      t3=Time.new(t.year,t.month+1,1)
    end
    t3+=60*60 if t3.dst? && !t.dst?
    t3=(t3-t).to_i
    t4=[]
    k=t3/86400
    t4.push("#{longFormattedNumber(k)} days") if k>0
    t3-=k*86400
    k=t3/3600
    t4.push("#{k} hours") if k>0
    t3-=k*3600
    k=t3/60
    t4.push("#{k} minutes") if k>0
    t3-=k*60
    t4.push("#{t3} seconds") if t3>0
    str="#{str}\nTime until Void Treasure Trade reset, come next #{str3.split(' ')[1]}: #{t4.join(', ')}" if [3,4,0].include?(mode)
  end
  if [2,0].include?(mode)
    str5="__**#{"#{str3}'s " if str3.length>0}Expert Ruins:**__"
    str5="#{str5}\n*Open:* #{['<:Element_Null:532106087810334741>All','<:Element_Null:532106087810334741>All','<:Element_Flame:532106087952810005>Flamehowl','<:Element_Water:532106088221376522>Waterscour','<:Element_Wind:532106087948746763>Windmaul','<:Element_Light:532106088129101834>Lightsunder','<:Element_Shadow:532106088154267658>Shadowsteep'][t.wday]}"
    if t.wday>2
      str5="#{str5}\n*Available Orbs:* #{['All','All','Flame, Blaze, Inferno','Water, Stream, Deluge','Wind, Storm, Maelstorm','Light, Radiance, Refulgence','Shadow, Nightfall, Nether'][t.wday]}" if t.wday>1
      str5="#{str5}\n*Other Available Mats:* #{["Fiend's Horn, Fiend's Eye, Fiend's Claw, Ancient Bird's Feather, Bewitching Wing, Granite, Meteorite","Fiend's Horn, Fiend's Eye, Fiend's Claw, Ancient Bird's Feather, Bewitching Wing, Granite, Meteorite","Fiend's Horn, Fiend's Eye","Ancient Bird's Feather, Bewitching Wing",'Granite, Meteorite',"Fiend's Claw","Ancient Bird's Feather, Bewitching Wing"][t.wday]}" if t.wday>1
    end
    str5="All Expert Ruins are available" if t.year>2020 || t.month>6 || t.day>=24
    str=extend_message(str,str5,event,2)
    str5="__**<:Element_Void:548467446734913536> #{"#{str3}'s " if str3.length>0}Void Strikes:**__"
    data_load(['void'])
    void=$voids[0,7].map{|q| q}
    matz=$voids[8,$voids.length-8].map{|q| q}
    str5="#{str5}\n*Open:* "
    str5="#{str5}#{void[t.wday].split(', ').reject{|q| q.include?('*')}.join(', ')}"
    str5="#{str5}, " if void[t.wday].split(', ').reject{|q| q.include?('*')}.length>0 && void[t.wday].split(', ').reject{|q| !q.include?('*')}.length>0
    str5="#{str5}#{void[t.wday].split(', ').reject{|q| !q.include?('*')}.map{|q| "#{q.gsub('*','')}<:x2:680152943299002370>"}.join(', ')}"
    voidmats=void[t.wday].split(', ').map{|q| q.gsub('*','')}.join(', ')
    for i in 0...matz.length
      matz[i]=matz[i].split(', ')
      k=matz[i][0]
      matz[i]=matz[i][1,matz[i].length-1].join(', ')
      voidmats=voidmats.gsub(k,matz[i])
    end
    voidmats=voidmats.split(', ').uniq.sort.join(', ')
    str5="#{str5}\n*Available Mats:* #{voidmats}"
    str=extend_message(str,str5,event,2)
    showhdt=false
    showhdt=true if Shardizard==4
    showhdt=true if t.year>2019
    showhdt=true if t.month>11
    showhdt=true if t.day>18
    if showhdt
      str5="__**<:Tribe_Dragon:549947361745567754> #{"#{str3}'s " if str3.length>0}High Dragon Trials:**__"
      str5="#{str5}\n*Open:* #{['<:Element_Null:532106087810334741> High All','<:Element_Wind:532106087948746763> High Midgardsormr, <:Element_Water:532106088221376522> High Mercury','<:Element_Flame:532106087952810005> High Brunhilda, <:Element_Shadow:532106088154267658> High Zodiark','<:Element_Water:532106088221376522> High Mercury, <:Element_Light:532106088129101834> High Jupiter','<:Element_Wind:532106087948746763> High Midgardsormr, <:Element_Shadow:532106088154267658> High Zodiark','<:Element_Flame:532106087952810005> High Brunhilda, <:Element_Light:532106088129101834> High Jupiter','<:Element_Null:532106087810334741> High All'][t.wday]}"
      str=extend_message(str,str5,event,2)
    end
  end
  str=extend_message(str,"**Shop Mats:** #{['Light Metal, Abyss Stone','Iron Ore, Granite',"Fiend's Claw, Fiend's Horn","Bat Wing, Ancient Bird's Feather",'Iron Ore, Granite',"Fiend's Claw, Fiend's Horn","Bat Wing, Ancient Bird's Feather"][t.wday]}",event,2) if t.wday>-1 && [3,0].include?(mode)
  if [1,0].include?(mode)
    str=extend_message(str,"**#{"#{str3}'s " if str3.length>0}Bond Gift:** #{['Golden Chalice','Juicy Meat','Kaleidoscope','Floral Circlet','Compelling Book','Mana Essence','Golden Chalice'][t.wday]}",event,2)
    if t.wday>0 && t.wday<6
      drg=$dragons.reject{|q| q.favorite !=t.wday}
      m=[]
      for i in 0...$max_rarity[1]
        m.push([generate_rarity_row(i+1),[]])
      end
      for i in 0...drg.length
        f="#{drg[i][0]}#{element_emote(drg[i][2],bot,drg[i][16])}"
        for i2 in 0...$max_rarity[1]
          m[i2][1].push(f) if drg[i][1][0,1].to_i==i2+1
        end
      end
      m=m.reject{|q| q[1].length<=0}
      create_embed(event,str,'',0xCE456B,nil,nil,m.map{|q| [q[0],q[1].join("\n")]})
    else
      event.respond str
    end
  else
    event.respond str
  end
  current_banner(bot,event,args,'__Current banner:__ ',false) if (safe_to_spam?(event) || has_any?(event.message.text.downcase.split(' '),['banner','banners'])) && str3.length<=0 && mode==0
end

def next_events(event,bot,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.map{|q| q.downcase}
  t=Time.now
  timeshift=7
  timeshift-=1 unless (t-24*60*60).dst?
  t-=60*60*timeshift
  str="Time elapsed since today's reset: #{"#{t.hour} hours, " if t.hour>0}#{"#{'0' if t.min<10}#{t.min} minutes, " if t.hour>0 || t.min>0}#{'0' if t.sec<10}#{t.sec} seconds"
  str="#{str}\nTime until tomorrow's reset: #{"#{23-t.hour} hours, " if 23-t.hour>0}#{"#{'0' if 59-t.min<10}#{59-t.min} minutes, " if 23-t.hour>0 || 59-t.min>0}#{'0' if 60-t.sec<10}#{60-t.sec} seconds"
  t2=Time.new(2018,9,27)-60*60
  t2=t-t2
  date=(((t2.to_i/60)/60)/24)
  str="#{str}\n"
  str="#{str}\nDate assuming reset is at midnight: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]})"
  str="#{str}\nDays since game release: #{longFormattedNumber(date)}"
  if t.month==12
    t3=Time.new(t.year+1,1,1)
  else
    t3=Time.new(t.year,t.month+1,1)
  end
  t3=(t3-t).to_i
  t4=[]
  k=t3/86400
  t4.push("#{longFormattedNumber(k)} days") if k>0
  t3-=k*86400
  k=t3/3600
  t4.push("#{k} hours") if k>0
  t3-=k*3600
  k=t3/60
  t4.push("#{k} minutes") if k>0
  t3-=k*60
  t4.push("#{t3} seconds") if t3>0
  str="#{str}\nTime until Void Treasure Trade reset: #{t4.join(', ')}"
  mode=0
  for i in 0...args.length
    mode=1 if mode<1 && ['ruin','ruins'].include?(args[i]) && !(t.year>2020 || t.month>6 || t.day>24)
    mode=2 if mode<1 && ['mats','mat','material','materials'].include?(args[i])
    mode=3 if mode<1 && ['shop','store'].include?(args[i])
    mode=4 if mode<1 && ['bond','dragon','bonds','dragons'].include?(args[i])
    mode=5 if mode<1 && ['void','strike','voidstrike','voidstrikes','strikes'].include?(args[i])
    mode=6 if mode<1 && ['voidmat','strikemat','voidstrikemat','voidmats','strikemats','voidstrikemats','voidmaterial','strikematerial','voidstrikematerial','voidmaterials','strikematerials','voidstrikematerials'].include?(args[i])
    mode=6 if mode==2 && ['void','strike','voidstrike','voidstrikes','strikes'].include?(args[i]) && !safe_to_spam?(event)
    mode=6 if mode==5 && ['mats','mat','material','materials'].include?(args[i]) && !safe_to_spam?(event)
    mode=7 if mode<1 && ['high','highdragon','hdt','trial','trials','hd'].include?(args[i])
  end
  if mode==0 && !safe_to_spam?(event)
    event.respond "Please either specify an event type or use this command in PM.\n\nAvailable event types include:\n- Ruins\n- Mats\n- Shop\n- Bond items\n- Void Strikes\n- High Dragon Trials"
    return nil
  end
  if [1,0].include?(mode) && !(t.year>2020 || t.month>6 || t.day>24)
    ruin=['<:Element_Null:532106087810334741>All','<:Element_Null:532106087810334741>All','<:Element_Flame:532106087952810005>Flamehowl','<:Element_Water:532106088221376522>Waterscour','<:Element_Wind:532106087948746763>Windmaul','<:Element_Light:532106088129101834>Lightsunder','<:Element_Shadow:532106088154267658>Shadowsteep']
    ruin=ruin.rotate(t.wday)
    matz=["","","Flame/Blaze/Inferno Orbs, Fiend's Horn, Fiend's Eye","Water/Stream/Deluge Orbs, Ancient Bird's Feather, Bewitching Wing",
          "Wind/Storm/Maelstorm Orbs, Granite, Meteorite","Light/Radiance/Refulgence Orbs, Fiend's Claw",
          "Shadow/Nightfall/Nether Orbs, Ancient Bird's Feather, Bewitching Wing"]
    matz=matz.rotate(t.wday)
    str2='__**Expert Ruins**__'
    for i in 0...ruin.length
      if i==0
        t2=t+24*60*60*(i+1)
        str2="#{str2}#{"\n" if mode==1 && safe_to_spam?(event)}\n#{ruin[i]} - Today#{" - Next available tomorrow (#{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t2.wday]}, #{t2.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t2.month]} #{t2.year})" if ruin[0]==ruin[1]}"
        str2="#{str2}\n~~Available mats: #{matz[i]}~~" if mode==1 && safe_to_spam?(event)
      elsif ruin[i]==ruin[i-1]
      else
        t2=t+24*60*60*i
        str2="#{str2}#{"\n" if mode==1 && safe_to_spam?(event)}\n#{ruin[i]} - #{"#{i} days from now" if i>1}#{"Tomorrow" if i==1} - #{t2.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t2.month]} #{t2.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t2.wday]})"
        str2="#{str2}\n~~Available mats: #{matz[i]}~~" if mode==1 && safe_to_spam?(event)
      end
    end
    t2=t+24*60*60*ruin.length
    unless [ruin[1],ruin[-1]].include?(ruin[0])
      str2="#{str2}#{"\n" if mode==1 && safe_to_spam?(event)}\n#{ruin[0]} - #{ruin.length} days from now - #{t2.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t2.month]} #{t2.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t2.wday]})"
      str2="#{str2}\n~~Available mats: #{matz[0]}~~" if mode==1 && safe_to_spam?(event)
    end
    str=extend_message(str,str2,event,2)
  end
  data_load(['void'])
  void=$voids[0,7].map{|q| q.gsub('*','')}
  void2=$voids[0,7].map{|q| q.split(', ').reject{|q2| !q2.include?('*')}.join(', ').gsub('*','')}
  void=void.rotate(t.wday)
  void2=void2.rotate(t.wday)
  void.push(void[0])
  void2.push(void2[0])
  if [0,5].include?(mode)
    double=false
    shortlist=false
    shortlist=true if mode==0
    shortlist=true if !safe_to_spam?(event)
    elem=[]
    for i in 0...args.length
      double=true if ['double','x2','2'].include?(args[i])
      elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i])
      elem.push('Water') if ['water','waters'].include?(args[i])
      elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i])
      elem.push('Wind') if ['earth','earths'].include?(args[i]) && event.user.id==192821228468305920
      elem.push('Light') if ['light','lights'].include?(args[i])
      elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i])
    end
    mmzz=[]
    mmzz2=[]
    matz=$voids[7,$voids.length-7].map{|q| q}
    for i in 0...void.length
      m=void[i].split(', ')
      pos=0
      for i2 in 0...m.length
        pos=matz.find_index{|q| m[i2]==q.split(', ')[0]}
        pos=0 if pos.nil?
        mmzz.push([m[i2],i,pos])
      end
      m=void2[i].split(', ')
      pos=0
      for i2 in 0...m.length
        pos=matz.find_index{|q| m[i2]==q.split(', ')[0]}
        pos=0 if pos.nil?
        mmzz2.push([m[i2],i,pos])
      end
    end
    for i in 0...matz.length
      matz[i]=matz[i].split(', ')
      matz[i].shift
      matz[i]=matz[i].join(', ')
    end
    mmzz.sort!{|a,b| (a[2]<=>b[2])==0 ? (a[1]<=>b[1]) : (a[2]<=>b[2])}
    mmzz.reverse!
    for i in 0...mmzz.length-1
      if mmzz[i][0]==mmzz[i+1][0]
        mmzz[i+1][3]=mmzz[i][1]*1 unless mmzz[i+1][1]>0
        mmzz[i]=nil
      end
    end
    mmzz.compact!
    mmzz.reverse!
    mmzz2.sort!{|a,b| (a[2]<=>b[2])==0 ? (a[1]<=>b[1]) : (a[2]<=>b[2])}
    mmzz2.reverse!
    for i in 0...mmzz2.length-1
      if mmzz2[i][0]==mmzz2[i+1][0]
        mmzz2[i+1][3]=mmzz2[i][1]*1 unless mmzz2[i+1][1]>0
        mmzz2[i]=nil
      end
    end
    mmzz2.compact!
    mmzz2.reverse!
    str2="__**<:Element_Void:548467446734913536> Void Strikes**__"
    if double
      mmzz=mmzz2.map{|q| q}
      mmzz2=[]
      str2="__**<:Element_Void:548467446734913536><:x2:680152943299002370> Void Strikes: Double Drop**__"
    end
    if mmzz.length>10 && !safe_to_spam?(event)
      if !(double || elem.length>0) || mmzz.length>25
        mmzz3=mmzz.reject{|q| ['Scalding Shroom','Wandering Shroom','Gust Shroom','Steel Golem','Obsidian Golem','Amber Golem','Blazing Ghost','Violet Ghost','Lambent Ghost','Cerulean Ghost','Frost Hermit','Twilight Hermit','Raging Manticore','Greedy Manticore','Smoldering Manticore','Proud Manticore','Catoblepas Fotia','Catoblepas Anemos','Eolian Phantom','Infernal Phantom'].include?(q[0].split('>')[-1]) && !mmzz2.map{|q2| q2[0]}.include?(q[0])}
        if mmzz3.length>16
          otheroptions=[]
          otheroptions.push("an element name") unless elem.length>0
          otheroptions.push("the word \"double\"") unless double
          str2="#{str2}\nThere are so many #{'qualifying ' if double || elem.length>0}Void Strikes that I will reduce the list to those available today or tomorrow.\nVoid Strikes that are always available but have no Double Drops are also excluded.\nFor the full list, use this command in PM.#{"\nYou can also include #{otheroptions.join(' or ')} to reduce the list accordingly." if otheroptions.length>0}\n"
          mmzz=mmzz.reject{|q| q[1]>1}
          if mmzz.length>25
            event.respond "Even reduced, the list of Void Strikes is too long for this channel.  Please retry this command in PM."
            return nil
          end
        else
          mmzz=mmzz3.map{|q| q}
          str2="#{str2}\nVoid Strikes that are always available, but never have Double Drops, have been removed.\n"
        end
      end
    end
    str=extend_message(str,str2,event,2)
    strpost=false
    for i in 0...mmzz.length
      str2="#{"\n" if mode==5 && safe_to_spam?(event)}*#{mmzz[i][0]}* -"
      i2=mmzz2.find_index{|q| q[0]==mmzz[i][0]}
      spliticon="\n"
      if ['Scalding Shroom','Wandering Shroom','Gust Shroom','Steel Golem','Obsidian Golem','Amber Golem','Blazing Ghost','Violet Ghost','Lambent Ghost','Cerulean Ghost','Frost Hermit','Twilight Hermit','Raging Manticore','Greedy Manticore','Smoldering Manticore','Proud Manticore','Catoblepas Fotia','Catoblepas Anemos','Eolian Phantom','Infernal Phantom'].include?(mmzz[i][0].split('>')[-1]) && !double
        spliticon=' - '
        str2="#{str2.gsub(' -','')} [Always available]"
      elsif mmzz[i][1]==0
        str2="#{str2} **Today**#{'<:x2:680152943299002370>' if !i2.nil? && shortlist && mmzz2[i2][1]==0}#{' - Next available' unless mmzz[i][3].nil? || mmzz[i][3]<=0}"
        if mmzz[i][3].nil? || mmzz[i][3]<=0
        else
          t_d=t+mmzz[i][3]*24*60*60
          if !i2.nil? && shortlist && [mmzz2[i2][3],mmzz2[i2][1]].include?(mmzz[i][3])
            str2="#{str2} #{mmzz[i][3]} days from now<:x2:680152943299002370> (#{disp_date(t_d,1)})" unless mmzz[i][3]==1
            str2="#{str2} tomorrow<:x2:680152943299002370> (#{disp_date(t_d,1)})" if mmzz[i][3]==1
          elsif !i2.nil? && shortlist
            str2="#{str2.gsub('Next','~~Next')} #{mmzz[i][3]} days from now (#{disp_date(t_d,2)})~~" unless mmzz[i][3]==1
            str2="#{str2.gsub('Next','~~Next')} tomorrow (#{disp_date(t_d,2)})~~" if mmzz[i][3]==1
            if mmzz2[i2][1]==0
              t_d=t+mmzz2[i2][3]*24*60*60
            else
              t_d=t+mmzz2[i2][1]*24*60*60
            end
            str2="#{str2} - <:x2:680152943299002370> next available #{mmzz2[i2][3]} days from now (#{disp_date(t_d,2)})"
          elsif mmzz[i][3]==1
            str2="#{str2} tomorrow#{'<:x2:680152943299002370>' if !i2.nil? && shortlist && [mmzz2[i2][1],mmzz2[i2][3]].include?(1)} (#{disp_date(t_d,1)})"
          else
            str2="#{str2} #{mmzz[i][3]} days from now (#{disp_date(t_d,1)})"
          end
        end
      else
        t_d=t+mmzz[i][1]*24*60*60
        if !i2.nil? && shortlist && mmzz2[i2][1]==mmzz[i][1]
          str2="#{str2} #{mmzz[i][1]} days from now<:x2:680152943299002370> (#{disp_date(t_d,1)})" unless mmzz[i][1]==1
          str2="#{str2} Tomorrow<:x2:680152943299002370> (#{disp_date(t_d,1)})" if mmzz[i][1]==1
        elsif !i2.nil? && shortlist
          str2="#{str2} ~~#{mmzz[i][1]} days from now (#{disp_date(t_d,2)})~~" unless mmzz[i][1]==1
          str2="#{str2} ~~Tomorrow (#{disp_date(t_d,2)})~~" if mmzz[i][1]==1
          t_d=t+mmzz2[i2][1]*24*60*60
          str2="#{str2} - <:x2:680152943299002370> coming #{mmzz2[i2][1]} days from now (#{disp_date(t_d,2)})"
        elsif mmzz[i][1]==1
          str2="#{str2} Tomorrow (#{disp_date(t_d,1)})"
        else
          str2="#{str2} #{mmzz[i][1]} days from now (#{disp_date(t_d,1)})"
        end
      end
      unless i2.nil? || (shortlist && str2[-1]!=']')
        str2="#{str2}#{spliticon}<:x2:680152943299002370>#{'*Double Drops* - ' unless spliticon==' - '}"
        if mmzz2[i2][1]==0
          str2="#{str2} **Today**#{' - Next available' unless mmzz2[i2][3].nil? || mmzz2[i2][3]<=0}"
          if mmzz2[i2][3].nil? || mmzz2[i2][3]<=0
          else
            t_d=t+mmzz2[i2][3]*24*60*60
            if mmzz2[i2][3]==1
              str2="#{str2} tomorrow (#{disp_date(t_d,1)})"
            else
              str2="#{str2} #{mmzz2[i2][3]} days from now (#{disp_date(t_d,1)})"
            end
          end
        else
          t_d=t+mmzz2[i2][1]*24*60*60
          if mmzz2[i2][1]==1
            str2="#{str2} Tomorrow (#{disp_date(t_d,1)})"
          else
            str2="#{str2} #{mmzz2[i2][1]} days from now (#{disp_date(t_d,1)})"
          end
        end
      end
      str2="#{str2}\n~~Available mats: #{matz[mmzz[i][2]]}~~" if mode==5 && safe_to_spam?(event)
      if elem.length>0 && !str2.include?("<:Element_#{elem[0]}:")
      elsif !safe_to_spam?(event) && str2[-1]==']'
      else
        str=extend_message(str,str2,event,1)
      end
    end
  end
  if [0,7].include?(mode)
    str2="__**<:Tribe_Dragon:549947361745567754> High Dragon Trials**__"
    hdt=['<:Element_Flame:532106087952810005> High Brunhilda, <:Element_Water:532106088221376522> High Mercury, <:Element_Wind:532106087948746763> High Midgardsormr, <:Element_Light:532106088129101834> High Jupiter, <:Element_Shadow:532106088154267658> High Zodiark',
         '<:Element_Wind:532106087948746763> High Midgardsormr, <:Element_Water:532106088221376522> High Mercury',
         '<:Element_Flame:532106087952810005> High Brunhilda, <:Element_Shadow:532106088154267658> High Zodiark',
         '<:Element_Water:532106088221376522> High Mercury, <:Element_Light:532106088129101834> High Jupiter',
         '<:Element_Wind:532106087948746763> High Midgardsormr, <:Element_Shadow:532106088154267658> High Zodiark',
         '<:Element_Flame:532106087952810005> High Brunhilda, <:Element_Light:532106088129101834> High Jupiter',
         '<:Element_Flame:532106087952810005> High Brunhilda, <:Element_Water:532106088221376522> High Mercury, <:Element_Wind:532106087948746763> High Midgardsormr, <:Element_Light:532106088129101834> High Jupiter, <:Element_Shadow:532106088154267658> High Zodiark']
    hdt=hdt.rotate(t.wday)
    mmzz=[]
    for i in 0...hdt.length
      m=hdt[i].split(', ')
      pos=0
      for i2 in 0...m.length
        pos=1 if m[i2]=='<:Element_Flame:532106087952810005> High Brunhilda'
        pos=2 if m[i2]=='<:Element_Water:532106088221376522> High Mercury'
        pos=3 if m[i2]=='<:Element_Wind:532106087948746763> High Midgardsormr'
        pos=4 if m[i2]=='<:Element_Light:532106088129101834> High Jupiter'
        pos=5 if m[i2]=='<:Element_Shadow:532106088154267658> High Zodiark'
        pos=0 if pos.nil?
        mmzz.push([m[i2],i,pos])
      end
    end
    mmzz.sort!{|a,b| (a[2]<=>b[2])==0 ? (a[1]<=>b[1]) : (a[2]<=>b[2])}
    mmzz.reverse!
    for i in 0...mmzz.length-1
      if mmzz[i][0]==mmzz[i+1][0]
        mmzz[i+1][3]=mmzz[i][1]*1 unless mmzz[i+1][1]>0
        mmzz[i]=nil
      end
    end
    mmzz.compact!
    mmzz.reverse!
    for i in 0...mmzz.length
      str2="#{str2}\n*#{mmzz[i][0]}* -"
      if mmzz[i][1]==0
        str2="#{str2} **Today**#{' - Next available' unless mmzz[i][3].nil? || mmzz[i][3]<=0}"
        if mmzz[i][3].nil? || mmzz[i][3]<=0
        else
          t_d=t+mmzz[i][3]*24*60*60
          if mmzz[i][3]==1
            str2="#{str2} tomorrow (#{disp_date(t_d,1)})"
          else
            str2="#{str2} #{mmzz[i][3]} days from now (#{disp_date(t_d,1)})"
          end
        end
      else
        t_d=t+mmzz[i][1]*24*60*60
        if mmzz[i][1]==1
          str2="#{str2} Tomorrow (#{disp_date(t_d,1)})"
        else
          str2="#{str2} #{mmzz[i][1]} days from now (#{disp_date(t_d,1)})"
        end
      end
    end
    str=extend_message(str,str2,event,2)
  end
  f=[0,2]
  if f.include?(mode)
    matz=["Flame/Blaze/Inferno Orbs, Fiend's Horn, Fiend's Eye, Water/Stream/Deluge Orbs, Ancient Bird's Feather, Bewitching Wing, Wind/Storm/Maelstorm Orbs, Granite, Meteorite, Light/Radiance/Refulgence Orbs, Fiend's Claw, Shadow/Nightfall/Nether Orbs",
          "Flame/Blaze/Inferno Orbs, Fiend's Horn, Fiend's Eye, Water/Stream/Deluge Orbs, Ancient Bird's Feather, Bewitching Wing, Wind/Storm/Maelstorm Orbs, Granite, Meteorite, Light/Radiance/Refulgence Orbs, Fiend's Claw, Shadow/Nightfall/Nether Orbs",
          "Flame/Blaze/Inferno Orbs, Fiend's Horn, Fiend's Eye","Water/Stream/Deluge Orbs, Ancient Bird's Feather, Bewitching Wing",
          "Wind/Storm/Maelstorm Orbs, Granite, Meteorite","Light/Radiance/Refulgence Orbs, Fiend's Claw",
          "Shadow/Nightfall/Nether Orbs, Ancient Bird's Feather, Bewitching Wing"]
    matz=matz.rotate(t.wday)
    mmzz=[]
    for i in 0...matz.length
      m=matz[i].split(', ')
      for i2 in 0...m.length
        mmzz.push([m[i2],i])
        mmzz.push([m[i2],7]) if i==0
      end
    end
    mmzz.sort!{|a,b| (a[0]<=>b[0])==0 ? (a[1]<=>b[1]) : (a[0]<=>b[0])}
    mmzz.reverse!
    for i in 0...mmzz.length-1
      if mmzz[i][0]==mmzz[i+1][0]
        mmzz[i+1][2]=mmzz[i][1]*1 unless mmzz[i+1][1]>0
        mmzz[i]=nil
      end
    end
    mmzz.compact!
    mmzz.reverse!
    str2="__**Materials** found in the Elemental Ruins__"
    strpost=false
    for i in 0...mmzz.length
      str2="#{str2}\n*#{mmzz[i][0]}* -"
      if mmzz[i][1]==0
        str2="#{str2} **Today**#{' - Next available' unless mmzz[i][2].nil? || mmzz[i][2]<=0}"
        if mmzz[i][2].nil? || mmzz[i][2]<=0
        else
          t_d=t+mmzz[i][2]*24*60*60
          if mmzz[i][2]==1
            str2="#{str2} tomorrow (#{disp_date(t_d,1)})"
          else
            str2="#{str2} #{mmzz[i][2]} days from now (#{disp_date(t_d,1)})"
          end
        end
      else
        t_d=t+mmzz[i][1]*24*60*60
        if mmzz[i][1]==1
          str2="#{str2} Tomorrow (#{disp_date(t_d,1)})"
        else
          str2="#{str2} #{mmzz[i][1]} days from now (#{disp_date(t_d,1)})"
        end
      end
    end
  end
  f.push(6)
  if f.include?(mode)
    matz=void.map{|q| q.split(', ').uniq.sort.join(', ')}
    matzx=$voids[8,$voids.length-8].map{|q| q.split(', ')}
    for i in 0...matzx.length
      matzx[i]=[matzx[i][0],matzx[i][1,matzx[i].length-1].join(', ')]
    end
    for i in 0...matz.length
      for i2 in 0...matzx.length
        matz[i]=matz[i].gsub(matzx[i2][0],matzx[i2][1])
      end
    end
    matz=matz.map{|q| q.split(', ').uniq.sort}
    mmzz=[]
    for i in 0...matz.length
      m=matz[i]
      for i2 in 0...m.length
        mmzz.push([m[i2],i])
        mmzz.push([m[i2],7]) if i==0
      end
    end
    mmzz=mmzz.reject{|q| q[0].nil? || q[0].length<=0}
    mmzz.sort!{|a,b| (a[0]<=>b[0])==0 ? (a[1]<=>b[1]) : (a[0]<=>b[0])}
    mmzz.reverse!
    for i in 0...mmzz.length-1
      if mmzz[i][0]==mmzz[i+1][0]
        mmzz[i+1][2]=mmzz[i][1]*1 unless mmzz[i+1][1]>0
        mmzz[i]=nil
      end
    end
    mmzz.compact!
    mmzz.reverse!
    str2="__**Materials** found in the Void Strikes__"
    if mmzz.length>25 && !safe_to_spam?(event)
      mmzz=mmzz.reject{|q| q[1]>2} if mmzz.length>50
      mmzz=mmzz.reject{|q| q[1]>1} if mmzz.length>50
      for i in 0...mmzz.length
        mmzz[i][0]="*#{mmzz[i][0]}*" if mmzz[i][1]==1 || mmzz[i][2]==1
        mmzz[i][0]="**#{mmzz[i][0]}**#{"  (#{mmzz[i][2]})" unless mmzz[i][2]==1}" if mmzz[i][1]==0
      end
      create_embed(event,"#{str}\n\n#{str2}","**Bold** mats are available today, and include in parenthesis the number of days for them to become available again.\n*Italic* mats are available tomorrow.",0xCE456B,'For the full list of mats, use this command in PM.',nil,triple_finish(mmzz.map{|q| q[0]}))
      return nil
    end
    strpost=false
    for i in 0...mmzz.length
      str2="#{str2}\n*#{mmzz[i][0]}* -"
      if mmzz[i][1]==0
        str2="#{str2} **Today**#{' - Next available' unless mmzz[i][2].nil? || mmzz[i][2]<=0}"
        if mmzz[i][2].nil? || mmzz[i][2]<=0
        else
          t_d=t+mmzz[i][2]*24*60*60
          if mmzz[i][2]==1
            str2="#{str2} tomorrow (#{disp_date(t_d,1)})"
          else
            str2="#{str2} #{mmzz[i][2]} days from now (#{disp_date(t_d,1)})"
          end
        end
      else
        t_d=t+mmzz[i][1]*24*60*60
        if mmzz[i][1]==1
          str2="#{str2} Tomorrow (#{disp_date(t_d,1)})"
        else
          str2="#{str2} #{mmzz[i][1]} days from now (#{disp_date(t_d,1)})"
        end
      end
    end
    if str2.length>2000
      str2=str2.split("\n")
      str=extend_message(str,str2[0],event,2)
      for i in 1...str2.length
        str=extend_message(str,str2[i],event)
      end
    else
      str=extend_message(str,str2,event,2)
    end
  end
  f=[0,3]
  f.push(2) if safe_to_spam?(event)
  if f.include?(mode)
    matz=["Light Metal, Abyss Stone","Iron Ore, Granite","Fiend's Claw, Fiend's Horn","Bat Wing, Ancient Bird's Feather",'Iron Ore, Granite',
          "Fiend's Claw, Fiend's Horn","Bat Wing, Ancient Bird's Feather"]
    matz=matz.rotate(t.wday)
    mmzz=[]
    for i in 0...matz.length
      m=matz[i].split(', ')
      for i2 in 0...m.length
        mmzz.push([m[i2],i])
        mmzz.push([m[i2],7]) if i==0
      end
    end
    mmzz.sort!{|a,b| (a[0]<=>b[0])==0 ? (a[1]<=>b[1]) : (a[0]<=>b[0])}
    mmzz.reverse!
    for i in 0...mmzz.length-1
      if mmzz[i][0]==mmzz[i+1][0]
        mmzz[i+1][2]=mmzz[i][1]*1 unless mmzz[i+1][1]>0
        mmzz[i]=nil
      end
    end
    mmzz.compact!
    mmzz.reverse!
    str2="__Materials sold by the **Shop**__"
    strpost=false
    for i in 0...mmzz.length
      str2="#{str2}\n*#{mmzz[i][0]}* -"
      if mmzz[i][1]==0
        str2="#{str2} **Today**#{' - Next available' unless mmzz[i][2].nil? || mmzz[i][2]<=0}"
        if mmzz[i][2].nil? || mmzz[i][2]<=0
        else
          t_d=t+mmzz[i][2]*24*60*60
          if mmzz[i][2]==1
            str2="#{str2} tomorrow (#{disp_date(t_d,1)})"
          else
            str2="#{str2} #{mmzz[i][2]} days from now (#{disp_date(t_d,1)})"
          end
        end
      else
        t_d=t+mmzz[i][1]*24*60*60
        if mmzz[i][1]==1
          str2="#{str2} Tomorrow (#{disp_date(t_d,1)})"
        else
          str2="#{str2} #{mmzz[i][1]} days from now (#{disp_date(t_d,1)})"
        end
      end
    end
    str=extend_message(str,str2,event,2)
  end
  if [0,4].include?(mode)
    bond=['Golden Chalice','Juicy Meat','Kaleidoscope','Floral Circlet','Compelling Book','Mana Essence','Golden Chalice']
    bond=bond.rotate(t.wday)
    str2='__**Dragon Bond items**__'
    for i in 0...bond.length
      if i==0
        t2=t+24*60*60*(i+1)
        str2="#{str2}\n#{bond[i]} - Today#{" - Next available tomorrow (#{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t2.wday]}, #{t2.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t2.month]} #{t2.year})" if bond[0]==bond[1]}"
      elsif bond[i]==bond[i-1]
      else
        t2=t+24*60*60*i
        str2="#{str2}\n#{bond[i]} - #{"#{i} days from now" if i>1}#{"Tomorrow" if i==1} - #{t2.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t2.month]} #{t2.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t2.wday]})"
      end
    end
    t2=t+24*60*60*bond.length
    str2="#{str2}\n#{bond[0]} - #{bond.length} days from now - #{t2.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t2.month]} #{t2.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t2.wday]})" unless [bond[1],bond[-1]].include?(bond[0])
    str=extend_message(str,str2,event,2)
  end
  event.respond str
end

def exp_shift(m,mode=0)
  if mode==2
    if m==0
      return '-'
    elsif m%3500==0
      return "#{longFormattedNumber(m/3500)} Gold Crystal#{'s' unless m/3500==1}"
    elsif m>3500
      return "#{longFormattedNumber(m/3500)} Gold Crystal#{'s' unless m/3500==1}, #{exp_shift(m-(m/3500)*3500,2)}"
    elsif m%1000==0
      return "#{longFormattedNumber(m/1000)} Silver Crystal#{'s' unless m/1000==1}"
    elsif m>1000
      return "#{longFormattedNumber(m/1000)} Silver Crystal#{'s' unless m/1000==1}, #{exp_shift(m-(m/1000)*1000,2)}"
    elsif m%150==0
      return "#{longFormattedNumber(m/150)} Bronze Crystal#{'s' unless m/150==1}"
    else
      return "#{longFormattedNumber(m/150+1)} Bronze Crystal#{'s' unless m/150==0}"
    end
  elsif mode==3
    if m==0
      return '-'
    elsif m%3500==0
      return "#{longFormattedNumber(m/3500)} Succulent Dragonfruit#{'s' unless m/3500==1}"
    elsif m>3500
      return "#{longFormattedNumber(m/3500)} Succulent Dragonfruit#{'s' unless m/3500==1}, #{exp_shift(m-(m/3500)*3500,3)}"
    elsif m%1000==0
      return "#{longFormattedNumber(m/1000)} Ripe Dragonfruit#{'s' unless m/1000==1}"
    elsif m>1000
      return "#{longFormattedNumber(m/1000)} Ripe Dragonfruit#{'s' unless m/1000==1}, #{exp_shift(m-(m/1000)*1000,3)}"
    elsif m%150==0
      return "#{longFormattedNumber(m/150)} Dragonfruit#{'s' unless m/150==1}"
    else
      return "#{longFormattedNumber(m/150+1)} Dragonfruit#{'s' unless m/150==0}"
    end
  elsif mode==4
    if m==0
      return '-'
    elsif m%1800==0
      return "#{longFormattedNumber(m/1800)} Favored Bondfood"
    elsif m>1800
      return "#{longFormattedNumber(m/1800)} Favored Bondfood, #{exp_shift(m-(m/1800)*1800,4)}"
    elsif m%1200==0
      return "#{longFormattedNumber(m/1200)} Unfavored Bondfood"
    elsif m>1200
      return "#{longFormattedNumber(m/1200)} Unfavored Bondfood, #{exp_shift(m-(m/1200)*1200,4)}"
    elsif m%1000==0
      return "#{longFormattedNumber(m/1000)} Four-Leaf Clover#{'s' unless m/1000==1}"
    elsif m>1000
      return "#{longFormattedNumber(m/1000)} Four-Leaf Clover#{'s' unless m/1000==1}, #{exp_shift(m-(m/1000)*1000,4)}"
    elsif m%300==0
      return "#{longFormattedNumber(m/300)} bottle#{'s' unless m/300==1} of Tasty Milk"
    else
      return "#{longFormattedNumber(m/300+1)} bottle#{'s' unless m/300==0} of Tasty Milk"
    end
  elsif mode==5
    if m==0
      return '-'
    elsif m%3500==0
      return "#{longFormattedNumber(m/3500)} Consecrated Water"
    elsif m>3500
      return "#{longFormattedNumber(m/3500)} Consecrated Water, #{exp_shift(m-(m/3500)*3500,5)}"
    elsif m%1000==0
      return "#{longFormattedNumber(m/1000)} Blessed Water"
    elsif m>1000
      return "#{longFormattedNumber(m/1000)} Blessed Water, #{exp_shift(m-(m/1000)*1000,5)}"
    elsif m%500==0
      return "#{longFormattedNumber(m/500)} Holy Water"
    else
      return "#{longFormattedNumber(m/500+1)} Holy Water"
    end
  elsif mode==6
    if m==0
      return '-'
    elsif m%3500==0
      return "#{longFormattedNumber(m/3500)} Gold Whetstone#{'s' unless m/3500==1}"
    elsif m>3500
      return "#{longFormattedNumber(m/3500)} Gold Whetstone#{'s' unless m/3500==1}, #{exp_shift(m-(m/3500)*3500,6)}"
    elsif m%1000==0
      return "#{longFormattedNumber(m/1000)} Silver Whetstone#{'s' unless m/1000==1}"
    elsif m>1000
      return "#{longFormattedNumber(m/1000)} Silver Whetstone#{'s' unless m/1000==1}, #{exp_shift(m-(m/1000)*1000,6)}"
    elsif m%500==0
      return "#{longFormattedNumber(m/150)} Bronze Whetstone#{'s' unless m/500==1}"
    else
      return "#{longFormattedNumber(m/150+1)} Bronze Whetstone#{'s' unless m/500==0}"
    end
  end
end

def focus_feed(favor,exp_target,loon=false)
  t=Time.now
  timeshift=7
  timeshift-=1 unless t.dst?
  t-=60*60*timeshift
  exp=0
  days=0
  while exp<exp_target
    days+=1
    exp+=100+300+600+1000
    if t.wday==0 || t.wday==6
      exp+=2000
    elsif t.wday==favor
      exp+=1800
    elsif loon
    else
      exp+=1200
    end
    t+=24*60*60
  end
  return days
end

def level(event,bot,args=nil,mode=0)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.map{|q| q.downcase}
  nums=[]
  for i in 0...args.length
    nums.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0
    mode=1 if mode==0 && ['player','pxp','pexp','plxp','plexp','plevel','pllevel'].include?(args[i])
    mode=2 if mode==0 && ['adventurer','adventurers','adv','axp','aexp','advxp','advexp','alevel','advlevel'].include?(args[i])
    mode=3 if mode==0 && ['dragon','dragons','drg','dxp','dexp','drgxp','drgexp','dlevel','drglevel'].include?(args[i])
    mode=4 if mode==0 && ['bond','dragonbond','dbxp','dbexp','bxp','bexp','bondxp','bondexp','blevel','dblevel','bondlevel'].include?(args[i])
    mode=5 if mode==0 && ['wyrmprint','wyrmprints','wyrm','wyrms','wrxp','wrexp','wrxp','wrlevel','wyrmxp','wyrmexp','wyrmxp','wyrmlevel'].include?(args[i])
    mode=6 if mode==0 && ['weapon','weapons','wpxp','wpexp','wplevel','weaponxp','weaponexp','weaponlevel'].include?(args[i])
    mode=7 if mode==0 && ['wxp','wexp','wlevel'].include?(args[i])
  end
  if mode==0 && !safe_to_spam?(event)
    event.respond "Please either specify an EXP type or use this command in PM.\n\nAvailable EXP types include:\n- Player\n- Adventurer\n- Dragon\n- Dragon Bond\n- Wyrmprint\n- Weapon"
    return nil
  end
  nums.uniq!
  str=''
  if [1,0].include?(mode)
    pxp=[[12,18,25],[15,20,26],[24,22,26],[27,24,27],[30,25,27],[33,26,28],[36,27,28],[39,28,29],[42,29,29],[45,30,30],[57,31,30],[60,32,31],[63,33,31],
         [66,34,32],[69,35,32],[72,36,33],[75,37,33],[78,38,34],[81,39,34],[84,40,35],[87,41,35],[90,42,36],[93,43,36],[96,44,37],[99,45,37],[102,46,38],
         [105,47,38],[108,48,39],[111,49,39],[114,50,40],[117,51,40],[120,52,41],[123,53,41],[126,54,42],[129,55,42],[132,56,43],[135,57,43],[138,58,44],
         [141,59,44],[144,60,45],[147,61,45],[150,62,46],[153,63,46],[156,64,47],[159,65,47],[162,66,48],[165,67,48],[168,68,49],[171,69,49],[180,70,50],
         [190,71,50],[200,72,51],[210,73,51],[220,74,52],[230,75,52],[240,76,53],[250,77,53],[260,78,54],[270,79,54],[280,80,55],[300,80,55],[320,81,56],
         [340,81,56],[360,82,57],[380,82,57],[400,83,58],[420,83,58],[440,84,59],[460,84,59],[480,85,60],[510,85,60],[540,86,61],[570,86,61],[600,87,62],
         [630,87,62],[660,88,63],[690,88,63],[720,89,64],[750,89,64],[800,90,65],[850,90,65],[900,91,66],[950,91,66],[1000,92,67],[1050,92,67],[1100,93,68],
         [1150,93,68],[1200,94,69],[1250,94,69],[1300,95,70],[1350,95,70],[1400,96,71],[1450,96,71],[1500,97,72],[1550,97,72],[1600,98,73],[1650,98,73],
         [1700,99,74],[1750,99,74],[1800,100,75],[1900,100,75],[2000,101,76],[2100,101,76],[2200,102,77],[2300,102,77],[2400,103,78],[2500,103,78],
         [2600,104,79],[2700,104,79],[2800,105,80],[2900,105,80],[3000,106,81],[3100,106,81],[3200,107,82],[3300,107,82],[3400,108,83],[3500,108,83],
         [3600,109,84],[3700,109,84],[3900,110,85],[4100,110,85],[4300,111,86],[4500,111,86],[4700,112,87],[4900,112,87],[5100,113,88],[5300,113,88],
         [5500,114,89],[5700,114,89],[5900,115,90],[6100,115,90],[6300,115,91],[6500,116,91],[6700,116,92],[6900,116,92],[7100,117,93],[7300,117,93],
         [7500,117,94],[7700,118,94],[7900,118,95],[8100,118,95],[8300,119,96],[8500,119,96],[8700,119,97],[8900,120,97],[9100,120,98],[9300,120,98],
         [9500,121,99],[9700,121,99],[9900,121,100],[10100,122,100],[10300,122,101],[10500,122,101],[10700,123,102],[10900,123,102],[11100,123,103],
         [11300,124,103],[11500,124,104],[11700,124,104],[11900,125,105],[12200,125,105],[12500,125,106],[12800,126,106],[13100,126,107],[13400,126,107],
         [13700,127,108],[14000,127,108],[14300,127,109],[14600,128,109],[14900,128,110],[15200,128,110],[15500,129,111],[15800,129,111],[16100,129,112],
         [16400,130,112],[16700,130,113],[17000,130,113],[17300,131,114],[17600,131,114],[17900,131,115],[18200,132,115],[18500,132,116],[18800,132,116],
         [19100,133,117],[19400,133,117],[19700,133,118],[20000,134,118],[20300,134,119],[20600,134,119],[20900,135,120],[21200,135,120],[21500,135,121],
         [21800,136,121],[22100,136,122],[22400,136,122],[22700,137,123],[23000,137,123],[23300,137,124],[23600,138,124],[23900,138,125]]
    pxp[-1][0]=0
    str2="__**Player EXP**__"
    if nums.length<=0
      str2="#{str2}\n*To get from level 1 to level #{pxp.length}:*  \u200B  \u200B  #{longFormattedNumber(pxp.map{|q| q[0]*10}.inject(0){|sum,x| sum + x })} EXP required"
      str2="#{str2}\n*Resulting stamina increase:*  \u200B  \u200B  #{pxp[pxp.length-1][1]-pxp[0][1]} points of increase ~~(from #{pxp[0][1]} to #{pxp[pxp.length-1][1]})~~"
      str2="#{str2}\n*Resulting friends list increase:*  \u200B  \u200B  #{pxp[pxp.length-1][2]-pxp[0][2]} more friends ~~(from #{pxp[0][2]} to #{pxp[pxp.length-1][2]})~~"
    elsif nums.length==1
      n=[nums[0],pxp.length].min
      unless n==1
        str2="#{str2}#{"\n" unless n==pxp.length}\n*To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(pxp[0,n-1].map{|q| q[0]*10}.inject(0){|sum,x| sum + x })} EXP required"
        str2="#{str2}\n*Resulting stamina increase:*  \u200B  \u200B  #{pxp[n-1][1]-pxp[0][1]} points of increase ~~(from #{pxp[0][1]} to #{pxp[n-1][1]})~~"
        str2="#{str2}\n*Resulting friends list increase:*  \u200B  \u200B  #{pxp[n-1][2]-pxp[0][2]} more friends ~~(from #{pxp[0][2]} to #{pxp[n-1][2]})~~"
      end
      unless n==pxp.length
        str2="#{str2}#{"\n" unless n==1}\n*To get from level #{n} to level #{pxp.length}:*  \u200B  \u200B  #{longFormattedNumber(pxp[n-1,pxp.length-n].map{|q| q[0]*10}.inject(0){|sum,x| sum + x })} EXP required"
        str2="#{str2}\n*Resulting stamina increase:*  \u200B  \u200B  #{pxp[pxp.length-1][1]-pxp[n-1][1]} points of increase ~~(from #{pxp[n-1][1]} to #{pxp[pxp.length-1][1]})~~"
        str2="#{str2}\n*Resulting friends list increase:*  \u200B  \u200B  #{pxp[pxp.length-1][2]-pxp[n-1][2]} more friends ~~(from #{pxp[n-1][2]} to #{pxp[pxp.length-1][2]})~~"
      end
    else
      n=[nums[0,2].min,1].max
      n=1 if n>pxp.length
      m=[nums[0,2].max,pxp.length].min
      str2="#{str2}\n*To get from level #{n} to level #{m}:*  \u200B  \u200B  #{longFormattedNumber(pxp[n-1,m-n].map{|q| q[0]*10}.inject(0){|sum,x| sum + x })} EXP required"
      str2="#{str2}\n*Resulting stamina increase:*  \u200B  \u200B  #{pxp[m-1][1]-pxp[n-1][1]} points of increase ~~(from #{pxp[n-1][1]} to #{pxp[m-1][1]})~~"
      str2="#{str2}\n*Resulting friends list increase:*  \u200B  \u200B  #{pxp[m-1][2]-pxp[n-1][2]} more friends ~~(from #{pxp[n-1][2]} to #{pxp[m-1][2]})~~"
    end
    str=extend_message(str,str2,event,2)
  end
  if [2,0].include?(mode)
    axp=[3,5,7,9,11,15,19,23,27,31,38,45,52,59,66,78,90,102,114,126,151,176,201,226,251,301,351,401,451,501,576,651,726,801,876,951,1026,1101,1176,1251,1326,
         1401,1476,1551,1626,1701,1776,1851,1926,2001,2076,2151,2226,2301,2376,2451,2526,2601,2676,2751,3260,3280,3300,3320,3340,3360,3380,3400,3420,3440,3460,
         3480,3500,3520,3540,3560,3580,3600,3620,20000,21500,23000,24500,26000,27500,29000,30500,32000,33500,35000,38000,41000,44000,47000,50000,54500,59000,
         63500,68000,0]
    str2="__**Adventurer EXP**__"
    if nums.length<=0
      m=axp[0,60].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level 1 to level 60:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
      m=axp[0,70].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level 1 to level 70:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
      m=axp[0,80].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level 1 to level 80:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
      m=axp[0,1000].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_6:660289379520086046> *To get from level 1 to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
    elsif nums.length==1
      n=[nums[0],axp.length].min
      m=axp[0,n].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_1_Blank:555459856476274691> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
      if n<60
        m=axp[n-1,60-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level #{n} to level 60:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
      end
      if n<70
        m=axp[n-1,70-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level #{n} to level 70:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
      end
      if n<80
        m=axp[n-1,80-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level #{n} to level 80:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
      end
      if n<100
        m=axp[n-1,100-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_6:660289379520086046> *To get from level #{n} to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
      end
    else
      n=[nums[0,2].min,1].max
      n=1 if n>axp.length
      n2=[nums[0,2].max,axp.length].min
      m=axp[n-1,n2-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n*To get from level #{n} to level #{n2}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
    end
    str=extend_message(str,str2,event,2)
  end
  if [3,0].include?(mode)
    dxp=[24,30,36,42,48,54,60,66,72,78,90,102,114,126,138,150,162,174,186,198,216,234,252,270,288,306,324,342,360,378,402,426,450,474,498,522,546,570,594,618,
         648,678,708,738,768,798,828,858,888,918,954,990,1026,1062,1098,1134,1170,1206,1242,1278,1323,1368,1413,1458,1503,1548,1593,1638,1683,1728,1788,1848,
         1908,1968,2028,2088,2148,2208,2268,2328,2403,2478,2553,2628,2703,2778,2853,2928,3003,3078,3168,3258,3348,3438,3528,3618,3708,3798,3888,0]
    str2="__**Dragon EXP**__"
    if nums.length<=0
      m=dxp[0,59].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level 1 to level 60:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
      m=dxp[0,79].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level 1 to level 80:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
      m=dxp[0,99].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level 1 to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
    elsif nums.length==1
      n=[nums[0],dxp.length].min
      m=dxp[0,n].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_1_Blank:555459856476274691> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
      if n<60
        m=dxp[n-1,60-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level #{n} to level 60:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
      end
      if n<80
        m=dxp[n-1,80-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level #{n} to level 80:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
      end
      if n<100
        m=dxp[n-1,100-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level #{n} to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
      end
    else
      n=[nums[0,2].min,1].max
      n=1 if n>dxp.length
      n2=[nums[0,2].max,dxp.length].min
      m=dxp[n-1,n2-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n*To get from level #{n} to level #{n2}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
    end
    str=extend_message(str,str2,event,2)
    mode=4 if mode==3
  end
  if [4,0].include?(mode)
    bxp=[[8,7.1],[16,7.2],[18,7.3],[20,7.4],[22,7.5],[26,7.6],[30,7.7],[40,7.8],[50,7.9],[60,8.0],[70,8.1],[80,8.2],[90,8.3],[100,8.4],[110,8.5],[120,8.6],
         [130,8.7],[140,8.8],[150,8.9],[160,9.0],[175,9.1],[190,9.2],[205,9.3],[220,9.4],[240,9.5],[260,9.6],[280,9.7],[300,9.8],[320,9.9],[0,10.0]]
    str2="__**Dragon Bond**__"
    k=find_data_ex(:find_dragon,args.reject{|q| q.to_i.to_s==q}.join(' '),event)
    str2="#{str2}\nFocused feeding time shown for #{k.name}, whose favored bondfood is #{['Golden Chalice (Sunday)','Juicy Meat (Monday)','Kaleidoscope (Tuesday)','Floral Circlet (Wednesday)','Compelling Book (Thursday)','Mana Essence (Friday)','Golden Chalice (Saturday)'][k.favorite]}" unless k.nil?
    if nums.length<=0
      m=bxp.map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n*To get from level 1 to level #{bxp.length}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
      str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
      str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k.favorite,m)} days starting from today" unless k.nil?
      str2="#{str2}\n*Semi-focused feeding time:*  #{focus_feed(k.favorite,m,true)} days starting from today" unless k.nil?
      str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[bxp.length-1][1]-bxp[0][1])} additional seconds ~~(from #{bxp[0][1]} sec to #{bxp[bxp.length-1][1]} sec)~~"
    elsif nums.length==1
      n=[nums[0],bxp.length].min
      unless n==1
        m=bxp[0,n-1].map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}#{"\n" unless n==bxp.length}\n*To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
        str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
        str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k.favorite,m)} days starting from today" unless k.nil?
        str2="#{str2}\n*Semi-focused feeding time:*  #{focus_feed(k.favorite,m,true)} days starting from today" unless k.nil?
        str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[n-1][1]-bxp[0][1])} additional seconds ~~(from #{bxp[0][1]} sec to #{bxp[n-1][1]} sec)~~"
      end
      unless n==bxp.length
        m=bxp[n-1,bxp.length-n].map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}#{"\n" unless n==1}\n*To get from level #{n} to level #{bxp.length}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
        str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
        str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k.favorite,m)} days starting from today" unless k.nil?
        str2="#{str2}\n*Semi-focused feeding time:*  #{focus_feed(k.favorite,m,true)} days starting from today" unless k.nil?
        str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[bxp.length-1][1]-bxp[n-1][1])} additional seconds ~~(from #{bxp[n-1][1]} sec to #{bxp[bxp.length-1][1]} sec)~~"
      end
    else
      n=[nums[0,2].min,1].max
      n=1 if n>bxp.length
      n2=[nums[0,2].max,bxp.length].min
      m=bxp[n-1,n2-n].map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n*To get from level #{n} to level #{n2}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
      str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
      str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k.favorite,m)} days starting from today" unless k.nil?
      str2="#{str2}\n*Semi-focused feeding time:*  #{focus_feed(k.favorite,m,true)} days starting from today" unless k.nil?
      str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[n2-1][1]-bxp[n-1][1])} additional seconds ~~(from #{bxp[n-1][1]} sec to #{bxp[n2-1][1]} sec)~~"
    end
    str2="#{str2}\n\nInclude a dragon's name to show focused feeding times." if k.nil?
    str=extend_message(str,str2,event,2)
  end
  if [5,7,0].include?(mode)
    str2="__**Wyrmprint EXP**__"
    if nums.length<=0
      str2="#{str2}\n<:Rarity_2:532086056254963713> *To get from level 1 to level 10:*  \u200B  \u200B  70 Holy Water"
      str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level 1 to level 20:*  \u200B  \u200B  40 Consecrated Water, 140 Holy Water"
      str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level 1 to level 40:*  \u200B  \u200B  120 Consecrated Water, 120 Holy Water"
      str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level 1 to level 50:*  \u200B  \u200B  250 Consecrated Water, 150 Holy Water"
    elsif nums.length==1
      n=[nums[0],50].min
      if n<10
        m=10-n
        str2="#{str2}\n<:Rarity_2_Blank:555459856400908299> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{7*n-7} Holy Water"
        str2="#{str2}\n<:Rarity_2:532086056254963713> *To get from level #{n} to level 10:*  \u200B  \u200B  #{7*m} Holy Water"
      end
      if n<20
        m=20-n
        str2="#{str2}\n<:Rarity_3_Blank:555459856568418314> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{2*n-2} Consecrated Water, #{7*n-7} Holy Water"
        str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level #{n} to level 20:*  \u200B  \u200B  #{2*m} Consecrated Water, #{7*m} Holy Water"
      end
      if n<40
        m=40-n
        str2="#{str2}\n<:Rarity_4_Blank:555459856497246218> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{3*n-3} Consecrated Water, #{3*n-3} Holy Water"
        str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level #{n} to level 40:*  \u200B  \u200B  #{3*m} Consecrated Water, #{3*m} Holy Water"
      end
      if n<50
        m=50-n
        str2="#{str2}\n<:Rarity_5_Blank:555459856190930955> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{5*n-5} Consecrated Water, #{3*n-3} Holy Water"
        str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level #{n} to level 50:*  \u200B  \u200B  #{5*m} Consecrated Water, #{3*m} Holy Water"
      end
    else
      n=[nums[0,2].min,1].max
      n=1 if n>50
      n2=[nums[0,2].max,50].min
      m=[n2,10].min-n
      str2="#{str2}\n<:Rarity_2:532086056254963713> *To get from level #{n} to level #{m+n}:*  \u200B  \u200B  #{7*m} Holy Water" if n<10
      m=[n2,20].min-n
      str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level #{n} to level #{m+n}:*  \u200B  \u200B  #{2*m} Consecrated Water, #{7*m} Holy Water" if n<20
      m=[n2,40].min-n
      str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level #{n} to level #{m+n}:*  \u200B  \u200B  #{3*m} Consecrated Water, #{3*m} Holy Water" if n<40
      m=[n2,50].min-n
      str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level #{n} to level #{m+n}:*  \u200B  \u200B  #{5*m} Consecrated Water, #{3*m} Holy Water" if n<50
    end
    str=extend_message(str,str2,event,2)
  end
  if [6,7,0].include?(mode)
    wrxp=[50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,155,165,175,185,195,205,215,225,235,245,260,275,290,305,320,335,350,365,380,
          395,425,455,485,515,545,575,605,635,665,695,730,765,800,835,870,905,940,975,1010,1045,1090,1135,1180,1225,1270,1315,1360,1405,1450,1495,1575,1655,
          1735,1815,1895,1975,2055,2135,2215,2295,2395,2495,2595,2695,2795,2895,2995,3095,3195,3295,3415,3535,3655,3775,3895,4015,4135,4255,4375,4495,4620,
          4745,4870,4995,5120,5245,5370,5495,5620,5745,5870,5995,6120,6245,6370,6495,6620,6745,6870,6995,7120,7245,7370,7495,7620,7745,7870,7995,8120,8245,
          8370,8495,8620,8745,8870,8995,9120,9245,9370,9495,9620,9745,9870,9995,10120,10245,10370,10495,10620,10745,10875,11005,11135,11265,11395,11525,11655,
          11785,11915,12045,12175,12305,12435,12565,12695,12825,12955,13085,13215,13345,13475,13605,13735,13865,13995,14125,14255,14385,14515,14645,14775,
          14905,15035,15165,15295,15425,15555,15685,15815,15945,16075,16205,16335,16465,16595,16725,16855,16985,17115,0]
    str2="__**Weapon EXP**__"
    if nums.length<=0
      m=wrxp[0,30].inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_2:532086056254963713> *To get from level 1 to level 30:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
      m=wrxp[0,40].inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level 1 to level 40:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
      m=wrxp[0,70].inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level 1 to level 70:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
      m=wrxp[0,100].inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level 1 to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
      m=wrxp[0,200].inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_6:660289379520086046> *To get from level 1 to level 200:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
    elsif nums.length==1
      n=[nums[0],wrxp.length].min
      m=wrxp[0,n].inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_1_Blank:555459856476274691> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
      if n<30
        m=wrxp[n-1,30-n].inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_2:532086056254963713> *To get from level #{n} to level 30:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
      end
      if n<40
        m=wrxp[n-1,40-n].inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level #{n} to level 40:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
      end
      if n<70
        m=wrxp[n-1,70-n].inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level #{n} to level 70:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
      end
      if n<100
        m=wrxp[n-1,100-n].inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level #{n} to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
      end
      if n<200
        m=wrxp[n-1,200-n].inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_6:660289379520086046> *To get from level #{n} to level 200:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
      end
    else
      n=[nums[0,2].min,1].max
      n=1 if n>wrxp.length
      n2=[nums[0,2].max,wrxp.length].min
      m=wrxp[n-1,n2-n].inject(0){|sum,x| sum + x }
      str2="#{str2}\n*To get from level #{n} to level #{n2}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
    end
    str2="#{str2}\n**Dragalia v2.0 has messed with weapon leveling mechanics.  These numbers are currently inaccurate, and may be so indefinitely.**"
    str=extend_message(str,str2,event,2)
  end
  event.respond str
end

def show_print_shop(event)
  data_load()
  prn=$wyrmprints.reject{|q| has_any?(['e','s','z','y','t','w','$','c','p'],q.availability)}
  args=event.message.text.downcase.split(' ')
  rar=[]
  for i in 0...args.length
    rar.push(args[i].to_i) if args[i].to_i.to_s==args[i]
    rar.push(args[i][0,1].to_i) if args[i][1,1]=='*' && args[i][0,1].to_i.to_s==args[i][0,1]
  end
  rar=rar.reject{|q| q<3 || q>$max_rarity[2]}
  if rar.length<=0 && !safe_to_spam?(event)
    event.respond "Too much data is trying to be displayed.  Please either specify a rarity or use this command in PM."
    return nil
  end
  rar=rar[0,1] unless safe_to_spam?(event)
  flds=[]
  flds.push(["#{generate_rarity_row(3)}\n900<:Resource_Eldwater:532104503777034270> per 2UB\n17,000<:Resource_Eldwater:532104503777034270> per MUB\n\n200 purchase, 300-400 per unbind",prn.reject{|q| q.rarity !=3}.map{|q| q[0]}]) if rar.length<=0 || rar.include?(3)
  flds.push(["#{generate_rarity_row(4)}\n9,000<:Resource_Eldwater:532104503777034270> per 2UB\n17,000<:Resource_Eldwater:532104503777034270> per MUB\n\n2000 purchase, 3000-4000 per unbind",prn.reject{|q| q.rarity !=4}.map{|q| q[0]}]) if rar.length<=0 || rar.include?(4)
  flds.push(["#{generate_rarity_row(5)}\n19,000<:Resource_Eldwater:532104503777034270> per 2UB\n37,000<:Resource_Eldwater:532104503777034270> per MUB\n\n4000 purchase, 6000-9000 per unbind",prn.reject{|q| q.rarity !=5}.map{|q| q[0]}]) if rar.length<=0 || rar.include?(5)
  flds.push(["#{generate_rarity_row(6)}\n25,000<:Resource_Eldwater:532104503777034270> per 2UB\n53,000<:Resource_Eldwater:532104503777034270> per MUB\n\n8000 purchase, 9000-12000 per unbind",prn.reject{|q| q.rarity !=6}.map{|q| q[0]}]) if rar.length<=0 || rar.include?(6)
  flds=flds.map{|q| [q[0],q[1].join("\n"),q[1].length]}
  flds=flds.reject{|q| q[2]<=0}
  flds=flds.map{|q| [q[0],q[1]]}
  if flds.map{|q| "**#{q[0]}**\n#{q[1]}"}.join("\n\n").length>=1500 || flds.length<2
    for i in 0...flds.length
      hdr=flds[i][0].split("\n\n")
      create_embed(event,"**#{hdr[0].gsub("\n",' - ')}**\n__#{hdr[1]}__",'',0xCE456B,nil,nil,triple_finish(flds[i][1].split("\n")))
    end
  else
    flds.map{|q| [q[0].gsub("\n\n","\n"),q[1]]}
    create_embed(event,'__**Wyrmprint Shop**__','',0xCE456B,nil,nil,flds)
  end
end

def show_abil_limits(event,bot)
  create_embed(event,'__**Wyrmprint ability stacking limits**__','',0xCE456B,'Limits shown here are for wyrmprint totals per adventurer, not per team or including native adventurer abilities',nil,triple_finish($abilimits,true))
end

def affinity_resonance(event,bot)
  f=[]
  str=''
  for i in 0...$resonance.length
    k=$resonance[i].map{|q| q}
    moji2=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{k[0]}"}
    m=[]
    if safe_to_spam?(event)
      m.push("*2 prints:* #{k[1]}") unless k[1].nil?
      m.push("*3 prints:* #{k[2]}") unless k[2].nil?
      m.push("*4 prints:* #{k[3]}") unless k[3].nil?
      f.push(["#{moji2[0].mention unless moji2.length<=0} #{k[0]}",m.join("\n")])
    else
      m.push(2) unless k[1].nil?
      m.push(3) unless k[2].nil?
      m.push(4) unless k[3].nil?
      str="#{str}\n#{moji2[0].mention unless moji2.length<=0}**#{k[0]}** x#{m.join('/')} = "
      m=k[1,3].compact
      m2=m[0].split(' ')
      m2.pop
      m2=m2.join(' ')
      str="#{str}#{m2} +#{m.map{|q| q.split(' ')[-1].gsub('+','')}.join('/')}"
    end
  end
  create_embed(event,"__**Affinity effects**__",str,0xED619A,nil,nil,f)
  return nil
end

def why_botan(event,bot)
  if (!event.message.text.downcase.include?('full') && !event.message.text.downcase.include?('long')) && !safe_to_spam?(event)
    str='"When making the bot, why did you pick Botan, a seasonal character?"'
    str="#{str}\n\nThe short answer is: Someone had already taken the name NotteBot, and Botan was the character in the game with red-adjacent hair who was the cutest at the time I made the bot."
    str="#{str}\n\nFor the full story, please use the command `DL!whybotan full` or use the command in PM."
    create_embed(event,"__A word from my developer__",str,0x008b8b)
  else
    str='"When making the bot, why did you pick Botan, a seasonal character?"'
    str="#{str}\n\nThe short answer is: Someone had already taken the name NotteBot, and Botan was the character in the game with red-adjacent hair who was the cutest at the time I made the bot."
    str="#{str}\n\nThe long answer is:"
    str="#{str}\n\nWhen the day-zero players for Dragalia (people who downloaded the game off the APK site before it became officially available) started sending screenshots of the game, and I saw the cute pink-haired fairy, I actually briefly considered playing the game (because fun fact: the person who codes this bot doesn't actually play Dragalia.  The person who does the data entry, on the other hand, does play) and summoning for her."
    str="#{str}\n\nWhen I learned that she was the game's Navi, which intensified my desire to play - sure, I wouldn't be able to play *as* the tiny redhead, but she would be plot-relevant.  But what ultimately turned me off the game (and kept me from making the mistake of playing a third gacha game) was the fact that it was played in real-time - I can't do real-time action on a phone screen."
    str="#{str}\n\nBut I made the vague statement that if I ever made a bot for the game, then Notte - as the fairy was named - would be its face.  Which now begs the question of *why **isn't** she the face of your bot?*"
    create_embed(event,"__A word from my developer__",str,0x008b8b)
    str="Well, fast forward a few months.  The game's been out for a bit, and is teasing its first New Year's event, though I don't know this yet."
    str="#{str}\n\nI'm pulled into a server to answer a question about something FEH-related, and I answer it, but I also notice while there that there was a NotteBot, doing the expected thing of showing data relevant to Dragalia.  At first I'm glad that my Dragalia counterpart dev chose the right character to be the face of the bot - though, they likely chose her because she was the game's mascot, not because they had an attraction to pocket-sized redheads like I do."
    str="#{str}\n\nBut then I notice that - opposite to my usual problem with game bots - the data being displayed was accurate (or at least, no one in the server was claiming it was inaccurate)...but it was *formatted* in a user-unfriendly manner.  It was then that I decided to take matters into my own hands, but I obviously couldn't do NotteBot as that had already been taken."
    str="#{str}\n\nSo I make my declaration to the server in question, and ask them to show me pictures of any redheads in the game.  The only one I remember being shown was Cleo, and while her seasonal forms released after the bot have been very cute, her default form wasn't doing anything for me.  I think there were others, but again, none of them spoke to me."
    create_embed(event,'',str,0xFEB3B6)
    str="And then, an hour later, someone who hadn't been part of the original conversation pops in with a screenshot of the most recent teaser for the New Year's event - including the character we would later know as Botan."
    str="#{str}\n\n\"Her!\" I say.  \"What's her name?\""
    str="#{str}\n\"We don't know.  She's part of the upcoming New Year's thing.\""
    str="#{str}\n\"I'm going with her.  Ping me when she has a name.  In the meantime, I'm gonna start working on the bot.\""
    str="#{str}\n\nWhen we learned the name, there were some people who really wanted me to name the bot *Bot-an*.  And while I love puns quite a bit more than the average person (though not as much as someone like Chuggaaconroy) that name didn't fit the precident set by my previous gacha bots - and the mold that I retroactively applied to my first resource bot, which was previously named FEIndex and is now known as RobinBot.  So she became BotanBot."
    create_embed(event,'',str,0xC84563,"And before you ask, no, I do not remember what I had as the source code's filename before we knew her name.  The laptop that would have that info doesn't even turn on anymore.")
  end
end

def show_tools(event,bot)
  return nil if overlap_prevent(event)
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event) || event.message.text.downcase.include?('mobile') || event.message.text.downcase.include?('phone')
    event << '**Useful tools for players of** ***Dragalia Lost***'
    event << '__Download the game__'
    event << 'Google Play: <https://play.google.com/store/apps/details?id=com.aniplex.fategrandorder.en&hl=en_US>'
    event << 'Apple App Store: <https://itunes.apple.com/us/app/fate-grand-order-english/id1183802626?mt=8>'
    event << ''
    event << '__News__'
    event << 'In-game news: <https://dragalialost.com/en/news/>'
    event << 'Official Twitter: <https://twitter.com/dragalialostapp>'
    event << 'Official JP Twitter: <https://twitter.com/dragalialost>'
    event << '*Dragalia Life* manga: <https://comic.dragalialost.com/dragalialife/en/>'
    event << '*Dragalia Minis* manga <https://dragalialost.gamepedia.com/Dragalia_Minis>'
    event << ''
    event << '__Wikis & Databases__'
    event << 'Gamepedia Wiki: <https://dragalialost.wiki/>'
    event << 'Gamepress Database: <https://dragalialost.gamepress.gg/>'
    event << ''
    event << 'Stats Calculator: <https://junlico.github.io/dragalia-lost/>'
    event << 'Weapon Material Calculator: <https://yujinred.github.io/Dragalia-Weapon-Material-Calculator/>'
    event << 'Healing Formula/Calculator: <https://dragalialost.gamepedia.com/Healing_Formula>'
    event << 'Dragon Optimization Mastersheet: <https://docs.google.com/spreadsheets/d/1k-CROHAKTOGvR7-gJG5kFdMOc_qP5KayJ46fEI58GHI/edit#gid=700285435>'
    event << 'Skill Haste Calculator: <https://docs.google.com/spreadsheets/d/1Z886qU6xg4wp8ql_d7l6Kz5-aD4u_tvUXaAIgOGMq_s/edit#gid=97131039>'
    event << 'Skill Sharing guide: <https://docs.google.com/document/d/1OL9xwOFnWyIkiDqOguFCkrvFK2xl4RArmmcw2c1v1Fk/edit>'
    event << 'Time Attack Rankings: <https://dragalialost.com/en/special/timeattack/>'
  else
    xpic='https://lh3.googleusercontent.com/SIHM5RPpoLy3Xso8wxqzCzBggkNq6dYhLt8THToag6FW_peH43_k1YdKh23Xmu5i_6c=s180-rw'
    str="__Download the game__"
    str="#{str}\n[Google Play](https://play.google.com/store/apps/details?id=com.nintendo.zaga&hl=en_US)"
    str="#{str}\n[Apple App Store](https://itunes.apple.com/us/app/dragalia-lost/id1352230941?mt=8)"
    str="#{str}\n\n__News__"
    str="#{str}\n[In-game news](https://dragalialost.com/en/news/)"
    str="#{str}\n[Twitter](https://twitter.com/dragalialostapp)"
    str="#{str}  \u00B7  ([Japan](https://twitter.com/dragalialost))"
    str="#{str}\n[*Dragalia Life* manga](https://comic.dragalialost.com/dragalialife/en/)"
    str="#{str}  \u00B7  [*Dragalia Minis* manga](https://dragalialost.gamepedia.com/Dragalia_Minis)"
    str="#{str}\n\n__Wikis & Databases__"
    str="#{str}\n[Gamepedia Wiki](https://dragalialost.wiki/)"
    str="#{str}\n[Gamepress Database](https://dragalialost.gamepress.gg/)"
    str="#{str}\n\n__Calculators__"
    str="#{str}\n[Stats Calculator](https://junlico.github.io/dragalia-lost/)"
    str="#{str}\n[Weapon Material Calculator](https://yujinred.github.io/Dragalia-Weapon-Material-Calculator/)"
    str="#{str}\n[Healing Formula/Calculator](https://dragalialost.gamepedia.com/Healing_Formula)"
    str="#{str}\n[Dragon Optimization Mastersheet](https://docs.google.com/spreadsheets/d/1k-CROHAKTOGvR7-gJG5kFdMOc_qP5KayJ46fEI58GHI/edit#gid=700285435)"
    str="#{str}\n[Skill Haste Calculator](https://docs.google.com/spreadsheets/d/1Z886qU6xg4wp8ql_d7l6Kz5-aD4u_tvUXaAIgOGMq_s/edit#gid=97131039)"
    str="#{str}\n[Skill Sharing Guide](https://docs.google.com/document/d/1OL9xwOFnWyIkiDqOguFCkrvFK2xl4RArmmcw2c1v1Fk/edit)"
    str="#{str}\n[Time Attack Rankings](https://dragalialost.com/en/special/timeattack/)"
    create_embed(event,'**Useful tools for players of** ***Dragalia Lost***',str,0xED619A,nil,xpic)
    event.respond 'If you are on a mobile device and cannot click the links in the embed above, type `DL!tools mobile` to receive this message as plaintext.'
  end
  event << ''
end

def show_bot_status(event,bot)
  t=Time.now
  if $embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    event << "Current avatar: #{bot.user(543373018303299585).avatar_url}"
    event << "Adventurer/Dragon in avatar: #{$avvie_info[0]}"
    event << ''
    event << "Current status:"
    event << "[Playing] #{$avvie_info[1]}"
    event << ''
    event << "Reason: #{$avvie_info[2]}" unless $avvie_info[2].length.zero?
    event << ''
    event << "__extrachiz, she who made my default avatar__"
    event << "<https://twitter.com/extrachiz>"
    event << "<https://ko-fi.com/extrachiz>"
    event << ''
    event << "#{'Dev' if Shardizard==4}#{'Van' unless Shardizard==4}'s timezone: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]}) | #{'0' if t.hour<10}#{t.hour}:#{'0' if t.min<10}#{t.min}"
  else
    create_embed(event,'',"Adventurer/Dragon in avatar: #{$avvie_info[0]}\n\nCurrent status:\n[Playing] #{$avvie_info[1]}#{"\n\nReason: #{$avvie_info[2]}" unless $avvie_info[2].length.zero?}\n\n[For a full calendar of avatars, click here](https://docs.google.com/spreadsheets/d/1j-tdpotMO_DcppRLNnT8DN8Ftau-rdQ-ZmZh5rZkZP0/edit?usp=sharing)\nextrachiz, she who made my default avatar: [Twitter](https://twitter.com/extrachiz)  \u00B7  [Ko-fi](https://ko-fi.com/extrachiz)",(t.day*7+t.month*21*256+(t.year-2000)*10*256*256),"#{'Dev' if Shardizard==4}#{'Van' unless Shardizard==4}'s timezone: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]}) | #{'0' if t.hour<10}#{t.hour}:#{'0' if t.min<10}#{t.min}",bot.user(543373018303299585).avatar_url)
  end
end

def disp_update_list()
  if ![141260274144509952,167657750971547648].include?(event.user.id)
    t=Time.now
    if t.month==10 && t.year==2019 && t.day>23 && t.day<30
      event.respond "Please note that my developer is away for the weekend, and cannot do updates.  I have code that allows my data collector to update me remotely, but that may take longer than usual."
    else
      event.respond "This command is unavailable to you."
    end
    return nil
  end
  str="1.) Edit [the sheet](https://docs.google.com/spreadsheets/d/1WY83FtDC9ydd2ME-TfGgHfg7Pi9KzUnSq2rfDjkJJNM/edit#gid=246276672) as usual."
  str="#{str}\n\n2.) If the edits made were to the \"Skills\", \"Abil./Aura\", or \"CoAb.\" sheets, switch to the \"Askillities\" sheet."
  str="#{str}\n\n3.) Wait for the formulae to finish loading, then grab the BotanBot data column of the sheet you edited.  I generally highlight the lowest entry and CTRL+SHIFT+(up)."
  str="#{str}\n\n4.) Copy the selection from step 3 to a text file, with the following names based on sheet:"
  str="#{str}\n- *Adv.* should be copied to **DLAdventurers.txt**"
  str="#{str}\n- *Drg.* should be copied to **DLDragons.txt**"
  str="#{str}\n- *Prints* should be copied to **DLWyrmprints.txt**"
  str="#{str}\n- *Wep.* should be copied to **DLWeapons.txt**"
  str="#{str}\n- *Enemies* should be copied to **DLEnemies.txt**"
  str="#{str}\n- *Gauntlet* should be copied to **DLGauntlet.txt**"
  str="#{str}\n- *NPCs* should be copied to **DL_NPCs.txt**"
  str="#{str}\n- *Statuses* should be copied to **DLStatuses.txt**"
  str="#{str}\n- ~~*Void* will need to be edited manually by me.~~"
  str="#{str}\n- *Banners* should be copied to **DLBanners.txt**"
  str="#{str}\n- *Facilities* should be copied to **DLFacilities.txt**"
  str="#{str}\n- *Mats* should be copied to **DLMaterials.txt**"
  str="#{str}\n- *Askillities* should be copied to **DLSkills.txt**"
  str="#{str}\n- *Stickers* should be copied to **DLEmotes.txt**"
  str="#{str}\n\n5.) Upload the text file to [the GitHub page here](https://github.com/Rot8erConeX/BotanBot).  You might need to make a GitHub account to do so."
  str="#{str}\n\n6.) Wait probably five minutes for the file to settle on GitHub's servers, then use the command `DL!reload` in either my debug server, or in the bot spam channel of Heretic's Lab."
  str="#{str}\n\n7.) Type the number 3 to select reloading data based on GitHub files."
  str="#{str}\n\n8.) Double-check that the edited data works.  It is important to remember that I will not be there to guide you to wherever any problems might be based on error codes."
  str="#{str}\n\n9.) Add any relevant aliases to the new data."
  create_embed(event,"**How to update Botan's data while Mathoo is unavailable.**",str,0xED619A,nil)
end

def snagstats(event,bot,f=nil,f2=nil)
  nicknames_load()
  data_load()
  metadata_load()
  f='' if f.nil?
  f2='' if f2.nil?
  bot.servers.values(&:members)
  k=bot.servers.values.length
  k=1 if Shardizard==4 # Debug shard shares the five emote servers with the main account
  @server_data[0][Shardizard]=k
  @server_data[1][Shardizard]=bot.users.size
  metadata_save()
  if ['servers','server','members','member','shard','shards','user','users'].include?(f.downcase) && Shardizard>=0
    mx=Shards*1
    mx=f2.to_i if f2.to_i.to_s==f2 && event.user.id==167657750971547648
    str="**I am in #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x })} servers.**"
    for i in 0...mx
      m=i
      m=i+1 if i>3
      m=4 if m>@server_data[0].length-1
      str=extend_message(str,"The #{shard_data(0,true,mx)[i]} Shard is in #{longFormattedNumber(@server_data[0][m])} server#{"s" if @server_data[0][m]!=1}.",event)
    end
    str=extend_message(str,"The #{shard_data(0,false,mx)[4]} Shard is in #{longFormattedNumber(@server_data[0][4])} server#{"s" if @server_data[0][4]!=1}.",event,2) if event.user.id==167657750971547648
    if bot.profile.id==618979409059119113
      str="This cloned version of Botan is in #{longFormattedNumber(@server_data[0][0])} server#{"s" if @server_data[0][0]!=1}, reaching #{longFormattedNumber(@server_data[1][0])} unique members."
    end
    event.respond str
    return nil
  elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(f.downcase)
    adv=$adventurers.map{|q| q}
    str="**There are #{longFormattedNumber(adv.length)} adventurers, including:**"
    unless f2.nil? || f2.length<=0
      k=find_in_adventurers(bot,event,[f2],2)
      adv=k[1]
      str="#{k[0].join("\n")}\n**With these filters, there are #{longFormattedNumber(adv.length)} adventurers, including:**"
    end
    includepuppy=true
    includepuppy=false if adv.find_index{|q| q.name=='Puppy'}.nil?
    adv=adv.reject{|q| q.name=='Puppy'}
    str2=''
    for i in 0...$max_rarity[0]
      m=adv.reject{|q| q.rarity != i+1}
      str2="#{str2}\n#{$rarity_stars[0][i+1]} #{m.length} #{['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'][i]}-star adventurer#{'s' unless m.length==1}" if m.length>0
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q.element !='Flame'}
    str2="<:Element_Flame:532106087952810005> #{m.length} Flame-element adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Water'}
    str2="#{str2}\n<:Element_Water:532106088221376522> #{m.length} Water-element adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Wind'}
    str2="#{str2}\n<:Element_Wind:532106087948746763> #{m.length} Wind-element adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Light'}
    str2="#{str2}\n<:Element_Light:532106088129101834> #{m.length} Light-element adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Shadow'}
    str2="#{str2}\n<:Element_Shadow:532106088154267658> #{m.length} Shadow-element adventurer#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q.weapon !='Sword'}
    str2="<:Weapon_Sword:532106114540634113> #{m.length} Sword-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.weapon !='Blade'}
    str2="#{str2}\n<:Weapon_Blade:532106114628714496> #{m.length} Blade-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.weapon !='Dagger'}
    str2="#{str2}\n<:Weapon_Dagger:532106116025286656> #{m.length} Dagger-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.weapon !='Axe'}
    str2="#{str2}\n<:Weapon_Axe:532106114188443659> #{m.length} Axe-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.weapon !='Bow'}
    str2="#{str2}\n<:Weapon_Bow:532106114909732864> #{m.length} Bow-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.weapon !='Lance'}
    str2="#{str2}\n<:Weapon_Lance:532106114792423448> #{m.length} Lance-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.weapon !='Wand'}
    str2="#{str2}\n<:Weapon_Wand:532106114985099264> #{m.length} Wand-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.weapon !='Staff'}
    str2="#{str2}\n<:Weapon_Staff:532106114733441024> #{m.length} Staff-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.weapon !='Manacaster'}
    if m.length>0
      m2=adv.reject{|q| q.weapon !='Manacaster' || q.weapon2 != 'Rifle'}
      m3=adv.reject{|q| q.weapon !='Manacaster' || q.weapon2 != 'Shotgun'}
      m4=adv.reject{|q| q.weapon !='Manacaster' || q.weapon2 != 'Machine Gun'}
      str2="#{str2}\n<:Weapon_Manacaster:758905122448867338> #{m.length} Manacaster-using adventurer#{'s' unless m.length==1}:   <:MC_Rifle:772800760068046859>#{m2.length} rifle#{'s' unless m2.length==1}, <:MC_Shotgun:772800760055726080>#{m3.length} shotgun#{'s' unless m3.length==1}, <:MC_Machine_Gun:772800760081023017>#{m4.length} machine gun#{'s' unless m4.length==1}"
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q.clzz !='Attack'}
    str2="<:Type_Attack:532107867520630784> #{m.length} Attack-class adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.clzz !='Defense'}
    str2="#{str2}\n<:Type_Defense:532107867264909314> #{m.length} Defense-class adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.clzz !='Support'}
    str2="#{str2}\n<:Type_Support:532107867575156747> #{m.length} Support-class adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.clzz !='Healer'}
    str2="#{str2}\n<:Type_Healing:532107867348533249> #{m.length} Healing-class adventurer#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      str2=''
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('y')}
      str2="#{m.length} story adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && q.availability.length>1}
      str2="#{str2}\n#{m.length} summonable adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('w')}
      str2="#{str2}\n#{m.length} welfare adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('s')}
      str2="#{str2}\n#{m.length} seasonal adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('f')}
      str2="#{str2}\n#{m.length} former-seasonal adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('z')}
      str2="#{str2}\n#{m.length} Zodiac adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('-')}
      str2="#{str2}\n#{m.length} unavailable adventurer#{'s' unless m.length==1}" if m.length>0
      str2="#{str2}\n1 good boi" if includepuppy
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['dragon','dragons','drag','drags','drg','drgs'].include?(f.downcase)
    str='This command is not yet ready'
    adv=$dragons.map{|q| q}
    str="**There are #{adv.length} dragons, including:**"
    unless f2.nil? || f2.length<=0
      k=find_in_dragons(bot,event,[f2],2)
      adv=k[1]
      str="#{k[0].join("\n")}\n**With these filters, there are #{longFormattedNumber(adv.length)} dragons, including:**"
    end
    includepuppy=true
    includepuppy=false if adv.find_index{|q| q.name=='Puppy'}.nil?
    adv=adv.reject{|q| q.name=='Puppy'}
    str2=''
    for i in 0...$max_rarity[1]
      m=adv.reject{|q| q.rarity != i+1}
      str2="#{str2}\n#{$rarity_stars[0][i+1]} #{m.length} #{['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'][i]}-star dragon#{'s' unless m.length==1}" if m.length>0
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q.element !='Flame'}
    str2="<:Element_Flame:532106087952810005> #{m.length} Flame-element dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Water'}
    str2="#{str2}\n<:Element_Water:532106088221376522> #{m.length} Water-element dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Wind'}
    str2="#{str2}\n<:Element_Wind:532106087948746763> #{m.length} Wind-element dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Light'}
    str2="#{str2}\n<:Element_Light:532106088129101834> #{m.length} Light-element dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Shadow'}
    str2="#{str2}\n<:Element_Shadow:532106088154267658> #{m.length} Shadow-element dragon#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    x=['','Juicy Meat/Monday','Kaleidoscope/Tuesday','Floral Circlet/Wednesday','Compelling Book/Thursday','Mana Essence/Friday','']
    for i in 1...6
      m=adv.reject{|q| q.favorite !=i}
      str2="#{str2}\n#{m.length} dragon#{'s' unless m.length==1} that prefer #{x[i].split('/')[0]}s, which are available on #{x[i].split('/')[1]}" if m.length>0
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    m=adv.reject{|q| !q.dmg_turn}
    str2=''
    str2="#{m.length} dragon#{'s' unless m.length==1} that turn towards the source of damage they receive" if m.length>0
    m=adv.reject{|q| q.dmg_turn}
    str2="#{str2}\n#{m.length} dragon#{'s' unless m.length==1} that remain in position when damaged" if m.length>0
    str=extend_message(str,str2,event,2)
    m=adv.reject{|q| !q.longrange}
    str2="#{m.length} long-range dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.longrange}
    str2="#{str2}\n#{m.length} short-range dragon#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      str2=''
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('y')}
      str2="#{m.length} story dragon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && q.availability.length>1}
      str2="#{str2}\n#{m.length} summonable dragon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('w')}
      str2="#{str2}\n#{m.length} welfare dragon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('s')}
      str2="#{str2}\n#{m.length} seasonal dragon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('f')}
      str2="#{str2}\n#{m.length} former-seasonal dragon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.availability.nil? || !q.availability.include?('z')}
      str2="#{str2}\n#{m.length} Zodiac dragon#{'s' unless m.length==1}" if m.length>0
      str2="#{str2}\n1 good boi" if includepuppy
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(f.downcase)
    adv=$wyrmprints.map{|q| q}
    str="**There are #{adv.length} Wyrmprints, including:**"
    unless f2.nil? || f2.length<=0
      k=find_in_wyrmprints(bot,event,[f2],2)
      adv=k[1]
      str="#{k[0].join("\n")}\n**With these filters, there are #{longFormattedNumber(adv.length)} Wyrmprints, including:**"
    end
    str2=''
    for i in 0...$max_rarity[2]
      m=adv.reject{|q| q.rarity != i+1}
      str2="#{str2}\n#{$rarity_stars[0][i+1]} #{m.length} #{['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'][i]}-star wyrmprint#{'s' unless m.length==1}" if m.length>0
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q.affinity !='Crown'}
    str2="<:Affinity_Queen:758912216115314690> #{m.length} print#{'s' unless m.length==1} with Crown's Boon" if m.length>0
    m=adv.reject{|q| q.affinity !='Axe'}
    str2="#{str2}\n<:Affinity_Hatchet:758912216413241354> #{m.length} print#{'s' unless m.length==1} with Axe's Boon" if m.length>0
    m=adv.reject{|q| q.affinity !='Sword'}
    str2="#{str2}\n<:Affinity_Duel:758912216052269076> #{m.length} print#{'s' unless m.length==1} with Sword's Boon" if m.length>0
    m=adv.reject{|q| q.affinity !='Bow'}
    str2="#{str2}\n<:Affinity_Barrage:758912216401051720> #{m.length} print#{'s' unless m.length==1} with Bow's Boon" if m.length>0
    m=adv.reject{|q| q.affinity !='Dragon'}
    str2="#{str2}\n<:Affinity_Draco:758912216048205824> #{m.length} print#{'s' unless m.length==1} with Dragon's Boon" if m.length>0
    m=adv.reject{|q| q.affinity !='Lance'}
    str2="#{str2}\n<:Affinity_Trident:758912216333549619> #{m.length} print#{'s' unless m.length==1} with Lance's Boon" if m.length>0
    m=adv.reject{|q| q.affinity !='Eagle'}
    str2="#{str2}\n<:Affinity_Phoenix:758912216073240677> #{m.length} print#{'s' unless m.length==1} with Eagle's Boon" if m.length>0
    m=adv.reject{|q| q.affinity !='Wolf'}
    str2="#{str2}\n<:Affinity_Wolf:758912216274567189> #{m.length} print#{'s' unless m.length==1} with Wolf's Boon" if m.length>0
    m=adv.reject{|q| q.affinity !='Bull'}
    str2="#{str2}\n<:Affinity_Bull:758912215733895169> #{m.length} print#{'s' unless m.length==1} with Bull's Boon" if m.length>0
    m=adv.reject{|q| q.affinity !='Serpent'}
    str2="#{str2}\n<:Affinity_Serpent:758912216304189471> #{m.length} print#{'s' unless m.length==1} with Serpent's Boon" if m.length>0
    m=adv.reject{|q| q.affinity !='Staff'}
    str2="#{str2}\n<:Affinity_Divinity:758912216031952907> #{m.length} print#{'s' unless m.length==1} with Staff's Boon" if m.length>0
    m=adv.reject{|q| ['Crown','Axe','Sword','Bow','Dragon','Lance','Eagle','Wolf','Bull','Serpent','Staff'].include?(q.affinity )}
    str2="#{str2}\n#{m.length} print#{'s' unless m.length==1} with no affinity" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      str2=''
      m=adv.reject{|q| q.amulet !='Attack'}
      str2="<:Type_Attack:532107867520630784> #{m.length} Attack-amulet print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.amulet !='Defense'}
      str2="#{str2}\n<:Type_Defense:532107867264909314> #{m.length} Defense-amulet print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.amulet !='Support'}
      str2="#{str2}\n<:Type_Support:532107867575156747> #{m.length} Support-amulet print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q.amulet !='Healing'}
      str2="#{str2}\n<:Type_Healing:532107867348533249> #{m.length} Healing-amulet print#{'s' unless m.length==1}" if m.length>0
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
      str2=''
      m=adv.reject{|q| !q.availability.nil? && q.availability.length>0}
      str2="#{m.length} summonable print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && !q.availability.include?('w')}
      str2="#{str2}\n#{m.length} welfare print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && !q.availability.include?('s')}
      str2="#{str2}\n#{m.length} seasonal print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && !q.availability.include?('f')}
      str2="#{str2}\n#{m.length} former-seasonal print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && !q.availability.include?('z')}
      str2="#{str2}\n#{m.length} Zodiac print#{'s' unless m.length==1}" if m.length>0
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(f.downcase)
    adv=$weapons.map{|q| q}
    str="**There are #{adv.length} weapons, including:**"
    unless f2.nil? || f2.length<=0
      k=find_in_weapons(bot,event,[f2],2)
      adv=k[1]
      str="#{k[0].join("\n")}\n**With these filters, there are #{longFormattedNumber(adv.length)} weapons, including:**"
    end
    m=adv.reject{|q| q.type !='Sword'}
    str2="<:Weapon_Sword:532106114540634113> #{m.length} Sword#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.type !='Blade'}
    str2="#{str2}\n<:Weapon_Blade:532106114628714496> #{m.length} Blade#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.type !='Dagger'}
    str2="#{str2}\n<:Weapon_Dagger:532106116025286656> #{m.length} Dagger#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.type !='Axe'}
    str2="#{str2}\n<:Weapon_Axe:532106114188443659> #{m.length} Axe#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.type !='Bow'}
    str2="#{str2}\n<:Weapon_Bow:532106114909732864> #{m.length} Bow#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.type !='Lance'}
    str2="#{str2}\n<:Weapon_Lance:532106114792423448> #{m.length} Lance#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.type !='Wand'}
    str2="#{str2}\n<:Weapon_Wand:532106114985099264> #{m.length} Wand#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.type !='Staff'}
    str2="#{str2}\n<:Weapon_Staff:532106114733441024> #{m.length} #{'Staff' if m.length==1}#{'Staves' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.type !='Manacaster'}
    str2="#{str2}\n<:Weapon_Manacaster:758905122448867338> #{m.length} Manacaster#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    for i in 0...$max_rarity[3]
      m=adv.reject{|q| q.rarity != i+1}
      str2="#{str2}\n#{$rarity_stars[0][i+1]} #{m.length} #{['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'][i]}-star weapon#{'s' unless m.length==1}" if m.length>0
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| !['Flame','Water','Wind','Light','Shadow'].include?(q.element)}
    str2="<:Element_Null:532106087810334741> #{m.length} weapon#{'s' unless m.length==1} without an element" if m.length>0
    m=adv.reject{|q| q.element !='Flame'}
    str2="#{str2}\n<:Element_Flame:532106087952810005> #{m.length} Flame-element weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Water'}
    str2="#{str2}\n<:Element_Water:532106088221376522> #{m.length} Water-element weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Wind'}
    str2="#{str2}\n<:Element_Wind:532106087948746763> #{m.length} Wind-element weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Light'}
    str2="#{str2}\n<:Element_Light:532106088129101834> #{m.length} Light-element weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q.element !='Shadow'}
    str2="#{str2}\n<:Element_Shadow:532106088154267658> #{m.length} Shadow-element weapon#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      str2=''
      m=adv.reject{|q| !q.availability.nil? && q.availability.length>0}
      str2="#{m.length} craftable weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && !q.availability.include?('w')}
      str2="#{str2}\n#{m.length} welfare weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && !q.availability.include?('s')}
      str2="#{str2}\n#{m.length} seasonal weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && !q.availability.include?('f')}
      str2="#{str2}\n#{m.length} former-seasonal weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && !q.availability.include?('z')}
      str2="#{str2}\n#{m.length} Zodiac weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && !q.availability.include?('e')}
      str2="#{str2}\n#{m.length} starter weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| !q.availability.nil? && !q.availability.include?('$')}
      str2="#{str2}\n#{m.length} paid weapon#{'s' unless m.length==1}" if m.length>0
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['alts','alt','alternate','alternates','alternative','alternatives'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',3) rescue nil
    data_load()
    nicknames_load()
    untz=$adventurers.map{|q| q}
    untz2=[]
    for i in 0...untz.length
      m=[]
      m.push('default') if untz[i].name==untz[i].alts[0] || untz[i].alts[0][untz[i].alts[0].length-1,1]=='*'
      m.push('faceted') if untz[i].alts[0][0,1]=='*' && untz[i].alts.length>1
      m.push('sensible') if untz[i].alts[0][0,1]=='*' && untz[i].alts.length<2
      m.push('Gala') if untz[i].name=="Gala #{untz[i].alts[0]}"
      m.push('seasonal') if !untz[i].availability.nil? && untz[i].availability.include?('s')
      m.push('out-of-left-field') if m.length<=0
      n=''
      unless untz[i].name==untz[i].alts[0] || untz[i].alts[0][untz[i].alts[0].length-1,1]=='*'
        k=untz.reject{|q| q.alts[0].gsub('*','')[0]!=untz[i].alts[0].gsub('*','')[0] || q.name==untz[i].name || !(q.name==q.alts[0] || q.alts[0].include?('*'))}
        n="x" if k.length<=0
      end
      untz2.push([untz[i].name,untz[i].alts.map{|q| q.gsub('*','')},m,n,untz[i].gender])
    end
    untz2.uniq!
    all_units=untz2.map{|q| q}
    legal_units=untz2.map{|q| q}
    a2=all_units.reject{|q| q[1][1].nil?}.map{|q| q[1][0]}.uniq
    l2=legal_units.reject{|q| q[1][1].nil?}.map{|q| q[1][0]}.uniq
    str="There are #{untz2.reject{|q| !q[2].include?('default')}.length} adventurers in their default form"
    m=untz2.reject{|q| !q[2].include?('sensible')}.length
    str="#{str}\nThere are #{m} sensible alts of adventurers" unless m<=0
    str="#{str}\nThere are #{untz2.reject{|q| !q[2].include?('Gala')}.length} Gala alts of adventurers"
    str="#{str}\nThere are #{untz2.reject{|q| !q[2].include?('seasonal')}.length} seasonal alts of adventurers"
    str="#{str}\nThere are #{untz2.reject{|q| !q[2].include?('out-of-left-field')}.length} out-of-left-field alts of adventurers"
    k=[]
    for i in 0...all_units.length
      k.push("#{all_units[i][1][0]}") if all_units[i][3].length>0
    end
    k.uniq!
    str2=''
    str2="#{str2}\nThe following adventurers have alts but not default versions in DL: #{list_lift(k.map{|q| "*#{q}*"},"and")}." if k.length>0
    k=legal_units.map{|q| [q[1][0],0]}.uniq
    for i in 0...k.length
      k[i][1]=legal_units.reject{|q| q[1][0]!=k[i][0]}.uniq.length
    end
    k=k.sort{|b,a| supersort(a,b,1).zero? ? supersort(a,b,0) : supersort(a,b,1)}
    k=k.reject{|q| q[1]!=k[0][1]}
    str2="#{str2}\n#{list_lift(k.map{|q| "*#{q[0]}*"},'and')} #{"is" if k.length==1}#{"are" unless k.length==1} the adventurer#{"s" unless k.length==1} with the most alts, with #{k[0][1]} alts (including the default)#{" each" unless k.length==1}."
    k2=k.map{|q| q}
    k=legal_units.map{|q| [q[1],0]}.uniq
    for i in 0...k.length
      k[i][1]=legal_units.reject{|q| q[1]!=k[i][0]}.uniq.length
      if k[i][0].length>1
        k[i][0]="#{k[i][0][0]}(#{k[i][0][1]})"
      else
        k[i][0]=k[i][0][0]
      end
    end
    k=k.sort{|b,a| supersort(a,b,1).zero? ? supersort(a,b,0) : supersort(a,b,1)}
    k=k.reject{|q| q[1]!=k[0][1]}
    str2="#{str2}\n#{list_lift(k.map{|q| "*#{q[0]}*"},'and')} #{"is" if k.length==1}#{"are" unless k.length==1} the adventurer facet#{"s" unless k.length==1} with the most alts, with #{k[0][1]} alts (including the default)#{" each" unless k.length==1}." if k.length>0 && k != k2
    str="#{str}#{str2}"
    untz=$dragons.map{|q| q}
    untz2=[]
    for i in 0...untz.length
      m=[]
      m.push('default') if untz[i].name==untz[i].alts[0] || untz[i].alts[0][untz[i].alts[0].length-1,1]=='*'
      m.push('faceted') if untz[i].alts[0][0,1]=='*' && untz[i].alts.length>1
      m.push('sensible') if untz[i].alts[0][0,1]=='*' && untz[i].alts.length<2
      m.push('Gala') if untz[i].name=="Gala #{untz[i].alts[0]}"
      m.push('seasonal') if !untz[i].availability.nil? && untz[i].availability.include?('s')
      m.push('out-of-left-field') if m.length<=0
      n=''
      unless untz[i].name==untz[i].alts[0] || untz[i].alts[0][untz[i].alts[0].length-1,1]=='*'
        k=untz.reject{|q| q.alts[0].gsub('*','')[0]!=untz[i].alts[0].gsub('*','')[0] || q.name==untz[i].name || !(q.name==q.alts[0] || q.alts[0].include?('*'))}
        n="x" if k.length<=0
      end
      untz2.push([untz[i].name,untz[i].alts.map{|q| q.gsub('*','')},m,n,untz[i].gender])
    end
    untz2.uniq!
    all_units=untz2.map{|q| q}
    legal_units=untz2.map{|q| q}
    a2=all_units.reject{|q| q[1][1].nil?}.map{|q| q[1][0]}.uniq
    l2=legal_units.reject{|q| q[1][1].nil?}.map{|q| q[1][0]}.uniq
    str3="There are #{untz2.reject{|q| !q[2].include?('default')}.length} dragons in their default form, alongside #{l2.length} sets of dragon facets (High Dragons)"
    m=untz2.reject{|q| !q[2].include?('sensible')}.length
    str3="#{str3}\nThere are #{m} sensible alts of dragons" unless m<=0
    str3="#{str3}\nThere are #{untz2.reject{|q| !q[2].include?('seasonal')}.length} seasonal alts of dragons"
    str3="#{str3}\nThere are #{untz2.reject{|q| !q[2].include?('out-of-left-field')}.length} out-of-left-field alts of dragons"
    k=[]
    for i in 0...all_units.length
      k.push("#{all_units[i][1][0]}") if all_units[i][3].length>0
    end
    k.uniq!
    str2=''
    str2="#{str2}\nThe following dragons have alts but not default versions in DL: #{list_lift(k.map{|q| "*#{q}*"},"and")}." if k.length>0
    k=legal_units.map{|q| [q[1][0],0]}.uniq
    for i in 0...k.length
      k[i][1]=legal_units.reject{|q| q[1][0]!=k[i][0]}.uniq.length
    end
    k=k.sort{|b,a| supersort(a,b,1).zero? ? supersort(a,b,0) : supersort(a,b,1)}
    k=k.reject{|q| q[1]!=k[0][1]}
    str2="#{str2}\n#{list_lift(k.map{|q| "*#{q[0]}*"},'and')} #{"is" if k.length==1}#{"are" unless k.length==1} the dragon#{"s" unless k.length==1} with the most alts, with #{k[0][1]} alts (including the default)#{" each" unless k.length==1}."
    k2=k.map{|q| q}
    k=legal_units.map{|q| [q[1],0]}.uniq
    for i in 0...k.length
      k[i][1]=legal_units.reject{|q| q[1]!=k[i][0]}.uniq.length
      if k[i][0].length>1
        k[i][0]="#{k[i][0][0]}(#{k[i][0][1]})"
      else
        k[i][0]=k[i][0][0]
      end
    end
    k=k.sort{|b,a| supersort(a,b,1).zero? ? supersort(a,b,0) : supersort(a,b,1)}
    k=k.reject{|q| q[1]!=k[0][1]}
    str2="#{str2}\n#{list_lift(k.map{|q| "*#{q[0]}*"},'and')} #{"is" if k.length==1}#{"are" unless k.length==1} the dragon facet#{"s" unless k.length==1} with the most alts, with #{k[0][1]} alts (including the default)#{" each" unless k.length==1}." if k.length>0 && k != k2
    str3="#{str3}#{str2}"
    str=extend_message(str,str3,event,2)
    event.respond str
    return nil
  elsif ['alias','aliases','name','names','nickname','nicknames'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',1) rescue nil
    glbl=$aliases.reject{|q| q[0]!='Adventurer' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Adventurer' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    all_units=$adventurers.map{|q| [q.name,0,0,0]}
    for j in 0...all_units.length
      all_units[j][2]+=glbl.reject{|q| q[1]!=all_units[j][0]}.length
      all_units[j][3]+=srv_spec.reject{|q| q[1]!=all_units[j][0]}.length
    end
    k=all_units.reject{|q| q[2]!=all_units.map{|q2| q2[2]}.max}.map{|q| q[0]}
    k=all_units.reject{|q| q[2]!=all_units.map{|q2| q2[2]}.max}.map{|q| q[0]} if k.length>8 && !safe_to_spam?(event)
    str="**There are #{longFormattedNumber(glbl.length)} global adventurer aliases.**\nThe adventurer#{"s" unless k.length==1} with the most global aliases #{"is" if k.length==1}#{"are" unless k.length==1} #{list_lift(k,"and")}, with #{all_units.map{|q2| q2[2]}.max} global aliases#{" each" unless k.length==1}."
    k=all_units.reject{|q| q[2]>0}.map{|q| q[0]}
    k=all_units.reject{|q| q[2]>0}.map{|q| q[0]} if k.length>8 && !safe_to_spam?(event) 
    str="#{str}\nThe following adventurer#{"s" unless k.length==1} have no global aliases: #{list_lift(k,"and")}." if k.length>0
    str2="**There are #{longFormattedNumber(srv_spec.length)} server-specific adventurer aliases.**"
    if event.server.nil? && Shardizard==4
      str2="#{str2}\nDue to being the debug version, I cannot show more information."
    elsif event.server.nil?
      str2="#{str2}\nServers you and I share account for #{$aliases.reject{|q| q[0]!='Adventurer' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those."
    else
      str2="#{str2}\nThis server accounts for #{$aliases.reject{|q| q[0]!='Adventurer' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    k=all_units.reject{|q| q[3]!=all_units.map{|q2| q2[3]}.max}.map{|q| q[0]}
    k=all_units.reject{|q| q[3]!=all_units.map{|q2| q2[3]}.max}.map{|q| q[0]} if k.length>8 && !safe_to_spam?(event)
    str2="#{str2}\nThe adventurer#{"s" unless k.length==1} with the most server-specific aliases #{"is" if k.length==1}#{"are" unless k.length==1} #{list_lift(k,"and")}, with #{all_units.map{|q2| q2[3]}.max} server-specific aliases#{" each" unless k.length==1}." unless all_units.map{|q2| q2[3]}.max<=0
    k=srv_spec.map{|q| q[2].length}.inject(0){|sum,x| sum + x }
    str2="#{str2}\nCounting each alias/server combo as a unique alias, there are #{longFormattedNumber(k)} server-specific adventurer aliases"
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Dragon' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Dragon' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    all_units=$dragons.map{|q| [q.name,0,0,0]}
    for j in 0...all_units.length
      all_units[j][2]+=glbl.reject{|q| q[1]!=all_units[j][0]}.length
      all_units[j][3]+=srv_spec.reject{|q| q[1]!=all_units[j][0]}.length
    end
    k=all_units.reject{|q| q[2]!=all_units.map{|q2| q2[2]}.max}.map{|q| q[0]}
    k=all_units.reject{|q| q[2]!=all_units.map{|q2| q2[2]}.max}.map{|q| q[0]} if k.length>8 && !safe_to_spam?(event)
    str2="**There are #{longFormattedNumber(glbl.length)} global dragon aliases.**\nThe dragon#{"s" unless k.length==1} with the most global aliases #{"is" if k.length==1}#{"are" unless k.length==1} #{list_lift(k,"and")}, with #{all_units.map{|q2| q2[2]}.max} global aliases#{" each" unless k.length==1}."
    k=all_units.reject{|q| q[2]>0}.map{|q| q[0]}
    k=all_units.reject{|q| q[2]>0}.map{|q| q[0]} if k.length>8 && !safe_to_spam?(event) 
    str2="#{str2}\nThe following dragon#{"s" unless k.length==1} have no global aliases: #{list_lift(k,"and")}." if k.length>0
    str=extend_message(str,str2,event,2)
    str2="**There are #{longFormattedNumber(srv_spec.length)} server-specific dragon aliases.**"
    if event.server.nil? && Shardizard==4
      str2="#{str2}\nDue to being the debug version, I cannot show more information."
    elsif event.server.nil?
      str2="#{str2}\nServers you and I share account for #{$aliases.reject{|q| q[0]!='Dragon' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those."
    else
      str2="#{str2}\nThis server accounts for #{$aliases.reject{|q| q[0]!='Dragon' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    k=all_units.reject{|q| q[3]!=all_units.map{|q2| q2[3]}.max}.map{|q| q[0]}
    k=all_units.reject{|q| q[3]!=all_units.map{|q2| q2[3]}.max}.map{|q| q[0]} if k.length>8 && !safe_to_spam?(event)
    str2="#{str2}\nThe dragon#{"s" unless k.length==1} with the most server-specific aliases #{"is" if k.length==1}#{"are" unless k.length==1} #{list_lift(k,"and")}, with #{all_units.map{|q2| q2[3]}.max} server-specific aliases#{" each" unless k.length==1}." unless all_units.map{|q2| q2[3]}.max<=0
    k=srv_spec.map{|q| q[2].length}.inject(0){|sum,x| sum + x }
    str2="#{str2}\nCounting each alias/server combo as a unique alias, there are #{longFormattedNumber(k)} server-specific dragon aliases"
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Wyrmprint' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Wyrmprint' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global Wyrmprint aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific Wyrmprint aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{$aliases.reject{|q| q[0]!='Wyrmprint' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{$aliases.reject{|q| q[0]!='Wyrmprint' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Weapon' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Weapon' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global weapon aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific weapon aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{$aliases.reject{|q| q[0]!='Weapon' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{$aliases.reject{|q| q[0]!='Weapon' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Enemy' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Enemy' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global enemy aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific enemy aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{$aliases.reject{|q| q[0]!='Weapon' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{$aliases.reject{|q| q[0]!='Weapon' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Skill' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Skill' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global skill aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific skill aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{$aliases.reject{|q| q[0]!='Skill' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{$aliases.reject{|q| q[0]!='Skill' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Ability' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Ability' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global ability aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific ability aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{$aliases.reject{|q| q[0]!='Ability' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{$aliases.reject{|q| q[0]!='Ability' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Facility' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Facility' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global facility aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific facility aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{$aliases.reject{|q| q[0]!='Facility' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{$aliases.reject{|q| q[0]!='Facility' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=$aliases.reject{|q| q[0]!='Material' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=$aliases.reject{|q| q[0]!='Material' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global material aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific material aliases.**"
    if event.server.nil? && Shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{$aliases.reject{|q| q[0]!='Material' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{$aliases.reject{|q| q[0]!='Material' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    event.respond str
    return nil
  elsif ['code','lines','line','sloc'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',3) rescue nil
    b=[[],[],[],[],[]]
    File.open("#{$location}devkit/BotanBot.rb").each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[3].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[1].push(l) unless l.length<=0
    end
    File.open("#{$location}devkit/rot8er_functs.rb").each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[4].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[2].push(l) unless l.length<=0
    end
    File.open("#{$location}devkit/BotanClassFunctions.rb").each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[4].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[2].push(l) unless l.length<=0
    end
    event << "**I am #{longFormattedNumber(File.foreach("#{$location}devkit/BotanBot.rb").inject(0) {|c, line| c+1})} lines of code long.**"
    event << "Of those, #{longFormattedNumber(b[1].length)} are SLOC (non-empty)."
    event << "~~When fully collapsed, I appear to be #{longFormattedNumber(b[3].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
    event << ''
    event << "**I rely on multiple libraries that in total are #{longFormattedNumber(File.foreach("#{$location}devkit/rot8er_functs.rb").inject(0) {|c, line| c+1}+File.foreach("#{$location}devkit/BotanClassFunctions.rb").inject(0) {|c, line| c+1})} lines of code long.**"
    event << "Of those, #{longFormattedNumber(b[2].length)} are SLOC (non-empty)."
    event << "~~When fully collapsed, they appear to be #{longFormattedNumber(b[4].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
    event << ''
    event << "**There are #{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command('}.length)} commands, invoked with #{longFormattedNumber(all_commands().length)} different phrases.**"
    event << 'This includes:'
    event << "#{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command(' || q.include?('from: 167657750971547648')}.length-b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'" && q.gsub('  ','')!="str='You are not a mod.'"}.length)} global commands, invoked with #{longFormattedNumber(all_commands(false,0).length)} different phrases."
    event << "#{longFormattedNumber(b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'" && q.gsub('  ','')!="str='You are not a mod.'"}.length)} mod-only commands, invoked with #{longFormattedNumber(all_commands(false,1).length)} different phrases."
    event << "#{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command(' || !q.include?('from: 167657750971547648')}.length)} dev-only commands, invoked with #{longFormattedNumber(all_commands(false,2).length)} different phrases."
    event << ''
    event << "**There are #{longFormattedNumber(b[0].reject{|q| q[0,4]!='def '}.length)} functions the commands use.**"
    if safe_to_spam?(event) || " #{event.message.text.downcase} ".include?(" all ")
      b=b[0].map{|q| q.gsub('  ','')}.reject{|q| q.length<=0}
      for i in 0...b.length
        b[i]=b[i][1,b[i].length-1] if b[i][0,1]==' '
      end
      event << ''
      event << 'There are:'
      event << "#{longFormattedNumber(b.reject{|q| q[0,4]!='for '}.length)} `for` loops."
      event << "#{longFormattedNumber(b.reject{|q| q[0,6]!='while '}.length)} `while` loops."
      event << "#{longFormattedNumber(b.reject{|q| q[0,6]!='class '}.map{|q| q.split(' < ')[0]}.uniq.length)} `class` definitions invoked a total of #{longFormattedNumber(b.reject{|q| q[0,6]!='class '}.length)} times."
      event << "#{longFormattedNumber(b.reject{|q| q[0,3]!='if '}.length)} `if` trees, along with #{longFormattedNumber(b.reject{|q| q[0,6]!='elsif '}.length)} `elsif` branches and #{longFormattedNumber(b.reject{|q| q[0,4]!='else'}.length)} `else` branches."
      event << "#{longFormattedNumber(b.reject{|q| q[0,7]!='unless '}.length)} `unless` trees."
      event << "#{longFormattedNumber(b.reject{|q| count_in(q,'[')<=count_in(q,']')}.length)} multi-line arrays."
      event << "#{longFormattedNumber(b.reject{|q| count_in(q,'{')<=count_in(q,'}')}.length)} multi-line hashes."
      event << "#{longFormattedNumber(b.reject{|q| q[0,3]=='if ' || !remove_format(remove_format(q,"'"),'"').include?(' if ')}.length)} single-line `if` conditionals."
      event << "#{longFormattedNumber(b.reject{|q| q[0,7]=='unless ' || !remove_format(remove_format(q,"'"),'"').include?(' unless ')}.length)} single-line `unless` conditionals."
      event << "#{longFormattedNumber(b.reject{|q| q[0,7]!='return '}.length)} `return` lines."
    end
    return nil
  elsif event.user.id==167657750971547648 && !f.nil? && f.to_i.to_s==f
    srv=(bot.server(f.to_i) rescue nil)
    if srv.nil? || bot.user(543373018303299585).on(srv.id).nil?
      s2="I am not in that server, but it would be assigned to the #{shard_data(0,true)[(f.to_i >> 22) % Shards]} class."
    else
      s2="__**#{srv.name}** (#{srv.id})__\n*Owner:* #{srv.owner.distinct} (#{srv.owner.id})\n*Shard:* #{shard_data(0,true)[(f.to_i >> 22) % Shards]}\n*My nickname:* #{bot.user(543373018303299585).on(srv.id).display_name}"
    end
    event.respond s2
    return nil
  end
  glbl=$aliases.reject{|q| !q[3].nil?}
  srv_spec=$aliases.reject{|q| q[3].nil?}
  b=[]
  File.open("#{$location}devkit/BotanBot.rb").each_line do |line|
    l=line.gsub(' ','').gsub("\n",'')
    b.push(l) unless l.length<=0
  end
  unless Shardizard<0
    event << "**I am in #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x })} *servers*, reaching #{longFormattedNumber(@server_data[1].inject(0){|sum,x| sum + x })} unique members.**"
    event << "This shard is in #{longFormattedNumber(@server_data[0][Shardizard])} server#{"s" unless @server_data[0][Shardizard]==1}, reaching #{longFormattedNumber(bot.users.size)} unique members."
    event << ''
  end
  event << "**There are #{longFormattedNumber($adventurers.length)} *adventurers*.**"
  event << "**There are #{longFormattedNumber($dragons.length)} *dragons*.**"
  event << "**There are #{longFormattedNumber($wyrmprints.length)} *wyrmprints*.**"
  event << "**There are #{longFormattedNumber($weapons.length)} *weapons*.**"
  event << ''
  event << "There are #{longFormattedNumber($skills.length)} skills."
  event << "There are #{longFormattedNumber($abilities.reject{|q| q.type !='Aura'}.length)} dragon auras, split into #{longFormattedNumber($abilities.reject{|q| q.type !='Aura'}.map{|q| q.name.split(') ')[-1]}.uniq.length)} families."
  event << "There are #{longFormattedNumber($abilities.reject{|q| q.type !='Ability'}.length)} abilities, split into #{longFormattedNumber($abilities.reject{|q| q.type !='Ability'}.map{|q| q.name.split(') ')[-1]}.uniq.length)} families."
  event << "There are #{longFormattedNumber($abilities.reject{|q| q.type !='CoAbility'}.length)} co-abilities, split into #{longFormattedNumber($abilities.reject{|q| q.type !='CoAbility'}.map{|q| q.name}.uniq.length)} families."
  event << "There are #{longFormattedNumber($abilities.reject{|q| q.type !='Chain'}.length)} chain co-abilities, split into #{longFormattedNumber($abilities.reject{|q| q.type !='Chain'}.map{|q| q.name}.uniq.length)} families."
  event << ''
  event << "There are #{longFormattedNumber($facilities.map{|q| q.name}.uniq.length)} [unique] facilities with #{$facilities.length} total levels between them."
  event << "There are #{longFormattedNumber($mats.length)} materials."
  event << ''
  grps=get_group_data(true)
  event << "**There are #{longFormattedNumber(glbl.length)} global and #{longFormattedNumber(srv_spec.length)} server-specific *aliases*.**"
  event << "There are "
  event << ''
  event << "**I am #{longFormattedNumber(File.foreach("#{$location}devkit/BotanBot.rb").inject(0) {|c, line| c+1})} lines of *code* long.**"
  event << "Of those, #{longFormattedNumber(b.length)} are SLOC (non-empty)."
  return nil
end
