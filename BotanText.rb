def help_text_disp(event,bot,command=nil,subcommand=nil)
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
  elsif ['stats','stat','smol'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","If `name` is an adventurer or a weapon, shows `name`'s stats at all possible rarities.\nIf `name` is a dragon or wyrmprint, shows default data.",0xCE456B)
  elsif ['adventurer','adv','unit'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats, skills, and abilities.\n\nIn PM, shows stats at all possible rarities, as well as skill descriptions.\nOtherwise, shows stats at default rarity, and skill names only.  Other rarities can be specified to be shown instead.",0xCE456B)
  elsif ['dragon','drg'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats, skills, and abilities.",0xCE456B)
  elsif ['wyrmprint','wyrm','print'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats and abilities.",0xCE456B)
  elsif ['weapon','weap','wep','wpn'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats and skills.",0xCE456B)
  elsif ['lineage','craft','crafting'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the weapons that `name` directly promotes from, as well as the materials required to craft this weapon from it.",0xCE456B)
  elsif command.downcase=='invite'
    create_embed(event,'**invite**','PMs the invoker with a link to invite me to their server.',0xCE456B)
  elsif ['skill','skil'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the skill named `name` does.  Also shows all adventurers and dragons that know the skill, and any weapons that have it imbued.",0xCE456B)
  elsif ['ability','abil'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the ability named `name` does.  Also shows all adventurers and dragons that know the ability, and any wyrmprints that have it imbued.",0xCE456B)
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
    create_embed(event,"**#{command.downcase}** __type__","Shows the next time in-game daily events of the type `type` will happen.\nIf in PM and `type` is unspecified, shows the entire schedule.\n\n__*Accepted Inputs*__\nRuin(s)\nMat(s)\nShop, Store\nBond(s), Dragon(s)",0xCE456B)
  elsif ['art'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __target__","Shows `target`'s art.  Target can be:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Enemies\n- Stickers\n- NPCs",0xCE456B)
    if safe_to_spam?(event)
      lookout=[]
      if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
        lookout=[]
        File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
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
    unless @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
      event << ''
      event << 'This help window is not in an embed so that people who need this command can see it.'
    end
    return nil
  elsif ['share','skillshare','skilshare'].include?(command.downcase)
    create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Finds all adventurers that fit `filters`, removes any that lack shareable skills, and sorts by their shareable skill(s)' share cost and/or SP when shared.\n\nYou can search by:\n- Element\n- Weapon type\n- Class\n- Availability\n\nIf too many adventurers are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.  I will instead show only the top ten results.",0xCE456B)
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
    elsif ['wyrmprint','wyrm','print'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all wyrmprints that fit `filters`.\n\nYou can search by:\n- Rarity\n- Amulet type\n- Availability\n\nIf too many wyrmprints are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all weapons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Crafting tier\n- Element\n- Weapon type\n- Availability\n- (for Void weapons only) Boss that gives needed mats\n\nIf too many weapons are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['mat','mats','material','materials','item','items'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all materials and items that fit `filters`.\n\nYou can search by:\n- Rarity\n- Pouch Rarity\n- Tags\n\nIf too many materials and items are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
      lookout=[]
      if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
        lookout=[]
        File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
          lookout.push(eval line)
        end
      end
      w=lookout.reject{|q| q[2]!='Mat'}.map{|q| q[0]}.sort
      create_embed(event,'Tags','',0x40C0F0,nil,nil,triple_finish(w)) if safe_to_spam?(event)
    elsif ['skill','skills','skls','skl','skil','skils'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all skills that fit `filters`.\n\nYou can search by:\n- Element\n- Tags\n\nIf too many skills are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
      lookout=[]
      if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
        lookout=[]
        File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
          lookout.push(eval line)
        end
      end
    elsif ['abil','abilities','ability','abils','abilitys'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all abilities, dragon auras, co-abilities, and chain co-abilities that fit `filters`.\n\nYou can search by:\n- Ability Class (ability/aura/coability/chain)\n- Element\n- Tags\n\nIf too many abilities are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
      lookout=[]
      if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
        lookout=[]
        File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
          lookout.push(eval line)
        end
      end
    elsif ['enemies','boss','enemy','bosses','enemie','enemys','bosss'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all enemies that fit `filters`.\n\nYou can search by:\n- Element\n- Tribe\n\nIf too many enemies are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    else
      create_embed(event,"**#{command.downcase}** __\*filters__","Displays all adventurers, dragons, wyrmprints, and weapons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Weapon type\n- Class / Amulet type\n- Availability\n- Gender (for adventurers and dragons)\n\nIn addition, adventurers can be sorted by:\n- Race\n\nIn addition, dragons can be sorted by:\n- Dragon Roost Bond Gift preference\n- Whether or not the dragon turns to face damage sources\n- Whether or not the dragon is a ranged attacker\n\nIn addition, weapons can be sorted by:\n- Crafting tier\n\nIf too much data is trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    end
    lookout=[]
    if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
      lookout=[]
      File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
        lookout.push(eval line)
      end
    end
    w=lookout.reject{|q| q[2]!='Askillity'}.map{|q| q[0]}.sort
    create_embed(event,'Tags','',0x40C0F0,nil,nil,triple_finish(w)) if safe_to_spam?(event) && !['mat','mats','material','materials','item','items','enemies','boss','enemy','bosses','enemie','enemys','bosss'].include?(subcommand.downcase)
  elsif ['aliases','checkaliases','seealiases','alias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s aliases.\nIf no name is listed, responds with a list of all aliases and who/what they are for.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Chain CoAbilities\n- Facilities\n- Materials\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
  elsif ['saliases','serveraliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s server-specific aliases.\nIf no name is listed, responds with a list of all server-specific aliases and who/what they are for.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Chain CoAbilities\n- Facilities\n- Materials\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
  elsif ['tools','links','resources','tool','link','resource'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Responds with a list of links useful to players of *Dragalia Lost*.",0xCE456B)
  elsif ['mats','materials','nodes','node','spiral'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Displays all of the mats required for `name`'s mana nodes.",0xCE456B)
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
      create_embed(event,"**#{command.downcase}**","Returns:\n- the number of servers I'm in\n- the numbers of servants in the game\n- the numbers of aliases I keep track of\n- how long of a file I am.\n\nYou can also include the following words to get more specialized data:\nServer(s), Member(s), Shard(s), User(s)\nAdventurer(s), Unit(s)\nDragon(s)\nWyrmprint(s), Print(s)\nWeapon(s)\nAlt(s)\nAlias(es), Name(s), Nickname(s)\nCode, Line(s), SLOC#{"\n\nAs the bot developer, you can also include a server ID number to snag the shard number, owner, and my nickname in the specified server." if event.user.id==167657750971547648}",0xCE456B)
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
    str="#{str}\n`craft` __name__ - for data on a weapon's crafting materials"
    str="#{str}\n`status` __name__ - for data on a status ailment"
    str="#{str}\n\n`skill` __name__ - for data on a particular skill"
    str="#{str}\n`ability` __name__ - for data on a particular ability or co-ability"
    str="#{str}\n`limits` - for ability stacking limits (*also `stack`*)"
    str="#{str}\n\n`facility` __name__ - for data on a particular facility"
    str="#{str}\n`material` __name__ - for data on a particular material (*also `mat`*)"
    str="#{str}\n\n`stats` __target__ - for only an entity's stats"
    str="#{str}\n`alts` __target__ - to show all alts of a particular character"
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
    create_embed([event,x],"__**Bot Developer Commands**__",str,0x008b8b) if (event.server.nil? || event.channel.id==283821884800499714 || @shardizard==4 || command.downcase=='devcommands') && event.user.id==167657750971547648
    event.respond "If the you see the above message as only three lines long, please use the command `DL!embeds` to see my messages as plaintext instead of embeds.\n\nGlobal Command Prefixes: `DL!` `DL?`#{"\nServer Command Prefix: `#{@prefixes[event.server.id]}`" if !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0}\nYou can also use `DL!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name" unless x==1
    event.user.pm("If the you see the above message as only three lines long, please use the command `DL!embeds` to see my messages as plaintext instead of embeds.\n\nGlobal Command Prefixes: `DL!` `DL?`#{"\nServer Command Prefix: `#{@prefixes[event.server.id]}`" if !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0}\nYou can also use `DL!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name") if x==1
    event.respond "A PM has been sent to you.\nIf you would like to show the help list in this channel, please use the command `DL!help here`." if x==1
  end
end

@max_rarity=[5, 5, 5, 6] # adventurer, dragon, print, weapon
@abilimits=["Affliction Guard \u2192 III (5x)",
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
            "Gauge Accelerator \u2192 35%",
            "Healing Doublebuff \u2192 III (3%)",
            "Last Offense \u2192 60%",
            "Paralysis Res \u2192 100%",
            "Player XP \u2192 10%",
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
@punishments=[['Paralysis','ParalyzedPunisher'],
              ['Poison','PoisonedPunisher'],
              ['Blind','BlindedPunisher'],
              ['Stun','StunnedPunisher'],
              ['Broken','BrokenPunisher'],
              ['Burn','BurningPunisher'],
              ['Overdrive','OverdrivePunisher'],
              ['Frostbite','FrostbitePunisher'],
              ['Sleep','SleepingPunisher'],
              ['Bleed','BleedingPunisher'],
              ['ReducedDefense','ReducedDefensePunisher']]

def dragon_data(bot,event,args=nil,juststats=false)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_dragon,args.join(' '),event)
  args2=args.map{|q| q.downcase}
  if (has_any?(args2,['super','gala']) && has_any?(args2,['mym','brunhilda'])) || has_any?(args2,['supermym','superbrunhilda','brunhildasuper','mymsuper','galamym','galabrunhilda','brunhildagala','mymgala','mymhilda'])
    disp_pseudodragon_stats(bot,event,args,juststats,[['Brunhilda','High Brunhilda'],['"Mymhilda"','"Super Mym"'],'Infernal Ray'],['Adventurers','Gala_Mym_5'],'Gala Brunhilda')
    return nil
  elsif (has_any?(args2,['halloween','spooky','spoopy','scary']) && has_any?(args2,['mym','brunhilda'])) || has_any?(args2,['halloweenmym','halloweenbrunhilda','brunhildahalloween','mymhalloween','spookymym','spookybrunhilda','brunhildaspooky','mymspooky','spoopymym','spoopybrunhilda','brunhildaspoopy','mymspoopy','scarymym','scarybrunhilda','brunhildascary','mymscary','mymhilda'])
    disp_pseudodragon_stats(bot,event,args,juststats,[['Brunhilda'],['"Halloween Mymhilda"'],'Muspelheim'],['Adventurers','Mym(Halloween)_5'],'Halloween Brunhilda')
    return nil
  elsif (has_any?(args2,['shiny']) && has_any?(args2,['nyarlathotep'])) || has_any?(args2,['shinynyarlathotep','lathna'])
    disp_pseudodragon_stats(bot,event,args,juststats,[['Nyarlathotep'],['"Shiny Nyarlathotep"'],'All-Encompassing Darkness (Yang)'],['Dragons','Shiny_Nyarlathotep_5'],'Shiny Nyarlathotep')
    return nil
  elsif (has_any?(args2,['mega','rock']) && has_any?(args2,['man'])) || has_any?(args2,['megaman','rockman']) || k[0]=='Rush'
    disp_pseudodragon_stats(bot,event,args,juststats,[['Rush'],['"Rush Coil"'],'Rush Buster'],['Dragons','Rush'],'Rush')
    return nil
  elsif (has_any?(args2,['tiki','chiki']) && has_any?(args2,['young','child','sprog'])) || has_any?(args2,['tikiyoung','tikichild','tikisprog','chikiyoung','chikichild','chikisprog','youngtiki','childtiki','sprogtiki','youngchiki','childchiki','sprogchiki']) || k[0]=='Tiki(Young)'
    disp_pseudodragon_stats(bot,event,args,juststats,[['Tiki(Young)','Tiki(Young)'],['',''],['Breath of Fog','Divine Dragon Blow']],['Dragons','Tiki(Young)'],'Tiki(Young)')
    return nil
  end
  if k.length.zero?
    if args.join('').include?('frostfang')
      disp_skill_data(bot,event,['dragon','frostfang'])
    elsif args.join('').include?('time')
      disp_ability_data(bot,event,['dragon','time'])
      event.respond 'In addition to the ability, an aura exists.  To look that up, try `DL!aura Dragon Time`.'
    elsif args.join('').include?('damage')
      disp_ability_data(bot,event,['dragon','damage'])
    elsif args.join('').include?('delayres')
      disp_ability_data(bot,event,['dragon','delay','res'])
    elsif args.join('').include?('delay')
      disp_ability_data(bot,event,['dragon','delay'])
    elsif args.join('').include?('claw')
      disp_ability_data(bot,event,["dragon's",'claw'])
    elsif args.join('').include?('prep')
      disp_ability_data(bot,event,['shapeshift','prep'])
    else
      event.respond 'No matches found.'
    end
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  feh=false
  feh=true if !k[16].nil? && k[16]=='FEH'
  dispname=k[0].gsub(' ','_')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Dragons/#{dispname}.png?raw=true"
  str=generate_rarity_row(k[1][0,1].to_i,0,k[16],true)
  str='<:Rarity_3:532086056519204864>'*k[1][0,1].to_i if k[0]=='Bronze Fafnir'
  str='<:Rarity_4:532086056301101067>'*k[1][0,1].to_i if k[0]=='Silver Fafnir'
  str='<:Rarity_5:532086056737177600>'*k[1][0,1].to_i if k[0]=='Gold Fafnir'
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2]}"}
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[2].gsub('Shadow','Dark').gsub('Flame','Fire')}"} if feh
  title="#{moji[0].mention unless moji.length<=0}**#{k[2]}**"
  color='Colorless'
  color='Red' if ['Flame','Shadow'].include?(k[2])
  color='Blue' if ['Water','Light'].include?(k[2])
  color='Green' if ['Wind'].include?(k[2])
  moji=bot.server(443172595580534784).emoji.values.reject{|q| q.name != "#{color}_Dragon"}
  title="#{title}\n#{"#{moji[0].mention}Dragon" unless moji.length<0}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**" if feh
  title="#{title}\n<:Bond:613804021119189012>**FGO Collab**" if !k[16].nil? && k[16]=='FGO'
  title="#{title}\n<:Mega_Man:641484836304846857>**Mega Man Collab**" if !k[16].nil? && k[16]=='MM'
  title="#{title}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**" if !k[16].nil? && k[16]=='MH'
  title="#{title}\n**Collab**" if k[1].length>1 && k[1][1,1].downcase=='c' && !(feh || (!k[16].nil? && k[16].length>0 && ['FEH','FGO','MM','MH'].include?(k[16])))
  lookout=get_lookout_tags().reject{|q| q[2]!='Availability' && q[2]!='Availability/Dragon'}
  for i in 0...lookout.length
    if k[1].length>1 && k[1][1,1].downcase==lookout[i][3]
      if !lookout[i][4].nil? && lookout[i][4].include?('<')
        title="#{title}\n#{lookout[i][4]}**#{lookout[i][0]}**"
      else
        title="#{title}\n**#{lookout[i][0]}**"
      end
    end
  end
  title="#{title}\n**Seasonal**" if k[1].length>1 && k[1][1,1].downcase=='s'
  semoji=['<:HP:573344832307593216>','<:Strength:573344931205349376>','<:Defense:573344832282689567>','<:Speed:573366907357495296>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>']
  semoji=['<:HP_S:514712247503945739>','<:StrengthS:514712248372166666>','<:ProtoShield:642287078943752202>','<:SpeedS:514712247625580555>','<:FEHEnergized:587684963000909845>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if feh
  semoji=['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','<:Defense:573344832282689567>','<:SpeedS:514712247625580555>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if !k[16].nil? && k[16]=='MM'
  semoji=['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','<:FGO_Def:653485374605361162>','<:SpeedS:514712247625580555>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if !k[16].nil? && k[16]=='FGO'
  str="#{str}\n\n**Level 1**  #{semoji[0]}#{longFormattedNumber(k[3][0])}  #{semoji[1]}#{longFormattedNumber(k[4][0])}"
  str="#{str}\n**Level #{k[1][0,1].to_i*20}**  #{semoji[0]}#{longFormattedNumber(k[3][1])}  #{semoji[1]}#{longFormattedNumber(k[4][1])}"
  str="#{str}\n**Level #{k[1][0,1].to_i*20+15}**  #{semoji[0]}#{longFormattedNumber(k[3][2])}  #{semoji[1]}#{longFormattedNumber(k[4][2])}" if k[3].length>2 || k[4].length>2
  if s2s || juststats
    str="#{str}\n\n#{semoji[3]}**Speed:**  *Dash:*\u00A0\u00A0#{k[8][0]}  *Turn:*\u00A0\u00A0#{k[8][1]}"
    str="#{str}\n*Automatically turns to damage direction*" if k[10]=='Yes'
    if k[11]=='Yes'
      str="#{str}\n*Long range attacks*"
    else
      str="#{str}\n*Short range attacks*"
    end
  end
  sklz=@askilities.map{|q| q}
  skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[5][0]}
  skl1=sklz[skl1] unless skl1.nil?
  if juststats
  elsif skl1.nil?
    str="#{str}\n\n**Skill#{' 1' if k[5].length>1}:** *#{k[5][0]}* - LOAD ERROR"
  elsif s2s
    eng=''
    eng=", #{semoji[4]}Energizable" if skl1[7]=='Yes'
    eng=", #{semoji[5]}Inspirable" if skl1[10].include?('Damage')
    eng=", #{semoji[6]}Energizable/Inspirable" if skl1[7]=='Yes' && skl1[10].include?('Damage')
    str="#{str}\n\n__**#{skl1[0]}** (#{skl1[8]} sec invul#{eng}#{energy_emoji(skl1[10],true)})__#{" - #{longFormattedNumber(skl1[6][0])} SP" if skl1[6].max===skl1[6].min && skl1[6][0]>0}"
    if (skl1[9].nil? || skl1[9].length<=0) && skl1[6].max != skl1[6].min
      str="#{str}\n*Lv.1 (#{skl1[6][0]} SP):* #{skl1[3].gsub(';; ',"\n")}\n*Lv.2 (#{skl1[6][1]} SP):* #{skl1[4].gsub(';; ',"\n")}"
      str="#{str}\n*Lv.3 (#{skl1[6][2]} SP):* #{skl1[5].gsub(';; ',"\n")}" if !skl1[5].nil? && skl1[5].length>0
    elsif skl1[9].nil? || skl1[9].length<=0
      str="#{str}\n*Lv.1:* #{skl1[3].gsub(';; ',"\n")}\n*Lv.2:* #{skl1[4].gsub(';; ',"\n")}"
      str="#{str}\n*Lv.3:* #{skl1[5].gsub(';; ',"\n")}" if !skl1[5].nil? && skl1[5].length>0
    elsif skl1[6].max != skl1[6].min
      str="#{str}\n*Effect:* #{skl1[9].gsub(';; ',"\n")}\n*Lv.1 (#{skl1[6][0]} SP) \u2192 Lv.2 (#{skl1[6][1]} SP)*"
      str="#{str} \u2192 *Lv.3 (#{skl1[6][2]} SP)*" if !skl1[5].nil? && skl1[5].length>0
    else
      str="#{str}\n#{skl1[9].gsub(';; ',"\n")}"
    end
  else
    eng=''
    eng=semoji[4] if skl1[7]=='Yes'
    eng=semoji[5] if !skl1[10].nil? && skl1[10].include?('Damage')
    eng=semoji[6] if skl1[7]=='Yes' && !skl1[10].nil? && skl1[10].include?('Damage')
    str="#{str}\n\n**Skill#{' 1' if k[5].length>1}:** *#{k[5][0]}#{eng}#{energy_emoji(skl1[10])}#{" - #{longFormattedNumber(skl1[6][0])} SP" if skl1[6].max===skl1[6].min && skl1[6][0]>0}*;;;;;"
    strx=skl1[4].gsub(';; ',"\n")
  end
  if k[5].length>1
    skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[5][1]}
    skl1=sklz[skl1] unless skl1.nil?
    if juststats
    elsif skl1.nil?
      str="#{str}\n\n**Skill 2:** *#{k[5][1]}* - LOAD ERROR"
    elsif s2s
      eng=''
      eng=", #{semoji[4]}Energizable" if skl1[7]=='Yes'
      eng=", #{semoji[5]}Inspirable" if skl1[10].include?('Damage')
      eng=", #{semoji[6]}Energizable/Inspirable" if skl1[7]=='Yes' && skl1[10].include?('Damage')
      str="#{str}\n\n__**#{skl1[0]}** (#{skl1[8]} sec invul#{eng}#{energy_emoji(skl1[10],true)})__#{" - #{longFormattedNumber(skl1[6][0])} SP" if skl1[6].max===skl1[6].min && skl1[6][0]>0}"
      if (skl1[9].nil? || skl1[9].length<=0) && skl1[6].max != skl1[6].min
        str="#{str}\n*Lv.1 (#{skl1[6][0]} SP):* #{skl1[3].gsub(';; ',"\n")}\n*Lv.2 (#{skl1[6][1]} SP):* #{skl1[4].gsub(';; ',"\n")}"
        str="#{str}\n*Lv.3 (#{skl1[6][2]} SP):* #{skl1[5].gsub(';; ',"\n")}" if !skl1[5].nil? && skl1[5].length>0
      elsif skl1[9].nil? || skl1[9].length<=0
        str="#{str}\n*Lv.1:* #{skl1[3].gsub(';; ',"\n")}\n*Lv.2:* #{skl1[4].gsub(';; ',"\n")}"
        str="#{str}\n*Lv.3:* #{skl1[5].gsub(';; ',"\n")}" if !skl1[5].nil? && skl1[5].length>0
      elsif skl1[6].max != skl1[6].min
        str="#{str}\n*Effect:* #{skl1[9].gsub(';; ',"\n")}\n*Lv.1 (#{skl1[6][0]} SP) \u2192 Lv.2 (#{skl1[6][1]} SP)*"
        str="#{str} \u2192 *Lv.3 (#{skl1[6][2]} SP)*" if !skl1[5].nil? && skl1[5].length>0
      else
        str="#{str}\n#{skl1[9].gsub(';; ',"\n")}"
      end
    else
      eng=''
      eng=semoji[4] if skl1[7]=='Yes'
      eng=semoji[5] if !skl1[10].nil? && skl1[10].include?('Damage')
      eng=semoji[6] if skl1[7]=='Yes' && !skl1[10].nil? && skl1[10].include?('Damage')
      str="#{str}\n\n**Skill 2:** *#{k[5][1]}#{eng}#{energy_emoji(skl1[10])}#{" - #{longFormattedNumber(skl1[6][0])} SP" if skl1[6].max===skl1[6].min && skl1[6][0]>0}*;;;;;"
      strx=skl1[4].gsub(';; ',"\n")
    end
  end
  bemoji=['<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>']
  bemoji=['<:Limited:574682514585550848>','<:LimitBroken:574682514921095212>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>'] if !k[16].nil? && k[16]=='FGO'
  bemoji=['<:Aether_Stone:510776805746278421>','<:Refining_Stone:453618312165720086>','<:Really_Sacred_Coin:571011997609754624>','<:Resource_Structure:510774545154572298>'] if feh
  # Mana Spiral Pink = 0xE9438F
  str="#{str}\n\n**Aura:**\n#{bemoji[0]*4}#{k[6].map{|q| q[0]}.reject{|q| q.nil? || q.length<=0}.join(', ')}\n#{bemoji[1]*4}#{k[6].map{|q| q[1]}.reject{|q| q.nil? || q.length<=0}.join(', ')}#{"\n#{bemoji[1]*5}#{k[6].map{|q| q[-1]}.join(', ')}" if k[6].map{|q| q.length}.max>2}" unless juststats
  str="#{str}\n\n**Sells for:** #{longFormattedNumber(k[7][0])}#{bemoji[2]} #{longFormattedNumber(k[7][1])}#{bemoji[3]}" unless juststats
  str="#{str}#{"\n" if juststats}\n**Bond gift preference:** #{['Golden Chalice (Sunday)','Juicy Meat (Monday)','Kaleidoscope (Tuesday)','Floral Circlet (Wednesday)','Compelling Book (Thursday)','Mana Essence (Friday)','Golden Chalice (Saturday)'][k[9]]}"
  unless s2s
    if str.gsub(';;;;;',"\n#{strx}").length>=1900
      str=str.gsub(';;;;;',"\n~~The description makes this data too long.  Please try again in PM.~~")
    else
      str=str.gsub(';;;;;',"\n#{strx}")
    end
  end
  ftr=nil
  ftr=k[20] unless k[20].nil? || k[20].length<=0
  if str.length>1900 && safe_to_spam?(event)
    str=str.split("\n\n__**")
    str[-1]="__**#{str[-1]}".split("\n\n**Aura")
    str[0]="#{str[0]}\n\n**Aura#{str[-1][1]}"
    if str.length>2 && "__**#{str[1]}\n\n#{str[2][0]}".length<=1900
      str[2][0]="__**#{str[1]}\n\n#{str[2][0]}"
      str[1]=nil
      str.compact!
    end
    create_embed(event,["__**#{k[0]}**__",title],str[0],element_color(k[2]),nil,xpic)
    create_embed(event,'',"__**#{str[1]}",element_color(k[2])) if str.length>2
    create_embed(event,'',str[-1][0],element_color(k[2]),ftr)
  else
    create_embed(event,["__**#{k[0]}**__",title],str,element_color(k[2]),ftr,xpic)
  end
end

def disp_pseudodragon_stats(bot,event,args=nil,juststats=false,k2=[[],[],[]],pic=[],pseudonym='Brunhilda')
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=k2[0].map{|q| find_data_ex(:find_dragon,q,event)}
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  feh=false
  feh=true if !k[0][16].nil? && k[0][16]=='FEH'
  xpic=pic.join('/')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/#{xpic}.png?raw=true"
  str=generate_rarity_row(5,0,k[0][16],true)
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[0][2]}"}
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[0][2].gsub('Shadow','Dark').gsub('Flame','Fire')}"} if feh
  title="#{moji[0].mention unless moji.length<=0}**#{k[0][2]}**"
  color='Colorless'
  color='Red' if ['Flame','Shadow'].include?(k[0][2])
  color='Blue' if ['Water','Light'].include?(k[0][2])
  color='Green' if ['Wind'].include?(k[0][2])
  moji=bot.server(443172595580534784).emoji.values.reject{|q| q.name != "#{color}_Dragon"}
  title="#{title}\n#{moji[0].mention unless moji.length<=0}~~Pseudodragon~~ **Manakete**\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**" if feh
  title="#{title}\n<:Bond:613804021119189012>**FGO Collab**" if !k[0][16].nil? && k[0][16]=='FGO'
  title="#{title}\n<:Mega_Man:641484836304846857>**Mega Man Collab**" if !k[0][16].nil? && k[0][16]=='MM'
  title="#{title}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**" if !k[0][16].nil? && k[0][16]=='MH'
  title="#{title}\n**Collab**" if k[0][1].length>1 && k[0][1][1,1].downcase=='c' && !(feh || (!k[0][16].nil? && k[0][16].length>0 && ['FEH','FGO','MM','MH'].include?(k[0][16])))
  title="#{title}\n**Pseudodragon**" unless feh
  semoji=['<:HP:573344832307593216>','<:Strength:573344931205349376>','<:Defense:573344832282689567>','<:Speed:573366907357495296>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>']
  semoji=['<:HP_S:514712247503945739>','<:StrengthS:514712248372166666>','<:ProtoShield:642287078943752202>','<:SpeedS:514712247625580555>','<:FEHEnergized:587684963000909845>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if feh
  semoji=['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','<:Defense:573344832282689567>','<:SpeedS:514712247625580555>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if !k[0][16].nil? && k[0][16]=='MM'
  semoji=['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','<:FGO_Def:653485374605361162>','<:SpeedS:514712247625580555>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if !k[0][16].nil? && k[0][16]=='FGO'
  sklz=@askilities.map{|q| q}
  unless k.map{|q| q[8]}.uniq.length<2 && k.map{|q| q[10]}.uniq.length<2 && k.map{|q| q[11]}.uniq.length<2 && (k2[2].is_a?(String) || k2[2].length==1)
    for i in 0...k.length
      str="#{str}\n#{"\n__**#{k2[1][i]}**__" unless k2[1][i].length<=0}"
      if s2s || juststats
        str="#{str}\n#{semoji[3]}**Speed:**  *Dash:*\u00A0\u00A0#{k[i][8][0]}  *Turn:*\u00A0\u00A0#{k[i][8][1]}" unless k.map{|q| q[8]}.uniq.length<2
        str="#{str}\n*Automatically turns to damage direction*" if k[i][10]=='Yes' && k.map{|q| q[10]}.uniq.length>1
        if k.map{|q| q[11]}.uniq.length<2
        elsif k[i][11]=='Yes'
          str="#{str}\n*Long range attacks*"
        else
          str="#{str}\n*Short range attacks*"
        end
      end
      if k2[2].is_a?(Array) && k2[2].length>[i,1].max && !juststats
        skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==k2[2][i]}
        if skl1.nil?
          str="#{str}\n**Skill#{" #{i+1}" if k.uniq.length<2}:** *#{k2[2][i]}* - LOAD ERROR"
        else
          skl1=sklz[skl1]
          eng=''
          eng=", #{semoji[4]}Energizable" if skl1[7]=='Yes'
          eng=", #{semoji[5]}Inspirable" if !skl1[10].nil? && skl1[10].include?('Damage')
          eng=", #{semoji[6]}Energizable/Inspirable" if skl1[7]=='Yes' && !skl1[10].nil? && skl1[10].include?('Damage')
          str="#{str}\n**Skill#{" #{i+1}" if k.uniq.length<2}:** *#{skl1[0]}#{eng}#{energy_emoji(skl1[10])}*#{" - #{longFormattedNumber(skl1[6][0])} SP" if skl1[6].max===skl1[6].min && skl1[6][0]>0}\n#{skl1[4].gsub(';; ',"\n")}"
        end
      end
    end
  end
  if k.length==1
  elsif k.map{|q| q[8]}.uniq.length<2 || k.map{|q| q[10]}.uniq.length<2 || k.map{|q| q[11]}.uniq.length<2 || (k2[2].is_a?(Array) && k2[2].length>1)
    str2=''
    if s2s || juststats
      str2="#{semoji[3]}**Speed:**  *Dash:*\u00A0\u00A0#{k[0][8][0]}  *Turn:*\u00A0\u00A0#{k[0][8][1]}" if k.map{|q| q[8]}.uniq.length<2
      str2="#{str2}\n*Automatically turns to damage direction*" if k[0][10]=='Yes' && k.map{|q| q[10]}.uniq.length<2
      if k.map{|q| q[11]}.uniq.length>1
      elsif k[0][11]=='Yes'
        str2="#{str2}\n*Long range attacks*"
      else
        str2="#{str2}\n*Short range attacks*"
      end
    end
    if k.uniq.length>1
      str="#{str}\n\n__**Both**__\n#{str2}"
    else
      str="#{generate_rarity_row(5,0,k[0][16],true)}\n\n#{str2}\n\n#{str.gsub("#{generate_rarity_row(5,0,k[0][16],true)}\n\n",'')}"
    end
  end
  if (k2[2].is_a?(String) || k2[2].length==1) && !juststats
    k2[2]=k2[2][0] if k2[2].is_a?(Array)
    skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==k2[2]}
    skl1=sklz[skl1] unless skl1.nil?
    if skl1.nil?
      str="#{str}\n\n**Skill:** *#{k2[2][i]}* - LOAD ERROR"
    elsif s2s
      eng=''
      eng=", #{semoji[4]}Energizable" if skl1[7]=='Yes'
      eng=", #{semoji[5]}Inspirable" if !skl1[10].nil? && skl1[10].include?('Damage')
      eng=", #{semoji[6]}Energizable/Inspirable" if skl1[7]=='Yes' && !skl1[10].nil? && skl1[10].include?('Damage')
      str="#{str}\n\n__**#{skl1[0]}** (#{skl1[8]} sec invul#{eng}#{energy_emoji(skl1[10],true)})__#{" - #{longFormattedNumber(skl1[6][0])} SP" if skl1[6].max===skl1[6].min && skl1[6][0]>0}"
      if skl1[9].nil? || skl1[9].length<=0
        str="#{str}\n*Lv.1:* #{skl1[3].gsub(';; ',"\n")}\n*Lv.2:* #{skl1[4].gsub(';; ',"\n")}"
      else
        str="#{str}\n*Effect:* #{skl1[9].gsub(';; ',"\n")}"
      end
    else
      str="#{str}\n\n**Skill:** *#{skl1[0]}#{semoji[4] if skl1[7]=='Yes'}#{energy_emoji(skl1[10])}*;;;;;"
      strx=skl1[4].gsub(';; ',"\n")
    end
  end
  bemoji=['<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>']
  bemoji=['<:Limited:574682514585550848>','<:LimitBroken:574682514921095212>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>'] if !k[0][16].nil? && k[0][16]=='FGO'
  bemoji=['<:Aether_Stone:510776805746278421>','<:Refining_Stone:453618312165720086>','<:Really_Sacred_Coin:571011997609754624>','<:Resource_Structure:510774545154572298>'] if feh
  str="#{str}\n\n**Bond gift preference:** #{['Golden Chalice (Sunday)','Juicy Meat (Monday)','Kaleidoscope (Tuesday)','Floral Circlet (Wednesday)','Compelling Book (Thursday)','Mana Essence (Friday)','Golden Chalice (Saturday)'][k[0][9]]}"
  unless s2s
    if str.gsub(';;;;;',"\n#{strx}").length>=1900
      str=str.gsub(';;;;;',"\n~~The description makes this data too long.  Please try again in PM.~~")
    else
      str=str.gsub(';;;;;',"\n#{strx}")
    end
  end
  if str.length>1900 && safe_to_spam?(event)
    str=str.split("\n\n__**")
    str[1]="__**#{str[1]}".split("\n\n**Sells")
    str[0]="#{str[0]}\n\n**Sells#{str[1][1]}"
    create_embed(event,["__**#{pseudonym}**__",title],str[0],element_color(k[0][2]),nil,xpic)
    create_embed(event,'',str[1][0],element_color(k[0][2]),"Any data not displayed is taken instead from the user's normal dragon equip.")
  else
    create_embed(event,["__**#{pseudonym}**__",title],str,element_color(k[0][2]),"Any data not displayed is taken instead from the user's normal dragon equip.",xpic)
  end
end

def enemy_data(bot,event,args=nil,ignoresub=false)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_enemy,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  elsif k[0]=='Manticore'
    disp_enemy_data(bot,event,['Manticore(Refrain)'])
    disp_enemy_data(bot,event,['Manticore(BigTop)'])
    return nil
  elsif k[2][2]=='Gauntlet'
    disp_gauntlet_data(bot,event,args,k[0])
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  sklz=@askilities.map{|q| q}
  title=''
  str=''
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0].gsub('None','Null')}"}
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[2][0].gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Null')}"} if k[2].length>3 && k[2][3][0,11]=='Fire Emblem'
  title="#{title}\n#{moji[0].mention unless moji.length<=0} **Element:** #{k[2][0]}" unless ['High Dragon','Void','Imperial Order'].include?(k[2][2])
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{k[2][1]}"}
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Icon_Move_Infantry"} if k[2].length>3 && k[2][3][0,11]=='Fire Emblem'
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Icon_Move_Armor"} if k[2].length>3 && k[2][3][0,11]=='Fire Emblem' && !k[0].include?('(Enemy)')
  title="#{title}\n#{moji[0].mention unless moji.length<=0} **Tribe:** #{k[2][1]}"
  k[1][1]=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1] if k[1][1].nil? || k[1][1].length<=0
  if k[1][0].length<2 && k[1][1].length<2
    str="#{str}\n<:HP:573344832307593216>**Maximum HP:** #{longFormattedNumber(k[1][0][0])}"
    str="#{str}\n<:Strength:573344931205349376>**Strength:** #{longFormattedNumber(k[1][1][0])}"
  elsif k[0]=='Cube'
    str="#{str}\n"
    str="#{str}\n*Normal:*" if (k[1][0].length>0 && k[1][0][0]>-1) || (k[1][1].length>0 && k[1][1][0]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][0])}" if k[1][0].length>0 && k[1][0][0]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][0])}" if k[1][1].length>0 && k[1][1][0]>-1
    str="#{str}  **Binary Subtractor**"
    str="#{str}\n*Hard:*" if (k[1][0].length>1 && k[1][0][1]>-1) || (k[1][1].length>1 && k[1][1][1]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][1])}" if k[1][0].length>1 && k[1][0][1]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][1])}" if k[1][1].length>1 && k[1][1][1]>-1
    str="#{str}  **Septenary Increaser**"
  elsif k[2].length>3 && k[2][3][0,11]=='Fire Emblem'
    str="#{str}\n"
    str="#{str}\n*Prologue:*" if (k[1][0].length>0 && k[1][0][0]>-1) || (k[1][1].length>0 && k[1][1][0]>-1)
    str="#{str}  <:HP_S:514712247503945739>HP: #{longFormattedNumber(k[1][0][0])}" if k[1][0].length>0 && k[1][0][0]>-1
    str="#{str}  <:StrengthS:514712248372166666>Str: #{longFormattedNumber(k[1][1][0])}" if k[1][1].length>0 && k[1][1][0]>-1
    str="#{str}\n*Normal:*" if (k[1][0].length>1 && k[1][0][1]>-1) || (k[1][1].length>1 && k[1][1][1]>-1)
    str="#{str}  <:HP_S:514712247503945739>HP: #{longFormattedNumber(k[1][0][1])}" if k[1][0].length>1 && k[1][0][1]>-1
    str="#{str}  <:StrengthS:514712248372166666>Str: #{longFormattedNumber(k[1][1][1])}" if k[1][1].length>1 && k[1][1][1]>-1
    str="#{str}\n*Hard:*" if (k[1][0].length>2 && k[1][0][2]>-1) || (k[1][1].length>2 && k[1][1][2]>-1)
    str="#{str}  <:HP_S:514712247503945739>HP: #{longFormattedNumber(k[1][0][2])}" if k[1][0].length>2 && k[1][0][2]>-1
    str="#{str}  <:StrengthS:514712248372166666>Str: #{longFormattedNumber(k[1][1][2])}" if k[1][1].length>2 && k[1][1][2]>-1
    str="#{str}\n*Lunatic:*" if (k[1][0].length>3 && k[1][0][3]>-1) || (k[1][1].length>3 && k[1][1][3]>-1)
    str="#{str}  <:HP_S:514712247503945739>HP: #{longFormattedNumber(k[1][0][3])}" if k[1][0].length>3 && k[1][0][3]>-1
    str="#{str}  <:StrengthS:514712248372166666>Str: #{longFormattedNumber(k[1][1][3])}" if k[1][1].length>3 && k[1][1][3]>-1
    str="#{str}\n*Maddening:*" if (k[1][0].length>4 && k[1][0][4]>-1) || (k[1][1].length>4 && k[1][1][4]>-1)
    str="#{str}  <:HP_S:514712247503945739>HP: #{longFormattedNumber(k[1][0][4])}" if k[1][0].length>4 && k[1][0][4]>-1
    str="#{str}  <:StrengthS:514712248372166666>Str: #{longFormattedNumber(k[1][1][4])}" if k[1][1].length>4 && k[1][1][4]>-1
    str="#{str}\n*Infernal:*" if (k[1][0].length>5 && k[1][0][5]>-1) || (k[1][1].length>5 && k[1][1][5]>-1)
    str="#{str}  <:HP_S:514712247503945739>HP: #{longFormattedNumber(k[1][0][5])}" if k[1][0].length>5 && k[1][0][5]>-1
    str="#{str}  <:StrengthS:514712248372166666>Str: #{longFormattedNumber(k[1][1][5])}" if k[1][1].length>5 && k[1][1][5]>-1
    str="#{str}\n*Abyssal:*" if (k[1][0].length>6 && k[1][0][6]>-1) || (k[1][1].length>6 && k[1][1][6]>-1)
    str="#{str}  <:HP_S:514712247503945739>HP: #{longFormattedNumber(k[1][0][6])}" if k[1][0].length>6 && k[1][0][6]>-1
    str="#{str}  <:StrengthS:514712248372166666>Str: #{longFormattedNumber(k[1][1][6])}" if k[1][1].length>6 && k[1][1][6]>-1
    str="#{str}\n*Abyssal+ (Solo):*" if (k[1][0].length>7 && k[1][0][7]>-1) || (k[1][1].length>7 && k[1][1][7]>-1)
    str="#{str}  <:HP_S:514712247503945739>HP: #{longFormattedNumber(k[1][0][7])}" if k[1][0].length>7 && k[1][0][7]>-1
    str="#{str}  <:StrengthS:514712248372166666>Str: #{longFormattedNumber(k[1][1][7])}" if k[1][1].length>7 && k[1][1][7]>-1
    str="#{str}\n*Abyssal+ (Raid):*" if (k[1][0].length>8 && k[1][0][8]>-1) || (k[1][1].length>8 && k[1][1][8]>-1)
    str="#{str}  <:HP_S:514712247503945739>HP: #{longFormattedNumber(k[1][0][8])}" if k[1][0].length>8 && k[1][0][8]>-1
    str="#{str}  <:StrengthS:514712248372166666>Str: #{longFormattedNumber(k[1][1][8])}" if k[1][1].length>8 && k[1][1][8]>-1
    str="#{str}\n*Abyssal+ (Raid+):*" if (k[1][0].length>9 && k[1][0][9]>-1) || (k[1][1].length>9 && k[1][1][9]>-1)
    str="#{str}  <:HP_S:514712247503945739>HP: #{longFormattedNumber(k[1][0][9])}" if k[1][0].length>9 && k[1][0][9]>-1
    str="#{str}  <:StrengthS:514712248372166666>Str: #{longFormattedNumber(k[1][1][9])}" if k[1][1].length>9 && k[1][1][9]>-1
  elsif k[0]=='Fatalis'
    str="#{str}\n"
    str="#{str}\n*G\u22C6:*" if (k[1][0].length>0 && k[1][0][0]>-1) || (k[1][1].length>0 && k[1][1][0]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][0])}" if k[1][0].length>0 && k[1][0][0]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][0])}" if k[1][1].length>0 && k[1][1][0]>-1
    str="#{str}\n*G\u2605:*" if (k[1][0].length>1 && k[1][0][1]>-1) || (k[1][1].length>1 && k[1][1][1]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][1])}" if k[1][0].length>1 && k[1][0][1]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][1])}" if k[1][1].length>1 && k[1][1][1]>-1
    str="#{str}\n*G\u2605\u2605:*" if (k[1][0].length>2 && k[1][0][2]>-1) || (k[1][1].length>2 && k[1][1][2]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][2])}" if k[1][0].length>2 && k[1][0][2]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][2])}" if k[1][1].length>2 && k[1][1][2]>-1
    str="#{str}\n*G\u2605\u2605\u2605:*" if (k[1][0].length>3 && k[1][0][3]>-1) || (k[1][1].length>3 && k[1][1][3]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][3])}" if k[1][0].length>3 && k[1][0][3]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][3])}" if k[1][1].length>3 && k[1][1][3]>-1
    str="#{str}\n*G\u2605\u2605\u2605\u22C6:*" if (k[1][0].length>4 && k[1][0][4]>-1) || (k[1][1].length>4 && k[1][1][4]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][4])}" if k[1][0].length>4 && k[1][0][4]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][4])}" if k[1][1].length>4 && k[1][1][4]>-1
    str="#{str}\n*G\u2605\u2605\u2605\u2605 (Solo):*" if (k[1][0].length>5 && k[1][0][5]>-1) || (k[1][1].length>5 && k[1][1][5]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][5])}" if k[1][0].length>5 && k[1][0][5]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][5])}" if k[1][1].length>5 && k[1][1][5]>-1
    str="#{str}\n*G\u2605\u2605\u2605\u2605 (Raid):*" if (k[1][0].length>6 && k[1][0][6]>-1) || (k[1][1].length>6 && k[1][1][6]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][6])}" if k[1][0].length>6 && k[1][0][6]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][6])}" if k[1][1].length>6 && k[1][1][6]>-1
    str="#{str}\n*Special:*" if (k[1][0].length>7 && k[1][0][7]>-1) || (k[1][1].length>7 && k[1][1][7]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][7])}" if k[1][0].length>7 && k[1][0][7]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][7])}" if k[1][1].length>7 && k[1][1][7]>-1
    str="#{str}\n*Special+:*" if (k[1][0].length>8 && k[1][0][8]>-1) || (k[1][1].length>8 && k[1][1][8]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][8])}" if k[1][0].length>8 && k[1][0][8]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][8])}" if k[1][1].length>8 && k[1][1][8]>-1
    str="#{str}\n*Special++:*" if (k[1][0].length>9 && k[1][0][9]>-1) || (k[1][1].length>9 && k[1][1][9]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][9])}" if k[1][0].length>9 && k[1][0][9]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][9])}" if k[1][1].length>9 && k[1][1][9]>-1
  elsif k[0].include?('Rathalos')
    str="#{str}\n"
    str="#{str}\n*Low Rank:*" if (k[1][0].length>0 && k[1][0][0]>-1) || (k[1][1].length>0 && k[1][1][0]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][0])}" if k[1][0].length>0 && k[1][0][0]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][0])}" if k[1][1].length>0 && k[1][1][0]>-1
    str="#{str}\n*High Rank:*" if (k[1][0].length>1 && k[1][0][1]>-1) || (k[1][1].length>1 && k[1][1][1]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][1])}" if k[1][0].length>1 && k[1][0][1]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][1])}" if k[1][1].length>1 && k[1][1][1]>-1
    str="#{str}\n*Expert Rank:*" if (k[1][0].length>2 && k[1][0][2]>-1) || (k[1][1].length>2 && k[1][1][2]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][2])}" if k[1][0].length>2 && k[1][0][2]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][2])}" if k[1][1].length>2 && k[1][1][2]>-1
    str="#{str}\n*Master Rank:*" if (k[1][0].length>3 && k[1][0][3]>-1) || (k[1][1].length>3 && k[1][1][3]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][3])}" if k[1][0].length>3 && k[1][0][3]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][3])}" if k[1][1].length>3 && k[1][1][3]>-1
    str="#{str}\n*Nightmare Rank:*" if (k[1][0].length>4 && k[1][0][4]>-1) || (k[1][1].length>4 && k[1][1][4]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][4])}" if k[1][0].length>4 && k[1][0][4]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][4])}" if k[1][1].length>4 && k[1][1][4]>-1
    str="#{str}\n*Trial (Solo):*" if (k[1][0].length>5 && k[1][0][5]>-1) || (k[1][1].length>5 && k[1][1][5]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][5])}" if k[1][0].length>5 && k[1][0][5]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][5])}" if k[1][1].length>5 && k[1][1][5]>-1
    str="#{str}\n*Trial (Co-op):*" if (k[1][0].length>6 && k[1][0][6]>-1) || (k[1][1].length>6 && k[1][1][6]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][6])}" if k[1][0].length>6 && k[1][0][6]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][6])}" if k[1][1].length>6 && k[1][1][6]>-1
    str="#{str}\n*Trial (Co-op 2):*" if (k[1][0].length>7 && k[1][0][7]>-1) || (k[1][1].length>7 && k[1][1][7]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][7])}" if k[1][0].length>7 && k[1][0][7]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][7])}" if k[1][1].length>7 && k[1][1][7]>-1
    str="#{str}\n*Advanced:*" if (k[1][0].length>8 && k[1][0][8]>-1) || (k[1][1].length>8 && k[1][1][8]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][8])}" if k[1][0].length>8 && k[1][0][8]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][8])}" if k[1][1].length>8 && k[1][1][8]>-1
    str="#{str}\n*Challenge:*" if (k[1][0].length>9 && k[1][0][9]>-1) || (k[1][1].length>9 && k[1][1][9]>-1)
    str="#{str}  <:HP:573344832307593216>HP: #{longFormattedNumber(k[1][0][9])}" if k[1][0].length>9 && k[1][0][9]>-1
    str="#{str}  <:Strength:573344931205349376>Str: #{longFormattedNumber(k[1][1][9])}" if k[1][1].length>9 && k[1][1][9]>-1
  else
    str="#{str}\n"
    if (k[1][0].length>0 && k[1][0][0]>-1) || (k[1][1].length>0 && k[1][1][0]>-1)
      if k[2][2]=='High Dragon'
        str="#{str}\n*Prelude:*"
      else
        str="#{str}\n*Beginner:*"
      end
    end
    statemotes=['<:HP:573344832307593216>','<:Strength:573344931205349376>','Omega','Raid']
    statemotes=['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','Singularity','Raid'] if k[2][3]=='Fate/Grand Order'
    statemotes=['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','Superhero'] if k[2][3]=='Mega Man: Chaos Protocol'
    str="#{str}  #{statemotes[0]}HP: #{longFormattedNumber(k[1][0][0])}" if k[1][0].length>0 && k[1][0][0]>-1
    str="#{str}  #{statemotes[1]}Str: #{longFormattedNumber(k[1][1][0])}" if k[1][1].length>0 && k[1][1][0]>-1
    str="#{str}\n*Standard:*" if (k[1][0].length>1 && k[1][0][1]>-1) || (k[1][1].length>1 && k[1][1][1]>-1)
    str="#{str}  #{statemotes[0]}HP: #{longFormattedNumber(k[1][0][1])}" if k[1][0].length>1 && k[1][0][1]>-1
    str="#{str}  #{statemotes[1]}Str: #{longFormattedNumber(k[1][1][1])}" if k[1][1].length>1 && k[1][1][1]>-1
    str="#{str}\n*Expert:*" if (k[1][0].length>2 && k[1][0][2]>-1) || (k[1][1].length>2 && k[1][1][2]>-1)
    str="#{str}  #{statemotes[0]}HP: #{longFormattedNumber(k[1][0][2])}" if k[1][0].length>2 && k[1][0][2]>-1
    str="#{str}  #{statemotes[1]}Str: #{longFormattedNumber(k[1][1][2])}" if k[1][1].length>2 && k[1][1][2]>-1
    str="#{str}\n*Master:*" if (k[1][0].length>3 && k[1][0][3]>-1) || (k[1][1].length>3 && k[1][1][3]>-1)
    str="#{str}  #{statemotes[0]}HP: #{longFormattedNumber(k[1][0][3])}" if k[1][0].length>3 && k[1][0][3]>-1
    str="#{str}  #{statemotes[1]}Str: #{longFormattedNumber(k[1][1][3])}" if k[1][1].length>3 && k[1][1][3]>-1
    str="#{str}\n*Nightmare:*" if (k[1][0].length>4 && k[1][0][4]>-1) || (k[1][1].length>4 && k[1][1][4]>-1)
    str="#{str}  #{statemotes[0]}HP: #{longFormattedNumber(k[1][0][4])}" if k[1][0].length>4 && k[1][0][4]>-1
    str="#{str}  #{statemotes[1]}Str: #{longFormattedNumber(k[1][1][4])}" if k[1][1].length>4 && k[1][1][4]>-1
    str="#{str}\n*#{statemotes[2]} (Solo):*" if (k[1][0].length>5 && k[1][0][5]>-1) || (k[1][1].length>5 && k[1][1][5]>-1)
    str="#{str}  #{statemotes[0]}HP: #{longFormattedNumber(k[1][0][5])}" if k[1][0].length>5 && k[1][0][5]>-1
    str="#{str}  #{statemotes[1]}Str: #{longFormattedNumber(k[1][1][5])}" if k[1][1].length>5 && k[1][1][5]>-1
    str="#{str}\n*#{statemotes[2]}#{" (#{statemotes[3]} L1)" unless statemotes[3].nil?}:*" if (k[1][0].length>6 && k[1][0][6]>-1) || (k[1][1].length>6 && k[1][1][6]>-1)
    str="#{str}  #{statemotes[0]}HP: #{longFormattedNumber(k[1][0][6])}" if k[1][0].length>6 && k[1][0][6]>-1
    str="#{str}  #{statemotes[1]}Str: #{longFormattedNumber(k[1][1][6])}" if k[1][1].length>6 && k[1][1][6]>-1
    str="#{str}\n*#{statemotes[2]}#{" (#{statemotes[3]} L2)" unless statemotes[3].nil?}:*" if (k[1][0].length>7 && k[1][0][7]>-1) || (k[1][1].length>7 && k[1][1][7]>-1)
    str="#{str}  #{statemotes[0]}HP: #{longFormattedNumber(k[1][0][7])}" if k[1][0].length>7 && k[1][0][7]>-1
    str="#{str}  #{statemotes[1]}Str: #{longFormattedNumber(k[1][1][7])}" if k[1][1].length>7 && k[1][1][7]>-1
    str="#{str}\n*Special:*" if (k[1][0].length>8 && k[1][0][8]>-1) || (k[1][1].length>8 && k[1][1][8]>-1)
    str="#{str}  #{statemotes[0]}HP: #{longFormattedNumber(k[1][0][8])}" if k[1][0].length>8 && k[1][0][8]>-1
    str="#{str}  #{statemotes[1]}Str: #{longFormattedNumber(k[1][1][8])}" if k[1][1].length>8 && k[1][1][8]>-1
    str="#{str}\n*Challenge:*" if (k[1][0].length>9 && k[1][0][9]>-1) || (k[1][1].length>9 && k[1][1][9]>-1)
    str="#{str}  #{statemotes[0]}HP: #{longFormattedNumber(k[1][0][9])}" if k[1][0].length>9 && k[1][0][9]>-1
    str="#{str}  #{statemotes[1]}Str: #{longFormattedNumber(k[1][1][9])}" if k[1][1].length>9 && k[1][1][9]>-1
  end
  if k[2].length>3 && !['Jingu Bang','Mini Dasheng'].include?(k[0])
    m=@enemies.reject{|q| q[0]==k[0] || q[2].length<4 || q[2][3]!=k[2][3] || ['Jingu Bang','Mini Dasheng'].include?(q[0])}
    str="#{str}#{"\n" if k[1].length>1 || m.length>0}\n**Event Name:** #{k[2][3]}"
    str="#{str}\n*Other bosses from this event:* #{m.map{|q| "#{enemy_emoji(q,bot)}#{q[0]}"}.join(', ')}" if m.length>0 && !ignoresub
  end
  flds=nil
  if s2s
    flds=[]
    flds.push(['Resistances',"#{k[3].join("\n")}"])
    flds.push(['Afflictions',"#{k[4].join("\n")}"])
  else
    str="#{str}\n\n**Resistances:** #{k[3].join(', ')}"
    str="#{str}\n\n**Afflictions:** #{k[4].join(', ')}"
  end
  unless k[5].nil? || k[5].length<=0
    str2=''
    for i in 0...k[5].length
      abl=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==k[5][i]}
      unless abl.nil?
        abl=sklz[abl]
        str2="#{str2}\n\n**#{abl[0]}#{" #{'+' if abl[1].include?('%')}#{abl[1]}" unless abl[1]=='-'}**#{"\n#{abl[3]}" if abl[5]=='y'}"
      end
    end
    unless str2.length<=0
      if s2s
        flds.push(['Abilities',str2,1])
      else
        str="#{str}#{str2}"
      end
    end
  end
  xcolor=0xE3F78B
  xcolor=0xEF8663 if k[2][1]=='Thaumian'
  xcolor=0x5AD363 if k[2][1]=='Physian'
  xcolor=0xAD9087 if k[2][1]=='Therion'
  xcolor=0x271B2F if k[2][1]=='Dragon'
  xcolor=0x3B4DBB if k[2][1]=='Demon'
  xcolor=0x495218 if k[2][1]=='Demihuman'
  xcolor=0xFFDC5D if k[2][1]=='Human'
  xcolor=0xAD82DE if k[2][1]=='Undead'
  xpic="#{k[0].gsub(' ','_')}"
  ftr=nil
  ftr='For information about the enemies that spawn during the fight, try adding "Clone Wave 1" or "Clone Wave 2" to your message.' if k[0]=="Wandering Shroom" && !s2s
  ftr='For information about the enemies that spawn during the fight, they are named "Gift Basket".' if k[0]=="Shishimai" && !s2s
  ftr='For information about the enemies that spawn during the fight, they are named "Astral Gift Basket".' if k[0]=="Astral Shishimai" && !s2s
  hdr="__**#{k[0]}**__"
  if k[2][2]=='Void' && k[2].length>3 && k[2][3][0,11]=='Fire Emblem'
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[2][1].gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Null')}"}
    hdr="#{moji[0].mention}<:Current_Tempest_Bonus:498797966740422656> #{hdr}" if moji.length>0
  elsif k[2][2]=='Void'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0].gsub('None','Null')}"}
    hdr="#{moji[0].mention}<:Element_Void:548467446734913536> #{hdr}" if moji.length>0
  elsif k[2][2]=='High Dragon'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0].gsub('None','Null')}"}
    hdr="#{moji[0].mention} #{hdr}" if moji.length>0
  elsif k[2][2]=='Imperial Order'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0].gsub('None','Null')}"}
    hdr="#{moji[0].mention} #{hdr}" if moji.length>0
  end
  m=false
  IO.copy_stream(open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/FightBanners/Banner_#{xpic}.png"), "#{@location}devkit/DLTemp#{@shardizard}.png") rescue m=true
  if File.size("#{@location}devkit/DLTemp#{@shardizard}.png")<=100 || m
    xpic="#{xpic.gsub('_(Enemy)','')}"
  end
  xpic=[nil,"https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/FightBanners/Banner_#{xpic}.png"]
  xpic='https://github.com/Rot8erConeX/BotanBot/blob/master/FightBanners/Matilda_5.png?raw=true' if k[0]=='Matilda'
  create_embed(event,[hdr,title],str,xcolor,ftr,xpic,flds)
  if k[0]=="Wandering Shroom" && s2s
    disp_enemy_data(bot,event,"Wandering Shroom, Clone Wave 1".split(' '),true)
    disp_enemy_data(bot,event,"Wandering Shroom, Clone Wave 2".split(' '),true)
  elsif k[0]=="Qitian Dasheng" && s2s
    disp_enemy_data(bot,event,"Jingu Bang".split(' '),true)
    disp_enemy_data(bot,event,"Mini Dasheng".split(' '),true)
  elsif k[0]=="Gust Shroom" && s2s
    disp_enemy_data(bot,event,"Gust Shroom, Clone Wave 1".split(' '),true)
    disp_enemy_data(bot,event,"Gust Shroom, Clone Wave 2".split(' '),true)
  elsif k[0]=="Shishimai" && s2s
    disp_enemy_data(bot,event,"Gift Basket".split(' '),true)
  elsif k[0]=="Astral Shishimai" && s2s
    disp_enemy_data(bot,event,"Astral Gift Basket".split(' '),true)
  elsif k[0]=="Volk" && s2s
    disp_enemy_data(bot,event,"Blood Moon".split(' '),true)
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
  if k.nil? || k.length<=0
    event.respond 'No matches found.'
    return nil
  end
  if File.exist?("#{@location}devkit/DLGauntlet.txt")
    b=[]
    File.open("#{@location}devkit/DLGauntlet.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][2]=b[i][2].to_i
  end
  gaunt=b.reject{|q| q[0]!=k[0]}
  element=''
  level=0
  for i in 0...args.length
    element='Flame' if ['flame','fire','flames','fires'].include?(args[i].downcase) && element.length<=0
    element='Water' if ['water','waters'].include?(args[i].downcase) && element.length<=0
    element='Wind' if ['wind','air','winds','airs'].include?(args[i].downcase) && element.length<=0
    element='Wind' if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920 && element.length<=0
    element='Light' if ['light','lights'].include?(args[i].downcase) && element.length<=0
    element='Shadow' if ['shadow','dark','shadows','darks'].include?(args[i].downcase) && element.length<=0
  end
  gaunt=gaunt.reject{|q| q[1]!=element} if element.length>0
  for i in 0...args.length
    level=args[i].to_i if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<=gaunt.map{|q| q[2]}.max && level<=0
  end
  gaunt=gaunt.reject{|q| q[2]!=level} if level>0
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  sklz=@askilities.map{|q| q}
  title=''
  str=''
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{gaunt[0][1].gsub('None','Null')}"}
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{gaunt[0][1].gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Null')}"} if k[2].length>3 && k[2][3][0,11]=='Fire Emblem'
  title="#{title}\n#{moji[0].mention unless moji.length<=0} **Element:** #{gaunt[0][1]}" unless ['High Dragon','Void','Imperial Order'].include?(k[2][2]) || gaunt.map{|q| q[1]}.uniq.length>1
  title="#{title}\n**Stage:** #{gaunt[0][2]}" unless gaunt.map{|q| q[2]}.uniq.length>1
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{k[2][1]}"}
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Icon_Move_Infantry"} if k[2].length>3 && k[2][3][0,11]=='Fire Emblem'
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Icon_Move_Armor"} if k[2].length>3 && k[2][3][0,11]=='Fire Emblem' && !k[0].include?('(Enemy)')
  title="#{title}\n#{moji[0].mention unless moji.length<=0} **Tribe:** #{k[2][1]}"
  xcolor=0xE3F78B
  xcolor=0xEF8663 if k[2][1]=='Thaumian'
  xcolor=0x5AD363 if k[2][1]=='Physian'
  xcolor=0xAD9087 if k[2][1]=='Therion'
  xcolor=0x271B2F if k[2][1]=='Dragon'
  xcolor=0x3B4DBB if k[2][1]=='Demon'
  xcolor=0x495218 if k[2][1]=='Demihuman'
  xcolor=0xFFDC5D if k[2][1]=='Human'
  xcolor=0xAD82DE if k[2][1]=='Undead'
  if k[2].length>3 && !['Jingu Bang','Mini Dasheng'].include?(k[0])
    m=@enemies.reject{|q| q[0]==k[0] || q[2].length<4 || q[2][3]!=k[2][3] || ['Jingu Bang','Mini Dasheng'].include?(q[0])}
    str="#{str}#{"\n" if k[1].length>1 || m.length>0}\n**Event Name:** #{k[2][3]}"
    str="#{str}\n*Other bosses from this event:* #{m.map{|q| "#{enemy_emoji(q,bot)}#{q[0]}"}.join(', ')}" if m.length>0 && !ignoresub
  end
  str="#{str}\n"
  flds=nil
  ftr='For more detailed information, look up a single element/stage combination.'
  if gaunt.map{|q| q[1]}.uniq.length<2 && gaunt.map{|q| q[2]}.uniq.length<2
    str="#{str}\n<:HP:573344832307593216>*Maximum HP*: #{longFormattedNumber(gaunt[0][3].to_i)}\n<:Strength:573344931205349376>*Strength*: #{longFormattedNumber(gaunt[0][4].to_i)}#{"\n*Reward*: #{gaunt[0][11]}" unless gaunt[0][11].nil? || gaunt[0][11].length<=0}"
    flds=[]
    flds.push(['Resistances',gaunt[0][8].gsub(', ',"\n")]) unless gaunt[0][8].nil? || gaunt[0][8].length<=0
    flds.push(['Afflictions',gaunt[0][9].gsub(', ',"\n")]) unless gaunt[0][9].nil? || gaunt[0][9].length<=0
    ftr=nil
  elsif gaunt.map{|q| q[1]}.uniq.length<2
    for i in 0...gaunt.length
      str="#{str}\n*Stage #{gaunt[i][2]}*: <:HP:573344832307593216>HP: #{longFormattedNumber(gaunt[i][3].to_i)}  <:Strength:573344931205349376>Str: #{longFormattedNumber(gaunt[i][4].to_i)}#{" - Reward: #{gaunt[i][11]}" unless gaunt[i][11].nil? || gaunt[i][11].length<=0}" if [0,19,39,59,79,99,gaunt.length-1].include?(i) || safe_to_spam?(event)
    end
  elsif gaunt.map{|q| q[2]}.uniq.length<2
    for i in 0...gaunt.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{gaunt[i][1].gsub('None','Null')}"}
      str="#{str}\n#{moji[0].mention if moji.length>0}*#{gaunt[i][1]}*: <:HP:573344832307593216>HP: #{longFormattedNumber(gaunt[i][3].to_i)}  <:Strength:573344931205349376>Str: #{longFormattedNumber(gaunt[i][4].to_i)}#{" - Reward: #{gaunt[i][11]}" unless gaunt[i][11].nil? || gaunt[i][11].length<=0}"
    end
  else
    flds=[]
    f=gaunt.map{|q| q[1]}.uniq
    for i in 0...f.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{f[i].gsub('None','Null')}"}
      f2=gaunt.reject{|q| q[1]!=f[i]}
      f2=f2.sort{|a,b| a[2]<=>b[2]}
      f3="*Stage #{f2[0][2]}*: <:HP:573344832307593216>HP: #{longFormattedNumber(f2[0][3].to_i)}  <:Strength:573344931205349376>Str: #{longFormattedNumber(f2[0][4].to_i)}"
      f3="#{f3}\n*Stage #{f2[-1][2]}*: <:HP:573344832307593216>HP: #{longFormattedNumber(f2[-1][3].to_i)}  <:Strength:573344931205349376>Str: #{longFormattedNumber(f2[-1][4].to_i)}#{" - Reward: #{f2[-1][11]}" unless f2[-1][11].nil? || f2[-1][11].length<=0}"
      flds.push(["#{moji[0].mention unless moji.length<=0}#{f[i]}",f3])
    end
  end
  xpic="#{k[0].gsub(' ','_')}"
  m=false
  IO.copy_stream(open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/FightBanners/Banner_#{xpic}.png"), "#{@location}devkit/DLTemp#{@shardizard}.png") rescue m=true
  if File.size("#{@location}devkit/DLTemp#{@shardizard}.png")<=100 || m
    xpic="#{xpic.gsub('_(Enemy)','')}"
  end
  xpic=[nil,"https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/FightBanners/Banner_#{xpic}.png"]
  xpic='https://github.com/Rot8erConeX/BotanBot/blob/master/FightBanners/Matilda_5.png?raw=true' if k[0]=='Matilda'
  name="__**#{name}**__"
  if title.length+str.length>=1900
    m=[0,str.split("\n\n")]
    for i in 0...m[1].length
      m[1][i]=m[1][i].split("\n") if m[1][i].length>=1900
    end
    m[1]=m[1].flatten
    str=''
    for i in 0...m[1].length
      if "#{str}\n\n#{m[1][i]}".length>=1900
        if m[0]==0
          create_embed(event,[name,title],str,xcolor,nil,xpic)
        else
          create_embed(event,'',str,xcolor)
        end
        m[0]+=1
        str="#{m[1][i]}"
      else
        str="#{str}#{"\n" unless !str.split("\n")[-1].nil? && str.split("\n")[-1][0,7]=='*Stage '}\n#{m[1][i]}"
      end
    end
    if m[0]==0
      create_embed(event,[name,title],str,xcolor,nil,xpic)
    elsif flds.nil?
      create_embed(event,'',str,xcolor,ftr)
    else
      create_embed(event,'',str,xcolor)
    end
    create_embed(event,'','',xcolor,ftr,nil,flds) unless flds.nil?
  else
    create_embed(event,[name,title],str,xcolor,ftr,xpic,flds)
  end
end

def art_of_adventure(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_adventurer,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  elsif k[0]=='Mym(Halloween)' && has_any?(args,['dragon','drg'])
    disp_dragon_art(bot,event,['brunhilda','halloween'])
    return nil
  elsif k[0]=='Lathna' && has_any?(args,['dragon','drg'])
    disp_dragon_art(bot,event,['nyarlathotep','alt'])
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  rar=0
  lookout=[]
  if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
    lookout=[]
    File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Art' && q[2]!='Art/Adventurer'}
  rarval=[]
  for i in 0...@max_rarity[0]+1
    rarval.push(i)
  end
  for i in 0...args.length
    rar=args[i].to_i if rar==0 && args[i].to_i.to_s==args[i] && args[i].to_i>2 && args[i].to_i<@max_rarity[0]+1
    rar=args[i].to_i if rar==0 && args[i][1,1]=='*' && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>2 && args[i][0,1].to_i<@max_rarity[0]+1
    for j in 0...lookout.length
      rar=lookout[j][0] if rarval.include?(rar) && lookout[j][1].include?(args[i].downcase)
    end
  end
  rar='Dress_Blue' if args.map{|q| q.downcase}.include?('dress') && !rar.is_a?(String)
  if k[0]=='Xainfried' && rar=='Animal' && has_any?(['christmas','winter','dy','dragonyule','santa'],args.map{|q| q.downcase})
    k=find_data_ex(:find_adventurer,'Xainfried(Dragonyule)',event)
  end
  feh=false
  feh=true if !k[12].nil? && k[12]=='FEH'
  feh=true if !k[12].nil? && k[12]=='FGO'
  fehm=''
  fehm='FEH' if feh
  fehm='FGO' if !k[12].nil? && k[12]=='FGO'
  if rar.is_a?(String)
    m=false
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Adventurers/#{k[0].gsub(' ','_')}_#{rar}.png"
    IO.copy_stream(open(art), "#{@location}devkit/DLTemp#{@shardizard}.png") rescue m=true
    if File.size("#{@location}devkit/DLTemp#{@shardizard}.png")<=100 || m
      rar=k[1][0,1].to_i
      disp="#{generate_rarity_row(rar,@max_rarity[0],fehm)}"
    elsif rar=='NPC'
      rar=1
      rar=2 if ['Lathna','Nina','Notte'].include?(k[0])
      disp="#{generate_rarity_row(rar,@max_rarity[0],fehm)}"
    else
      disp="#{rar.gsub('Dress_Blue','Blue dress').gsub('Dress_Red','Red dress')} design"
    end
  else
    rar=k[1][0,1].to_i if rar<k[1][0,1].to_i || rar>5
    disp="#{generate_rarity_row(rar,@max_rarity[0],fehm)}"
  end
  art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Adventurers/#{k[0].gsub(' ','_')}_#{rar}.png"
  nammes=['','','']
  unless k[11].nil? || k[11].length<=0
    m=k[11].split(' as ')
    nammes[1]=m[0]
    disp="#{disp}\n**VA (English):** #{m[m.length-1]}"
  end
  unless k[10].nil? || k[10].length<=0
    m=k[10].split(' as ')
    nammes[2]=m[0]
    disp="#{disp}\n**VA (Japanese):** #{m[m.length-1]}"
  end
  if args.include?('just') || args.include?('justart') || args.include?('blank') || args.include?('noinfo')
    charsx=[[],[],[]]
  else
    charsx=[[],[],[]]
    chars=@adventurers.reject{|q| q[0]==k[0] || ((q[10].nil? || q[10].length<=0) && (q[11].nil? || q[11].length<=0))}
    for i in 0...chars.length
      x=chars[i]
      unless x[10].nil? || x[10].length<=0 || x[11].nil? || x[11].length<=0
        m=x[10].split(' as ')
        m2=x[11].split(' as ')
        charsx[1].push("#{x[0]} *[Both]*") if m[0]==nammes[2] && m2[0]==nammes[1]
      end
      unless x[11].nil? || x[11].length<=0
        m=x[11].split(' as ')
        charsx[1].push("#{x[0]} *[English]*") if m[0]==nammes[1] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
      unless x[10].nil? || x[10].length<=0
        m=x[10].split(' as ')
        charsx[1].push("#{x[0]} *[Japanese]*") if m[0]==nammes[2] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
    end
    chars=@dragons.reject{|q| q[0]==k[0] || ((q[13].nil? || q[13].length<=0) && (q[14].nil? || q[14].length<=0))}
    for i in 0...chars.length
      x=chars[i]
      unless x[13].nil? || x[13].length<=0 || x[14].nil? || x[14].length<=0
        m=x[13].split(' as ')
        m2=x[14].split(' as ')
        charsx[1].push("#{x[0]} *[Both]*") if m[0]==nammes[2] && m2[0]==nammes[1]
      end
      unless x[14].nil? || x[14].length<=0
        m=x[14].split(' as ')
        charsx[1].push("#{x[0]} *[English]*") if m[0]==nammes[1] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
      unless x[13].nil? || x[13].length<=0
        m=x[13].split(' as ')
        charsx[1].push("#{x[0]} *[Japanese]*") if m[0]==nammes[2] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
    end
    if !k[11].nil? && k[11].include?(' & ')
      m=k[11].split(' & ')
      for i in 0...m.length
        charsx[1].push(@adventurers.reject{|q| q[11]!=m[i]}.map{|q| "#{q[0]} *[English voice #{i+1}]*"}.join("\n"))
        charsx[1].push(@dragons.reject{|q| q[14]!=m[i]}.map{|q| "#{q[0]} *[English voice #{i+1}]*"}.join("\n"))
      end
    end
    if !k[10].nil? && k[10].include?(' & ')
      m=k[10].split(' & ')
      for i in 0...m.length
        charsx[1].push(@adventurers.reject{|q| q[10]!=m[i]}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]} *[Japanese voice #{i+1}]*"}.join("\n"))
        charsx[1].push(@dragons.reject{|q| q[13]!=m[i]}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]} *[Japanese voice #{i+1}]*"}.join("\n"))
      end
    end
    if File.exist?("#{@location}devkit/FEHUnits.txt")
      b=[]
      File.open("#{@location}devkit/FEHUnits.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      b[i][7]=b[i][7].split(';; ')
      if !b[i][7][0].nil? && b[i][7][0].length>0 && !b[i][7][1].nil? && b[i][7][1].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[English]*") if b[i][7][0].split(' as ')[0]==k[11] && b[i][7][1].split(' as ')[0]!=k[10]
        charsx[1].push("*[FEH]* #{b[i][0]} *[Japanese]*") if b[i][7][1].split(' as ')[0]==k[10] && b[i][7][0].split(' as ')[0]!=k[11]
        charsx[1].push("*[FEH]* #{b[i][0]} *[Both]*") if b[i][7][1].split(' as ')[0]==k[10] && b[i][7][0].split(' as ')[0]==k[11]
      elsif !b[i][7][0].nil? && b[i][7][0].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[English]*") if b[i][7][0].split(' as ')[0]==k[11]
      elsif !b[i][7][1].nil? && b[i][7][1].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[Japanese]*") if b[i][7][1].split(' as ')[0]==k[10]
      end
    end
    if event.server.nil? || !bot.user(502288364838322176).on(event.server.id).nil? || @shardizard==4
      if File.exist?("#{@location}devkit/FGOServants.txt")
        b=[]
        File.open("#{@location}devkit/FGOServants.txt").each_line do |line|
          b.push(line)
        end
      else
        b=[]
      end
      b=b.map{|q| q.gsub("\n",'').split('\\'[0])}
      for i in 0...b.length
        if b[i][0].include?('.')
          b[i][0]=[b[i][0].to_f,true]
        else
          b[i][0]=[b[i][0].to_i,false]
        end
      end
      for i in 0...b.length
        dispnum="#{b[i][0][0]}#{'.' unless b[i][0][1]}"
        if b[i][0][1]
          b2=b.reject{|q| q[0][0].to_i != b[i][0][0].to_i}.map{|q| [q[24],q[25]]}.uniq
          if b[i][0][0].to_i==b[i][0][0]
            dispnum="#{b[i][0][0].to_i}." if b2.length<2
            b[i][0][1]=false
          else
            b[i][0][1]=false if b2.length>1
          end
        end
        unless nammes[2].nil? || nammes[2].length<=0 || b[i][25].nil? || b[i][25].length<=0
          charsx[1].push("*[FGO]* Srv-#{dispnum}) #{b[i][1]} *[Japanese]*") if b[i][25].split(' & ').include?(nammes[2]) && !b[i][0][1]
        end
      end
    end
    disp='>No information<' if disp.length<=0
  end
  wrm=@wyrmprints.reject{|q| q[8].nil? || q[8].length<=0}
  wrmz=[]
  nme2check="#{k[0]}"
  nme2check='Mym' if k[0]=='Gala Mym'
  for i in 0...wrm.length
    wrmz.push("#{wrm[i][0]}") if wrm[i][8][0].include?(nme2check) && !wrm[i][8][1].nil? && wrm[i][8][1].include?(nme2check)
    wrmz.push("#{wrm[i][0]}") if wrm[i][8][0].include?(nme2check) && wrm[i][8][1].nil?
    wrmz.push("#{wrm[i][0]} *[Base]*") if wrm[i][8][0].include?(nme2check) && !wrm[i][8][1].nil? && !wrm[i][8][1].include?(nme2check)
    wrmz.push("#{wrm[i][0]} *[Refined]*") if !wrm[i][8][0].include?(nme2check) && !wrm[i][8][1].nil? && wrm[i][8][1].include?(nme2check)
  end
  dispx="#{disp}"
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    disp="#{disp}\n" if charsx.map{|q| q.length}.max>0
    disp="#{disp}\n**Same artist:** #{charsx[0].join(', ')}" if charsx[0].length>0
    if charsx[1].length>0
      disp="#{disp}\n**Same VA:**"
      disp2=""
      c=charsx[1].reject{|q| !q.include?('*[English]*')}.map{|q| q.gsub(' *[English]*','')}
      disp2="#{disp2}\n*English only:* #{c.join(', ')}" if c.length>0
      c=charsx[1].reject{|q| !q.include?('*[Japanese]*')}.map{|q| q.gsub(' *[Japanese]*','')}
      disp2="#{disp2}\n*Japanese only:* #{c.join(', ')}" if c.length>0
      c=charsx[1].reject{|q| !q.include?('*[Both]*')}.map{|q| q.gsub(' *[Both]*','')}
      disp2="#{disp2}\n*Both languages:* #{c.join(', ')}" if c.length>0
      disp2=disp2[1,disp2.length-1]
      if disp2.include?("\n")
        disp="#{disp}\n#{disp2}"
      else
        disp="#{disp} #{disp2}"
      end
    end
    disp="#{disp}\n**Same __everything__:** #{charsx[2].join(', ')}" if charsx[2].length>0
    disp="#{disp}\n**Found in these wyrmprints:** #{wrmz.join(', ')}" if wrmz.length>0
    disp=dispx if disp.length>=1900
    event.respond "#{disp}\n\n#{art}"
  else
    flds=[]
    flds.push(['Same Artist',charsx[0].join("\n")]) if charsx[0].length>0
    if charsx[1].length>0
      if charsx[1].length==charsx[1].reject{|q| !q.include?('*[English]*')}.length
        flds.push(['Same VA (English)',charsx[1].map{|q| q.gsub(' *[English]*','')}.join("\n")])
      elsif charsx[1].length==charsx[1].reject{|q| !q.include?('*[Japanese]*')}.length
        flds.push(['Same VA (Japanese)',charsx[1].map{|q| q.gsub(' *[Japanese]*','')}.join("\n")])
      elsif charsx[1].length==charsx[1].reject{|q| !q.include?('*[Both]*')}.length
        flds.push(['Same VA (Both)',charsx[1].map{|q| q.gsub(' *[Both]*','')}.join("\n")])
      else
        flds.push(['Same VA',charsx[1].join("\n")])
      end
    end
    flds.push(['Same everything',charsx[2].join("\n"),1]) if charsx[2].length>0
    flds.push(['Found in these wyrmprints',wrmz.join("\n")]) if wrmz.length>0
    if flds.length.zero?
      flds=nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1500 && safe_to_spam?(event)
      create_embed(event,"__**#{k[0]}**__#{adv_emoji(k,bot)}",disp,element_color(k[2][1]),nil,[nil,art])
      if flds.map{|q| q.join("\n")}.join("\n\n").length>=1900
        for i in 0...flds.length
          create_embed(event,'','',element_color(k[2][1]),nil,nil,[flds[i]])
        end
      else
        create_embed(event,'','',element_color(k[2][1]),nil,nil,flds)
      end
      return nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1800
      disp="#{disp}\nThe list of units with the same VA is so long that I cannot fit it into a single embed. Please use this command in PM."
      flds=nil
    else
      flds[-1][2]=nil if flds.length<3
      flds[-1].compact!
    end
    create_embed(event,"__**#{k[0]}**#{adv_emoji(k,bot)}__",disp,element_color(k[2][1]),nil,[nil,art],flds)
  end
end

def art_of_dragon(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.map{|q| q.downcase}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_dragon,args.join(' '),event)
  if k.length.zero?
    k=find_data_ex(:find_adventurer,args.join(' '),event)
    if k.length.zero?
      event.respond 'No matches found.'
      return nil
    elsif k[0]=='Lathna'
      k=find_data_ex(:find_dragon,'Nyarlathotep',event)
      args=['alt']
    else
      event.respond 'No matches found.'
      return nil
    end
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  feh=false
  feh=true if !k[12].nil? && k[12]=='FEH'
  feh=true if !k[12].nil? && k[12]=='FGO'
  fehm=''
  fehm='FEH' if feh
  fehm='FGO' if !k[12].nil? && k[12]=='FGO'
  disp=''
  disp="#{generate_rarity_row(k[1][0,1].to_i,0,fehm)}"
  disp='<:Rarity_3:532086056519204864>'*k[1][0,1].to_i if k[0]=='Bronze Fafnir'
  disp='<:Rarity_4:532086056301101067>'*k[1][0,1].to_i if k[0]=='Silver Fafnir'
  disp='<:Rarity_5:532086056737177600>'*k[1][0,1].to_i if k[0]=='Gold Fafnir'
  lookout=[]
  if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
    lookout=[]
    File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Art' && q[2]!='Art/Dragon'}
  for i in 0...args.length
    for j in 0...lookout.length
      rar=lookout[j][0] if rar.nil? && lookout[j][1].include?(args[i].downcase)
    end
  end
  if rar.nil? && k[0]=='Brunhilda' && args.include?('mym')
    rar='Human'
    disp="#{generate_rarity_row(k[1][0,1].to_i,@max_rarity[0],fehm)}"
  end
  if !rar.nil? && rar.is_a?(String)
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Dragons/#{k[0].gsub(' ','_')}#{"_#{rar}" unless rar.nil?}.png"
    IO.copy_stream(open(art), "#{@location}devkit/DLTemp#{@shardizard}.png") rescue m=true
    if File.size("#{@location}devkit/DLTemp#{@shardizard}.png")<=100 || m
      rar=nil
    else
      disp="#{disp}\n#{rar} design\n"
    end
  end
  nammes=['','','']
  unless k[14].nil? || k[14].length<=0
    m=k[14].split(' as ')
    nammes[1]=m[0]
    disp="#{disp}\n**VA (English):** #{m[m.length-1]}"
  end
  unless k[13].nil? || k[13].length<=0
    m=k[13].split(' as ')
    nammes[2]=m[0]
    disp="#{disp}\n**VA (Japanese):** #{m[m.length-1]}"
  end
  if args.include?('just') || args.include?('justart') || args.include?('blank') || args.include?('noinfo')
    charsx=[[],[],[]]
  else
    charsx=[[],[],[]]
    chars=@adventurers.reject{|q| q[0]==k[0] || ((q[10].nil? || q[10].length<=0) && (q[11].nil? || q[11].length<=0))}
    for i in 0...chars.length
      x=chars[i]
      unless x[10].nil? || x[10].length<=0 || x[11].nil? || x[11].length<=0
        m=x[10].split(' as ')
        m2=x[11].split(' as ')
        charsx[1].push("#{x[0]} *[Both]*") if m[0]==nammes[2] && m2[0]==nammes[1]
      end
      unless x[11].nil? || x[11].length<=0
        m=x[11].split(' as ')
        charsx[1].push("#{x[0]} *[English]*") if m[0]==nammes[1] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
      unless x[10].nil? || x[10].length<=0
        m=x[10].split(' as ')
        charsx[1].push("#{x[0]} *[Japanese]*") if m[0]==nammes[2] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
    end
    chars=@dragons.reject{|q| q[0]==k[0] || ((q[13].nil? || q[13].length<=0) && (q[14].nil? || q[14].length<=0))}
    for i in 0...chars.length
      x=chars[i]
      unless x[13].nil? || x[13].length<=0 || x[14].nil? || x[14].length<=0
        m=x[13].split(' as ')
        m2=x[14].split(' as ')
        charsx[1].push("#{x[0]} *[Both]*") if m[0]==nammes[2] && m2[0]==nammes[1]
      end
      unless x[14].nil? || x[14].length<=0
        m=x[14].split(' as ')
        charsx[1].push("#{x[0]} *[English]*") if m[0]==nammes[1] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
      unless x[13].nil? || x[13].length<=0
        m=x[13].split(' as ')
        charsx[1].push("#{x[0]} *[Japanese]*") if m[0]==nammes[2] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
    end
    if !k[14].nil? && k[14].include?(' & ')
      m=k[14].split(' & ')
      for i in 0...m.length
        charsx[1].push(@adventurers.reject{|q| q[11]!=m[i]}.map{|q| "#{q[0]} *[English voice #{i+1}]*"}.join("\n"))
        charsx[1].push(@dragons.reject{|q| q[14]!=m[i]}.map{|q| "#{q[0]} *[English voice #{i+1}]*"}.join("\n"))
      end
    end
    if !k[13].nil? && k[13].include?(' & ')
      m=k[13].split(' & ')
      for i in 0...m.length
        charsx[1].push(@adventurers.reject{|q| q[10]!=m[i]}.map{|q| "#{q[0]} *[Japanese voice #{i+1}]*"}.join("\n"))
        charsx[1].push(@dragons.reject{|q| q[13]!=m[i]}.map{|q| "#{q[0]} *[Japanese voice #{i+1}]*"}.join("\n"))
      end
    end
    if File.exist?("#{@location}devkit/FEHUnits.txt")
      b=[]
      File.open("#{@location}devkit/FEHUnits.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      if !b[i][7].nil? && b[i][7].length>0 && !b[i][8].nil? && b[i][8].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[English]*") if b[i][7].split(' as ')[0]==k[14] && b[i][8].split(' as ')[0]!=k[13]
        charsx[1].push("*[FEH]* #{b[i][0]} *[Japanese]*") if b[i][8].split(' as ')[0]==k[13] && b[i][7].split(' as ')[0]!=k[14]
        charsx[1].push("*[FEH]* #{b[i][0]} *[Both]*") if b[i][8].split(' as ')[0]==k[13] && b[i][7].split(' as ')[0]==k[14]
      elsif !b[i][7].nil? && b[i][7].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[English]*") if b[i][7].split(' as ')[0]==k[14]
      elsif !b[i][8].nil? && b[i][8].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[Japanese]*") if b[i][8].split(' as ')[0]==k[13]
      end
    end
    if event.server.nil? || !bot.user(502288364838322176).on(event.server.id).nil? || @shardizard==4
      if File.exist?("#{@location}devkit/FGOServants.txt")
        b=[]
        File.open("#{@location}devkit/FGOServants.txt").each_line do |line|
          b.push(line)
        end
      else
        b=[]
      end
      for i in 0...b.length
        b[i]=b[i].gsub("\n",'').split('\\'[0])
        unless nammes[2].nil? || nammes[2].length<=0 || b[i][25].nil? || b[i][25].length<=0
          charsx[1].push("*[FGO]* Srv-#{b[i][0]}#{"#{'.' if b[i][0].to_i>=2}) #{b[i][1]}" unless @embedless.include?(event.user.id) || was_embedless_mentioned?(event)} *[Japanese]*") if b[i][25].split(' & ').include?(nammes[2])
        end
      end
    end
    disp='>No information<' if disp.length<=0
  end
  wrm=@wyrmprints.reject{|q| q[8].nil? || q[8].length<=0}
  wrmz=[]
  nnn="#{k[0]}"
  nnn="Mym" if k[0]=='Brunhilda' && ['Human','Kimono','Damaged'].include?(rar)
  for i in 0...wrm.length
    wrmz.push("#{wrm[i][0]}") if wrm[i][8][0].include?(nnn) && !wrm[i][8][1].nil? && wrm[i][8][1].include?(nnn)
    wrmz.push("#{wrm[i][0]}") if wrm[i][8][0].include?(nnn) && wrm[i][8][1].nil?
    wrmz.push("#{wrm[i][0]} *[Base]*") if wrm[i][8][0].include?(nnn) && !wrm[i][8][1].nil? && !wrm[i][8][1].include?(nnn)
    wrmz.push("#{wrm[i][0]} *[Refined]*") if !wrm[i][8][0].include?(nnn) && !wrm[i][8][1].nil? && wrm[i][8][1].include?(nnn)
  end
  art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Dragons/#{k[0].gsub(' ','_')}#{"_#{rar}" unless rar.nil?}.png"
  dispx="#{disp}"
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    disp="#{disp}\n" if charsx.map{|q| q.length}.max>0
    disp="#{disp}\n**Same artist:** #{charsx[0].join(', ')}" if charsx[0].length>0
    if charsx[1].length>0
      disp="#{disp}\n**Same VA:**"
      disp2=""
      c=charsx[1].reject{|q| !q.include?('*[English]*')}.map{|q| q.gsub(' *[English]*','')}
      disp2="#{disp2}\n*English only:* #{c.join(', ')}" if c.length>0
      c=charsx[1].reject{|q| !q.include?('*[Japanese]*')}.map{|q| q.gsub(' *[Japanese]*','')}
      disp2="#{disp2}\n*Japanese only:* #{c.join(', ')}" if c.length>0
      c=charsx[1].reject{|q| !q.include?('*[Both]*')}.map{|q| q.gsub(' *[Both]*','')}
      disp2="#{disp2}\n*Both languages:* #{c.join(', ')}" if c.length>0
      disp2=disp2[1,disp2.length-1]
      if disp2.include?("\n")
        disp="#{disp}\n#{disp2}"
      else
        disp="#{disp} #{disp2}"
      end
    end
    disp="#{disp}\n**Same __everything__:** #{charsx[2].join(', ')}" if charsx[2].length>0
    disp="#{disp}\n**Found in these wyrmprints:** #{wrmz.join(', ')}" if wrmz.length>0
    disp=dispx if disp.length>=1900
    event.respond "#{disp}\n\n#{art}"
  else
    flds=[]
    flds.push(['Same Artist',charsx[0].join("\n")]) if charsx[0].length>0
    if charsx[1].length>0
      if charsx[1].length==charsx[1].reject{|q| !q.include?('*[English]*')}.length
        flds.push(['Same VA (English)',charsx[1].map{|q| q.gsub(' *[English]*','')}.join("\n")])
      elsif charsx[1].length==charsx[1].reject{|q| !q.include?('*[Japanese]*')}.length
        flds.push(['Same VA (Japanese)',charsx[1].map{|q| q.gsub(' *[Japanese]*','')}.join("\n")])
      elsif charsx[1].length==charsx[1].reject{|q| !q.include?('*[Both]*')}.length
        flds.push(['Same VA (Both)',charsx[1].map{|q| q.gsub(' *[Both]*','')}.join("\n")])
      else
        flds.push(['Same VA',charsx[1].join("\n")])
      end
    end
    flds.push(['Same everything',charsx[2].join("\n"),1]) if charsx[2].length>0
    flds.push(['Found in these wyrmprints',wrmz.join("\n")]) if wrmz.length>0
    if flds.length.zero?
      flds=nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1500 && safe_to_spam?(event)
      create_embed(event,"__**#{k[0]}**__#{dragon_emoji(k,bot)}",disp,element_color(k[2]),nil,[nil,art])
      if flds.map{|q| q.join("\n")}.join("\n\n").length>=1900
        for i in 0...flds.length
          create_embed(event,'','',element_color(k[2]),nil,nil,[flds[i]])
        end
      else
        create_embed(event,'','',element_color(k[2]),nil,nil,flds)
      end
      return nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1800
      disp="#{disp}\nThe list of units with the same VA is so long that I cannot fit it into a single embed. Please use this command in PM."
      flds=nil
    else
      flds[-1][2]=nil if flds.length<3
      flds[-1].compact!
    end
    create_embed(event,"__**#{k[0]}**#{dragon_emoji(k,bot)}__",disp,element_color(k[2]),nil,[nil,art],flds)
  end
end

def art_of_printing(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_wyrmprint,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  feh=false
  feh=true if !k[10].nil? && k[10]=='FGO'
  ftr='Include the word "refined" for MUB art.'
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Wyrmprints/#{k[0].gsub(' ','_')}_1.png"
  emote='<:NonUnbound:534494090876682264>'
  emote='<:Limited:574682514585550848>' if feh
  if has_any?(['mub','unbind','unbound','refined','refine','refinement','2ub','3ub'],evn)
    xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Wyrmprints/#{k[0].gsub(' ','_')}_2.png"
    k[8]=k[8][-1] unless k[8].nil?
    ftr=nil
    emote='<:Unbind:534494090969088000>'
    emote='<:LimitBroken:574682514921095212>' if feh
  else
    k[8]=k[8][0] unless k[8].nil?
  end
  fehm=''
  fehm='FGO' if feh
  xcolor=0x313439
  xcolor=0x5A0408 if k[2]=='Attack'
  xcolor=0x00205A if k[2]=='Defense'
  xcolor=0x39045A if k[2]=='Support'
  xcolor=0x005918 if k[2]=='Healing'
  halfemote="\u200B  \u200B  \u200B  \u200B"
  disp="#{halfemote*(4-k[1][0,1].to_i) if k[1][0,1].to_i<4}#{" \u200B" if k[1][0,1].to_i<3}#{generate_rarity_row(k[1][0,1].to_i,0,fehm)}\n#{"#{halfemote} \u200B" if k[1][0,1].to_i==5}#{emote*4}"
  nammes=['','','']
  unless k[7].nil? || k[7].length<=0
    m=k[7].split(' as ')
    nammes[0]=m[0]
    disp="#{disp}\n**Artist:** #{m[m.length-1]}"
  end
  if args.include?('just') || args.include?('justart') || args.include?('blank') || args.include?('noinfo')
    charsx=[[],[],[]]
  else
    charsx=[[],[],[]]
    chars=@wyrmprints.reject{|q| q[0]==k[0] || q[0].include?('Wily Warriors ') || ((q[7].nil? || q[7].length<=0))}
    chars=@wyrmprints.reject{|q| q[0]==k[0] || q[0].include?('Wily Warriors ') || q[0].include?('Greatwyrm ') || ((q[7].nil? || q[7].length<=0))} unless @wyrmprints.find_index{|q| q[0]=='Greatwyrm'}.nil?
    for i in 0...chars.length
      x=chars[i]
      unless x[7].nil? || x[7].length<=0
        m=x[7].split(' as ')
        charsx[0].push("#{x[0]}") if m[0]==nammes[0]
      end
    end
    if File.exist?("#{@location}devkit/FEHUnits.txt")
      b=[]
      File.open("#{@location}devkit/FEHUnits.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      if !b[i][6].nil? && b[i][6].length>0
        b[i][6]=b[i][6].split(';; ')
        charsx[0].push("*[FEH]* #{b[i][0]}") if b[i][6][0].split(' as ')[0]==nammes[0]
        charsx[0].push("*[FEH]* - Resplendent #{b[i][0]}") if !b[i][6][1].nil? && b[i][6][1].split(' as ')[0]==nammes[0]
      end
    end
    if event.server.nil? || !bot.user(502288364838322176).on(event.server.id).nil? || @shardizard==4
      if File.exist?("#{@location}devkit/FGOServants.txt")
        b=[]
        File.open("#{@location}devkit/FGOServants.txt").each_line do |line|
          b.push(line)
        end
      else
        b=[]
      end
      for i in 0...b.length
        b[i]=b[i].gsub("\n",'').split('\\'[0])
        unless nammes[0].nil? || nammes[0].length<=0 || b[i][24].nil? || b[i][24].length<=0
          charsx[0].push("*[FGO]* Srv-#{b[i][0]}#{"#{'.' if b[i][0].to_i>=2}) #{b[i][1]}" unless @embedless.include?(event.user.id) || was_embedless_mentioned?(event)}") if b[i][24]==nammes[0]
        end
      end
      if File.exist?("#{@location}devkit/FGOCraftEssances.txt")
        b=[]
        File.open("#{@location}devkit/FGOCraftEssances.txt").each_line do |line|
          b.push(line)
        end
      else
        b=[]
      end
      for i in 0...b.length
        b[i]=b[i].gsub("\n",'').split('\\'[0])
        unless nammes[0].nil? || nammes[0].length<=0 || b[i][9].nil? || b[i][9].length<=0
          charsx[0].push("*[FGO]* CE-#{b[i][0]}#{".) #{b[i][1]}" unless @embedless.include?(event.user.id) || was_embedless_mentioned?(event)}") if b[i][9]==nammes[0]
        end
      end
    end
    disp='>No information<' if disp.length<=0
  end
  dispx="#{disp}"
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    disp="#{disp}\n" if charsx.map{|q| q.length}.max>0
    disp="#{disp}\n**Same artist:** #{charsx[0].join(', ')}" if charsx[0].length>0
    disp="#{disp}\n**Characters in art:** #{k[8].join(', ')}" if !k[8].nil? && k[8].length>0 && !(args.include?('just') || args.include?('justart') || args.include?('blank') || args.include?('noinfo'))
    disp=dispx if disp.length>=1900
    event.respond "#{disp}\n\n#{xpic}"
  else
    flds=[]
    unless args.include?('just') || args.include?('justart') || args.include?('blank') || args.include?('noinfo')
      flds.push(['Same Artist',charsx[0].join("\n")]) if charsx[0].length>0
      flds.push(['Characters in art',k[8].join("\n")]) if !k[8].nil? && k[8].length>0
    end
    if flds.length.zero?
      flds=nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1500 && safe_to_spam?(event)
      create_embed(event,"__**#{k[0]}**__#{print_emoji(k,bot)}",disp,xcolor,nil,[nil,xpic])
      if flds.map{|q| q.join("\n")}.join("\n\n").length>=1900
        for i in 0...flds.length
          create_embed(event,'','',xcolor,nil,nil,[flds[i]])
        end
      else
        create_embed(event,'','',xcolor,nil,nil,flds)
      end
      event.respond ftr unless ftr.nil?
      return nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1800
      disp="#{disp}\nThe list of units with the same VA is so long that I cannot fit it into a single embed. Please use this command in PM."
      flds=nil
    else
      flds[-1][2]=nil if flds.length<3
      flds[-1].compact!
    end
    create_embed(event,"__**#{k[0]}**#{print_emoji(k,bot)}__",disp,xcolor,ftr,[nil,xpic],flds)
  end
end

def art_of_the_boss(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_enemy,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  lookout=[]
  if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
    lookout=[]
    File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
      lookout.push(eval line)
    end
  end
  rar=nil
  lookout=lookout.reject{|q| q[2]!='Art' && q[2]!='Art/Enemy'}
  for i in 0...args.length
    for j in 0...lookout.length
      rar=lookout[j][0] if rar.nil? && lookout[j][1].include?(args[i].downcase)
    end
  end
  if !rar.nil? && rar.is_a?(String)
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Bosses/#{k[0].gsub(' ','_')}#{"_#{rar}" unless rar.nil?}.png"
    IO.copy_stream(open(art), "#{@location}devkit/DLTemp#{@shardizard}.png") rescue m=true
    if File.size("#{@location}devkit/DLTemp#{@shardizard}.png")<=100 || m
      rar=nil
    else
      disp="#{disp}\n#{rar} design\n"
    end
  end
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Bosses/#{k[0].gsub(' ','_')}#{"_#{rar}" unless rar.nil?}.png"
  xcolor=0xE3F78B
  xcolor=0xEF8663 if k[2][1]=='Thaumian'
  xcolor=0x5AD363 if k[2][1]=='Physian'
  xcolor=0xAD9087 if k[2][1]=='Therion'
  xcolor=0x271B2F if k[2][1]=='Dragon'
  xcolor=0x3B4DBB if k[2][1]=='Demon'
  xcolor=0x495218 if k[2][1]=='Demihuman'
  xcolor=0xFFDC5D if k[2][1]=='Human'
  xcolor=0xAD82DE if k[2][1]=='Undead'
  str="__**#{k[0]}**__"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0].gsub('None','Null')}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{k[2][1]}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  str2=''
  m=false
  IO.copy_stream(open(xpic), "#{@location}devkit/DLTemp#{@shardizard}.png") rescue m=true
  str2='No art found' if File.size("#{@location}devkit/DLTemp#{@shardizard}.png")<=100 || m
  str2="#{rar} design" unless rar.nil?
  create_embed(event,str,str2,xcolor,nil,[nil,xpic])
end

def art_of_emotion(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.map{|q| q.downcase}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_emote,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  disp=''
  nme=k[0].gsub(' ','_').gsub('!','').gsub('?','')
  nme="#{nme}(JP)" if has_any?(event.message.text.downcase.split(' '),['jp','japan'])
  art="https://github.com/Rot8erConeX/BotanBot/blob/master/Art/Stickers/#{nme}.png?raw=true"
  ftr='Include the word "JP" for the Japanese version.'
  ftr=nil if has_any?(event.message.text.downcase.split(' '),['jp','japan'])
  create_embed(event,"__**#{k[0]}**__","**Character in image:** #{k[1]}",0xCE456B,ftr,[nil,art])
end

def art_of_the_nobody(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.map{|q| q.downcase}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_npc,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  rar=nil
  fehm=''
  fehm='FEH' if ['Loki','Thorr'].include?(k[0])
  k[1]/=2 if k[1]>2 && !k[0].include?('Slime') && k[0]!='Snapper'
  disp="#{generate_rarity_row(k[1],0,fehm,true)}"
  disp="#{generate_rarity_row(k[1],@max_rarity[0],fehm,true)}" if k[2]=='n'
  lookout=[]
  if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
    lookout=[]
    File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Art' && q[2]!='Art/NPC'}
  for i in 0...args.length
    for j in 0...lookout.length
      rar=lookout[j][0] if rar.nil? && lookout[j][1].include?(args[i].downcase)
    end
  end
  wrm=@wyrmprints.reject{|q| q[8].nil? || q[8].length<=0}
  wrmz=[]
  nammes=['','','']
  unless k[3].nil? || k[3].length<=0
    m=k[3].split(' as ')
    nammes[1]=m[0]
    disp="#{disp}\n**VA (English):** #{m[m.length-1]}"
  end
  unless k[4].nil? || k[4].length<=0
    m=k[4].split(' as ')
    nammes[2]=m[0]
    disp="#{disp}\n**VA (Japanese):** #{m[m.length-1]}"
  end
  flds=[]
  if args.include?('just') || args.include?('justart') || args.include?('blank') || args.include?('noinfo')
    charsx=[[],[],[]]
  else
    charsx=[[],[],[]]
    chars=@adventurers.reject{|q| q[0]==k[0] || ((q[10].nil? || q[10].length<=0) && (q[11].nil? || q[11].length<=0))}
    for i in 0...chars.length
      x=chars[i]
      unless x[10].nil? || x[10].length<=0 || x[11].nil? || x[11].length<=0
        m=x[10].split(' as ')
        m2=x[11].split(' as ')
        charsx[1].push("#{x[0]} *[Both]*") if m[0]==nammes[2] && m2[0]==nammes[1]
      end
      unless x[11].nil? || x[11].length<=0
        m=x[11].split(' as ')
        charsx[1].push("#{x[0]} *[English]*") if m[0]==nammes[1] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
      unless x[10].nil? || x[10].length<=0
        m=x[10].split(' as ')
        charsx[1].push("#{x[0]} *[Japanese]*") if m[0]==nammes[2] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
    end
    chars=@dragons.reject{|q| q[0]==k[0] || ((q[13].nil? || q[13].length<=0) && (q[14].nil? || q[14].length<=0))}
    for i in 0...chars.length
      x=chars[i]
      unless x[13].nil? || x[13].length<=0 || x[14].nil? || x[14].length<=0
        m=x[13].split(' as ')
        m2=x[14].split(' as ')
        charsx[1].push("#{x[0]} *[Both]*") if m[0]==nammes[2] && m2[0]==nammes[1]
      end
      unless x[14].nil? || x[14].length<=0
        m=x[14].split(' as ')
        charsx[1].push("#{x[0]} *[English]*") if m[0]==nammes[1] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
      unless x[13].nil? || x[13].length<=0
        m=x[13].split(' as ')
        charsx[1].push("#{x[0]} *[Japanese]*") if m[0]==nammes[2] && !charsx[1].include?("#{x[0]} *[Both]*")
      end
    end
    if !k[11].nil? && k[11].include?(' & ')
      m=k[11].split(' & ')
      for i in 0...m.length
        charsx[1].push(@adventurers.reject{|q| q[11]!=m[i]}.map{|q| "#{q[0]} *[English voice #{i+1}]*"}.join("\n"))
        charsx[1].push(@dragons.reject{|q| q[14]!=m[i]}.map{|q| "#{q[0]} *[English voice #{i+1}]*"}.join("\n"))
      end
    end
    if !k[10].nil? && k[10].include?(' & ')
      m=k[10].split(' & ')
      for i in 0...m.length
        charsx[1].push(@adventurers.reject{|q| q[10]!=m[i]}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]} *[Japanese voice #{i+1}]*"}.join("\n"))
        charsx[1].push(@dragons.reject{|q| q[13]!=m[i]}.map{|q| "#{q[0]}#{'.' if q[0]>=2}) #{q[1]} *[Japanese voice #{i+1}]*"}.join("\n"))
      end
    end
    if File.exist?("#{@location}devkit/FEHUnits.txt")
      b=[]
      File.open("#{@location}devkit/FEHUnits.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      b[i][7]=b[i][7].split(';; ')
      if !b[i][7][0].nil? && b[i][7][0].length>0 && !b[i][7][1].nil? && b[i][7][1].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[English]*") if b[i][7][0].split(' as ')[0]==k[11] && b[i][7][1].split(' as ')[0]!=k[10]
        charsx[1].push("*[FEH]* #{b[i][0]} *[Japanese]*") if b[i][7][1].split(' as ')[0]==k[10] && b[i][7][0].split(' as ')[0]!=k[11]
        charsx[1].push("*[FEH]* #{b[i][0]} *[Both]*") if b[i][7][1].split(' as ')[0]==k[10] && b[i][7][0].split(' as ')[0]==k[11]
      elsif !b[i][7][0].nil? && b[i][7][0].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[English]*") if b[i][7][0].split(' as ')[0]==k[11]
      elsif !b[i][7][1].nil? && b[i][7][1].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[Japanese]*") if b[i][7][1].split(' as ')[0]==k[10]
      end
    end
    if event.server.nil? || !bot.user(502288364838322176).on(event.server.id).nil? || @shardizard==4
      if File.exist?("#{@location}devkit/FGOServants.txt")
        b=[]
        File.open("#{@location}devkit/FGOServants.txt").each_line do |line|
          b.push(line)
        end
      else
        b=[]
      end
      for i in 0...b.length
        b[i]=b[i].gsub("\n",'').split('\\'[0])
        unless nammes[2].nil? || nammes[2].length<=0 || b[i][25].nil? || b[i][25].length<=0
          charsx[1].push("*[FGO]* Srv-#{b[i][0]}#{"#{'.' if b[i][0].to_i>=2}) #{b[i][1]}" unless @embedless.include?(event.user.id) || was_embedless_mentioned?(event)} *[Japanese]*") if b[i][25].split(' & ').include?(nammes[2])
        end
      end
    end
    disp='>No information<' if disp.length<=0
  end
  for i in 0...wrm.length
    wrmz.push("#{wrm[i][0]}") if wrm[i][8][0].include?(k[0]) && !wrm[i][8][1].nil? && wrm[i][8][1].include?(k[0])
    wrmz.push("#{wrm[i][0]}") if wrm[i][8][0].include?(k[0]) && wrm[i][8][1].nil?
    wrmz.push("#{wrm[i][0]} *[Base]*") if wrm[i][8][0].include?(k[0]) && !wrm[i][8][1].nil? && !wrm[i][8][1].include?(k[0])
    wrmz.push("#{wrm[i][0]} *[Refined]*") if !wrm[i][8][0].include?(k[0]) && !wrm[i][8][1].nil? && wrm[i][8][1].include?(k[0])
  end
  flds.push(['Wyrmprints with this character',wrmz.join("\n")]) if wrmz.length>0
  flds=nil if flds.length<=0
  if !rar.nil? && rar.is_a?(String)
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Misc/#{k[0].gsub(' ','_')}#{"_#{rar}" unless rar.nil?}.png"
    m=false
    IO.copy_stream(open(art), "#{@location}devkit/DLTemp#{@shardizard}.png") rescue m=true
    if File.size("#{@location}devkit/FGOTemp#{@shardizard}.png")<=100 || m
      rar=nil
    else
      disp="#{disp}\n#{rar} design\n"
    end
  end
  art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Misc/#{k[0].gsub(' ','_')}#{"_#{rar}" unless rar.nil?}.png"
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    disp="#{disp}\n" if charsx.map{|q| q.length}.max>0
    disp="#{disp}\n**Same artist:** #{charsx[0].join(', ')}" if charsx[0].length>0
    if charsx[1].length>0
      disp="#{disp}\n**Same VA:**"
      disp2=""
      c=charsx[1].reject{|q| !q.include?('*[English]*')}.map{|q| q.gsub(' *[English]*','')}
      disp2="#{disp2}\n*English only:* #{c.join(', ')}" if c.length>0
      c=charsx[1].reject{|q| !q.include?('*[Japanese]*')}.map{|q| q.gsub(' *[Japanese]*','')}
      disp2="#{disp2}\n*Japanese only:* #{c.join(', ')}" if c.length>0
      c=charsx[1].reject{|q| !q.include?('*[Both]*')}.map{|q| q.gsub(' *[Both]*','')}
      disp2="#{disp2}\n*Both languages:* #{c.join(', ')}" if c.length>0
      disp2=disp2[1,disp2.length-1]
      if disp2.include?("\n")
        disp="#{disp}\n#{disp2}"
      else
        disp="#{disp} #{disp2}"
      end
    end
    disp="#{disp}\n**Same __everything__:** #{charsx[2].join(', ')}" if charsx[2].length>0
    disp="#{disp}\n**Found in these wyrmprints:** #{wrmz.join(', ')}" if wrmz.length>0
    disp=dispx if disp.length>=1900
    event.respond "#{disp}\n\n#{art}"
  else
    flds=[]
    flds.push(['Same Artist',charsx[0].join("\n")]) if charsx[0].length>0
    if charsx[1].length>0
      if charsx[1].length==charsx[1].reject{|q| !q.include?('*[English]*')}.length
        flds.push(['Same VA (English)',charsx[1].map{|q| q.gsub(' *[English]*','')}.join("\n")])
      elsif charsx[1].length==charsx[1].reject{|q| !q.include?('*[Japanese]*')}.length
        flds.push(['Same VA (Japanese)',charsx[1].map{|q| q.gsub(' *[Japanese]*','')}.join("\n")])
      elsif charsx[1].length==charsx[1].reject{|q| !q.include?('*[Both]*')}.length
        flds.push(['Same VA (Both)',charsx[1].map{|q| q.gsub(' *[Both]*','')}.join("\n")])
      else
        flds.push(['Same VA',charsx[1].join("\n")])
      end
    end
    flds.push(['Same everything',charsx[2].join("\n"),1]) if charsx[2].length>0
    flds.push(['Found in these wyrmprints',wrmz.join("\n")]) if wrmz.length>0
    if flds.length.zero?
      flds=nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1500 && safe_to_spam?(event)
      create_embed(event,"__**#{k[0]}**__#{adv_emoji(k,bot)}",disp,element_color(k[2][1]),nil,[nil,art])
      if flds.map{|q| q.join("\n")}.join("\n\n").length>=1900
        for i in 0...flds.length
          create_embed(event,'','',element_color(k[2][1]),nil,nil,[flds[i]])
        end
      else
        create_embed(event,'','',element_color(k[2][1]),nil,nil,flds)
      end
      return nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1800
      disp="#{disp}\nThe list of units with the same VA is so long that I cannot fit it into a single embed. Please use this command in PM."
      flds=nil
    else
      flds[-1][2]=nil if flds.length<3
      flds[-1].compact!
    end
    create_embed(event,"__**#{k[0]}**__",disp,0xCE456B,nil,[nil,art],flds)
  end
end

def find_the_adventure(bot,event,args=nil,mode=0,allowstr=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  elem=[]
  wpn=[]
  clzz=[]
  fltr=[]
  tags=[]
  genders=[]
  races=[]
  crossgames=[]
  cygames=[]
  launch=false
  mana=false
  share=false
  lookout=get_lookout_tags()
  lookout2=lookout.reject{|q| q[2]!='Race'}
  lookout3=lookout.reject{|q| q[2]!='Cygame'}
  lookout4=lookout.reject{|q| q[2]!='Availability' && q[2]!='Availability/Adventurer'}
  lookout=lookout.reject{|q| q[2]!='Askillity'}
  lookout=lookout.reject{|q| ['Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff','Flame','Water','Wind','Light','Shadow','Attack','Defense','Support','Healer'].include?(q[0])}
  for i in 0...args.length
    launch=true if ['launch'].include?(args[i].downcase)
    mana=true if ['mana','spiral','manaspiral','70','70node','70mc','70ms'].include?(args[i].downcase)
    share=true if ['share','skillshare','shareskill'].include?(args[i].downcase) && allowstr%4<2
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<@max_rarity.max+1 && allowstr%2==0
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<@max_rarity.max+1 && allowstr%2==0
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
    clzz.push('Attack') if ['attack','atk','att','attacking'].include?(args[i].downcase)
    clzz.push('Defense') if ['defense','defence','def','defending','defensive','defencive'].include?(args[i].downcase)
    clzz.push('Support') if ['support','supports','supportive','supporting'].include?(args[i].downcase)
    clzz.push('Healer') if ['heal','healing','heals','healer','healers'].include?(args[i].downcase)
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
    genders.push('M') if ['male','boy','m','males','boys','man'].include?(args[i].downcase)
    genders.push('F') if ['female','woman','girl','f','females','women','girls'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i].downcase)
    end
    for i2 in 0...lookout2.length
      races.push(lookout2[i2][0]) if lookout2[i2][1].include?(args[i].downcase)
    end
    for i2 in 0...lookout3.length
      cygames.push(lookout3[i2][0]) if lookout3[i2][1].include?(args[i].downcase)
    end
    tags.push('StrengthSkill') if ['strength','str'].include?(args[i].downcase) && allowstr
  end
  textra=''
  rarity.uniq!
  elem.uniq!
  wpn.uniq!
  clzz.uniq!
  tags.uniq!
  tags=tags.reject{|q| q=='SP'} if allowstr%4>1
  genders.uniq!
  races.uniq!
  cygames.uniq!
  char=@adventurers.reject{|q| q[0]=='Puppy'}.uniq
  search=[]
  emo=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[1][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{@rarity_stars[0][q]}"}.join(', ')}")
    emo.push(@rarity_stars[0][rarity[0]]) if rarity.length<2
  end
  if elem.length>0
    char=char.reject{|q| !elem.include?(q[2][1])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if wpn.length>0
    char=char.reject{|q| !wpn.include?(q[2][2])}.uniq
    for i in 0...wpn.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[i]}"}
      emo.push(moji[0].mention) if wpn.length<2 && moji.length>0
      wpn[i]="#{moji[0].mention}#{wpn[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn.join(', ')}")
  end
  if clzz.length>0
    char=char.reject{|q| !clzz.include?(q[2][0])}.uniq
    for i in 0...clzz.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{clzz[i].gsub('Healer','Healing')}"}
      emo.push(moji[0].mention) if clzz.length<2 && moji.length>0
      clzz[i]="#{moji[0].mention}#{clzz[i]}" if moji.length>0
    end
    search.push("*Classes*: #{clzz.join(', ')}")
  end
  if launch
    search.push('*Game Launch*')
    b=@banners[0]
    char=char.reject{|q| !b[1].include?(q[0])}
  end
  if mana
    search.push('*<:Rarity_Mana:706612079783575607>Mana Spiral*')
    char=char.reject{|q| q[3][1][@max_rarity[0]].nil? || q[3][1][@max_rarity[0]]<=0 || q[4][1][@max_rarity[0]].nil? || q[4][1][@max_rarity[0]]<=0}
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Seasonal')
      for i in 0...@max_rarity[0]
        m.push("#{i+1}s")
        m.push("#{i+1}f")
      end
      emo.push('(s)') if fltr.length<2
    end
    if fltr.include?('NonLimited')
      for i in 0...@max_rarity[0]
        m.push("#{i+1}")
        m.push("#{i+1}f")
      end
      emo.push('(p)') if fltr.length<2
    end
    if fltr.include?('Collab')
      for i in 0...@max_rarity[0]
        m.push("#{i+1}c")
      end
      emo.push('(c)') if fltr.length<2
    end
    for i2 in 0...lookout4.length
      if fltr.include?(lookout4[i2][0])
        for i in 0...@max_rarity[0]
          m.push("#{i+1}#{lookout4[i2][3]}")
        end
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
      for i in 0...@max_rarity[0]
        m.push("#{i+1}c")
        m.push("#{i+1}s")
        m.push("#{i+1}z")
      end
      emo.push('(L)') if fltr.length<2
      fltr.push('Collab')
    end
    emo.push('(g)') if fltr.length<2 && fltr.include?('Gala')
    char=char.reject{|q| !m.include?(q[1]) && !(fltr.include?('Collab') && !q[12].nil? && q[12].length>0) && !(fltr.include?('Gala') && q[0][0,5]=='Gala ')}.uniq
  end
  if genders.length>0
    char=char.reject{|q| !genders.include?(q[13])}.uniq
    for i in 0...genders.length
      genders[i]='Male' if genders[i]=='M'
      genders[i]='Female' if genders[i]=='F'
      genders[i]='Genderless' if genders[i]=='G'
    end
    search.push("*Genders*: #{genders.join(', ')}")
  end
  if races.length>0
    char=char.reject{|q| !races.include?(q[14])}.uniq
    textra="#{textra}\n\nThis is showing adventurers from the Human race.\nFor enemies from the Human tribe, try `DL!find boss human`." if races.include?('Human')
    search.push("*Races*: #{races.join(', ')}")
  end
  if cygames.length>0
    char=char.reject{|q| !cygames.map{|q2| q2[0]}.include?(q[16])}.uniq
    search.push("*Cygames Origin*: #{cygames.map{|q2| q2[1]}.join(', ')}")
  end
  if crossgames.length>0
    char=char.reject{|q| q[12].nil? || !crossgames.include?(q[12])}.uniq
    for i in 0...crossgames.length
      crossgames[i]='<:Great_Badge_Golden:443704781068959744>Fire Emblem Heroes' if crossgames[i]=='FEH'
      crossgames[i]='<:Bond:613804021119189012>Fate/Grand Order' if crossgames[i]=='FGO'
      crossgames[i]='<:Mega_Man:641484836304846857>Mega Man' if crossgames[i]=='MM'
      crossgames[i]='<:MH_Rathalos:669319247670804506>Monster Hunter' if crossgames[i]=='MH'
    end
    search.push("*Crossover Specifics*: #{crossgames.join(', ')}")
  end
  if tags.length>0 || allowstr%4>1 || share
    if tags.include?('Punisher') && tags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...@punishments.length
        if tags.include?(@punishments[i][0]) && !tags.include?(@punishments[i][1])
          tags.push("#{@punishments[i][1]}")
          tags2.push("#{@punishments[i][0]}")
        end
      end
      if tags2.length>0
        tags=tags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Punisher tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Punisher tag, remove #{mm}.\nTo search for just #{mm}, remove the Punisher tag."
      end
    end
    search.push("<:SkillShare:714597012733034547>*Adventurers with Shareable Skills*") if share
    search.push("*Skill/Ability Tags*: #{tags.join(', ')}") unless tags.length<=0
    sklz=@askilities.map{|q| q}
    for i in 0...char.length
      skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==char[i][6][0]}
      skl1=sklz[skl1] unless skl1.nil?
      skl2=sklz.find_index{|q| q[2]=='Skill' && q[0]==char[i][6][1]}
      skl2=sklz[skl2] unless skl2.nil?
      if allowstr%4<2
        coab=sklz.find_index{|q| q[2]=='CoAbility' && q[0]==char[i][7][0].split(' ')[0,char[i][7][0].split(' ').length-1].join(' ')}
        coab=sklz[coab] unless coab.nil?
        coab[6]=[] if !coab.nil? && coab[6].nil?
        cha=sklz.find_index{|q| q[2]=='Chain' && q[0]==char[i][7][1].split(' ')[0,char[i][7][1].split(' ').length-1].join(' ')}
        cha=sklz[cha] unless cha.nil?
        cha[6]=[] if !cha.nil? && cha[6].nil?
        ab1=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][8][0][-1]}
        ab1=sklz[ab1] unless ab1.nil?
        ab1[6]=[] if !ab1.nil? && ab1[6].nil?
        ab2=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][8][1][-1]}
        ab2=sklz[ab2] unless ab2.nil?
        ab2[6]=[] if !ab2.nil? && ab2[6].nil?
        ab3=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][8][2][-1]}
        ab3=sklz[ab3] unless ab3.nil?
        ab3[6]=[] if !ab3.nil? && ab3[6].nil?
      else
        coab=nil
        cha=nil
        ab1=nil
        ab2=nil
        ab3=nil
        skl1=nil unless !skl1.nil? && !skl1[12].nil? && skl1[12].length>0 && skl1[12].max>0
        skl2=nil unless !skl2.nil? && !skl2[12].nil? && skl2[12].length>0 && skl2[12].max>0
      end
      char[i][20]="#{skl1[10].join("\n") unless skl1.nil?}\n#{skl2[10].join("\n") unless skl2.nil?}\n#{coab[6].join("\n") unless coab.nil?}\n#{cha[6].join("\n") unless cha.nil?}\n#{ab1[6].join("\n") unless ab1.nil?}\n#{ab2[6].join("\n") unless ab2.nil?}\n#{ab3[6].join("\n") unless ab3.nil?}".split("\n")
      char[i][20]='~~reject me~~' if share && (skl1.nil? || skl1[12].nil? || skl1[12].length<=0 || skl1[12].max<=0) && (skl2.nil? || skl2[12].nil? || skl2[12].length<=0 || skl2[12].max<=0)
      if (args.include?('any') || tags.length==1) && tags.length>0
        x=[[],[],[],[]]
        x[0].push('1') if !skl1.nil? && has_any?(tags,skl1[10])
        x[0].push('2') if !skl2.nil? && has_any?(tags,skl2[10])
        x[1].push('o') if !coab.nil? && has_any?(tags,coab[6])
        x[2].push('o') if !cha.nil? && has_any?(tags,cha[6])
        x[3].push('1') if !ab1.nil? && has_any?(tags,ab1[6])
        x[3].push('2') if !ab2.nil? && has_any?(tags,ab2[6])
        x[3].push('3') if !ab3.nil? && has_any?(tags,ab3[6])
        x[0]="S#{x[0].join('/')}" if x[0].length>0
        x[1]='Co' if x[1].length>0
        x[2]='Ch' if x[2].length>0
        x[3]="A#{x[3].join('/')}" if x[3].length>0
        x=x.reject{|q| q.length<=0}
        x.compact!
        char[i][0]="#{char[i][0]} *[#{x.join('+')}]*" if x.length>0
      elsif share || allowstr%4>1
        x=[]
        x.push('1') unless skl1.nil? || skl1[12].nil? || skl1[12].length<=0 || skl1[12].max<=0
        x.push('2') unless skl2.nil? || skl2[12].nil? || skl2[12].length<=0 || skl2[12].max<=0
        char[i][0]="#{char[i][0]} *[S#{x.join('/')}]*" if x.length>0
      end
    end
    char=char.reject{|q| q[20]=='~~reject me~~'}
    if tags.length<=0
    elsif args.include?('any')
      search[-1]="#{search[-1]}\n(searching for adventurers with any listed tag in their skills and abilities)" if tags.length>1
      char=char.reject{|q| !has_any?(tags,q[20])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for adventurers with all listed tags in their skills and abilities)" if tags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for adventurers with all listed tags.\nTo search for adventurers with any of the listed tags, perform the search again with the word \"any\" in your message." if tags.length>1
      for i in 0...tags.length
        char=char.reject{|q| !q[20].include?(tags[i])}.uniq
      end
    end
  end
  for i in 0...char.length
    char[i][0]="~~#{char[i][0]}~~" if char[i][1].length>1 && char[i][1][1,1]=='-' && char[i][0].include?('*')
    char[i][0]="*#{char[i][0]}*" if char[i][1].length>1 && char[i][1][1,1]=='-' && !char[i][0].include?('*')
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_the_dragon(bot,event,args=nil,mode=0,allowstr=true)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  t=Time.now
  timeshift=7
  timeshift-=1 unless t.dst?
  t-=60*60*timeshift
  rarity=[]
  elem=[]
  fltr=[]
  wday=[]
  wpn=[]
  turn=[]
  ranged=[]
  tags=[]
  genders=[]
  cygames=[]
  crossgames=[]
  races=[]
  launch=false
  lookout=get_lookout_tags()
  lookout2=lookout.reject{|q| q[2]!='Cygame'}
  lookout4=lookout.reject{|q| q[2]!='Availability' && q[2]!='Availability/Dragon'}
  lookout5=lookout.reject{|q| q[2]!='Race'}
  lookout=lookout.reject{|q| q[2]!='Askillity'}
  lookout=lookout.reject{|q| ['Flame','Water','Wind','Light','Shadow'].include?(q[0])}
  for i in 0...args.length
    launch=true if ['launch'].include?(args[i].downcase)
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<@max_rarity.max+1
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<@max_rarity.max+1
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
    wpn.push('Share') if ['share','skillshare','shareskill'].include?(args[i].downcase)
    wday.push(1) if ['mo','monday','mondae','mon','m','juicymeat','meat'].include?(args[i].downcase)
    wday.push(2) if ['tu','tuesday','tuesdae','tues','tue','t','kaleidoscope','kscope','k-scope'].include?(args[i].downcase)
    wday.push(3) if ['we','wednesday','wednesdae','wednes','wed','w','floralcirclet','flower','floral','circlet','circle'].include?(args[i].downcase)
    wday.push(4) if ['th','thursday','thursdae','thurs','thu','thur','h','r','compellingbook','book'].include?(args[i].downcase)
    wday.push(5) if ['fr','friday','fridae','fri','fryday','frydae','fry','f','manaessence','mana','essence'].include?(args[i].downcase)
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
    genders.push('M') if ['male','boy','m','males','boys','man'].include?(args[i].downcase)
    genders.push('F') if ['female','woman','girl'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i].downcase)
    end
    for i2 in 0...lookout5.length
      races.push(lookout5[i2][0]) if lookout5[i2][1].include?(args[i].downcase)
    end
    races.push('Spiralian') if ['mana','spiral','manaspiral','70','70node','70mc','70ms'].include?(args[i].downcase)
    for i2 in 0...lookout2.length
      cygames.push(lookout2[i2][0]) if lookout2[i2][1].include?(args[i].downcase)
    end
    tags.push('StrengthSkill') if ['strength','str'].include?(args[i].downcase) && allowstr
  end
  textra=''
  rarity.uniq!
  elem.uniq!
  wpn.uniq!
  wday.uniq!
  turn.uniq!
  ranged.uniq!
  races.uniq!
  fltr.uniq!
  tags.uniq!
  cygames.uniq!
  char=@dragons.reject{|q| q[0]=='Puppy'}.uniq
  search=[]
  emo=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[1][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{@rarity_stars[0][q]}"}.join(', ')}")
    emo.push(@rarity_stars[0][rarity[0]]) if rarity.length<2
  end
  if elem.length>0
    char=char.reject{|q| !elem.include?(q[2])}.uniq
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
    b=@banners[0]
    char=char.reject{|q| !b[2].include?(q[0])}
  end
  if wday.length>0
    char=char.reject{|q| !wday.include?(q[9])}.uniq
    wday=wday.map{|q| ['Golden Chalice (Sunday)','Juicy Meat (Monday)','Kaleidoscope (Tuesday)','Floral Circlet (Wednesday)','Compelling Book (Thursday)','Mana Essence (Friday)','Golden Chalice (Saturday)'][q]}
    search.push("*Bond gift preference*: #{wday.join(', ')}")
  end
  if turn.length>0
    char=char.reject{|q| !turn.include?(q[10])}.uniq
    for i in 0...turn.length
      turn[i]='Turned to damage direction' if turn[i]=='Yes'
      turn[i]='Not turned to damage direction' if turn[i]=='No'
    end
    search.push("*Turn data*: #{turn.join(', ')}")
  end
  if ranged.length>0
    char=char.reject{|q| !ranged.include?(q[11])}.uniq
    for i in 0...ranged.length
      ranged[i]='Long' if ranged[i]=='Yes'
      ranged[i]='Short' if ranged[i]=='No'
    end
    search.push("*Range*: #{ranged.join(', ')}")
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Seasonal')
      for i in 0...@max_rarity[1]
        m.push("#{i+1}s")
        m.push("#{i+1}f")
      end
      emo.push('(s)') if fltr.length<2
    end
    if fltr.include?('NonLimited')
      for i in 0...@max_rarity[1]
        m.push("#{i+1}")
        m.push("#{i+1}f")
      end
      emo.push('($)') if fltr.length<2
    end
    if fltr.include?('Collab')
      for i in 0...@max_rarity[1]
        m.push("#{i+1}c")
      end
      emo.push('(c)') if fltr.length<2
    end
    for i2 in 0...lookout4.length
      if fltr.include?(lookout4[i2][0])
        for i in 0...@max_rarity[0]
          m.push("#{i+1}#{lookout4[i2][3]}")
        end
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
      for i in 0...@max_rarity[0]
        m.push("#{i+1}c")
        m.push("#{i+1}s")
        m.push("#{i+1}z")
      end
      emo.push('(L)') if fltr.length<2
      fltr.push('Collab')
    end
    char=char.reject{|q| !m.include?(q[1]) && !(fltr.include?('Collab') && !q[16].nil? && q[16].length>0) && !(fltr.include?('Gala') && q[0][0,5]=='Gala ')}.uniq
  end
  if genders.length>0
    char=char.reject{|q| !genders.include?(q[17])}.uniq
    for i in 0...genders.length
      genders[i]='Male' if genders[i]=='M'
      genders[i]='Female' if genders[i]=='F'
      genders[i]='Genderless' if genders[i]=='G'
    end
    search.push("*Genders*: #{genders.join(', ')}")
  end
  if cygames.length>0
    char=char.reject{|q| !cygames.map{|q2| q2[0]}.include?(q[18])}.uniq
    search.push("*Cygames Origin*: #{cygames.map{|q2| q2[1]}.join(', ')}")
  end
  if crossgames.length>0
    char=char.reject{|q| q[16].nil? || !crossgames.include?(q[16])}.uniq
    for i in 0...crossgames.length
      crossgames[i]='<:Great_Badge_Golden:443704781068959744>Fire Emblem Heroes' if crossgames[i]=='FEH'
      crossgames[i]='<:Bond:613804021119189012>Fate/Grand Order' if crossgames[i]=='FGO'
      crossgames[i]='<:Mega_Man:641484836304846857>Mega Man' if crossgames[i]=='MM'
      crossgames[i]='<:MH_Rathalos:669319247670804506>Monster Hunter' if crossgames[i]=='MH'
    end
    search.push("*Crossover Specifics*: #{crossgames.join(', ')}")
  end
  if tags.length>0
    if tags.include?('Punisher') && tags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...@punishments.length
        if tags.include?(@punishments[i][0]) && !tags.include?(@punishments[i][1])
          tags.push("#{@punishments[i][1]}")
          tags2.push("#{@punishments[i][0]}")
        end
      end
      if tags2.length>0
        tags=tags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Punisher tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Punisher tag, remove #{mm}.\nTo search for just #{mm}, remove the Punisher tag."
      end
    end
    search.push("*Skill/Ability Tags*: #{tags.join(', ')}")
    sklz=@askilities.map{|q| q}
    for i in 0...char.length
      skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==char[i][5][0]}
      skl1=sklz[skl1] unless skl1.nil?
      skl2=sklz.find_index{|q| q[2]=='Skill' && q[0]==char[i][5][1]}
      skl2=sklz[skl2] unless skl2.nil?
      ab1=nil
      ab1=sklz.find_index{|q| ['Ability','Aura'].include?(q[2]) && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][6][0][-1]} unless char[i][6].length<1
      ab1=sklz[ab1] unless ab1.nil?
      ab1[6]=[] if !ab1.nil? && ab1[6].nil?
      ab2=nil
      ab2=sklz.find_index{|q| ['Ability','Aura'].include?(q[2]) && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][6][1][-1]} unless char[i][6].length<2
      ab2=sklz[ab2] unless ab2.nil?
      ab2[6]=[] if !ab2.nil? && ab2[6].nil?
      ab3=nil
      ab3=sklz.find_index{|q| ['Ability','Aura'].include?(q[2]) && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][6][2][-1]} unless char[i][6].length<3
      ab3=sklz[ab3] unless ab3.nil?
      ab3[6]=[] if !ab3.nil? && ab3[6].nil?
      if args.include?('any') || tags.length<=1
        x=[[],[],[]]
        x[0].push('1') if !skl1.nil? && has_any?(tags,skl1[10])
        x[2].push('1') if !ab1.nil? && has_any?(tags,ab1[6])
        x[2].push('2') if !ab2.nil? && has_any?(tags,ab2[6])
        x[2].push('3') if !ab3.nil? && has_any?(tags,ab3[6])
        x[0]="S" if x[0].length>0
        x[1]='Co' if x[1].length>0
        x[2]="A#{x[2].join('/')}" if x[2].length>0
        x=x.reject{|q| q.length<=0}
        x.compact!
        char[i][0]="#{char[i][0]} *[#{x.join('+')}]*" if x.length>0
      end
      char[i][20]="#{skl1[10].join("\n") unless skl1.nil?}\n#{skl2[10].join("\n") unless skl2.nil?}\n#{ab1[6].join("\n") unless ab1.nil?}\n#{ab2[6].join("\n") unless ab2.nil?}\n#{ab3[6].join("\n") unless ab3.nil?}".split("\n")
    end
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for dragons with any listed tag in their skills and abilities)" if tags.length>1
      char=char.reject{|q| !has_any?(tags,q[20])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for dragons with all listed tags in their skills and abilities)" if tags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for dragons with all listed tags.\nTo search for dragons with any of the listed tags, perform the search again with the word \"any\" in your message." if tags.length>1
      for i in 0...tags.length
        char=char.reject{|q| !q[20].include?(tags[i])}.uniq
      end
    end
  end
  return nil if races.length>0 && search.length<=0 && mode%4>1
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_the_printer(bot,event,args=nil,mode=0,allowstr=true)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  clzz=[]
  fltr=[]
  crossgames=[]
  launch=false
  tags=[]
  lookout=get_lookout_tags()
  lookout4=lookout.reject{|q| q[2]!='Availability' && q[2]!='Availability/Wyrmprint'}
  lookout=lookout.reject{|q| q[2]!='Askillity'}
  lookout=lookout.reject{|q| ['Attack','Defense','Support','Healer'].include?(q[0])}
  ign=false
  for i in 0...args.length
    launch=true if ['launch'].include?(args[i].downcase)
    ign=true if ['share','skillshare','shareskill'].include?(args[i].downcase)
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<@max_rarity.max+1
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<@max_rarity.max+1
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
    for i2 in 0...lookout.length
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i].downcase)
    end
  end
  textra=''
  rarity.uniq!
  clzz.uniq!
  fltr.uniq!
  tags.uniq!
  char=@wyrmprints.reject{|q| ['Wily Warriors','Greatwyrm'].include?(q[0])}.uniq
  search=[]
  emo=[]
  char=[] if ign
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[1][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{@rarity_stars[0][q]}"}.join(', ')}")
    emo.push(@rarity_stars[0][rarity[0]]) if rarity.length<2
  end
  if clzz.length>0
    char=char.reject{|q| !clzz.include?(q[2])}.uniq
    for i in 0...clzz.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{clzz[i]}"}
      emo.push(moji[0].mention) if clzz.length<2 && moji.length>0
      clzz[i]="#{moji[0].mention}#{clzz[i]}" if moji.length>0
    end
    search.push("*Amulet Types*: #{clzz.join(', ')}")
  end
  if launch
    search.push('*Game Launch*')
    b=@banners[0]
    char=char.reject{|q| !b[3].include?(q[0])}
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Seasonal')
      for i in 0...@max_rarity[2]
        m.push("#{i+1}s")
        m.push("#{i+1}f")
      end
      emo.push('(s)') if fltr.length<2
    end
    if fltr.include?('NonLimited')
      for i in 0...@max_rarity[2]
        m.push("#{i+1}")
        m.push("#{i+1}f")
      end
      emo.push('(u)') if fltr.length<2
    end
    if fltr.include?('Collab')
      for i in 0...@max_rarity[2]
        m.push("#{i+1}c")
      end
      emo.push('(c)') if fltr.length<2
    end
    for i2 in 0...lookout4.length
      if fltr.include?(lookout4[i2][0])
        for i in 0...@max_rarity[0]
          m.push("#{i+1}#{lookout4[i2][3]}")
        end
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
      for i in 0...@max_rarity[0]
        m.push("#{i+1}c")
        m.push("#{i+1}s")
        m.push("#{i+1}z")
      end
      emo.push('(L)') if fltr.length<2
      fltr.push('Collab')
    end
    char=char.reject{|q| !m.include?(q[1]) && !(fltr.include?('Collab') && !q[10].nil? && q[10].length>0)}.uniq
  end
  if crossgames.length>0
    char=char.reject{|q| q[10].nil? || !crossgames.include?(q[10])}.uniq
    for i in 0...crossgames.length
      crossgames[i]='<:Great_Badge_Golden:443704781068959744>Fire Emblem Heroes' if crossgames[i]=='FEH'
      crossgames[i]='<:Bond:613804021119189012>Fate/Grand Order' if crossgames[i]=='FGO'
      crossgames[i]='<:Mega_Man:641484836304846857>Mega Man' if crossgames[i]=='MM'
      crossgames[i]='<:MH_Rathalos:669319247670804506>Monster Hunter' if crossgames[i]=='MH'
    end
    search.push("*Crossover Specifics*: #{crossgames.join(', ')}")
  end
  if tags.length>0
    if tags.include?('Punisher') && tags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...@punishments.length
        if tags.include?(@punishments[i][0]) && !tags.include?(@punishments[i][1])
          tags.push("#{@punishments[i][1]}")
          tags2.push("#{@punishments[i][0]}")
        end
      end
      if tags2.length>0
        tags=tags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Punisher tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Punisher tag, remove #{mm}.\nTo search for just #{mm}, remove the Punisher tag."
      end
    end
    search.push("*Skill/Ability Tags*: #{tags.join(', ')}")
    sklz=@askilities.map{|q| q}
    for i in 0...char.length
      ab1=nil
      ab1=sklz.find_index{|q| ['Ability'].include?(q[2]) && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][5][0][-1]} unless char[i][5].length<1
      ab1=sklz[ab1] unless ab1.nil?
      ab1[6]=[] if !ab1.nil? && ab1[6].nil?
      ab2=nil
      ab2=sklz.find_index{|q| ['Ability'].include?(q[2]) && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][5][1][-1]} unless char[i][5].length<2
      ab2=sklz[ab2] unless ab2.nil?
      ab2[6]=[] if !ab2.nil? && ab2[6].nil?
      ab3=nil
      ab3=sklz.find_index{|q| ['Ability'].include?(q[2]) && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][5][2][-1]} unless char[i][5].length<3
      ab3=sklz[ab3] unless ab3.nil?
      ab3[6]=[] if !ab3.nil? && ab3[6].nil?
      if args.include?('any') || tags.length<=1
        x=[[],[],[]]
        x[2].push('1') if !ab1.nil? && has_any?(tags,ab1[6])
        x[2].push('2') if !ab2.nil? && has_any?(tags,ab2[6])
        x[2].push('3') if !ab3.nil? && has_any?(tags,ab3[6])
        x[0]="S" if x[0].length>0
        x[1]='Co' if x[1].length>0
        x[2]="A#{x[2].join('/')}" if x[2].length>0
        x=x.reject{|q| q.length<=0}
        x.compact!
        char[i][0]="#{char[i][0]} *[#{x.join('+')}]*" if x.length>0
      end
      char[i][20]="#{ab1[6].join("\n") unless ab1.nil?}\n#{ab2[6].join("\n") unless ab2.nil?}\n#{ab3[6].join("\n") unless ab3.nil?}".split("\n")
    end
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for wyrmprints with any listed tag in their abilities)" if tags.length>1
      char=char.reject{|q| !has_any?(tags,q[20])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for wyrmprints with all listed tags in their abilities)" if tags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for wyrmprints with all listed tags.\nTo search for wyrmprints with any of the listed tags, perform the search again with the word \"any\" in your message." if tags.length>1
      for i in 0...tags.length
        char=char.reject{|q| !q[20].include?(tags[i])}.uniq
      end
    end
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_the_stick(bot,event,args=nil,mode=0,allowstr=true,juststats=false)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  tier=[]
  rarity_tier=[]
  rarity_tier_2=[]
  elem=[]
  wpn=[]
  fltr=[]
  tags=[]
  crossgames=[]
  launch=false
  lookout=get_lookout_tags()
  lookout3=lookout.reject{|q| q[2]!='Availability' && q[2]!='Availability/Weapon'}
  lookout=lookout.reject{|q| q[2]!='Askillity'}
  lookout=lookout.reject{|q| ['Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff','Flame','Water','Wind','Light','Shadow'].include?(q[0])}
  args2=args.map{|q| q}
  ign=false
  for i in 0...args.length
    launch=true if ['launch'].include?(args[i].downcase)
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<@max_rarity.max+1
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<@max_rarity.max+1
    tier.push(args[i][1,args[i].length-1].to_i) if args[i][0,1].downcase=='t' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0 && args[i][1,args[i].length-1].to_i<4
    tier.push(args[i][4,args[i].length-4].to_i) if ['tier','teir'].include?(args[i][0,4].downcase) && args[i][4,args[i].length-4].to_i.to_s==args[i][4,args[i].length-4] && args[i][4,args[i].length-4].to_i>0 && args[i][4,args[i].length-4].to_i<4
    rarity_tier.push(args[i].downcase) if args[i][1,1]=='t' && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<6 && args[i][2,args[i].length-2].to_i.to_s==args[i][2,args[i].length-2] && args[i][2,args[i].length-2].to_i>0 && args[i][2,args[i].length-2].to_i<4
    rarity_tier_2.push('HDT1') if ['hdt1','hd1'].include?(args[i].downcase)
    rarity_tier_2.push('HDT2') if ['hdt2','hd2'].include?(args[i].downcase)
    rarity_tier_2.push('HDT3') if ['hdt3','hd3'].include?(args[i].downcase)
    rarity_tier_2.push('ChT1') if ['ct1','chm1','cht1'].include?(args[i].downcase)
    rarity_tier_2.push('ChT2') if ['ct2','chm2','cht2'].include?(args[i].downcase)
    rarity_tier_2.push('ChT3') if ['ct3','chm3','cht3'].include?(args[i].downcase)
    rarity_tier_2.push('AGT1') if ['agito1','agt1'].include?(args[i].downcase)
    rarity_tier_2.push('AGT2') if ['agito2','agt2'].include?(args[i].downcase)
    rarity_tier_2.push('AGT3') if ['agito3','agt3'].include?(args[i].downcase)
    ign=true if ['share','skillshare','shareskill'].include?(args[i].downcase)
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
      for i2 in 0...lookout.length
        tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
      end
      tags.push('StrengthSkill') if ['strength','str'].include?(args[i].downcase) && allowstr
    end
  end
  args2.compact!
  textra=''
  rarity.uniq!
  tier.uniq!
  rarity_tier.uniq!
  elem.uniq!
  wpn.uniq!
  fltr.uniq!
  tags.uniq!
  char=@weapons.map{|q| q}.uniq
  search=[]
  emo=[]
  char=[] if ign
  if rarity.length>0 || tier.length>0 || rarity_tier.length>0 || rarity_tier_2.length>0
    if rarity.length>0
      search.push("*Rarities*: #{rarity.map{|q| "#{q}#{@rarity_stars[0][q]}"}.join(', ')}")
      emo.push(@rarity_stars[0][rarity[0]]) if rarity.length==1
    elsif tier.length>0
      rarity=[1,2,3,4,5]
    end
    if tier.length>0
      search.push("*Crafting Tiers*: #{tier.join(', ')}")
      emo.push("T#{tier[0]}") if tier.length==1
    elsif rarity.length>0
      tier=[0,1,2,3]
    end
    search.push("*Combined Rarity/Tiers*: #{rarity_tier.map{|q| "#{q[0,1]}#{@rarity_stars[0][q[0,1].to_i]}-T#{q[2,1]}"}.join(', ') if rarity_tier.length>0}#{', ' if rarity_tier.length>0 && rarity_tier_2.length>0}#{rarity_tier_2.map{|q| "#{'High Dragon' if q[0,3]=='HDT'}#{'Chimeratech' if q[0,3]=='ChT'}#{'Agito' if q[0,3]=='AGT'}-T#{q[3,1]}"}.join(', ')}") if rarity_tier.length>0 || rarity_tier_2.length>0
    for i in 0...rarity.length
      for i2 in 0...tier.length
        rarity_tier.push("#{rarity[i]}t#{tier[i2]}")
      end
    end
    rarity_tier.uniq!
    char2=[]
    char2=char.reject{|q| !rarity_tier_2.include?("HDT#{q[16]}") || q[2][1,1]!='h'}.uniq if rarity_tier_2.length>0
    char3=[]
    char3=char.reject{|q| !rarity_tier_2.include?("ChT#{q[16]}") || q[2][1,1]!='m'}.uniq if rarity_tier_2.length>0
    char4=[]
    char4=char.reject{|q| !rarity_tier_2.include?("AGT#{q[16]}") || q[2][1,1]!='a'}.uniq if rarity_tier_2.length>0
    char=char.reject{|q| !rarity_tier.include?("#{q[2][0,1]}t#{q[16]}")}.uniq
    for i in 0...char2.length
      char.push(char2[i])
    end
    for i in 0...char3.length
      char.push(char3[i])
    end
    for i in 0...char4.length
      char.push(char4[i])
    end
  end
  if wpn.length>0
    char=char.reject{|q| !wpn.include?(q[1])}.uniq
    for i in 0...wpn.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[i]}"}
      emo.push(moji[0].mention) if wpn.length<2 && moji.length>0
      wpn[i]="#{moji[0].mention}#{wpn[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn.join(', ')}")
  end
  if elem.length>0
    char=char.reject{|q| !elem.include?(q[3])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if launch
    search.push('*Game Launch*')
    char=char.reject{|q| q[8].to_i<8 || q[8].to_i>211}
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Seasonal')
      for i in 0...@max_rarity[3]
        m.push("#{i+1}s")
        m.push("#{i+1}f")
      end
      emo.push('(s)') if fltr.length<2
    end
    for i2 in 0...lookout3.length
      if fltr.include?(lookout3[i2][0])
        for i in 0...@max_rarity[3]
          m.push("#{i+1}#{lookout3[i2][3]}")
        end
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
    if fltr.include?('Core')
      for i in 0...@max_rarity[3]
        m.push("#{i+1}")
      end
      emo.push('(c)') if fltr.length<2
    end
    if fltr.include?('Collab')
      for i in 0...@max_rarity[3]
        m.push("#{i+1}c")
      end
      emo.push('(clb)') if fltr.length<2
    end
    if fltr.include?('Former')
      for i in 0...@max_rarity[0]
        m.push("#{i+1}f")
      end
      emo.push('(f)') if fltr.length<2
    end
    search.push("*Filters*: #{fltr.map{|q| q.gsub('Void','<:Element_Void:548467446734913536> Void')}.join(', ')}")
    if fltr.include?('Limited')
      for i in 0...@max_rarity[0]
        m.push("#{i+1}c")
        m.push("#{i+1}s")
        m.push("#{i+1}z")
      end
      emo.push('(L)') if fltr.length<2
      fltr.push('Collab')
    end
    char=char.reject{|q| !m.include?(q[2]) && !(fltr.include?('Collab') && !q[14].nil? && q[14].length>0)}.uniq
  end
  if crossgames.length>0
    char=char.reject{|q| q[14].nil? || !crossgames.include?(q[14])}.uniq
    for i in 0...crossgames.length
      crossgames[i]='<:Great_Badge_Golden:443704781068959744>Fire Emblem Heroes' if crossgames[i]=='FEH'
      crossgames[i]='<:Bond:613804021119189012>Fate/Grand Order' if crossgames[i]=='FGO'
      crossgames[i]='<:Mega_Man:641484836304846857>Mega Man' if crossgames[i]=='MM'
      crossgames[i]='<:MH_Rathalos:669319247670804506>Monster Hunter' if crossgames[i]=='MH'
    end
    search.push("*Crossover Specifics*: #{crossgames.join(', ')}")
  end
  if tags.length>0
    if tags.include?('Punisher') && tags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...@punishments.length
        if tags.include?(@punishments[i][0]) && !tags.include?(@punishments[i][1])
          tags.push("#{@punishments[i][1]}")
          tags2.push("#{@punishments[i][0]}")
        end
      end
      if tags2.length>0
        tags=tags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Punisher tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Punisher tag, remove #{mm}.\nTo search for just #{mm}, remove the Punisher tag."
      end
    end
    search.push("*Skill/Ability Tags*: #{tags.join(', ')}")
    sklz=@askilities.reject{|q| q[2]!='Skill'}
    for i in 0...char.length
      skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==char[i][6]}
      skl1=sklz[skl1] unless skl1.nil?
      ab1=nil
      ab2=nil
      ab3=nil
      unless char[i][13].nil?
        ab1=sklz.find_index{|q| ['Ability'].include?(q[2]) && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][13][0][-1]} unless char[i][13].length<1
        ab1=sklz[ab1] unless ab1.nil?
        ab1[6]=[] if !ab1.nil? && ab1[6].nil?
        ab2=sklz.find_index{|q| ['Ability'].include?(q[2]) && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][13][1][-1]} unless char[i][13].length<2
        ab2=sklz[ab2] unless ab2.nil?
        ab2[6]=[] if !ab2.nil? && ab2[6].nil?
        ab3=sklz.find_index{|q| ['Ability'].include?(q[2]) && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==char[i][13][2][-1]} unless char[i][13].length<3
        ab3=sklz[ab3] unless ab3.nil?
        ab3[6]=[] if !ab3.nil? && ab3[6].nil?
      end
      if args.include?('any') || tags.length<=1
        x=[[],[],[]]
        x[0].push('3') if !skl1.nil? && has_any?(tags,skl1[10])
        x[2].push('1') if !ab1.nil? && has_any?(tags,ab1[6])
        x[2].push('2') if !ab2.nil? && has_any?(tags,ab2[6])
        x[2].push('3') if !ab3.nil? && has_any?(tags,ab3[6])
        x[0]="S#{x[0].join('/')}" if x[0].length>0
        x[1]='Co' if x[1].length>0
        x[2]="A#{x[2].join('/')}" if x[2].length>0
        x=x.reject{|q| q.length<=0}
        x.compact!
        char[i][0]="#{char[i][0]} *[#{x.join('+')}]*" if x.length>0
      end
      char[i][20]="#{skl1[10].join("\n") unless skl1.nil?}\n#{ab1[6].join("\n") unless ab1.nil?}\n#{ab2[6].join("\n") unless ab2.nil?}\n#{ab3[6].join("\n") unless ab3.nil?}".split("\n")
    end
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for weapons with any listed tag in their skills and abilities)" if tags.length>1
      char=char.reject{|q| !has_any?(tags,q[20])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for weapons with all listed tags in their skills and abilities)" if tags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for weapons with all listed tags.\nTo search for weapons with any of the listed tags, perform the search again with the word \"any\" in your message." if tags.length>1
      for i in 0...tags.length
        char=char.reject{|q| !q[20].include?(tags[i])}.uniq
      end
    end
  end
  if !juststats && find_data_ex(:find_enemy,args2.join(' '),event).length>0 && find_data_ex(:find_enemy,args2.join(' '),event)[0][0,8]!='Mega Man'
    args2=args2.reject{|q| q.to_i.to_s==q || q.gsub('*','').to_i.to_s==q.gsub('*','')}
    k2=find_data_ex(:find_enemy,args2.join(' '),event)
    unless k2.nil? || k2.length<=0
      search.push("*Uses Mats from:* #{enemy_emoji(k2,bot)}#{k2[0]}")
      char=char.reject{|q| q[15].nil? || q[15]!=k2[0]}
    end
  end
  if juststats
    return nil if char.uniq.length>=@weapons.uniq.length
    return char
  elsif (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def fac_stats(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  kxx=find_data_ex(:find_facility,args.join(' '),event)
  if kxx.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  k=kxx[0]
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  s2s=false if evn.include?('totals')
  s2s=false if evn.include?('total')
  str=''
  title=''
  title="**Type:** #{k[3][0]} #{"(#{k[3][1]})" if k[3].length>1}"
  title="#{title}\n**Size:** #{k[4]}"
  title="#{title}\n**Final Level:** #{kxx.length}" if kxx.length>1
  title="#{title}\n**Quantity available:** #{k[5]}"
  str="#{str}\n\n**Description:** #{k[2]}"
  m='t'
  m='Amber' if ['Staff Dojo'].include?(k[0])
  m='Azure' if ['Blade Dojo','Lance Dojo'].include?(k[0])
  m='Jade' if ['Axe Dojo','Wand Dojo'].include?(k[0])
  m='Vermillion' if ['Sword Dojo','Bow Dojo'].include?(k[0])
  m='Violet' if ['Dagger Dojo'].include?(k[0])
  str="#{str}\n\n**First Dojo cost:** Dyrenell Aes x10\n**Second Dojo cost:** Dyrenell Aes x30, Dyrenell Argenteus x10, #{k[0].split(' ')[0]} Tablet x2" if k[3]==['Adventurer', 'Dojo']
  if k[3]==['Adventurer', 'Altar']
    if k[0]=='Flame Altar'
      str="#{str}\n\n**First Altar becomes available at:** Player Level#{' (PL)' if s2s} 1\n**Second Altar becomes available at:** Player Level 40"
      str="#{str}\n\nBy default can only go to Level 10\nCan reach Level 15 at PL 12\nCan reach Level 20 at PL 24\nCan reach Level 25 at PL 37\nCan reach Level 30 at PL 67" if s2s
    elsif k[0]=='Wind Altar'
      str="#{str}\n\n**First Altar becomes available at:** Player Level#{' (PL)' if s2s} 4\n**Second Altar becomes available at:** Player Level 45"
      str="#{str}\n\nBy default can only go to Level 10\nCan reach Level 15 at PL 14\nCan reach Level 20 at PL 26\nCan reach Level 25 at PL 40\nCan reach Level 30 at PL 70" if s2s
    elsif k[0]=='Water Altar'
      str="#{str}\n\n**First Altar becomes available at:** Player Level#{' (PL)' if s2s} 6\n**Second Altar becomes available at:** Player Level 50"
      str="#{str}\n\nBy default can only go to Level 10\nCan reach Level 15 at PL 16\nCan reach Level 20 at PL 28\nCan reach Level 25 at PL 43\nCan reach Level 30 at PL 73" if s2s
    elsif k[0]=='Shadow Altar'
      str="#{str}\n\n**First Altar becomes available at:** Player Level#{' (PL)' if s2s} 8\n**Second Altar becomes available at:** Player Level 55"
      str="#{str}\n\nBy default can only go to Level 10\nCan reach Level 15 at PL 18\nCan reach Level 20 at PL 30\nCan reach Level 25 at PL 46\nCan reach Level 30 at PL 76" if s2s
    elsif k[0]=='Light Altar'
      str="#{str}\n\n**First Altar becomes available at:** Player Level#{' (PL)' if s2s} 10\n**Second Altar becomes available at:** Player Level 60"
      str="#{str}\n\nBy default can only go to Level 10\nCan reach Level 15 at PL 20\nCan reach Level 20 at PL 32\nCan reach Level 25 at PL 49\nCan reach Level 30 at PL 79" if s2s
    end
  elsif k[0]=='Fafnir Statue (Flame)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Flame:532106087952810005>High Brunhilda's Trial\n**Cost:** Flamewyrm's Greatsphere x30, Talonstone x10"
  elsif k[0]=='Fafnir Statue (Water)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Water:532106088221376522>High Mercury's Trial\n**Cost:** Waterwyrm's Greatsphere x30, Talonstone x10"
  elsif k[0]=='Fafnir Statue (Wind)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Wind:532106087948746763>High Midgardsormr's Trial\n**Cost:** Windwyrm's Greatsphere x30, Talonstone x10"
  elsif k[0]=='Fafnir Statue (Light)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Light:532106088129101834>High Jupiter's Trial\n**Cost:** Lightwyrm's Greatsphere x30, Talonstone x10"
  elsif k[0]=='Fafnir Statue (Shadow)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Shadow:532106088154267658>High Zodiark's Trial\n**Cost:** Shadowwyrm's Greatsphere x30, Talonstone x10"
  elsif k[0]=='Smithy' && !s2s
    str="#{str}\n\nLevel 1-3 Smithies can craft #{generate_rarity_row(3)} weapons"
    str="#{str}\nLevel 4-6 Smithies can craft #{generate_rarity_row(4)} weapons"
    str="#{str}\nLevel 7-9 Smithies can craft #{generate_rarity_row(5)} weapons"
    str="#{str}\nLevel 9 Smithies can craft #{generate_rarity_row(6)} weapons"
    str="#{str}\nEach new level of smithy allows you to craft higher-tier weapons within the newest-allowed rarity bracket."
  end
  ftr=nil
  ftr='Use this command in PM to see the costs to upgrade this facility.' unless s2s
  dispname=k[0].gsub(' ','_')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Facilities/#{dispname}.png?raw=true"
  create_embed(event,["__**#{k[0]}**__",title],str,0x8BE3F7,ftr,xpic)
  str=''
  ftr=nil
  return nil if ['Smithy','Halidom'].include?(k[0]) && !safe_to_spam?(event)
  if k[0]=='Smithy'
    str="__**Can craft #{generate_rarity_row(3)} weapons**__"
    str="#{str}\n*Level 1 \u2192 2:* 1,000<:Resource_Rupies:532104504372363274> - ~~no mats~~"
    str="#{str}\n*Level 2 \u2192 3:* 5,000<:Resource_Rupies:532104504372363274> - Light Metal x3"
    str="#{str}\n\n__**Can craft #{generate_rarity_row(4)} weapons**__"
    str="#{str}\n*Level 3 \u2192 4:* 20,000<:Resource_Rupies:532104504372363274> - Iron Ore x10, Fiend's Claw x10, Bat's Wing x10"
    str="#{str}\n*Level 4 \u2192 5:* 40,000<:Resource_Rupies:532104504372363274> - Iron Ore x15, Fiend's Claw x15, Bat's Wing x15, Light Metal x15"
    str="#{str}\n*Level 5 \u2192 6:* 60,000<:Resource_Rupies:532104504372363274> - Granite x10, Fiend's Horn x10, Ancient Bird's Feather x10"
    str="#{str}\n\n__**Can craft #{generate_rarity_row(5)} weapons**__"
    str="#{str}\n*Level 6 \u2192 7:* 80,000<:Resource_Rupies:532104504372363274> - Granite x15, Fiend's Horn x15, Ancient Bird's Feather x15, Abyss Stone x15"
    str="#{str}\n*Level 7 \u2192 8:* 100,000<:Resource_Rupies:532104504372363274> - Meteorite x10, Fiend's Eye x10, Bewitching Wings x10"
    str="#{str}\n*Level 8 \u2192 9:* 120,000<:Resource_Rupies:532104504372363274> - Meteorite x15, Fiend's Eye x15, Bewitching Wings x15, Crimson Core x15"
    str="#{str}\n\n__**Can craft #{generate_rarity_row(6)} weapons**__"
    str="#{str}\n*Level 9*"
    ftr='Each new level of smithy allows you to craft higher-tier weapons within the newest-allowed rarity bracket.'
  elsif k[0]=='Halidom'
    str="__*Level 1 \u2192 2*__\nRequires Facility level of 5\n5,000<:Resource_Rupies:532104504372363274>"
    str="#{str}\n\n__*Level 2 \u2192 3*__\nRequires Facility level of 40\n20,000<:Resource_Rupies:532104504372363274>\n<:Element_Wind:532106087948746763>Wind Orb x10, Storm Orb x1, Talonstone x3"
    str="#{str}\n\n__*Level 3 \u2192 4*__\nRequires Facility level of 100\n50,000<:Resource_Rupies:532104504372363274>\n<:Element_Water:532106088221376522>Water Orb x20, Stream Orb x3, Deluge Orb x1, Talonstone x5"
    str="#{str}\n\n__*Level 4 \u2192 5*__\nRequires Facility level of 200\n100,000<:Resource_Rupies:532104504372363274>\n<:Element_Flame:532106087952810005>Flame Orb x50, Blaze Orb x7, Inferno Orb x2, Talonstone x10"
    str="#{str}\n\n__*Level 5 \u2192 6*__\nRequires Facility level of 300\n150,000<:Resource_Rupies:532104504372363274>\n<:Element_Light:532106088129101834>Light Orb x100, Radiance Orb x15, Refulgence Orb x3, Talonstone x15"
    str="#{str}\n\n__*Level 6 \u2192 7*__\nRequires Facility level of 400\n200,000<:Resource_Rupies:532104504372363274>\n<:Element_Shadow:532106088154267658>Shadow Orb x150, Nightfall Orb x20, Nether Orb x4, Talonstone x20"
    str="#{str}\n\n__*Level 7 \u2192 8*__\nRequires Facility level of 550\n250,000<:Resource_Rupies:532104504372363274>\n<:Element_Wind:532106087948746763>Wind Orb x200, Storm Orb x25, Maelstrom Orb x6, Talonstone x25"
    str="#{str}\n\n__*Level 8 \u2192 9*__\nRequires Facility level of 700\n300,000<:Resource_Rupies:532104504372363274>\n<:Element_Water:532106088221376522>Water Orb x300, Stream Orb x40, Deluge Orb x9, Talonstone x30"
    str="#{str}\n\n__*Level 9 \u2192 10*__\nRequires Facility level of 850\n350,000<:Resource_Rupies:532104504372363274>\n<:Element_Flame:532106087952810005>Flame Orb x400, Blaze Orb x80, Inferno Orb x20, Rainbow Orb x40, Talonstone x50"
  else
    nums=[]
    val=0
    minmax=false
    for i in 0...args.length
      if args[i].to_i.to_s==args[i] && args[i].to_i>0
        if nums.length<2
          nums.push(args[i].to_i)
        elsif val<=0
          val=args[i].to_i
        end
      elsif args[i][0,1].downcase=='x' && args[i][1,args[i].length-1].to_i.to_s==args[i][1,args[i].length-1] && args[i][1,args[i].length-1].to_i>0
        val=args[i][1,args[i].length-1].to_i if val<=0
      elsif ['min','max','maximum','minimum'].include?(args[i].downcase)
        minmax=true
      end
    end
    nums=[] if minmax
    val=1 if val<=0
    str="**Amounts shown are for #{val} copies of this facility.**\n" unless val==1
    if nums.length<=0
      mtz=[]
      cost=0
      for i in 0...kxx.length
        cost+=kxx[i][6]
        if s2s && !minmax
          str="#{str}\nCreation: #{longFormattedNumber(kxx[i][6]*val)}<:Resource_Rupies:532104504372363274>" if i==0
          str="#{str}\nLevel #{i} \u2192 #{i+1}: #{longFormattedNumber(kxx[i][6]*val)}<:Resource_Rupies:532104504372363274>" unless i==0
        end
        unless kxx[i][7].nil?
          for i2 in 0...kxx[i][7].length
            mtz.push(kxx[i][7][i2])
          end
          str="#{str} - #{kxx[i][7].map{|q| "#{q[0]} x#{q[1].to_i*val}"}.sort.join(', ')}" if s2s && !minmax
        end
        if minmax && i>0
        elsif !s2s && !minmax
        elsif ['Dual Altar','Event Dual Altar','Dual Dojo','Event Dual Dojo'].include?(k[3][1])
          alta=[(i+1)/2,i/2]
          alta[0]*=0.3
          alta[1]*=0.3
          alta[0]+=0.5
          alta[1]+=0.5
          alta[1]+=0.3 if i>=29
          str="#{str}\nLevel #{i+1}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
        elsif k[3][1]=='Tree'
          alta=[i+2.0,i+2.0]
          if i<9
            x=i/4
            alta=[x*3.0+3.0,x*3.0+3.0]
            if i%4>0
              alta[0]+=1.0
              alta[1]+=0.5
            end
            if i%4>1
              alta[1]+=1.0
              alta[0]+=0.5
            end
            if i%4>2
              alta[0]+=1.0
              alta[1]+=0.5
            end
          end
          str="#{str}\nLevel #{i+1}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
        elsif k[3][1]=='Altar'
          alta=[(i+1)/2,i/2]
          alta=[i-17,i-17] if i>34
          alta=alta.map{|q| q*0.5+0.5}
          str="#{str}\nLevel #{i+1}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
        elsif ['Dojo','Fafnir'].include?(k[3][1])
          alta=[(i+1)/2,i/2]
          alta=alta.map{|q| q*0.5+3.0}
          for i2 in 0...((i+1)/15+1)
            if i>15*i2+14 && i2%2==0
              alta[0]+=1+i2
              alta[1]+=1.5+i2
            elsif i>15*i2+14 && i2%2==1
              alta[0]+=1.5+i2
              alta[1]+=1+i2
            end
          end
          str="#{str}\nLevel #{i+1}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
        elsif k[3][1]=='Event Altar'
          alta=[(i+1)/2,i/2]
          alta=alta.map{|q| q*0.5}
          alta[0]+=1
          str="#{str}\nLevel #{i+1}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
        end
      end
      str=str.gsub('Level 1:','**Initial Buff:**') if minmax
      mtzz=mtz.map{|q| q[0]}.uniq.sort
      str3="TOTAL: #{longFormattedNumber(cost*val)}<:Resource_Rupies:532104504372363274> - "
      for i in 0...mtzz.length
        str3="#{str3}#{', ' unless i==0}#{mtzz[i]} x#{mtz.reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i*val}.inject(0){|sum,x| sum + x }}"
      end
      if ['Dual Altar','Event Dual Altar','Dual Dojo','Event Dual Dojo'].include?(k[3][1])
        alta=[(kxx.length)/2,(kxx.length-1)/2]
        alta=alta.map{|q| q*0.3+0.5}
        alta[1]+=0.3 if kxx.length>=30
        str3="#{str3}**\n**FINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Tree'
        alta=[kxx.length+1.0,kxx.length+1.0]
        if (kxx.length-1)<9
          x=(kxx.length-1)/4
          alta=[x*3.0+3.0,x*3.0+3.0]
          if (kxx.length-1)%4>0
            alta[0]+=1.0
            alta[1]+=0.5
          end
          if (kxx.length-1)%4>1
            alta[1]+=1.0
            alta[0]+=0.5
          end
          if (kxx.length-1)%4>2
            alta[0]+=1.0
            alta[1]+=0.5
          end
        end
        str3="#{str3}**\n**FINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Altar'
        alta=[kxx.length/2,(kxx.length-1)/2]
        alta=[kxx.length-18,kxx.length-18] if kxx.length>34
        alta=alta.map{|q| q*0.5+0.5}
        str3="#{str3}**\n**FINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif ['Dojo','Fafnir'].include?(k[3][1])
        alta=[kxx.length/2,(kxx.length-1)/2]
        alta=alta.map{|q| q*0.5+3.0}
        for i2 in 0...(kxx.length/15+1)
          if kxx.length%15==0 && i2*15+15==kxx.length
          elsif kxx.length>15*i2+14 && i2%2==0
            alta[0]+=1+i2
            alta[1]+=1.5+i2
          elsif kxx.length>15*i2+14 && i2%2==1
            alta[0]+=1.5+i2
            alta[1]+=1+i2
          end
        end
        str3="#{str3}**\n**FINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Event Altar'
        alta=[kxx.length/2,(kxx.length-1)/2]
        alta=alta.map{|q| q*0.5}
        alta[0]+=1
        str3="#{str3}**\n**FINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      end
      str="#{str}\n\n**#{str3}**"
    elsif nums.length==1
      n=[nums[0],kxx.length].min
      mtz=[[],[]]
      cost=[0,0]
      for i in 0...kxx.length
        cost[0]+=kxx[i][6]*val if i<n
        cost[1]+=kxx[i][6]*val unless i<n
        unless kxx[i][7].nil?
          for i2 in 0...kxx[i][7].length
            mtz[0].push(kxx[i][7][i2]) if i<n
            mtz[1].push(kxx[i][7][i2]) unless i<n
          end
        end
      end
      str3="**Total from level 1 to #{n}:** #{longFormattedNumber(cost[0])}<:Resource_Rupies:532104504372363274>"
      mtzz=mtz[0].map{|q| q[0]}.uniq.sort
      for i in 0...mtzz.length
        str3="#{str3}#{' - ' if i==0}#{', ' unless i==0}#{mtzz[i]} x#{mtz[0].reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i*val}.inject(0){|sum,x| sum + x }}"
      end
      if ['Dual Altar','Event Dual Altar','Dual Dojo','Event Dual Dojo'].include?(k[3][1])
        alta=[(n)/2,(n-1)/2]
        alta.map{|q| q*0.3+0.5}
        alta[1]+=0.3 if n>=30
        str3="#{str3}\nBuffs at Level #{n}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Altar'
        alta=[(n)/2,(n-1)/2]
        alta=[n-18,n-18] if n>34
        alta=alta.map{|q| q*0.5+0.5}
        str3="#{str3}\nBuffs at Level #{n}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Tree'
        alta=[n+1.0,n+1.0]
        if (n-1)<9
          x=(n-1)/4
          alta=[x*3.0+3.0,x*3.0+3.0]
          if (n-1)%4>0
            alta[0]+=1.0
            alta[1]+=0.5
          end
          if (n-1)%4>1
            alta[1]+=1.0
            alta[0]+=0.5
          end
          if (n-1)%4>2
            alta[0]+=1.0
            alta[1]+=0.5
          end
        end
        str3="#{str3}\nBuffs at Level #{n}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif ['Dojo','Fafnir'].include?(k[3][1])
        alta=[(n)/2,(n-1)/2]
        alta=alta.map{|q| q*0.5+3.0}
        for i2 in 0...(kxx.length/15+1)
          if n>15*i2+14 && i2%2==0
            alta[0]+=1+i2
            alta[1]+=1.5+i2
          elsif n>15*i2+14 && i2%2==1
            alta[0]+=1.5+i2
            alta[1]+=1+i2
          end
        end
        str3="#{str3}\nBuffs at Level #{n}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Event Altar'
        alta=[(n)/2,(n-1)/2]
        alta=alta.map{|q| q*0.5}
        alta[0]+=1
        str3="#{str3}\nBuffs at Level #{n}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      end
      str="#{str}\n\n#{str3}" unless n==1
      str3="**Total from level #{n} to #{kxx.length}:** #{longFormattedNumber(cost[1])}<:Resource_Rupies:532104504372363274>"
      mtzz=mtz[1].map{|q| q[0]}.uniq.sort
      for i in 0...mtzz.length
        str3="#{str3}#{' - ' if i==0}#{', ' unless i==0}#{mtzz[i]} x#{mtz[1].reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i*val}.inject(0){|sum,x| sum + x }}"
      end
      if ['Dual Altar','Event Dual Altar','Dual Dojo','Event Dual Dojo'].include?(k[3][1])
        alta=[(kxx.length)/2,(kxx.length-1)/2]
        alta.map{|q| q*0.3+0.5}
        alta[1]+=0.3 if kxx.length>=30
        str3="#{str3}\nFINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Altar'
        alta=[kxx.length/2,(kxx.length-1)/2]
        alta=[kxx.length-18,kxx.length-18] if kxx.length>34
        alta=alta.map{|q| q*0.5+0.5}
        str3="#{str3}\nFINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Tree'
        alta=[kxx.length+1.0,kxx.length+1.0]
        if (kxx.length-1)<9
          x=(kxx.length-1)/4
          alta=[x*3.0+3.0,x*3.0+3.0]
          if (kxx.length-1)%4>0
            alta[0]+=1.0
            alta[1]+=0.5
          end
          if (kxx.length-1)%4>1
            alta[1]+=1.0
            alta[0]+=0.5
          end
          if (kxx.length-1)%4>2
            alta[0]+=1.0
            alta[1]+=0.5
          end
        end
        str3="#{str3}\nFINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif ['Dojo','Fafnir'].include?(k[3][1])
        alta=[kxx.length/2,(kxx.length-1)/2]
        alta=alta.map{|q| q*0.5+3.0}
        for i2 in 0...(kxx.length/15+1)
          if kxx.length>15*i2+14 && i2%2==0
            alta[0]+=1+i2
            alta[1]+=1.5+i2
          elsif kxx.length>15*i2+14 && i2%2==1
            alta[0]+=1.5+i2
            alta[1]+=1+i2
          end
        end
        str3="#{str3}\nFINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Event Altar'
        alta=[kxx.length/2,(kxx.length-1)/2]
        alta=alta.map{|q| q*0.5}
        alta[0]+=1
        str3="#{str3}\nFINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      end
      str="#{str}\n\n#{str3}" unless n==kxx.length
    else
      n=[nums[0,2].min,1].max
      n=1 if n>kxx.length
      n2=[nums[0,2].max,kxx.length].min
      mtz=[]
      cost=0
      kxx=kxx[n,n2-n]
      for i in 0...kxx.length
        cost+=kxx[i][6]
        str="#{str}\nLevel #{n+i} \u2192 #{n+i+1}: #{longFormattedNumber(kxx[i][6]*val)}<:Resource_Rupies:532104504372363274>" if s2s
        unless kxx[i][7].nil?
          for i2 in 0...kxx[i][7].length
            mtz.push(kxx[i][7][i2])
          end
          str="#{str} - #{kxx[i][7].map{|q| "#{q[0]} x#{q[1].to_i*val}"}.sort.join(', ')}" if s2s
        end
      end
      mtzz=mtz.map{|q| q[0]}.uniq.sort
      str3="TOTAL from level #{n} to #{n2}: #{longFormattedNumber(cost*val)}<:Resource_Rupies:532104504372363274> - "
      for i in 0...mtzz.length
        str3="#{str3}#{', ' unless i==0}#{mtzz[i]} x#{mtz.reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i*val}.inject(0){|sum,x| sum + x }}"
      end
      if ['Dual Altar','Event Dual Altar','Dual Dojo','Event Dual Dojo'].include?(k[3][1])
        alta=[(n2)/2,(n2-1)/2]
        alta.map{|q| q*0.3+0.5}
        alta[1]+=0.3 if n2>=30
        str3="#{str3}\nBuffs at Level #{n2}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Altar'
        alta=[(n2)/2,(n2-1)/2]
        alta=[n2-18,n2-18] if n2>34
        alta=alta.map{|q| q*0.5+0.5}
        str3="#{str3}\nBuffs at Level #{n2}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Tree'
        alta=[n2+1.0,n2+1.0]
        if (n2-1)<9
          x=(n2-1)/4
          alta=[x*3.0+3.0,x*3.0+3.0]
          if (n2-1)%4>0
            alta[0]+=1.0
            alta[1]+=0.5
          end
          if (n2-1)%4>1
            alta[1]+=1.0
            alta[0]+=0.5
          end
          if (n2-1)%4>2
            alta[0]+=1.0
            alta[1]+=0.5
          end
        end
        str3="#{str3}\nBuffs at Level #{n2}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif ['Dojo','Fafnir'].include?(k[3][1])
        alta=[(n2)/2,(n2-1)/2]
        alta=alta.map{|q| q*0.5+3.0}
        for i2 in 0...(kxx.length/15+1)
          if n2>15*i2+14 && i2%2==0
            alta[0]+=1+i2
            alta[1]+=1.5+i2
          elsif n2>15*i2+14 && i2%2==1
            alta[0]+=1.5+i2
            alta[1]+=1+i2
          end
        end
        str3="#{str3}\nBuffs at Level #{n2}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      elsif k[3][1]=='Event Altar'
        alta=[(n2)/2,(n2-1)/2]
        alta=alta.map{|q| q*0.5}
        alta[0]+=1
        str3="#{str3}\nBuffs at Level #{n2}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      end
      str="#{str}\n\n**#{str3}**"
    end
  end
  str=str.gsub("\n\n","\n") if minmax
  if str.length>=1900
    str=str.split("\n")
    str2=''
    for i in 0...str.length
      if "#{str2}\n#{str[i]}".length>=1900
        create_embed(event,'',str2,0x8BE3F7,ftr)
        str2=str[i]
      else
        str2="#{str2}\n#{str[i]}"
      end
    end
    create_embed(event,'',str2,0x8BE3F7,ftr)
  else
    create_embed(event,'',str,0x8BE3F7,ftr) if str.length>0
  end
end

def damage_modifiers(bot,event,args=nil)
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
  end
  m=[0,'First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth','Tenth','Eleventh','Twelfth','Thirteenth','Fourteenth','Fifteenth','16th',
     '17th','18th','19th','20th','21st','22nd','23rd','24th','25th','26th','27th','28th','29th','30th','31st','32nd','33rd','34th','35th','36th','37th','38th',
     '39th','40th','41st','42nd','43rd','44th','45th','46th','47th','48th','49th','50th']
  if wpn.length<=0
    k=find_data_ex(:find_adventurer,args.join(' '),event)
    kx=find_data_ex(:find_adventurer,args.join(' '),event,true)
    xk=find_data_ex(:find_dragon,args.join(' '),event,true)
    if k.nil? || k.length<=0 || (!xk.nil? && xk.length>0 && (kx.nil? || kx.length<=0))
      k=find_data_ex(:find_dragon,args.join(' '),event)
      if k.nil? || k.length<=0
        k=find_data_ex(:find_weapon,args.join(' '),event)
        unless k.nil? || k.length<=0
          wpn.push(k[1])
          k=nil
        end
      else
        if k[19].nil? || k[19].length<=0
          event.respond "**#{k[0]}**#{dragon_emoji(k,bot)} does not have any damage modifiers stored."
          return nil
        end
        for i in 0...k[19].length
          for i2 in 1...k[19][i].length
            k[19][i][i2]="#{k[19][i][i2]}%" unless k[19][i][i2].is_a?(String) && k[19][i][i2].to_i.to_s != k[19][i][i2]
            k[19][i][i2]="*#{m[i2]} Hit:* #{k[19][i][i2]}"
          end
        end
        f=nil
        disp=''
        if k[19].length==1
          disp=k[19][0][1,k[19][0].length-1].join("\n")
        else
          f=[]
          for i in 0...k[19].length
            f.push(k[19][i][0],k[19][i][1,k[19][i].length-1].join("\n"))
          end
        end
        dispname=k[0].gsub(' ','_')
        xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Dragons/#{dispname}.png?raw=true"
        create_embed(event,"__Damage modifiers for **#{k[0]}#{dragon_emoji(k,bot)}**__",disp,element_color(k[2]),nil,xpic,f)
        return nil
      end
    elsif k[0]=='Puppy'
      kx=find_data_ex(:find_dragon,args.join(' '),event)
      if k[19].length==1
        if k[19][0].length>3
          ff=[]
          for i2 in 1...k[19][0].length-2
            ff.push("*#{m[i2]} Hit:* #{k[19][0][i2]}#{'%' if k[19][0][i2].to_i.to_s==k[19][0][i2]}")
          end
          ff.push("\n**Dash Attack:** #{k[19][0][-2]}#{'%' if k[19][0][-2].to_i.to_s==k[19][0][-2]}")
          ff.push("\n**Force Strike:** #{k[19][0][-1]}#{'%' if k[19][0][-1].to_i.to_s==k[19][0][-1]}")
          disp=ff.join("\n")
        else
          disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
        end
      else
        disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
      end
      for i in 0...kx[19].length
        for i2 in 1...kx[19][i].length
          kx[19][i][i2]="#{k[19][i][i2]}%" unless kx[19][i][i2].is_a?(String) && kx[19][i][i2].to_i.to_s != kx[19][i][i2]
          kx[19][i][i2]="*#{m[i2]} Hit:* #{kx[19][i][i2]}"
        end
      end
      disp2=kx[19][0][1,kx[19][0].length-1].join("\n")
      create_embed(event,"__Damage modifiers for **#{k[0]}#{adv_emoji(k,bot)}**__",'',element_color(k[2][1]),nil,xpic,[['Adventurer',disp],['Dragon',disp2]])
      return nil
    elsif !k[19].nil? && k[19].length>0
      f=[]
      k2=[1,2,3,4,5,6,7]
      k2=[90,95,114,120,180,95,'104% L1, 115% L2'] if k[2][2]=='Sword'
      k2=[106.7,106.7,'69.3% x2',141.9,'157.3% x2',94,"83% L1, 92% L2"] if k[2][2]=='Blade'
      k2=[90,'45.5% x2','64.8% x2',142.8,180,85,"43.2% x3 L1, 47% x3 L2"] if k[2][2]=='Dagger'
      k2=[125.4,134.2,224.4,237.6,250.8,73,"173% L1, 192% L2"] if k[2][2]=='Axe'
      k2=[92.4,'49.5% x2',118.8,165,123.2,89,"27% x5 L1, 30% x5 L2"] if k[2][2]=='Lance'
      k2=['36.35% x3','46.25% x2','52.5% x3','78.75% x2','42.75% x5','30% x3',"28% x8 L1, 31% x8 L2"] if k[2][2]=='Bow'
      k2=[112.7,'60.95% x2','41.4% x3','89.7% x2','71.07% x1 + 41.4575% x4',100,"81% x2 L1, 90% x2 L2"] if k[2][2]=='Wand'
      k2=[82.8,96,'54% x2',180,235.2,80,"55% x4 L1, 61% x4 L2"] if k[2][2]=='Staff'
      if k[19].length==1
        if ['Dash','DA'].include?(k[19][0][0])
          k2[5]=k[19][0][-1]
        else
          k2[6]=k[19][0][-1]
          k2[5]=k[19][0][-2] if k[19][0].length>2
        end
      end
      for i in 0...k2.length
        k2[i]="#{k2[i]}%" unless k2[i].is_a?(String) && k2[i].to_i.to_s != k2[i]
      end
      if k[19].length==1
        if k[19][0].length>3
          ff=[]
          for i2 in 1...k[19][0].length-2
            ff.push("*#{m[i2]} Hit:* #{k[19][0][i2]}#{'%' if k[19][0][i2].to_i.to_s==k[19][0][i2]}")
          end
          ff.push("\n**Dash Attack:** #{k[19][0][-2]}#{'%' if k[19][0][-2].to_i.to_s==k[19][0][-2]}")
          ff.push("\n**Force Strike:** #{k[19][0][-1]}#{'%' if k[19][0][-1].to_i.to_s==k[19][0][-1]}")
          disp=ff.join("\n")
        else
          disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
        end
      else
        disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
      end
      if k[19].length>1
        for i in 0...k[19].length
          if k[19][i].length>1
            ff=["__**Combo**__"]
            for i2 in 1...k[19][i].length-2
              ff.push("*#{m[i2]} Hit:* #{k[19][i][i2]}#{'%' if k[19][i][i2].to_i.to_s==k[19][i][i2]}")
            end
            ff.push("\n**Dash Attack:** #{k[19][i][-2]}#{'%' if k[19][i][i2].to_i.to_s==k[19][i][i2]}") unless k[19][i][-2].to_s.gsub('%','')==k2[5].to_s.gsub('%','')
            ff.push("\n**Force Strike:** #{k[19][i][-1]}#{'%' if k[19][i][i2].to_i.to_s==k[19][i][i2]}") unless k[19][i][-1].to_s.gsub('%','')==k2[6].to_s.gsub('%','')
            if k[19][i][0][0,1]=='*' && i==0
              disp=ff.join("\n")
              k2[5]=k[19][i][-2]
              k2[6]=k[19][i][-1]
            else
              f.push([k[19][i][0],ff.join("\n")])
            end
          end
        end
      else
        f=nil
      end
      dispname=k[0].gsub(' ','_')
      xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Adventurers/#{dispname}_#{k[1][0,1]}.png?raw=true"
      create_embed(event,"__Damage modifiers for **#{k[0]}#{adv_emoji(k,bot)}**__",disp,element_color(k[2][1]),nil,xpic,f)
      return nil
    else
      wpn.push(k[2][2])
      k=nil
    end
  end
  if wpn.length<=0 && !safe_to_spam?(event)
    event.respond "The complete table is too large.  Please either specify a weapon type or use this command in PM."
  elsif wpn.length<=0
    kx=[[90,95,114,120,180,95,"104% L1, 115% L2"],
        [106.7,106.7,'69.3% x2',141.9,'157.3% x2',94,"83% L1, 92% L2"],
        [90,'45.5% x2','64.8% x2',142.8,180,85,"43.2% x3 L1, 47% x3 L2"],
        [125.4,134.2,224.4,237.6,250.8,73,"173% L1, 192% L2"],
        [92.4,'49.5% x2',118.8,165,123.2,89,"27% x5 L1, 30% x5 L2"],
        ['36.35% x3','46.25% x2','52.5% x3','78.75% x2','42.75% x5','30% x3',"28% x8 L1, 31% x8 L2"],
        [112.7,'60.95% x2','41.4% x3','89.7% x2','71.07% x1 + 41.4575% x4',100,"81% x2 L1, 90% x2 L2"],
        [82.8,96,'54% x2',180,235.2,80,"55% x4 L1, 61% x4 L2"]]
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
    create_embed(event,"__**Damage modifiers**__",'',0xCE456B,nil,nil,f)
  else
    k=[1,2,3,4,5,6,7]
    k=[90,95,114,120,180,95,"104% L1, 115% L2"] if wpn[0]=='Sword'
    k=[106.7,106.7,'69.3% x2',141.9,'157.3% x2',94,"83% L1, 92% L2"] if wpn[0]=='Blade'
    k=[90,'45.5% x2','64.8% x2',142.8,180,85,"43.2% x3 L1, 47% x3 L2"] if wpn[0]=='Dagger'
    k=[125.4,134.2,224.4,237.6,250.8,73,"173% L1, 192% L2"] if wpn[0]=='Axe'
    k=[92.4,'49.5% x2',118.8,165,123.2,89,"27% x5 L1, 30% x5 L2"] if wpn[0]=='Lance'
    k=['36.35% x3','46.25% x2','52.5% x3','78.75% x2','42.75% x5','30% x3',"28% x8 L1, 31% x8 L2"] if wpn[0]=='Bow'
    k=[112.7,'60.95% x2','41.4% x3','89.7% x2','71.07% x1 + 41.4575% x4',100,"81% x2 L1, 90% x2 L2"] if wpn[0]=='Wand'
    k=[82.8,96,'54% x2',180,235.2,80,"55% x4 L1, 61% x4 L2"] if wpn[0]=='Staff'
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

def sp_table(bot,event,args=nil)
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
  end
  if wpn.length<=0
    k=find_data_ex(:find_adventurer,args.join(' '),event)
    if k.nil? || k.length<=0
      k=find_data_ex(:find_weapon,args.join(' '),event)
      unless k.nil? || k.length<=0
        wpn.push(k[1])
        k=nil
      end
    elsif !k[18].nil? && k[18].length>0
      f=[]
      m=[0,'First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth','Tenth','Eleventh','Twelfth','Thirteenth','Fourteenth','Fifteenth',
         '16th','17th','18th','19th','20th','21st','22nd','23rd','24th','25th','26th','27th','28th','29th','30th','31st','32nd','33rd','34th','35th','36th',
         '37th','38th','39th','40th','41st','42nd','43rd','44th','45th','46th','47th','48th','49th','50th']
      k2=[1,2,3,4,5,6,7]
      k2=[150,150,196,265,391,143,345,1152] if k[2][2]=='Sword'
      k2=[130,130,220,360,900,104,200,1740] if k[2][2]=='Blade'
      k2=[144,144,264,288,480,132,288,1128] if k[2][2]=='Dagger'
      k2=[200,240,360,380,420,160,300,1600] if k[2][2]=='Axe'
      k2=[120,240,120,480,600,111,400,1560] if k[2][2]=='Lance'
      k2=[184,92,276,414,529,208,460,1495] if k[2][2]=='Bow'
      k2=[130,200,240,430,600,156,400,1600] if k[2][2]=='Wand'
      k2=[232,232,348,464,696,300,580,1972] if k[2][2]=='Staff'
      if k[18].length==1
        if ['Dash','DA'].include?(k[18][0][0])
          k2[5]=k[18][0][-1]
        else
          k2[6]=k[18][0][-1]
          k2[5]=k[18][0][-2] if k[18][0].length>2
        end
        if k[18][0].length>3
          ff=[]
          t=0
          for i2 in 1...k[18][0].length-2
            ff.push("*#{m[i2]} Hit:* #{k[18][0][i2]}")
            if k[18][0][i2].to_i.to_s==k[18][0][i2] && t>=0
              t+=k[18][0][i2].to_i
            else
              t=-1
            end
          end
          if t<0
            ff.push("~~*Total cannot be calculated dynamically*~~")
          else
            ff.push("\u30FC *Total:* #{t}")
          end
          ff.push("\n**Dash Attack:** #{k[18][0][-2]}")
          ff.push("\n**Force Strike:** #{k[18][0][-1]}")
          disp=ff.join("\n")
        else
          disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\u30FC *Total: #{k2[7]}*\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
        end
      else
        disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n\u30FC *Total: #{k2[7]}*\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
      end
      if k[18].length>1
        for i in 0...k[18].length
          if k[18][i].length>1
            ff=[]
            t=0
            for i2 in 1...k[18][i].length-2
              ff.push("*#{m[i2]} Hit:* #{k[18][i][i2]}")
              if k[18][i][i2].to_i.to_s==k[18][i][i2] && t>=0
                t+=k[18][i][i2].to_i
              else
                t=-1
              end
            end
            if t<0
              ff.push("~~*Total cannot be calculated dynamically*~~")
            else
              ff.push("\u30FC *Total:* #{t}")
            end
            ff.push("\n**Dash Attack:** #{k[18][i][-2]}") unless k[18][i][-2].to_i==k2[5]
            ff.push("\n**Force Strike:** #{k[18][i][-1]}") unless k[18][i][-1].to_i==k2[6]
            if k[18][i][0][0,1]=='*' && i==0
              disp=ff.join("\n")
              k2[5]=k[18][i][-2]
              k2[6]=k[18][i][-1]
            else
              f.push([k[18][i][0],ff.join("\n")])
            end
          end
        end
      else
        f=nil
      end
      dispname=k[0].gsub(' ','_')
      xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Adventurers/#{dispname}_#{k[1][0,1]}.png?raw=true"
      create_embed(event,"__SP gains for **#{k[0]}#{adv_emoji(k,bot)}**__",disp,element_color(k[2][1]),nil,xpic,f)
      return nil
    else
      wpn.push(k[2][2])
      k=nil
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
        '<:Weapon_Wand:532106114985099264>Wands','<:Weapon_Staff:532106114733441024>Staves']
    f=[]
    for i in 0...k.length
      f.push([k2[i],k[i]])
    end
    create_embed(event,"__**SP gains**__",'',0xCE456B,nil,nil,f)
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

def adv_mats(event,args,bot,forcespiral=false)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_adventurer,args.join(' '),event,false,false,true)
  if k.length>0
    elems=['flame','fire','flames','fires','water','waters','wind','air','winds','airs','light','lights','shadow','dark','shadows','darks']
    if event.user.id==192821228468305920
      elems.push('earth')
      elems.push('earths')
    end
    if elems.include?(k[1].downcase)
      k=[]
    else
      k=k[0]
    end
  end
  elem=''
  name=''
  nums=[]
  mana=false
  euden=false
  xpic=nil
  if k.length.zero?
    mana=true if forcespiral
  else
    name=k[0]
    elem=k[2][1]
    nums.push(k[1][0,1].to_i)
    mana=true unless k[3][1][@max_rarity[0]].nil? || k[3][1][@max_rarity[0]]<=0 || k[4][1][@max_rarity[0]].nil? || k[4][1][@max_rarity[0]]<=0
    euden=true if k[0]=='Euden'
    dispname=k[0].gsub(' ','_')
    xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Adventurers/#{dispname}_#{k[1][0,1]}.png?raw=true"
  end
  for i in 0...args.length
    elem='Flame' if ['flame','fire','flames','fires'].include?(args[i].downcase) && elem.length<=0
    elem='Water' if ['water','waters'].include?(args[i].downcase) && elem.length<=0
    elem='Wind' if ['wind','air','winds','airs'].include?(args[i].downcase) && elem.length<=0
    elem='Wind' if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920 && elem.length<=0
    elem='Light' if ['light','lights'].include?(args[i].downcase) && elem.length<=0
    elem='Shadow' if ['shadow','dark','shadows','darks'].include?(args[i].downcase) && elem.length<=0
    nums.push(args[i].to_i) if args[i].to_i.to_s==args[i]
  end
  if nums.length<=0 || elem.length<=0
    event.respond "You need either an element and a rarity, or an adventurer name."
    return nil
  elsif forcespiral && !mana
    event.respond "This adventurer does not have a mana spiral."
    return nil
  end
  rar=-1
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
  if forcespiral
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
  if euden
    f=["Mana x3950","Flame Orb x7","Flame Orb x15, Blaze Orb x2, Mana x14300","Flame Orb x12, Blaze Orb x3",
       "Flame Orb x30, Blaze Orb x3, Inferno Orb x1, Flamewyrm's Scale x5, Flamewyrm's Scaldscale x1, Mana x32100",
       "Blaze Orb x5, Inferno Orb x3, Rainbow Orb x1, Flamewyrm's Scale x15, Flamewyrm's Scaldscale x5",
       "Flame Orb x75, Blaze Orb x10, Inferno Orb x1, Flamewyrm's Scale x13, Flamewyrm's Scaldscale x4, Mana x51400",
       "Inferno Orb x4, Rainbow Orb x1, Flamewyrm's Scale x10, Flamewyrm's Scaldscale x7, Knight's Testament x2",
       "Blaze Orb x12, Inferno Orb x7, Rainbow Orb x2, Flamewyrm's Scale x25, Flamewyrm's Scaldscale x7, Knight's Testament x1, Champion's Testament x1, Mana x86000, Eldwater x73000","Inferno Orb x8, Rainbow Orb x16, Flamewyrm's Scaldscale x12, Knight's Testament x2, Void Seed x8","Mana x16000",
       "Inferno Orb x8, Incandescence Orb x4, Rainbow Orb x4, Mana x24000","Mana x16000","Mana x16000",
       "Incandescence Orb x4, Knight's Testament x3, Longing Heart x5, Mana x30000",
       "Incandescence Orb x3, Flamewyrm's Scaldscale x14, Burning Heart x4, Mana x56000","Mana x16000","Mana x16000",
       "Inferno Orb x12, Incandescence Orb x4, Rainbow Orb x4, Mana x36000","Incandescence Orb x4, Blazing Ember x5, Champion's Testament x1, Mana x60000",
       "Mana x16000","Mana x16000","Inferno Orb x16, Incandescence Orb x4, Rainbow Orb x4, Mana x24000","Mana x16000",
       "Incandescence Orb x4, Windwyrm's Greatsphere x4, Champion's Testament x1, Mana x90000","Mana x16000",
       "Incandescence Orb x4, Rainbow Orb x4, Flamewyrm's Scaldscale x16, Mana x36000","Mana x16000","Mana x16000",
       "Incandescence Orb x8, Rainbow Orb x4, Windwyrm's Greatsphere x4, Mana x120000"]
  else
    if rar==5
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
    elsif rar==4
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
      if elem=='Flame'
        f[i]=f[i].gsub("Bronze Orb","Flame Orb").gsub("Silver Orb","Blaze Orb").gsub("Gold Orb","Inferno Orb").gsub("Platinum Orb","Incandescence Orb")
        f[i]=f[i].gsub("Samewyrm's Scale","Flamewyrm's Scale").gsub("Samewyrm's Superscale","Flamewyrm's Scaldscale")
        f[i]=f[i].gsub("Void Heart","Burning Heart").gsub("HighDragon Tail","Blazing Ember")
        f[i]=f[i].gsub("Weakwyrm's Greatsphere","Windwyrm's Greatsphere").gsub("High Weakwyrm's Tail","High Windwyrm's Tail")
      elsif elem=='Water'
        f[i]=f[i].gsub("Bronze Orb","Water Orb").gsub("Silver Orb","Stream Orb").gsub("Gold Orb","Deluge Orb").gsub("Platinum Orb","Tsunami Orb")
        f[i]=f[i].gsub("Samewyrm's Scale","Waterwyrm's Scale").gsub("Samewyrm's Superscale","Waterwyrm's Glistscale")
        f[i]=f[i].gsub("Void Heart","Azure Heart").gsub("HighDragon Tail","Oceanic Crown")
        f[i]=f[i].gsub("Weakwyrm's Greatsphere","Flamewyrm's Greatsphere").gsub("High Weakwyrm's Tail","High Flamewyrm's Tail")
      elsif elem=='Wind'
        f[i]=f[i].gsub("Bronze Orb","Wind Orb").gsub("Silver Orb","Storm Orb").gsub("Gold Orb","Maelstrom Orb").gsub("Platinum Orb","Tempest Orb")
        f[i]=f[i].gsub("Samewyrm's Scale","Windwyrm's Scale").gsub("Samewyrm's Superscale","Windwyrm's Squallscale")
        f[i]=f[i].gsub("Void Heart","Verdant Heart").gsub("HighDragon Tail","Zephyr Rune")
        f[i]=f[i].gsub("Weakwyrm's Greatsphere","Waterwyrm's Greatsphere").gsub("High Weakwyrm's Tail","High Waterwyrm's Tail")
      elsif elem=='Light'
        f[i]=f[i].gsub("Bronze Orb","Light Orb").gsub("Silver Orb","Radiance Orb").gsub("Gold Orb","Refulgence Orb").gsub("Platinum Orb","Resplendence Orb")
        f[i]=f[i].gsub("Samewyrm's Scale","Lightwyrm's Scale").gsub("Samewyrm's Superscale","Lightwyrm's Glowscale")
        f[i]=f[i].gsub("Void Heart","Coronal Heart").gsub("HighDragon Tail","Abyssal Standard")
        f[i]=f[i].gsub("Weakwyrm's Greatsphere","Shadowwyrm's Greatsphere").gsub("High Weakwyrm's Tail","High Shadowwyrm's Tail")
      elsif elem=='Shadow'
        f[i]=f[i].gsub("Bronze Orb","Shadow Orb").gsub("Silver Orb","Nightfall Orb").gsub("Gold Orb","Nether Orb").gsub("Platinum Orb","Abaddon Orb")
        f[i]=f[i].gsub("Samewyrm's Scale","Shadowwyrm's Scale").gsub("Samewyrm's Superscale","Shadowwyrm's Darkscale")
        f[i]=f[i].gsub("Void Heart","Ebony Heart").gsub("HighDragon Tail","Ruinous Wing")
        f[i]=f[i].gsub("Weakwyrm's Greatsphere","Lightwyrm's Greatsphere").gsub("High Weakwyrm's Tail","High Lightwyrm's Tail")
      end
    end
  end
  name="#{rar}#{@rarity_stars[0][rar]} #{elem}#{element_emote(elem,bot)} Adventurer" if name.length<=0
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
      f2.push([3,"#{f[4] if nums[0]<30}\n\n__*Floor 4 unbind*__\n#{f[5]}"]) if nums[0]<40 && nums[1]>=30
      f2.push([4,"#{f[6] if nums[0]<40}\n\n__*Floor 5 unbind*__\n#{f[7]}"]) if nums[0]<50 && nums[1]>=40
      f2.push([5,"#{f[8] if nums[0]<50}#{"\n\n__*Mana Spiral unlock*__\n#{f[9]}" if mana && nums[1]<=49}"]) if nums[0]<=50 && nums[1]>=50
      xcolor=element_color(elem)
      disp="__**#{name}**'s Mana Spiral mats#{" (#{nums_mean})" if nums_mean.length>0}__"
      if f2.length>0 && !f2[0][1].nil? && f2[0][1].length>0 && !forcespiral
        if f2[0][1].length<=0
        elsif f2[0][1].split("\n").reject{|q| q.length<=0}[0].include?('unbind')
          f2[1][1]="#{f2[0][1]}\n\n#{f2[1][1]}"
          f2[0]=nil
          f2.compact!
        end
        create_embed(event,"__**#{name}**'s mats#{" (#{nums_mean})" if nums_mean.length>0}__",'',element_color(elem),'Floors are given totals as nodes can be unlocked in any order',xpic,f2.map{|q| ["Floor #{q[0]}",q[1]]})
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
      create_embed(event,"__**#{name}**'s mat totals#{" (#{nums_mean})" if nums_mean.length>0}__",'',element_color(elem),nil,xpic,triple_finish(f3,true))
    end
    return nil
  end
  event.respond "**Element:** #{element_emote(elem,bot)}\n**Rarity:** #{generate_rarity_row(rar)}#{"\n**Mana Spiral**" if mana}#{"\n**Additional Numbers:** #{nums[0,[nums.length,2].min].join(', ')}" if nums.length>0}"
end

def grab_today(event,bot,args=nil,ignoreinputs=false,mode=0)
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
    str=extend_message(str,str5,event,2)
    str5="__**<:Element_Void:548467446734913536> #{"#{str3}'s " if str3.length>0}Void Strikes:**__"
    data_load()
    void=@voids[0,7].map{|q| q}
    matz=@voids[8,@voids.length-8].map{|q| q}
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
    showhdt=true if @shardizard==4
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
      drg=@dragons.reject{|q| q[9]!=t.wday}
      m=[]
      for i in 0...@max_rarity[1]
        m.push([generate_rarity_row(i+1),[]])
      end
      for i in 0...drg.length
        f="#{drg[i][0]}#{element_emote(drg[i][2],bot,drg[i][16])}"
        for i2 in 0...@max_rarity[1]
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

def future_events(event,bot,args=nil)
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
    mode=1 if mode<1 && ['ruin','ruins'].include?(args[i])
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
  if [1,0].include?(mode)
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
  data_load()
  void=@voids[0,7].map{|q| q.gsub('*','')}
  void2=@voids[0,7].map{|q| q.split(', ').reject{|q2| !q2.include?('*')}.join(', ').gsub('*','')}
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
    matz=@voids[7,@voids.length-7].map{|q| q}
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
    matzx=@voids[8,@voids.length-8].map{|q| q.split(', ')}
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

def disp_boop_tags(event)
  event.channel.send_temporary_message('Please wait...',10)
  data_load()
  lookout2=[]
  if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
    lookout2=[]
    File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
      lookout2.push(eval line)
    end
  end
  lookout=lookout2.reject{|q| q[2]!='Mat'}.map{|q| q[0]}
  m=@mats.map{|q| q[8]}.join(', ').split(', ').reject{|q| q.nil? || q.length<=0 || lookout.include?(q)}.uniq.sort
  str='__**Mat tags**__'
  for i in 0...m.length
    str=extend_message(str,m[i],event)
  end
  lookout=lookout2.reject{|q| q[2]!='Askillity'}.map{|q| q[0]}
  m=@askilities.reject{|q| q[2]!='Skill'}.map{|q| q[10]}.join(', ').split(', ').reject{|q| lookout.include?(q) || q.nil? || q.length<=0 || (q[0,1]=='E' && q[1,1].to_i.to_s==q[1,1]) || (q[0,1]=='I' && q[1,1].to_i.to_s==q[1,1]) || ['Flame','Water','Wind','Light','Shadow','Mixed','Null','Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff'].include?(q)}.uniq.sort
  str=extend_message(str,'__**Skill tags**__',event,2)
  for i in 0...m.length
    str=extend_message(str,m[i],event)
  end
  m=@askilities.reject{|q| !['Ability','Aura','CoAbility','Chain'].include?(q[2])}.map{|q| q[6]}.join(', ').split(', ').reject{|q| q.nil? || q.length<=0 || lookout.include?(q) || ['Flame','Water','Wind','Light','Shadow','Mixed','Null','Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff'].include?(q)}.uniq.sort
  str=extend_message(str,'__**Ability tags**__',event,2)
  for i in 0...m.length
    str=extend_message(str,m[i],event)
  end
  lookout=lookout2.reject{|q| q[2]!='Banner'}.map{|q| q[0]}
  m=@banners.map{|q| q[5]}.join(', ').split(', ').reject{|q| q.nil? || q.length<=0 || lookout.include?(q) || ['Flame','Water','Wind','Light','Shadow','Mixed','Null','fake'].include?(q)}.uniq.sort
  str=extend_message(str,'__**Banner tags**__',event,2)
  for i in 0...m.length
    str=extend_message(str,m[i],event)
  end
  event.respond str
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
  str="#{str}\n\n7.) Type the number 2 to select reloading data based on GitHub files."
  str="#{str}\n\n8.) Double-check that the edited data works.  It is important to remember that I will not be there to guide you to wherever any problems might be based on error codes."
  str="#{str}\n\n9.) Add any relevant aliases to the new data."
  create_embed(event,"**How to update Botan's data while Mathoo is unavailable.**",str,0xED619A,nil)
end

def disp_adv_chain(event,args,bot)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_adventurer,args.join(' '),event,false,false,true)
  if k.nil? || k.length<=0
    event.respond 'No matches found.'
    return nil
  end
  event.channel.send_temporary_message('Calculating data, please wait...',2)
  str=args.join(' ')
  k2=[]
  for i in 0...args.length
    args2=str.split(' ')
    k=find_data_ex(:find_adventurer,args2.join(' '),event,false,false,true)
    unless k.nil? || k.length<=0
      k2.push(k[0])
      str=first_sub(str,k[1],'')
    end
  end
  args2=str.split(' ')
  k3=[]
  k4=[]
  k5=[]
  k6=[]
  str='__***Team***__'
  limit=false
  for i in 0...k2.length
    if k4.length>=4
      if limit
        str=extend_message(str,"~~#{k2[i][0]}#{adv_emoji(k2[i],bot,true)}~~",event)
      else
        limit=true
        str=extend_message(str,"~~#{k2[i][0]}#{adv_emoji(k2[i],bot,true)}~~ - team limit reached",event)
      end
    elsif k3.include?(k2[i][9][0]) && !has_any?(['altteam','alteam'],args2)
      str=extend_message(str,"~~#{k2[i][0]}#{adv_emoji(k2[i],bot,true)}~~ - #{k2[i][9][0]} already on team",event)
    else
      str=extend_message(str,"**#{k2[i][0]}#{adv_emoji(k2[i],bot,true)}**",event)
      k3.push(k2[i][9][0])
      k4.push(k2[i][7][0]) # coability
      k5.push(k2[i][7][1]) # chain coability
      k6.push(k2[i][2]) # data
      k6[-1].push(k2[i][0]) # name
    end
  end
  xseed=['HP','Strength']
  for i in 0...k6.length
    xseed.push("(#{k6[i][1]}) HP")
    xseed.push("(#{k6[i][2]}) HP")
    xseed.push("(#{k6[i][1]}) Strength")
    xseed.push("(#{k6[i][2]}) Strength")
  end
  xseed.uniq!
  romanums=['Ox0','I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII','XVIII','XIX','XX','XXI','XXII','XXIII','XXIV',
            'XXV','XXVI','XXVII','XXVIII','XXIX','XXX','XXXI','XXXII','XXXIII','XXXIV','XXXV','XXXVI','XXXVII','XXXVIII','XXXIX','XL','XLI','XLII','XLII',
            'XLIII','XLIV','XLV','XLVI','XLVII','XLVIII','XLIX','L']
  kk4=[]
  for i in 0...k4.length
    if k4[i].include?(' & ')
      k4[i]=k4[i].split(' ')
      k4[i]=[k4[i][0,k4[i].length-1].join(' ').split(' & '),k4[i][-1]]
      if k4[i][0].include?('HP') || k4[i][0].include?('Strength') || k4[i][0].include?('Defense')
        k4[i][0]=k4[i][0].join(' & ')
        kk4.push(k4[i].join(' '))
      elsif k4[i][0][0,k4[i][0].length-1].reject{|q| !q.include?('%') && !q.include?('/')}.length>0
        k4[i][0][-1]="#{k4[i][0][-1]} #{k4[i][-1]}"
        kk4.push(k4[i][0])
      elsif k4[i][-1].include?('%') || k4[i][-1].include?('/') || k4[i][-1].to_i.to_s==k4[i][-1]
        kk4.push(k4[i][0].map{|q| "#{q} #{k4[i][-1]}"})
      else
        k4[i][0][-1]="#{k4[i][0][-1]} #{k4[i][-1]}"
        kk4.push(k4[i][0])
      end
    else
      kk4.push(k4[i])
    end
  end
  k4=kk4.map{|q| q}.flatten
  for i in 0...k4.length
    k4[i]=k4[i].gsub("(#{k6[0][1]}) ",'') if k6.map{|q| q[1]}.uniq.length<=1
    k4[i]=k4[i].gsub("(#{k6[0][2]}) ",'') if k6.map{|q| q[2]}.uniq.length<=1
    k4[i]=k4[i].split(' ')
    if k4[i][-1].include?('/')
      k4[i][-1]=k4[i][-1].split('/')[-1].gsub('+','')
      if k4[i][-1].include?('%')
        k4[i]=[k4[i][0,k4[i].length-1].join(' '),k4[i][-1].gsub('%','').to_i,'Percent']
      elsif !romanums.find_index{|q| q==k4[i][-1]}.nil?
        k4[i]=[k4[i][0,k4[i].length-1].join(' '),k4[i][-1],'Roman']
      elsif k4[i][-1].to_i.to_s==k4[i][-1]
        k4[i]=[k4[i][0,k4[i].length-1].join(' '),k4[i][-1].to_i,'Number']
      else
        k4[i]=[k4[i].join(' '),nil,'']
      end
    elsif k4[i][-1].include?('%')
      k4[i]=[k4[i][0,k4[i].length-1].join(' '),k4[i][-1].gsub('%','').gsub('+','').to_i,'Percent']
    elsif !romanums.find_index{|q| q==k4[i][-1]}.nil?
      k4[i]=[k4[i][0,k4[i].length-1].join(' '),k4[i][-1],'Roman']
    elsif k4[i][-1].to_i.to_s==k4[i][-1]
      k4[i]=[k4[i][0,k4[i].length-1].join(' '),k4[i][-1].to_i,'Number']
    else
      k4[i]=[k4[i].join(' '),nil,'']
    end
    k4[i][0]="#{k4[i][0]} [Coab]" if xseed.include?(k4[i][0])
  end
  kk5=[]
  for i in 0...k5.length
    if k5[i].include?(' & ')
      k5[i]=k5[i].split(' ')
      k5[i]=[k5[i][0,k5[i].length-1].join(' ').split(' & '),k5[i][-1]]
      if k5[i][0][0,k5[i][0].length-1].reject{|q| !q.include?('%') && !q.include?('/')}.length>0
        k5[i][0][-1]="#{k5[i][0][-1]} #{k5[i][-1]}"
        kk5.push(k5[i][0])
      elsif k5[i][-1].include?('%') || k5[i][-1].include?('/') || k5[i][-1].to_i.to_s==k5[i][-1]
        kk5.push(k5[i][0].map{|q| "#{q} #{k5[i][-1]}"})
      else
        k5[i][0][-1]="#{k5[i][0][-1]} #{k5[i][-1]}"
        kk5.push(k5[i][0])
      end
    else
      kk5.push(k5[i])
    end
  end
  k5=kk5.map{|q| q}.flatten
  for i in 0...k5.length
    k5[i]=k5[i].gsub("(#{k6[0][1]}) ",'') if k6.map{|q| q[1]}.uniq.length<=1
    k5[i]=k5[i].gsub("(#{k6[0][2]}) ",'') if k6.map{|q| q[2]}.uniq.length<=1
    k5[i]=k5[i].split(' ')
    if k5[i][-1].include?('/')
      k5[i][-1]=k5[i][-1].split('/')[-1].gsub('+','')
      if k5[i][-1].include?('%')
        k5[i]=[k5[i][0,k5[i].length-1].join(' '),k5[i][-1].gsub('%','').to_i,'Percent']
      elsif !romanums.find_index{|q| q==k5[i][-1]}.nil?
        k5[i]=[k5[i][0,k5[i].length-1].join(' '),k5[i][-1],'Roman']
      elsif k5[i][-1].to_i.to_s==k5[i][-1]
        k5[i]=[k5[i][0,k5[i].length-1].join(' '),k5[i][-1].to_i,'Number']
      else
        k5[i]=[k5[i].join(' '),nil,'']
      end
    elsif k5[i][-1].include?('%')
      k5[i]=[k5[i][0,k5[i].length-1].join(' '),k5[i][-1].gsub('%','').gsub('+','').to_i,'Percent']
    elsif !romanums.find_index{|q| q==k5[i][-1]}.nil?
      k5[i]=[k5[i][0,k5[i].length-1].join(' '),k5[i][-1],'Roman']
    elsif k5[i][-1].to_i.to_s==k5[i][-1]
      k5[i]=[k5[i][0,k5[i].length-1].join(' '),k5[i][-1].to_i,'Number']
    else
      k5[i]=[k5[i].join(' '),nil,'']
    end
    k5[i][0]="#{k5[i][0]} [Chain]" if xseed.include?(k5[i][0])
  end
  str2=[]
  str2.push(k6[0][1]) if k6.map{|q| q[1]}.uniq.length<=1
  str2.push(k6[0][2]) if k6.map{|q| q[2]}.uniq.length<=1
  str2.push(k6[0][0]) if k6.map{|q| q[0]}.uniq.length<=1
  str=extend_message(str,"**#{str2.join(' ')} Synergy**",event) if str2.length>0 && k6.length>1
  m=k4.map{|q| [q[0],0,q[2]]}.uniq
  for i in 0...m.length
    if m[i][2].length<=0
      k5.push([m[i][0],nil,m[i][2]])
    else
      k5.push([m[i][0],k4.reject{|q| q[0]!=m[i][0] || q[2]!=m[i][2]}.map{|q| q[1]}.max,m[i][2]])
    end
  end
  m=k5.map{|q| [q[0],0,q[2]]}.uniq
  for i in 0...m.length
    if m[i][2].length<=0
      m[i]=m[i][0]
    else
      m2=k5.reject{|q| q[0]!=m[i][0] || q[2]!=m[i][2]}.map{|q| q[1]}
      x=''
      x='**' if m2.length>1
      m2=m2.inject(0){|sum,x| sum + x } unless m[i][2]=='Roman'
      m[i][1]=m2*1
    end
  end
  mmm=m.map{|q| q}
  elem_stats=[['',      0,0,0,0,0,0],
              ['Flame', 0,0,0,0,0,0],
              ['Water', 0,0,0,0,0,0],
              ['Wind',  0,0,0,0,0,0],
              ['Light', 0,0,0,0,0,0],
              ['Shadow',0,0,0,0,0,0],
              ['Sword', 0,0,0,0,0,0],
              ['Blade', 0,0,0,0,0,0],
              ['Dagger',0,0,0,0,0,0],
              ['Axe',   0,0,0,0,0,0],
              ['Bow',   0,0,0,0,0,0],
              ['Lance', 0,0,0,0,0,0],
              ['Wand',  0,0,0,0,0,0],
              ['Staff', 0,0,0,0,0,0]]
  for i in 0...m.length
    m[i][0]=m[i][0].gsub(' [Chain]','') unless mmm.map{|q| q[0].split(') ')[-1]}.include?(m[i][0].split(') ')[-1].gsub('~~','').gsub(' [Chain]',' [Coab]'))
    m[i][0]=m[i][0].gsub(' [Coab]','') unless mmm.map{|q| q[0].split(') ')[-1]}.include?(m[i][0].split(') ')[-1].gsub('~~','').gsub(' [Coab]',' [Chain]'))
    skillname=m[i][0].gsub(' [Chain]','').gsub(' [Coab]','')
    if m[i][2].length<=0
      m[i]=m[i][0]
    else
      m2=k5.reject{|q| q[0]!=m[i][0] || q[2]!=m[i][2]}.map{|q| q[1]}
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
        m4=k5.reject{|q| q[0]!=m3 || q[2]!=m[i][2]}.map{|q| q[1]}
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
    for i in 0...k6.length
      str3=[]
      m1=elem_stats[0].map{|q| q}
      m2=elem_stats.find_index{|q| q[0]==k6[i][1]}
      m2=elem_stats[m2].map{|q| q} unless m2.nil?
      m2=['',0,0,0,0,0,0] if m2.nil?
      m3=elem_stats.find_index{|q| q[0]==k6[i][2]}
      m3=elem_stats[m3].map{|q| q} unless m3.nil?
      m3=['',0,0,0,0,0,0] if m3.nil?
      for i2 in 1...m1.length
        m1[i2]+=m2[i2]+m3[i2]
      end
      m2=m1[1]+100
      m3=m1[4]+100
      m2=m2*m3/100.0-100
      str3.push("<:HP:573344832307593216>+#{'%.2f' % m2}%") if m2>=1
      m2=m1[2]+100
      m3=m1[5]+100
      m2=m2*m3/100.0-100
      str3.push("<:Strength:573344931205349376>+#{'%.2f' % m2}%") if m2>=1
      m2=m1[3]+100
      m3=m1[6]+100
      m2=m2*m3/100.0-100
      str3.push("<:Defense:573344832282689567>+#{'%.2f' % m2}%") if m2>=1
      str=extend_message(str,"**#{k6[i][3]}** - #{str3.join('  ')}",event) if str3.length>0
    end
  end
  event.respond str
  return nil
end

def show_bot_status(event,bot)
  t=Time.now
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event)
    event << "Current avatar: #{bot.user(543373018303299585).avatar_url}"
    event << "Adventurer/Dragon in avatar: #{@avvie_info[0]}"
    event << ''
    event << "Current status:"
    event << "[Playing] #{@avvie_info[1]}"
    event << ''
    event << "Reason: #{@avvie_info[2]}" unless @avvie_info[2].length.zero?
    event << ''
    event << "__extrachiz, she who made my default avatar__"
    event << "<https://twitter.com/extrachiz>"
    event << "<https://ko-fi.com/extrachiz>"
    event << ''
    event << "#{'Dev' if @shardizard==4}#{'Van' unless @shardizard==4}'s timezone: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]}) | #{'0' if t.hour<10}#{t.hour}:#{'0' if t.min<10}#{t.min}"
  else
    create_embed(event,'',"Adventurer/Dragon in avatar: #{@avvie_info[0]}\n\nCurrent status:\n[Playing] #{@avvie_info[1]}#{"\n\nReason: #{@avvie_info[2]}" unless @avvie_info[2].length.zero?}\n\n[For a full calendar of avatars, click here](https://docs.google.com/spreadsheets/d/1j-tdpotMO_DcppRLNnT8DN8Ftau-rdQ-ZmZh5rZkZP0/edit?usp=sharing)\nextrachiz, she who made my default avatar: [Twitter](https://twitter.com/extrachiz)  \u00B7  [Ko-fi](https://ko-fi.com/extrachiz)",(t.day*7+t.month*21*256+(t.year-2000)*10*256*256),"#{'Dev' if @shardizard==4}#{'Van' unless @shardizard==4}'s timezone: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]}) | #{'0' if t.hour<10}#{t.hour}:#{'0' if t.min<10}#{t.min}",bot.user(543373018303299585).avatar_url)
  end
end

def add_a_new_alias(bot,event,newname=nil,unit=nil,modifier=nil,modifier2=nil,mode=0)
  data_load()
  nicknames_load()
  err=false
  str=''
  if newname.nil? || unit.nil?
    str="The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Enemies\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Chain CoAbilities\n- Facilities\n- Materials\n\nYou must specify both:\n- one of the above\n- an alias you wish to give that item"
    err=true
  elsif event.user.id != 167657750971547648 && event.server.nil?
    str='Only my developer is allowed to use this command in PM.'
    err=true
  elsif (!is_mod?(event.user,event.server,event.channel) && ![368976843883151362,195303206933233665,141260274144509952].include?(event.user.id)) && event.channel.id != 532083509083373583
    str='You are not a mod.'
    err=true
  elsif newname.include?('"') || newname.include?("\n")
    str='Full stop.  " is not allowed in an alias.'
    err=true
  elsif !event.server.nil? && event.server.id==363917126978764801
    err="You guys revoked your permission to add aliases when you refused to listen to me regarding the Erk alias for Serra.  Even if that was an alias for FEH instead of DL."
    str=true
  end
  if err
    event.respond str if str.length>0 && mode==0
    args=event.message.text.downcase.split(' ')
    args.shift
    disp_aliases(bot,event,args) if mode==1
    return nil
  end
  type=['Alias','Alias']
  if find_adventurer(newname,event,true).length>0
    type[0]='Adventurer'
  elsif find_dragon(newname,event,true).length>0
    type[0]='Dragon'
  elsif find_wyrmprint(newname,event,true).length>0
    type[0]='Wyrmprint'
  elsif find_weapon(newname,event,true).length>0
    type[0]='Weapon'
  elsif find_enemy(newname,event,true).length>0
    type[0]='Enemy'
  elsif find_skill(newname,event,true).length>0
    type[0]='Skill'
  elsif find_ability(newname,event,true).length>0
    type[0]='Ability'
  elsif find_facility(newname,event,true).length>0
    type[0]='Facility'
  elsif find_mat(newname,event,true).length>0
    type[0]='Material'
  elsif find_adventurer(newname,event).length>0
    type[0]='Adventurer*'
  elsif find_dragon(newname,event).length>0
    type[0]='Dragon*'
  elsif find_wyrmprint(newname,event).length>0
    type[0]='Wyrmprint*'
  elsif find_weapon(newname,event).length>0
    type[0]='Weapon*'
  elsif find_enemy(newname,event).length>0
    type[0]='Enemy*'
  elsif find_skill(newname,event).length>0
    type[0]='Skill*'
  elsif find_ability(newname,event).length>0
    type[0]='Ability*'
  elsif find_facility(newname,event).length>0
    type[0]='Facility*'
  elsif find_mat(newname,event).length>0
    type[0]='Material*'
  end
  if find_adventurer(unit,event,true).length>0
    type[1]='Adventurer'
  elsif find_dragon(unit,event,true).length>0
    type[1]='Dragon'
  elsif find_wyrmprint(unit,event,true).length>0
    type[1]='Wyrmprint'
  elsif find_weapon(unit,event,true).length>0
    type[1]='Weapon'
  elsif find_enemy(unit,event,true).length>0
    type[1]='Enemy'
  elsif find_skill(unit,event,true).length>0
    type[1]='Skill'
  elsif find_ability(unit,event,true).length>0
    type[1]='Ability'
  elsif find_facility(unit,event,true).length>0
    type[1]='Facility'
  elsif find_mat(unit,event,true).length>0
    type[1]='Material'
  elsif find_adventurer(unit,event).length>0
    type[1]='Adventurer*'
  elsif find_dragon(unit,event).length>0
    type[1]='Dragon*'
  elsif find_wyrmprint(unit,event).length>0
    type[1]='Wyrmprint*'
  elsif find_weapon(unit,event).length>0
    type[1]='Weapon*'
  elsif find_enemy(unit,event).length>0
    type[1]='Enemy*'
  elsif find_skill(unit,event).length>0
    type[1]='Skill*'
  elsif find_ability(unit,event).length>0
    type[1]='Ability*'
  elsif find_facility(unit,event).length>0
    type[1]='Facility*'
  elsif find_mat(unit,event).length>0
    type[1]='Material*'
  end
  checkstr=normalize(newname,true)
  if type.reject{|q| q != 'Alias'}.length<=0
    type[0]='Alias' if type[0].include?('*')
    type[1]='Alias' if type[1].include?('*') && type[0]!='Alias'
  end
  if type.reject{|q| q == 'Alias'}.length<=0
    alz1=newname
    alz2=unit
    alz1='>Censored mention<' if alz1.include?('@')
    alz2='>Censored mention<' if alz2.include?('@')
    str="The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Enemies\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Chain CoAbilities\n- Facilities\n- Materials\n\nNeither #{alz1} nor #{alz2} fall into any of these categories."
    err=true
  elsif type.reject{|q| q != 'Alias'}.length<=0
    alz1=newname
    alz2=unit
    alz1='>Censored mention<' if alz1.include?('@')
    alz2='>Censored mention<' if alz2.include?('@')
    event.respond "#{alz1} is a #{type[0].downcase}\n#{alz2} is a #{type[1].downcase}"
    err=true
  end
  if err
    str=["#{str}\nPlease try again.","#{str}\nTrying to list aliases instead."][mode]
    event.respond str if str.length>0
    args=event.message.text.downcase.split(' ')
    args.shift
    list_unit_aliases(event,args,bot) if mode==1
    return nil
  end
  if type[1]=='Alias' && type[0]!='Alias'
    f="#{newname}"
    newname="#{unit}"
    unit="#{f}"
    type=type.reverse.map{|q| q.gsub('*','')}
  else
    type=type.map{|q| q.gsub('*','')}
  end
  if newname.length<=2 && event.channel.id != 532083509083373583
    event.respond "Please note that aliases shorter than three characters long will be rejected."
    return nil
  end
  if type[1]=='Adventurer'
    unit=find_adventurer(unit,event)
    dispstr=['Adventurer',unit[0],'Adventurer',unit[0]]
  elsif type[1]=='Dragon'
    unit=find_dragon(unit,event)
    dispstr=['Dragon',unit[0],'Dragon',unit[0]]
  elsif type[1]=='Wyrmprint'
    unit=find_wyrmprint(unit,event)
    dispstr=['Wyrmprint',unit[0],'Wyrmprint',unit[0]]
  elsif type[1]=='Weapon'
    unit=find_weapon(unit,event)
    dispstr=['Weapon',unit[0],'Weapon',unit[0]]
  elsif type[1]=='Enemy'
    unit=find_enemy(unit,event)
    dispstr=['Enemy',unit[0],'Enemy',unit[0]]
  elsif type[1]=='Skill'
    unit=find_skill(unit,event)
    dispstr=['Skill',unit[0],'Skill',unit[0]]
  elsif type[1]=='Ability'
    unit=find_ability(unit,event)
    if unit[0].is_a?(Array) && unit.length<=1
      dispstr=['Ability',"#{unit[0][0]} #{unit[0][1]}",'Ability',"#{unit[0][0]} #{unit[0][1]}"]
      dispstr=['Ability',"#{unit[0][0]}",'Ability',"#{unit[0][0]}"] if ['-','example'].include?(unit[0][1])
    elsif unit[0].is_a?(Array)
      dispstr=['Ability',unit[0][0],'Ability',unit[0][0]]
    else
      dispstr=['Ability',"#{unit[0]} #{unit[1]}",'Ability',"#{unit[0]} #{unit[1]}"]
      dispstr=['Ability',"#{unit[0]}",'Ability',"#{unit[0]}"] if ['-','example'].include?(unit[1])
    end
  elsif type[1]=='Facility'
    unit=find_facility(unit,event)
    dispstr=['Facility',unit[0][0],'Facility',unit[0][0]]
  elsif type[1]=='Material'
    unit=find_mat(unit,event)
    dispstr=['Material',unit[0],'Item',unit[0]]
  end
  logchn=536307117301170187
  logchn=431862993194582036 if @shardizard==4
  newname=newname.gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')
  srv=0
  srv=event.server.id unless event.server.nil?
  srv=modifier.to_i if event.user.id==167657750971547648 && modifier.to_i.to_s==modifier
  srvname='PM with dev'
  srvname=bot.server(srv).name unless event.server.nil? && srv.zero?
  checkstr=normalize(newname,true)
  k=event.message.emoji
  for i in 0...k.length
    checkstr=checkstr.gsub("<:#{k[i].name}:#{k[i].id}>",k[i].name)
  end
  if checkstr.downcase =~ /(7|t)+?h+?(o|0)+?(7|t)+?/ && !(dispstr[1].include?('thot') && event.channel.id==532083509083373583)
    event.respond "That name has __***NOT***__ been added to #{dispstr[1]}'s aliases."
    bot.channel(logchn).send_message("~~**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** #{newname} for #{dispstr[1]}~~\n**Reason for rejection:** Begone, alias.")
    return nil
  elsif checkstr.downcase =~ /n+?((i|1)+?|(e|3)+?)(b|g|8)+?(a|4|(e|3)+?r+?)+?/
    event.respond "That name has __***NOT***__ been added to #{dispstr[1]}'s aliases."
    bot.channel(logchn).send_message("~~**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** >Censored< for #{dispstr[1]}~~\n**Reason for rejection:** Begone, alias.")
    return nil
  end
  newname=normalize(newname,true)
  m=nil
  m=[event.server.id] unless event.server.nil?
  srv=0
  srv=event.server.id unless event.server.nil?
  srv=modifier.to_i if event.user.id==167657750971547648 && modifier.to_i.to_s==modifier
  srvname='PM with dev'
  srvname=bot.server(srv).name unless event.server.nil? && srv.zero?
  if event.user.id==167657750971547648 && modifier.to_i.to_s==modifier
    m=[modifier.to_i]
    modifier=nil
  end
  chn=event.channel.id
  chn=modifier2.to_i if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
  m=nil if [167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) && !modifier.nil?
  m=nil if event.channel.id==532083509083373583 && !modifier.nil?
  double=false
  for i in 0...@aliases.length
    if @aliases[i][3].nil?
    elsif @aliases[i][1].downcase==newname.downcase && @aliases[i][2]==dispstr[3]
      if ([167657750971547648,141260274144509952].include?(event.user.id) || event.channel.id==532083509083373583) && !modifier.nil?
        @aliases[i][3]=nil
        @aliases[i][4]=nil
        @aliases[i].compact!
        bot.channel(chn).send_message("The alias **#{newname}** for the #{dispstr[2].downcase} *#{dispstr[1]}* exists in a server already.  Making it global now.")
        event.respond "The alias #{newname} for #{dispstr[1]} exists in a server already.  Making it global now.\nPlease test to be sure that the alias stuck." if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
        bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** #{newname} for #{dispstr[1]} - gone global.")
        double=true
      else
        @aliases[i][3].push(srv)
        bot.channel(chn).send_message("The alias **#{newname}** for the #{dispstr[2].downcase} *#{dispstr[1]}* exists in another server already.  Adding this server to those that can use it.")
        event.respond "The alias #{newname} for #{dispstr[1]} exists in another server already.  Adding this server to those that can use it.\nPlease test to be sure that the alias stuck." if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
        metadata_load()
        bot.user(167657750971547648).pm("The alias **#{@aliases[i][0]}** for the #{type[1]} **#{dispstr[1]}** is used in quite a few servers.  It might be time to make this global") if @aliases[i][3].length >= @server_data[0].inject(0){|sum,x| sum + x } / 20 && @aliases[i][3].length>=5 && @aliases[i][4].nil?
        bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** #{newname} for #{dispstr[1]} - gained a new server that supports it.")
        double=true
      end
    end
  end
  unless double
    @aliases.push([dispstr[0],newname,dispstr[3],m].compact)
    @aliases.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? ((a[2].downcase <=> b[2].downcase) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2].downcase <=> b[2].downcase)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
    bot.channel(chn).send_message("**#{newname}** has been#{" globally" if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==532083509083373583) && !modifier.nil?} added to the aliases for the #{dispstr[2].downcase} *#{dispstr[1]}*.\nPlease test to be sure that the alias stuck.")
    event.respond "#{newname} has been added to #{dispstr[1]}'s aliases#{" globally" if event.user.id==167657750971547648 && !modifier.nil?}." if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
    bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** #{newname} for #{dispstr[1]}#{" - global alias" if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==532083509083373583) && !modifier.nil?}")
  end
  @aliases.uniq!
  nzzz=@aliases.map{|a| a}
  open("#{@location}devkit/DLNames.txt", 'w') { |f|
    for i in 0...nzzz.length
      f.puts "#{nzzz[i].to_s}#{"\n" if i<nzzz.length-1}"
    end
  }
  nicknames_load()
  nzz=nicknames_load(2)
  nzzz=@aliases.map{|a| a}
  if nzzz[nzzz.length-1].length>1 && nzzz[nzzz.length-1][2]>=nzz[nzz.length-1][2]
    bot.channel(logchn).send_message('Alias list saved.')
    open("#{@location}devkit/DLNames2.txt", 'w') { |f|
      for i in 0...nzzz.length
        f.puts "#{nzzz[i].to_s}#{"\n" if i<nzzz.length-1}"
      end
    }
    bot.channel(logchn).send_message('Alias list has been backed up.')
  end
end

def disp_alias_list(bot,event,args=nil,mode=0)
  event.channel.send_temporary_message('Calculating data, please wait...',2)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  data_load()
  nicknames_load()
  unless args.length.zero?
    if find_data_ex(:find_adventurer,args.join(''),event).length>0
    elsif find_data_ex(:find_dragon,args.join(''),event).length>0
    elsif find_data_ex(:find_wyrmprint,args.join(''),event).length>0
    elsif find_data_ex(:find_weapon,args.join(''),event).length>0
    elsif find_data_ex(:find_enemy,args.join(''),event).length>0
    elsif find_data_ex(:find_skill,args.join(''),event).length>0
    elsif find_data_ex(:find_ability,args.join(''),event).length>0
    elsif find_data_ex(:find_facility,args.join(''),event).length>0
    elsif find_data_ex(:find_mat,args.join(''),event).length>0
    elsif has_any?(args,['adventurer','adventurers','adv','advs','unit','units','dragon','dragons','wyrmprint','wyrm','print','wyrmprints','wyrms','prints','weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap','skill','skil','skills','skils','ability','abilitys','abilities','abil','abils','able','ables','facility','facilitys','facilities','faculty','facultys','faculties','mat','mats','material','materials','item','items','enemy','enemies','boss','bosss','bosses','drg','drgs'])
    else
      event.respond "The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Enemies\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Facilities\n- Materials\n\n#{args.join(' ')} does not fall into any of these categories."
      return nil
    end
  end
  adv=find_data_ex(:find_adventurer,args.join(''),event,true)
  adv=nil if adv.length<=0 || args.length.zero?
  drg=find_data_ex(:find_dragon,args.join(''),event,true)
  drg=nil if drg.length<=0 || args.length.zero?
  wrm=find_data_ex(:find_wyrmprint,args.join(''),event,true)
  wrm=nil if wrm.length<=0 || args.length.zero?
  wpn=find_data_ex(:find_weapon,args.join(''),event,true)
  wpn=nil if wpn.length<=0 || args.length.zero?
  enm=find_data_ex(:find_enemy,args.join(''),event,true)
  enm=nil if enm.length<=0 || args.length.zero?
  skl=find_data_ex(:find_skill,args.join(''),event,true)
  skl=nil if skl.length<=0 || args.length.zero?
  abl=find_data_ex(:find_ability,args.join(''),event,true)
  abl=nil if abl.length<=0 || args.length.zero?
  fac=find_data_ex(:find_facility,args.join(''),event,true)
  fac=nil if fac.length<=0 || args.length.zero?
  mat=find_data_ex(:find_mat,args.join(''),event,true)
  mat=nil if mat.length<=0 || args.length.zero?
  if adv.nil? && drg.nil? && wrm.nil? && wpn.nil? && enm.nil? && skl.nil? && abl.nil? && abl.nil? && fac.nil? && mat.nil?
    adv=find_data_ex(:find_adventurer,args.join(''),event)
    adv=nil if adv.length<=0 || args.length.zero?
    drg=find_data_ex(:find_dragon,args.join(''),event)
    drg=nil if drg.length<=0 || args.length.zero?
    wrm=find_data_ex(:find_wyrmprint,args.join(''),event)
    wrm=nil if wrm.length<=0 || args.length.zero?
    wpn=find_data_ex(:find_weapon,args.join(''),event)
    wpn=nil if wpn.length<=0 || args.length.zero?
    enm=find_data_ex(:find_enemy,args.join(''),event)
    enm=nil if enm.length<=0 || args.length.zero?
    skl=find_data_ex(:find_skill,args.join(''),event)
    skl=nil if skl.length<=0 || args.length.zero?
    abl=find_data_ex(:find_ability,args.join(''),event)
    abl=nil if abl.length<=0 || args.length.zero?
    fac=find_data_ex(:find_facility,args.join(''),event)
    fac=nil if fac.length<=0 || args.length.zero?
    mat=find_data_ex(:find_mat,args.join(''),event)
    mat=nil if mat.length<=0 || args.length.zero?
  end
  f=[]
  n=@aliases.reject{|q| q[0]!='Adventurer'}.map{|q| [q[1],q[2],q[3]]}
  h=''
  if adv.nil? && drg.nil? && wrm.nil? && wpn.nil? && enm.nil? && skl.nil? && abl.nil? && abl.nil? && fac.nil? && mat.nil?
    if has_any?(args,['adventurer','adventurers','adv','advs','unit','units'])
      n=n.reject{|q| q[2].nil?} if mode==1
      f.push('__**Adventurer Aliases**__')
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['dragon','dragons','drg','drgs'])
      f.push('__**Dragon Aliases**__')
      n=@aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'])
      f.push('__**Wyrmprint Aliases**__')
      n=@aliases.reject{|q| q[0]!='Wyrmprint'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'])
      f.push('__**Weapon Aliases**__')
      n=@aliases.reject{|q| q[0]!='Weapon'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['enemy','enemies','boss','bosss','bosses'])
      f.push('__**Enemy Aliases**__')
      n=@aliases.reject{|q| q[0]!='Enemy'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['skill','skil','skills','skils'])
      f.push('__**Skill Aliases**__')
      n=@aliases.reject{|q| q[0]!='Skill'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['ability','abilitys','abilities','abil','abils','able','ables'])
      f.push('__**Ability Aliases**__')
      n=@aliases.reject{|q| q[0]!='Ability'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['facility','facilitys','facilities','faculty','facultys','faculties'])
      f.push('__**Facility Aliases**__')
      n=@aliases.reject{|q| q[0]!='Facility'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['mat','mats','material','materials','item','items'])
      f.push('__**Item Aliases**__')
      n=@aliases.reject{|q| q[0]!='Material'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub("*","\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub("*","\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub("*","\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif safe_to_spam?(event) || mode==1
      n=n.reject{|q| q[2].nil?} if mode==1
      unless event.server.nil?
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        if n.length>25 && !safe_to_spam?(event)
          event.respond "There are so many aliases that I don't want to spam the server.  Please use the command in PM."
          return nil
        end
        msg='__**Adventurer Aliases**__'
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0].gsub('*',"\\*")} == #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event) unless mode==1 && !event.server.nil? && !n[i][2].nil? && !n[i][2].include?(event.server.id)
        end
        msg=extend_message(msg,'__**Dragon Aliases**__',event,2)
        n=@aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0].gsub('*',"\\*")} == #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event) unless mode==1 && !event.server.nil? && !n[i][2].nil? && !n[i][2].include?(event.server.id)
        end
        msg=extend_message(msg,'__**Wyrmprint Aliases**__',event,2)
        n=@aliases.reject{|q| q[0]!='Wyrmprint'}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0].gsub('*',"\\*")} == #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event) unless mode==1 && !event.server.nil? && !n[i][2].nil? && !n[i][2].include?(event.server.id)
        end
        msg=extend_message(msg,'__**Weapon Aliases**__',event,2)
        n=@aliases.reject{|q| !['Weapon'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0].gsub('*',"\\*")} == #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event) unless mode==1 && !event.server.nil? && !n[i][2].nil? && !n[i][2].include?(event.server.id)
        end
        msg=extend_message(msg,'__**Enemy Aliases**__',event,2)
        n=@aliases.reject{|q| !['Enemy'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0].gsub('*',"\\*")} == #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event) unless mode==1 && !event.server.nil? && !n[i][2].nil? && !n[i][2].include?(event.server.id)
        end
        msg=extend_message(msg,'__**Skill Aliases**__',event,2)
        n=@aliases.reject{|q| !['Skill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0].gsub('*',"\\*")} == #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event) unless mode==1 && !event.server.nil? && !n[i][2].nil? && !n[i][2].include?(event.server.id)
        end
        msg=extend_message(msg,'__**Ability Aliases**__',event,2)
        n=@aliases.reject{|q| !['Ability'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0].gsub('*',"\\*")} == #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event) unless mode==1 && !event.server.nil? && !n[i][2].nil? && !n[i][2].include?(event.server.id)
        end
        msg=extend_message(msg,'__**Facility Aliases**__',event,2)
        n=@aliases.reject{|q| !['Facility'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0].gsub('*',"\\*")} == #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event) unless mode==1 && !event.server.nil? && !n[i][2].nil? && !n[i][2].include?(event.server.id)
        end
        msg=extend_message(msg,'__**Item Aliases**__',event,2)
        n=@aliases.reject{|q| !['Material'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| !q[2].nil? && !q[2].include?(event.server.id)}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0].gsub('*',"\\*")} == #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event) unless mode==1 && !event.server.nil? && !n[i][2].nil? && !n[i][2].include?(event.server.id)
        end
        event.respond msg
        return nil
      end
      f.push('__**Adventurer Aliases**__')
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif mode==1 && !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Dragon Aliases**__")
      n=@aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Wyrmprint Aliases**__")
      n=@aliases.reject{|q| q[0]!='Wyrmprint'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Weapon Aliases**__")
      n=@aliases.reject{|q| !['Weapon'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Enemy Aliases**__")
      n=@aliases.reject{|q| !['Enemy'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Skill Aliases**__")
      n=@aliases.reject{|q| !['Skill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Ability Aliases**__")
      n=@aliases.reject{|q| !['Ability'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Facility Aliases**__")
      n=@aliases.reject{|q| !['Facility'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Item Aliases**__")
      n=@aliases.reject{|q| !['Material'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        elsif !event.server.nil?
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_').gsub('*',"\\*")} == #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    else
      event.respond "The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Facilities\n- Materials\n\nPlease either specify a member of one of these categories or use this command in PM."
      return nil
    end
  elsif !adv.nil?
    n=n.reject{|q| q[2].nil?} if mode==1
    k=0
    k=event.server.id unless event.server.nil?
    f.push("__**#{adv[0]}#{adv_emoji(adv,bot)}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(adv[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if adv[0].include?('(') || adv[0].include?(')') || adv[0].include?(' ') || adv[0].include?('!') || adv[0].include?('_') || adv[0].include?('?') || adv[0].include?("'") || adv[0].include?('"')
    end
    for i in 0...n.length
      if n[i][1]==adv[0]
        if event.server.nil? && !n[i][2].nil?
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        elsif n[i][2].nil?
          f.push(n[i][0].gsub('_','\\_')) unless mode==1
        else
          f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
        end
      end
    end
  elsif !drg.nil?
    drg=drg[0] if drg[0].is_a?(Array)
    k=0
    k=event.server.id unless event.server.nil?
    n=@aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{drg[0]}#{dragon_emoji(drg,bot)}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(drg[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if drg[0].include?('(') || drg[0].include?(')') || drg[0].include?(' ') || drg[0].include?('!') || drg[0].include?('_') || drg[0].include?('?') || drg[0].include?("'") || drg[0].include?('"')
    end
    for i in 0...n.length
      if n[i][1]==drg[0]
        if event.server.nil? && !n[i][2].nil?
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        elsif n[i][2].nil?
          f.push(n[i][0].gsub('_','\\_')) unless mode==1
        else
          f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
        end
      end
    end
  elsif !wrm.nil?
    n=@aliases.reject{|q| q[0]!='Wyrmprint' || q[2]!=wrm[0]}.map{|q| [q[1],q[2],q[3]]}
    k=0
    k=event.server.id unless event.server.nil?
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{wrm[0]}#{print_emoji(wrm,bot)}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(wrm[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if wrm[0].include?('(') || wrm[0].include?(')') || wrm[0].include?(' ') || wrm[0].include?('!') || wrm[0].include?('_') || wrm[0].include?('?') || wrm[0].include?("'") || wrm[0].include?('"')
    end
    for i in 0...n.length
      if n[i][1]==wrm[0]
        if event.server.nil? && !n[i][2].nil?
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        elsif n[i][2].nil?
          f.push(n[i][0].gsub('_','\\_')) unless mode==1
        else
          f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
        end
      end
    end
  elsif !wpn.nil?
    wpn=wpn[0] if wpn[0].is_a?(Array)
    k=0
    k=event.server.id unless event.server.nil?
    n=@aliases.reject{|q| !['Weapon'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{wpn[0]}#{weapon_emoji(wpn,bot)}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(wpn[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if wpn[0].include?('(') || wpn[0].include?(')') || wpn[0].include?(' ') || wpn[0].include?('!') || wpn[0].include?('_') || wpn[0].include?('?') || wpn[0].include?("'") || wpn[0].include?('"')
      mnm=[wpn[3]]
      mnm.push('Fire') if wpn[3]=='Flame'
      mnm.push('Dark') if wpn[3]=='Shadow'
      mnm2=[wpn[1]]
      mnm2.push('Spear') if wpn[1]=='Lance'
      mnm2.push('Katana') if wpn[1]=='Blade'
      mnm2.push('Rod') if wpn[1]=='Wand'
      lists=get_lookout_tags().reject{|q| q[2]!='Availability/Weapon'}.map{|q| [q[3],q[1]]}
      for i in 0...mnm.length
        for i2 in 0...mnm2.length
          if wpn[2][1,1]!='p' && wpn[2][1,1]!='s' && !lists.map{|q| q[0]}.include?(wpn[2][1,1]) && wpn[3]!='None'
            f.push("#{wpn[2][0,1]}\\*#{mnm[i]}#{mnm2[i2]}")
            f.push("#{wpn[2][0,1]}\\*#{mnm2[i2]}#{mnm[i]}")
            f.push("#{mnm[i]}#{wpn[2][0,1]}\\*#{mnm2[i2]}")
            f.push("#{mnm2[i2]}#{wpn[2][0,1]}\\*#{mnm[i]}")
            f.push("#{mnm[i]}#{mnm2[i2]}#{wpn[2][0,1]}\\*")
            f.push("#{mnm2[i2]}#{mnm[i]}#{wpn[2][0,1]}\\*")
          elsif lists.map{|q| q[0]}.include?(wpn[2][1,1]) && wpn[3]!='None'
            mnm3=lists[lists.find_index{|q| q[0]==wpn[2][1,1]}][1]
            mnm3=mnm3.reject{|q| q[-1]=='s' && mnm3.include?(q[0,q.length-1])}
            mnm3=mnm3.map{|q| "#{q[0].upcase}#{q[1,q.length-1].downcase}"}
            for i3 in 0...mnm3.length
              f.push("#{mnm3[i3]}#{wpn[2][0,1]}\\*#{mnm[i]}#{mnm2[i2]}")
              f.push("#{mnm3[i3]}#{wpn[2][0,1]}\\*#{mnm2[i2]}#{mnm[i]}")
              f.push("#{mnm3[i3]}#{mnm[i]}#{wpn[2][0,1]}\\*#{mnm2[i2]}")
              f.push("#{mnm3[i3]}#{mnm2[i2]}#{wpn[2][0,1]}\\*#{mnm[i]}")
              f.push("#{mnm3[i3]}#{mnm[i]}#{mnm2[i2]}#{wpn[2][0,1]}\\*")
              f.push("#{mnm3[i3]}#{mnm2[i2]}#{mnm[i]}#{wpn[2][0,1]}\\*")
              f.push("#{wpn[2][0,1]}\\*#{mnm3[i3]}#{mnm[i]}#{mnm2[i2]}")
              f.push("#{wpn[2][0,1]}\\*#{mnm3[i3]}#{mnm2[i2]}#{mnm[i]}")
              f.push("#{mnm[i]}#{mnm3[i3]}#{wpn[2][0,1]}\\*#{mnm2[i2]}")
              f.push("#{mnm2[i2]}#{mnm3[i3]}#{wpn[2][0,1]}\\*#{mnm[i]}")
              f.push("#{mnm[i]}#{mnm3[i3]}#{mnm2[i2]}#{wpn[2][0,1]}\\*")
              f.push("#{mnm2[i2]}#{mnm3[i3]}#{mnm[i]}#{wpn[2][0,1]}\\*")
              f.push("#{wpn[2][0,1]}\\*#{mnm[i]}#{mnm3[i3]}#{mnm2[i2]}")
              f.push("#{wpn[2][0,1]}\\*#{mnm2[i2]}#{mnm3[i3]}#{mnm[i]}")
              f.push("#{mnm[i]}#{wpn[2][0,1]}\\*#{mnm3[i3]}#{mnm2[i2]}")
              f.push("#{mnm2[i2]}#{wpn[2][0,1]}\\*#{mnm3[i3]}#{mnm[i]}")
              f.push("#{mnm[i]}#{mnm2[i2]}#{mnm3[i3]}#{wpn[2][0,1]}\\*")
              f.push("#{mnm2[i2]}#{mnm[i]}#{mnm3[i3]}#{wpn[2][0,1]}\\*")
              f.push("#{wpn[2][0,1]}\\*#{mnm[i]}#{mnm2[i2]}#{mnm3[i3]}")
              f.push("#{wpn[2][0,1]}\\*#{mnm2[i2]}#{mnm[i]}#{mnm3[i3]}")
              f.push("#{mnm[i]}#{wpn[2][0,1]}\\*#{mnm2[i2]}#{mnm3[i3]}")
              f.push("#{mnm2[i2]}#{wpn[2][0,1]}\\*#{mnm[i]}#{mnm3[i3]}")
              f.push("#{mnm[i]}#{mnm2[i2]}#{wpn[2][0,1]}\\*#{mnm3[i3]}")
              f.push("#{mnm2[i2]}#{mnm[i]}#{wpn[2][0,1]}\\*#{mnm3[i3]}")
            end
          end
        end
      end
    end
    for i in 0...n.length
      if n[i][1]==wpn[0]
        if event.server.nil? && !n[i][2].nil?
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        elsif n[i][2].nil?
          f.push(n[i][0].gsub('_','\\_')) unless mode==1
        else
          f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
        end
      end
    end
  elsif !enm.nil?
    n=@aliases.reject{|q| !['Enemy'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
    k=0
    k=event.server.id unless event.server.nil?
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{enm[0]}#{enemy_emoji(enm,bot)}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(enm[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if enm[0].include?('(') || enm[0].include?(')') || enm[0].include?(' ') || enm[0].include?('!') || enm[0].include?('_') || enm[0].include?('?') || enm[0].include?("'") || enm[0].include?('"')
    end
    for i in 0...n.length
      if n[i][1]==enm[0]
        if event.server.nil? && !n[i][2].nil?
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        elsif n[i][2].nil?
          f.push(n[i][0].gsub('_','\\_')) unless mode==1
        else
          f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
        end
      end
    end
  elsif !skl.nil?
    n=@aliases.reject{|q| !['Skill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
    k=0
    k=event.server.id unless event.server.nil?
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{skl[0]}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(skl[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if skl[0].include?('(') || skl[0].include?(')') || skl[0].include?(' ') || skl[0].include?('!') || skl[0].include?('_') || skl[0].include?('?') || skl[0].include?("'") || skl[0].include?('"')
    end
    for i in 0...n.length
      if n[i][1]==skl[0]
        if event.server.nil? && !n[i][2].nil?
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        elsif n[i][2].nil?
          f.push(n[i][0].gsub('_','\\_')) unless mode==1
        else
          f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
        end
      end
    end
  elsif !abl.nil?
    abl=abl[0] if abl[0].is_a?(Array) && abl.length<=1
    k=0
    k=event.server.id unless event.server.nil?
    n=@aliases.reject{|q| !['Ability'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    if abl[0].is_a?(Array)
      f.push("__**#{abl[0][0]}**__#{"'s server-specific aliases" if mode==1}")
      unless mode==1
        f.push(abl[0][0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if abl[0][0].include?('(') || abl[0][0].include?(')') || abl[0][0].include?(' ') || abl[0][0].include?('!') || abl[0][0].include?('_') || abl[0][0].include?('?') || abl[0][0].include?("'") || abl[0][0].include?('"')
      end
      for i in 0...n.length
        if n[i][1]==abl[0][0]
          if event.server.nil? && !n[i][2].nil?
            a=[]
            for j in 0...n[i][2].length
              srv=(bot.server(n[i][2][j]) rescue nil)
              unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
                a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
              end
            end
            f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
          elsif n[i][2].nil?
            f.push(n[i][0].gsub('_','\\_')) unless mode==1
          else
            f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
          end
        end
      end
      for i2 in 0...abl.length
        unless abl[i2][1]=='example'
          f.push("\n__**#{abl[i2][0]} #{'+' if abl[i2][1].include?('%')}#{abl[i2][1]}**__#{"'s server-specific aliases" if mode==1}")
          unless mode==1
            f.push("#{abl[i2][0]}#{abl[i2][1]}".gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"',''))
            if abl[i2][1].include?('%')
              f.push("#{abl[i2][0]}#{abl[i2][1]}".gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"',''))
              f.push("#{abl[i2][0]}#{abl[i2][1].gsub('%','')}".gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"',''))
              f.push("#{abl[i2][0]}+#{abl[i2][1].gsub('%','')}".gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"',''))
            end
          end
          for i in 0...n.length
            if n[i][1]=="#{abl[i2][0]} #{abl[i2][1]}"
              if event.server.nil? && !n[i][2].nil?
                a=[]
                for j in 0...n[i][2].length
                  srv=(bot.server(n[i][2][j]) rescue nil)
                  unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
                    a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
                  end
                end
                f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
              elsif n[i][2].nil?
                f.push(n[i][0].gsub('_','\\_')) unless mode==1
              else
                f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
              end
            end
          end
        end
      end
    else
      f.push("__**#{abl[0]} #{'+' if abl[1].include?('%')}#{abl[1]}**__#{"'s server-specific aliases" if mode==1}")
      unless mode==1
        f.push("#{abl[0]}#{abl[1]}".gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"',''))
        if abl[i2][1].include?('%')
          f.push("#{abl[0]}#{abl[1]}".gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"',''))
          f.push("#{abl[0]}#{abl[1].gsub('%','')}".gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"',''))
          f.push("#{abl[0]}+#{abl[1].gsub('%','')}".gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"',''))
        end
      end
      for i in 0...n.length
        if n[i][1]=="#{abl[0]} #{abl[1]}"
          if event.server.nil? && !n[i][2].nil?
            a=[]
            for j in 0...n[i][2].length
              srv=(bot.server(n[i][2][j]) rescue nil)
              unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
                a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
              end
            end
            f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
          elsif n[i][2].nil?
            f.push(n[i][0].gsub('_','\\_')) unless mode==1
          else
            f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
          end
        end
      end
    end
  elsif !fac.nil?
    fac=fac[0] if fac[0].is_a?(Array)
    k=0
    k=event.server.id unless event.server.nil?
    n=@aliases.reject{|q| !['Facility'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{fac[0]}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(fac[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if fac[0].include?('(') || fac[0].include?(')') || fac[0].include?(' ') || fac[0].include?('!') || fac[0].include?('_') || fac[0].include?('?') || fac[0].include?("'") || fac[0].include?('"')
    end
    for i in 0...n.length
      if n[i][1]==fac[0]
        if event.server.nil? && !n[i][2].nil?
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        elsif n[i][2].nil?
          f.push(n[i][0].gsub('_','\\_')) unless mode==1
        else
          f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
        end
      end
    end
  elsif !mat.nil?
    n=@aliases.reject{|q| !['Material'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
    k=0
    k=event.server.id unless event.server.nil?
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{mat[0]}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(mat[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if mat[0].include?('(') || mat[0].include?(')') || mat[0].include?(' ') || mat[0].include?('!') || mat[0].include?('_') || mat[0].include?('?') || mat[0].include?("'") || mat[0].include?('"')
    end
    for i in 0...n.length
      if n[i][1]==mat[0]
        if event.server.nil? && !n[i][2].nil?
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\\_')} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        elsif n[i][2].nil?
          f.push(n[i][0].gsub('_','\\_')) unless mode==1
        else
          f.push("#{n[i][0].gsub('_','\\_')}#{" *(in this server only)*" unless mode==1}") if n[i][2].include?(k)
        end
      end
    end
  end
  f.uniq!
  if f.length>50 && !safe_to_spam?(event)
    event.respond "There are so many aliases that I don't want to spam the server.  Please use the command in PM."
    return nil
  elsif event.user.id==328380949484011532 && !event.server.nil? && f.length>25
    event.respond "There are so many aliases that I don't want to spam the server.  Please use the command in PM."
    return nil
  end
  msg=''
  for i in 0...f.length
    msg=extend_message(msg,f[i],event)
  end
  event.respond msg
  return nil
end

def snagstats(event,bot,f=nil,f2=nil)
  nicknames_load()
  data_load()
  metadata_load()
  f='' if f.nil?
  f2='' if f2.nil?
  bot.servers.values(&:members)
  k=bot.servers.values.length
  k=1 if @shardizard==4 # Debug shard shares the five emote servers with the main account
  @server_data[0][@shardizard]=k
  @server_data[1][@shardizard]=bot.users.size
  metadata_save()
  if ['servers','server','members','member','shard','shards','user','users'].include?(f.downcase)
    str="**I am in #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x })} servers.**"
    for i in 0...@shards
      m=i
      m=i+1 if i>3
      str=extend_message(str,"The #{shard_data(0,true)[i]} Shard is in #{longFormattedNumber(@server_data[0][m])} server#{"s" if @server_data[0][m]!=1}.",event)
    end
    str=extend_message(str,"The #{shard_data(0)[4]} Shard is in #{longFormattedNumber(@server_data[0][4])} server#{"s" if @server_data[0][4]!=1}.",event,2) if event.user.id==167657750971547648
    if bot.profile.id==618979409059119113
      str="This cloned version of Botan is in #{longFormattedNumber(@server_data[0][0])} server#{"s" if @server_data[0][0]!=1}, reaching #{longFormattedNumber(@server_data[1][0])} unique members."
    end
    event.respond str
    return nil
  elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(f.downcase)
    adv=@adventurers.map{|q| q}
    adv=find_in_adventurers(bot,event,[f2],2)[1] unless f2.nil? || f2.length<=0
    str="**There are #{adv.length} adventurers, including:**"
    adv=adv.reject{|q| q[0]=='Puppy'}
    str2=''
    for i in 0...@max_rarity[0]
      m=adv.reject{|q| q[1][0,1].to_i != i+1}
      str2="#{str2}\n#{@rarity_stars[0][i+1]} #{m.length} #{['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'][i]}-star adventurer#{'s' unless m.length==1}" if m.length>0
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q[2][1]!='Flame'}
    str2="<:Element_Flame:532106087952810005> #{m.length} Flame-element adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][1]!='Water'}
    str2="#{str2}\n<:Element_Water:532106088221376522> #{m.length} Water-element adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][1]!='Wind'}
    str2="#{str2}\n<:Element_Wind:532106087948746763> #{m.length} Wind-element adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][1]!='Light'}
    str2="#{str2}\n<:Element_Light:532106088129101834> #{m.length} Light-element adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][1]!='Shadow'}
    str2="#{str2}\n<:Element_Shadow:532106088154267658> #{m.length} Shadow-element adventurer#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q[2][2]!='Sword'}
    str2="<:Weapon_Sword:532106114540634113> #{m.length} Sword-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][2]!='Blade'}
    str2="#{str2}\n<:Weapon_Blade:532106114628714496> #{m.length} Blade-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][2]!='Dagger'}
    str2="#{str2}\n<:Weapon_Dagger:532106116025286656> #{m.length} Dagger-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][2]!='Axe'}
    str2="#{str2}\n<:Weapon_Axe:532106114188443659> #{m.length} Axe-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][2]!='Bow'}
    str2="#{str2}\n<:Weapon_Bow:532106114909732864> #{m.length} Bow-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][2]!='Lance'}
    str2="#{str2}\n<:Weapon_Lance:532106114792423448> #{m.length} Lance-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][2]!='Wand'}
    str2="#{str2}\n<:Weapon_Wand:532106114985099264> #{m.length} Wand-using adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][2]!='Staff'}
    str2="#{str2}\n<:Weapon_Staff:532106114733441024> #{m.length} Staff-using adventurer#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q[2][0]!='Attack'}
    str2="<:Type_Attack:532107867520630784> #{m.length} Attack-class adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][0]!='Defense'}
    str2="#{str2}\n<:Type_Defense:532107867264909314> #{m.length} Defense-class adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][0]!='Support'}
    str2="#{str2}\n<:Type_Support:532107867575156747> #{m.length} Support-class adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][0]!='Healer'}
    str2="#{str2}\n<:Type_Healing:532107867348533249> #{m.length} Healing-class adventurer#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      str2=''
      m=adv.reject{|q| q[1][1,1]!='y'}
      str2="#{m.length} story adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1].length>1}
      str2="#{str2}\n#{m.length} summonable adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='w'}
      str2="#{str2}\n#{m.length} welfare adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='s'}
      str2="#{str2}\n#{m.length} seasonal adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='f'}
      str2="#{str2}\n#{m.length} former-seasonal adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='-'}
      str2="#{str2}\n#{m.length} unavailable adventurer#{'s' unless m.length==1}" if m.length>0
      str2="#{str2}\n1 good boi"
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['dragon','dragons','drag','drags','drg','drgs'].include?(f.downcase)
    adv=@dragons.map{|q| q}
    adv=find_in_dragons(bot,event,[f2],2)[1] unless f2.nil?
    str="**There are #{adv.length} dragons, including:**"
    adv=adv.reject{|q| q[0]=='Puppy'}
    str2=''
    for i in 0...@max_rarity[1]
      m=adv.reject{|q| q[1][0,1].to_i != i+1}
      str2="#{str2}\n#{@rarity_stars[0][i+1]} #{m.length} #{['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'][i]}-star dragon#{'s' unless m.length==1}" if m.length>0
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q[2]!='Flame'}
    str2="<:Element_Flame:532106087952810005> #{m.length} Flame-element dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2]!='Water'}
    str2="#{str2}\n<:Element_Water:532106088221376522> #{m.length} Water-element dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2]!='Wind'}
    str2="#{str2}\n<:Element_Wind:532106087948746763> #{m.length} Wind-element dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2]!='Light'}
    str2="#{str2}\n<:Element_Light:532106088129101834> #{m.length} Light-element dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2]!='Shadow'}
    str2="#{str2}\n<:Element_Shadow:532106088154267658> #{m.length} Shadow-element dragon#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    x=['','Juicy Meat/Monday','Kaleidoscope/Tuesday','Floral Circlet/Wednesday','Compelling Book/Thursday','Mana Essence/Friday','']
    for i in 1...6
      m=adv.reject{|q| q[9]!=i}
      str2="#{str2}\n#{m.length} dragon#{'s' unless m.length==1} that prefer #{x[i].split('/')[0]}s, which are available on #{x[i].split('/')[1]}" if m.length>0
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    m=adv.reject{|q| q[10]!='Yes'}
    str2=''
    str2="#{m.length} dragon#{'s' unless m.length==1} that turn towards the source of damage they receive" if m.length>0
    m=adv.reject{|q| q[10]!='No'}
    str2="#{str2}\n#{m.length} dragon#{'s' unless m.length==1} that remain in position when damaged" if m.length>0
    str=extend_message(str,str2,event,2)
    m=adv.reject{|q| q[11]!='Yes'}
    str2="#{m.length} long-range dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[11]!='No'}
    str2="#{str2}\n#{m.length} short-range dragon#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      str2=''
      m=adv.reject{|q| q[1][1,1]!='y'}
      str2="#{m.length} story dragon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1].length>1}
      str2="#{str2}\n#{m.length} summonable dragon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='w'}
      str2="#{str2}\n#{m.length} welfare dragon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='s'}
      str2="#{str2}\n#{m.length} seasonal dragon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='f'}
      str2="#{str2}\n#{m.length} former-seasonal dragon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac dragon#{'s' unless m.length==1}" if m.length>0
      str2="#{str2}\n1 good boi"
      str2=str2[1,str2.length-1] if str2[0,1]=="\n"
      str2=str2[2,str2.length-2] if str2[0,2]=="\n"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(f.downcase)
    adv=@wyrmprints.map{|q| q}
    adv=find_in_wyrmprints(bot,event,[f2],2)[1] unless f2.nil?
    str="**There are #{adv.length} Wyrmprints, including:**"
    str2=''
    for i in 0...@max_rarity[2]
      m=adv.reject{|q| q[1][0,1].to_i != i+1}
      str2="#{str2}\n#{@rarity_stars[0][i+1]} #{m.length} #{['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'][i]}-star wyrmprint#{'s' unless m.length==1}" if m.length>0
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q[2]!='Attack'}
    str2="<:Type_Attack:532107867520630784> #{m.length} Attack-amulet print#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2]!='Defense'}
    str2="#{str2}\n<:Type_Defense:532107867264909314> #{m.length} Defense-amulet print#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2]!='Support'}
    str2="#{str2}\n<:Type_Support:532107867575156747> #{m.length} Support-amulet print#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2]!='Healing'}
    str2="#{str2}\n<:Type_Healing:532107867348533249> #{m.length} Healing-amulet print#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      str2=''
      m=adv.reject{|q| q[1].length>1}
      str2="#{m.length} summonable print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='w'}
      str2="#{str2}\n#{m.length} welfare print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='s'}
      str2="#{str2}\n#{m.length} seasonal print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='f'}
      str2="#{str2}\n#{m.length} former-seasonal print#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac print#{'s' unless m.length==1}" if m.length>0
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(f.downcase)
    adv=@weapons.map{|q| q}
    adv=find_in_weapons(bot,event,[f2],2)[1] unless f2.nil?
    str="**There are #{adv.length} #{'<:Element_Void:548467446734913536> Void ' if find_in_weapons(bot,event,[f2],2)[0].include?('*Filters*: <:Element_Void:548467446734913536> Void')}weapons, including:**"
    m=adv.reject{|q| q[1]!='Sword'}
    str2="<:Weapon_Sword:532106114540634113> #{m.length} Sword#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1]!='Blade'}
    str2="#{str2}\n<:Weapon_Blade:532106114628714496> #{m.length} Blade#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1]!='Dagger'}
    str2="#{str2}\n<:Weapon_Dagger:532106116025286656> #{m.length} Dagger#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1]!='Axe'}
    str2="#{str2}\n<:Weapon_Axe:532106114188443659> #{m.length} Axe#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1]!='Bow'}
    str2="#{str2}\n<:Weapon_Bow:532106114909732864> #{m.length} Bow#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1]!='Lance'}
    str2="#{str2}\n<:Weapon_Lance:532106114792423448> #{m.length} Lance#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1]!='Wand'}
    str2="#{str2}\n<:Weapon_Wand:532106114985099264> #{m.length} Wand#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1]!='Staff'}
    str2="#{str2}\n<:Weapon_Staff:532106114733441024> #{m.length} #{'Staff' if m.length==1}#{'Staves' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    for i in 0...@max_rarity[3]
      m=adv.reject{|q| q[2][0,1].to_i != i+1}
      str2="#{str2}\n#{@rarity_stars[0][i+1]} #{m.length} #{['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'][i]}-star weapon#{'s' unless m.length==1}" if m.length>0
    end
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q[3]!='None'}
    str2="<:Element_Null:532106087810334741> #{m.length} weapon#{'s' unless m.length==1} without an element" if m.length>0
    m=adv.reject{|q| q[3]!='Flame'}
    str2="#{str2}\n<:Element_Flame:532106087952810005> #{m.length} Flame-element weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[3]!='Water'}
    str2="#{str2}\n<:Element_Water:532106088221376522> #{m.length} Water-element weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[3]!='Wind'}
    str2="#{str2}\n<:Element_Wind:532106087948746763> #{m.length} Wind-element weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[3]!='Light'}
    str2="#{str2}\n<:Element_Light:532106088129101834> #{m.length} Light-element weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[3]!='Shadow'}
    str2="#{str2}\n<:Element_Shadow:532106088154267658> #{m.length} Shadow-element weapon#{'s' unless m.length==1}" if m.length>0
    str2=str2[1,str2.length-1] if str2[0,1]=="\n"
    str2=str2[2,str2.length-2] if str2[0,2]=="\n"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      str2=''
      m=adv.reject{|q| q[2].length>1}
      str2="#{m.length} craftable weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[2][1,1]!='w'}
      str2="#{str2}\n#{m.length} welfare weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[2][1,1]!='s'}
      str2="#{str2}\n#{m.length} seasonal weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[2][1,1]!='f'}
      str2="#{str2}\n#{m.length} former-seasonal weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[2][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[2][1,1]!='e'}
      str2="#{str2}\n#{m.length} starter weapon#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[2][1,1]!='p'}
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
    untz=@adventurers.map{|q| q}
    untz2=[]
    for i in 0...untz.length
      m=[]
      m.push('default') if untz[i][0]==untz[i][9][0] || untz[i][9][0][untz[i][9][0].length-1,1]=='*'
      m.push('faceted') if untz[i][9][0][0,1]=='*' && untz[i][9].length>1
      m.push('sensible') if untz[i][9][0][0,1]=='*' && untz[i][9].length<2
      m.push('Gala') if untz[i][0]=="Gala #{untz[i][9][0]}"
      m.push('seasonal') if untz[i][1][1,1]=='s'
      m.push('out-of-left-field') if m.length<=0
      n=''
      unless untz[i][0]==untz[i][9][0] || untz[i][9][0][untz[i][9][0].length-1,1]=='*'
        k=untz.reject{|q| q[9][0].gsub('*','')[0]!=untz[i][9][0].gsub('*','')[0] || q[0]==untz[i][0] || !(q[0]==q[9][0] || q[9][0].include?('*'))}
        n="x" if k.length<=0
      end
      untz2.push([untz[i][0],untz[i][9].map{|q| q.gsub('*','')},m,n,untz[i][13]])
    end
    untz2.uniq!
    all_units=untz2.map{|q| q}
    legal_units=untz2.map{|q| q}
    a2=all_units.reject{|q| q[1][1].nil?}.map{|q| q[1][0]}.uniq
    l2=legal_units.reject{|q| q[1][1].nil?}.map{|q| q[1][0]}.uniq
    str="There are #{untz2.reject{|q| !q[2].include?('default')}.length} adventurers in their default form"
    str="#{str}\nThere are #{untz2.reject{|q| !q[2].include?('sensible')}.length} sensible alts of adventurers"
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
    untz=@dragons.map{|q| q}
    untz2=[]
    for i in 0...untz.length
      m=[]
      m.push('default') if untz[i][0]==untz[i][12][0] || untz[i][12][0][untz[i][12][0].length-1,1]=='*'
      m.push('faceted') if untz[i][12][0][0,1]=='*' && untz[i][12].length>1
      m.push('sensible') if untz[i][12][0][0,1]=='*' && untz[i][12].length<2
      m.push('seasonal') if untz[i][1][1,1]=='s'
      m.push('out-of-left-field') if m.length<=0
      n=''
      unless untz[i][0]==untz[i][12][0] || untz[i][12][0][untz[i][12][0].length-1,1]=='*'
        k=untz.reject{|q| q[12][0].gsub('*','')[0]!=untz[i][12][0].gsub('*','')[0] || q[0]==untz[i][0] || !(q[0]==q[12][0] || q[12][0].include?('*'))}
        n="x" if k.length<=0
      end
      untz2.push([untz[i][0],untz[i][12].map{|q| q.gsub('*','')},m,n,untz[i][13]])
    end
    untz2.uniq!
    all_units=untz2.map{|q| q}
    legal_units=untz2.map{|q| q}
    a2=all_units.reject{|q| q[1][1].nil?}.map{|q| q[1][0]}.uniq
    l2=legal_units.reject{|q| q[1][1].nil?}.map{|q| q[1][0]}.uniq
    str3="There are #{untz2.reject{|q| !q[2].include?('default')}.length} dragons in their default form, alongside #{l2.length} sets of dragon facets (High Dragons)"
    str3="#{str3}\nThere are #{untz2.reject{|q| !q[2].include?('sensible')}.length} sensible alts of dragons"
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
  elsif ['code','lines','line','sloc'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',3)
    b=[[],[],[],[],[]]
    File.open("#{@location}devkit/BotanBot.rb").each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[3].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[1].push(l) unless l.length<=0
    end
    File.open("#{@location}devkit/rot8er_functs.rb").each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[4].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[2].push(l) unless l.length<=0
    end
    File.open("#{@location}devkit/BotanText.rb").each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[4].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[2].push(l) unless l.length<=0
    end
    event << "**I am #{longFormattedNumber(File.foreach("#{@location}devkit/BotanBot.rb").inject(0) {|c, line| c+1})} lines of code long.**"
    event << "Of those, #{longFormattedNumber(b[1].length)} are SLOC (non-empty)."
    event << "~~When fully collapsed, I appear to be #{longFormattedNumber(b[3].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
    event << ''
    event << "**I rely on multiple libraries that in total are #{longFormattedNumber(File.foreach("#{@location}devkit/rot8er_functs.rb").inject(0) {|c, line| c+1}+File.foreach("#{@location}devkit/BotanText.rb").inject(0) {|c, line| c+1})} lines of code long.**"
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
      event << "#{longFormattedNumber(b.reject{|q| q[0,3]!='if '}.length)} `if` trees, along with #{longFormattedNumber(b.reject{|q| q[0,6]!='elsif '}.length)} `elsif` branches and #{longFormattedNumber(b.reject{|q| q[0,4]!='else'}.length)} `else` branches."
      event << "#{longFormattedNumber(b.reject{|q| q[0,7]!='unless '}.length)} `unless` trees."
      event << "#{longFormattedNumber(b.reject{|q| count_in(q,'[')<=count_in(q,']')}.length)} multi-line arrays."
      event << "#{longFormattedNumber(b.reject{|q| count_in(q,'{')<=count_in(q,'}')}.length)} multi-line hashes."
      event << "#{longFormattedNumber(b.reject{|q| q[0,3]=='if ' || !remove_format(remove_format(q,"'"),'"').include?(' if ')}.length)} single-line `if` conditionals."
      event << "#{longFormattedNumber(b.reject{|q| q[0,7]=='unless ' || !remove_format(remove_format(q,"'"),'"').include?(' unless ')}.length)} single-line `unless` conditionals."
      event << "#{longFormattedNumber(b.reject{|q| q[0,7]!='return '}.length)} `return` lines."
    end
    return nil
  elsif ['alias','aliases','name','names','nickname','nicknames'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',1)
    glbl=@aliases.reject{|q| q[0]!='Adventurer' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Adventurer' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    all_units=@adventurers.map{|q| [q[0],0,0,0]}
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
    if event.server.nil? && @shardizard==4
      str2="#{str2}\nDue to being the debug version, I cannot show more information."
    elsif event.server.nil?
      str2="#{str2}\nServers you and I share account for #{@aliases.reject{|q| q[0]!='Adventurer' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those."
    else
      str2="#{str2}\nThis server accounts for #{@aliases.reject{|q| q[0]!='Adventurer' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    k=all_units.reject{|q| q[3]!=all_units.map{|q2| q2[3]}.max}.map{|q| q[0]}
    k=all_units.reject{|q| q[3]!=all_units.map{|q2| q2[3]}.max}.map{|q| q[0]} if k.length>8 && !safe_to_spam?(event)
    str2="#{str2}\nThe adventurer#{"s" unless k.length==1} with the most server-specific aliases #{"is" if k.length==1}#{"are" unless k.length==1} #{list_lift(k,"and")}, with #{all_units.map{|q2| q2[3]}.max} server-specific aliases#{" each" unless k.length==1}." unless all_units.map{|q2| q2[3]}.max<=0
    k=srv_spec.map{|q| q[2].length}.inject(0){|sum,x| sum + x }
    str2="#{str2}\nCounting each alias/server combo as a unique alias, there are #{longFormattedNumber(k)} server-specific aliases"
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Dragon' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Dragon' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global dragon aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific dragon aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Dragon' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Dragon' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Wyrmprint' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Wyrmprint' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global Wyrmprint aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific Wyrmprint aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Wyrmprint' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Wyrmprint' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Weapon' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Weapon' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global weapon aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific weapon aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Weapon' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Weapon' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Enemy' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Enemy' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global enemy aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific enemy aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Weapon' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Weapon' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Skill' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Skill' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global skill aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific skill aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Skill' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Skill' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Ability' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Ability' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global ability aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific ability aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Ability' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Ability' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Facility' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Facility' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global facility aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific facility aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Facility' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Facility' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    glbl=@aliases.reject{|q| q[0]!='Material' || !q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    srv_spec=@aliases.reject{|q| q[0]!='Material' || q[3].nil?}.map{|q| [q[1],q[2],q[3]]}
    str2="**There are #{longFormattedNumber(glbl.length)} global material aliases.**\n**There are #{longFormattedNumber(srv_spec.length)} server-specific material aliases.**"
    if event.server.nil? && @shardizard==4
    elsif event.server.nil?
      str2="#{str2} - Servers you and I share account for #{@aliases.reject{|q| q[0]!='Material' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those"
    else
      str2="#{str2} - This server accounts for #{@aliases.reject{|q| q[0]!='Material' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
    end
    str=extend_message(str,str2,event,2)
    event.respond str
    return nil
  elsif event.user.id==167657750971547648 && !f.nil? && f.to_i.to_s==f
    srv=(bot.server(f.to_i) rescue nil)
    if srv.nil? || bot.user(543373018303299585).on(srv.id).nil?
      s2="I am not in that server, but it would be assigned to the #{shard_data(0,true)[(f.to_i >> 22) % @shards]} class."
    else
      s2="__**#{srv.name}** (#{srv.id})__\n*Owner:* #{srv.owner.distinct} (#{srv.owner.id})\n*Shard:* #{shard_data(0,true)[(f.to_i >> 22) % @shards]}\n*My nickname:* #{bot.user(543373018303299585).on(srv.id).display_name}"
    end
    event.respond s2
    return nil
  end
  glbl=@aliases.reject{|q| q[0]!='Adventurer' || !q[3].nil?}
  srv_spec=@aliases.reject{|q| q[0]!='Adventurer' || q[3].nil?}
  b=[]
  File.open("#{@location}devkit/BotanBot.rb").each_line do |line|
    l=line.gsub(' ','').gsub("\n",'')
    b.push(l) unless l.length<=0
  end
  event << "**I am in #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x })} *servers*, reaching #{longFormattedNumber(@server_data[1].inject(0){|sum,x| sum + x })} unique members.**"
  event << "This shard is in #{longFormattedNumber(@server_data[0][@shardizard])} server#{"s" unless @server_data[0][@shardizard]==1}, reaching #{longFormattedNumber(bot.users.size)} unique members."
  event << ''
  event << "**There are #{longFormattedNumber(@adventurers.length)} *adventurers*.**"
  event << "**There are #{longFormattedNumber(@dragons.length)} *dragons*.**"
  event << "**There are #{longFormattedNumber(@wyrmprints.length)} *wyrmprints*.**"
  event << "**There are #{longFormattedNumber(@weapons.length)} *weapons*.**"
  event << ''
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='Skill'}.length)} skills."
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='Aura'}.length)} dragon auras, split into #{longFormattedNumber(@askilities.reject{|q| q[2]!='Aura'}.map{|q| q[0].split(') ')[-1]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='Ability'}.length)} abilities, split into #{longFormattedNumber(@askilities.reject{|q| q[2]!='Ability'}.map{|q| q[0].split(') ')[-1]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='CoAbility'}.length)} co-abilities, split into #{longFormattedNumber(@askilities.reject{|q| q[2]!='CoAbility'}.map{|q| q[0]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='Chain'}.length)} chain co-abilities, split into #{longFormattedNumber(@askilities.reject{|q| q[2]!='Chain'}.map{|q| q[0]}.uniq.length)} families."
  event << ''
  event << "There are #{longFormattedNumber(@facilities.map{|q| q[0]}.uniq.length)} [unique] facilities with #{@facilities.length} total levels between them."
  event << "There are #{longFormattedNumber(@mats.length)} materials."
  event << ''
  event << "**There are #{longFormattedNumber(glbl.length)} global and #{longFormattedNumber(srv_spec.length)} server-specific *aliases*.**"
  event << ''
  event << "**I am #{longFormattedNumber(File.foreach("#{@location}devkit/BotanBot.rb").inject(0) {|c, line| c+1})} lines of *code* long.**"
  event << "Of those, #{longFormattedNumber(b.length)} are SLOC (non-empty)."
  return nil
end
