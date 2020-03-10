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
    create_embed(event,"**#{command.downcase}** __type__","Shows SP gains for adventurers with the weapon type `type`.\nIf an adventurer's name is listed, shows their SP gains.\nIf a weapon's name is listed, shows SP gains for that weapon's type.\nIf no type, adventurer, or weapon is specified, and in PM, shows the entire SP gains table.",0xCE456B)
  elsif ['dmg','damage'].include?(command.downcase)
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
  elsif ['aura'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the aura named `name` does.  Also shows all dragons that have the aura.",0xCE456B)
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
    elsif ['abil','abilities','ability','abils','abilitys'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all abilities, dragon auras, and co-abilities that fit `filters`.\n\nYou can search by:\n- Ability Class (ability/aura/coability)\n- Element\n- Tags\n\nIf too many abilities are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
      lookout=[]
      if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
        lookout=[]
        File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
          lookout.push(eval line)
        end
      end
      w=lookout.reject{|q| q[2]!='Ability'}.map{|q| q[0]}.sort
      create_embed(event,'Tags','',0x40C0F0,nil,nil,triple_finish(w)) if safe_to_spam?(event)
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
    w=lookout.reject{|q| q[2]!='Skill'}.map{|q| q[0]}.sort
    create_embed(event,'Tags','',0x40C0F0,nil,nil,triple_finish(w)) if safe_to_spam?(event) && !['mat','mats','material','materials','item','items','abil','abilities','ability','abils','abilitys','enemies','boss','enemy','bosses','enemie','enemys','bosss'].include?(subcommand.downcase)
  elsif ['aliases','checkaliases','seealiases','alias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s aliases.\nIf no name is listed, responds with a list of all aliases and who/what they are for.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n- Facilities\n- Materials\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
  elsif ['saliases','serveraliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s server-specific aliases.\nIf no name is listed, responds with a list of all server-specific aliases and who/what they are for.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n- Facilities\n- Materials\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
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
    str="#{str}\n`aura` __name__ - for data on a particular aura"
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
    str="#{str}\n`sp` __types__ - shows SP gains for weapon types"
    str="#{str}\n`damage` __types__ - shows damage modifiers for weapon types"
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
  if wpn.length<=0
    k=find_data_ex(:find_adventurer,args.join(' '),event)
    if k.nil? || k.length<=0
      k=find_data_ex(:find_weapon,args.join(' '),event)
      unless k.nil? || k.length<=0
        wpn.push(k[1])
        k=nil
      end
    elsif !k[19].nil? && k[19].length>0
      f=[]
      m=[0,'First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth','Tenth','Eleventh','Twelfth','Thirteenth','Fourteenth','Fifteenth',
         '16th','17th','18th','19th','20th','21st','22nd','23rd','24th','25th','26th','27th','28th','29th','30th','31st','32nd','33rd','34th','35th','36th',
         '37th','38th','39th','40th','41st','42nd','43rd','44th','45th','46th','47th','48th','49th','50th']
      k2=[1,2,3,4,5,6,7]
      k2=[75,80,95,100,150,95,'104% L1, 115% L2'] if k[2][2]=='Sword'
      k2=[97,97,63,129,'194% uncharged, 143% charged',94,"83% L1, 92% L2"] if k[2][2]=='Blade'
      k2=[75,38,54,119,119,89,"43.20% L1, 47% L2"] if k[2][2]=='Dagger'
      k2=[114,122,204,216,228,73,"173% L1, 192% L2"] if k[2][2]=='Axe'
      k2=[84,45,108,150,112,89,"27% L1, 30% L2"] if k[2][2]=='Lance'
      k2=[29,37,42,63,35,30,"28% L1, 31% L2"] if k[2][2]=='Bow'
      k2=[98,53,36,78,"61.8% big ball, 36.05% small projectile",100,"81% L1, 90% L2"] if k[2][2]=='Wand'
      k2=[69,80,45,150,196,80,"55% L1, 61% L2"] if k[2][2]=='Staff'
      if k[19].length==1
        if ['Dash','DA'].include?(k[19][0][0])
          k2[5]=k[19][0][-1]
        else
          k2[6]=k[19][0][-1]
          k2[5]=k[19][0][-2] if k[19][0].length>2
        end
        for i in 0...k2.length
          k2[i]="#{k2[i]}%" unless k2[i].is_a?(String)
        end
        if k[19][0].length>3
          ff=[]
          for i2 in 1...k[19][0].length-2
            ff.push("*#{m[i2]} Hit:* #{k[19][0][i2]}#{'%' if k[19][0][i2].to_i.to_s==k[19][0][i2]}")
          end
          ff.push("\n**Dash Attack:** #{k[19][0][-2]}#{'%' if k[19][0][-2].to_i.to_s==k[19][0][-2]}") unless k[19][0][-2].to_i==k2[5]
          ff.push("\n**Force Strike:** #{k[19][0][-1]}#{'%' if k[19][0][-1].to_i.to_s==k[19][0][-1]}") unless k[19][0][-1].to_i==k2[6]
          disp=ff.join("\n")
        else
          disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n~~*Total: #{k2[7]}*~~\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
        end
      else
        disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n~~*Total: #{k2[7]}*~~\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
      end
      if k[19].length>1
        for i in 0...k[19].length
          ff=[]
          for i2 in 1...k[19][i].length-2
            ff.push("*#{m[i2]} Hit:* #{k[19][i][i2]}")
          end
          ff.push("\n**Dash Attack:** #{k[19][i][-2]}") unless k[19][i][-2].to_i==k2[5]
          ff.push("\n**Force Strike:** #{k[19][i][-1]}") unless k[19][i][-1].to_i==k2[6]
          f.push([k[19][i][0],ff.join("\n")])
        end
      else
        f=nil
      end
      dispname=k[0].gsub(' ','_')
      xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Adventurers/#{dispname}_#{k[1][0,1]}.png?raw=true"
      create_embed(event,"__Damage modifiers gains for **#{k[0]}#{adv_emoji(k,bot)}**__",disp,element_color(k[2][1]),nil,xpic,f)
      return nil
    else
      wpn.push(k[2][2])
      k=nil
    end
  end
  if wpn.length<=0 && !safe_to_spam?(event)
    event.respond "The complete table is too large.  Please either specify a weapon type or use this command in PM."
  elsif wpn.length<=0
    kx=[[75,80,95,100,150,95,"104% L1, 115% L2"],[97,97,63,129,"194% uncharged, 143% charged",94,"83% L1, 92% L2"],[75,38,54,119,119,89,"43.20% L1, 47% L2"],
        [114,122,204,216,228,73,"173% L1, 192% L2"],[84,45,108,150,112,89,"27% L1, 30% L2"],[29,37,42,63,35,30,"28% L1, 31% L2"],
        [98,53,36,78,"61.8% big ball, 36.05% small projectile",100,"81% L1, 90% L2"],[69,80,45,150,196,80,"55% L1, 61% L2"]]
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
    create_embed(event,"__**SP gains**__",'',0xCE456B,nil,nil,f)
  else
    k=[1,2,3,4,5,6,7]
    k=[75,80,95,100,150,95,"104% L1, 115% L2"] if wpn[0]=='Sword'
    k=[97,97,63,129,"194% uncharged, 143% charged",94,"83% L1, 92% L2"] if wpn[0]=='Blade'
    k=[75,38,54,119,119,89,"43.20% L1, 47% L2"] if wpn[0]=='Dagger'
    k=[114,122,204,216,228,73,"173% L1, 192% L2"] if wpn[0]=='Axe'
    k=[84,45,108,150,112,89,"27% L1, 30% L2"] if wpn[0]=='Lance'
    k=[29,37,42,63,35,30,"28% L1, 31% L2"] if wpn[0]=='Bow'
    k=[98,53,36,78,"61.8% big ball, 36.05% small projectile",100,"81% L1, 90% L2"] if wpn[0]=='Wand'
    k=[69,80,45,150,196,80,"55% L1, 61% L2"] if wpn[0]=='Staff'
    for i in 0...k.length
      k[i]="#{k[i]}%" unless k[i].is_a?(String)
    end
    m=''
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[0]}"}
    m=moji[0].mention unless moji.length<=0
    disp="__**Combo:**__\n*First Hit:* #{k[0]}\n*Second Hit:* #{k[1]}\n*Third Hit:* #{k[2]}\n*Fourth Hit:* #{k[3]}\n*Fifth Hit:* #{k[4]}\n\n**Dash Attack:** #{k[5]}\n\n**Force Strike** #{k[6]}"
    create_embed(event,"__Damage modifiers gains for **#{m}#{wpn[0]}** users__",disp,0xCE456B)
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
      k2=[130,130,220,360,'660 uncharged, 900 charged',104,200,'1500 uncharged, 1740 charged'] if k[2][2]=='Blade'
      k2=[144,144,264,288,288,132,288,1128] if k[2][2]=='Dagger'
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
            ff.push("~~*Total:* #{t}~~")
          end
          ff.push("\n**Dash Attack:** #{k[18][0][-2]}") unless k[18][0][-2].to_i==k2[5]
          ff.push("\n**Force Strike:** #{k[18][0][-1]}") unless k[18][0][-1].to_i==k2[6]
          disp=ff.join("\n")
        else
          disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n~~*Total: #{k2[7]}*~~\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
        end
      else
        disp="__**Combo:**__\n*First Hit:* #{k2[0]}\n*Second Hit:* #{k2[1]}\n*Third Hit:* #{k2[2]}\n*Fourth Hit:* #{k2[3]}\n*Fifth Hit:* #{k2[4]}\n~~*Total: #{k2[7]}*~~\n\n**Dash Attack:** #{k2[5]}\n\n**Force Strike** #{k2[6]}"
      end
      if k[18].length>1
        for i in 0...k[18].length
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
            ff.push("~~*Total:* #{t}~~")
          end
          ff.push("\n**Dash Attack:** #{k[18][i][-2]}") unless k[18][i][-2].to_i==k2[5]
          ff.push("\n**Force Strike:** #{k[18][i][-1]}") unless k[18][i][-1].to_i==k2[6]
          f.push([k[18][i][0],ff.join("\n")])
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
    kx=[[150,150,196,265,391,143,345,1152],[130,130,220,360,'660 uncharged, 900 charged',104,200,'1500 uncharged, 1740 charged'],
        [144,144,264,288,288,132,288,1128],[200,240,360,380,420,160,300,1600],[120,240,120,480,600,111,400,1560],[184,92,276,414,529,208,460,1495],
        [130,200,240,430,600,156,400,1600],[232,232,348,464,696,300,580,1972]]
    k=kx.map{|q| "__**Combo:**__\n*First Hit:* #{q[0]}\n*Second Hit:* #{q[1]}\n*Third Hit:* #{q[2]}\n*Fourth Hit:* #{q[3]}\n*Fifth Hit:* #{q[4]}\n~~*Total:* #{q[7]}~~\n\n**Dash Attack:** #{q[5]}\n**Force Strike** #{q[6]}"}
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
    k=[130,130,220,360,'660 uncharged, 900 charged',104,200,'1500 uncharged, 1740 charged'] if wpn[0]=='Blade'
    k=[144,144,264,288,288,132,288,1128] if wpn[0]=='Dagger'
    k=[200,240,360,380,420,160,300,1600] if wpn[0]=='Axe'
    k=[120,240,120,480,600,111,400,1560] if wpn[0]=='Lance'
    k=[184,92,276,414,529,208,460,1495] if wpn[0]=='Bow'
    k=[130,200,240,430,600,156,400,1600] if wpn[0]=='Wand'
    k=[232,232,348,464,696,300,580,1972] if wpn[0]=='Staff'
    m=''
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[0]}"}
    m=moji[0].mention unless moji.length<=0
    disp="__**Combo:**__\n*First Hit:* #{k[0]}\n*Second Hit:* #{k[1]}\n*Third Hit:* #{k[2]}\n*Fourth Hit:* #{k[3]}\n*Fifth Hit:* #{k[4]}\n~~*Total: #{k[7]}*~~\n\n**Dash Attack:** #{k[5]}\n\n**Force Strike** #{k[6]}"
    create_embed(event,"__SP gains for **#{m}#{wpn[0]}** users__",disp,0xCE456B)
  end
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
    str="**I am in #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x })} servers, reaching #{longFormattedNumber(@server_data[1].inject(0){|sum,x| sum + x })} unique members.**"
    for i in 0...@shards
      m=i
      m=i+1 if i>3
      str=extend_message(str,"The #{shard_data(0,true)[i]} Shard is in #{longFormattedNumber(@server_data[0][m])} server#{"s" if @server_data[0][m]!=1}, reaching #{longFormattedNumber(@server_data[1][m])} unique members.",event)
    end
    str=extend_message(str,"The #{shard_data(0)[4]} Shard is in #{longFormattedNumber(@server_data[0][4])} server#{"s" if @server_data[0][4]!=1}, reaching #{longFormattedNumber(@server_data[1][4])} unique members.",event,2) if event.user.id==167657750971547648
    if bot.profile.id==618979409059119113
      str="This cloned version of Botan is in #{longFormattedNumber(@server_data[0][0])} server#{"s" if @server_data[0][0]!=1}, reaching #{longFormattedNumber(@server_data[1][0])} unique members."
    end
    event.respond str
    return nil
  elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(f.downcase)
    adv=@adventurers.map{|q| q}
    adv=find_in_adventurers(bot,event,[f2],2)[1] unless f2.nil? || f2.length<=0
    str="**There are #{adv.length} adventurers, including:**"
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
      m=adv.reject{|q| q[1][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac adventurer#{'s' unless m.length==1}" if m.length>0
      m=adv.reject{|q| q[1][1,1]!='-'}
      str2="#{str2}\n#{m.length} unavailable adventurer#{'s' unless m.length==1}" if m.length>0
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
      m=adv.reject{|q| q[1][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac dragon#{'s' unless m.length==1}" if m.length>0
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
      m=adv.reject{|q| q[1][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac print#{'s' unless m.length==1}" if m.length>0
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(f.downcase)
    adv=@weapons.map{|q| q}
    adv=find_in_weapons(bot,event,[f2],2)[1] unless f2.nil?
    str="**There are #{adv.length} #{'<:Element_Void:548467446734913536> Void' if find_in_weapons(bot,event,[f2],2)[0].include?('*Filters*: <:Element_Void:548467446734913536> Void')} weapons, including:**"
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
    event << "~~When fully collapsed, it appears to be #{longFormattedNumber(b[4].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
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
