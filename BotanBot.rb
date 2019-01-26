@shardizard=ARGV.first.to_i              # taking a single variable from the command prompt to get the shard value
system("color 0#{"BCADF"[@shardizard,1]}")
system("title loading #{['Defense','Attack','Healing','Support','Null'][@shardizard]} BotanBot")

require 'discordrb'                    # Download link: https://github.com/meew0/discordrb
require 'open-uri'                     # pre-installed with Ruby in Windows
require 'net/http'                     # pre-installed with Ruby in Windows
require 'certified'
require 'tzinfo/data'                  # Downloaded with active_support below, but the require must be above active_support's require
require 'rufus-scheduler'              # Download link: https://github.com/jmettraux/rufus-scheduler
require 'active_support/core_ext/time' # Download link: https://rubygems.org/gems/activesupport/versions/5.0.0
require_relative 'rot8er_functs'       # functions I use commonly in bots

@prefix=['DL!','Dl!','dL!','dl!',
         'DL?','Dl?','dL?','dl?']

# The bot's token is basically their password, so is censored for obvious reasons
if @shardizard==4
  bot = Discordrb::Commands::CommandBot.new token: '>Debug Token<', client_id: >Debug ID<, prefix: @prefix
else
  bot = Discordrb::Commands::CommandBot.new token: '>Token<', shard_id: @shardizard, num_shards: 4, client_id: >ID<, prefix: @prefix
end
bot.gateway.check_heartbeat_acks = false

@adventurers=[]
@dragons=[]
@wyrmprints=[]
@weapons=[]

@askilities=[]

@aliases=[]
@spam_channels=[]
@server_data=[[],[]]
@ignored=[]
@embedless=[]

def all_commands(include_nil=false,permissions=-1)
  return all_commands(include_nil)-all_commands(false,1)-all_commands(false,2) if permissions==0
  k=['reboot','adventurer','adv','addalias','checkaliases','aliases','seealiases','saliases','serveraliases','deletealias','removealias','channellist','long',
     'channelist','spamlist','spamchannels','bugreport','suggestion','feedback','donation','donate','shard','attribute','safe','spam','safetospam','safe2spam',
     'longreplies','sortaliases','status','backupaliases','restorealiases','sendmessage','sendpm','ignoreuser','leaveserver','cleanupaliases','snagstats','find',
     'search','dragon','help','wyrmprint','wyrm','print','weapon','wep','weap','wpn','skill','skil','ability','abil','aura','roost','today','ruin','ruins',
     'daily','now','dailies','todayindl','today_in_dl','tomorrow','tommorrow','tomorow','tommorow']
  k=['addalias','deletealias','removealias','s2s'] if permissions==1
  k=['reboot','sortaliases','status','backupaliases','restorealiases','sendmessage','sendpm','ignoreuser','leaveserver','cleanupaliases'] if permissions==2
  k=k.uniq
  k.push(nil) if include_nil
  return k
end

def safe_to_spam?(event,chn=nil) # determines whether or not it is safe to send extremely long messages
  return true if event.server.nil? # it is safe to spam in PM
  return true if [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(event.server.id) # it is safe to spam in the emoji servers
  chn=event.channel if chn.nil?
  return true if ['bots','bot'].include?(chn.name.downcase) # channels named "bots" are safe to spam in
  return true if chn.name.downcase.include?('bot') && chn.name.downcase.include?('spam') # it is safe to spam in any bot spam channel
  return true if chn.name.downcase.include?('bot') && chn.name.downcase.include?('command') # it is safe to spam in any bot spam channel
  return true if chn.name.downcase.include?('bot') && chn.name.downcase.include?('channel') # it is safe to spam in any bot spam channel
  return true if chn.name.downcase.include?('botanbot')  # it is safe to spam in channels designed specifically for BotanBot
  return true if chn.name.downcase.include?('botan-bot')
  return true if chn.name.downcase.include?('botan_bot')
  return true if chn.name.downcase.include?('buttonbot')  # it is safe to spam in channels designed specifically for ButtonBot
  return true if chn.name.downcase.include?('button-bot')
  return true if chn.name.downcase.include?('button_bot')
  return true if @spam_channels[0].include?(chn.id)
  return false
end

def data_load()
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLAdventurers.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLAdventurers.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][2]=b[i][2].split(', ')
    b[i][3]=b[i][3].split('; ').map{|q| q.split(', ').map{|q2| q2.to_i}}
    b[i][4]=b[i][4].split('; ').map{|q| q.split(', ').map{|q2| q2.to_i}}
    b[i][5]=b[i][5].to_i
    b[i][6]=b[i][6].split(';; ')
    b[i][8]=b[i][8].split(';;;; ').map{|q| q.split(';; ')}
  end
  @adventurers=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLDragons.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLDragons.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][3]=b[i][3].split(', ').map{|q| q.to_i}
    b[i][4]=b[i][4].split(', ').map{|q| q.to_i}
    b[i][6]=b[i][6].split(';;;; ').map{|q| q.split(';; ')}
    b[i][7]=b[i][7].split(', ').map{|q| q.to_i}
    b[i][8]=b[i][8].split(', ').map{|q| q.to_f}
    b[i][9]=b[i][9].to_i
  end
  @dragons=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLWyrmprints.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLWyrmprints.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][3]=b[i][3].split(', ').map{|q| q.to_i}
    b[i][4]=b[i][4].split(', ').map{|q| q.to_i}
    b[i][5]=b[i][5].split(';;;; ').map{|q| q.split(';; ')}
    b[i][6]=b[i][6].split(', ').map{|q| q.to_i}
  end
  @wyrmprints=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLWeapons.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLWeapons.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][4]=b[i][4].split(', ').map{|q| q.to_i}
    b[i][5]=b[i][5].split(', ').map{|q| q.to_i}
    b[i][7]=b[i][7].split(', ').map{|q| q.to_i}
    b[i][11]=b[i][11].split(', ').map{|q| q.to_i}
    b[i][12]=b[i][12].split(';; ').map{|q| q.split(', ')} unless b[i][12].nil?
  end
  @weapons=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSkills.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSkills.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    if b[i][2]=='Skill'
      b[i][6]=b[i][6].split(', ').map{|q| q.to_i}
      b[i][8]=b[i][8].to_f
    elsif b[i][2]=='Aura'
      b[i][4]=b[i][4].to_i
    elsif b[i][2]=='Ability'
      b[i][4]=b[i][4].to_i
    elsif b[i][2]=='CoAbility'
      b[i][4]=b[i][4].to_i
    end
  end
  @askilities=b.map{|q| q}
end

def metadata_load()
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSave.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSave.txt').each_line do |line|
      b.push(eval line)
    end
  else
    b=[[168592191189417984, 256379815601373184],[],[],[]]
  end
  @embedless=b[0]
  @embedless=[168592191189417984, 256379815601373184] if @embedless.nil?
  @ignored=b[1]
  @ignored=[] if @ignored.nil?
  @server_data=b[2]
  @server_data=[[0,0,0,0,0],[0,0,0,0,0]] if @server_data.nil? || @server_data.length<=0
  @spam_channels=b[3]
  @spam_channels=[] if @spam_channels.nil?
end

def metadata_save()
  x=[@embedless.map{|q| q}, @ignored.map{|q| q}, @server_data.map{|q| q}, @spam_channels.map{|q| q}]
  open('C:/Users/Mini-Matt/Desktop/devkit/DLSave.txt', 'w') { |f|
    f.puts x[0].to_s
    f.puts x[1].to_s
    f.puts x[2].to_s
    f.puts x[3].to_s
    f.puts "\n"
  }
end

def nicknames_load(mode=1)
  if mode==2 && File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLNames2.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLNames.txt').each_line do |line|
      b.push(eval line)
    end
    return b
  elsif File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLNames.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLNames.txt').each_line do |line|
      b.push(eval line)
    end
  else
    b=[]
  end
  @aliases=b.reject{|q| q.nil? || q[1].nil? || q[2].nil?}.uniq
end

bot.command(:reboot, from: 167657750971547648) do |event| # reboots Botan
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  puts 'DL!reboot'
  exec "cd C:/Users/Mini-Matt/Desktop/devkit && BotanBot.rb #{@shardizard}"
end

