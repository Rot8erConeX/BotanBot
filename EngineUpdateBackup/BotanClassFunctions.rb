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
  elsif ['team','backpack'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __\*names__","Creates a team out of the adventurers listed in `names`, and then calculates the totals of that team's coabilities and chaincoabilities.",0xCE456B)
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
    elsif ['group','groups'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of groups, as well as the specifics of the semi-dynamic ones",0xCE456B)
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
            "Buff Time \u2192 30%",
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

class DLAdventurer
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
end

class DLDragon
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
    if rar.nil? && @name=='Brunhilda' && args.include?('mym')
      rar='Human'
      disp="#{self.rar_row}"
    end
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
end

class DLWyrmprint
  def isMultiprint?
    return true if @name=='Wily Warriors'
    return true if @name=='Greatwyrm'
    return false
  end
  
  def multiprintText
    return nil unless self.isMultiprint?
    pr=$wyrmprints.reject{|q| !q.name.include?("#{@name} ")}.map{|q| q.name.gsub("#{@name} ",'')}.uniq
    str="This print entry only exists to contain the combined art of the #{@name} series of wyrmprints.  For individual pieces of this series, use their subtitles:\n#{pr.join("\n")}"
    str="\n#{str}" if !@obtain.nil? && @obtain.length>0
    return str
  end
  
  def rar_row(r=0)
    return generate_rarity_row(@rarity,0,@games[0])
  end
  
  def portrait(event,args=nil,forcerar=nil)
    args=event.message.text.downcase.split(' ') if args.nil?
    dispname=@name.gsub(' ','_')
    l=1
    l=2 if has_any?(['mub','unbind','unbound','refined','refine','refinement','2ub','3ub'],args)
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Wyrmprints/#{dispname}_#{l}.png"
    emtz=['','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>']
    emtz=['','<:Limited:574682514585550848>','<:LimitBroken:574682514921095212>'] if @games[0]=='FEH'
    halfemote="\u200B  \u200B  \u200B  \u200B"
    disp="#{halfemote*(4-@rarity) if @rarity<4}#{" \u200B" if @rarity<3}#{self.rar_row}"
    disp="#{disp}\n#{"#{halfemote} \u200B" if @rarity==5}#{emtz[l]*4}"
    return [art,disp]
  end
  
  def voice_na; return nil; end
  def voice_jp; return nil; end
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
      str2="*#{skl1.name}#{skl1.energy_display(false)} [#{skl1.level_text(lvl,-1,true)}]* - #{skl1.sp_display(lvl)} SP"
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
      str2="#{str2}\n\n*#{skl2.name}#{skl2.energy_display(false)} [#{skl2.level_text(lvl,-1,true)}]* - #{skl2.sp_display(lvl)} SP"
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

def disp_enemy_data(bot,event,args=nil,ignoresub=false)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_enemy,args.join(' '),event)
  if k.nil?
    event.respond 'No matches found.'
    return nil
  elsif k.name=='Manticore'
    disp_enemy_data(bot,event,['Manticore(Refrain)'])
    disp_enemy_data(bot,event,['Manticore(BigTop)'])
    return nil
  elsif k.subdata=='Gauntlet'
    disp_gauntlet_data(bot,event,args,k.name)
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  title=k.class_header(bot)
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
  str=''
  if k.stats.nil? || k.stats.length<=0
    str="~~Stats currently unknown~~"
  elsif k.stats.length<2
    str="#{k.stat_emotes[0]}**HP:** #{longFormattedNumber(k.stats[0][1])}" if k.stats[0][1]>-1
    str="#{str}#{"\n" unless str.length<=0}#{k.stat_emotes[1]}**#{k.stat_emotes[2]}:** #{longFormattedNumber(k.stats[0][2])}" if k.stats[0][2]>-1
  else
    for i in 0...k.stats.length
      kx=k.stats[i].map{|q| q}
      if kx[1]>-1 || kx[2]>-1
        str="#{str}\n**#{kx[0].gsub("/empty","\u22C6").gsub("/star","\u2605")}:**"
        str="#{str}  #{k.stat_emotes[0]}*HP:* #{longFormattedNumber(kx[1])}" if kx[1]>-1
        str="#{str}  #{k.stat_emotes[1]}*#{semoji[2]}:* #{longFormattedNumber(kx[2])}" if kx[2]>-1
      end
    end
  end
  if !k.event.nil? && !k.isBaby?
    m=$enemies.reject{|q| q.name==k.name || q.event.nil? || q.event != k.event || q.isBaby?}
    str="#{str}#{"\n" if k.stats.length>1 || m.length>0}\n**Event Name:** #{k.event}"
    str="#{str}\n*Other bosses from this event:* #{m.map{|q| "#{q.emotes(bot)}#{q.name}"}.join(', ')}" if m.length>0 && !ignoresub
  end
  flds=nil
  if s2s
    flds=[]
    flds.push(['Resistances',"#{k.weaknesses.gsub(', ',"\n")}"])
    flds.push(['Afflictions',"#{k.afflictions.gsub(', ',"\n")}"])
  else
    str="#{str}\n\n**Resistances:** #{k.weaknesses}"
    str="#{str}\n\n**Afflictions:** #{k.afflictions}"
  end
  unless k.abilities.nil? || k.abilities.length<=0
    str2=''; str3='__**Abilities**__'
    for i in 0...k.abilities.length
      abl=$abilities.find_index{|q| q.fullName==k.abilities[i]}
      unless abl.nil?
        abl=$abilities[abl]
        str2="#{str2}\n\n**#{abl.fullName}**#{"\n#{abl.description}" if abl.show}"
        str3="#{str3}\n*#{abl.fullName}*"
      end
    end
    unless str2.length<=0
      if s2s
        flds.push(['Abilities',str2,1])
      elsif "#{str}#{str2}".length>1500
        str="#{str}\n\n#{str3}"
      else
        str="#{str}#{str2}"
      end
    end
  end
  ftr=nil
  if !s2s && k.babies.length>0
    if ['Wandering Shroom','Gust Shroom'].include?(k.name)
      ftr='For information about the enemies that spawn during the fight, try adding "Clone Wave 1" or "Clone Wave 2" to your message.'
    elsif k.babies.length>1
      ftr="For information about the enemies that spawn during the fight, they are named #{list_lift(k.babies.map{|q| "\"#{q.name}\""},'and')}."
    else
      ftr="For information about the enemies that spawn during the fight, they are named \"#{k.babies[0].name}\"."
    end
    if ftr.length>100
      str="#{str}\n\n#{ftr}"
      ftr=nil
    end
  end
  hdr="__**#{k.name}**__"
  if k.subdata=='Void' && !k.event.nil? && k.event[0,11]=='Fire Emblem'
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k.element.gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Anima')}"}
    hdr="#{moji[0].mention}<:Current_Tempest_Bonus:498797966740422656> #{hdr}" if moji.length>0
  elsif k.subdata=='Void'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k.element.gsub('None','Null')}"}
    hdr="#{moji[0].mention}<:Element_Void:548467446734913536> #{hdr}" if moji.length>0
  elsif k.subdata=='High Dragon'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k.element.gsub('None','Null')}"}
    hdr="#{moji[0].mention} #{hdr}" if moji.length>0
  elsif k.subdata=='Imperial Order'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k.element.gsub('None','Null')}"}
    hdr="#{moji[0].mention} #{hdr}" if moji.length>0
  end
  create_embed(event,[hdr,title],str,k.disp_color,ftr,k.thumbnail,flds)
  if s2s && k.babies.length>0
    for i in 0...k.babies.length
      disp_enemy_data(bot,event,k.babies[i].name.split(' '),true)
    end
  end
  return nil
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
    k=find_best_match(args.join(' '),bot,event,false,false,2)
  end
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  hdr="__**#{k.name}**__#{k.emotes(bot)}"
  mx=k.portrait(event,args)
  title=mx[1]
  xpic=[nil,mx[0]]
  rar=mx[2]
  ftr=nil
  str=''
  if k.is_a?(DLWyrmprint)
    title=nil if k.is_a?(DLWyrmprint)
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
  fehunits=$feh_units.map{|q| q.clone}
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
        m='Appears in the following wyrmprints'
      elsif appearances.reject{|q| !q.name.include?('*[Sticker]*')}.length<=0
        m='Appears in the following stickers'
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
  flds=nil if flds.length<=0
  create_embed(event,[hdr,title],str,k.disp_color,ftr,xpic,flds)
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
    event << 'Gamepedia Wiki: <https://dragalialost.gamepedia.com/Dragalia_Lost_Wiki>'
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
    str="#{str}\n[Gamepedia Wiki](https://dragalialost.gamepedia.com/Dragalia_Lost_Wiki)"
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
   # adv=find_in_adventurers(bot,event,[f2],2)[1] unless f2.nil? || f2.length<=0
    str="**There are #{adv.length} adventurers, including:**"
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
      str2="#{str2}\n1 good boi"
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['dragon','dragons','drag','drags','drg','drgs'].include?(f.downcase)
    str='This command is not yet ready'
    adv=$dragons.map{|q| q}
   # adv=find_in_dragons(bot,event,[f2],2)[1] unless f2.nil?
    str="**There are #{adv.length} dragons, including:**"
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
      str2="#{str2}\n1 good boi"
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(f.downcase)
    adv=$wyrmprints.map{|q| q}
  #  adv=find_in_wyrmprints(bot,event,[f2],2)[1] unless f2.nil?
    str="**There are #{adv.length} Wyrmprints, including:**"
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
  #  adv=find_in_weapons(bot,event,[f2],2)[1] unless f2.nil?
  #  str="**There are #{adv.length} #{'<:Element_Void:548467446734913536> Void ' if find_in_weapons(bot,event,[f2],2)[0].include?('*Filters*: <:Element_Void:548467446734913536> Void')}weapons, including:**"
    str="**There are #{adv.length} weapons, including:**"
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
    event.channel.send_temporary_message('Calculating data, please wait...',3)
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
    event.channel.send_temporary_message('Calculating data, please wait...',1)
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
  elsif ['groups','group','groupings','grouping'].include?(f.downcase)
    str='This command is not yet ready'
