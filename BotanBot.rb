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
     'search','dragon','help']
  k=['addalias','deletealias','removealias'] if permissions==1
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
  end
  @dragons=b.map{|q| q}
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
    create_embed(event,'**addalias** __new alias__ __name__',"Adds `new alias` to `name`'s aliases.\nIf the arguments are listed in the opposite order, the command will auto-switch them.\n\n~~Aliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n- Facilities\n- Materials~~\n\nInforms you if the alias already belongs to someone/something.\nAlso informs you if the thing you wish to give the alias to does not exist.\n\n**This command is only able to be used by server mods**.",0xC31C19)
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
    create_embed(event,"**#{command.downcase}** __\*filters__","Displays all adventurers that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Weapon\n- Class\n- Availability\n\nIf too many adventurers are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
  elsif ['aliases','checkaliases','seealiases','alias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s aliases.\nIf no name is listed, responds with a list of all aliases and who/what they are for.\n\n~~Aliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n- Facilities\n- Materials~~\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
  elsif ['saliases','serveraliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s server-specific aliases.\nIf no name is listed, responds with a list of all server-specific aliases and who/what they are for.\n\n~~Aliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n- Facilities\n- Materials~~\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
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
    create_embed([event,x],"Command Prefixes: #{@prefix.map{|q| q.upcase}.uniq.map{|q| "`#{q}`"}.join(', ')}\nYou can also use `DL!help CommandName` to learn more on a particular command.\n__**Botan Bot help**__","__**Game Data**__\n`adventurer` __name__ - for data on an adventurer (*also `adv`*)\n`dragon` __name__ - for data on a dragon\n\n`find` __\*filters__ - to find specific adventurers or dragons\n\n__**Meta Data**__\n`invite` - for a link to invite me to your server\n`snagstats` __type__ - to receive relevant bot stats\n`spam` - to determine if the current location is safe for me to send long replies to (*also `safetospam` or `safe2spam`*)\n\n__**Developer Information**__\n`bugreport` __\\*message__ - to send my developer a bug report\n`suggestion` __\\*message__ - to send my developer a feature suggestion\n`feedback` __\\*message__ - to send my developer other kinds of feedback\n~~the above three commands are actually identical, merely given unique entries to help people find them~~",0xCE456B)
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
  return 0x484E50
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
    str2="__**#{skl1[0]}** (#{skl1[8]} sec invul#{', <:Energized:534451856286679040>Energizable' if skl1[7]=='Yes'})__"
    if skl1[9].nil? || skl1[9].length<=0
      str2="#{str2}\n*Tier 1 (F1):* #{skl1[3].gsub(';; ',"\n")}\n*Tier 2 (F3):* #{skl1[4].gsub(';; ',"\n")}\n*Tier 3 (F5):* #{skl1[5].gsub(';; ',"\n")}"
    else
      str2="#{str2}\n*Effect:* #{skl1[9].gsub(';; ',"\n")}\n*Tier 1 (F1) \u2192 Tier 2 (F3) \u2192 Tier 3 (F5)*"
    end
    str2="#{str2}\n\n__**#{skl2[0]}** (#{skl2[8]} sec invul#{', <:Energized:534451856286679040>Energizable' if skl2[7]=='Yes'})__"
    if skl2[9].nil? || skl2[9].length<=0
      str2="#{str2}\n*Tier 1 (F1):* #{skl2[3].gsub(';; ',"\n")}\n*Tier 2 (F4):* #{skl2[4].gsub(';; ',"\n")}"
    else
      str2="#{str2}\n*Effect:* #{skl2[9].gsub(';; ',"\n")}\n*Tier 1 (F1) \u2192 Tier 2 (F4)*"
    end
    flds.push(['Skills',str2,1])
    a3="#{k[8][2][0]} (F5)"
    a3="#{k[8][2][0]} (F3) \u2192 #{k[8][2][1]} (F5)" if k[1][0,1].to_i==5
    flds.push(['Abilities',"#{k[8][0][0]} (F1) \u2192 #{k[8][0][1]} (F3)\n#{k[8][1][0]} (F2) \u2192 #{k[8][1][1]} (F4)\n#{a3}\n\n*Co-Ability (F5):* #{k[7]}"])
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
    str="#{str}\n\n**Skills:** #{k[6][0]}#{'<:Energized:534451856286679040>' if skl1[7]=='Yes'} [Lv.#{lv[0]}], #{k[6][1]}#{'<:Energized:534451856286679040>' if skl2[7]=='Yes'} [Lv.#{lv[1]}]"
    m=[]
    for i in 0...3
      m.push(k[8][i][lv[i+2]-1]) if lv[i+2]>0
    end
    str="#{str}\n**Abilities:** #{m.join(', ')}"
    str="#{str}\n**Co-Ability:** #{k[7]}" if rar>=5
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
      str="#{str}\n*Tier 1:* #{skl1[3].gsub(';; ',"\n")}\n*Tier 2:* #{skl1[4].gsub(';; ',"\n")}"
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

def disp_aliases(bot,event,args,mode=0) # empty
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
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i]}"}
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
    str="__**Search**__\n#{search.join("\n")}\n\n__**Results**__"
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
    create_embed(event,"__**Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

bot.command([:find,:search]) do |event, *args|
  return nil if overlap_prevent(event)
  find_adventurers(bot,event,args)
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

bot.command(:addalias) do |event, name| # empty
  return nil if overlap_prevent(event)
end

bot.command([:checkaliases,:aliases,:seealiases]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_aliases(bot,event,args)
end

bot.command([:serveraliases,:saliases]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_aliases(bot,event,args,1)
end

bot.command([:deletealias,:removealias]) do |event, name| # empty
  return nil if overlap_prevent(event)
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
  @aliases.sort! {|a,b| (a[0] <=> b[0]) == 0 ? ((a[2] <=> b[2]) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2] <=> b[2])) : (a[0] <=> b[0])}
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
      str2="#{str2}\nServers you and I share account for #{@aliases.reject{|q| q[0]!='Servant' || q[3].nil? || q[3].reject{|q2| q2==285663217261477889 || bot.user(event.user.id).on(q2).nil?}.length<=0}.length} of those."
    else
      str2="#{str2}\nThis server accounts for #{@aliases.reject{|q| q[0]!='Servant' || q[3].nil? || !q[3].include?(event.server.id)}.length} of those."
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
  event << "**There are also #{longFormattedNumber(@dragons.length)} dragons.**"
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
    elsif find_data_ex(:find_adventurer,s,event).length>0
      disp_adventurer_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_dragon,s,event).length>0
      disp_dragon_stats(bot,event,s.split(' '))
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
  elsif ['adventurer','adv'].include?(args[0].downcase)
    m=false
    args.shift
    disp_adventurer_stats(bot,event,args)
  elsif ['dragon'].include?(args[0].downcase)
    m=false
    args.shift
    disp_dragon_stats(bot,event,args)
  end
  if m
    if find_data_ex(:find_adventurer,name,event,true).length>0
      disp_adventurer_stats(bot,event,args)
    elsif find_data_ex(:find_dragon,name,event,true).length>0
      disp_dragon_stats(bot,event,args)
    elsif find_data_ex(:find_adventurer,name,event).length>0
      disp_adventurer_stats(bot,event,args)
    elsif find_data_ex(:find_dragon,name,event).length>0
      disp_dragon_stats(bot,event,args)
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
end

bot.run