bot.command([:help,:commands,:command_list,:commandlist,:Help]) do |event, command, subcommand|
  return nil if overlap_prevent(event)
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
  elsif ['shard','attribute'].include?(command.downcase)
    create_embed(event,'**shard**','Returns the shard that this server is served by.',0xCE456B)
  elsif ['bugreport','suggestion','feedback'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __*message__",'PMs my developer with your username, the server, and the contents of the message `message`',0xCE456B)
  elsif command.downcase=='addalias'
    create_embed(event,'**addalias** __new alias__ __name__',"Adds `new alias` to `name`'s aliases.\nIf the arguments are listed in the opposite order, the command will auto-switch them.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n~~- Facilities\n- Materials~~\n\nInforms you if the alias already belongs to someone/something.\nAlso informs you if the thing you wish to give the alias to does not exist.\n\n**This command is only able to be used by server mods**.",0xC31C19)
  elsif ['deletealias','removealias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __alias__","Removes `alias` from the list of aliases, regardless of who/what it was for.\n\n**This command is only able to be used by server mods**.",0xC31C19)
  elsif ['backupaliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Backs up the alias list.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['restorealiases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Restores the the alias, from last backup.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['safe','spam','safetospam','safe2spam','long','longreplies'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __toggle__","Responds with whether or not the channel the command is invoked in is one in which I can send extremely long replies.\n\nIf the channel does not fill one of the many molds for acceptable channels, server mods can toggle the ability with the words \"on\", \"semi\", and \"off\".",0xCE456B)
  elsif ['status'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __\*message__","Sets my status to `message`.\n\n**This command is only able to be used by Rot8er_ConeX**.",0x008b8b)
  elsif ['adventurer','adv','unit'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats, skills, and abilities.\n\nIn PM, shows stats at all possible rarities, as well as skill descriptions.\nOtherwise, shows stats at default rarity, and skill names only.  Other rarities can be specified to be shown instead.",0xCE456B)
  elsif ['dragon'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats, skills, and abilities.",0xCE456B)
  elsif ['wyrmprint','wyrm','print'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats and abilities.",0xCE456B)
  elsif ['weapon','weap','wep','wpn'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats and skills.",0xCE456B)
  elsif ['skill','skil'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the skill named `name` does.  Also shows all adventurers and dragons that know the skill, and any weapons that have it imbued.",0xCE456B)
  elsif ['ability','abil'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the ability named `name` does.  Also shows all adventurers and dragons that know the ability, and any wyrmprints that have it imbued.",0xCE456B)
  elsif ['aura'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows everything that the aura named `name` does.  Also shows all dragons that have the aura.",0xCE456B)
  elsif ['roost'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the current day's Dragon Roost Bond gift, as well as all the dragons that get an extra bond increase from the gift.\n\nYou can include the word \"tomorrow\" to instead show the data for tomorrow.\nYou can also include a day of the week to instead show data on that day of the week.",0xCE456B)
  elsif ['ruin','ruins'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the current day's Elemental Ruins, what difficulties are available, and what orbs come out of those.\n\nYou can include the word \"tomorrow\" to instead show the data for tomorrow.\nYou can also include a day of the week to instead show data on that day of the week.",0xCE456B)
  elsif ['today','now','daily','dailies','today_in_dl','todayindl'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the current day's Dragon Roost Bond gift, as well as all the dragons that get an extra bond increase from the gift.\nAlso shows the current day's Elemental Ruins, what difficulties are available, and what orbs come out of those.",0xCE456B)
  elsif ['tomorrow','tomorow','tommorrow','tommorow'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the next day's Dragon Roost Bond gift, as well as all the dragons that get an extra bond increase from the gift.\nAlso shows the next day's Elemental Ruins, what difficulties are available, and what orbs come out of those.",0xCE456B)
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
  elsif ['find','search'].include?(command.downcase)
    subcommand='' if subcommand.nil?
    if ['adventurer','adventurers','adv','advs','unit','units'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all adventurers that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Weapon type\n- Class\n- Availability\n\nIf too many adventurers are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['dragon','dragons'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all dragons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Dragon Roost Bond Gift preference\n- Whether or not the dragon turns to face damage sources\n- Whether or not the dragon is a ranged attacker\n- Availability\n\nIf too many dragons are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['wyrmprint','wyrm','print'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all wyrmprints that fit `filters`.\n\nYou can search by:\n- Rarity\n- Amulet type\n- Availability\n\nIf too many wyrmprints are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all weapons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Weapon type\n- Availability\n\nIf too many weapons are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    else
      create_embed(event,"**#{command.downcase}** __\*filters__","Displays all adventurers, dragons, wyrmprints, and weapons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Weapon type\n- Class / Amulet type\n- Availability\n\nIn addition, dragons can be sorted by:\n- Dragon Roost Bond Gift preference\n- Whether or not the dragon turns to face damage sources\n- Whether or not the dragon is a ranged attacker\n\nIf too much data is trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    end
  elsif ['aliases','checkaliases','seealiases','alias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s aliases.\nIf no name is listed, responds with a list of all aliases and who/what they are for.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n~~- Facilities\n- Materials~~\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
  elsif ['saliases','serveraliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s server-specific aliases.\nIf no name is listed, responds with a list of all server-specific aliases and who/what they are for.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n~~- Facilities\n- Materials~~\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
  elsif command.downcase=='snagstats'
    subcommand='' if subcommand.nil?
    if ['server','servers','member','members','shard','shards','users','user'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**",'Returns the number of servers and unique members each shard reaches.',0xCE456B)
    elsif ['alias','aliases','name','names','nickname','nicknames'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the number of aliases in each of the two categories - global single-servant, and server-specific single-servant.\nAlso returns specifics about the most frequent instances of each category",0xCE456B)
    elsif ['code','lines','line','sloc'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}**","Returns the specifics about my code, including number of commands and functions, as well as - if in PM - loops, statements, and conditionals.",0xCE456B)
    else
      create_embed(event,"**#{command.downcase}**","Returns:\n- the number of servers I'm in\n- the numbers of servants in the game\n- the numbers of aliases I keep track of\n- how long of a file I am.\n\nYou can also include the following words to get more specialized data:\nServer(s), Member(s), Shard(s), User(s)\nAlias(es), Name(s), Nickname(s)\nCode, Line(s), SLOC#{"\n\nAs the bot developer, you can also include a server ID number to snag the shard number, owner, and my nickname in the specified server." if event.user.id==167657750971547648}",0xCE456B)
    end
  else
    x=0
    x=1 unless safe_to_spam?(event)
    if command.downcase=='here'
      x=0
      command=''
    end
    event.respond "#{command.downcase} is not a command" if command!='' && command.downcase != 'devcommands'
    create_embed([event,x],"Command Prefixes: #{@prefix.map{|q| q.upcase}.uniq.map{|q| "`#{q}`"}.join(', ')}\nYou can also use `DL!help CommandName` to learn more on a particular command.\n__**Botan Bot help**__","__**Game Data**__\n`adventurer` __name__ - for data on an adventurer (*also `adv`*)\n`dragon` __name__ - for data on a dragon\n`wyrmprint` __name__ - for data on a wyrmprint (*also `wyrm` or `print`*)\n`weapon` __name__ - for data on a weapon\n\n`skill` __name__ - for data on a particular skill\n`ability` __name__ - for data on a particular ability\n`aura` __name__ - for data on a particular aura\n\n`find` __\*filters__ - to find specific adventurers or dragons\n`today` - to show data on current events (*also `daily` or `todayInDL`*)\n\n__**Meta Data**__\n`invite` - for a link to invite me to your server\n`snagstats` __type__ - to receive relevant bot stats\n`spam` - to determine if the current location is safe for me to send long replies to (*also `safetospam` or `safe2spam`*)\n`shard` (*also `alliance`*)\n\n__**Developer Information**__\n`bugreport` __\\*message__ - to send my developer a bug report\n`suggestion` __\\*message__ - to send my developer a feature suggestion\n`feedback` __\\*message__ - to send my developer other kinds of feedback\n~~the above three commands are actually identical, merely given unique entries to help people find them~~",0xCE456B)
    create_embed([event,x],"__**Server Admin Commands**__","__**Unit Aliases**__\n`addalias` __new alias__ __unit__ - Adds a new server-specific alias\n~~`aliases` __unit__ (*also `checkaliases` or `seealiases`*)~~\n`deletealias` __alias__ (*also `removealias`*) - deletes a server-specific alias",0xC31C19) if is_mod?(event.user,event.server,event.channel)
    create_embed([event,x],"__**Bot Developer Commands**__","__**Mjolnr, the Hammer**__\n`ignoreuser` __user id number__ - makes me ignore a user\n`leaveserver` __server id number__ - makes me leave a server\n\n__**Communication**__\n`status` __\\*message__ - sets my status\n`sendmessage` __channel id__ __\\*message__ - sends a message to a specific channel\n`sendpm` __user id number__ __\\*message__ - sends a PM to a user\n\n__**Server Info**__\n`snagstats` - snags relevant bot stats\n\n__**Shards**__\n`reboot` - reboots this shard\n\n__**Meta Data Storage**__\n`backupaliases` - backs up the alias list\n`restorealiases` - restores the alias list from last backup\n`sortaliases` - sorts the alias list by servant",0x008b8b) if (event.server.nil? || event.channel.id==283821884800499714 || @shardizard==4 || command.downcase=='devcommands') && event.user.id==167657750971547648
    event.respond "If the you see the above message as only three lines long, please use the command `DL!embeds` to see my messages as plaintext instead of embeds.\n\nCommand Prefixes: #{@prefix.map{|q| q.upcase}.uniq.map{|q| "`#{q}`"}.join(', ')}\nYou can also use `DL!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name" unless x==1
    event.user.pm("If the you see the above message as only three lines long, please use the command `DL!embeds` to see my messages as plaintext instead of embeds.\n\nCommand Prefixes: #{@prefix.map{|q| q.upcase}.uniq.map{|q| "`#{q}`"}.join(', ')}\nYou can also use `DL!help CommandName` to learn more on a particular command.\n\nWhen looking up a character, you also have the option of @ mentioning me in a message that includes that character's name") if x==1
    event.respond "A PM has been sent to you.\nIf you would like to show the help list in this channel, please use the command `DL!help here`." if x==1
  end
end

def overlap_prevent(event) # used to prevent servers with both Botan and her debug form from receiving two replies
  if event.server.nil? # failsafe code catching PMs as not a server
    return false
  elsif event.message.text.downcase.split(' ').include?('debug') && [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(event.server.id)
    return @shardizard != 4 # the debug bot can be forced to be used in the emoji servers by including the word "debug" in your message
  elsif [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(event.server.id) # emoji servers will use default Elise otherwise
    return @shardizard == 4
  end
  return false
end

def find_adventurer(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@adventurers.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @adventurers[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Adventurer'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @adventurers[@adventurers.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@adventurers.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @adventurers[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @adventurers[@adventurers.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_dragon(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@dragons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @dragons[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @dragons[@dragons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@dragons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @dragons[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @dragons[@dragons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_wyrmprint(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@wyrmprints.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @wyrmprints[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Wyrmprint'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @wyrmprints[@wyrmprints.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@wyrmprints.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @wyrmprints[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @wyrmprints[@wyrmprints.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_weapon(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@weapons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @weapons[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Weapon'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @weapons[@weapons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@weapons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @weapons[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @weapons[@weapons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_skill(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  sklz=@askilities.reject{|q| q[2]!='Skill'}
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return sklz[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Skill'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return sklz[sklz.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return sklz[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return sklz[sklz.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_ability(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  sklz=@askilities.reject{|q| q[2]=='Skill'}
  return [] if name.length<2
  k=sklz.reject{|q| "#{q[0]} #{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name}
  return k unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[0]} +#{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name}
  return k unless k.nil? || k.length<=0
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return sklz.reject{|q| q[0]!=sklz[k][0]} unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| !['Aura','Ability'].include?(q[0])}.map{|q| [q[1],q[2],q[3],q[0]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| "#{q[0]} #{q[1]}"==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1]}
  end
  return [] if fullname
  k=sklz.reject{|q| "#{q[0]} #{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]!=name}
  return k unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[0]} +#{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]!=name}
  return k unless k.nil? || k.length<=0
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return sklz.reject{|q| q[0]!=sklz[k][0]} unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| "#{q[0]} #{q[1]}"==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1]}
  end
  return []
end

def find_data_ex(callback,name,event,fullname=false)
  k=method(callback).call(name,event,true)
  return k if k.length>0
  blank=[]
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(callback).call(args[i,args.length-i-i2].join(' '),event,true)
      return k if k.length>0 && args[i,args.length-i-i2].length>0
    end
  end
  return blank if fullname
  k=method(callback).call(name,event)
  return k if k.length>0
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(callback).call(args[i,args.length-i-i2].join(' '),event)
      return k if k.length>0 && args[i,args.length-i-i2].length>0
    end
  end
  return blank
end

def generate_rarity_row(rar,include_blanks=false)
  return "#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][rar]*rar}#{['','<:Rarity_1_Blank:532104334423621632>','<:Rarity_2_Blank:532104120010539018>','<:Rarity_3_Blank:532104120052744192>','<:Rarity_4_Blank:532104120002150410>','<:Rarity_5_Blank:532104120014995466>'][rar]*(5-rar) if include_blanks}"
end

def element_color(ele)
  return 0xE73031 if ele=='Flame'
  return 0x1890DE if ele=='Water'
  return 0x00D771 if ele=='Wind'
  return 0xFFB90F if ele=='Light'
  return 0xA637DE if ele=='Shadow'
  return 0x849294
end

def element_emote(ele,bot)
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{ele.gsub('None','Null')}"}
  return moji[0].mention if moji.length>0
  return ''
end

def disp_adventurer_stats(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_adventurer,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  s2s=false if @shardizard==4 && event.message.text.downcase.split(' ').include?('smol')
  rar=0
  for i in 0...args.length
    rar=args[i].to_i if rar.zero? && args[i].to_i.to_s==args[i] && args[i].to_i>2 && args[i].to_i<6
  end
  rar=k[1][0,1].to_i if rar.zero?
  rar=k[1][0,1].to_i if rar>k[1][0,1].to_i && s2s
  str=''
  unless s2s
    str="#{generate_rarity_row(rar,true)}"
    str="#{str} (from #{k[1][0,1].to_i}#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][k[1][0,1].to_i]})" unless rar==k[1][0,1].to_i
  end
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][1]}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Element:** #{k[2][1]}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[2][2]}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Weapon:** #{k[2][2]}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2][0].gsub('Healer','Healing')}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Class:** #{k[2][0]}"
  str="#{str}\n**Welfare**" if k[1].length>1 && k[1][1,1].downcase=='w'
  str="#{str}\n**Story**" if k[1].length>1 && k[1][1,1].downcase=='y'
  str="#{str}\n**Seasonal**" if k[1].length>1 && k[1][1,1].downcase=='s'
  str="#{str}\n**Zodiac Seasonal**" if k[1].length>1 && k[1][1,1].downcase=='z'
  flds=nil
  xpic=nil
  sklz=@askilities.map{|q| q}
  skl1=sklz[sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6][0]}]
  skl2=sklz[sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6][1]}]
  if s2s
    xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Adventurers/#{k[0].gsub(' ','_')}_#{k[1][0,1]}.png"
    str="#{str}\n\n**Defense:** #{k[5]}"
    flds=[]
    for i in rar...6
      flds.push([generate_rarity_row(i,true),"**Level 1**  \u200B  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[3][0][i-3])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[4][0][i-3])}  \u00B7\n**Level #{30+10*i}**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[3][1][i-3])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[4][1][i-3])}  \u00B7"])
    end
    str2="__**#{skl1[0]}** (#{skl1[8]} sec invul#{', <:Energized:534451856286679040>Energizable' if skl1[7]=='Yes'})__#{" - #{longFormattedNumber(skl1[6][0])} SP" if skl1[6].max===skl1[6].min}"
    if (skl1[9].nil? || skl1[9].length<=0) && skl1[6].max != skl1[6].min
      str2="#{str2}\n*Lv.1 (F1, #{skl1[6][0]} SP):* #{skl1[3].gsub(';; ',"\n")}\n*Lv.2 (F3, #{skl1[6][1]} SP):* #{skl1[4].gsub(';; ',"\n")}\n*Lv.3 (F5, #{skl1[6][2]} SP):* #{skl1[5].gsub(';; ',"\n")}"
    elsif skl1[9].nil? || skl1[9].length<=0
      str2="#{str2}\n*Lv.1 (F1):* #{skl1[3].gsub(';; ',"\n")}\n*Lv.2 (F3):* #{skl1[4].gsub(';; ',"\n")}\n*Lv.3 (F5):* #{skl1[5].gsub(';; ',"\n")}"
    elsif skl1[6].max != skl1[6].min
      str2="#{str2}\n*Effect:* #{skl1[9].gsub(';; ',"\n")}\n*Lv.1 (F1, #{skl1[6][0]} SP) \u2192 Lv.2 (F3, #{skl1[6][1]} SP) \u2192 Lv.3 (F5, #{skl1[6][2]} SP)*"
    else
      str2="#{str2}\n*Effect:* #{skl1[9].gsub(';; ',"\n")}\n*Lv.1 (F1) \u2192 Lv.2 (F3) \u2192 Lv.3 (F5)*"
    end
    str2="#{str2}\n\n__**#{skl2[0]}** (#{skl2[8]} sec invul#{', <:Energized:534451856286679040>Energizable' if skl2[7]=='Yes'})__#{" - #{longFormattedNumber(skl2[6][0])} SP" if skl2[6][0]===skl2[6][1]}"
    if (skl2[9].nil? || skl2[9].length<=0) && skl2[6][0]!=skl2[6][1]
      str2="#{str2}\n*Lv.1 (F1, #{skl2[6][0]} SP):* #{skl2[3].gsub(';; ',"\n")}\n*Lv.2 (F4, #{skl2[6][1]} SP):* #{skl2[4].gsub(';; ',"\n")}"
    elsif skl2[9].nil? || skl2[9].length<=0
      str2="#{str2}\n*Lv.1 (F1):* #{skl2[3].gsub(';; ',"\n")}\n*Lv.2 (F4):* #{skl2[4].gsub(';; ',"\n")}"
    elsif skl2[6][0]!=skl2[6][1]
      str2="#{str2}\n*Effect:* #{skl2[9].gsub(';; ',"\n")}\n*Lv.1 (F1, #{skl2[6][0]} SP) \u2192 Lv.2 (F4, #{skl2[6][1]} SP)*"
    else
      str2="#{str2}\n*Effect:* #{skl2[9].gsub(';; ',"\n")}\n*Lv.1 (F1) \u2192 Lv.2 (F4)*"
    end
    flds.push(['Skills',str2,1])
    a3="#{k[8][2][0]} (F5)"
    a3="#{k[8][2][0]} (F3) \u2192 #{k[8][2][1]} (F5)" if k[1][0,1].to_i==5
    flds.push(['Abilities',"#{k[8][0][0]} (F1) \u2192 #{k[8][0][1]} (F3)\n#{k[8][1][0]} (F2) \u2192 #{k[8][1][1]} (F4)\n#{a3}\n\n*Co-Ability:* #{k[7]}"])
  else
    xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Adventurers/#{k[0].gsub(' ','_')}_#{[rar,k[1][0,1].to_i].max}.png"
    str="#{str}\n\n**Level 1**  \u200B  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[3][0][rar-3])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[4][0][rar-3])}  \u200B  \u200B  *Def:*\u00A0\u00A0#{longFormattedNumber(k[5])}"
    str="#{str}\n**Level #{30+10*rar}**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[3][1][rar-3])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[4][1][rar-3])}  \u200B  \u200B  *Def:*\u00A0\u00A0#{longFormattedNumber(k[5])}"
    lv=[3,2,2,2,k[8][2].length]
    lv=[2,2,2,2,0] if rar==4
    lv=[2,1,2,1,0] if rar==3
    lv[4]=1 if k[1][0,1].to_i==5
    lv=[1,1,1,1,0] if rar==2
    lv=[1,1,1,0,0] if rar==1
    str="#{str}\n\n**Skills:**\n#{k[6][0]}#{'<:Energized:534451856286679040>' if skl1[7]=='Yes'} [Lv.#{lv[0]}] - #{longFormattedNumber(skl1[6][lv[0]-1])} SP\n#{k[6][1]}#{'<:Energized:534451856286679040>' if skl2[7]=='Yes'} [Lv.#{lv[1]}] - #{longFormattedNumber(skl2[6][lv[1]-1])} SP"
    m=[]
    for i in 0...3
      m.push(k[8][i][lv[i+2]-1]) if lv[i+2]>0
    end
    str="#{str}\n\n**Abilities:** #{m.join(', ')}"
    if rar<5
      str="#{str}\n**Co-Ability:** #{k[7].split('/')[0]}"
    else
      m=k[7].split(' ')
      m[-1]=m[-1].split('/')
      str="#{str}\n**Co-Ability:** #{m[0,m.length-1].join(' ')} #{m[-1][-1]}"
    end
  end
  if flds.nil?
    create_embed(event,"__**#{k[0]}**__",str,element_color(k[2][1]),nil,xpic,flds)
  elsif flds.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length>=1500
    create_embed(event,"__**#{k[0]}**__",str,element_color(k[2][1]),nil,xpic,flds[0,flds.length-2])
    create_embed(event,"__**#{flds[-2][0]}**__",flds[-2][1],element_color(k[2][1]))
    create_embed(event,"__**#{flds[-1][0]}**__",flds[-1][1],element_color(k[2][1]))
  else
    create_embed(event,"__**#{k[0]}**__",str,element_color(k[2][1]),nil,xpic,flds)
  end
end  

def disp_dragon_stats(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_dragon,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  s2s=false if @shardizard==4 && event.message.text.downcase.split(' ').include?('smol')
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Dragons/#{k[0].gsub(' ','_')}.png"
  str=generate_rarity_row(k[1][0,1].to_i)
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2]}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Element:** #{k[2]}"
  str="#{str}\n**Welfare**" if k[1].length>1 && k[1][1,1].downcase=='w'
  str="#{str}\n**Story**" if k[1].length>1 && k[1][1,1].downcase=='y'
  str="#{str}\n**Seasonal**" if k[1].length>1 && k[1][1,1].downcase=='s'
  str="#{str}\n**Zodiac Seasonal**" if k[1].length>1 && k[1][1,1].downcase=='z'
  str="#{str}\n\n**Level 1**  \u200B  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[3][0])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}"
  str="#{str}\n**Level #{k[1][0,1].to_i*20}**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[3][1])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}"
  str="#{str}\n\n**Speed:**  \u200B  \u200B  \u200B  *Dash:*\u00A0\u00A0#{k[8][0]}  \u200B  \u200B  *Turn:*\u00A0\u00A0#{k[8][1]}"
  str="#{str}\n*Automatically turns to damage direction*" if k[10]=='Yes'
  if k[11]=='Yes'
    str="#{str}\n*Long range attacks*"
  else
    str="#{str}\n*Short range attacks*"
  end
  sklz=@askilities.map{|q| q}
  skl1=sklz[sklz.find_index{|q| q[2]=='Skill' && q[0]==k[5]}]
  if s2s
    str="#{str}\n\n__**#{skl1[0]}** (#{skl1[8]} sec invul#{', <:Energized:534451856286679040>Energizable' if skl1[7]=='Yes'})__"
    if skl1[9].nil? || skl1[9].length<=0
      str="#{str}\n*Lv.1:* #{skl1[3].gsub(';; ',"\n")}\n*Lv.2:* #{skl1[4].gsub(';; ',"\n")}"
    else
      str="#{str}\n*Effect:* #{skl1[9].gsub(';; ',"\n")}"
    end
  else
    str="#{str}\n\n**Skill:** #{k[5]}#{'<:Energized:534451856286679040>' if skl1[7]=='Yes'}"
  end
  str="#{str}\n\n**Aura:**\n<:NonUnbound:534494090876682264><:NonUnbound:534494090876682264><:NonUnbound:534494090876682264><:NonUnbound:534494090876682264>#{k[6][0][0]}\n<:Unbind:534494090969088000><:Unbind:534494090969088000><:Unbind:534494090969088000><:Unbind:534494090969088000>#{k[6][0][1]}"
  str="#{str}\n\n**Ability:** #{k[6][1][0]} \u2192 #{k[6][1][1]}" if k[6].length>1
  str="#{str}\n\n**Sells for:** #{longFormattedNumber(k[7][0])}<:Resource_Rupies:532104504372363274> #{longFormattedNumber(k[7][1])}<:Resource_Eldwater:532104503777034270>"
  if str.length>1900 && safe_to_spam?(event)
    str=str.split("\n\n__**")
    str[1]="__**#{str[1]}".split("\n\n**Sells")
    str[0]="#{str[0]}\n\n**Sells#{str[1][1]}"
    create_embed(event,"__**#{k[0]}**__",str[0],element_color(k[2]),nil,xpic)
    create_embed(event,'',str[1][0],element_color(k[2]))
  else
    create_embed(event,"__**#{k[0]}**__",str,element_color(k[2]),nil,xpic)
  end
end

def disp_wyrmprint_stats(bot,event,args=nil)
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
  s2s=false if @shardizard==4 && evn.include?('smol')
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Wyrmprints/#{k[0].gsub(' ','_')}_1.png"
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Wyrmprints/#{k[0].gsub(' ','_')}_2.png" if has_any?(['mub','unbind','unbound'],evn)
  str=generate_rarity_row(k[1][0,1].to_i)
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2]}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Amulet Type:** #{k[2]}"
  xcolor=0x313439
  xcolor=0x5A0408 if k[2]=='Attack'
  xcolor=0x00205A if k[2]=='Defense'
  xcolor=0x39045A if k[2]=='Support'
  xcolor=0x005918 if k[2]=='Healing'
  str="#{str}\n**Welfare**" if k[1].length>1 && k[1][1,1].downcase=='w'
  str="#{str}\n**Story**" if k[1].length>1 && k[1][1,1].downcase=='y'
  str="#{str}\n**Seasonal**" if k[1].length>1 && k[1][1,1].downcase=='s'
  str="#{str}\n**Zodiac Seasonal**" if k[1].length>1 && k[1][1,1].downcase=='z'
  f=k[1][0,1].to_i*20
  f-=10 if k[1][0,1].to_i<3
  if s2s
    str="#{str}\n\n__**#{'<:NonUnbound:534494090876682264>'*4} Level 1**__"
    str="#{str}\n*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][0])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}"
    str="#{str}\n#{k[5].map{|q| q[0]}.join("\n")}"
    str="#{str}\n\n__**#{'<:Unbind:534494090969088000>'*4} Level #{f}**__"
    str="#{str}\n*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][1])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}"
    str="#{str}\n#{k[5].map{|q| q[1]}.join("\n")}"
  else
    str="#{str}\n\n**#{'<:NonUnbound:534494090876682264>'*4} Level 1**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[3][0])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}"
    str="#{str}\n**#{'<:Unbind:534494090969088000>'*4} Level #{f}**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[3][1])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}"
    str="#{str}\n\n__**Abilities**__\n#{k[5].map{|q| "#{q[0]}/#{q[1].split(' ')[-1]}"}.join("\n")}"
  end
  str="#{str}\n\n**Sells for:** #{longFormattedNumber(k[6][0])}<:Resource_Rupies:532104504372363274> #{longFormattedNumber(k[6][1])}<:Resource_Eldwater:532104503777034270>"
  ftr="Artist: #{k[7]}" unless k[7].nil? || k[7].length<=0
  create_embed(event,"__**#{k[0]}**__",str,xcolor,ftr,xpic)
end

def disp_weapon_stats(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_weapon,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  s2s=false if @shardizard==4 && evn.include?('smol')
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Weapons/#{k[0].gsub(' ','_')}.png"
  str=generate_rarity_row(k[2][0,1].to_i)
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[3].gsub('None','Null')}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Element:** #{k[3]}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[1]}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Weapon Type:** #{k[1]}"
  str="#{str}\n**Welfare**" if k[2].length>1 && k[2][1,1].downcase=='w'
  str="#{str}\n**Story**" if k[2].length>1 && k[2][1,1].downcase=='y'
  str="#{str}\n**Seasonal**" if k[2].length>1 && k[2][1,1].downcase=='s'
  str="#{str}\n**Zodiac Seasonal**" if k[2].length>1 && k[2][1,1].downcase=='z'
  str="#{str}\n**Enemy exclusive**" if k[2].length>1 && k[2][1,1].downcase=='e'
  f=30*k[2][0,1].to_i-50
  f+=20 if k[2][0,1].to_i<3
  wpnz=@weapons.map{|q| q}
  sklz=@askilities.map{|q| q}
  skl=nil
  skl=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6]} if !k[6].nil? && k[6].length>0
  skl=sklz[skl] unless skl.nil?
  if s2s && !skl.nil?
    str="#{str}\n\n__**#{'<:NonUnbound:534494090876682264>'*4} Level 1**__"
    str="#{str}\n*HP:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][0])}"
    str="#{str}\n*#{skl[0]}* - #{longFormattedNumber(skl[6][0])} SP\n#{skl[3].gsub(';; ',"\n")}"
    if k[2][0,1].to_i>=5 && k[3]!='None'
      str="#{str}\n\n__**#{'<:NonUnbound:534494090876682264>'*4} Level 80**__"
      str="#{str}\n*HP:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][1])}"
      str="#{str}\n*#{skl[0]}* - #{longFormattedNumber(skl[6][0])} SP\n#{skl[3].gsub(';; ',"\n")}"
    end
    str="#{str}\n\n__**#{'<:Unbind:534494090969088000>'*4} Level #{f}**__"
    str="#{str}\n*HP:*\u00A0\u00A0#{longFormattedNumber(k[4][2])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][2])}"
    str="#{str}\n*#{skl[0]}* - #{longFormattedNumber(skl[6][1])} SP\n#{skl[4].gsub(';; ',"\n")}"
  else
    str="#{str}\n\n**#{'<:NonUnbound:534494090876682264>'*4} Level 1**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][0])}"
    str="#{str}\n**#{'<:NonUnbound:534494090876682264>'*4} Level 80**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][1])}" if k[2][0,1].to_i>=5 && k[3]!='None'
    str="#{str}\n**#{'<:Unbind:534494090969088000>'*4} Level #{f}**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[4][2])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][2])}"
    unless skl.nil?
      str="#{str}\n\n**Skill:** *#{skl[0]}*"
      if skl[6][0]==skl[6][1]
        str="#{str} - #{longFormattedNumber(skl[6][0])} SP"
      else
        str="#{str} - #{longFormattedNumber(skl[6][0])} \u2192 #{longFormattedNumber(skl[6][1])} SP"
      end
    end
  end
  str2=''
  if s2s
    m2=wpnz.find_index{|q| q[1]==k[1] && q[2]==k[2] && q[8]==k[9] && !['','0',0].include?(q[8])}
    m=wpnz.reject{|q| q[1]!=k[1] || q[2]!=k[2] || q[9]!=k[8] || ['','0',0].include?(q[9])}
    str2="#{str2}#{"\n" if m.length>1}\n\n**Promotes from: #{element_emote(wpnz[m2][3],bot)}*#{wpnz[m2][0]}* **\n*Smithy level required:* #{k[10]}\n*Assembly cost:* #{longFormattedNumber(k[11][0])}<:Resource_Rupies:532104504372363274>\n*Required mats:* #{k[12].map{|q| "#{q[0]} x#{q[1]}"}.join(', ')}" unless m2.nil?
    if m.length>0
      for i in 0...m.length
        str2="#{str2}#{"\n" if i==0 && m.length>1}\n\n**#{"Promotion #{i+1}" if m.length>1}#{'Promotes into' if m.length==1}: #{element_emote(m[i][3],bot)}*#{m[i][0]}* **\n*Smithy level required:* #{m[i][10]}\n*Assembly cost:* #{longFormattedNumber(m[i][11][0])}<:Resource_Rupies:532104504372363274>\n*Required mats:* #{m[i][12].map{|q| "#{q[0]} x#{q[1]}"}.join(', ')}"
      end
    end
  else
    m=wpnz.find_index{|q| q[1]==k[1] && q[2]==k[2] && q[8]==k[9] && !['','0',0].include?(q[8])}
    str2="#{str2}\n**Promotes from:** #{wpnz[m][0]}" unless m.nil?
    m=wpnz.reject{|q| q[1]!=k[1] || q[2]!=k[2] || q[9]!=k[8] || ['','0',0].include?(q[9])}
    str2="#{str2}\n**Promotes into:** #{m.map{|q| "#{element_emote(q[3],bot)}#{q[0]}"}.join(', ')}" unless m.length<=0
  end
  str="#{str}#{"\n" unless s2s}#{str2}" if str2.length>0
  str="#{str}\n\n**Sells for:** #{longFormattedNumber(k[7][0])}<:Resource_Rupies:532104504372363274>#{" #{longFormattedNumber(k[7][1])}<:Resource_Eldwater:532104503777034270>" if k[7][1]>0}"
  str="#{str}\n**Disassembles for:** #{longFormattedNumber(k[11][1])}<:Resource_Rupies:532104504372363274>"
  create_embed(event,"__**#{k[0]}**__",str,element_color(k[3]),nil,xpic)
end

def disp_skill_data(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_skill,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  s2s=false if @shardizard==4 && evn.include?('smol')
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Skills/#{k[0].gsub(' ','_')}.png"
  xcolor=0x02010a
  mx=k[3,3].reject{|q| q.nil? || q.length<=0}
  str=''
  str="**SP Cost:** #{longFormattedNumber(k[6][0])}" if k[6][0,mx.length].max==k[6][0,mx.length].min
  str="#{str}\n**Invulnerability duration:** #{k[8]} seconds"
  str="#{str}\n<:Energized:534451856286679040> **Energizable**" if k[7]=='Yes'
  str="#{str}\n~~Not energizable~~" if k[7]=='No'
  str2=''
  for i in 0...mx.length
    str2="#{str2}\n\n__**Level #{i+1}**__"
    str2="#{str2} - #{k[6][i]} SP" unless k[6][0,mx.length].max==k[6][0,mx.length].min
    str2="#{str2}\n#{k[i+3].gsub(';; ',"\n")}"
  end
  flds=[]
  m=[]
  x=@adventurers.map{|q| q}
  for i in 0...x.length
    m.push("#{x[i][0]} - S1") if x[i][6][0]==k[0]
    m.push("#{x[i][0]} - S1") if x[i][6][1]==k[0]
  end
  flds.push(['Adventurers',m.join("\n")]) if m.length>0
  m=[]
  x=@dragons.map{|q| q}
  for i in 0...x.length
    m.push("#{x[i][0]}") if x[i][5]==k[0]
  end
  flds.push(['Dragons',m.join("\n")]) if m.length>0
  m=[]
  x=@weapons.map{|q| q}
  for i in 0...x.length
    m.push("#{x[i][0]} - S3") if x[i][6]==k[0]
  end
  flds.push(['Weapons',m.join("\n")]) if m.length>0
  flds=nil if flds.length<=0
  m=0
  m=flds.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length unless flds.nil?
  if str.length+str2.length+m<1800 && (s2s || k[9].nil? || k[9].length<=0)
    str="#{str}#{str2}"
    create_embed(event,"__**#{k[0]}**__",str,xcolor,nil,xpic,flds)
  elsif str2.length<1800 && (s2s || k[9].nil? || k[9].length<=0)
    create_embed(event,"__**#{k[0]}**__",str,xcolor,nil,xpic)
    create_embed(event,'',str2,xcolor)
    create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
  elsif k[9].nil? || k[9].length<=0
    create_embed(event,"__**#{k[0]}**__",str,xcolor,nil,xpic)
    m=str2.split("\n\n").reject{|q| q.nil? || q.length<=0}
    s=''
    for i in 0...m.length
      s=extend_message(s,m[i],event,2)
    end
    event.respond s
    create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
  else
    str2="\n\n#{k[9].gsub(';; ',"\n")}"
    unless k[6][0,mx.length].max==k[6][0,mx.length].min
      str2="#{str2}\n\nL1 = #{longFormattedNumber(k[6][0])} SP\nL2 = #{longFormattedNumber(k[6][1])} SP"
      str2="#{str2}\nL3 = #{longFormattedNumber(k[6][2])} SP" if mx.length>2
    end
    if str.length+str2.length+m<1800
      str="#{str}#{str2}"
      create_embed(event,"__**#{k[0]}**__",str,xcolor,nil,xpic,flds)
    elsif str2.length<1800
      create_embed(event,"__**#{k[0]}**__",str,xcolor,nil,xpic)
      create_embed(event,'',str2,xcolor)
      create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
    else
      create_embed(event,"__**#{k[0]}**__",str,xcolor,nil,xpic)
      m=str2.split("\n").reject{|q| q.nil? || q.length<=0}
      s=''
      for i in 0...m.length
        s=extend_message(s,m[i],event,2)
      end
      event.respond s
      create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
    end
  end
end

def disp_ability_data(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_ability,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  s2s=false if @shardizard==4 && evn.include?('smol')
  k=k.reject{|q| q[2]=='Aura'} if k.is_a?(Array) && k.map{|q| q[2]}.uniq.length>1
  k=k[0] if k[0].is_a?(Array) && k.length<=1
  str=''
  hdr=''
  xpic=k[0]
  adv=@adventurers.map{|q| q}
  drg=@dragons.map{|q| q}
  wrm=@wyrmprints.map{|q| q}
  ftr=nil
  flds=nil
  if k[0].is_a?(Array)
    hdr="__**#{k[0][0]}**__ [#{k[0][2].gsub('Co','')} family]"
    xpic=k[0][0]
    xcolor=0x7D7682
    xcolor=0xC6BEB6 if k[0][2]=='Aura'
    xcolor=0x342E4C if k[0][2]=='CoAbility' && k.map{|q| q[2]}.uniq.length==1
    k2=k.reject{|q| q[2]!='Ability'}
    k3=k.reject{|q| q[2]!='CoAbility'}
    if k2.length>0 && k3.length>0
      if k.map{|q| q[1]}.uniq.length<=1
        hdr="__**#{k[0][0]} #{'+' if k[0][1].include?('%')}#{k[0][1]}**__ [Ability family]"
        m=k2[0]
        str="__**Ability**__"
        str="#{str}\n*Effect:* #{m[3]}" if m[5]=='y'
        str="#{str}\n*Might:* #{m[4]}"
        m2=[]
        checkstr="#{k[0][0]} #{'+' if k[0][1].include?('%')}#{k[0][1]}"
        checkstr="#{k[0][0]}" if k[0][1]=='-'
        for i in 0...adv.length
          m2.push("#{adv[i][0]} (A1\u2081)") if adv[i][8][0][0]==checkstr
          m2.push("#{adv[i][0]} (A1\u2082)") if adv[i][8][0][1]==checkstr
          m2.push("#{adv[i][0]} (A2\u2081)") if adv[i][8][1][0]==checkstr
          m2.push("#{adv[i][0]} (A2\u2082)") if adv[i][8][1][1]==checkstr
          m2.push("#{adv[i][0]} (A3)") if adv[i][8][2][0]==checkstr && adv[i][8][2].length<=1
          m2.push("#{adv[i][0]} (A3\u2081)") if adv[i][8][2][0]==checkstr && adv[i][8][2].length>1
          m2.push("#{adv[i][0]} (A3\u2082)") if adv[i][8][2][1]==checkstr && adv[i][8][2].length>1
        end
        str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
        m2=[]
        for i in 0...drg.length
          if drg[i][6].length>1
            m2.push("#{drg[i][0]} (A\u2081)") if drg[i][6][1][0]==checkstr
            m2.push("#{drg[i][0]} (A\u2082)") if drg[i][6][1][1]==checkstr
          end
        end
        str="#{str}\n*Dragons:* #{m2.join(', ')}" if m2.length>0
        m2=[]
        for i in 0...wrm.length
          m2.push("#{wrm[i][0]} (A1\u2081)") if wrm[i][5][0][0]==checkstr
          m2.push("#{wrm[i][0]} (A1\u2082)") if wrm[i][5][0][1]==checkstr
          m2.push("#{wrm[i][0]} (A2\u2081)") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr
          m2.push("#{wrm[i][0]} (A2\u2082)") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
          m2.push("#{wrm[i][0]} (A3\u2081)") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr
          m2.push("#{wrm[i][0]} (A3\u2082)") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
        end
        str="#{str}\n*Wyrmprints:* #{m2.join(', ')}" if m2.length>0
        m=k3[0]
        str="#{str}\n\n__**Co-Ability**__"
        str="#{str}\n*Effect:* #{m[3]}" if m[5]=='y'
        str="#{str}\n*Might:* #{m[4]}"
        m2=[]
        for i in 0...adv.length
          mx=adv[i][7].split(' ')
          mxx=mx[0,mx.length-1].join(' ')
          mx=mx[-1].split('/').map{|q| "#{mxx} #{q}"}
          for i2 in 0...mx.length
            m2.push("#{adv[i][0]} (C#{["\u2081","\u2082","\u2083","\u2084","\u2085"][i2]})") if checkstr==mx[i2]
          end
        end
        str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
      else
        str="__**Abilities**__"
        for i in 0...k2.length
          str="#{str}\n*#{k2[i][0]} #{k2[i][1]}*"
        end
        str="#{str}\n\n__**CoAbilities**__"
        for i in 0...k3.length
          str="#{str}\n*#{k3[i][0]} #{k3[i][1]}*"
        end
        ftr='For a list of ways to obtain these abilities, look a single one of them up.'
      end
    else
      hdr="__**#{k[0][0]}**__ [#{k[0][2]} family]"
      ftr="For a list of ways to obtain these #{k[0][2].downcase.gsub('y','ie')}s, look a single one of them up or use this command in PM." unless s2s
      ftr="For a list of adventurers with these coabilities, look a single one of them up or use this command in PM." if !s2s && k[0][2]=='CoAbility'
      lng=false
      lng=true if k.map{|q| q[5]}.include?('y')
      lng=true if k[0][2]=='Aura'
      for i2 in 0...k.length
        str="#{str}\n#{"\n__" if s2s || lng}**#{k[i2][0]} #{'+' if k[i2][1].include?('%')}#{k[i2][1]}**#{'__' if s2s || lng}#{" - #{k[i2][4]} MT" unless s2s ||lng}"
        str="#{str}\n*Effect:* #{k[i2][3]}" if lng
        str="#{str}\n*Might:* #{k[i2][4]}" if s2s || lng
        if s2s
          checkstr="#{k[i2][0]} #{'+' if k[i2][1].include?('%')}#{k[i2][1]}"
          checkstr="#{k[i2][0]}" if k[i2][1]=='-'
          m2=[]
          if k[i2][2]=='Ability'
            for i in 0...adv.length
              m2.push("#{adv[i][0]} (A1\u2081)") if adv[i][8][0][0]==checkstr
              m2.push("#{adv[i][0]} (A1\u2082)") if adv[i][8][0][1]==checkstr
              m2.push("#{adv[i][0]} (A2\u2081)") if adv[i][8][1][0]==checkstr
              m2.push("#{adv[i][0]} (A2\u2082)") if adv[i][8][1][1]==checkstr
              m2.push("#{adv[i][0]} (A3)") if adv[i][8][2][0]==checkstr && adv[i][8][2].length<=1
              m2.push("#{adv[i][0]} (A3\u2081)") if adv[i][8][2][0]==checkstr && adv[i][8][2].length>1
              m2.push("#{adv[i][0]} (A3\u2082)") if adv[i][8][2][1]==checkstr && adv[i][8][2].length>1
            end
            str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
            m2=[]
            for i in 0...drg.length
              if drg[i][6].length>1
                m2.push("#{drg[i][0]} (A\u2081)") if drg[i][6][1][0]==checkstr
                m2.push("#{drg[i][0]} (A\u2082)") if drg[i][6][1][1]==checkstr
              end
            end
            str="#{str}\n*Dragons:* #{m2.join(', ')}" if m2.length>0
            m2=[]
            for i in 0...wrm.length
              m2.push("#{wrm[i][0]} (A1\u2081)") if wrm[i][5][0][0]==checkstr
              m2.push("#{wrm[i][0]} (A1\u2082)") if wrm[i][5][0][1]==checkstr
              m2.push("#{wrm[i][0]} (A2\u2081)") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr
              m2.push("#{wrm[i][0]} (A2\u2082)") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
              m2.push("#{wrm[i][0]} (A3\u2081)") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr
              m2.push("#{wrm[i][0]} (A3\u2082)") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
            end
            str="#{str}\n*Wyrmprints:* #{m2.join(', ')}" if m2.length>0
          elsif k[i2][2]=='CoAbility'
            for i in 0...adv.length
              mx=adv[i][7].split(' ')
              mxx=mx[0,mx.length-1].join(' ')
              mx=mx[-1].split('/').map{|q| "#{mxx} #{q}"}
              m2.push("#{adv[i][0]} [Min]") if checkstr==mx[0]
              m2.push("#{adv[i][0]} [Max]") if checkstr==mx[4]
            end
            str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
          elsif k[i2][2]=='Aura'
            for i in 0...drg.length
              m2.push("#{drg[i][0]} (A\u2081)") if drg[i][6][0][0]==checkstr
              m2.push("#{drg[i][0]} (A\u2082)") if drg[i][6][0][1]==checkstr
            end
            str="#{str}\n*Dragons:* #{m2.join(', ')}" if m2.length>0
          end
        end
      end
    end
  else
    hdr="__**#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}**__ [#{k[2]}]"
    xcolor=0x555058
    xcolor=0x87817C if k[2]=='Aura'
    xcolor=0x242035 if k[2]=='CoAbility'
    str="**Effect:** #{k[3]}" if k[5]=='y' || k[2]=='Aura'
    str="#{str}\n\n**Might:** #{k[4]}"
    str2=''
    flds=[]
    if k[2]=='Ability'
      m2=[]
      checkstr="#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}"
      checkstr="#{k[0]}" if k[1]=='-'
      for i in 0...adv.length
        m2.push("#{adv[i][0]} (A1\u2081)") if adv[i][8][0][0]==checkstr
        m2.push("#{adv[i][0]} (A1\u2082)") if adv[i][8][0][1]==checkstr
        m2.push("#{adv[i][0]} (A2\u2081)") if adv[i][8][1][0]==checkstr
        m2.push("#{adv[i][0]} (A2\u2082)") if adv[i][8][1][1]==checkstr
        m2.push("#{adv[i][0]} (A3)") if adv[i][8][2][0]==checkstr && adv[i][8][2].length<=1
        m2.push("#{adv[i][0]} (A3\u2081)") if adv[i][8][2][0]==checkstr && adv[i][8][2].length>1
        m2.push("#{adv[i][0]} (A3\u2082)") if adv[i][8][2][1]==checkstr && adv[i][8][2].length>1
      end
      if m2.length>0
        if !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Adventurers:** #{m2.join(', ')}"
        else
          flds.push(['Adventurers',m2.join("\n")])
        end
      end
      m2=[]
      for i in 0...drg.length
        if drg[i][6].length>1
          m2.push("#{drg[i][0]} (A\u2081)") if drg[i][6][1][0]==checkstr
          m2.push("#{drg[i][0]} (A\u2082)") if drg[i][6][1][1]==checkstr
        end
      end
      if m2.length>0
        if !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Dragons:** #{m2.join(', ')}"
        else
          flds.push(['Dragons',m2.join("\n")])
        end
      end
      m2=[]
      for i in 0...wrm.length
        m2.push("#{wrm[i][0]} (A1\u2081)") if wrm[i][5][0][0]==checkstr
        m2.push("#{wrm[i][0]} (A1\u2082)") if wrm[i][5][0][1]==checkstr
        m2.push("#{wrm[i][0]} (A2\u2081)") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr
        m2.push("#{wrm[i][0]} (A2\u2082)") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
        m2.push("#{wrm[i][0]} (A3\u2081)") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr
        m2.push("#{wrm[i][0]} (A3\u2082)") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
      end
      if m2.length>0
        if !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Wyrmprints:** #{m2.join(', ')}"
        else
          flds.push(['Wyrmprints',m2.join("\n")])
        end
      end
    elsif k[2]=='CoAbility'
      m2=[]
      checkstr="#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}"
      checkstr="#{k[0]}" if k[1]=='-'
      for i in 0...adv.length
        mx=adv[i][7].split(' ')
        mxx=mx[0,mx.length-1].join(' ')
        mx=mx[-1].split('/').map{|q| "#{mxx} #{q}"}
        for i2 in 0...mx.length
          m2.push("#{adv[i][0]} (C#{["\u2081","\u2082","\u2083","\u2084","\u2085"][i2]})") if checkstr==mx[i2]
        end
      end
      if m2.length>0
        if !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Adventurers:** #{m2.join(', ')}"
        else
          flds.push(['Adventurers',m2.join("\n")])
        end
      end
    elsif k[2]=='Aura'
      m2=[]
      checkstr="#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}"
      checkstr="#{k[0]}" if k[1]=='-'
      for i in 0...drg.length
        m2.push("#{drg[i][0]} (A\u2081)") if drg[i][6][0][0]==checkstr
        m2.push("#{drg[i][0]} (A\u2082)") if drg[i][6][0][1]==checkstr
      end
      if m2.length>0
        if !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Dragons:** #{m2.join(', ')}"
        else
          flds.push(['Dragons',m2.join("\n")])
        end
      end
    end
    str="#{str}\n#{str2}" if str2.length>0
    flds=nil if flds.length<=0
  end
  xpic=xpic.gsub(' ','_')
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Abilities/#{xpic}.png"
  f=0
  f=flds.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length unless flds.nil?
  f+=ftr.length unless ftr.nil?
  if hdr.length+str.length+f>=1800
    if hdr.length+str.length>=1800
      m=[2,0,str.split("\n\n")]
      m=[1,0,str.split("\n")] if m[2].length<=1
      str=''
      for i in 0...m[2].length
        if "#{str}#{"\n"*m[0]}#{m[2][i]}".length>=1900
          if m[1]==0
            create_embed(event,hdr,str,xcolor,nil,xpic)
          else
            create_embed(event,'',str,xcolor)
          end
          m[1]+=1
          str="#{m[2][i]}"
        else
          str="#{str}#{"\n"*m[0]}#{m[2][i]}"
        end
      end
      if m[1]==0
        create_embed(event,hdr,str,xcolor,nil,xpic)
      else
        create_embed(event,'',str,xcolor)
      end
      unless flds.nil?
        if flds.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length>=1900
          for i in 0...flds.length
            create_embed(event,'','',xcolor,nil,nil,[flds[i]])
          end
        else
          create_embed(event,'','',xcolor,nil,nil,flds)
        end
      end
    else
      create_embed(event,hdr,str,xcolor,nil,xpic)
    end
    event.respond ftr unless ftr.nil?
  else
    create_embed(event,hdr,str,xcolor,ftr,xpic,flds)
  end
end

def find_in_adventurers(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  elem=[]
  wpn=[]
  clzz=[]
  fltr=[]
  for i in 0...args.length
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>2 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>2 && args[i][0,1].to_i<6
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    wpn.push('Sword') if ['sword','swords'].include?(args[i].downcase)
    wpn.push('Blade') if ['blade','blades','sabers','saber'].include?(args[i].downcase)
    wpn.push('Dagger') if ['dagger','daggers','knife','knifes','knives'].include?(args[i].downcase)
    wpn.push('Axe') if ['axes','axe'].include?(args[i].downcase)
    wpn.push('Bow') if ['bow','bows','arrow','arrows','archer','archers'].include?(args[i].downcase)
    wpn.push('Lance') if ['lance','lances','pitchfork','pitchforks','trident','tridents'].include?(args[i].downcase)
    wpn.push('Wand') if ['wand','wands'].include?(args[i].downcase)
    wpn.push('Staff') if ['staff','staffs','staves'].include?(args[i].downcase)
    clzz.push('Attack') if ['attack','atk','att','attacking'].include?(args[i].downcase)
    clzz.push('Defense') if ['defense','defence','def','defending','defensive','defencive'].include?(args[i].downcase)
    clzz.push('Support') if ['support','supports','supportive','supporting'].include?(args[i].downcase)
    clzz.push('Healing') if ['heal','healing','heals','healer','healers'].include?(args[i].downcase)
    fltr.push('Welfare') if ['welfare','welfares','free','freebies','f2p'].include?(args[i].downcase)
    fltr.push('Story') if ['story','stories','storys'].include?(args[i].downcase)
    fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
    fltr.push('Zodiac Seasonal') if ['zodiac','zodiacs','seazonal','seazonals','seazons','seazons'].include?(args[i].downcase)
    fltr.push('Summon') if ['summon','summons','summonable','summonables'].include?(args[i].downcase)
  end
  textra=''
  rarity.uniq!
  elem.uniq!
  wpn.uniq!
  clzz.uniq!
  char=@adventurers.map{|q| q}.uniq
  search=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[1][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][q]}"}.join(', ')}")
  end
  if elem.length>0
    char=char.reject{|q| !elem.include?(q[2][1])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if wpn.length>0
    char=char.reject{|q| !wpn.include?(q[2][2])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[i]}"}
      wpn[i]="#{moji[0].mention}#{wpn[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn.join(', ')}")
  end
  if clzz.length>0
    char=char.reject{|q| !clzz.include?(q[2][0])}.uniq
    for i in 0...clzz.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{clzz[i]}"}
      clzz[i]="#{moji[0].mention}#{clzz[i]}" if moji.length>0
    end
    search.push("*Classes*: #{clzz.join(', ')}")
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Welfare')
      m.push('1w')
      m.push('2w')
      m.push('3w')
      m.push('4w')
      m.push('5w')
    end
    if fltr.include?('Seasonal')
      m.push('1s')
      m.push('2s')
      m.push('3s')
      m.push('4s')
      m.push('5s')
    end
    if fltr.include?('Zodiac Seasonal')
      m.push('1z')
      m.push('2z')
      m.push('3z')
      m.push('4z')
      m.push('5z')
    end
    if fltr.include?('Story')
      m.push('1y')
      m.push('2y')
      m.push('3y')
      m.push('4y')
      m.push('5y')
    end
    if fltr.include?('Summon')
      m.push('1')
      m.push('2')
      m.push('3')
      m.push('4')
      m.push('5')
    end
    char=char.reject{|q| !m.include?(q[1])}.uniq
    search.push("*Filters*: #{fltr.join(', ')}")
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode==0
    event.respond "Too much data is trying to be displayed.  Please use this command in PM."
    return nil
  else
    return [search,char]
  end
end

def find_in_dragons(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  elem=[]
  fltr=[]
  wday=[]
  turn=[]
  ranged=[]
  for i in 0...args.length
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>2 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>2 && args[i][0,1].to_i<6
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    wday.push(1) if ['mo','monday','mondae','mon','m','juicymeat','meat'].include?(args[i].downcase)
    wday.push(2) if ['tu','tuesday','tuesdae','tues','tue','t','kaleidoscope','kscope','k-scope'].include?(args[i].downcase)
    wday.push(3) if ['we','wednesday','wednesdae','wednes','wed','w','floralcirclet','flower','floral','circlet','circle'].include?(args[i].downcase)
    wday.push(4) if ['th','thursday','thursdae','thurs','thu','thur','h','r','compellingbook','book'].include?(args[i].downcase)
    wday.push(5) if ['fr','friday','fridae','fri','fryday','frydae','fry','f','manaessence','mana','essence'].include?(args[i].downcase)
    turn.push('Yes') if ['turn','damage'].include?(args[i].downcase)
    turn.push('No') if ['noturn','anchor'].include?(args[i].downcase)
    ranged.push('Yes') if ['long','longrange','ranged'].include?(args[i].downcase)
    ranged.push('no') if ['short','shortrange','melee'].include?(args[i].downcase)
    fltr.push('Welfare') if ['welfare','welfares','free','freebies','f2p'].include?(args[i].downcase)
    fltr.push('Story') if ['story','stories','storys'].include?(args[i].downcase)
    fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
    fltr.push('Zodiac Seasonal') if ['zodiac','zodiacs','seazonal','seazonals','seazons','seazons'].include?(args[i].downcase)
    fltr.push('Summon') if ['summon','summons','summonable','summonables'].include?(args[i].downcase)
  end
  textra=''
  rarity.uniq!
  elem.uniq!
  wday.uniq!
  turn.uniq!
  ranged.uniq!
  fltr.uniq!
  char=@dragons.map{|q| q}.uniq
  search=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[1][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][q]}"}.join(', ')}")
  end
  if elem.length>0
    char=char.reject{|q| !elem.include?(q[2])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
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
    if fltr.include?('Welfare')
      m.push('1w')
      m.push('2w')
      m.push('3w')
      m.push('4w')
      m.push('5w')
    end
    if fltr.include?('Seasonal')
      m.push('1s')
      m.push('2s')
      m.push('3s')
      m.push('4s')
      m.push('5s')
    end
    if fltr.include?('Zodiac Seasonal')
      m.push('1z')
      m.push('2z')
      m.push('3z')
      m.push('4z')
      m.push('5z')
    end
    if fltr.include?('Story')
      m.push('1y')
      m.push('2y')
      m.push('3y')
      m.push('4y')
      m.push('5y')
    end
    if fltr.include?('Summon')
      m.push('1')
      m.push('2')
      m.push('3')
      m.push('4')
      m.push('5')
    end
    char=char.reject{|q| !m.include?(q[1])}.uniq
    search.push("*Filters*: #{fltr.join(', ')}")
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode==0
    event.respond "Too much data is trying to be displayed.  Please use this command in PM."
    return nil
  else
    return [search,char]
  end
end

def find_in_wyrmprints(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  clzz=[]
  fltr=[]
  for i in 0...args.length
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>2 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>2 && args[i][0,1].to_i<6
    clzz.push('Attack') if ['attack','atk','att','attacking'].include?(args[i].downcase)
    clzz.push('Defense') if ['defense','defence','def','defending','defensive','defencive'].include?(args[i].downcase)
    clzz.push('Support') if ['support','supports','supportive','supporting'].include?(args[i].downcase)
    clzz.push('Healing') if ['heal','healing','heals','healer','healers'].include?(args[i].downcase)
    fltr.push('Welfare') if ['welfare','welfares','free','freebies','f2p'].include?(args[i].downcase)
    fltr.push('Story') if ['story','stories','storys'].include?(args[i].downcase)
    fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
    fltr.push('Zodiac Seasonal') if ['zodiac','zodiacs','seazonal','seazonals','seazons','seazons'].include?(args[i].downcase)
    fltr.push('Summon') if ['summon','summons','summonable','summonables'].include?(args[i].downcase)
  end
  textra=''
  rarity.uniq!
  clzz.uniq!
  char=@wyrmprints.map{|q| q}.uniq
  search=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[1][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][q]}"}.join(', ')}")
  end
  if clzz.length>0
    char=char.reject{|q| !clzz.include?(q[2])}.uniq
    for i in 0...clzz.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{clzz[i]}"}
      clzz[i]="#{moji[0].mention}#{clzz[i]}" if moji.length>0
    end
    search.push("*Amulet Types*: #{clzz.join(', ')}")
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Welfare')
      m.push('1w')
      m.push('2w')
      m.push('3w')
      m.push('4w')
      m.push('5w')
    end
    if fltr.include?('Seasonal')
      m.push('1s')
      m.push('2s')
      m.push('3s')
      m.push('4s')
      m.push('5s')
    end
    if fltr.include?('Zodiac Seasonal')
      m.push('1z')
      m.push('2z')
      m.push('3z')
      m.push('4z')
      m.push('5z')
    end
    if fltr.include?('Story')
      m.push('1y')
      m.push('2y')
      m.push('3y')
      m.push('4y')
      m.push('5y')
    end
    if fltr.include?('Summon')
      m.push('1')
      m.push('2')
      m.push('3')
      m.push('4')
      m.push('5')
    end
    char=char.reject{|q| !m.include?(q[1])}.uniq
    search.push("*Filters*: #{fltr.join(', ')}")
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode==0
    event.respond "Too much data is trying to be displayed.  Please use this command in PM."
    return nil
  else
    return [search,char]
  end
end

def find_in_weapons(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  elem=[]
  wpn=[]
  fltr=[]
  for i in 0...args.length
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>2 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>2 && args[i][0,1].to_i<6
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    elem.push('None') if ['none','no-element','no_element','noelement','elementless'].include?(args[i].downcase)
    wpn.push('Sword') if ['sword','swords'].include?(args[i].downcase)
    wpn.push('Blade') if ['blade','blades','sabers','saber'].include?(args[i].downcase)
    wpn.push('Dagger') if ['dagger','daggers','knife','knifes','knives'].include?(args[i].downcase)
    wpn.push('Axe') if ['axes','axe'].include?(args[i].downcase)
    wpn.push('Bow') if ['bow','bows','arrow','arrows','archer','archers'].include?(args[i].downcase)
    wpn.push('Lance') if ['lance','lances','pitchfork','pitchforks','trident','tridents'].include?(args[i].downcase)
    wpn.push('Wand') if ['wand','wands'].include?(args[i].downcase)
    wpn.push('Staff') if ['staff','staffs','staves'].include?(args[i].downcase)
    fltr.push('Welfare') if ['welfare','welfares','free','freebies','f2p'].include?(args[i].downcase)
    fltr.push('Enemy') if ['enemy','enemys','enemies'].include?(args[i].downcase)
    fltr.push('Story') if ['story','stories','storys'].include?(args[i].downcase)
    fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
    fltr.push('Zodiac Seasonal') if ['zodiac','zodiacs','seazonal','seazonals','seazons','seazons'].include?(args[i].downcase)
    fltr.push('Summon') if ['summon','summons','summonable','summonables'].include?(args[i].downcase)
  end
  textra=''
  rarity.uniq!
  elem.uniq!
  wpn.uniq!
  fltr.uniq!
  char=@weapons.map{|q| q}.uniq
  search=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[2][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][q]}"}.join(', ')}")
  end
  if elem.length>0
    char=char.reject{|q| !elem.include?(q[3])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if wpn.length>0
    char=char.reject{|q| !wpn.include?(q[1])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[i]}"}
      wpn[i]="#{moji[0].mention}#{wpn[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn.join(', ')}")
  end
  if fltr.length>0
    m=[]
    if fltr.include?('Welfare')
      m.push('1w')
      m.push('2w')
      m.push('3w')
      m.push('4w')
      m.push('5w')
    end
    if fltr.include?('Seasonal')
      m.push('1s')
      m.push('2s')
      m.push('3s')
      m.push('4s')
      m.push('5s')
    end
    if fltr.include?('Zodiac Seasonal')
      m.push('1z')
      m.push('2z')
      m.push('3z')
      m.push('4z')
      m.push('5z')
    end
    if fltr.include?('Story')
      m.push('1y')
      m.push('2y')
      m.push('3y')
      m.push('4y')
      m.push('5y')
    end
    if fltr.include?('Enemy')
      m.push('1e')
      m.push('2e')
      m.push('3e')
      m.push('4e')
      m.push('5e')
    end
    if fltr.include?('Summon')
      m.push('1')
      m.push('2')
      m.push('3')
      m.push('4')
      m.push('5')
    end
    char=char.reject{|q| !m.include?(q[2])}.uniq
    search.push("*Filters*: #{fltr.join(', ')}")
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode==0
    event.respond "Too much data is trying to be displayed.  Please use this command in PM."
    return nil
  else
    return [search,char]
  end
end

def find_adventurers(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_adventurers(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length>=1900
    str="__**Adventurer Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    flds=nil
    flds=triple_finish(char) unless char.length<=0
    textra=''
    textra="**No adventurers match your search**" if char.length<=0
    create_embed(event,"__**Adventurer Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

def find_dragons(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_dragons(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length>=1900
    str="__**Dragon Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    flds=nil
    flds=triple_finish(char) unless char.length<=0
    textra=''
    textra="**No dragons match your search**" if char.length<=0
    create_embed(event,"__**Dragon Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

def find_wyrmprints(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_wyrmprints(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length>=1900
    str="__**Wyrmprint Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    flds=nil
    flds=triple_finish(char) unless char.length<=0
    textra=''
    textra="**No wyrmprints match your search**" if char.length<=0
    create_embed(event,"__**Wyrmprint Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

def find_weapons(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_weapons(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length>=1900
    str="__**Weapon Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    flds=nil
    flds=triple_finish(char) unless char.length<=0
    textra=''
    textra="**No weapons match your search**" if char.length<=0
    create_embed(event,"__**Weapons Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

def find_all(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  adv=find_in_adventurers(bot,event,args)
  drg=find_in_dragons(bot,event,args)
  wrm=find_in_wyrmprints(bot,event,args)
  wpn=find_in_weapons(bot,event,args)
  adv=nil if adv[1].length>=@adventurers.length
  drg=nil if drg[1].length>=@dragons.length
  wrm=nil if wrm[1].length>=@wyrmprints.length
  wpn=nil if wpn[1].length>=@weapons.length
  return nil if adv.nil? && drg.nil? && wrm.nil? && wpn.nil?
  if adv.nil? && wrm.nil? && wpn.nil?
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
  adv=[[],[]] if adv.nil?
  drg=[[],[]] if drg.nil?
  wrm=[[],[]] if wrm.nil?
  wpn=[[],[]] if wpn.nil?
  adv[1]=adv[1].sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  drg[1]=drg[1].sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  wrm[1]=wrm[1].sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  wpn[1]=wpn[1].sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  search="#{adv[0].join("\n")}\n#{drg[0].join("\n")}\n#{wrm[0].join("\n")}\n#{wpn[0].join("\n")}".split("\n")
  search=search.reject{|q| count_in(search,q)<2}.uniq
  adv[0]=adv[0].reject{|q| search.include?(q)}
  drg[0]=drg[0].reject{|q| search.include?(q)}
  wrm[0]=wrm[0].reject{|q| search.include?(q)}
  wpn[0]=wpn[0].reject{|q| search.include?(q)}
  str=''
  str="__**Overall Search**__\n#{search.join("\n")}" if search.length>0
  str="#{str}\n\n__**Adventurer Search**__\n#{adv[0].join("\n")}" if adv[0].length>0
  str="#{str}\n\n__**Dragon Search**__\n#{drg[0].join("\n")}" if drg[0].length>0
  str="#{str}\n\n__**Wyrmprint Search**__\n#{wrm[0].join("\n")}" if wrm[0].length>0
  str="#{str}\n\n__**Weapon Search**__\n#{wpn[0].join("\n")}" if wpn[0].length>0
  str="#{str}\n\n__**Results**__"
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || str.length+adv[1].join("\n").length+drg[1].join("\n").length+wrm[1].join("\n").length+wpn[1].join("\n").length+"Totals: #{adv[1].length} adventurers, #{drg[1].length} dragons, #{wrm[1].length} wyrmprints, #{wpn[1].length} weapons".length>=1800
    str="#{str}\n*Adventurers:* #{adv[1][0]}"
    for i in 1...adv[1].length
      str=extend_message(str,adv[1][i],event,1,', ')
    end
    str=extend_message(str,"*Dragons:* #{drg[1][0]}",event)
    for i in 1...drg[1].length
      str=extend_message(str,drg[1][i],event,1,', ')
    end
    str=extend_message(str,"*Wyrmprints:* #{wrm[1][0]}",event)
    for i in 1...wrm[1].length
      str=extend_message(str,wrm[1][i],event,1,', ')
    end
    str=extend_message(str,"*Weapons:* #{wpn[1][0]}",event)
    for i in 1...wpn[1].length
      str=extend_message(str,wpn[1][i],event,1,', ')
    end
    str=extend_message(str,"Totals: #{adv[1].length} adventurers, #{drg[1].length} dragons, #{wrm[1].length} wyrmprints, #{wpn[1].length} weapons",event,2)
    event.respond str
  else
    flds=nil
    flds=[] unless adv[1].length<=0 && drg[1].length<=0 && wrm[1].length<=0
    flds.push(['Adventurers',adv[1].join("\n")]) if adv[1].length>0
    flds.push(['Dragons',drg[1].join("\n")]) if drg[1].length>0
    flds.push(['Wyrmprints',wrm[1].join("\n")]) if wrm[1].length>0
    flds.push(['Weapons',wpn[1].join("\n")]) if wpn[1].length>0
    textra=''
    textra="**No data matches your search**" if adv[1].length<=0 && drg[1].length<=0 && wrm[1].length<=0 && wpn[1].length<=0
    create_embed(event,str,textra,0xCE456B,"Totals: #{adv[1].length} adventurers, #{drg[1].length} dragons, #{wrm[1].length} wyrmprints, #{wpn[1].length} weapons",nil,flds)
  end
end

def spaceship_order(x)
  return 1 if x=='Adventurer'
  return 2 if x=='Dragon'
  return 3 if x=='Wyrmprint'
  return 4 if x=='Weapon'
  return 500
end

def add_new_alias(bot,event,newname=nil,unit=nil,modifier=nil,modifier2=nil,mode=0)
  data_load()
  nicknames_load()
  err=false
  str=''
  if newname.nil? || unit.nil?
    str="The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n\nYou must specify both:\n- one of the above\n- an alias you wish to give that item"
    err=true
  elsif event.user.id != 167657750971547648 && event.server.nil?
    str='Only my developer is allowed to use this command in PM.'
    err=true
  elsif (!is_mod?(event.user,event.server,event.channel) && ![368976843883151362,195303206933233665].include?(event.user.id)) && event.channel.id != 502288368777035777
    str='You are not a mod.'
    err=true
  elsif newname.include?('"') || newname.include?("\n")
    str='Full stop.  " is not allowed in an alias.'
    err=true
  elsif !event.server.nil? && event.server.id==363917126978764801
    err="You guys revoked your permission to add aliases when you refused to listen to me regarding the Erk alias for Serra.  Even if that was an alias for FEH instead of FGO."
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
  elsif find_skill(newname,event,true).length>0
    type[0]='Skill'
  elsif find_ability(newname,event,true).length>0
    type[0]='Ability'
  elsif find_adventurer(newname,event).length>0
    type[0]='Adventurer*'
  elsif find_dragon(newname,event).length>0
    type[0]='Dragon*'
  elsif find_wyrmprint(newname,event).length>0
    type[0]='Wyrmprint*'
  elsif find_weapon(newname,event).length>0
    type[0]='Weapon*'
  elsif find_skill(newname,event).length>0
    type[0]='Skill*'
  elsif find_ability(newname,event).length>0
    type[0]='Ability*'
  end
  if find_adventurer(unit,event,true).length>0
    type[1]='Adventurer'
  elsif find_dragon(unit,event,true).length>0
    type[1]='Dragon'
  elsif find_wyrmprint(unit,event,true).length>0
    type[1]='Wyrmprint'
  elsif find_weapon(unit,event,true).length>0
    type[1]='Weapon'
  elsif find_skill(unit,event,true).length>0
    type[1]='Skill'
  elsif find_ability(unit,event,true).length>0
    type[1]='Ability'
  elsif find_adventurer(unit,event).length>0
    type[1]='Adventurer*'
  elsif find_dragon(unit,event).length>0
    type[1]='Dragon*'
  elsif find_wyrmprint(unit,event).length>0
    type[1]='Wyrmprint*'
  elsif find_weapon(unit,event).length>0
    type[1]='Weapon*'
  elsif find_skill(unit,event).length>0
    type[1]='Skill*'
  elsif find_ability(unit,event).length>0
    type[1]='Ability*'
  end
  checkstr=normalize(newname)
  if type.reject{|q| q != 'Alias'}.length<=0
    type[0]='Alias' if type[0].include?('*')
    type[1]='Alias' if type[1].include?('*') && type[0]!='Alias'
  end
  if type.reject{|q| q == 'Alias'}.length<=0
    str="The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n\nNeither #{newname} nor #{unit} fall into any of these categories."
    err=true
  elsif type.reject{|q| q != 'Alias'}.length<=0
    event.respond "#{newname} is a #{type[0].downcase}\n#{unit} is a #{type[1].downcase}"
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
  end
  if type[1]=='Adventurer'
    unit=find_adventurer(unit,event)
    dispstr=['Adventurer',unit[0],'Adventurer',unit[0]]
  elsif type[1]=='Dragon'
    unit=find_dragon(unit,event)
    dispstr=['Dragon',unit[0],'Dragon',unit[0]]
  elsif type[1]=='Wyrmprint'
    unit=find_wyrmprint(unit,event)
    dispstr=['Wyrmprint',unit[1],'Wyrmprint',unit[0]]
  elsif type[1]=='Weapon'
    unit=find_weapon(unit,event)
    dispstr=['Weapon',unit[0],'Weapon',unit[0]]
  elsif type[1]=='Skill'
    unit=find_skill(unit,event)
    dispstr=['Skill',unit[0],'Skill',unit[0]]
  elsif type[1]=='Ability'
    unit=find_ability(unit,event)
    if unit[0].is_a?(Array) && unit.length<=1
      dispstr=['Ability',"#{unit[0][0]} #{unit[0][1]}",'Ability',"#{unit[0][0]} #{unit[0][1]}"]
    elsif unit[0].is_a?(Array)
      dispstr=['Ability',unit[0][0],'Ability',unit[0][0]]
    else
      dispstr=['Ability',"#{unit[0]} #{unit[1]}",'Ability',"#{unit[0]} #{unit[1]}"]
    end
  end
  logchn=536307117301170187
  logchn=431862993194582036 if @shardizard==4
  newname=newname.gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')
  srv=0
  srv=event.server.id unless event.server.nil?
  srv=modifier.to_i if event.user.id==167657750971547648 && modifier.to_i.to_s==modifier
  srvname='PM with dev'
  srvname=bot.server(srv).name unless event.server.nil? && srv.zero?
  checkstr=normalize(newname)
  k=event.message.emoji
  for i in 0...k.length
    checkstr=checkstr.gsub("<:#{k[i].name}:#{k[i].id}>",k[i].name)
  end
  if checkstr.downcase =~ /(7|t)+?h+?(o|0)+?(7|t)+?/
    event.respond "That name has __***NOT***__ been added to #{dispstr[1]}'s aliases."
    bot.channel(logchn).send_message("~~**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** #{newname} for #{dispstr[1]}~~\n**Reason for rejection:** Begone, alias.")
    return nil
  elsif checkstr.downcase =~ /n+?((i|1)+?|(e|3)+?)(b|g|8)+?(a|4|(e|3)+?r+?)+?/
    event.respond "That name has __***NOT***__ been added to #{dispstr[1]}'s aliases."
    bot.channel(logchn).send_message("~~**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** >Censored< for #{dispstr[1]}~~\n**Reason for rejection:** Begone, alias.")
    return nil
  end
  newname=normalize(newname)
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
  m=nil if event.channel.id==502288368777035777 && !modifier.nil?
  double=false
  for i in 0...@aliases.length
    if @aliases[i][3].nil?
    elsif @aliases[i][1].downcase==newname.downcase && @aliases[i][2]==dispstr[3]
      if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==502288368777035777) && !modifier.nil?
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
    bot.channel(chn).send_message("**#{newname}** has been#{" globally" if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==502288368777035777) && !modifier.nil?} added to the aliases for the #{dispstr[2].downcase} *#{dispstr[1]}*.\nPlease test to be sure that the alias stuck.")
    event.respond "#{newname} has been added to #{dispstr[1]}'s aliases#{" globally" if event.user.id==167657750971547648 && !modifier.nil?}." if event.user.id==167657750971547648 && !modifier2.nil? && modifier2.to_i.to_s==modifier2
    bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n**#{dispstr[2]} Alias:** #{newname} for #{dispstr[1]}#{" - global alias" if ([167657750971547648,368976843883151362,195303206933233665].include?(event.user.id) || event.channel.id==502288368777035777) && !modifier.nil?}")
  end
  @aliases.uniq!
  nzzz=@aliases.map{|a| a}
  open('C:/Users/Mini-Matt/Desktop/devkit/DLNames.txt', 'w') { |f|
    for i in 0...nzzz.length
      f.puts "#{nzzz[i].to_s}#{"\n" if i<nzzz.length-1}"
    end
  }
  nicknames_load()
  nzz=nicknames_load(2)
  nzzz=@aliases.map{|a| a}
  if nzzz[nzzz.length-1].length>1 && nzzz[nzzz.length-1][2]>=nzz[nzz.length-1][2]
    bot.channel(logchn).send_message('Alias list saved.')
    open('C:/Users/Mini-Matt/Desktop/devkit/DLNames2.txt', 'w') { |f|
      for i in 0...nzzz.length
        f.puts "#{nzzz[i].to_s}#{"\n" if i<nzzz.length-1}"
      end
    }
    bot.channel(logchn).send_message('Alias list has been backed up.')
  end
end

def disp_aliases(bot,event,args=nil,mode=0)
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
    elsif find_data_ex(:find_skill,args.join(''),event).length>0
    elsif find_data_ex(:find_ability,args.join(''),event).length>0
    elsif has_any?(args,['adventurer','adventurers','adv','advs','unit','units','dragon','dragons','wyrmprint','wyrm','print','weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap','skill','skil','skills','skils','ability','abilitys','abilities','abil','abils','able','ables'])
    else
      event.respond "The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Abilities\n\n#{args.join(' ')} does not fall into any of these categories."
      return nil
    end
  end
  adv=find_data_ex(:find_adventurer,args.join(''),event)
  adv=nil if adv.length<=0 || args.length.zero?
  drg=find_data_ex(:find_dragon,args.join(''),event)
  drg=nil if drg.length<=0 || args.length.zero?
  wrm=find_data_ex(:find_wyrmprint,args.join(''),event)
  wrm=nil if wrm.length<=0 || args.length.zero?
  wpn=find_data_ex(:find_weapon,args.join(''),event)
  wpn=nil if wpn.length<=0 || args.length.zero?
  skl=find_data_ex(:find_skill,args.join(''),event)
  skl=nil if skl.length<=0 || args.length.zero?
  abl=find_data_ex(:find_ability,args.join(''),event)
  abl=nil if abl.length<=0 || args.length.zero?
  f=[]
  n=@aliases.reject{|q| q[0]!='Adventurer'}.map{|q| [q[1],q[2],q[3]]}
  h=''
  if adv.nil? && drg.nil? && wrm.nil? && wpn.nil? && abl.nil? && abl.nil?
    if has_any?(args,['adventurer','adventurers','adv','advs','unit','units'])
      n=n.reject{|q| q[2].nil?} if mode==1
      f.push('__**Adventurer Aliases**__')
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['dragon','dragons'])
      f.push('__**Dragon Aliases**__')
      n=@aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['wyrmprint','wyrm','print'])
      f.push('__**Wyrmprint Aliases**__')
      n=@aliases.reject{|q| q[0]!='Wyrmprint'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'])
      f.push('__**Weapon Aliases**__')
      n=@aliases.reject{|q| q[0]!='Weapon'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['skill','skil','skills','skils'])
      f.push('__**Skill Aliases**__')
      n=@aliases.reject{|q| q[0]!='Skill'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    elsif has_any?(args,['ability','abilitys','abilities','abil','abils','able','ables'])
      f.push('__**Ability Aliases**__')
      n=@aliases.reject{|q| q[0]!='Ability'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
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
          msg=extend_message(msg,"#{n[i][0]} = #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Dragon Aliases**__',event,2)
        n=@aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0]} = #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Wyrmprint Aliases**__',event,2)
        n=@aliases.reject{|q| q[0]!='Wyrmprint'}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0]} = #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Weapon Aliases**__',event,2)
        n=@aliases.reject{|q| !['Weapon'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0]} = #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Skill Aliases**__',event,2)
        n=@aliases.reject{|q| !['Skill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0]} = #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Ability Aliases**__',event,2)
        n=@aliases.reject{|q| !['Ability'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0]} = #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        event.respond msg
        return nil
      end
      f.push('__**Adventurer Aliases**__')
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Dragon Aliases**__")
      n=@aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Wyrmprint Aliases**__")
      n=@aliases.reject{|q| q[0]!='Wyrmprint'}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Weapon Aliases**__")
      n=@aliases.reject{|q| !['Weapon'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Skill Aliases**__")
      n=@aliases.reject{|q| !['Skill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
      f.push("\n__**Ability Aliases**__")
      n=@aliases.reject{|q| !['Ability'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
      n=n.reject{|q| q[2].nil?} if mode==1
      for i in 0...n.length
        if n[i][2].nil?
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}")
        elsif !event.server.nil? && n[i][2].include?(event.server.id)
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]}#{" *(in this server only)*" unless mode==1}")
        else
          a=[]
          for j in 0...n[i][2].length
            srv=(bot.server(n[i][2][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              a.push("*#{bot.server(n[i][2][j]).name}*") unless event.user.on(n[i][2][j]).nil?
            end
          end
          f.push("#{n[i][0].gsub('_','\_')} = #{n[i][1]} (in the following servers: #{list_lift(a,'and')})") if a.length>0
        end
      end
    else
      event.respond "The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n\nPlease either specify a member of one of these categories or use this command in PM."
      return nil
    end
  elsif !adv.nil?
    n=n.reject{|q| q[2].nil?} if mode==1
    k=0
    k=event.server.id unless event.server.nil?
    f.push("__**#{adv[0]}**__#{"'s server-specific aliases" if mode==1}")
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
    n=@aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{drg[0]}**__#{"'s server-specific aliases" if mode==1}")
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
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{wrm[0]}**__#{"'s server-specific aliases" if mode==1}")
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
    n=@aliases.reject{|q| !['Weapon'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{wpn[0]}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(wpn[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if wpn[0].include?('(') || wpn[0].include?(')') || wpn[0].include?(' ') || wpn[0].include?('!') || wpn[0].include?('_') || wpn[0].include?('?') || wpn[0].include?("'") || wpn[0].include?('"')
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
  elsif !skl.nil?
    n=@aliases.reject{|q| !['Skill'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
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
  end
  f.uniq!
  if f.length>50 && !safe_to_spam?(event)
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

def roost(event,bot,args=nil,ignoreinputs=false)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.map{|q| q.downcase}
  t=Time.now
  timeshift=7
  timeshift-=1 unless t.dst?
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
  str="#{str}\nDays since game release: #{longFormattedNumber(date)}#{'~~' unless sftday==t.wday}"
  str3=''
  if sftday<0
    t+=24*60*60
    t2=Time.new(2018,9,27)-60*60
    t2=t-t2
    date=(((t2.to_i/60)/60)/24)
    str="#{str}\n\nTomorrow's date: #{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]})"
    str="#{str}\nDays since game release, come tomorrow: #{longFormattedNumber(date)}"
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
  end
  str="#{str}\n\n__**#{"#{str3}'s " if str3.length>0}Elemental Ruins:**__"
  str="#{str}\n*Open:* #{['<:Element_Null:532106087810334741>All','<:Element_Null:532106087810334741>All','<:Element_Flame:532106087952810005>Flamehowl','<:Element_Water:532106088221376522>Waterscour','<:Element_Wind:532106087948746763>Windmaul','<:Element_Light:532106088129101834>Lightsunder','<:Element_Shadow:532106088154267658>Shadowsteep'][t.wday]}"
  str="#{str}\n*Difficulties:* Beginner, Standard#{', Expert' if t.wday>1}"
  str="#{str}\n*Available Orbs:* #{['','','Flame, Blaze, Inferno','Water, Stream, Deluge','Wind, Storm, Maelstorm','Light, Radiance, Refulgence','Shadow, Nightfull, Nether'][t.wday]}" if t.wday>1
  str="#{str}\n\n**#{"#{str3}'s " if str3.length>0}Bond Gift:** #{['Golden Chalice','Juicy Meat','Kaleidoscope','Floral Circlet','Compelling Book','Mana Essence','Golden Chalice'][t.wday]}"
  if t.wday>0 && t.wday<6
    drg=@dragons.reject{|q| q[9]!=t.wday}.map{|q| q[0]}
    create_embed(event,str,'',0xCE456B,nil,nil,triple_finish(drg))
  else
    event.respond str
  end
end

bot.command([:roost,:ruin,:ruins]) do |event, *args|
  return nil if overlap_prevent(event)
  roost(event,bot,args)
end

bot.command([:today,:daily,:dailies,:now,:todayindl,:todayinDL,:todayInDL,:today_in_dl,:today_In_DL,:today_in_DL,:today_In_dl]) do |event, *args|
  return nil if overlap_prevent(event)
  roost(event,bot,args,true)
end

bot.command([:tomorrow,:tommorrow,:tomorow,:tommorow]) do |event, *args|
  return nil if overlap_prevent(event)
  roost(event,bot,args,-1)
end

bot.command([:find,:search]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    args.shift
    find_adventurers(bot,event,args)
    return nil
  elsif ['dragon','dragons'].include?(args[0].downcase)
    args.shift
    find_dragons(bot,event,args)
    return nil
  elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
    args.shift
    find_wyrmprints(bot,event,args)
    return nil
  elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(args[0].downcase)
    args.shift
    find_weapons(bot,event,args)
    return nil
  end
  find_all(bot,event,args)
end

bot.command([:adventurer,:adv,:unit]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_adventurers(bot,event,args)
    return nil
  end
  disp_adventurer_stats(bot,event,args)
end

bot.command([:dragon]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_dragons(bot,event,args)
    return nil
  end
  disp_dragon_stats(bot,event,args)
end

bot.command([:wyrmprint,:wyrm,:print]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_wyrmprints(bot,event,args)
    return nil
  end
  disp_wyrmprint_stats(bot,event,args)
end

bot.command([:weapon,:wep,:weap,:wpn]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_weapons(bot,event,args)
    return nil
  end
  disp_weapon_stats(bot,event,args)
end

bot.command([:skill,:skil]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_skill_data(bot,event,args)
end

bot.command([:ability,:abil,:aura]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_ability_data(bot,event,args)
end

bot.command(:addalias) do |event, newname, unit, modifier, modifier2|
  return nil if overlap_prevent(event)
  add_new_alias(bot,event,newname,unit,modifier,modifier2)
end

bot.command(:alias) do |event, newname, unit, modifier, modifier2|
  return nil if overlap_prevent(event)
  add_new_alias(bot,event,newname,unit,modifier,modifier2,1)
end

bot.command([:checkaliases,:aliases,:seealiases]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_aliases(bot,event,args)
end

bot.command([:serveraliases,:saliases]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_aliases(bot,event,args,1)
end

bot.command([:deletealias,:removealias]) do |event, name|
  return nil if overlap_prevent(event)
  nicknames_load()
  if name.nil?
    event.respond "I can't delete nothing!" if name.nil?
    return nil
  elsif event.user.id != 167657750971547648 && event.server.nil?
    event.respond 'Only my developer is allowed to use this command in PM.'
    return nil
  elsif !is_mod?(event.user,event.server,event.channel)
    event.respond 'You are not a mod.'
    return nil
  elsif find_adventurer(name,event).length<=0 && find_dragon(name,event).length<=0 && find_wyrmprint(name,event).length<=0 && find_weapon(name,event).length<=0 && find_skill(name,event).length<=0 && find_ability(name,event).length<=0
    event.respond "#{name} is not an alias!"
    return nil
  end
  if find_adventurer(name,event,true).length>0
    j=find_adventurer(name,event,true)
    j=["Adventurer","#{j[0]}"]
  elsif find_dragon(name,event,true).length>0
    j=find_dragon(name,event,true)
    j=["Dragon","#{j[0]}"]
  elsif find_wyrmprint(name,event,true).length>0
    j=find_wyrmprint(name,event,true)
    j=["Wyrmprint","#{j[0]}"]
  elsif find_weapon(name,event,true).length>0
    j=find_weapon(name,event,true)
    j=["Weapon","#{j[0]}"]
  elsif find_skill(name,event,true).length>0
    j=find_skill(name,event,true)
    j=["Skill","#{j[0]}"]
  elsif find_ability(name,event,true).length>0
    j=find_ability(name,event,true)
    if j[0].is_a?(Array)
      j=["Ability","#{j[0][0]}"]
    else
      j=["Ability","#{j[0]} #{j[1]}"]
    end
  elsif find_adventurer(name,event).length>0
    j=find_adventurer(name,event)
    j=["Adventurer","#{j[0]}"]
  elsif find_dragon(name,event).length>0
    j=find_dragon(name,event)
    j=["Dragon","#{j[0]}"]
  elsif find_wyrmprint(name,event).length>0
    j=find_wyrmprint(name,event)
    j=["Wyrmprint","#{j[0]}"]
  elsif find_weapon(name,event).length>0
    j=find_weapon(name,event)
    j=["Weapon","#{j[0]}"]
  elsif find_skill(name,event).length>0
    j=find_skill(name,event)
    j=["Skill","#{j[0]}"]
  elsif find_ability(name,event).length>0
    j=find_ability(name,event)
    if j[0].is_a?(Array)
      j=["Ability","#{j[0][0]}"]
    else
      j=["Ability","#{j[0]} #{j[1]}"]
    end
  end
  k=0
  k=event.server.id unless event.server.nil?
  for izzz in 0...@aliases.length
    if @aliases[izzz][1].downcase==name.downcase
      if @aliases[izzz][3].nil? && event.user.id != 167657750971547648
        event.respond 'You cannot remove a global alias'
        return nil
      elsif @aliases[izzz][3].nil? || @aliases[izzz][3].include?(k)
        unless @aliases[izzz][3].nil?
          for izzz2 in 0...@aliases[izzz][3].length
            @aliases[izzz][3][izzz2]=nil if @aliases[izzz][3][izzz2]==k
          end
          @aliases[izzz][3].compact!
        end
        @aliases[izzz]=nil if @aliases[izzz][3].nil? || @aliases[izzz][3].length<=0
      end
    end
  end
  @aliases.uniq!
  @aliases.compact!
  logchn=536307117301170187
  logchn=431862993194582036 if @shardizard==4
  srv=0
  srv=event.server.id unless event.server.nil?
  srvname='PM with dev'
  srvname=bot.server(srv).name unless event.server.nil? && srv.zero?
  bot.channel(logchn).send_message("**Server:** #{srvname} (#{srv})\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:** #{event.user.distinct} (#{event.user.id})\n~~**#{j[0]} Alias:** #{name} for #{j[1]}~~ **DELETED**.")
  open('C:/Users/Mini-Matt/Desktop/devkit/DLNames.txt', 'w') { |f|
    for i in 0...@aliases.length
      f.puts "#{@aliases[i].to_s}#{"\n" if i<@aliases.length-1}"
    end
  }
  event.respond "#{name} has been removed from #{j[1]}'s aliases."
  nicknames_load()
  nzz=nicknames_load(2)
  nzzz=@aliases.map{|a| a}
  if nzzz[nzzz.length-1].length>2 && nzzz[nzzz.length-1][2]>=nzz[nzz.length-1][2]
    bot.channel(logchn).send_message("Alias list saved.")
    open('C:/Users/Mini-Matt/Desktop/devkit/DLNames.txt', 'w') { |f|
      for i in 0...nzzz.length
        f.puts "#{nzzz[i].to_s}#{"\n" if i<nzzz.length-1}"
      end
    }
    bot.channel(logchn).send_message("Alias list has been backed up.")
  end
  return nil
end

bot.command([:channellist,:chanelist,:spamchannels,:spamlist]) do |event|
  return nil if overlap_prevent(event)
  if event.server.nil?
    event.respond "Yes, it is safe to spam here."
    return nil
  end
  sfe=[[],[]]
  for i in 0...event.server.channels.length
    chn=event.server.channels[i]
    if safe_to_spam?(event,chn)
      sfe[0].push(chn.mention)
    end
  end
  event << '__**All long replies are safe**__'
  event << sfe[0].join("\n")
  event << 'In PM with any user'
end

bot.command([:bugreport, :suggestion, :feedback]) do |event, *args|
  return nil if overlap_prevent(event)
  bug_report(bot,event,args,4,['Defense','Attack','Healing','Support','Null'],'Class',@prefix,141260274144509952)
end

bot.command([:donation, :donate]) do |event, uid|
  return nil if overlap_prevent(event)
  donor_embed(bot,event)
end

bot.command([:shard,:attribute]) do |event, i|
  return nil if overlap_prevent(event)
  if i.to_i.to_s==i && i.to_i.is_a?(Integer) && @shardizard != 4
    srv=(bot.server(i.to_i) rescue nil)
    if srv.nil? || bot.user(502288364838322176).on(srv.id).nil?
      event.respond "I am not in that server, but it would be assigned the #{['<:Type_Defense:532107867264909314> Defense','<:Type_Attack:532107867520630784> Attack','<:Type_Healing:532107867348533249> Healing','<:Type_Support:532107867575156747> Support','<:Element_Null:532106087810334741> Null'][(i.to_i >> 22) % 4]} Class."
    else
      event.respond "#{srv.name} is assigned the #{['<:Type_Defense:532107867264909314> Defense','<:Type_Attack:532107867520630784> Attack','<:Type_Healing:532107867348533249> Healing','<:Type_Support:532107867575156747> Support','<:Element_Null:532106087810334741> Null'][(i.to_i >> 22) % 4]} Class."
    end
    return nil
  end
  event.respond 'This is the debug mode, which is assigned the <:Element_Null:532106087810334741> Null Class.' if @shardizard==4
  event.respond 'PMs always are assigned the <:Type_Defense:532107867264909314> Defense Class.' if event.server.nil?
  event.respond "This server is assigned the #{['<:Type_Defense:532107867264909314> Defense','<:Type_Attack:532107867520630784> Attack','<:Type_Healing:532107867348533249> Healing','<:Type_Support:532107867575156747> Support','<:Element_Null:532106087810334741> Null'][(event.server.id >> 22) % 4]} Class." unless event.server.nil? || @shardizard==4
end

bot.command([:safe,:spam,:safetospam,:safe2spam,:long,:longreplies]) do |event, f|
  return nil if overlap_prevent(event)
  f='' if f.nil?
  metadata_load()
  if event.server.nil?
    event.respond 'It is safe for me to send long replies here because this is my PMs with you.'
  elsif [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(event.server.id)
    event.respond 'It is safe for me to send long replies here because this is one of my emoji servers.'
  elsif @shardizard==4
    event.respond 'It is safe for me to send long replies here because this is my debug mode.'
  elsif ['bots','bot'].include?(event.channel.name.downcase)
    event.respond "It is safe for me to send long replies here because the channel is named `#{event.channel.name.downcase}`."
  elsif event.channel.name.downcase.include?('bot') && event.channel.name.downcase.include?('spam')
    event.respond 'It is safe for me to send long replies here because the channel name includes both the word "bot" and the word "spam".'
  elsif event.channel.name.downcase.include?('bot') && event.channel.name.downcase.include?('command')
    event.respond 'It is safe for me to send long replies here because the channel name includes both the word "bot" and the word "command".'
  elsif event.channel.name.downcase.include?('bot') && event.channel.name.downcase.include?('channel')
    event.respond 'It is safe for me to send long replies here because the channel name includes both the word "bot" and the word "channel".'
  elsif event.channel.name.downcase.include?('botanbot') || event.channel.name.downcase.include?('botan-bot') || event.channel.name.downcase.include?('botan_bot') || event.channel.name.downcase.include?('buttonbot') || event.channel.name.downcase.include?('button-bot') || event.channel.name.downcase.include?('button_bot')
    event.respond 'It is safe for me to send long replies here because the channel name specifically calls attention to the fact that it is made for me.'
  elsif @spam_channels.include?(event.channel.id)
    if is_mod?(event.user,event.server,event.channel) && ['off','no','false'].include?(f.downcase)
      metadata_load()
      @spam_channels.delete(event.channel.id)
      metadata_save()
      event.respond 'This channel is no longer marked as safe for me to send long replies to.'
    else
      event << 'This channel has been specifically designated for me to be safe to send long replies to.'
      event << 'If you wish to turn them off, ask a server mod to type `DL!spam off` in this channel.'
    end
  elsif is_mod?(event.user,event.server,event.channel,1) && ['on','yes','true'].include?(f.downcase)
    metadata_load()
    @spam_channels.push(event.channel.id)
    metadata_save()
    event.respond 'This channel is now marked as safe for me to send long replies to.'
  else
    event << 'It is not safe for me to send long replies here.'
    event << ''
    event << 'If you wish to change that, try one of the following:'
    event << '- Change the channel name to "bots".'
    event << '- Change the channel name to include the word "bot" and one of the following words: "spam", "command(s)", "channel".'
    event << '- Have a server mod type `DL!spam on` in this channel.'
  end
end

bot.command(:sortaliases, from: 167657750971547648) do |event, *args|
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648
  data_load()
  nicknames_load()
  @aliases.uniq!
  @aliases.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? ((a[2].downcase <=> b[2].downcase) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2].downcase <=> b[2].downcase)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
  open('C:/Users/Mini-Matt/Desktop/devkit/DLNames.txt', 'w') { |f|
    for i in 0...@aliases.length
      f.puts "#{@aliases[i].to_s}#{"\n" if i<@aliases.length-1}"
    end
  }
  event.respond 'The alias list has been sorted alphabetically'
end

bot.command(:status, from: 167657750971547648) do |event, *args|
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648
  bot.game=args.join(' ')
  event.respond 'Status set.'
end

bot.command(:backupaliases, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 || event.channel.id==386658080257212417
  nicknames_load()
  nzz=nicknames_load(2)
  @aliases.uniq!
  @aliases.sort! {|a,b| (a[0] <=> b[0]) == 0 ? ((a[2] <=> b[2]) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2] <=> b[2])) : (a[0] <=> b[0])}
  nzzzzz=@aliases.map{|a| a}
  open('C:/Users/Mini-Matt/Desktop/devkit/DLNames2.txt', 'w') { |f|
    for i in 0...nzzzzz.length
      f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
    end
  }
  event.respond 'Alias list has been backed up.'
end

bot.command(:restorealiases, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  return nil unless [167657750971547648,bot.profile.id].include?(event.user.id) || event.channel.id==502288368777035777
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLNames2.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLNames2.txt').each_line do |line|
      b.push(eval line)
    end
  else
    b=[]
  end
  nzzzzz=b.uniq
  if nzzzzz[nzzzzz.length-1][1]<225
    event << 'Last backup of the alias list has been corrupted.  Restoring from manually-created backup.'
    if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLNames3.txt')
      b=[]
      File.open('C:/Users/Mini-Matt/Desktop/devkit/DLNames3.txt').each_line do |line|
        b.push(eval line)
      end
    else
      b=[]
    end
    nzzzzz=b.uniq
  else
    event << 'Last backup of the alias list being used.'
  end
  open('C:/Users/Mini-Matt/Desktop/devkit/DLNames.txt', 'w') { |f|
    for i in 0...nzzzzz.length
      f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
    end
  }
  event << 'Alias list has been restored from backup.'
end

bot.command(:sendmessage, from: 167657750971547648) do |event, channel_id, *args| # sends a message to a specific channel
  return nil if overlap_prevent(event)
  dev_message(bot,event,channel_id)
end

bot.command(:sendpm, from: 167657750971547648) do |event, user_id, *args| # sends a PM to a specific user
  return nil if overlap_prevent(event)
  dev_pm(bot,event,user_id)
end

bot.command(:ignoreuser, from: 167657750971547648) do |event, user_id| # causes Botan to ignore the specified user
  return nil if overlap_prevent(event)
  bliss_mode(bot,event,user_id)
end

bot.command(:leaveserver, from: 167657750971547648) do |event, server_id| # forces Botan to leave a server
  return nil if overlap_prevent(event)
  walk_away(bot,event,server_id)
end

bot.command(:cleanupaliases, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  event.channel.send_temporary_message('Please wait...',10)
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  nicknames_load()
  nmz=@aliases.map{|q| q}
  k=0
  k2=0
  for i in 0...nmz.length
    unless nmz[i][3].nil?
      for i2 in 0...nmz[i][3].length
        srv=(bot.server(nmz[i][3][i2]) rescue nil)
        if srv.nil? || bot.user(502288364838322176).on(srv.id).nil?
          k+=1
          nmz[i][3][i2]=nil
        end
      end
      nmz[i][3].compact!
      nmz[i]=nil if nmz[i][3].length<=0
    end
  end
  nmz.compact!
  open('C:/Users/Mini-Matt/Desktop/devkit/DLNames.txt', 'w') { |f|
    for i in 0...nmz.length
      f.puts "#{nmz[i].to_s}#{"\n" if i<nmz.length-1}"
    end
  }
  event << "#{k} aliases were removed due to being from servers I'm no longer in."
  event << "#{k2} aliases were removed due to being identical to the servant's name."
end

bot.command(:snagstats) do |event, f, f2|
  return nil if overlap_prevent(event)
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
    event << "**I am in #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x })} servers, reaching #{longFormattedNumber(@server_data[1].inject(0){|sum,x| sum + x })} unique members.**"
    event << "#{longFormattedNumber(@server_data[0][0])} server#{"s are" if @server_data[0][0]!=1}#{" is" unless @server_data[0][0]!=1} assigned the <:Type_Defense:532107867264909314> Defense class, reaching #{longFormattedNumber(@server_data[1][0])} unique members."
    event << "#{longFormattedNumber(@server_data[0][1])} server#{"s are" if @server_data[0][0]!=1}#{" is" unless @server_data[0][0]!=1} assigned the <:Type_Attack:532107867520630784> Attack class, reaching #{longFormattedNumber(@server_data[1][1])} unique members."
    event << "#{longFormattedNumber(@server_data[0][2])} server#{"s are" if @server_data[0][0]!=1}#{" is" unless @server_data[0][0]!=1} assigned the <:Type_Healing:532107867348533249> Healing class, reaching #{longFormattedNumber(@server_data[1][2])} unique members."
    event << "#{longFormattedNumber(@server_data[0][3])} server#{"s are" if @server_data[0][0]!=1}#{" is" unless @server_data[0][0]!=1} assigned the <:Type_Support:532107867575156747> Support class, reaching #{longFormattedNumber(@server_data[1][3])} unique members."
    return nil
  elsif ['code','lines','line','sloc'].include?(f.downcase)
    event.channel.send_temporary_message('Calculating data, please wait...',3)
    b=[[],[],[],[],[]]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/BotanBot.rb').each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[3].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[1].push(l) unless l.length<=0
    end
    File.open('C:/Users/Mini-Matt/Desktop/devkit/rot8er_functs.rb').each_line do |line|
      l=line.gsub("\n",'')
      b[0].push(l)
      b[4].push(l)
      l=line.gsub("\n",'').gsub(' ','')
      b[2].push(l) unless l.length<=0
    end
    event << "**I am #{longFormattedNumber(File.foreach("C:/Users/Mini-Matt/Desktop/devkit/BotanBot.rb").inject(0) {|c, line| c+1})} lines of code long.**"
    event << "Of those, #{longFormattedNumber(b[1].length)} are SLOC (non-empty)."
    event << "~~When fully collapsed, I appear to be #{longFormattedNumber(b[3].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
    event << ''
    event << "**I rely on a library that is #{longFormattedNumber(File.foreach("C:/Users/Mini-Matt/Desktop/devkit/rot8er_functs.rb").inject(0) {|c, line| c+1})} lines of code long.**"
    event << "Of those, #{longFormattedNumber(b[2].length)} are SLOC (non-empty)."
    event << "~~When fully collapsed, it appears to be #{longFormattedNumber(b[4].reject{|q| q.length>0 && (q[0,2]=='  ' || q[0,3]=='end' || q[0,4]=='else')}.length)} lines of code long.~~"
    event << ''
    event << "**There are #{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command('}.length)} commands, invoked with #{longFormattedNumber(all_commands().length)} different phrases.**"
    event << 'This includes:'
    event << "#{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command(' || q.include?('from: 167657750971547648')}.length-b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'"}.length)} global commands, invoked with #{longFormattedNumber(all_commands(false,0).length)} different phrases."
    event << "#{longFormattedNumber(b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'"}.length)} mod-only commands, invoked with #{longFormattedNumber(all_commands(false,1).length)} different phrases."
    event << "#{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command(' || !q.include?('from: 167657750971547648')}.length)} dev-only commands, invoked with #{longFormattedNumber(all_commands(false,2).length)} different phrases."
    event << ''
    event << "**There are #{longFormattedNumber(@prefix.map{|q| q.downcase}.reject{|q| q.include?('0') || q.include?('ii')}.uniq.length)} command prefixes**, but because I am faking case-insensitivity it's actually #{longFormattedNumber(@prefix.length)} prefixes."
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
    event.respond str
    return nil
  elsif event.user.id==167657750971547648 && !f.nil? && f.to_i.to_s==f
    srv=(bot.server(f.to_i) rescue nil)
    if srv.nil? || bot.user(502288364838322176).on(srv.id).nil?
      s2="I am not in that server, but it would be assigned to the #{['Defense','Attack','Healing','Support','Null'][(f.to_i >> 22) % 4]} class."
    else
      s2="__**#{srv.name}** (#{srv.id})__\n*Owner:* #{srv.owner.distinct} (#{srv.owner.id})\n*Class:* #{['Man','Sky','Earth','Star'][(f.to_i >> 22) % 4]}\n*My nickname:* #{bot.user(502288364838322176).on(srv.id).display_name}"
    end
    event.respond s2
    return nil
  end
  glbl=@aliases.reject{|q| q[0]!='Adventurer' || !q[3].nil?}
  srv_spec=@aliases.reject{|q| q[0]!='Adventurer' || q[3].nil?}
  b=[]
  File.open('C:/Users/Mini-Matt/Desktop/devkit/BotanBot.rb').each_line do |line|
    l=line.gsub(' ','').gsub("\n",'')
    b.push(l) unless l.length<=0
  end
  event << "**I am in #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x })} *servers*, reaching #{longFormattedNumber(@server_data[1].inject(0){|sum,x| sum + x })} unique members.**"
  event << "This shard is in #{longFormattedNumber(@server_data[0][@shardizard])} server#{"s" unless @server_data[0][@shardizard]==1}, reaching #{longFormattedNumber(bot.users.size)} unique members."
  event << ''
  event << "**There are #{longFormattedNumber(@adventurers.length)} adventurers.**"
  event << "**There are #{longFormattedNumber(@dragons.length)} dragons.**"
  event << "**There are #{longFormattedNumber(@wyrmprints.length)} wyrmprints.**"
  event << "**There are #{longFormattedNumber(@weapons.length)} weapons.**"
  event << ''
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='Skill'}.length)} skills."
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='Aura'}.length)} dragon auras, split into #{longFormattedNumber(@askilities.reject{|q| q[2]!='Aura'}.map{|q| q[0]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='Ability'}.length)} abilities, split into #{longFormattedNumber(@askilities.reject{|q| q[2]!='Ability'}.map{|q| q[0]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='CoAbility'}.length)} co-abilities, split into #{longFormattedNumber(@askilities.reject{|q| q[2]!='CoAbility'}.map{|q| q[0]}.uniq.length)} families."
  event << ''
  event << "**There are #{longFormattedNumber(glbl.length)} global and #{longFormattedNumber(srv_spec.length)} server-specific *aliases*.**"
  event << ''
  event << "**I am #{longFormattedNumber(File.foreach("C:/Users/Mini-Matt/Desktop/devkit/BotanBot.rb").inject(0) {|c, line| c+1})} lines of *code* long.**"
  event << "Of those, #{longFormattedNumber(b.length)} are SLOC (non-empty)."
  return nil
end

bot.server_create do |event|
  chn=event.server.general_channel
  if chn.nil?
    chnn=[]
    for i in 0...event.server.channels.length
      chnn.push(event.server.channels[i]) if bot.user(bot.profile.id).on(event.server.id).permission?(:send_messages,event.server.channels[i]) && event.server.channels[i].type.zero?
    end
    chn=chnn[0] if chnn.length>0
  end
  if ![285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(event.server.id) && @shardizard==4
    (chn.send_message(get_debug_leave_message()) rescue nil)
    event.server.leave
  else
    bot.user(167657750971547648).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned the #{['Defense','Attack','Healing','Support','Null'][(event.server.id >> 22) % 4]} class")
    bot.user(239973891626237952).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned the #{['Defense','Attack','Healing','Support','Null'][(event.server.id >> 22) % 4]} class")
    metadata_load()
    @server_data[0][((event.server.id >> 22) % 4)] += 1
    metadata_save()
    chn.send_message("Hello, my name is Botan.  Folks around town call me the \"naginata cutie.\" ...Hey, don't you **dare** laugh at that, jerk!\nYou want data on *Dragalia Lost*?  Leave this to me!") rescue nil
  end
end

bot.server_delete do |event|
  unless @shardizard==4
    bot.user(167657750971547648).pm("Left server **#{event.server.name}**")
    bot.user(239973891626237952).pm("Left server **#{event.server.name}**")
    metadata_load()
    @server_data[0][((event.server.id >> 22) % 4)] -= 1
    metadata_save()
  end
end

bot.message do |event|
  data_load()
  str=event.message.text.downcase
  s="#{str}"
  m=false
  if ['dl!','dl?'].include?(s[0,3].downcase)
    m=true
    s=s[3,s.length-3]
    puts event.message.text
  end
  if @shardizard==4 && (['fea!','fef!'].include?(str[0,4]) || ['fe13!','fe14!'].include?(str[0,5]) || ['fe!'].include?(str[0,3]))
    str=str[4,str.length-4] if ['fea!','fef!'].include?(str[0,4])
    str=str[5,str.length-5] if ['fe13!','fe14!'].include?(str[0,5])
    str=str[3,str.length-3] if ['fe!'].include?(str[0,3])
    a=str.split(' ')
    if a[0].downcase=='reboot'
      event.respond 'Becoming Robin.  Please wait approximately ten seconds...'
      exec 'cd C:/Users/Mini-Matt/Desktop/devkit && feindex.rb 4'
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond 'I am not Robin right now.  Please use `FE!reboot` to turn me into Robin.'
    end
  elsif (['feh!','feh?'].include?(str[0,4]) || ['f?','e?','h?'].include?(str[0,2])) && @shardizard==4
    s=event.message.text.downcase
    s=s[2,s.length-2] if ['f?','e?','h?'].include?(event.message.text.downcase[0,2])
    s=s[4,s.length-4] if ['feh!','feh?'].include?(event.message.text.downcase[0,4])
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming Elise.  Please wait approximately ten seconds..."
      exec "cd C:/Users/Mini-Matt/Desktop/devkit && PriscillaBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond "I am not Elise right now.  Please use `FEH!reboot` to turn me into Elise."
    end
  elsif (['fgo!','fgo?','liz!','liz?'].include?(str[0,4]) || ['fate!','fate?'].include?(str[0,5])) && @shardizard==4
    s=event.message.text.downcase
    s=s[5,s.length-5] if ['fate!','fate?'].include?(event.message.text.downcase[0,5])
    s=s[4,s.length-4] if ['fgo!','fgo?','liz!','liz?'].include?(event.message.text.downcase[0,4])
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming Liz.  Please wait approximately ten seconds..."
      exec "cd C:/Users/Mini-Matt/Desktop/devkit && LizBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond "I am not Liz right now.  Please use `FGO!reboot` to turn me into Liz."
    end
  elsif overlap_prevent(event)
  elsif m && !all_commands().include?(s.split(' ')[0])
    if find_data_ex(:find_adventurer,s,event,true).length>0
      disp_adventurer_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_dragon,s,event,true).length>0
      disp_dragon_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_wyrmprint,s,event,true).length>0
      disp_wyrmprint_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_weapon,s,event,true).length>0
      disp_weapon_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_skill,s,event,true).length>0
      disp_skill_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_ability,s,event,true).length>0
      disp_ability_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_adventurer,s,event).length>0
      disp_adventurer_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_dragon,s,event).length>0
      disp_dragon_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_wyrmprint,s,event).length>0
      disp_wyrmprint_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_weapon,s,event).length>0
      disp_weapon_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_skill,s,event).length>0
      disp_skill_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_ability,s,event).length>0
      disp_ability_data(bot,event,s.split(' '))
    end
  elsif event.message.text.include?('0x4') && !event.user.bot_account? && @shardizard==4
    s=event.message.text
    s=remove_format(s,'```')              # remove large code blocks
    s=remove_format(s,'`')                # remove small code blocks
    s=remove_format(s,'~~')               # remove crossed-out text
    if s=='0x4' || s[0,4]=='0x4 ' || s[s.length-4,4]==' 0x4' || s.include?(' 0x4 ')
      event.respond "#{"#{event.user.mention} " unless event.server.nil?}I am not Elise right now, but I have responded in case you're checking my response time."
    end
  end
end

bot.mention do |event|
  puts event.message.text
  args=event.message.text.downcase.split(' ')
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  name=args.join(' ')
  m=true
  m=false if event.user.bot_account?
  if !m
  elsif ['find','search'].include?(args[0].downcase)
    m=false
    args.shift
    if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
      args.shift
      find_adventurers(bot,event,args)
    elsif ['dragon','dragons'].include?(args[0].downcase)
      args.shift
      find_dragons(bot,event,args)
    elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
      args.shift
      find_wyrmprints(bot,event,args)
    elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(args[0].downcase)
      args.shift
      find_weapons(bot,event,args)
    else
      find_all(bot,event,args)
    end
  elsif ['adventurer','adv'].include?(args[0].downcase)
    m=false
    args.shift
    disp_adventurer_stats(bot,event,args)
  elsif ['dragon'].include?(args[0].downcase)
    m=false
    args.shift
    disp_dragon_stats(bot,event,args)
  elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
    m=false
    args.shift
    disp_wyrmprint_stats(bot,event,args)
  elsif ['weapon','weap','wep','wpn'].include?(args[0].downcase)
    m=false
    args.shift
    disp_weapon_stats(bot,event,args)
  elsif ['skill','skil'].include?(args[0].downcase)
    m=false
    args.shift
    disp_skill_data(bot,event,args)
  elsif ['ability','abil'].include?(args[0].downcase)
    m=false
    args.shift
    disp_ability_data(bot,event,args)
  elsif ['serveraliases','saliases'].include?(args[0].downcase)
    args.shift
    disp_aliases(bot,event,args,1)
    m=false
  elsif ['checkaliases','seealiases','aliases'].include?(args[0].downcase)
    args.shift
    disp_aliases(bot,event,args)
    m=false
  elsif ['roost','ruin','ruins','daily','dailies'].include?(args[0].downcase)
    args.shift
    roost(event,bot,args)
    m=false
  elsif ['today','now','tomorrow','tommorrow','tomorow','tommorow','sunday','sundae','sun','su','sonday','sondae','son','u','mo','monday','mondae','mon','m','mo','monday','mondae','mon','m','tu','tuesday','tuesdae','tues','tue','t','we','wednesday','wednesdae','wednes','wed','w','th','thursday','thursdae','thurs','thu','thur','h','r','fr','friday','fridae','fri','fryday','frydae','fry','f','sa','saturday','saturdae','sat','saturnday','saturndae','saturn','satur'].include?(args[0].downcase)
    roost(event,bot,args)
    m=false
  end
  if m
    if find_data_ex(:find_adventurer,name,event,true).length>0
      disp_adventurer_stats(bot,event,args)
    elsif find_data_ex(:find_dragon,name,event,true).length>0
      disp_dragon_stats(bot,event,args)
    elsif find_data_ex(:find_wyrmprint,name,event,true).length>0
      disp_wyrmprint_stats(bot,event,args)
    elsif find_data_ex(:find_weapon,name,event,true).length>0
      disp_weapon_stats(bot,event,args)
    elsif find_data_ex(:find_skill,name,event,true).length>0
      disp_skill_data(bot,event,args)
    elsif find_data_ex(:find_ability,name,event,true).length>0
      disp_ability_data(bot,event,args)
    elsif find_data_ex(:find_adventurer,name,event).length>0
      disp_adventurer_stats(bot,event,args)
    elsif find_data_ex(:find_dragon,name,event).length>0
      disp_dragon_stats(bot,event,args)
    elsif find_data_ex(:find_wyrmprint,name,event).length>0
      disp_wyrmprint_stats(bot,event,args)
    elsif find_data_ex(:find_weapon,name,event).length>0
      disp_weapon_stats(bot,event,args)
    elsif find_data_ex(:find_skill,name,event).length>0
      disp_skill_data(bot,event,args)
    elsif find_data_ex(:find_ability,name,event).length>0
      disp_ability_data(bot,event,args)
    end
  end
end

bot.ready do |event|
  if @shardizard==4
    for i in 0...bot.servers.values.length
      if ![285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,523821178670940170,523830882453422120,523824424437415946,523825319916994564,523822789308841985,532083509083373579].include?(bot.servers.values[i].id)
        bot.servers.values[i].general_channel.send_message(get_debug_leave_message()) rescue nil
        bot.servers.values[i].leave
      end
    end
  end
  system("color 3#{"BCADF"[@shardizard,1]}")
  bot.game='loading, please wait...'
  metadata_load()
  if @ignored.length>0
    for i in 0...@ignored.length
      bot.ignore_user(@ignored[i].to_i)
    end
  end
  metadata_save()
  metadata_load()
  data_load()
  system("color 1#{"BCADF"[@shardizard,1]}")
  system("title #{['Defense','Attack','Healing','Support','Null'][@shardizard]} BotanBot")
  bot.game='Dragalia Lost'
  bot.user(bot.profile.id).on(285663217261477889).nickname='BotanBot (Debug)' if @shardizard==4
  bot.profile.avatar=(File.open('C:/Users/Mini-Matt/Desktop/devkit/DebugBotan.png','r')) if @shardizard==4
end

bot.run