=begin
    event.channel.send_temporary_message('Calculating data, please wait...',3)
    grps=get_group_data(true)
    grps2=get_group_data()
    str="**There are #{grps.length} groups, including the following semi-dynamic ones:**"
    grps=grps.reject{|q| !q[6]}
    grps2=grps2.reject{|q| !q[6]}
    for i in 0...grps2.length
      m=[]
      m.push("#{grps2[i][4].length} weapons") unless grps2[i][4].nil? || grps2[i][4].length<=0
      m.push("#{grps2[i][5].length} wyrmprints") unless grps2[i][5].nil? || grps2[i][5].length<=0
      str=extend_message(str,"*#{grps2[i][0]}*, with #{"#{grps2[i][2].length-grps[i][2].length}#{"(+#{grps[i][2].length})" unless grps[i][2].length<=0} adventurers" unless grps2[i][2].nil?}#{' and ' unless grps2[i][2].nil? || grps2[i][3].nil?}#{"#{grps2[i][3].length-grps[i][3].length}#{"(+#{grps[i][3].length})" unless grps[i][3].length<=0} dragons" unless grps2[i][3].nil?}#{" (as well as #{list_lift(m,'and')})" unless m.length<=0}",event)
    end
    str=extend_message(str,"Parenthetical additions are not dynamic",event) if str.include?('(') || str.include?(')')
=end
    event.respond str
    return nil
  elsif ['code','lines','line','sloc'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',3)
    b=[[],[],[],[],[]]
    File.open("#{$location}devkit/DebugBotX.rb").each_line do |line|
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
    event << "**I am #{longFormattedNumber(File.foreach("#{$location}devkit/DebugBotX.rb").inject(0) {|c, line| c+1})} lines of code long.**"
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
