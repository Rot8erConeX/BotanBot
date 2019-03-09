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

# this is required to get her to change her avatar on certain holidays
ENV['TZ'] = 'America/Chicago'
@scheduler = Rufus::Scheduler.new

# All the possible command prefixes
@prefixes={}
load 'C:/Users/Mini-Matt/Desktop/devkit/DLPrefix.rb'

prefix_proc = proc do |message|
  load 'C:/Users/Mini-Matt/Desktop/devkit/DLPrefix.rb'
  next message.content[3..-1] if message.text.downcase.start_with?('dl!')
  next message.content[3..-1] if message.text.downcase.start_with?('dl?')
  next if message.channel.server.nil? || @prefixes[message.channel.server.id].nil? || @prefixes[message.channel.server.id].length<=0
  prefix = @prefixes[message.channel.server.id]
  # We use [prefix.size..-1] so we can handle prefixes of any length
  next message.content[prefix.size..-1] if message.text.downcase.start_with?(prefix.downcase)
end

# The bot's token is basically their password, so is censored for obvious reasons
if @shardizard==4
  bot = Discordrb::Commands::CommandBot.new token: '>Debug Token<', client_id: >Debug ID<, prefix: prefix_proc
else
  bot = Discordrb::Commands::CommandBot.new token: '>Token<', shard_id: @shardizard, num_shards: 4, client_id: >ID<, prefix: prefix_proc
end
bot.gateway.check_heartbeat_acks = false

@adventurers=[]
@dragons=[]
@wyrmprints=[]
@weapons=[]
@enemies=[]

@askilities=[]

@facilities=[]
@mats=[]
@banners=[]

@aliases=[]
@spam_channels=[]
@server_data=[[],[]]
@ignored=[]
@embedless=[]
@avvie_info=['Botan','*Dragalia Lost*','N/A']

def all_commands(include_nil=false,permissions=-1)
  return all_commands(include_nil)-all_commands(false,1)-all_commands(false,2) if permissions==0
  k=['reboot','adventurer','adv','addalias','checkaliases','aliases','seealiases','saliases','serveraliases','deletealias','removealias','channellist','long',
     'channelist','spamlist','spamchannels','bugreport','suggestion','feedback','donation','donate','shard','attribute','safe','spam','safetospam','safe2spam',
     'longreplies','sortaliases','status','backupaliases','restorealiases','sendmessage','sendpm','ignoreuser','leaveserver','cleanupaliases','snagstats','find',
     'search','dragon','help','wyrmprint','wyrm','print','weapon','wep','weap','wpn','skill','skil','ability','abil','aura','roost','today','ruin','ruins','drg',
     'daily','now','dailies','todayindl','today_in_dl','tomorrow','tommorrow','tomorow','tommorow','shop','store','exp','level','xp','plxp','plexp','pllevel',
     'plevel','pxp','pexp','advxp','advexp','advlevel','alevel','axp','aexp','drgxp','drgexp','drglevel','dlevel','dxp','dexp','bxp','bexp','blevel','dbxp',
     'dbexp','dblevel','bondlevel','bondxp','bondexp','wrxp','wrexp','wrlevel','wyrmxp','wyrmexp','wyrmlevel','wpxp','wpexp','wplevel','weaponxp','weaponexp',
     'weaponlevel','wxp','wexp','wlevel','victory','facility','faculty','fac','mat','material','item','list','lookup','invite','boop','alts','alt','lineage',
     'craft','crafting','tools','tool','links','link','resources','resource','next','enemy','boss','banners','banner','prefix','art']
  k=['addalias','deletealias','removealias','prefix'] if permissions==1
  k=['reboot','sortaliases','status','backupaliases','restorealiases','sendmessage','sendpm','ignoreuser','leaveserver','cleanupaliases','boop'] if permissions==2
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
  return true if @spam_channels.include?(chn.id)
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
    b[i][9]=b[i][9].split(', ')
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
    b[i][12]=b[i][12].split(', ')
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
    b[i][13]=b[i][13].split(';;;; ').map{|q| q.split(';; ')} unless b[i][13].nil?
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
      b[i][10]=b[i][10].split(', ') unless b[i][10].nil?
    elsif b[i][2]=='Aura'
      b[i][4]=b[i][4].to_i
    elsif b[i][2]=='Ability'
      b[i][4]=b[i][4].to_i
    elsif b[i][2]=='CoAbility'
      b[i][4]=b[i][4].to_i
    end
  end
  @askilities=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLFacilities.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLFacilities.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][2]=b[i][2].split(', ')
  end
  @facilities=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLMaterials.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLMaterials.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][1]=b[i][1].to_i
    b[i][2]=b[i][2].to_i
    b[i][4]=b[i][4].split(';; ')
    b[i][5]=b[i][5].split(';; ')
    b[i][6]=b[i][6].to_i
    b[i][7]=b[i][7].to_i
    b[i][8]=b[i][8].split(', ')
  end
  @mats=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLEnemies.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLEnemies.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][1]=b[i][1].split(', ').map{|q| q.to_i}
    b[i][2]=b[i][2].split(', ')
    b[i][3]=b[i][3].split(', ')
    b[i][4]=b[i][4].split(', ')
    b[i][5]=b[i][5].split(';; ') unless b[i][5].nil?
  end
  @enemies=b.map{|q| q}
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLBanners.txt')
    b=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLBanners.txt').each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][1]=b[i][1].split(', ')
    b[i][2]=b[i][2].split(', ')
    b[i][3]=b[i][3].split(', ')
    b[i][4]=b[i][4].split(', ')
    b[i][5]=b[i][5].split(', ')
  end
  @banners=b.map{|q| q}
end

def prefixes_save()
  x=@prefixes
  open('C:/Users/Mini-Matt/Desktop/devkit/DLPrefix.rb', 'w') { |f|
    f.puts x.to_s.gsub('=>',' => ').gsub(', ',",\n  ").gsub('{',"@prefixes = {\n  ").gsub('}',"\n}")
  }
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
  elsif command.downcase=='prefix'
    create_embed(event,'**prefix** __new prefix__',"Sets the server's custom prefix to `prefix`.\n\n**This command can only be used by server mods.**",0xC31C19)
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
  elsif ['victory'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}**","Shows a victorious emote.",0xCE456B)
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
  elsif ['dragon','drg'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats, skills, and abilities.",0xCE456B)
  elsif ['wyrmprint','wyrm','print'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats and abilities.",0xCE456B)
  elsif ['weapon','weap','wep','wpn'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows `name`'s stats and skills.",0xCE456B)
  elsif ['lineage','craft','crafting'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the weapons that `name` directly promotes from.",0xCE456B)
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
  elsif ['today','now','daily','dailies','today_in_dl','todayindl'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the current day's Dragon Roost Bond gift, as well as all the dragons that get an extra bond increase from the gift.\nAlso shows the current day's Expert Ruins, what difficulties are available, and what orbs and other mats come out of those.\nAlso shows the current day's shop mats.",0xCE456B)
  elsif ['tomorrow','tomorow','tommorrow','tommorow'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Shows the next day's Dragon Roost Bond gift, as well as all the dragons that get an extra bond increase from the gift.\nAlso shows the next day's Expert Ruins, what difficulties are available, and what orbs and other mats come out of those.\nAlso shows the current day's shop mats.",0xCE456B)
  elsif ['next','schedule'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __type__","Shows the next time in-game daily events of the type `type` will happen.\nIf in PM and `type` is unspecified, shows the entire schedule.\n\n__*Accepted Inputs*__\nRuin(s)\nMat(s)\nShop, Store\nBond(s), Dragon(s)",0xCE456B)
  elsif ['art'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __target__","Shows `target`'s art.  Target can be:\n- Adventurers\n- Dragons\n- Wyrmprints",0xCE456B)
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
  elsif ['find','search','lookup'].include?(command.downcase)
    subcommand='' if subcommand.nil?
    if ['adventurer','adventurers','adv','advs','unit','units'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all adventurers that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Weapon type\n- Class\n- Availability\n\nIf too many adventurers are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['dragon','dragons'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all dragons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Dragon Roost Bond Gift preference\n- Whether or not the dragon turns to face damage sources\n- Whether or not the dragon is a ranged attacker\n- Availability\n\nIf too many dragons are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['wyrmprint','wyrm','print'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all wyrmprints that fit `filters`.\n\nYou can search by:\n- Rarity\n- Amulet type\n- Availability\n\nIf too many wyrmprints are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all weapons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Weapon type\n- Availability\n\nIf too many weapons are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    elsif ['mat','mats','material','materials','item','items'].include?(subcommand.downcase)
      create_embed(event,"**#{command.downcase} #{subcommand.downcase}** __\*filters__","Displays all materials and items that fit `filters`.\n\nYou can search by:\n- Rarity\n- Pouch Rarity\n- Tags\n\nIf too many materials and items are trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
      lookout=[]
      if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt')
        lookout=[]
        File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt').each_line do |line|
          lookout.push(eval line)
        end
      end
      w=lookout.reject{|q| q[2]!='Mat'}.map{|q| q[0]}.sort
      create_embed(event,'Tags','',0x40C0F0,nil,nil,triple_finish(w)) if safe_to_spam?(event)
    else
      create_embed(event,"**#{command.downcase}** __\*filters__","Displays all adventurers, dragons, wyrmprints, and weapons that fit `filters`.\n\nYou can search by:\n- Rarity\n- Element\n- Weapon type\n- Class / Amulet type\n- Availability\n\nIn addition, dragons can be sorted by:\n- Dragon Roost Bond Gift preference\n- Whether or not the dragon turns to face damage sources\n- Whether or not the dragon is a ranged attacker\n\nIf too much data is trying to be displayed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
    end
    lookout=[]
    if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt')
      lookout=[]
      File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt').each_line do |line|
        lookout.push(eval line)
      end
    end
    w=lookout.reject{|q| q[2]!='Skill'}.map{|q| q[0]}.sort
    create_embed(event,'Tags','',0x40C0F0,nil,nil,triple_finish(w)) if safe_to_spam?(event) && !['mat','mats','material','materials','item','items'].include?(subcommand.downcase)
  elsif ['aliases','checkaliases','seealiases','alias'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s aliases.\nIf no name is listed, responds with a list of all aliases and who/what they are for.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n- Facilities\n- Materials\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
  elsif ['saliases','serveraliases'].include?(command.downcase)
    create_embed(event,"**#{command.downcase}** __name__","Responds with a list of all `name`'s server-specific aliases.\nIf no name is listed, responds with a list of all server-specific aliases and who/what they are for.\n\nAliases can be added to:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Skills\n- Auras\n- Abilities\n- CoAbilities\n- Facilities\n- Materials\n\nPlease note that if more than 50 aliases are to be listed, I will - for the sake of the sanity of other server members - only allow you to use the command in PM.",0xCE456B)
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
    str="#{str}\n`dragon` __name__ - for data on a dragon (*also `drg`*)"
    str="#{str}\n`wyrmprint` __name__ - for data on a wyrmprint (*also `wyrm` or `print`*)"
    str="#{str}\n`weapon` __name__ - for data on a weapon (*also `weap` or `wep`*)"
    str="#{str}\n`craft` __name__ - for data on a weapon's crafting materials"
    str="#{str}\n\n`skill` __name__ - for data on a particular skill"
    str="#{str}\n`ability` __name__ - for data on a particular ability or co-ability"
    str="#{str}\n`aura` __name__ - for data on a particular aura"
    str="#{str}\n\n`facility` __name__ - for data on a particular facility"
    str="#{str}\n`material` __name__ - for data on a particular material (*also `mat`*)"
    str="#{str}\n\n`aliases` __target__ - to show all aliases of a particular entity (*also `checkaliases` or `seealiases`*)"
    str="#{str}\n`serveraliases` __target__- to show all server-specific aliases of a particular entity (*also `saliases`*)"
    str="#{str}\n\n`find` __\*filters__ - to find specific adventurers, dragons, wyrmprints, or weapons"
    str="#{str}\n`today` - to show data on current events (*also `daily` or `todayInDL`*)"
    str="#{str}\n`next` - to show data on cyclical events (*also `schedule`*)"
    str="#{str}\n`art` __target__ - to show an adventurer's, dragon's, or wyrmprint's art"
    str="#{str}\n\n__**Meta Data**__"
    str="#{str}\n`invite` - for a link to invite me to your server"
    str="#{str}\n`snagstats` __type__ - to receive relevant bot stats"
    str="#{str}\n`spam` - to determine if the current location is safe for me to send long replies to (*also `safetospam` or `safe2spam`*)"
    str="#{str}\n`shard` (*also `alliance`*)"
    str="#{str}\n\n__**Developer Information**__"
    str="#{str}\n`bugreport` __\\*message__ - to send my developer a bug report"
    str="#{str}\n`suggestion` __\\*message__ - to send my developer a feature suggestion"
    str="#{str}\n`feedback` __\\*message__ - to send my developer other kinds of feedback"
    str="#{str}\n~~the above three commands are actually identical, merely given unique entries to help people find them~~"
    create_embed([event,x],"Global Command Prefixes: `DL!` `DL?`#{"\nServer Command Prefix: `#{@prefixes[event.server.id]}`" if !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0}\nYou can also use `DL!help CommandName` to learn more on a particular command.\n__**Botan Bot help**__",str,0xCE456B)
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
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@adventurers.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @adventurers[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Adventurer'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @adventurers[@adventurers.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @adventurers[@adventurers.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@adventurers.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @adventurers[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @adventurers[@adventurers.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @adventurers[@adventurers.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_dragon(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@dragons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @dragons[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @dragons[@dragons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @dragons[@dragons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@dragons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @dragons[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @dragons[@dragons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @dragons[@dragons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_wyrmprint(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@wyrmprints.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @wyrmprints[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Wyrmprint'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @wyrmprints[@wyrmprints.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @wyrmprints[@wyrmprints.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@wyrmprints.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @wyrmprints[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @wyrmprints[@wyrmprints.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @wyrmprints[@wyrmprints.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_weapon(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@weapons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[2][0,1]}*#{q[3]}#{q[1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[2][0,1]}#{q[3]}#{q[1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[2][0,1]}*#{q[1]}#{q[3]}".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[2][0,1]}#{q[1]}#{q[3]}".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[3]}#{q[2][0,1]}*#{q[1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[3]}#{q[2][0,1]}#{q[1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[1]}#{q[2][0,1]}*#{q[3]}".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[1]}#{q[2][0,1]}#{q[3]}".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[3]}#{q[1]}#{q[2][0,1]}*".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[3]}#{q[1]}#{q[2][0,1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[1]}#{q[3]}#{q[2][0,1]}*".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.find_index{|q| q[2][1,1]!='v' && q[3]!='None' && "#{q[1]}#{q[3]}#{q[2][0,1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow')}
  return @weapons[k] unless k.nil?
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[2][0,1]}*#{q[3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[2][0,1]}#{q[3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[2][0,1]}*#{q[1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[2][0,1]}#{q[1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[3]}#{q[2][0,1]}*#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[3]}#{q[2][0,1]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[1]}#{q[2][0,1]}*#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[1]}#{q[2][0,1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[3]}#{q[1]}#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[3]}#{q[1]}#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[1]}#{q[3]}#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "Void#{q[1]}#{q[3]}#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}*Void#{q[3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}Void#{q[3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}*Void#{q[1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}Void#{q[1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}Void#{q[2][0,1]}*#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}Void#{q[2][0,1]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}Void#{q[2][0,1]}*#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}Void#{q[2][0,1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}Void#{q[1]}#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}Void#{q[1]}#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}Void#{q[3]}#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}Void#{q[3]}#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}*#{q[3]}Void#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}#{q[3]}Void#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}*#{q[1]}Void#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}#{q[1]}Void#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}#{q[2][0,1]}*Void#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}#{q[2][0,1]}Void#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}#{q[2][0,1]}*Void#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}#{q[2][0,1]}Void#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}#{q[1]}Void#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}#{q[1]}Void#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}#{q[3]}Void#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}#{q[3]}Void#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}*#{q[3]}#{q[1]}Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}#{q[3]}#{q[1]}Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}*#{q[1]}#{q[3]}Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[2][0,1]}#{q[1]}#{q[3]}Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}#{q[2][0,1]}*#{q[1]}Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}#{q[2][0,1]}#{q[1]}Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}#{q[2][0,1]}*#{q[3]}Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}#{q[2][0,1]}#{q[3]}Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}#{q[1]}#{q[2][0,1]}*Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[3]}#{q[1]}#{q[2][0,1]}Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}#{q[3]}#{q[2][0,1]}*Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  k=@weapons.reject{|q| q[2][1,1]!='v' || q[3]=='None' || "#{q[1]}#{q[3]}#{q[2][0,1]}Void".downcase != name.gsub('fire','flame').gsub('dark','shadow')}
  return k if k.length>0
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Weapon'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @weapons[@weapons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @weapons[@weapons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@weapons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @weapons[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @weapons[@weapons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @weapons[@weapons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_skill(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  sklz=@askilities.reject{|q| q[2]!='Skill'}
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return sklz[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Skill'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return sklz[sklz.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return sklz[sklz.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return sklz[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return sklz[sklz.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return sklz[sklz.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_ability(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  sklz=@askilities.reject{|q| q[2]=='Skill'}
  return [] if name.length<2
  k=sklz.reject{|q| "#{q[0]} #{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name}
  return k unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[0]} +#{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name}
  return k unless k.nil? || k.length<=0
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return sklz.reject{|q| q[0]!=sklz[k][0]} unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| !['Aura','Ability'].include?(q[0])}.map{|q| [q[1],q[2],q[3],q[0]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| "#{q[0]} #{q[1]}"==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1]}
  end
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| "#{q[0]} #{q[1]}"==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1]}
  end
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name[0,q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','').length] && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    sklz2=sklz.reject{|q| q[0]!=alz[k][1]}
    m=sklz2.find_index{|q| "#{alz[k][0]}#{q[1]}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{alz[k][0]}+#{q[1]}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{alz[k][0]}#{q[1].gsub('%','')}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{alz[k][0]}+#{q[1].gsub('%','')}".downcase==name}
    return sklz2[m] unless m.nil?
  end
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name[0,q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','').length] && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    sklz2=sklz.reject{|q| q[0]!=alz[k][1]}
    m=sklz2.find_index{|q| "#{alz[k][0]}#{q[1]}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{alz[k][0]}+#{q[1]}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{alz[k][0]}#{q[1].gsub('%','')}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{alz[k][0]}+#{q[1].gsub('%','')}".downcase==name}
    return sklz2[m] unless m.nil?
  end
  return [] if fullname
  k=sklz.reject{|q| "#{q[0]} #{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]!=name}
  return k unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[0]} +#{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]!=name}
  return k unless k.nil? || k.length<=0
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return sklz.reject{|q| q[0]!=sklz[k][0]} unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| "#{q[0]} #{q[1]}"==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1]}
  end
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| "#{q[0]} #{q[1]}"==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1]}
  end
  return []
end

def find_facility(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@facilities.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @facilities[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Facility'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @facilities[@facilities.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @facilities[@facilities.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@facilities.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @facilities[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @facilities[@facilities.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @facilities[@facilities.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_mat(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@mats.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @mats[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Material'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @mats[@mats.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @mats[@mats.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@mats.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @mats[@mats.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @mats[@mats.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_enemy(name,event,fullname=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@enemies.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @enemies[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Enemy'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @enemies[@enemies.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @enemies[@enemies.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname
  k=@enemies.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @enemies[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @enemies[@enemies.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @enemies[@enemies.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
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

def adv_emoji(k,bot)
  str=['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][k[1][0,1].to_i]
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][1]}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[2][2]}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2][0].gsub('Healer','Healing')}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  return str
end

def dragon_emoji(k,bot)
  str=['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][k[1][0,1].to_i]
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2]}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  return str
end

def print_emoji(k,bot)
  str=['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][k[1][0,1].to_i]
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2]}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  return str
end

def weapon_emoji(k,bot)
  str=['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][k[2][0,1].to_i]
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[3].gsub('None','Null')}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[1]}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  return str
end

def enemy_emoji(k,bot)
  str=''
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0]}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{k[2][1]}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  return str
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
    rar=args[i].to_i if rar.zero? && args[i][1,1]=='*' && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>2 && args[i][0,1].to_i<6
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
  str="#{str}\n**Unavailable**" if k[1].length>1 && k[1][1,1].downcase=='-'
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
    lv[4]=1 if k[1][0,1].to_i==5 && rar<5
    lv=[1,1,1,1,0] if rar==2
    lv=[1,1,1,0,0] if rar==1
    x=[skl1[3,3].reject{|q| q.nil? || q.length<=0}[lv[0]-1].gsub(';; ',"\n"),skl2[3,3].reject{|q| q.nil? || q.length<=0}[lv[1]-1].gsub(';; ',"\n")]
    strx="__**Skills:**__"
    strx="#{strx}\n*#{k[6][0]}#{'<:Energized:534451856286679040>' if skl1[7]=='Yes'} [Lv.#{lv[0]}] - #{longFormattedNumber(skl1[6][lv[0]-1])} SP*\n#{x[0]}"
    strx="#{strx}\n\n*#{k[6][1]}#{'<:Energized:534451856286679040>' if skl2[7]=='Yes'} [Lv.#{lv[1]}] - #{longFormattedNumber(skl2[6][lv[1]-1])} SP*\n#{x[1]}"
    strx2="**Skills:**"
    strx2="#{strx2}\n#{k[6][0]}#{'<:Energized:534451856286679040>' if skl1[7]=='Yes'} [Lv.#{lv[0]}] - #{longFormattedNumber(skl1[6][lv[0]-1])} SP"
    strx2="#{strx2}\n#{k[6][1]}#{'<:Energized:534451856286679040>' if skl2[7]=='Yes'} [Lv.#{lv[1]}] - #{longFormattedNumber(skl2[6][lv[1]-1])} SP"
    m=[]
    for i in 0...3
      m.push(k[8][i][lv[i+2]-1]) if lv[i+2]>0
    end
    str="#{str}\n\n;;;;;\n\n**Abilities:** #{m.join(', ')}"
    if rar<5
      str="#{str}\n**Co-Ability:** #{k[7].split('/')[0]}"
    else
      m=k[7].split(' ')
      m[-1]=m[-1].split('/')
      str="#{str}\n**Co-Ability:** #{m[0,m.length-1].join(' ')} #{m[-1][-1]}"
    end
    if str.gsub(';;;;;',strx).length>=1800
      str=str.gsub(';;;;;',"#{strx2}\n~~Skill descriptions make this data too long.  Please try again in PM.~~")
    else
      str=str.gsub(';;;;;',strx)
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
    str="#{str}\n\n**Skill:** *#{k[5]}#{'<:Energized:534451856286679040>' if skl1[7]=='Yes'} - #{longFormattedNumber(skl1[6][1])} SP*;;;;;"
    strx=skl1[4].gsub(';; ',"\n")
  end
  str="#{str}\n\n**Aura:**\n<:NonUnbound:534494090876682264><:NonUnbound:534494090876682264><:NonUnbound:534494090876682264><:NonUnbound:534494090876682264>#{k[6][0][0]}\n<:Unbind:534494090969088000><:Unbind:534494090969088000><:Unbind:534494090969088000><:Unbind:534494090969088000>#{k[6][0][1]}"
  str="#{str}\n\n**Ability:** #{k[6][1][0]} \u2192 #{k[6][1][1]}" if k[6].length>1
  str="#{str}\n\n**Sells for:** #{longFormattedNumber(k[7][0])}<:Resource_Rupies:532104504372363274> #{longFormattedNumber(k[7][1])}<:Resource_Eldwater:532104503777034270>"
  str="#{str}\n**Bond gift preference:** #{['Golden Chalice (Sunday)','Juicy Meat (Monday)','Kaleidoscope (Tuesday)','Floral Circlet (Wednesday)','Compelling Book (Thursday)','Mana Essence (Friday)','Golden Chalice (Saturday)'][k[9]]}"
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
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Wyrmprints/#{k[0].gsub(' ','_')}_2.png" if has_any?(['mub','unbind','unbound','refined'],evn)
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
    for i in 0...k[5].length
      if k[5][i][0]==k[5][i][1]
        k[5][i]=k[5][i][0]
      elsif k[5][i][0].split(' ')[0,k[5][i][0].split(' ').length-1].join(' ')==k[5][i][1].split(' ')[0,k[5][i][1].split(' ').length-1].join(' ')
        k[5][i]="#{k[5][i][0]}/#{k[5][i][1].split(' ')[-1]}"
      else
        k[5][i]=k[5][i][0,2].join(" \u2192 ")
      end
    end
    str="#{str}\n\n__**Abilities**__\n#{k[5].join("\n")}"
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
  elsif k[0].is_a?(Array)
    for i in 0...k.length
      disp_weapon_stats(bot,event,k[i][0].split(' '))
    end
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
  str="#{str}\n**Starter**" if k[2].length>1 && k[2][1,1].downcase=='e'
  str="#{str}\n**Paid**" if k[2].length>1 && k[2][1,1].downcase=='p'
  str="#{str}\n**Void**" if k[2].length>1 && k[2][1,1].downcase=='v'
  f=30*k[2][0,1].to_i-50
  f+=20 if k[2][0,1].to_i<3
  wpnz=@weapons.map{|q| q}
  sklz=@askilities.map{|q| q}
  skl=nil
  skl=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6]} if !k[6].nil? && k[6].length>0
  skl=sklz[skl] unless skl.nil?
  abl=nil
  abl2=nil
  ablx=nil
  ablx2=nil
  unless k[13].nil? || k[13].length<=0
    abl=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==k[13][0][0]} if !k[13][0][0].nil? && k[13][0][0].length>0
    abl=sklz[abl] unless abl.nil?
    abl2=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==k[13][0][1]} if !k[13][0][1].nil? && k[13][0][1].length>0
    abl2=sklz[abl2] unless abl2.nil?
    unless k[13][1].nil? || k[13][1].length<=0
      ablx=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==k[13][1][0]} if !k[13][1][0].nil? && k[13][1][0].length>0
      ablx=sklz[ablx] unless ablx.nil?
      ablx2=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==k[13][1][1]} if !k[13][1][1].nil? && k[13][1][1].length>0
      ablx2=sklz[ablx2] unless ablx2.nil?
    end
  end
  if s2s && !skl.nil?
    str="#{str}\n\n__**#{'<:NonUnbound:534494090876682264>'*4} Level 1**__"
    str="#{str}\n*HP:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][0])}"
    str="#{str}\n*#{skl[0]}* - #{longFormattedNumber(skl[6][0])} SP\n#{skl[3].gsub(';; ',"\n")}"
    str="#{str}\n*#{abl[0]}#{" #{'+' if abl[1].include?('%')}#{abl[1]}" unless abl[1]=='-'}*" unless abl.nil?
    str="#{str}\n*#{ablx[0]}#{" #{'+' if ablx[1].include?('%')}#{ablx[1]}" unless ablx[1]=='-'}*" unless ablx.nil?
    if k[2][0,1].to_i>=5 && k[3]!='None'
      str="#{str}\n\n__**#{'<:NonUnbound:534494090876682264>'*4} Level 80**__"
      str="#{str}\n*HP:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][1])}"
      str="#{str}\n*#{skl[0]}* - #{longFormattedNumber(skl[6][0])} SP\n#{skl[3].gsub(';; ',"\n")}"
      str="#{str}\n*#{abl[0]}#{" #{'+' if abl[1].include?('%')}#{abl[1]}" unless abl[1]=='-'}*" unless abl.nil?
      str="#{str}\n*#{ablx[0]}#{" #{'+' if ablx[1].include?('%')}#{ablx[1]}" unless ablx[1]=='-'}*" unless ablx.nil?
    end
    str="#{str}\n\n__**#{'<:Unbind:534494090969088000>'*4} Level #{f}**__"
    str="#{str}\n*HP:*\u00A0\u00A0#{longFormattedNumber(k[4][2])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][2])}"
    str="#{str}\n*#{skl[0]}* - #{longFormattedNumber(skl[6][1])} SP\n#{skl[4].gsub(';; ',"\n")}"
    str="#{str}\n*#{abl2[0]}#{" #{'+' if abl2[1].include?('%')}#{abl2[1]}" unless abl2[1]=='-'}*" unless abl2.nil?
    str="#{str}\n*#{abl[0]}#{" #{'+' if abl[1].include?('%')}#{abl[1]}" unless abl[1]=='-'}*" if abl2.nil? && !abl.nil?
    str="#{str}\n*#{ablx2[0]}#{" #{'+' if ablx2[1].include?('%')}#{ablx2[1]}" unless ablx2[1]=='-'}*" unless ablx2.nil?
    str="#{str}\n*#{ablx[0]}#{" #{'+' if ablx[1].include?('%')}#{ablx[1]}" unless ablx[1]=='-'}*" if ablx2.nil? && !ablx.nil?
  else
    str="#{str}\n\n**#{'<:NonUnbound:534494090876682264>'*4} Level 1**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][0])}"
    str="#{str}\n**#{'<:NonUnbound:534494090876682264>'*4} Level 80**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][1])}" if k[2][0,1].to_i>=5 && k[3]!='None'
    str="#{str}\n**#{'<:Unbind:534494090969088000>'*4} Level #{f}**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[4][2])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][2])}"
    strx=''
    unless skl.nil?
      str="#{str}\n\n**Skill:** *#{skl[0]}*"
      if skl[6][0]==skl[6][1]
        str="#{str} - #{longFormattedNumber(skl[6][0])} SP;;;;;"
      else
        str="#{str} - #{longFormattedNumber(skl[6][0])} \u2192 #{longFormattedNumber(skl[6][1])} SP;;;;;"
      end
      strx=skl[4].gsub(';; ',"\n")
    end
    if !abl2.nil?
      str="#{str}\n\n**Abilities:** *#{abl2[0]}#{" #{'+' if abl2[1].include?('%')}#{abl2[1]}" unless abl2[1]=='-'}*"
    elsif !abl.nil?
      str="#{str}\n\n**Abilities:** *#{abl[0]}#{" #{'+' if abl[1].include?('%')}#{abl[1]}" unless abl[1]=='-'}*"
    elsif !ablx2.nil?
      str="#{str}\n\n**Abilities:** *#{ablx2[0]}#{" #{'+' if ablx2[1].include?('%')}#{ablx2[1]}" unless ablx2[1]=='-'}*"
      ablx2=nil
      ablx=nil
    elsif !ablx.nil?
      str="#{str}\n\n**Abilities:** *#{ablx[0]}#{" #{'+' if ablx[1].include?('%')}#{ablx[1]}" unless ablx[1]=='-'}*"
      ablx=nil
    end
    if !ablx2.nil?
      str="#{str}, *#{ablx2[0]}#{" #{'+' if ablx2[1].include?('%')}#{ablx2[1]}" unless ablx2[1]=='-'}*"
    elsif !ablx.nil?
      str="#{str}, *#{ablx[0]}#{" #{'+' if ablx[1].include?('%')}#{ablx[1]}" unless ablx[1]=='-'}*"
    end
  end
  str2=''
  if s2s
    m2=wpnz.find_index{|q| q[1]==k[1] && q[2]==k[2] && q[8]==k[9] && !['','0',0].include?(q[8])}
    m2=wpnz.find_index{|q| q[1]==k[1] && q[2][1,1]=='v' && q[2][0,1].to_i==k[2][0,1].to_i-1 && q[8]==k[9] && !['','0',0].include?(q[8])} if k[2][1,1]=='v' && k[8].to_i>=300 && k[8].to_i<400
    m=wpnz.reject{|q| q[1]!=k[1] || q[2]!=k[2] || q[9]!=k[8] || ['','0',0].include?(q[9])}
    m=wpnz.reject{|q| q[1]!=k[1] || q[2][1,1]!='v' || q[2][0,1].to_i-1!=k[2][0,1].to_i || q[9]!=k[8] || ['','0',0].include?(q[9])} if k[2][1,1]=='v' && k[8].to_i>=200 && k[8].to_i<300
    str2="#{str2}#{"\n" unless m.length==1}\n\n**Promotes from: #{element_emote(wpnz[m2][3],bot)}*#{wpnz[m2][0]}* **\n*Smithy level required:* #{k[10]}\n*Assembly cost:* #{longFormattedNumber(k[11][0])}<:Resource_Rupies:532104504372363274>\n*Required mats:* #{k[12].map{|q| "#{q[0]} x#{q[1]}"}.join(', ')}" unless m2.nil?
    if m.length>0
      for i in 0...m.length
        str2="#{str2}#{"\n" if i==0 && m.length>1}\n\n**#{"Promotion #{i+1}" if m.length>1}#{'Promotes into' if m.length==1}: #{element_emote(m[i][3],bot)}*#{m[i][0]}* **\n*Smithy level required:* #{m[i][10]}\n*Assembly cost:* #{longFormattedNumber(m[i][11][0])}<:Resource_Rupies:532104504372363274>\n*Required mats:* #{m[i][12].map{|q| "#{q[0]} x#{q[1]}"}.join(', ')}"
      end
    end
  else
    m=wpnz.find_index{|q| q[1]==k[1] && q[2]==k[2] && q[8]==k[9] && !['','0',0].include?(q[8])}
    m=wpnz.find_index{|q| q[1]==k[1] && q[2][0,1].to_i==k[2][0,1].to_i-1 && q[8]==k[9] && !['','0',0].include?(q[8])} if k[2][1,1]=='v' && k[8].to_i>=300 && k[8].to_i<400
    str2="#{str2}\n**Promotes from:** #{element_emote(wpnz[m][3],bot)}#{wpnz[m][0]}" unless m.nil?
    m=wpnz.reject{|q| q[1]!=k[1] || q[2]!=k[2] || q[9]!=k[8] || ['','0',0].include?(q[9])}
    m=wpnz.reject{|q| q[1]!=k[1] || q[2][1,1]!='v' || q[2][0,1].to_i-1!=k[2][0,1].to_i || q[9]!=k[8] || ['','0',0].include?(q[9])} if k[2][1,1]=='v' && k[8].to_i>=200 && k[8].to_i<300
    str2="#{str2}\n**Promotes into:** #{m.map{|q| "#{element_emote(q[3],bot)}#{q[0]}"}.join(', ')}" unless m.length<=0
  end
  str="#{str}#{"\n" unless s2s}#{str2}" if str2.length>0
  str="#{str}\n\n**Sells for:** #{longFormattedNumber(k[7][0])}<:Resource_Rupies:532104504372363274>#{" #{longFormattedNumber(k[7][1])}<:Resource_Eldwater:532104503777034270>" if k[7][1]>0}"
  str="#{str}\n**Assembles for:** #{longFormattedNumber(k[11][0])}<:Resource_Rupies:532104504372363274>"
  str="#{str}\n**Disassembles for:** #{longFormattedNumber(k[11][1])}<:Resource_Rupies:532104504372363274>"
  unless s2s
    if str.gsub(';;;;;',"\n#{strx}").length>=1900
      str=str.gsub(';;;;;',"\n~~The description makes this data too long.  Please try again in PM.~~")
    else
      str=str.gsub(';;;;;',"\n#{strx}")
    end
  end
  create_embed(event,"__**#{k[0]}**__",str,element_color(k[3]),nil,xpic)
end

def disp_weapon_lineage(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_weapon,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  elsif k[0].is_a?(Array)
    for i in 0...k.length
      disp_weapon_lineage(bot,event,k[i][0].split(' '))
    end
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  s2s=false if @shardizard==4 && evn.include?('smol')
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Weapons/#{k[0].gsub(' ','_')}.png"
  mub=false
  mub=true if has_any?(['mub','unbind','unbound','refined'],evn)
  str=generate_rarity_row(k[2][0,1].to_i)
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[3].gsub('None','Null')}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Element:** #{k[3]}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[1]}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Weapon Type:** #{k[1]}"
  str="#{str}\n**Welfare**" if k[2].length>1 && k[2][1,1].downcase=='w'
  str="#{str}\n**Story**" if k[2].length>1 && k[2][1,1].downcase=='y'
  str="#{str}\n**Seasonal**" if k[2].length>1 && k[2][1,1].downcase=='s'
  str="#{str}\n**Zodiac Seasonal**" if k[2].length>1 && k[2][1,1].downcase=='z'
  str="#{str}\n**Starter**" if k[2].length>1 && k[2][1,1].downcase=='e'
  str="#{str}\n**Paid**" if k[2].length>1 && k[2][1,1].downcase=='p'
  str="#{str}\n**Void**" if k[2].length>1 && k[2][1,1].downcase=='v'
  f=30*k[2][0,1].to_i-50
  f+=20 if k[2][0,1].to_i<3
  wpnz=@weapons.map{|q| q}
  sklz=@askilities.map{|q| q}
  skl=nil
  skl=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6]} if !k[6].nil? && k[6].length>0
  skl=sklz[skl] unless skl.nil?
  abl=nil
  abl2=nil
  ablx=nil
  ablx2=nil
  unless k[13].nil? || k[13].length<=0
    abl=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==k[13][0][0]} if !k[13][0][0].nil? && k[13][0][0].length>0
    abl=sklz[abl] unless abl.nil?
    abl2=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==k[13][0][1]} if !k[13][0][1].nil? && k[13][0][1].length>0
    abl2=sklz[abl2] unless abl2.nil?
    unless k[13][1].nil? || k[13][1].length<=0
      ablx=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==k[13][1][0]} if !k[13][1][0].nil? && k[13][1][0].length>0
      ablx=sklz[ablx] unless ablx.nil?
      ablx2=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==k[13][1][1]} if !k[13][1][1].nil? && k[13][1][1].length>0
      ablx2=sklz[ablx2] unless ablx2.nil?
    end
  end
  if mub
    str="#{str}\n**#{'<:Unbind:534494090969088000>'*4} Level #{f}**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[4][2])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][2])}"
  else
    str="#{str}\n**#{'<:NonUnbound:534494090876682264>'*4} Level 1**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][0])}"
    str="#{str}\n**#{'<:NonUnbound:534494090876682264>'*4} Level 80**  \u200B  \u200B  *HP:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}  \u200B  \u200B  *Str:*\u00A0\u00A0#{longFormattedNumber(k[5][1])}" if k[2][0,1].to_i>=5 && k[3]!='None'
  end
  if s2s && !skl.nil?
    if mub
      str="#{str}\n**Skill:** *#{skl[0]}* - #{longFormattedNumber(skl[6][1])} SP\n#{skl[4].gsub(';; ',"\n")}"
    else
      str="#{str}\n**Skill:** *#{skl[0]}* - #{longFormattedNumber(skl[6][0])} SP\n#{skl[3].gsub(';; ',"\n")}"
    end
  else
    strx=''
    unless skl.nil?
      str="#{str}\n**Skill:** *#{skl[0]}*"
      if skl[6][0]==skl[6][1]
        str="#{str} - #{longFormattedNumber(skl[6][0])} SP;;;;;"
      else
        str="#{str} - #{longFormattedNumber(skl[6][0])} \u2192 #{longFormattedNumber(skl[6][1])} SP;;;;;"
      end
      strx=skl[3].gsub(';; ',"\n")
      strx=skl[4].gsub(';; ',"\n") if mub
    end
  end
  if !abl2.nil?
    str="#{str}\n**Abilities:** *#{abl2[0]}#{" #{'+' if abl2[1].include?('%')}#{abl2[1]}" unless abl2[1]=='-'}*"
  elsif !abl.nil?
    str="#{str}\n**Abilities:** *#{abl[0]}#{" #{'+' if abl[1].include?('%')}#{abl[1]}" unless abl[1]=='-'}*"
  elsif !ablx2.nil?
    str="#{str}\n**Abilities:** *#{ablx2[0]}#{" #{'+' if ablx2[1].include?('%')}#{ablx2[1]}" unless ablx2[1]=='-'}*"
    ablx2=nil
    ablx=nil
  elsif !ablx.nil?
    str="#{str}\n**Abilities:** *#{ablx[0]}#{" #{'+' if ablx[1].include?('%')}#{ablx[1]}" unless ablx[1]=='-'}*"
    ablx=nil
  end
  if !ablx2.nil?
    str="#{str}, *#{ablx2[0]}#{" #{'+' if ablx2[1].include?('%')}#{ablx2[1]}" unless ablx2[1]=='-'}*"
  elsif !ablx.nil?
    str="#{str}, *#{ablx[0]}#{" #{'+' if ablx[1].include?('%')}#{ablx[1]}" unless ablx[1]=='-'}*"
  end
  str2=''
  val=1
  val=5 if mub
  ftr=nil
  str="#{str}\n\n**This weapon#{" (x#{val})" unless val==1}**\n*Smithy level required:* #{k[10]}\n*Assembly cost:* #{longFormattedNumber(val*k[11][0])}<:Resource_Rupies:532104504372363274>#{"\n*Required mats:* #{k[12].map{|q| "#{q[0]} x#{val*q[1].to_i}"}.join(', ')}" unless k[12].nil?}"
  m2=wpnz.find_index{|q| q[1]==k[1] && q[2]==k[2] && q[8]==k[9] && !['','0',0].include?(q[8])}
  m2=wpnz.find_index{|q| q[1]==k[1] && q[2][1,1]=='v' && q[2][0,1].to_i==k[2][0,1].to_i-1 && q[8]==k[9] && !['','0',0].include?(q[8])} if k[2][1,1]=='v' && k[8].to_i>=300
  cost=0
  cost+=val*k[11][0]
  mtz=[]
  unless k[12].nil?
    for i in 0...k[12].length
      mtz.push([k[12][i][0],k[12][i][1].to_i*val])
    end
  end
  unless m2.nil?
    str2="#{str2}\n\n**Promotes from: #{element_emote(wpnz[m2][3],bot)}*#{wpnz[m2][0]}* (x#{5*val})**\n*Assembly cost:* #{longFormattedNumber(val*5*wpnz[m2][11][0])}<:Resource_Rupies:532104504372363274>\n#{"*Required mats:* #{wpnz[m2][12].map{|q| "#{q[0]} x#{val*5*q[1].to_i}"}.join(', ')}" unless wpnz[m2][12].nil?}"
    cost+=val*5*wpnz[m2][11][0]
    unless wpnz[m2][12].nil?
      for i in 0...wpnz[m2][12].length
        mtz.push([wpnz[m2][12][i][0],wpnz[m2][12][i][1].to_i*5*val])
      end
    end
    m22=wpnz.find_index{|q| q[1]==wpnz[m2][1] && q[2]==wpnz[m2][2] && q[8]==wpnz[m2][9] && !['','0',0].include?(q[8])}
    m22=wpnz.find_index{|q| q[1]==wpnz[m2][1] && q[2][1,1]=='v' && q[2][0,1].to_i==wpnz[m2][2][0,1].to_i-1 && q[8]==wpnz[m2][9] && !['','0',0].include?(q[8])} if wpnz[m2][2][1,1]=='v' && wpnz[m2][8].to_i>=300
    unless m22.nil?
      str2="#{str2}\n\n**Which promotes from: #{element_emote(wpnz[m22][3],bot)}*#{wpnz[m22][0]}* (x#{25*val})**\n*Assembly cost:* #{longFormattedNumber(val*25*wpnz[m22][11][0])}<:Resource_Rupies:532104504372363274>\n*#{"Required mats:* #{wpnz[m22][12].map{|q| "#{q[0]} x#{val*25*q[1].to_i}"}.join(', ')}" unless wpnz[m22][12].nil?}"
      cost+=val*25*wpnz[m22][11][0]
      unless wpnz[m22][12].nil?
        for i in 0...wpnz[m22][12].length
          mtz.push([wpnz[m22][12][i][0],wpnz[m22][12][i][1].to_i*25*val])
        end
      end
      m222=wpnz.find_index{|q| q[1]==wpnz[m22][1] && q[2]==wpnz[m22][2] && q[8]==wpnz[m22][9] && !['','0',0].include?(q[8])}
      m222=wpnz.find_index{|q| q[1]==wpnz[m22][1] && q[2][1,1]=='v' && q[2][0,1].to_i==wpnz[m22][2][0,1].to_i-1 && q[8]==wpnz[m22][9] && !['','0',0].include?(q[8])} if wpnz[m22][2][1,1]=='v' && wpnz[m22][8].to_i>=300
      unless m222.nil?
        str2="#{str2}\n\n**Which promotes from: #{element_emote(wpnz[m222][3],bot)}*#{wpnz[m222][0]}* (x#{125*val})**\n*Assembly cost:* #{longFormattedNumber(val*125*wpnz[m222][11][0])}<:Resource_Rupies:532104504372363274>\n#{"*Required mats:* #{wpnz[m222][12].map{|q| "#{q[0]} x#{val*125*q[1].to_i}"}.join(', ')}" unless wpnz[m222][12].nil?}"
        cost+=val*125*wpnz[m222][11][0]
        unless wpnz[m222][12].nil?
          for i in 0...wpnz[m222][12].length
            mtz.push([wpnz[m222][12][i][0],wpnz[m222][12][i][1].to_i*125*val])
          end
        end
      end
    end
  end
  if s2s
    ftr='Include the word "Unbound" to show the data for MUB versions of these weapons.' unless mub
  else
    m=wpnz.find_index{|q| q[1]==k[1] && q[2]==k[2] && q[8]==k[9] && !['','0',0].include?(q[8])}
    str2=''
    unless m.nil?
      str2="#{str2}\n\n**Promotes from:** #{wpnz[m][0]}"
      m2=wpnz.find_index{|q| q[1]==wpnz[m][1] && q[2]==wpnz[m][2] && q[8]==wpnz[m][9] && !['','0',0].include?(q[8])}
      unless m2.nil?
        str2="#{str2}\n**Which promotes from:** #{wpnz[m2][0]}"
        m22=wpnz.find_index{|q| q[1]==wpnz[m2][1] && q[2]==wpnz[m2][2] && q[8]==wpnz[m2][9] && !['','0',0].include?(q[8])}
        str2="#{str2}\n**Which promotes from:** #{wpnz[m22][0]}" unless m22.nil?
      end
    end
  end
  str3=''
  unless m2.nil?
    str3="**TOTALS**\n*Assembly cost:* #{longFormattedNumber(cost)}<:Resource_Rupies:532104504372363274>\n*Required Mats:* "
    mtzz=mtz.map{|q| q[0]}.uniq
    for i in 0...mtzz.length
      str3="#{str3}#{', ' unless i==0}#{mtzz[i]} x#{mtz.reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i}.inject(0){|sum,x| sum + x }}"
    end
  end
  str="#{str}#{str2}" if str2.length>0
  unless s2s
    if str.gsub(';;;;;',"\n#{strx}").length>=1900
      str=str.gsub(';;;;;',"\n~~The description makes this data too long.  Please try again in PM.~~")
    else
      str=str.gsub(';;;;;',"\n#{strx}")
    end
  end
  if str.length+str3.length>=1900
    create_embed(event,"__**#{k[0]}**__",str,element_color(k[3]),nil,xpic)
    create_embed(event,'',str3,element_color(k[3]),ftr)
  else
    create_embed(event,"__**#{k[0]}**__","#{str}\n\n#{str3}",element_color(k[3]),ftr,xpic)
  end
end

def disp_enemy_data(bot,event,args=nil,ignoresub=false)
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
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  s2s=false if @shardizard==4 && evn.include?('smol')
  sklz=@askilities.map{|q| q}
  str=''
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0].gsub('None','Null')}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Element:** #{k[2][0]}" unless ['High Dragon','Void','Imperial Order'].include?(k[2][2])
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{k[2][1]}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Tribe:** #{k[2][1]}"
  if k[1].length<2
    str="#{str}\n**Maximum HP:** #{longFormattedNumber(k[1][0])}"
  else
    str="#{str}\n\n__**Maximum HP:**__"
    str="#{str}\n*Beginner:* #{longFormattedNumber(k[1][0])}" if k[1].length>0 && k[1][0]>-1
    str="#{str}\n*Standard:* #{longFormattedNumber(k[1][1])}" if k[1].length>1 && k[1][1]>-1
    str="#{str}\n*Expert:* #{longFormattedNumber(k[1][2])}" if k[1].length>2 && k[1][2]>-1
    str="#{str}\n*Master:* #{longFormattedNumber(k[1][3])}" if k[1].length>3 && k[1][3]>-1
    str="#{str}\n*Special:* #{longFormattedNumber(k[1][4])}" if k[1].length>4 && k[1][4]>-1
    str="#{str}\n*Challenge:* #{longFormattedNumber(k[1][5])}" if k[1].length>5 && k[1][5]>-1
  end
  if k[2].length>3
    m=@enemies.reject{|q| q[0]==k[0] || q[2].length<4 || q[2][3]!=k[2][3]}
    str="#{str}#{"\n" if k[1].length>1 || m.length>0}\n**Event Name:** #{k[2][3]}"
    str="#{str}\n*Other bosses from this event:* #{m.map{|q| "#{enemy_emoji(q,bot)}#{q[0]}"}.join(', ')}" if m.length>0 && !ignoresub
  end
  flds=nil
  if s2s
    flds=[]
    flds.push(['Weaknesses',"#{k[3].join("\n")}#{"\n\n~~Bold indicates strong weaknesses~~" if k[3].reject{|q| !q.include?('**')}.length>0}"])
    flds.push(['Afflictions',"#{k[4].join("\n")}"])
  else
    str="#{str}\n\n**Weaknesses:** #{k[3].join(', ').gsub('**','*')}#{"\n~~Italic indicates strong weaknesses~~" if k[3].reject{|q| !q.include?('**')}.length>0}"
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
  xcolor=0x495218 if k[2][1]=='Human'
  xcolor=0xAD82DE if k[2][1]=='Undead'
  xpic="#{k[0].gsub(' ','_')}"
  ftr=nil
  ftr='For information about the enemies that spawn during the fight, try adding "Clone Wave 1" or "Clone Wave 2" to your message.' if k[0]=="Wandering Shroom" && !s2s
  ftr='For information about the enemies that spawn during the fight, they are named "Gift Basket".' if k[0]=="Shishimai" && !s2s
  hdr="__**#{k[0]}**__"
  if k[2][2]=='Void'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0].gsub('None','Null')}"}
    hdr="#{moji[0].mention}<:Element_Void:548467446734913536> #{hdr}" if moji.length>0
  elsif k[2][2]=='High Dragon'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0].gsub('None','Null')}"}
    hdr="#{moji[0].mention} #{hdr}" if moji.length>0
    m=false
    IO.copy_stream(open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/FightBanners/Banner_#{xpic}.png"), "C:/Users/Mini-Matt/Desktop/devkit/DLTemp#{@shardizard}.png") rescue m=true
    if File.size("C:/Users/Mini-Matt/Desktop/devkit/DLTemp#{@shardizard}.png")<=100 || m
      xpic="#{xpic.gsub('_(Enemy)','')}"
    end
  elsif k[2][2]=='Imperial Order'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0].gsub('None','Null')}"}
    hdr="#{moji[0].mention} #{hdr}" if moji.length>0
  end
  xpic=[nil,"https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/FightBanners/Banner_#{xpic}.png"]
  xpic='https://github.com/Rot8erConeX/BotanBot/blob/master/FightBanners/Matilda_5.png?raw=true' if k[0]=='Matilda'
  create_embed(event,hdr,str,xcolor,ftr,xpic,flds)
  if k[0]=="Wandering Shroom" && s2s
    disp_enemy_data(bot,event,"Wandering Shroom, Clone Wave 1".split(' '),true)
    disp_enemy_data(bot,event,"Wandering Shroom, Clone Wave 2".split(' '),true)
  elsif k[0]=="Shishimai" && s2s
    disp_enemy_data(bot,event,"Gift Basket".split(' '),true)
  end
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
    m.push("#{x[i][0]} - S2") if x[i][6][1]==k[0]
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
  if args.include?('tags')
    if flds.length<=0
      flds=triple_finish(k[10])
      str="#{str}\n\n__**Tags**__"
    else
      flds.push(['Tags',k[10].join("\n")])
    end
  end
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
  wep=@weapons.map{|q| q}
  enm=@enemies.map{|q| q}
  unless evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
    for i in 0...adv.length
      m=[adv[i][8][0][1].split(' '),adv[i][8][1][1].split(' '),adv[i][8][2][-1].split(' ')]
      adv[i][8][3]=['x','x']
      if adv[i][8][2].length>1
      elsif m[0][-1].include?('%') && m[2][-1].include?('%') && m[0][0,m[0].length-1].join(' ')==m[2][0,m[2].length-1].join(' ')
        adv[i][8][0][1]='x'
        adv[i][8][2][-1]='x'
        adv[i][8][3]=["#{m[0][0,m[0].length-1].join(' ')} +#{m[0][-1].gsub('+','').gsub('%','').to_i+m[2][-1].gsub('+','').gsub('%','').to_i}%",'x']
      elsif m[1][-1].include?('%') && m[2][-1].include?('%') && m[1][0,m[1].length-1].join(' ')==m[2][0,m[2].length-1].join(' ')
        adv[i][8][1][1]='x'
        adv[i][8][2][-1]='x'
        adv[i][8][3]=['x',"#{m[1][0,m[1].length-1].join(' ')} +#{m[1][-1].gsub('+','').gsub('%','').to_i+m[2][-1].gsub('+','').gsub('%','').to_i}%"]
      end
    end
  end
  ftr=nil
  flds=nil
  dispslots=false
  dispslots=true if evn.include?('slots') || evn.include?('slot')
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
        hdr="__**#{k[0][1]} #{k[0][0]}**__ [Ability family]" if k[0][0][0,5]=='Hits '
        m=k2[0]
        str="__**Ability**__"
        str="#{str}\n*Effect:* #{m[3]}" if m[5]=='y'
        m2=[]
        checkstr="#{k[0][0]} #{'+' if k[0][1].include?('%')}#{k[0][1]}"
        checkstr="#{k[0][0]}" if k[0][1]=='-'
        for i in 0...adv.length
          if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
            m2.push("#{adv[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][0][0]==checkstr
            m2.push("#{adv[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][0][1]==checkstr
            m2.push("#{adv[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][1][0]==checkstr
            m2.push("#{adv[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][1][1]==checkstr
            m2.push("#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2][0]==checkstr && adv[i][8][2].length<=1
            m2.push("#{adv[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][2][0]==checkstr && adv[i][8][2].length>1
            m2.push("#{adv[i][0]}#{" (A3\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][2][1]==checkstr && adv[i][8][2].length>1
          else
            m2.push("#{adv[i][0]}#{" (A1)" if dispslots}") if adv[i][8][0][1]==checkstr
            m2.push("#{adv[i][0]}#{" (A2)" if dispslots}") if adv[i][8][1][1]==checkstr
            m2.push("#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2][0]==checkstr && adv[i][8][2].length<=1
            m2.push("#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2][1]==checkstr && adv[i][8][2].length>1
            m2.push("#{adv[i][0]}#{" (A1+3)" if dispslots}") if adv[i][8][3][0]==checkstr
            m2.push("#{adv[i][0]}#{" (A2+3)" if dispslots}") if adv[i][8][3][1]==checkstr
          end
        end
        str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
        m2=[]
        for i in 0...drg.length
          if drg[i][6].length>1
            if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
              m2.push("#{drg[i][0]}#{" (A\u2081)" if dispslots}#{' [Min]' unless dispslots}") if drg[i][6][1][0]==checkstr
              m2.push("#{drg[i][0]}#{" (A\u2082)" if dispslots}#{' [Max]' unless dispslots}") if drg[i][6][1][1]==checkstr
            else
              m2.push("#{drg[i][0]}") if drg[i][6][1][1]==checkstr
            end
          end
        end
        str="#{str}\n*Dragons:* #{m2.join(', ')}" if m2.length>0
        m2=[]
        for i in 0...wrm.length
          if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
            m2.push("#{wrm[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5][0][0]==checkstr
            m2.push("#{wrm[i][0]}#{" (A1\u2082)" if dispslots}#{' [Mix]' unless dispslots}") if wrm[i][5][0][1]==checkstr
            m2.push("#{wrm[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr
            m2.push("#{wrm[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
            m2.push("#{wrm[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr
            m2.push("#{wrm[i][0]}#{" (A3\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
          else
            m2.push("#{wrm[i][0]}#{" (A1)" if dispslots}") if wrm[i][5][0][1]==checkstr
            m2.push("#{wrm[i][0]}#{" (A2)" if dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
            m2.push("#{wrm[i][0]}#{" (A3)" if dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
          end
        end
        str="#{str}\n*Wyrmprints:* #{m2.join(', ')}" if m2.length>0
        m2=[]
        for i in 0...wep.length
          unless wep[i][13].nil? || wep[i][13].length<=0
            if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
              m2.push("#{wep[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wep[i][13][0][0]==checkstr
              m2.push("#{wep[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wep[i][13][0][1]==checkstr
              m2.push("#{wep[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][0]==checkstr
              m2.push("#{wep[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr
            else
              m2.push("#{wep[i][0]}#{" (A1)" if dispslots}") if wep[i][13][0][1]==checkstr
              m2.push("#{wep[i][0]}#{" (A2)" if dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr
            end
          end
        end
        str="#{str}\n*Weapons:* #{m2.join(', ')}" if m2.length>0
        m2=[]
        for i in 0...enm.length
          unless enm[i][5].nil? || enm.length<=0
            for i2 in 0...enm[i][5].length
              m2.push("#{enm[i][0]}#{" (A#{i2+1})" if dispslots}") if enm[i][5][i2]==checkstr
            end
          end
        end
        str="#{str}\n*Enemies:* #{m2.join(', ')}" if m2.length>0
        m=k3[0]
        str="#{str}\n\n__**Co-Ability**__"
        str="#{str}\n*Effect:* #{m[3]}" if m[5]=='y'
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
        ftr='The numbers in parenthesis indicate which CoAbility stage the adventurer needs to have.'
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
        if s2s
          checkstr="#{k[i2][0]} #{'+' if k[i2][1].include?('%')}#{k[i2][1]}"
          checkstr="#{k[i2][0]}" if k[i2][1]=='-'
          m2=[]
          if k[i2][2]=='Ability'
            for i in 0...adv.length
              if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
                m2.push("#{adv[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][0][0]==checkstr
                m2.push("#{adv[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][0][1]==checkstr
                m2.push("#{adv[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][1][0]==checkstr
                m2.push("#{adv[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][1][1]==checkstr
                m2.push("#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2][0]==checkstr && adv[i][8][2].length<=1
                m2.push("#{adv[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][2][0]==checkstr && adv[i][8][2].length>1
                m2.push("#{adv[i][0]}#{" (A3\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][2][1]==checkstr && adv[i][8][2].length>1
              else
                m2.push("#{adv[i][0]}#{" (A1)" if dispslots}") if adv[i][8][0][1]==checkstr
                m2.push("#{adv[i][0]}#{" (A2)" if dispslots}") if adv[i][8][1][1]==checkstr
                m2.push("#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2][0]==checkstr && adv[i][8][2].length<=1
                m2.push("#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2][1]==checkstr && adv[i][8][2].length>1
                m2.push("#{adv[i][0]}#{" (A1+3)" if dispslots}") if adv[i][8][3][0]==checkstr
                m2.push("#{adv[i][0]}#{" (A2+3)" if dispslots}") if adv[i][8][3][1]==checkstr
              end
            end
            str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
            m2=[]
            for i in 0...drg.length
              if drg[i][6].length>1
                if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
                  m2.push("#{drg[i][0]}#{" (A\u2081)" if dispslots}#{' [Min]' unless dispslots}") if drg[i][6][1][0]==checkstr
                  m2.push("#{drg[i][0]}#{" (A\u2082)" if dispslots}#{' [Max]' unless dispslots}") if drg[i][6][1][1]==checkstr
                else
                  m2.push("#{drg[i][0]}") if drg[i][6][1][1]==checkstr
                end
              end
            end
            str="#{str}\n*Dragons:* #{m2.join(', ')}" if m2.length>0
            m2=[]
            for i in 0...wrm.length
              if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
                m2.push("#{wrm[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5][0][0]==checkstr
                m2.push("#{wrm[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5][0][1]==checkstr
                m2.push("#{wrm[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr
                m2.push("#{wrm[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
                m2.push("#{wrm[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr
                m2.push("#{wrm[i][0]}#{" (A3\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
              else
                m2.push("#{wrm[i][0]}#{" (A1)" if dispslots}") if wrm[i][5][0][1]==checkstr
                m2.push("#{wrm[i][0]}#{" (A2)" if dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
                m2.push("#{wrm[i][0]}#{" (A3)" if dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
              end
            end
            str="#{str}\n*Wyrmprints:* #{m2.join(', ')}" if m2.length>0
            m2=[]
            for i in 0...wep.length
              unless wep[i][13].nil? || wep[i][13].length<=0
                if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
                  m2.push("#{wep[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wep[i][13][0][0]==checkstr
                  m2.push("#{wep[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wep[i][13][0][1]==checkstr
                  m2.push("#{wep[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][0]==checkstr
                  m2.push("#{wep[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr
                else
                  m2.push("#{wep[i][0]}#{" (A1)" if dispslots}") if wep[i][13][0][1]==checkstr
                  m2.push("#{wep[i][0]}#{" (A2)" if dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr
                end
              end
            end
            str="#{str}\n*Weapons:* #{m2.join(', ')}" if m2.length>0
            m2=[]
            for i in 0...enm.length
              unless enm[i][5].nil? || enm.length<=0
                for i2 in 0...enm[i][5].length
                  m2.push("#{enm[i][0]}#{" (A#{i2+1})" if dispslots}") if enm[i][5][i2]==checkstr
                end
              end
            end
            str="#{str}\n*Enemies:* #{m2.join(', ')}" if m2.length>0
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
    ftr='To include base abilities, include the word "subabilities" in your message.' unless !ftr.nil? || evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
    ftr=nil if k.reject{|q| q[2]=='CoAbility'}.length<=0
  else
    hdr="__**#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}**__ [#{k[2]}]"
    hdr="__**#{k[1]} #{k[0]}**__ [#{k[2]}]" if k[0][0,5]=='Hits '
    hdr="__**#{k[0]}**__ [#{k[2]}]" if k[1]=='-'
    xcolor=0x555058
    xcolor=0x87817C if k[2]=='Aura'
    xcolor=0x242035 if k[2]=='CoAbility'
    str="**Effect:** #{k[3]}" if k[5]=='y' || k[2]=='Aura'
    str2=''
    flds=[]
    if k[2]=='Ability'
      m2=[]
      checkstr="#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}"
      checkstr="#{k[0]}" if k[1]=='-'
      for i in 0...adv.length
        if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
          m2.push("#{adv[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][0][0]==checkstr
          m2.push("#{adv[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][0][1]==checkstr
          m2.push("#{adv[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][1][0]==checkstr
          m2.push("#{adv[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][1][1]==checkstr
          m2.push("#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2][0]==checkstr && adv[i][8][2].length<=1
          m2.push("#{adv[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][2][0]==checkstr && adv[i][8][2].length>1
          m2.push("#{adv[i][0]}#{" (A3\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][2][1]==checkstr && adv[i][8][2].length>1
        else
          m2.push("#{adv[i][0]}#{" (A1)" if dispslots}") if adv[i][8][0][1]==checkstr
          m2.push("#{adv[i][0]}#{" (A2)" if dispslots}") if adv[i][8][1][1]==checkstr
          m2.push("#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2][0]==checkstr && adv[i][8][2].length<=1
          m2.push("#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2][1]==checkstr && adv[i][8][2].length>1
          m2.push("#{adv[i][0]}#{" (A1+3)" if dispslots}") if adv[i][8][3][0]==checkstr
          m2.push("#{adv[i][0]}#{" (A2+3)" if dispslots}") if adv[i][8][3][1]==checkstr
        end
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
          if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
            m2.push("#{drg[i][0]}#{" (A\u2081)" if dispslots}#{' [Min]' unless dispslots}") if drg[i][6][1][0]==checkstr
            m2.push("#{drg[i][0]}#{" (A\u2082)" if dispslots}#{' [Max]' unless dispslots}") if drg[i][6][1][1]==checkstr
          else
            m2.push("#{drg[i][0]}") if drg[i][6][1][1]==checkstr
          end
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
        if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
          m2.push("#{wrm[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5][0][0]==checkstr
          m2.push("#{wrm[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5][0][1]==checkstr
          m2.push("#{wrm[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr
          m2.push("#{wrm[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
          m2.push("#{wrm[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr
          m2.push("#{wrm[i][0]}#{" (A3\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
        else
          m2.push("#{wrm[i][0]}#{" (A1)" if dispslots}") if wrm[i][5][0][1]==checkstr
          m2.push("#{wrm[i][0]}#{" (A2)" if dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
          m2.push("#{wrm[i][0]}#{" (A3)" if dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
        end
      end
      if m2.length>0
        if !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Wyrmprints:** #{m2.join(', ')}"
        else
          flds.push(['Wyrmprints',m2.join("\n")])
        end
      end
      m2=[]
      for i in 0...wep.length
        unless wep[i][13].nil? || wep[i][13].length<=0
          if evn.include?('sub') || evn.include?('subabilities') || evn.include?('subability') || evn.include?('starter')
            m2.push("#{wep[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wep[i][13][0][0]==checkstr
            m2.push("#{wep[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots}") if wep[i][13][0][1]==checkstr
            m2.push("#{wep[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][0]==checkstr
            m2.push("#{wep[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr
          else
            m2.push("#{wep[i][0]}#{" (A1)" if dispslots}") if wep[i][13][0][1]==checkstr
            m2.push("#{wep[i][0]}#{" (A2)" if dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr
          end
        end
      end
      if m2.length>0
        if !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Weapons:** #{m2.join(', ')}"
        else
          flds.push(['Weapons',m2.join("\n")])
        end
      end
      m2=[]
      for i in 0...enm.length
        unless enm[i][5].nil? || enm.length<=0
          for i2 in 0...enm[i][5].length
            m2.push("#{enm[i][0]}#{" (A#{i2+1})" if dispslots}") if enm[i][5][i2]==checkstr
          end
        end
      end
      if m2.length>0
        if !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Enemies:** #{m2.join(', ')}"
        else
          flds.push(['Enemies',m2.join("\n")])
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
      ftr='The numbers in parenthesis indicate which CoAbility stage the adventurer needs to have.'
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

def disp_facility_data(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_facility,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  s2s=false if @shardizard==4 && evn.include?('smol')
  str=''
  str="**Type:** #{k[2][0]} #{"(#{k[2][1]})" if k[2].length>1}"
  str="#{str}\n**Size:** #{k[3]}"
  str="#{str}\n**Quantity available:** #{k[4]}"
  str="#{str}\n\n**Description:** #{k[1]}"
  m='t'
  m='Amber' if ['Staff Dojo'].include?(k[0])
  m='Azure' if ['Blade Dojo','Lance Dojo'].include?(k[0])
  m='Jade' if ['Axe Dojo','Wand Dojo'].include?(k[0])
  m='Vermillion' if ['Sword Dojo','Bow Dojo'].include?(k[0])
  m='Violet' if ['Dagger Dojo'].include?(k[0])
  str="#{str}\n\n**First Dojo cost:** Dyrenell Aes x10\n**Second Dojo cost:** Dyrenell Aes x30, Dyrenell Argenteus x10, #{k[0].split(' ')[0]} Tablet x2" if k[2]==['Adventurer', 'Dojo']
  if k[2]==['Adventurer', 'Altar']
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
  elsif k[0]=='Fafnir Statue (Wind)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Wind:532106087948746763>High Midgardsormr's Trial\n**Cost:** Windwyrm's Greatsphere x30, Talonstone x10"
  elsif k[0]=='Smithy' && !s2s
    str="#{str}\n\nLevel 1-3 Smithies can craft #{generate_rarity_row(3)} weapons"
    str="#{str}\nLevel 4-6 Smithies can craft #{generate_rarity_row(4)} weapons"
    str="#{str}\nLevel 7-9 Smithies can craft #{generate_rarity_row(5)} weapons"
    str="#{str}\nEach new level of smithy allows you to craft higher-tier weapons within the newest-allowed rarity bracket."
  end
  ftr=nil
  ftr='Use this command in PM to see the costs to upgrade this facility.' unless s2s
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Facilities/#{k[0].gsub(' ','_')}.png"
  create_embed(event,"__**#{k[0]}**__",str,0x8BE3F7,ftr,xpic)
  if s2s
    str=''
    ftr=nil
    if k[2][0]=='Adventurer'
      if k[2][1]=='Dojo'
        m='t'
        m='Amber' if ['Staff Dojo'].include?(k[0])
        m='Azure' if ['Blade Dojo','Lance Dojo'].include?(k[0])
        m='Jade' if ['Axe Dojo','Wand Dojo'].include?(k[0])
        m='Vermillion' if ['Sword Dojo','Bow Dojo'].include?(k[0])
        m='Violet' if ['Dagger Dojo'].include?(k[0])
        str="*Level 1 \u2192 5 (per level):* Dyrenell Aes x10"
        str="#{str}\n\n*Level 5 \u2192 10 (per level):* Dyrenell Aes x20"
        str="#{str}\n\n*Level 10 \u2192 13 (per level):* Dyrenell Aes x30, Dyrenell Argenteus x5, #{m} Insignia x10"
        str="#{str}\n\n*Level 13 \u2192 15 (per level):* Dyrenell Aes x30, Dyrenell Argenteus x10, #{m} Insignia x20"
        str="#{str}\n\n*Level 15 \u2192 18 (per level):* Dyrenell Aes x50, Dyrenell Argenteus x20, #{m} Insignia x40"
        str="#{str}\n\n*Level 18 \u2192 20 (per level):* Dyrenell Aes x70, Dyrenell Argenteus x30, #{m} Insignia x60"
        str="#{str}\n\n*Level 20 \u2192 21:* Dyrenell Aes x100, Dyrenell Argenteus x40, Dyrenell Aureus x20, #{m} Insignia x80"
        str="#{str}\n\n*Level 21 \u2192 22:* Dyrenell Aes x100, Dyrenell Argenteus x40, Dyrenell Aureus x30, #{m} Insignia x80"
        str="#{str}\n\n*Level 22 \u2192 23:* Dyrenell Aes x100, Dyrenell Argenteus x40, Dyrenell Aureus x40, #{m} Insignia x80"
        str="#{str}\n\n*Level 23 \u2192 24:* Dyrenell Aes x150, Dyrenell Argenteus x50, Dyrenell Aureus x50, #{m} Insignia x100"
        str="#{str}\n\n*Level 24 \u2192 25:* Dyrenell Aes x150, Dyrenell Argenteus x50, Dyrenell Aureus x60, #{m} Insignia x100"
        str="#{str}\n\n*Level 25 \u2192 26:* Dyrenell Aes x200, Dyrenell Argenteus x60, Dyrenell Aureus x70, #{m} Insignia x120, Royal #{m} Insignia x20"
        str="#{str}\n\n*Level 26 \u2192 27:* Dyrenell Aes x200, Dyrenell Argenteus x60, Dyrenell Aureus x80, #{m} Insignia x120, Royal #{m} Insignia x30"
        str="#{str}\n\n*Level 27 \u2192 28:* Dyrenell Aes x200, Dyrenell Argenteus x60, Dyrenell Aureus x90, #{m} Insignia x120, Royal #{m} Insignia x40"
        str="#{str}\n\n*Level 28 \u2192 29:* Dyrenell Aes x300, Dyrenell Argenteus x80, Dyrenell Aureus x100, #{m} Insignia x160, Royal #{m} Insignia x50"
        str="#{str}\n\n*Level 29 \u2192 30:* Dyrenell Aes x300, Dyrenell Argenteus x80, Dyrenell Aureus x110, #{m} Insignia x160, Royal #{m} Insignia x60"
      elsif k[2][1]=='Altar'
        m=['1','2','3']
        m=['Flame','Blaze','Inferno'] if k[0]=='Flame Altar'
        m=['Water','Stream','Deluge'] if k[0]=='Water Altar'
        m=['Wind','Storm','Maelstorm'] if k[0]=='Wind Altar'
        m=['Light','Radiance','Refulgence'] if k[0]=='Light Altar'
        m=['Shadow','Nightfull','Nether'] if k[0]=='Shadow Altar'
        str="*Level 1 \u2192 3 (per level):* ~~no mats~~"
        str="#{str}\n*Level 3 \u2192 4:* #{m[0]} Orb x1"
        str="#{str}\n*Level 4 \u2192 5:* #{m[0]} Orb x3"
        str="#{str}\n*Level 5 \u2192 8 (per level):* #{m[0]} Orb x5"
        str="#{str}\n*Level 8 \u2192 10 (per level):* #{m[0]} Orb x7"
        str="#{str}\n*Level 10 \u2192 13 (per level):* #{m[0]} Orb x10, #{m[1]} Orb x1"
        str="#{str}\n*Level 13 \u2192 15 (per level):* #{m[0]} Orb x15, #{m[1]} Orb x2"
        str="#{str}\n*Level 15 \u2192 18 (per level):* #{m[0]} Orb x20, #{m[1]} Orb x3"
        str="#{str}\n*Level 18 \u2192 20 (per level):* #{m[0]} Orb x30, #{m[1]} Orb x4"
        str="#{str}\n*Level 20 \u2192 23 (per level):* #{m[0]} Orb x50, #{m[1]} Orb x6, #{m[2]} Orb x1"
        str="#{str}\n*Level 23 \u2192 25 (per level):* #{m[0]} Orb x70, #{m[1]} Orb x8, #{m[2]} Orb x1"
        str="#{str}\n*Level 25 \u2192 28 (per level):* #{m[0]} Orb x100, #{m[1]} Orb x10, #{m[2]} Orb x2"
        str="#{str}\n*Level 28 \u2192 30 (per level):* #{m[0]} Orb x150, #{m[1]} Orb x12, #{m[2]} Orb x3"
      elsif k[2][1]=='Void Altar'
        str="*Level 1 \u2192 2:* Bat's Wing x10"
        str="#{str}\n*Level 2 \u2192 3:* Bat's Wing x15, Solid Fungus x2"
        str="#{str}\n*Level 3 \u2192 4:* Bat's Wing x20"
        str="#{str}\n*Level 4 \u2192 5:* Bat's Wing x25, Solid Fungus x5"
        str="#{str}\n*Level 5 \u2192 6:* Bat's Wing x30, Ancient Bird's Feather x5"
        str="#{str}\n*Level 6 \u2192 7:* Bat's Wing x35, Ancient Bird's Feather x10, Steel Slab x2"
        str="#{str}\n*Level 7 \u2192 8:* Bat's Wing x40, Ancient Bird's Feather x15"
        str="#{str}\n*Level 8 \u2192 9:* Bat's Wing x45, Ancient Bird's Feather x20, Steel Slab x5"
        str="#{str}\n*Level 9 \u2192 10:* Bat's Wing x50, Ancient Bird's Feather x25"
        str="#{str}\n*Level 10 \u2192 11:* Bat's Wing x55, Ancient Bird's Feather x30, Bewitching Wings x5, Great Feather x2"
        str="#{str}\n*Level 11 \u2192 12:* Bat's Wing x60, Ancient Bird's Feather x35, Bewitching Wings x10"
        str="#{str}\n*Level 12 \u2192 13:* Bat's Wing x65, Ancient Bird's Feather x40, Bewitching Wings x15, Great Feather x5"
        str="#{str}\n*Level 13 \u2192 14:* Bat's Wing x70, Ancient Bird's Feather x45, Bewitching Wings x20"
        str="#{str}\n*Level 14 \u2192 15:* Bat's Wing x75, Ancient Bird's Feather x50, Bewitching Wings x30, Great Feather x8"
      elsif k[2][1]=='Event Altar' && !k[5].nil? && k[5].length>0
        m=[3,5,7,10,12,15,18,21,25,30,50,70,90,120,150,180,210,250,300,350,400,450,500,550,600,700,800,900,1000]
        for i in 0...m.length
          str="#{str}\n*Level #{i+1} \u2192 #{i+2}:* #{k[5]} x#{m[i]}"
        end
      end
    elsif k[2][0]=='Dragon'
      if k[2][1]=='Fafnir'
        m=k[0].gsub('Fafnir Statue (','').gsub(')','')
        m2='x'
        m2='Scald' if m=='Flame'
        m2='Squall' if m=='Wind'
        str="*Level 1 \u2192 3 (per level):* #{m}wyrm's Greatsphere x3"
        str="#{str}\n*Level 3 \u2192 5 (per level):* #{m}wyrm's Greatsphere x5"
        str="#{str}\n*Level 5 \u2192 8 (per level):* #{m}wyrm's Greatsphere x7, #{m}wyrm's #{m2}scale x5, Talonstone x10"
        str="#{str}\n*Level 8 \u2192 10 (per level):* #{m}wyrm's Greatsphere x10, #{m}wyrm's #{m2}scale x5, Talonstone x10"
        str="#{str}\n*Level 10 \u2192 13 (per level):* #{m}wyrm's Greatsphere x12, #{m}wyrm's #{m2}scale x10, Talonstone x20"
        str="#{str}\n*Level 13 \u2192 15 (per level):* #{m}wyrm's Greatsphere x15, #{m}wyrm's #{m2}scale x10, Talonstone x20"
        str="#{str}\n*Level 15 \u2192 18 (per level):* #{m}wyrm's Greatsphere x20, #{m}wyrm's #{m2}scale x20, Talonstone x30"
        str="#{str}\n*Level 18 \u2192 20 (per level):* #{m}wyrm's Greatsphere x30, #{m}wyrm's #{m2}scale x20, Talonstone x30"
        str="#{str}\n*Level 20 \u2192 23 (per level):* #{m}wyrm's Greatsphere x40, #{m}wyrm's #{m2}scale x30, Talonstone x40"
        str="#{str}\n*Level 23 \u2192 25 (per level):* #{m}wyrm's Greatsphere x50, #{m}wyrm's #{m2}scale x30, Talonstone x40"
        str="#{str}\n*Level 25 \u2192 28 (per level):* #{m}wyrm's Greatsphere x60, #{m}wyrm's #{m2}scale x50, Talonstone x60"
        str="#{str}\n*Level 28 \u2192 30 (per level):* #{m}wyrm's Greatsphere x70, #{m}wyrm's #{m2}scale x50, Talonstone x60"
      elsif k[2][1]=='Dracolith'
        str="*Level 1 \u2192 3 (per level):* ~~no mats~~"
        m=[[5,3,1],[10,4,1],[15,5,1],[20,6,3],[25,7,3],[30,8,3],[35,10,3],[40,15,5],[50,20,5],[60,25,5],[90,30,8],[120,40,8],[150,60,8],[200,80,10],
           [250,100,10],[300,120,10],[350,140,10]]
        m2=k[0].split(' ')[0]
        for i in 0...m.length
          str="#{str}\n*Level #{i+3} \u2192 #{i+4}:* #{m2}wyrm's Sphere x#{m[i][0]}, #{m2}wyrm's Scale x#{m[i][1]}, Talonstone x#{m[i][2]}"
        end
      end
    elsif k[0]=='Smithy'
      str="__**Can craft #{generate_rarity_row(3)} weapons**__"
      str="#{str}\n*Level 1 \u2192 2:* ~~no mats~~"
      str="#{str}\n*Level 2 \u2192 3:* Light Metal x3"
      str="#{str}\n\n__**Can craft #{generate_rarity_row(4)} weapons**__"
      str="#{str}\n*Level 3 \u2192 4:* Iron Ore x10, Fiend's Claw x10, Bat's Wing x10"
      str="#{str}\n*Level 4 \u2192 5:* Iron Ore x15, Fiend's Claw x15, Bat's Wing x15, Light Metal x15"
      str="#{str}\n*Level 5 \u2192 6:* Granite x10, Fiend's Horn x10, Ancient Bird's Feather x10"
      str="#{str}\n\n__**Can craft #{generate_rarity_row(5)} weapons**__"
      str="#{str}\n*Level 6 \u2192 7:* Granite x15, Fiend's Horn x15, Ancient Bird's Feather x15, Abyss Stone x15"
      str="#{str}\n*Level 7 \u2192 8:* Meteorite x10, Fiend's Eye x10, Bewitching Wings x10"
      str="#{str}\n*Level 8 \u2192 9:* Meteorite x15, Fiend's Eye x15, Bewitching Wings x15, Crimson Core x15"
      ftr='Each new level of smithy allows you to craft higher-tier weapons within the newest-allowed rarity bracket.'
    elsif k[0]=='Halidom'
      str="__*Level 1 \u2192 2*__\nRequires Facility level of 5"
      str="#{str}\n\n__*Level 2 \u2192 3*__\nRequires Facility level of 40\n<:Element_Wind:532106087948746763>Wind Orb x10, Storm Orb x1, Talonstone x3"
      str="#{str}\n\n__*Level 3 \u2192 4*__\nRequires Facility level of 100\n<:Element_Water:532106088221376522>Water Orb x20, Stream Orb x3, Deluge Orb x1, Talonstone x5"
      str="#{str}\n\n__*Level 4 \u2192 5*__\nRequires Facility level of 200\n<:Element_Flame:532106087952810005>Flame Orb x50, Blaze Orb x7, Inferno Orb x2, Talonstone x10"
      str="#{str}\n\n__*Level 5 \u2192 6*__\nRequires Facility level of 300\n<:Element_Light:532106088129101834>Light Orb x100, Radiance Orb x15, Refulgence Orb x3, Talonstone x15"
      str="#{str}\n\n__*Level 6 \u2192 7*__\nRequires Facility level of 400\n<:Element_Shadow:532106088154267658>Shadow Orb x150, Nightfall Orb x20, Nether Orb x4, Talonstone x20"
      str="#{str}\n\n__*Level 7 \u2192 8*__\nRequires Facility level of 550\n<:Element_Wind:532106087948746763>Wind Orb x200, Storm Orb x25, Maelstrom Orb x6, Talonstone x25"
      str="#{str}\n\n__*Level 8 \u2192 9*__\nRequires Facility level of 700\n<:Element_Water:532106088221376522>Water Orb x300, Stream Orb x40, Deluge Orb x9, Talonstone x30"
    elsif k[0]=='Dragontree'
      str="*Level 1 \u2192 3 (per level):* ~~no mats~~"
      str="#{str}\n*Level 3 \u2192 5 (per level):* Talonstone x1"
      str="#{str}\n*Level 5 \u2192 7 (per level):* Talonstone x2"
      str="#{str}\n*Level 7 \u2192 9 (per level):* Talonstone x3"
      str="#{str}\n*Level 9 \u2192 10:* Talonstone x4"
      str="#{str}\n*Level 10 \u2192 11:* Talonstone x5"
      str="#{str}\n*Level 11 \u2192 12:* Talonstone x6"
      str="#{str}\n*Level 12 \u2192 13:* Talonstone x8"
      str="#{str}\n*Level 13 \u2192 14:* Talonstone x9"
      str="#{str}\n*Level 14 \u2192 15:* Talonstone x10"
      str="#{str}\n*Level 15 \u2192 16:* Talonstone x12"
      str="#{str}\n*Level 16 \u2192 17:* Talonstone x13"
      str="#{str}\n*Level 17 \u2192 18:* Talonstone x14"
      str="#{str}\n*Level 18 \u2192 19:* Talonstone x16"
      str="#{str}\n*Level 19 \u2192 20:* Talonstone x17"
      str="#{str}\n*Level 20 \u2192 21:* Talonstone x18"
      str="#{str}\n*Level 21 \u2192 22:* Talonstone x20"
      str="#{str}\n*Level 22 \u2192 23:* Talonstone x21"
      str="#{str}\n*Level 23 \u2192 24:* Talonstone x22"
      str="#{str}\n*Level 24 \u2192 25:* Talonstone x24"
      str="#{str}\n*Level 25 \u2192 26:* Talonstone x25"
      str="#{str}\n*Level 26 \u2192 27:* Talonstone x26"
    elsif k[0]=='Rupie Mine'
      str="*Level 1 \u2192 5 (per level):* ~~no mats~~"
      str="#{str}\n*Level 5 \u2192 8 (per level):* Light Orb x1"
      str="#{str}\n*Level 8 \u2192 10 (per level):* Light Orb x2"
      str="#{str}\n*Level 10 \u2192 13 (per level):* Light Orb x3"
      str="#{str}\n*Level 13 \u2192 15 (per level):* Light Orb x5"
      str="#{str}\n*Level 15 \u2192 18 (per level):* Light Orb x8, Radiance Orb x1"
      str="#{str}\n*Level 18 \u2192 20 (per level):* Light Orb x10, Radiance Orb x1"
      str="#{str}\n*Level 20 \u2192 23 (per level):* Light Orb x15, Radiance Orb x2"
      str="#{str}\n*Level 23 \u2192 25 (per level):* Light Orb x20, Radiance Orb x2"
      str="#{str}\n*Level 25 \u2192 28 (per level):* Light Orb x30, Radiance Orb x3, Refulgence Orb x1"
      str="#{str}\n*Level 28 \u2192 30 (per level):* Light Orb x40, Radiance Orb x3, Refulgence Orb x1"
    elsif !k[5].nil? && k[5].length>0
      str=k[5].gsub('/n',"\n").gsub('/>'," \u2192 ").gsub('/a'," \u2192 ").gsub('/u'," \u2192 ")
    end
    create_embed(event,'',str,0x8BE3F7,ftr) if str.length>0
  end
end

def disp_mat_data(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_mat,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  s2s=false if @shardizard==4 && evn.include?('smol')
  str=generate_rarity_row(k[1])
  if k[2]==101
    str="#{str}\n**Type:** Upgrade\n**Subtype:** Adventurer"
  elsif k[2]==102
    str="#{str}\n**Type:** Upgrade\n**Subtype:** Dragon"
  elsif k[2]==103
    str="#{str}\n**Type:** Upgrade\n**Subtype:** Weapon"
  elsif k[2]==104
    str="#{str}\n**Type:** Upgrade\n**Subtype:** Facility"
  elsif k[2]==111
    str="#{str}\n**Type:** Unbind\n**Subtype:** Dragon"
  elsif k[2]==112
    str="#{str}\n**Type:** Unbind\n**Subtype:** Weapon"
  elsif k[2]==113
    str="#{str}\n**Type:** Upgrade\n**Subtype:** Wyrmprint"
  elsif k[2]==114
    str="#{str}\n**Type:** Unbind\n**Subtype:** Wyrmprint"
  else
    str="#{str}\n**Type:** Misc."
  end
  str="#{str}\n**Drop bag:** #{['<:Rarity_3:532086056519204864> Common','<:Rarity_5:532086056737177600> Rare'][k[6]]}" unless k[2]==0
  str="#{str}\n\n**Description:** #{k[3].gsub(';; ',"\n")}"
  str="#{str}\n**EXP:** #{longFormattedNumber(k[7])}" unless k[7]<=0
  str="#{str}\n\n**Ways to obtain:**\n#{k[4].join("\n")}"
  str="#{str}\n\n**Uses:**\n#{k[5].join("\n")}" if s2s
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Mats/#{k[0].gsub(' ','_')}.png"
  flds=nil
  flds=triple_finish(k[8].sort,true) if args.include?('tag') || args.include?('tags')
  flds=nil unless s2s
  f=0
  f=flds.map{|q| q[1]}.join("\n").length+"\n\n**searching tags:**".length unless flds.nil?
  if str.length+f>=1800
    str=str.split("\n\n")
    str[0]="#{str[0]}\n\n#{str[1]}"
    str[1]=nil
    str.compact!
    if s2s
      create_embed(event,"__**#{k[0]}**__",str[0],0xE3F78B,nil,xpic)
      if str.length>=3 && "#{str[1]}\n\n#{str[2]}".length<1900
        create_embed(event,'',"#{str[1]}\n\n#{str[2]}",0xE3F78B)
      else
        create_embed(event,'',str[1],0xE3F78B)
        create_embed(event,'',str[2],0xE3F78B) if str.length>=3
      end
      create_embed(event,'','Searching tags',0xE3F78B,nil,nil,flds) unless flds.nil?
    else
      create_embed(event,"__**#{k[0]}**__","#{str[0]}#{"\n\n**Searching Tags:**" unless flds.nil?}",0xE3F78B,'For obtainment methods, please use this command in PM.  Including them made this reply too long.',xpic,flds)
    end
  else
    create_embed(event,"__**#{k[0]}**__","#{str}#{"\n\n**Searching Tags:**" unless flds.nil?}",0xE3F78B,nil,xpic,flds)
  end
end  

def disp_adventurer_art(bot,event,args=nil)
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
  lookout=[]
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt')
    lookout=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt').each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Art' && q[2]!='Art/Adventurer'}
  for i in 0...args.length
    rar=args[i].to_i if rar==0 && args[i].to_i.to_s==args[i] && args[i].to_i>2 && args[i].to_i<6
    rar=args[i].to_i if rar==0 && args[i][1,1]=='*' && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>2 && args[i][0,1].to_i<6
    for j in 0...lookout.length
      rar=lookout[j][0] if [0,1,2,3,4,5].include?(rar) && lookout[j][1].include?(args[i].downcase)
    end
  end
  if rar.is_a?(String)
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Adventurers/#{k[0].gsub(' ','_')}_#{rar}.png"
    IO.copy_stream(open(art), "C:/Users/Mini-Matt/Desktop/devkit/DLTemp#{@shardizard}.png") rescue m=true
    if File.size("C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png")<=100 || m
      rar=k[1][0,1].to_i
      disp="#{generate_rarity_row(rar,true)}"
    else
      disp="#{rar} design"
    end
  else
    rar=k[1][0,1].to_i if rar<k[1][0,1].to_i || rar>5
    disp="#{generate_rarity_row(rar,true)}"
  end
  art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Adventurers/#{k[0].gsub(' ','_')}_#{rar}.png"
  if args.include?('just') || args.include?('justart') || args.include?('blank') || args.include?('noinfo')
    charsx=[[],[],[]]
  else
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
    if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt')
      b=[]
      File.open('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt').each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      if !b[i][7].nil? && b[i][7].length>0 && !b[i][8].nil? && b[i][8].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[English]*") if b[i][7].split(' as ')[0]==k[11] && b[i][8].split(' as ')[0]!=k[10]
        charsx[1].push("*[FEH]* #{b[i][0]} *[Japanese]*") if b[i][8].split(' as ')[0]==k[10] && b[i][7].split(' as ')[0]!=k[11]
        charsx[1].push("*[FEH]* #{b[i][0]} *[Both]*") if b[i][8].split(' as ')[0]==k[10] && b[i][7].split(' as ')[0]==k[11]
      elsif !b[i][7].nil? && b[i][7].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[English]*") if b[i][7].split(' as ')[0]==k[11]
      elsif !b[i][8].nil? && b[i][8].length>0
        charsx[1].push("*[FEH]* #{b[i][0]} *[Japanese]*") if b[i][8].split(' as ')[0]==k[10]
      end
    end
    if event.server.nil? || !bot.user(502288364838322176).on(event.server.id).nil? || @shardizard==4
      if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOServants.txt')
        b=[]
        File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOServants.txt').each_line do |line|
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
    if flds.length.zero?
      flds=nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1500 && safe_to_spam?(event)
      event.channel.send_embed("__**#{k[0]}**__#{adv_emoji(k,bot)}") do |embed|
        embed.description=disp
        embed.color=element_color(k[2][1])
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: art)
      end
      if flds.map{|q| q.join("\n")}.join("\n\n").length>=1900
        for i in 0...flds.length
          event.channel.send_embed('') do |embed|
            embed.color=element_color(k[2][1])
            embed.add_field(name: flds[i][0], value: flds[i][1], inline: true)
          end
        end
      else
        event.channel.send_embed('') do |embed|
          embed.color=element_color(k[2][1])
          unless flds.nil?
            for i in 0...flds.length
              embed.add_field(name: flds[i][0], value: flds[i][1], inline: true)
            end
          end
        end
      end
      return nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1800
      disp="#{disp}\nThe list of units with the same VA is so long that I cannot fit it into a single embed. Please use this command in PM."
      flds=nil
    else
      flds[-1][2]=nil if flds.length<3
      flds[-1].compact!
    end
    event.channel.send_embed("__**#{k[0]}**#{adv_emoji(k,bot)}__") do |embed|
      embed.description=disp
      embed.color=element_color(k[2][1])
      unless flds.nil?
        for i in 0...flds.length
          embed.add_field(name: flds[i][0], value: flds[i][1], inline: flds[i][2].nil?)
        end
      end
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: art)
    end
  end
end

def disp_dragon_art(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.map{|q| q.downcase}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_dragon,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  s2s=false if @shardizard==4 && event.message.text.downcase.split(' ').include?('smol')
  disp=''
  lookout=[]
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt')
    lookout=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt').each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Art' && q[2]!='Art/Dragon'}
  for i in 0...args.length
    for j in 0...lookout.length
      rar=lookout[j][0] if rar.nil? && lookout[j][1].include?(args[i].downcase)
    end
  end
  puts rar
  rar='Human' if rar.nil? && k[0]=='Brunhilda' && args.include?('mym')
  if !rar.nil? && rar.is_a?(String)
    art="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Dragons/#{k[0].gsub(' ','_')}#{"_#{rar}" unless rar.nil?}.png"
    IO.copy_stream(open(art), "C:/Users/Mini-Matt/Desktop/devkit/DLTemp#{@shardizard}.png") rescue m=true
    if File.size("C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png")<=100 || m
      rar=nil
    else
      disp="#{rar} design"
    end
  end
  if args.include?('just') || args.include?('justart') || args.include?('blank') || args.include?('noinfo')
    charsx=[[],[],[]]
  else
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
    if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt')
      b=[]
      File.open('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt').each_line do |line|
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
      if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOServants.txt')
        b=[]
        File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOServants.txt').each_line do |line|
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
    if flds.length.zero?
      flds=nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1500 && safe_to_spam?(event)
      event.channel.send_embed("__**#{k[0]}**__#{dragon_emoji(k,bot)}") do |embed|
        embed.description=disp
        embed.color=element_color(k[2])
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: art)
      end
      if flds.map{|q| q.join("\n")}.join("\n\n").length>=1900
        for i in 0...flds.length
          event.channel.send_embed('') do |embed|
            embed.color=element_color(k[2])
            embed.add_field(name: flds[i][0], value: flds[i][1], inline: true)
          end
        end
      else
        event.channel.send_embed('') do |embed|
          embed.color=element_color(k[2])
          unless flds.nil?
            for i in 0...flds.length
              embed.add_field(name: flds[i][0], value: flds[i][1], inline: true)
            end
          end
        end
      end
      return nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1800
      disp="#{disp}\nThe list of units with the same VA is so long that I cannot fit it into a single embed. Please use this command in PM."
      flds=nil
    else
      flds[-1][2]=nil if flds.length<3
      flds[-1].compact!
    end
    event.channel.send_embed("__**#{k[0]}**#{dragon_emoji(k,bot)}__") do |embed|
      embed.description=disp
      embed.color=element_color(k[2])
      unless flds.nil?
        for i in 0...flds.length
          embed.add_field(name: flds[i][0], value: flds[i][1], inline: flds[i][2].nil?)
        end
      end
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: art)
    end
  end
end

def disp_wyrmprint_art(bot,event,args=nil)
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
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Wyrmprints/#{k[0].gsub(' ','_')}_1.png"
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Wyrmprints/#{k[0].gsub(' ','_')}_2.png" if has_any?(['mub','unbind','unbound','refined'],evn)
  str=generate_rarity_row(k[1][0,1].to_i)
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2]}"}
  str="#{str}\n#{moji[0].mention unless moji.length<=0} **Amulet Type:** #{k[2]}"
  xcolor=0x313439
  xcolor=0x5A0408 if k[2]=='Attack'
  xcolor=0x00205A if k[2]=='Defense'
  xcolor=0x39045A if k[2]=='Support'
  xcolor=0x005918 if k[2]=='Healing'
  disp=''
  if args.include?('just') || args.include?('justart') || args.include?('blank') || args.include?('noinfo')
    charsx=[[],[],[]]
  else
    nammes=['','','']
    unless k[7].nil? || k[7].length<=0
      m=k[7].split(' as ')
      nammes[0]=m[0]
      disp="#{disp}\n**Artist:** #{m[m.length-1]}"
    end
    charsx=[[],[],[]]
    chars=@wyrmprints.reject{|q| q[0]==k[0] || ((q[7].nil? || q[7].length<=0))}
    for i in 0...chars.length
      x=chars[i]
      unless x[7].nil? || x[7].length<=0
        m=x[7].split(' as ')
        charsx[0].push("#{x[0]}") if m[0]==nammes[0]
      end
    end
    if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt')
      b=[]
      File.open('C:/Users/Mini-Matt/Desktop/devkit/FEHUnits.txt').each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      if !b[i][6].nil? && b[i][6].length>0
        charsx[0].push("*[FEH]* #{b[i][0]}") if b[i][6].split(' as ')[0]==nammes[0]
      end
    end
    if event.server.nil? || !bot.user(502288364838322176).on(event.server.id).nil? || @shardizard==4
      if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOServants.txt')
        b=[]
        File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOServants.txt').each_line do |line|
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
      if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/FGOCraftEssances.txt')
        b=[]
        File.open('C:/Users/Mini-Matt/Desktop/devkit/FGOCraftEssances.txt').each_line do |line|
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
    disp=dispx if disp.length>=1900
    event.respond "#{disp}\n\n#{xpic}"
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
    if flds.length.zero?
      flds=nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1500 && safe_to_spam?(event)
      event.channel.send_embed("__**#{k[0]}**__#{print_emoji(k,bot)}") do |embed|
        embed.description=disp
        embed.color=xcolor
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: xpic)
      end
      if flds.map{|q| q.join("\n")}.join("\n\n").length>=1900
        for i in 0...flds.length
          event.channel.send_embed('') do |embed|
            embed.color=xcolor
            embed.add_field(name: flds[i][0], value: flds[i][1], inline: true)
          end
        end
      else
        event.channel.send_embed('') do |embed|
          embed.color=xcolor
          unless flds.nil?
            for i in 0...flds.length
              embed.add_field(name: flds[i][0], value: flds[i][1], inline: true)
            end
          end
        end
      end
      return nil
    elsif flds.map{|q| q.join("\n")}.join("\n\n").length>=1800
      disp="#{disp}\nThe list of units with the same VA is so long that I cannot fit it into a single embed. Please use this command in PM."
      flds=nil
    else
      flds[-1][2]=nil if flds.length<3
      flds[-1].compact!
    end
    event.channel.send_embed("__**#{k[0]}**#{print_emoji(k,bot)}__") do |embed|
      embed.description=disp
      embed.color=xcolor
      unless flds.nil?
        for i in 0...flds.length
          embed.add_field(name: flds[i][0], value: flds[i][1], inline: flds[i][2].nil?)
        end
      end
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: xpic)
    end
  end
end

def disp_boss_art(bot,event,args=nil)
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
  s2s=false if @shardizard==4 && evn.include?('smol')
  xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/Bosses/#{k[0].gsub(' ','_')}.png"
  xcolor=0xE3F78B
  xcolor=0xEF8663 if k[2][1]=='Thaumian'
  xcolor=0x5AD363 if k[2][1]=='Physian'
  xcolor=0xAD9087 if k[2][1]=='Therion'
  xcolor=0x271B2F if k[2][1]=='Dragon'
  xcolor=0x3B4DBB if k[2][1]=='Demon'
  xcolor=0x495218 if k[2][1]=='Demihuman'
  xcolor=0x495218 if k[2][1]=='Human'
  xcolor=0xAD82DE if k[2][1]=='Undead'
  str="__**#{k[0]}**__"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0].gsub('None','Null')}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{k[2][1]}"}
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  str2=''
  m=false
  IO.copy_stream(open(art), "C:/Users/Mini-Matt/Desktop/devkit/DLTemp#{@shardizard}.png") rescue m=true
  str2='No art found' if File.size("C:/Users/Mini-Matt/Desktop/devkit/FGOTemp#{@shardizard}.png")<=100 || m
  create_embed(event,str,str2,xcolor,nil,[nil,xpic])
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
  k=find_data_ex(:find_adventurer,args.join(' '),event,true)
  if k.length.zero?
    k=find_data_ex(:find_dragon,args.join(' '),event,true)
    if k.length.zero?
      k=find_data_ex(:find_wyrmprint,args.join(' '),event,true)
      if k.length.zero?
        k=find_data_ex(:find_adventurer,args.join(' '),event)
        if k.length.zero?
          k=find_data_ex(:find_dragon,args.join(' '),event)
          if k.length.zero?
            k=find_data_ex(:find_wyrmprint,args.join(' '),event)
            if k.length.zero?
              event.respond "No matches found.\n\nThis command can cover:\n- Adventurers\n- Dragons\n- Wyrmprints"
              return nil
            else
              p=[3,'Wyrmprint']
              xcolor=0x5A0408 if k[2]=='Attack'
              xcolor=0x00205A if k[2]=='Defense'
              xcolor=0x39045A if k[2]=='Support'
              xcolor=0x005918 if k[2]=='Healing'
              xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Wyrmprints/#{k[0].gsub(' ','_')}_1.png"
              xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Wyrmprints/#{k[0].gsub(' ','_')}_2.png" if has_any?(['mub','unbind','unbound','refined'],evn)
            end
          else
            p=[2,'Dragon']
            xcolor=element_color(k[2])
            xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Dragons/#{k[0].gsub(' ','_')}.png"
          end
        else
          p=[1,'Adventurer']
          xcolor=element_color(k[2][1])
          xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Adventurers/#{k[0].gsub(' ','_')}_#{k[1][0,1]}.png"
        end
      else
        p=[3,'Wyrmprint']
        xcolor=0x5A0408 if k[2]=='Attack'
        xcolor=0x00205A if k[2]=='Defense'
        xcolor=0x39045A if k[2]=='Support'
        xcolor=0x005918 if k[2]=='Healing'
        xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Wyrmprints/#{k[0].gsub(' ','_')}_1.png"
        xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Wyrmprints/#{k[0].gsub(' ','_')}_2.png" if has_any?(['mub','unbind','unbound','refined'],evn)
      end
    else
      p=[2,'Dragon']
      xcolor=element_color(k[2])
      xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Dragons/#{k[0].gsub(' ','_')}.png"
    end
  else
    p=[1,'Adventurer']
    xcolor=element_color(k[2][1])
    xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Adventurers/#{k[0].gsub(' ','_')}_#{k[1][0,1]}.png"
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  s2s=false if @shardizard==4 && evn.include?('smol')
  bnr=[]
  bbb=@banners.map{|q| q}
  bnr.push("*Launch #{p[1]}*") if bbb[0][p[0]].include?(k[0])
  for i in 1...bbb.length
    if bbb[i][p[0]].include?(k[0])
      str="#{'*Banner Name:* ' if s2s}#{bbb[i][0]}"
      kk=bbb[i][4].map{|q| q.split('/')}.map{|q| "#{q[0]}#{['','Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'][q[1].to_i]}#{q[2]}"}
      if s2s
        str="#{str}\n*Real-world date:* #{kk[0]} - #{kk[1]}"
        str="#{str}\n*Focus Adventurers:* #{bbb[i][1].reject{|q| q==k[0]}.sort.join(', ')}" unless bbb[i][1]==['-'] || bbb[i][1].reject{|q| q==k[0]}.length<=0
        str="#{str}\n*Focus Dragons:* #{bbb[i][2].reject{|q| q==k[0]}.sort.join(', ')}" unless bbb[i][2]==['-'] || bbb[i][2].reject{|q| q==k[0]}.length<=0
        str="#{str}\n*Focus Wyrmprints:* #{bbb[i][3].reject{|q| q==k[0]}.sort.join(', ')}" unless bbb[i][3]==['-'] || bbb[i][3].reject{|q| q==k[0]}.length<=0
      else
        str="*#{str}*  (#{kk[0]}-#{kk[1]})"
      end
      bnr.push(str)
    end
  end
  if bnr.length>0
    bnr[0]="__**Debut Banner**__\n#{bnr[0]}"
    bnr[1]="#{"\n" unless s2s}__**Other Banners**__\n#{bnr[1]}" if bnr.length>1
  else
    bnr.push('~~None~~')
  end
  if "__**#{k[0]}**'s Banners__".length+bnr.join("#{"\n" if s2s}\n").length>=1900
    str="__**#{k[0]}**'s Banners__"
    for i in 0...bnr.length
      str=extend_message(event,str,bnr[i],2) if s2s
      str=extend_message(event,str,bnr[i]) unless s2s
    end
    event.respond str
  else
    create_embed(event,"__**#{k[0]}**'s Banners__",bnr.join("#{"\n" if s2s}\n"),xcolor,nil,xpic)
  end
end

def find_in_adventurers(bot,event,args=nil,mode=0)
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
  lookout=[]
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt')
    lookout=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt').each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Skill'}
  for i in 0...args.length
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<6
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
    clzz.push('Healer') if ['heal','healing','heals','healer','healers'].include?(args[i].downcase)
    fltr.push('Welfare') if ['welfare','welfares','free','freebies','f2p'].include?(args[i].downcase)
    fltr.push('Story') if ['story','stories','storys'].include?(args[i].downcase)
    fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
    fltr.push('Zodiac Seasonal') if ['zodiac','zodiacs','seazonal','seazonals','seazons','seazons'].include?(args[i].downcase)
    fltr.push('Summon') if ['summon','summons','summonable','summonables'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  textra=''
  rarity.uniq!
  elem.uniq!
  wpn.uniq!
  clzz.uniq!
  tags.uniq!
  char=@adventurers.map{|q| q}.uniq
  search=[]
  emo=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[1][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][q]}"}.join(', ')}")
    emo.push(['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][rarity[0]]) if rarity.length<2
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
  if fltr.length>0
    m=[]
    if fltr.include?('Welfare')
      m.push('1w')
      m.push('2w')
      m.push('3w')
      m.push('4w')
      m.push('5w')
      emo.push('(w)') if fltr.length<2
    end
    if fltr.include?('Seasonal')
      m.push('1s')
      m.push('2s')
      m.push('3s')
      m.push('4s')
      m.push('5s')
      emo.push('(s)') if fltr.length<2
    end
    if fltr.include?('Zodiac Seasonal')
      m.push('1z')
      m.push('2z')
      m.push('3z')
      m.push('4z')
      m.push('5z')
      emo.push('(z)') if fltr.length<2
    end
    if fltr.include?('Story')
      m.push('1y')
      m.push('2y')
      m.push('3y')
      m.push('4y')
      m.push('5y')
      emo.push('(y)') if fltr.length<2
    end
    if fltr.include?('Summon')
      m.push('1')
      m.push('2')
      m.push('3')
      m.push('4')
      m.push('5')
      emo.push('(p)') if fltr.length<2
    end
    char=char.reject{|q| !m.include?(q[1])}.uniq
    search.push("*Filters*: #{fltr.join(', ')}")
  end
  if tags.length>0
    search.push("*Skill Tags*: #{tags.join(', ')}")
    sklz=@askilities.reject{|q| q[2]!='Skill'}
    for i in 0...char.length
      skl1=sklz[sklz.find_index{|q| q[2]=='Skill' && q[0]==char[i][6][0]}]
      skl2=sklz[sklz.find_index{|q| q[2]=='Skill' && q[0]==char[i][6][1]}]
      char[i][20]="#{skl1[10].join("\n")}\n#{skl2[10].join("\n")}".split("\n")
      if args.include?('any') || tags.length<=1
        char[i][0]="#{char[i][0]} *[S1]*" if has_any?(tags,skl1[10]) && !has_any?(tags,skl2[10])
        char[i][0]="#{char[i][0]} *[S2]*" if !has_any?(tags,skl1[10]) && has_any?(tags,skl2[10])
        char[i][0]="#{char[i][0]} *[S1/2]*" if has_any?(tags,skl1[10]) && has_any?(tags,skl2[10])
      end
    end
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for adventurers with any listed tag in their skills)" if tags.length>1
      char=char.reject{|q| !has_any?(tags,q[20])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for adventurers with all listed tags in their skills)" if tags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for adventurers with all listed tags.\nTo search for adventurers with any of the listed tags, perform the search again with the word \"any\" in your message." if tags.length>1
      for i in 0...tags.length
        char=char.reject{|q| !q[20].include?(tags[i])}.uniq
      end
    end
  end
  for i in 0...char.length
    char[i][0]="*#{char[i][0]}*" if char[i][1].length>1 && char[i][1][1,1]=='-'
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event)
    event.respond "Too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_in_dragons(bot,event,args=nil,mode=0)
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
  turn=[]
  ranged=[]
  tags=[]
  lookout=[]
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt')
    lookout=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt').each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Skill'}
  for i in 0...args.length
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<6
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
    wday.push(t.wday) if ['today','now'].include?(args[i].downcase)
    turn.push('Yes') if ['turn','damage'].include?(args[i].downcase)
    turn.push('No') if ['noturn','anchor'].include?(args[i].downcase)
    ranged.push('Yes') if ['long','longrange','ranged'].include?(args[i].downcase)
    ranged.push('no') if ['short','shortrange','melee'].include?(args[i].downcase)
    fltr.push('Welfare') if ['welfare','welfares','free','freebies','f2p'].include?(args[i].downcase)
    fltr.push('Story') if ['story','stories','storys'].include?(args[i].downcase)
    fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
    fltr.push('Zodiac Seasonal') if ['zodiac','zodiacs','seazonal','seazonals','seazons','seazons'].include?(args[i].downcase)
    fltr.push('Summon') if ['summon','summons','summonable','summonables'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  textra=''
  rarity.uniq!
  elem.uniq!
  wday.uniq!
  turn.uniq!
  ranged.uniq!
  fltr.uniq!
  tags.uniq!
  char=@dragons.map{|q| q}.uniq
  search=[]
  emo=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[1][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][q]}"}.join(', ')}")
    emo.push(['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][rarity[0]]) if rarity.length<2
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
      emo.push('(w)') if fltr.length<2
    end
    if fltr.include?('Seasonal')
      m.push('1s')
      m.push('2s')
      m.push('3s')
      m.push('4s')
      m.push('5s')
      emo.push('(s)') if fltr.length<2
    end
    if fltr.include?('Zodiac Seasonal')
      m.push('1z')
      m.push('2z')
      m.push('3z')
      m.push('4z')
      m.push('5z')
      emo.push('(z)') if fltr.length<2
    end
    if fltr.include?('Story')
      m.push('1y')
      m.push('2y')
      m.push('3y')
      m.push('4y')
      m.push('5y')
      emo.push('(y)') if fltr.length<2
    end
    if fltr.include?('Summon')
      m.push('1')
      m.push('2')
      m.push('3')
      m.push('4')
      m.push('5')
      emo.push('(p)') if fltr.length<2
    end
    char=char.reject{|q| !m.include?(q[1])}.uniq
    search.push("*Filters*: #{fltr.join(', ')}")
  end
  if tags.length>0
    search.push("*Skill Tags*: #{tags.join(', ')}")
    sklz=@askilities.reject{|q| q[2]!='Skill'}
    for i in 0...char.length
      skl1=sklz[sklz.find_index{|q| q[2]=='Skill' && q[0]==char[i][5]}]
      char[i][20]=skl1[10]
    end
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for dragons with any listed tag in their skills)" if tags.length>1
      char=char.reject{|q| !has_any?(tags,q[20])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for dragons with all listed tags in their skills)" if tags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for dragons with all listed tags.\nTo search for dragons with any of the listed tags, perform the search again with the word \"any\" in your message." if tags.length>1
      for i in 0...tags.length
        char=char.reject{|q| !q[20].include?(tags[i])}.uniq
      end
    end
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event)
    event.respond "Too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_in_wyrmprints(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  clzz=[]
  fltr=[]
  for i in 0...args.length
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<6
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
  emo=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[1][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][q]}"}.join(', ')}")
    emo.push(['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][rarity[0]]) if rarity.length<2
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
  if fltr.length>0
    m=[]
    if fltr.include?('Welfare')
      m.push('1w')
      m.push('2w')
      m.push('3w')
      m.push('4w')
      m.push('5w')
      emo.push('(w)') if fltr.length<2
    end
    if fltr.include?('Seasonal')
      m.push('1s')
      m.push('2s')
      m.push('3s')
      m.push('4s')
      m.push('5s')
      emo.push('(s)') if fltr.length<2
    end
    if fltr.include?('Zodiac Seasonal')
      m.push('1z')
      m.push('2z')
      m.push('3z')
      m.push('4z')
      m.push('5z')
      emo.push('(z)') if fltr.length<2
    end
    if fltr.include?('Story')
      m.push('1y')
      m.push('2y')
      m.push('3y')
      m.push('4y')
      m.push('5y')
      emo.push('(y)') if fltr.length<2
    end
    if fltr.include?('Summon')
      m.push('1')
      m.push('2')
      m.push('3')
      m.push('4')
      m.push('5')
      emo.push('(p)') if fltr.length<2
    end
    char=char.reject{|q| !m.include?(q[1])}.uniq
    search.push("*Filters*: #{fltr.join(', ')}")
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event)
    event.respond "Too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_in_weapons(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  elem=[]
  wpn=[]
  fltr=[]
  tags=[]
  lookout=[]
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt')
    lookout=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt').each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Skill'}
  for i in 0...args.length
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<6
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
    fltr.push('Starter') if ['starter','starters','start','starting'].include?(args[i].downcase)
    fltr.push('Story') if ['story','stories','storys'].include?(args[i].downcase)
    fltr.push('Seasonal') if ['seasonal','seasonals','seasons','seasons'].include?(args[i].downcase)
    fltr.push('Zodiac Seasonal') if ['zodiac','zodiacs','seazonal','seazonals','seazons','seazons'].include?(args[i].downcase)
    fltr.push('Summon') if ['summon','summons','summonable','summonables'].include?(args[i].downcase)
    fltr.push('Paid') if ['payment','paid','paying','whale'].include?(args[i].downcase)
    fltr.push('Void') if ['void'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  textra=''
  rarity.uniq!
  elem.uniq!
  wpn.uniq!
  fltr.uniq!
  tags.uniq!
  char=@weapons.map{|q| q}.uniq
  search=[]
  emo=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[2][0,1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][q]}"}.join(', ')}")
    emo.push(['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][rarity[0]]) if rarity.length<2
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
  if fltr.length>0
    m=[]
    if fltr.include?('Welfare')
      m.push('1w')
      m.push('2w')
      m.push('3w')
      m.push('4w')
      m.push('5w')
      emo.push('(w)') if fltr.length<2
    end
    if fltr.include?('Seasonal')
      m.push('1s')
      m.push('2s')
      m.push('3s')
      m.push('4s')
      m.push('5s')
      emo.push('(s)') if fltr.length<2
    end
    if fltr.include?('Zodiac Seasonal')
      m.push('1z')
      m.push('2z')
      m.push('3z')
      m.push('4z')
      m.push('5z')
      emo.push('(z)') if fltr.length<2
    end
    if fltr.include?('Story')
      m.push('1y')
      m.push('2y')
      m.push('3y')
      m.push('4y')
      m.push('5y')
      emo.push('(y)') if fltr.length<2
    end
    if fltr.include?('Starter')
      m.push('1e')
      m.push('2e')
      m.push('3e')
      m.push('4e')
      m.push('5e')
      emo.push('(e)') if fltr.length<2
    end
    if fltr.include?('Paid')
      m.push('1p')
      m.push('2p')
      m.push('3p')
      m.push('4p')
      m.push('5p')
      emo.push('(p)') if fltr.length<2
    end
    if fltr.include?('Void')
      m.push('1v')
      m.push('2v')
      m.push('3v')
      m.push('4v')
      m.push('5v')
      emo.push('(v)') if fltr.length<2
    end
    if fltr.include?('Summon')
      m.push('1')
      m.push('2')
      m.push('3')
      m.push('4')
      m.push('5')
      emo.push('(p)') if fltr.length<2
    end
    char=char.reject{|q| !m.include?(q[2])}.uniq
    search.push("*Filters*: #{fltr.join(', ')}")
  end
  if tags.length>0
    search.push("*Skill Tags*: #{tags.join(', ')}")
    sklz=@askilities.reject{|q| q[2]!='Skill'}
    for i in 0...char.length
      if char[i][6].nil? || char[i][6].length<=0
        char[i][20]=[]
      else
        skl1=sklz[sklz.find_index{|q| q[2]=='Skill' && q[0]==char[i][6]}]
        char[i][20]=skl1[10]
      end
    end
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for weapons with any listed tag in their skills)" if tags.length>1
      char=char.reject{|q| !has_any?(tags,q[20])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for weapons with all listed tags in their skills)" if tags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for weapons with all listed tags.\nTo search for weapons with any of the listed tags, perform the search again with the word \"any\" in your message." if tags.length>1
      for i in 0...tags.length
        char=char.reject{|q| !q[20].include?(tags[i])}.uniq
      end
    end
    if args.include?('any') || tags.length<=1
      for i in 0...char.length
        char[i][0]="#{char[i][0]} *[S3]*"
      end
    end
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length+emo.join('').length>=1900) && !safe_to_spam?(event)
    event.respond "Too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,char,emo,textra]
  end
end

def find_in_mats(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  pouch=[]
  tags=[]
  lookout=[]
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt')
    lookout=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt').each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Mat'}
  for i in 0...args.length
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>1 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>1 && args[i][0,1].to_i<6
    pouch.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>=0 && args[i].to_i<2
    pouch.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>=0 && args[i][0,1].to_i<2
    pouch.push(0) if ['common','commons'].include?(args[i])
    pouch.push(1) if ['rare','rares'].include?(args[i])
    for i2 in 0...lookout.length
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  rarity.uniq!
  pouch.uniq!
  tags.uniq!
  char=@mats.map{|q| q}
  textra=''
  search=[]
  if rarity.length>0
    char=char.reject{|q| !rarity.include?(q[1].to_i)}.uniq
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{['','<:Rarity_1:532086056594440231>','<:Rarity_2:532086056254963713>','<:Rarity_3:532086056519204864>','<:Rarity_4:532086056301101067>','<:Rarity_5:532086056737177600>'][q]}"}.join(', ')}")
  end
  if pouch.length>0
    char=char.reject{|q| !pouch.include?(q[6].to_i)}.uniq
    search.push("*Pouch Rarities*: #{pouch.map{|q| "#{['<:Rarity_3:532086056519204864> Common','<:Rarity_5:532086056737177600> Rare'][q]}"}.join(', ')}")
  end
  if tags.length>0
    search.push("*Tags*: #{tags.join(', ')}")
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for materials or items with any listed tag)" if tags.length>1
      char=char.reject{|q| !has_any?(tags,q[8])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for materials or items with all listed tags)" if tags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for materials and items with all listed tags.\nTo search for materials or items with any of the listed tags, perform the search again with the word \"any\" in your message." if tags.length>1
      for i in 0...tags.length
        char=char.reject{|q| !q[8].include?(tags[i])}.uniq
      end
    end
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length+textra.length>=1900) && !safe_to_spam?(event)
    event.respond "Too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,textra,char]
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
  char=char.sort{|a,b| a[0].gsub('*','')<=>b[0].gsub('*','')}.map{|q| q[0]}.uniq
  textra=k[3]
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
  textra=k[3]
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
  textra=k[3]
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
  textra=k[3]
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
    textra="**No weapons match your search**" if char.length<=0
    create_embed(event,"__**Weapons Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

def find_mats(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_mats(bot,event,args)
  return nil if k.nil?
  search=k[0]
  textra=k[1]
  char=k[2]
  char=char.sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length>=1900
    str="__**Material/Item Search**__\n#{search.join("\n")}#{"\n\n__**Notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    flds=nil
    flds=triple_finish(char) unless char.length<=0
    textra="#{textra}\n\n**No materials/items match your search**" if char.length<=0
    create_embed(event,"__**Material/Item Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

def find_all(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  adv=find_in_adventurers(bot,event,args,1)
  drg=find_in_dragons(bot,event,args,1)
  wrm=find_in_wyrmprints(bot,event,args,1)
  wpn=find_in_weapons(bot,event,args,1)
  adv=nil if adv[1].length>=@adventurers.length
  drg=nil if drg[1].length>=@dragons.length
  wrm=nil if wrm[1].length>=@wyrmprints.length
  wpn=nil if wpn[1].length>=@weapons.length
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
  adv[1]=adv[1].sort{|a,b| a[0].gsub('*','')<=>b[0].gsub('*','')}.map{|q| q[0]}.uniq
  drg[1]=drg[1].sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  wrm[1]=wrm[1].sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  wpn[1]=wpn[1].sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  search="#{adv[0].join("\n\n").gsub('adventurers','items')}\n\n#{drg[0].join("\n\n").gsub('dragons','items')}\n\n#{wrm[0].join("\n\n").gsub('wyrmprints','items')}\n\n#{wpn[0].join("\n\n").gsub('weapons','items')}".split("\n\n")
  search=search.reject{|q| count_in(search,q)<2}.uniq
  adv[0]=adv[0].reject{|q| search.include?(q.gsub('adventurers','items'))}
  drg[0]=drg[0].reject{|q| search.include?(q.gsub('dragons','items'))}
  wrm[1]=[] if wrm[0].length==1 && wrm[0][0][0,11]=='*Rarities*:' && search.length>1
  wrm[0]=wrm[0].reject{|q| search.include?(q.gsub('wyrmprints','items'))}
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
  textra="#{textra.join("\n\n")}\n\n#{adv[3].join("\n\n").gsub('adventurers','items')}\n\n#{drg[3].join("\n\n").gsub('dragons','items')}\n\n#{wrm[3].join("\n\n").gsub('wyrmprints','items')}\n\n#{wpn[3].join("\n\n").gsub('weapons','items')}"
  textra='' if textra.gsub("\n",'').length<=0
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || str.length+adv[1].join("\n").length+drg[1].join("\n").length+wrm[1].join("\n").length+wpn[1].join("\n").length+"Totals: #{adv[1].length} adventurers, #{drg[1].length} dragons, #{wrm[4]} wyrmprints#{' (not shown)' if wrm[4]>wrm[1].length}, #{wpn[1].length} weapons".length+textra.length>=1800
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
    str=extend_message(str,"Totals: #{adv[1].length} adventurers, #{drg[1].length} dragons, #{wrm[4]} wyrmprints#{' (not shown)' if wrm[4]>wrm[1].length}, #{wpn[1].length} weapons",event,2)
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
    create_embed(event,str,textra,0xCE456B,"Totals: #{adv[1].length} adventurers, #{drg[1].length} dragons, #{wrm[4]} wyrmprints#{' (not shown)' if wrm[4]>wrm[1].length}, #{wpn[1].length} weapons",nil,flds)
  end
end

def spaceship_order(x)
  return 1 if x=='Adventurer'
  return 2 if x=='Dragon'
  return 3 if x=='Wyrmprint'
  return 4 if x=='Weapon'
  return 5 if x=='Enemy'
  return 6 if x=='Skill'
  return 7 if x=='Ability'
  return 8 if x=='Facility'
  return 9 if x=='Material'
  return 1000
end

def add_new_alias(bot,event,newname=nil,unit=nil,modifier=nil,modifier2=nil,mode=0)
  data_load()
  nicknames_load()
  err=false
  str=''
  if newname.nil? || unit.nil?
    str="The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Enemies\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Facilities\n- Materials\n\nYou must specify both:\n- one of the above\n- an alias you wish to give that item"
    err=true
  elsif event.user.id != 167657750971547648 && event.server.nil?
    str='Only my developer is allowed to use this command in PM.'
    err=true
  elsif (!is_mod?(event.user,event.server,event.channel) && ![368976843883151362,195303206933233665].include?(event.user.id)) && event.channel.id != 532083509083373583
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
    str="The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Enemies\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Facilities\n- Materials\n\nNeither #{newname} nor #{unit} fall into any of these categories."
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
  else
    type=type.map{|q| q.gsub('*','')}
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
    elsif unit[0].is_a?(Array)
      dispstr=['Ability',unit[0][0],'Ability',unit[0][0]]
    else
      dispstr=['Ability',"#{unit[0]} #{unit[1]}",'Ability',"#{unit[0]} #{unit[1]}"]
    end
  elsif type[1]=='Facility'
    unit=find_facility(unit,event)
    dispstr=['Facility',unit[0],'Facility',unit[0]]
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
  if checkstr.downcase =~ /(7|t)+?h+?(o|0)+?(7|t)+?/
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
    elsif find_data_ex(:find_enemy,args.join(''),event).length>0
    elsif find_data_ex(:find_skill,args.join(''),event).length>0
    elsif find_data_ex(:find_ability,args.join(''),event).length>0
    elsif find_data_ex(:find_facility,args.join(''),event).length>0
    elsif find_data_ex(:find_mat,args.join(''),event).length>0
    elsif has_any?(args,['adventurer','adventurers','adv','advs','unit','units','dragon','dragons','wyrmprint','wyrm','print','wyrmprints','wyrms','prints','weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap','skill','skil','skills','skils','ability','abilitys','abilities','abil','abils','able','ables','facility','facilitys','facilities','faculty','facultys','faculties','mat','mats','material','materials','item','items','enemy','enemies','boss','bosss','bosses'])
    else
      event.respond "The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Enemies\n- Skills\n- Abilities\n- Auras\n- CoAbilities\n- Facilities\n- Materials\n\n#{args.join(' ')} does not fall into any of these categories."
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
  f=[]
  n=@aliases.reject{|q| q[0]!='Adventurer'}.map{|q| [q[1],q[2],q[3]]}
  h=''
  if adv.nil? && drg.nil? && wrm.nil? && wpn.nil? && enm.nil? && abl.nil? && abl.nil? && fac.nil? && mat.nil?
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
    elsif has_any?(args,['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'])
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
    elsif has_any?(args,['enemy','enemies','boss','bosss','bosses'])
      f.push('__**Enemy Aliases**__')
      n=@aliases.reject{|q| q[0]!='Enemy'}.map{|q| [q[1],q[2],q[3]]}
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
    elsif has_any?(args,['facility','facilitys','facilities','faculty','facultys','faculties'])
      f.push('__**Facility Aliases**__')
      n=@aliases.reject{|q| q[0]!='Facility'}.map{|q| [q[1],q[2],q[3]]}
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
    elsif has_any?(args,['mat','mats','material','materials','item','items'])
      f.push('__**Items Aliases**__')
      n=@aliases.reject{|q| q[0]!='Material'}.map{|q| [q[1],q[2],q[3]]}
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
        msg=extend_message(msg,'__**Enemy Aliases**__',event,2)
        n=@aliases.reject{|q| !['Enemy'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
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
        msg=extend_message(msg,'__**Facility Aliases**__',event,2)
        n=@aliases.reject{|q| !['Facility'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
        n=n.reject{|q| q[2].nil?} if mode==1
        for i in 0...n.length
          msg=extend_message(msg,"#{n[i][0]} = #{n[i][1]}#{' *(in this server only)*' unless n[i][2].nil? || mode==1}",event)
        end
        msg=extend_message(msg,'__**Item Aliases**__',event,2)
        n=@aliases.reject{|q| !['Material'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
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
      f.push("\n__**Enemy Aliases**__")
      n=@aliases.reject{|q| !['Enemy'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
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
      f.push("\n__**Facility Aliases**__")
      n=@aliases.reject{|q| !['Facility'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
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
      f.push("\n__**Item Aliases**__")
      n=@aliases.reject{|q| !['Material'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
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
    n=@aliases.reject{|q| !['Weapon'].include?(q[0])}.map{|q| [q[1],q[2],q[3]]}
    n=n.reject{|q| q[2].nil?} if mode==1
    f.push("__**#{wpn[0]}#{weapon_emoji(wpn,bot)}**__#{"'s server-specific aliases" if mode==1}")
    unless mode==1
      f.push(wpn[0].gsub(' ','').gsub('(','').gsub(')','').gsub('_','').gsub('!','').gsub('?','').gsub("'",'').gsub('"','')) if wpn[0].include?('(') || wpn[0].include?(')') || wpn[0].include?(' ') || wpn[0].include?('!') || wpn[0].include?('_') || wpn[0].include?('?') || wpn[0].include?("'") || wpn[0].include?('"')
      if wpn[2][1,1]!='v' && wpn[3]!='None'
        mnm=[wpn[3]]
        mnm.push('Fire') if wpn[3]=='Flame'
        mnm.push('Dark') if wpn[3]=='Shadow'
        for i in 0...mnm.length
          f.push("#{wpn[2][0,1]}\\*#{mnm[i]}#{wpn[1]}")
          f.push("#{wpn[2][0,1]}\\*#{wpn[1]}#{mnm[i]}")
          f.push("#{mnm[i]}#{wpn[2][0,1]}\\*#{wpn[1]}")
          f.push("#{wpn[1]}#{wpn[2][0,1]}\\*#{mnm[i]}")
          f.push("#{mnm[i]}#{wpn[1]}#{wpn[2][0,1]}\\*")
          f.push("#{wpn[1]}#{mnm[i]}#{wpn[2][0,1]}\\*")
        end
      elsif wpn[2][1,1]=='v' && wpn[3]!='None'
        mnm=[wpn[3]]
        mnm.push('Fire') if wpn[3]=='Flame'
        mnm.push('Dark') if wpn[3]=='Shadow'
        for i in 0...mnm.length
          f.push("Void#{wpn[2][0,1]}\\*#{mnm[i]}#{wpn[1]}")
          f.push("Void#{wpn[2][0,1]}\\*#{wpn[1]}#{mnm[i]}")
          f.push("Void#{mnm[i]}#{wpn[2][0,1]}\\*#{wpn[1]}")
          f.push("Void#{wpn[1]}#{wpn[2][0,1]}\\*#{mnm[i]}")
          f.push("Void#{mnm[i]}#{wpn[1]}#{wpn[2][0,1]}\\*")
          f.push("Void#{wpn[1]}#{mnm[i]}#{wpn[2][0,1]}\\*")
          f.push("#{wpn[2][0,1]}\\*Void#{mnm[i]}#{wpn[1]}")
          f.push("#{wpn[2][0,1]}\\*Void#{wpn[1]}#{mnm[i]}")
          f.push("#{mnm[i]}Void#{wpn[2][0,1]}\\*#{wpn[1]}")
          f.push("#{wpn[1]}Void#{wpn[2][0,1]}\\*#{mnm[i]}")
          f.push("#{mnm[i]}Void#{wpn[1]}#{wpn[2][0,1]}\\*")
          f.push("#{wpn[1]}Void#{mnm[i]}#{wpn[2][0,1]}\\*")
          f.push("#{wpn[2][0,1]}\\*#{mnm[i]}Void#{wpn[1]}")
          f.push("#{wpn[2][0,1]}\\*#{wpn[1]}Void#{mnm[i]}")
          f.push("#{mnm[i]}#{wpn[2][0,1]}\\*Void#{wpn[1]}")
          f.push("#{wpn[1]}#{wpn[2][0,1]}\\*Void#{mnm[i]}")
          f.push("#{mnm[i]}#{wpn[1]}Void#{wpn[2][0,1]}\\*")
          f.push("#{wpn[1]}#{mnm[i]}Void#{wpn[2][0,1]}\\*")
          f.push("#{wpn[2][0,1]}\\*#{mnm[i]}#{wpn[1]}Void")
          f.push("#{wpn[2][0,1]}\\*#{wpn[1]}#{mnm[i]}Void")
          f.push("#{mnm[i]}#{wpn[2][0,1]}\\*#{wpn[1]}Void")
          f.push("#{wpn[1]}#{wpn[2][0,1]}\\*#{mnm[i]}Void")
          f.push("#{mnm[i]}#{wpn[1]}#{wpn[2][0,1]}\\*Void")
          f.push("#{wpn[1]}#{mnm[i]}#{wpn[2][0,1]}\\*Void")
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
  elsif !fac.nil?
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
  end
  msg=''
  for i in 0...f.length
    msg=extend_message(msg,f[i],event)
  end
  event.respond msg
  return nil
end

def disp_date(t,mode=0)
  return "#{t.day}#{['','Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'][t.month]}#{t.year}" if mode==2
  return "#{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year}" if mode==1
  return "#{t.day} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][t.month]} #{t.year} (a #{['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'][t.wday]})"
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
  str="#{str}\nTime until High Dragon bonus chest reset: #{t4.join(', ')}"
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
  str="#{str}\nTime until Void Treasure Trade reset: #{t4.join(', ')}#{'~~' unless sftday==t.wday}"
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
    str="#{str}\nTime until High Dragon bonus chest reset, come tomorrow: #{t4.join(', ')}"
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
    str="#{str}\nTime until Void Treasure Trade reset, come tomorrow: #{t4.join(', ')}"
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
    str="#{str}\nTime until High Dragon bonus chest reset, come next #{str3.split(' ')[1]}: #{t4.join(', ')}"
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
    str="#{str}\nTime until Void Treasure Trade reset, come next #{str3.split(' ')[1]}: #{t4.join(', ')}"
  end
  str="#{str}\n\n__**#{"#{str3}'s " if str3.length>0}Expert Ruins:**__"
  str="#{str}\n*Open:* #{['<:Element_Null:532106087810334741>All','<:Element_Null:532106087810334741>All','<:Element_Flame:532106087952810005>Flamehowl','<:Element_Water:532106088221376522>Waterscour','<:Element_Wind:532106087948746763>Windmaul','<:Element_Light:532106088129101834>Lightsunder','<:Element_Shadow:532106088154267658>Shadowsteep'][t.wday]}"
  if t.wday>2
    str="#{str}\n*Available Orbs:* #{['All','All','Flame, Blaze, Inferno','Water, Stream, Deluge','Wind, Storm, Maelstorm','Light, Radiance, Refulgence','Shadow, Nightfull, Nether'][t.wday]}" if t.wday>1
    str="#{str}\n*Other Available Mats:* #{["Fiend's Horn, Fiend's Eye, Fiend's Claw, Ancient Bird's Feather, Bewitching Wing, Granite, Meteorite","Fiend's Horn, Fiend's Eye, Fiend's Claw, Ancient Bird's Feather, Bewitching Wing, Granite, Meteorite","Fiend's Horn, Fiend's Eye","Ancient Bird's Feather, Bewitching Wing",'Granite, Meteorite',"Fiend's Claw","Ancient Bird's Feather, Bewitching Wing"][t.wday]}" if t.wday>1
  end
  str="#{str}\n\n__**<:Element_Void:548467446734913536> #{"#{str3}'s " if str3.length>0}Void Strikes:**__"
  # <:Element_Flame:532106087952810005>Steel Golem
  # <:Element_Water:532106088221376522>
  # <:Element_Wind:532106087948746763>Void Zephyr
  # <:Element_Light:532106088129101834>Wandering Shroom
  # <:Element_Shadow:532106088154267658>Raging Manticore
  str="#{str}\n*Open:* #{['<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Flame:532106087952810005>Steel Golem, <:Element_Wind:532106087948746763>Void Zephyr','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Flame:532106087952810005>Steel Golem','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Shadow:532106088154267658>Raging Manticore','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Flame:532106087952810005>Steel Golem, <:Element_Wind:532106087948746763>Void Zephyr','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Shadow:532106088154267658>Raging Manticore','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Flame:532106087952810005>Steel Golem','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Shadow:532106088154267658>Raging Manticore, <:Element_Wind:532106087948746763>Void Zephyr'][t.wday]}"
  str="#{str}\n*Available Mats:* #{["Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Iron Ore, Steel Slab, Granite, Golem Core, Great Feather, Zephyr Rune","Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Iron Ore, Steel Slab, Granite, Golem Core","Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Raging Fang, Raging Tail, Fiend's Claw, Fiend's Horn","Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Iron Ore, Steel Slab, Granite, Golem Core, Great Feather, Zephyr Rune","Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Raging Fang, Raging Tail, Fiend's Claw, Fiend's Horn","Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Iron Ore, Steel Slab, Granite, Golem Core","Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Raging Fang, Raging Tail, Fiend's Claw, Fiend's Horn, Great Feather, Zephyr Rune"][t.wday]}"
  str="#{str}\n\n**Shop Mats:** #{['Light Metal, Abyss Stone','Iron Ore, Granite',"Fiend's Claw, Fiend's Horn","Bat Wing, Ancient Bird's Feather",'Iron Ore, Granite',"Fiend's Claw, Fiend's Horn","Bat Wing, Ancient Bird's Feather"][t.wday]}" if t.wday>-1
  str="#{str}\n\n**#{"#{str3}'s " if str3.length>0}Bond Gift:** #{['Golden Chalice','Juicy Meat','Kaleidoscope','Floral Circlet','Compelling Book','Mana Essence','Golden Chalice'][t.wday]}"
  if t.wday>0 && t.wday<6
    drg=@dragons.reject{|q| q[9]!=t.wday}
    m=[[generate_rarity_row(1),[]],[generate_rarity_row(2),[]],[generate_rarity_row(3),[]],[generate_rarity_row(4),[]],[generate_rarity_row(5),[]]]
    for i in 0...drg.length
      f="#{drg[i][0]}#{element_emote(drg[i][2],bot)}"
      m[0][1].push(f) if drg[i][1][0,1].to_i==1
      m[1][1].push(f) if drg[i][1][0,1].to_i==2
      m[2][1].push(f) if drg[i][1][0,1].to_i==3
      m[3][1].push(f) if drg[i][1][0,1].to_i==4
      m[4][1].push(f) if drg[i][1][0,1].to_i==5
    end
    m=m.reject{|q| q[1].length<=0}
    create_embed(event,str,'',0xCE456B,nil,nil,m.map{|q| [q[0],q[1].join("\n")]})
  else
    event.respond str
  end
end

def next_events(event,bot,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  args=args.map{|q| q.downcase}
  t=Time.now
  timeshift=7
  timeshift-=1 unless t.dst?
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
  end
  if mode==0 && !safe_to_spam?(event)
    event.respond "Please either specify an event type or use this command in PM.\n\nAvailable event types include:\n- Ruins\n- Mats\n- Shop\n- Bond items"
    return nil
  end
  if [1,0].include?(mode)
    ruin=['<:Element_Null:532106087810334741>All','<:Element_Null:532106087810334741>All','<:Element_Flame:532106087952810005>Flamehowl','<:Element_Water:532106088221376522>Waterscour','<:Element_Wind:532106087948746763>Windmaul','<:Element_Light:532106088129101834>Lightsunder','<:Element_Shadow:532106088154267658>Shadowsteep']
    ruin=ruin.rotate(t.wday)
    matz=["","","Flame/Blaze/Inferno Orbs, Fiend's Horn, Fiend's Eye","Water/Stream/Deluge Orbs, Ancient Bird's Feather, Bewitching Wing",
          "Wind/Storm/Maelstorm Orbs, Granite, Meteorite","Light/Radiance/Refulgence Orbs, Fiend's Claw",
          "Shadow/Nightfull/Nether Orbs, Ancient Bird's Feather, Bewitching Wing"]
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
  if [0,5].include?(mode)
    void=['<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Flame:532106087952810005>Steel Golem, <:Element_Wind:532106087948746763>Void Zephyr','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Flame:532106087952810005>Steel Golem','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Shadow:532106088154267658>Raging Manticore','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Flame:532106087952810005>Steel Golem, <:Element_Wind:532106087948746763>Void Zephyr','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Shadow:532106088154267658>Raging Manticore','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Flame:532106087952810005>Steel Golem','<:Element_Light:532106088129101834>Wandering Shroom, <:Element_Shadow:532106088154267658>Raging Manticore, <:Element_Wind:532106087948746763>Void Zephyr']
    void=void.rotate(t.wday)
    mmzz=[]
    for i in 0...void.length
      m=void[i].split(', ')
      pos=0
      for i2 in 0...m.length
        pos=1 if m[i2]=='<:Element_Flame:532106087952810005>Steel Golem'
        pos=2 if m[i2]=='<:Element_Water:532106088221376522>Water Void'
        pos=3 if m[i2]=='<:Element_Wind:532106087948746763>Void Zephyr'
        pos=4 if m[i2]=='<:Element_Light:532106088129101834>Wandering Shroom'
        pos=5 if m[i2]=='<:Element_Shadow:532106088154267658>Raging Manticore'
        mmzz.push([m[i2],i,pos])
        mmzz.push([m[i2],7,pos]) if i==0
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
    str2="__**<:Element_Void:548467446734913536> Void Strikes**__"
    strpost=false
    matz=['',"Iron Ore, Steel Slab, Granite, Void Leaf, Void Seed, Golem Core","","Great Feather, Void Leaf, Void Seed, Zephyr Rune",
          "Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore",
          "Raging Fang, Raging Tail, Void Leaf, Void Seed, Fiend's Claw, Fiend's Horn"]
    for i in 0...mmzz.length
      str2="#{str2}#{"\n" if mode==5 && safe_to_spam?(event)}\n*#{mmzz[i][0]}* -"
      if mmzz[i][1]==0
        str2="#{str2} **Today**#{' - Next available' unless mmzz[i][3].nil? || mmzz[i][3]<=0}"
        if mmzz[i][3].nil? || mmzz[i][3]<=0
        else
          t_d=t+mmzz[i][2]*24*60*60
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
      str2="#{str2}\n~~Available mats: #{matz[mmzz[i][2]]}~~" if mode==5 && safe_to_spam?(event)
      if mmzz[i][2]==1 && mmzz.find_index{|q| q[2]==2}.nil?
        str2="#{str2}#{"\n" if mode==5 && safe_to_spam?(event)}\n<:Element_Water:532106088221376522>*Water Void* - ~~never~~"
      end
    end
    str=extend_message(str,str2,event,2)
  end
  f=[0,2]
  if f.include?(mode)
    matz=["Flame/Blaze/Inferno Orbs, Fiend's Horn, Fiend's Eye, Water/Stream/Deluge Orbs, Ancient Bird's Feather, Bewitching Wing, Wind/Storm/Maelstorm Orbs, Granite, Meteorite, Light/Radiance/Refulgence Orbs, Fiend's Claw, Shadow/Nightfull/Nether Orbs",
          "Flame/Blaze/Inferno Orbs, Fiend's Horn, Fiend's Eye, Water/Stream/Deluge Orbs, Ancient Bird's Feather, Bewitching Wing, Wind/Storm/Maelstorm Orbs, Granite, Meteorite, Light/Radiance/Refulgence Orbs, Fiend's Claw, Shadow/Nightfull/Nether Orbs",
          "Flame/Blaze/Inferno Orbs, Fiend's Horn, Fiend's Eye","Water/Stream/Deluge Orbs, Ancient Bird's Feather, Bewitching Wing",
          "Wind/Storm/Maelstorm Orbs, Granite, Meteorite","Light/Radiance/Refulgence Orbs, Fiend's Claw",
          "Shadow/Nightfull/Nether Orbs, Ancient Bird's Feather, Bewitching Wing"]
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
    str=extend_message(str,str2,event,2)
  end
  f.push(6)
  if f.include?(mode)
    matz=["Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Iron Ore, Steel Slab, Granite, Golem Core, Great Feather, Zephyr Rune",
          "Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Iron Ore, Steel Slab, Granite, Golem Core",
          "Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Raging Fang, Raging Tail, Fiend's Claw, Fiend's Horn",
          "Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Iron Ore, Steel Slab, Granite, Golem Core, Great Feather, Zephyr Rune",
          "Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Raging Fang, Raging Tail, Fiend's Claw, Fiend's Horn",
          "Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Iron Ore, Steel Slab, Granite, Golem Core",
          "Bat's Wing, Solid Fungus, Ancient Bird's Feather, Void Leaf, Void Seed, Shiny Spore, Raging Fang, Raging Tail, Fiend's Claw, Fiend's Horn, Great Feather, Zephyr Rune"]
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
    str2="__**Materials** found in the Void Strikes__"
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

def focus_feed(favor,exp_target)
  t=Time.now
  timeshift=7
  timeshift-=1 unless t.dst?
  t-=60*60*timeshift
  exp=0
  days=0
  while exp<exp_target
    days+=1
    if t.wday==0 || t.wday==6
      exp+=2000
    elsif t.wday==favor
      exp+=1800
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
         [9500,121,99],[9700,121,99],[0,121,100]]
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
         3480,3500,3520,3540,3560,3580,3600,3620,0]
    str2="__**Adventurer EXP**__"
    if nums.length<=0
      m=axp[0,60].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level 1 to level 60:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
      m=axp[0,70].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level 1 to level 70:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
      m=axp[0,80].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level 1 to level 80:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
    elsif nums.length==1
      n=[nums[0],axp.length].min
      m=axp[0,n].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_1_Blank:532104334423621632> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,2)}"
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
      m=dxp[0,60].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level 1 to level 60:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
      m=dxp[0,80].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level 1 to level 80:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
      m=dxp[0,100].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level 1 to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
    elsif nums.length==1
      n=[nums[0],dxp.length].min
      m=dxp[0,n].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_1_Blank:532104334423621632> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,3)}"
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
    str2="#{str2}\nFocused feeding time shown for #{k[0]}, whose favored bondfood is #{['Golden Chalice (Sunday)','Juicy Meat (Monday)','Kaleidoscope (Tuesday)','Floral Circlet (Wednesday)','Compelling Book (Thursday)','Mana Essence (Friday)','Golden Chalice (Saturday)'][k[9]]}" if k.length>0
    if nums.length<=0
      m=bxp.map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n*To get from level 1 to level #{bxp.length}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
      str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
      str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k[9],m)} days starting from today" if k.length>0
      str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[bxp.length-1][1]-bxp[0][1])} additional seconds ~~(from #{bxp[0][1]} sec to #{bxp[bxp.length-1][1]} sec)~~"
    elsif nums.length==1
      n=[nums[0],bxp.length].min
      unless n==1
        m=bxp[0,n-1].map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}#{"\n" unless n==bxp.length}\n*To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
        str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
        str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k[9],m)} days starting from today" if k.length>0
        str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[n-1][1]-bxp[0][1])} additional seconds ~~(from #{bxp[0][1]} sec to #{bxp[n-1][1]} sec)~~"
      end
      unless n==bxp.length
        m=bxp[n-1,bxp.length-n].map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}#{"\n" unless n==1}\n*To get from level #{n} to level #{bxp.length}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
        str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
        str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k[9],m)} days starting from today" if k.length>0
        str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[bxp.length-1][1]-bxp[n-1][1])} additional seconds ~~(from #{bxp[n-1][1]} sec to #{bxp[bxp.length-1][1]} sec)~~"
      end
    else
      n=[nums[0,2].min,1].max
      n=1 if n>bxp.length
      n2=[nums[0,2].max,bxp.length].min
      m=bxp[n-1,n2-n].map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n*To get from level #{n} to level #{n2}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
      str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
      str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k[9],m)} days starting from today" if k.length>0
      str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[n2-1][1]-bxp[n-1][1])} additional seconds ~~(from #{bxp[n-1][1]} sec to #{bxp[n2-1][1]} sec)~~"
    end
    str2="#{str2}\n\nInclude a dragon's name to show focused feeding times." if k.length<=0
    str=extend_message(str,str2,event,2)
  end
  if [5,7,0].include?(mode)
    wrxp=[15,20,25,30,35,40,45,50,55,60,69,78,87,96,105,114,123,132,141,150,164,178,192,206,220,234,248,262,276,290,308,326,344,362,380,398,416,434,452,470,493,
          516,539,562,585,608,631,654,677,700,727,754,781,808,835,862,889,916,943,970,1004,1038,1072,1106,1140,1174,1208,1242,1276,1310,1355,1400,1445,1490,
          1535,1580,1625,1670,1715,1760,1816,1872,1928,1984,2040,2096,2152,2208,2264,2320,2388,2456,2524,2592,2660,2728,2796,2864,2932,0]
    str2="__**Wyrmprint EXP**__"
    if nums.length<=0
      m=wrxp[0,30].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_2:532086056254963713> *To get from level 1 to level 30:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,5)}"
      m=wrxp[0,60].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level 1 to level 60:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,5)}"
      m=wrxp[0,80].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level 1 to level 80:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,5)}"
      m=wrxp[0,100].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level 1 to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,5)}"
    elsif nums.length==1
      n=[nums[0],wrxp.length].min
      m=wrxp[0,n].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_1_Blank:532104334423621632> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,5)}"
      if n<30
        m=wrxp[n-1,30-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_2:532086056254963713> *To get from level #{n} to level 30:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,5)}"
      end
      if n<60
        m=wrxp[n-1,60-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_3:532086056519204864> *To get from level #{n} to level 60:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,5)}"
      end
      if n<80
        m=wrxp[n-1,80-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_4:532086056301101067> *To get from level #{n} to level 80:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,5)}"
      end
      if n<100
        m=wrxp[n-1,100-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}\n<:Rarity_5:532086056737177600> *To get from level #{n} to level 100:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,5)}"
      end
    else
      n=[nums[0,2].min,1].max
      n=1 if n>wrxp.length
      n2=[nums[0,2].max,wrxp.length].min
      m=wrxp[n-1,n2-n].map{|q| q*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n*To get from level #{n} to level #{n2}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,5)}"
    end
    str=extend_message(str,str2,event,2)
  end
  if [6,7,0].include?(mode)
    wrxp=[50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,155,165,175,185,195,205,215,225,235,245,260,275,290,305,320,335,350,365,380,
          395,425,455,485,515,545,575,605,635,665,695,730,765,800,835,870,905,940,975,1010,1045,1090,1135,1180,1225,1270,1315,1360,1405,1450,1495,1575,1655,
          1735,1815,1895,1975,2055,2135,2215,2295,2395,2495,2595,2695,2795,2895,2995,3095,3195,3295,3415,3535,3655,3775,3895,4015,4135,4255,4375,0]
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
    elsif nums.length==1
      n=[nums[0],wrxp.length].min
      m=wrxp[0,n].inject(0){|sum,x| sum + x }
      str2="#{str2}\n<:Rarity_1_Blank:532104334423621632> *To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
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
    else
      n=[nums[0,2].min,1].max
      n=1 if n>wrxp.length
      n2=[nums[0,2].max,wrxp.length].min
      m=wrxp[n-1,n2-n].inject(0){|sum,x| sum + x }
      str2="#{str2}\n*To get from level #{n} to level #{n2}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP  \u200B  \u200B  #{exp_shift(m,6)}"
    end
    str=extend_message(str,str2,event,2)
  end
  event.respond str
end

def find_adv_alts(event,args,bot)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_adventurer,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  name=k[9][0].gsub('*','')
  k=@adventurers.reject{|q| q[9][0].gsub('*','')!=name}.uniq
  untz2=[]
  color=[]
  for i in 0...k.length
    color.push(element_color(k[i][2][1]))
    m=[]
    m.push('default') if k[i][0]==k[i][9][0] || k[i][9][0][k[i][9][0].length-1,1]=='*'
    m.push('default') if k[i][9][0][0,1]=='*' && k[i][9].length>1
    m.push('sensible') if k[i][9][0][0,1]=='*' && k[i][9].length<2
    m.push('seasonal') if k[i][1][1,1]=='s'
    m.push('out-of-left-field') if m.length<=0
    n=''
    unless k[i][0]==k[i][9] || k[i][9][k[i][9].length-1,1]=='*'
      k2=k.reject{|q| q[9][0].gsub('*','')!=k[i][9][0].gsub('*','') || q[0]==k[i][0] || !(q[0]==q[9][0] || q[9][0].include?('*'))}
      n='x' if k2.length<=0
    end
    untz2.push(["#{k[i][0]}#{adv_emoji(k[i],bot)} - #{m.uniq.join(', ')}",k[i][9].map{|q| q.gsub('*','')}])
  end
  if color.length.zero?
    color=0xFFD800
  else
    color=avg_color(color)
  end
  k2=k.map{|q| q[9].length}
  if k2.max>1
    k2=k.map{|q| q[9][1]}.uniq.map{|q| ["#{name}(#{q})",[],q]}
    for i in 0...untz2.length
      for j in 0...k2.length
        k2[j][1].push(untz2[i][0]) if k2[j][2]==untz2[i][1][1]
      end
    end
    for i in 0...k2.length
      k2[i][0]="**Facet #{i+1}: #{k2[i][0]}**"
      k2[i][1]=k2[i][1].join("\n")
      k2[i][2]=nil
      k2[i].compact!
      k2[i]=nil if k2[i][1].length<=0
    end
    k2.compact!
  else
    k2=[[".",untz2.map{|q| q[0]}.join("\n")]]
  end
  create_embed(event,"__**#{name}**__",'',color,nil,nil,k2,2)
  return nil
end

def find_dragon_alts(event,args,bot)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_dragon,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  name=k[12][0].gsub('*','')
  k=@dragons.reject{|q| q[12][0].gsub('*','')!=name}.uniq
  untz2=[]
  color=[]
  for i in 0...k.length
    color.push(element_color(k[i][2]))
    m=[]
    m.push('default') if k[i][0]==k[i][12][0] || k[i][12][0][k[i][12][0].length-1,1]=='*'
    m.push('default') if k[i][12][0][0,1]=='*' && k[i][12].length>1
    m.push('sensible') if k[i][12][0][0,1]=='*' && k[i][12].length<2
    m.push('seasonal') if k[i][1][1,1]=='s'
    m.push('out-of-left-field') if m.length<=0
    n=''
    unless k[i][0]==k[i][12] || k[i][12][k[i][12].length-1,1]=='*'
      k2=k.reject{|q| q[12][0].gsub('*','')!=k[i][12][0].gsub('*','') || q[0]==k[i][0] || !(q[0]==q[12][0] || q[12][0].include?('*'))}
      n='x' if k2.length<=0
    end
    untz2.push(["#{k[i][0]}#{dragon_emoji(k[i],bot)} - #{m.uniq.join(', ')}",k[i][12].map{|q| q.gsub('*','')}])
  end
  if color.length.zero?
    color=0xFFD800
  else
    color=avg_color(color)
  end
  k2=k.map{|q| q[12].length}
  if k2.max>1
    k2=k.map{|q| q[12][1]}.uniq.map{|q| ["#{name}(#{q})",[],q]}
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
    k2=[[".",untz2.map{|q| q[0]}.join("\n")]]
  end
  create_embed(event,"__**#{name}**__",'',color,nil,nil,k2,2)
  return nil
end

bot.command([:adventurer,:adv,:unit]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_adventurers(bot,event,args)
    return nil
  elsif ['level','xp','exp'].include?(args[0].downcase)
    args.shift
    level(event,bot,args,2)
    return nil
  elsif ['art'].include?(args[0].downcase)
    args.shift
    disp_adventurer_art(bot,event,args)
    return nil
  elsif ['alt','alts'].include?(args[0].downcase)
    args.shift
    find_adv_alts(event,args,bot)
    return nil
  end
  disp_adventurer_stats(bot,event,args)
end

bot.command([:dragon,:drg]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_dragons(bot,event,args)
    return nil
  elsif ['level','xp','exp'].include?(args[0].downcase)
    args.shift
    level(event,bot,args,3)
    return nil
  elsif ['alt','alts'].include?(args[0].downcase)
    args.shift
    find_dragon_alts(event,args,bot)
    return nil
  elsif ['art'].include?(args[0].downcase)
    args.shift
    disp_dragon_art(bot,event,args)
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
  elsif ['level','xp','exp'].include?(args[0].downcase)
    args.shift
    level(event,bot,args,5)
    return nil
  elsif ['art'].include?(args[0].downcase)
    args.shift
    disp_wyrmprint_art(bot,event,args)
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
  elsif ['level','xp','exp'].include?(args[0].downcase)
    args.shift
    level(event,bot,args,6)
    return nil
  elsif ['lineage','craft','crafting'].include?(args[0].downcase)
    args.shift
    disp_weapon_lineage(bot,event,args)
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

bot.command([:facility,:faculty,:fac]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_facility_data(bot,event,args)
end

bot.command([:mat,:material,:item]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_mats(bot,event,args)
    return nil
  end
  disp_mat_data(bot,event,args)
end

bot.command([:art]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    disp_adventurer_art(bot,event,args)
  elsif ['dragon','dragons','drg'].include?(args[0].downcase)
    disp_dragon_art(bot,event,args)
  elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
    disp_wyrmprint_art(bot,event,args)
  elsif ['enemy','boss'].include?(args[0].downcase)
    disp_wyrmprint_art(bot,event,args)
  elsif find_data_ex(:find_adventurer,args.join(' '),event,true).length>0
    disp_adventurer_art(bot,event,args)
  elsif find_data_ex(:find_dragon,args.join(' '),event,true).length>0
    disp_dragon_art(bot,event,args)
  elsif find_data_ex(:find_enemy,args.join(' '),event,true).length>0
    disp_boss_art(bot,event,args)
  elsif find_data_ex(:find_wyrmprint,args.join(' '),event,true).length>0
    disp_wyrmprint_art(bot,event,args)
  elsif find_data_ex(:find_adventurer,args.join(' '),event).length>0
    disp_adventurer_art(bot,event,args)
  elsif find_data_ex(:find_dragon,args.join(' '),event).length>0
    disp_dragon_art(bot,event,args)
  elsif find_data_ex(:find_wyrmprint,args.join(' '),event).length>0
    disp_wyrmprint_art(bot,event,args)
  elsif find_data_ex(:find_enemy,args.join(' '),event).length>0
    disp_boss_art(bot,event,args)
  else
    event.respond 'No matches found'
  end
  return nil
end

bot.command([:enemy,:boss]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_enemy_data(bot,event,args)
end

bot.command([:banners,:banner]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_banner(bot,event,args)
end

bot.command([:lineage,:craft,:crafting]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_weapon_lineage(bot,event,args)
end

bot.command([:alts,:alt]) do |event, *args|
  return nil if overlap_prevent(event)
  if find_data_ex(:find_adventurer,args.join(' '),event,true).length>0
    find_adv_alts(event,args,bot)
  elsif find_data_ex(:find_dragon,args.join(' '),event,true).length>0
    find_dragon_alts(event,args,bot)
  elsif find_data_ex(:find_adventurer,args.join(' '),event).length>0
    find_adv_alts(event,args,bot)
  elsif find_data_ex(:find_dragon,args.join(' '),event).length>0
    find_dragon_alts(event,args,bot)
  else
    event.respond 'No matches found.'
  end
  return nil
end

bot.command([:find,:search,:list,:lookup]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    args.shift
    find_adventurers(bot,event,args)
    return nil
  elsif ['dragon','dragons','drg'].include?(args[0].downcase)
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
  elsif ['mat','mats','materials','material','item','items'].include?(args[0].downcase)
    args.shift
    find_mats(bot,event,args)
    return nil
  end
  find_all(bot,event,args)
end

bot.command([:victory]) do |event, *args|
  return nil if overlap_prevent(event)
  create_embed(event,'','',0xCE456B,nil,[nil,'https://cdn.discordapp.com/attachments/532352926270881792/538860577498464256/emote.png'])
end

bot.command([:xp,:exp,:level]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args)
end

bot.command([:plxp,:plexp,:pllevel,:plevel,:pxp,:pexp]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args,1)
end

bot.command([:advxp,:advexp,:advlevel,:alevel,:axp,:aexp]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args,2)
end

bot.command([:drgxp,:drgexp,:drglevel,:dlevel,:dxp,:dexp]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args,3)
end

bot.command([:bxp,:bexp,:blevel,:dbxp,:dbexp,:dblevel,:bondlevel,:bondxp,:bondexp]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args,4)
end

bot.command([:wrxp,:wrexp,:wrlevel,:wyrmxp,:wyrmexp,:wyrmxp,:wyrmlevel]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args,5)
end

bot.command([:wpxp,:wpexp,:wplevel,:weaponxp,:weaponexp,:weaponlevel]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args,6)
end

bot.command([:wxp,:wexp,:wlevel]) do |event, *args|
  return nil if overlap_prevent(event)
  level(event,bot,args,7)
end

bot.command([:next,:schedule]) do |event, *args|
  return nil if overlap_prevent(event)
  next_events(event,bot,args)
end

bot.command([:roost,:ruin,:ruins,:shop,:store,:daily,:dailies]) do |event, *args|
  return nil if overlap_prevent(event)
  roost(event,bot,args)
end

bot.command([:today,:now,:todayindl,:todayinDL,:todayInDL,:today_in_dl,:today_In_DL,:today_in_DL,:today_In_dl]) do |event, *args|
  return nil if overlap_prevent(event)
  roost(event,bot,args,true)
end

bot.command([:tomorrow,:tommorrow,:tomorow,:tommorow]) do |event, *args|
  return nil if overlap_prevent(event)
  roost(event,bot,args,-1)
end

bot.command(:prefix) do |event, prefix|
  return nil if overlap_prevent(event)
  if prefix.nil?
    event.respond 'No prefix was defined.  Try again'
    return nil
  elsif event.server.nil?
    event.respond 'This command is not available in PM.'
    return nil
  elsif !is_mod?(event.user,event.server,event.channel)
    event.respond 'You are not a mod.'
    return nil
  elsif ['feh!','feh?','f?','e?','h?','fgo!','fgo?','fg0!','fg0?','liz!','liz?','iiz!','iiz?','fate!','fate?','dl!','dl?','fe!','fe14!','fef!','fe13!','fea!','fe?','fe14?','fef?','fe13?','fea?'].include?(prefix.downcase)
    event.respond "That is a prefix that would conflict with either myself or another one of my developer's bots."
    return nil
  end
  @prefixes[event.server.id]=prefix
  prefixes_save()
  event.respond "This server's prefix has been saved as **#{prefix}**"
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
  elsif find_adventurer(name,event).length<=0 && find_dragon(name,event).length<=0 && find_wyrmprint(name,event).length<=0 && find_weapon(name,event).length<=0 && find_skill(name,event).length<=0 && find_enemy(name,event).length<=0 && find_ability(name,event).length<=0
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
  elsif find_enemy(name,event,true).length>0
    j=find_enemy(name,event,true)
    j=["Enemy","#{j[0]}"]
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
  elsif find_facility(name,event,true).length>0
    j=find_facility(name,event,true)
    j=["Facility","#{j[0]}"]
  elsif find_mat(name,event,true).length>0
    j=find_mat(name,event,true)
    j=["Material","#{j[0]}"]
  elsif find_skill(name,event,true).length>0
    j=find_skill(name,event,true)
    j=["Skill","#{j[0]}"]
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
  elsif find_enemy(name,event).length>0
    j=find_enemy(name,event)
    j=["Enemy","#{j[0]}"]
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
  elsif find_facility(name,event).length>0
    j=find_facility(name,event)
    j=["Facility","#{j[0]}"]
  elsif find_mat(name,event).length>0
    j=find_mat(name,event)
    j=["Material","#{j[0]}"]
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
  bug_report(bot,event,args,4,['Defense','Attack','Healing','Support','Null'],'Class',@prefix,532083509083373583)
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

bot.command(:invite) do |event, user|
  return nil if overlap_prevent(event)
  usr=event.user
  txt="**You can invite me to your server with this link: <https://goo.gl/mp77kQ>**\nTo look at my source code: <https://github.com/Rot8erConeX/LizBot/blob/master/BotanBot.rb>\nTo follow my coder's development Twitter and learn of updates: <https://twitter.com/EliseBotDev>\nIf you suggested me to server mods and they ask what I do, show them this image: https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/MarketingBotan.png"
  user_to_name="you"
  unless user.nil?
    if /<@!?(?:\d+)>/ =~ user
      usr=event.message.mentions[0]
      txt="This message was sent to you at the request of #{event.user.distinct}.\n\n#{txt}"
      user_to_name=usr.distinct
    else
      usr=bot.user(user.to_i)
      txt="This message was sent to you at the request of #{event.user.distinct}.\n\n#{txt}"
      user_to_name=usr.distinct
    end
  end
  usr.pm(txt)
  event.respond "A PM was sent to #{user_to_name}." unless event.server.nil? && user_to_name=="you"
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

bot.command([:tools,:links,:tool,:link,:resources,:resources]) do |event|
  return nil if overlap_prevent(event)
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || event.message.text.downcase.include?('mobile') || event.message.text.downcase.include?('phone')
    event << '**Useful tools for players of** ***Dragalia Lost***'
    event << '__Download the game__'
    event << 'Google Play: <https://play.google.com/store/apps/details?id=com.aniplex.fategrandorder.en&hl=en_US>'
    event << 'Apple App Store: <https://itunes.apple.com/us/app/fate-grand-order-english/id1183802626?mt=8>'
    event << ''
    event << '__News__'
    event << 'In-game news: <https://dragalialost.com/en/news/>'
    event << ''
    event << 'Stats Calculator: <https://docs.google.com/spreadsheets/d/1uyx9MRDeE4SnupOtQm2wm2rB2i2aXtMSHdGC908vpGg/edit#gid=1600382551>'
    event << 'Weapon Material Calculator: <https://yujinred.github.io/Dragalia-Weapon-Material-Calculator/>'
  else
    xpic='https://lh3.googleusercontent.com/SIHM5RPpoLy3Xso8wxqzCzBggkNq6dYhLt8THToag6FW_peH43_k1YdKh23Xmu5i_6c=s180-rw'
    create_embed(event,'**Useful tools for players of** ***Dragalia Lost***',"__Download the game__\n[Google Play](https://play.google.com/store/apps/details?id=com.nintendo.zaga&hl=en_US)\n[Apple App Store](https://itunes.apple.com/us/app/dragalia-lost/id1352230941?mt=8)\n\n__News__\n[In-game news](https://dragalialost.com/en/news/)\n\n__Calculators__\n[Stats Calculator](https://docs.google.com/spreadsheets/d/1uyx9MRDeE4SnupOtQm2wm2rB2i2aXtMSHdGC908vpGg/edit#gid=1600382551)\n[Weapon Material Calculator](https://yujinred.github.io/Dragalia-Weapon-Material-Calculator/)",0xED619A,nil,xpic)
    event.respond 'If you are on a mobile device and cannot click the links in the embed above, type `DL!tools mobile` to receive this message as plaintext.'
  end
  event << ''
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
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  event.channel.send_temporary_message('Please wait...',10)
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
    event << "#{longFormattedNumber(@server_data[0][1])} server#{"s are" if @server_data[0][1]!=1}#{" is" unless @server_data[0][1]!=1} assigned the <:Type_Attack:532107867520630784> Attack class, reaching #{longFormattedNumber(@server_data[1][1])} unique members."
    event << "#{longFormattedNumber(@server_data[0][2])} server#{"s are" if @server_data[0][2]!=1}#{" is" unless @server_data[0][2]!=1} assigned the <:Type_Healing:532107867348533249> Healing class, reaching #{longFormattedNumber(@server_data[1][2])} unique members."
    event << "#{longFormattedNumber(@server_data[0][3])} server#{"s are" if @server_data[0][3]!=1}#{" is" unless @server_data[0][3]!=1} assigned the <:Type_Support:532107867575156747> Support class, reaching #{longFormattedNumber(@server_data[1][3])} unique members."
    event << "#{longFormattedNumber(@server_data[0][4])} server#{"s are" if @server_data[0][4]!=1}#{" is" unless @server_data[0][4]!=1} assigned <:Element_Null:532106087810334741> no class, reaching #{longFormattedNumber(@server_data[1][4])} unique members."
    return nil
  elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(f.downcase)
    adv=@adventurers.map{|q| q}
    str="**There are #{adv.length} adventurers, including:**"
    str2=''
    m=adv.reject{|q| q[1][0,1].to_i != 1}
    str2="#{str2}\n<:Rarity_1:532086056594440231> #{m.length} one-star adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 2}
    str2="#{str2}\n<:Rarity_2:532086056254963713> #{m.length} two-star adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 3}
    str2="#{str2}\n<:Rarity_3:532086056519204864> #{m.length} three-star adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 4}
    str2="#{str2}\n<:Rarity_4:532086056301101067> #{m.length} four-star adventurer#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 5}
    str2="#{str2}\n<:Rarity_5:532086056737177600> #{m.length} five-star adventurer#{'s' unless m.length==1}" if m.length>0
    str=extend_message(str,str2,event)
    m=adv.reject{|q| q[2][1]!='Flame'}
    str2="<:Element_Flame:532106087952810005> #{m.length} Flame-element adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][1]!='Water'}
    str2="#{str2}\n<:Element_Water:532106088221376522> #{m.length} Water-element adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][1]!='Wind'}
    str2="#{str2}\n<:Element_Wind:532106087948746763> #{m.length} Wind-element adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][1]!='Light'}
    str2="#{str2}\n<:Element_Light:532106088129101834> #{m.length} Light-element adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][1]!='Shadow'}
    str2="#{str2}\n<:Element_Shadow:532106088154267658> #{m.length} Shadow-element adventurer#{'s' unless m.length==1}"
    str=extend_message(str,str2,event,2)
    m=adv.reject{|q| q[2][2]!='Sword'}
    str2="<:Weapon_Sword:532106114540634113> #{m.length} Sword-using adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][2]!='Blade'}
    str2="#{str2}\n<:Weapon_Blade:532106114628714496> #{m.length} Blade-using adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][2]!='Dagger'}
    str2="#{str2}\n<:Weapon_Dagger:532106116025286656> #{m.length} Dagger-using adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][2]!='Axe'}
    str2="#{str2}\n<:Weapon_Axe:532106114188443659> #{m.length} Axe-using adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][2]!='Bow'}
    str2="#{str2}\n<:Weapon_Bow:532106114909732864> #{m.length} Bow-using adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][2]!='Lance'}
    str2="#{str2}\n<:Weapon_Lance:532106114792423448> #{m.length} Lance-using adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][2]!='Wand'}
    str2="#{str2}\n<:Weapon_Wand:532106114985099264> #{m.length} Wand-using adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][2]!='Staff'}
    str2="#{str2}\n<:Weapon_Staff:532106114733441024> #{m.length} Staff-using adventurer#{'s' unless m.length==1}"
    str=extend_message(str,str2,event,2)
    m=adv.reject{|q| q[2][0]!='Attack'}
    str2="<:Type_Attack:532107867520630784> #{m.length} Attack-class adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][0]!='Defense'}
    str2="#{str2}\n<:Type_Defense:532107867264909314> #{m.length} Defense-class adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][0]!='Support'}
    str2="#{str2}\n<:Type_Support:532107867575156747> #{m.length} Support-class adventurer#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2][0]!='Healer'}
    str2="#{str2}\n<:Type_Healing:532107867348533249> #{m.length} Healing-class adventurer#{'s' unless m.length==1}"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      m=adv.reject{|q| q[1][1,1]!='y'}
      str2="#{m.length} story adventurer#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1].length>1}
      str2="#{str2}\n#{m.length} summonable adventurer#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1][1,1]!='w'}
      str2="#{str2}\n#{m.length} welfare adventurer#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1][1,1]!='s'}
      str2="#{str2}\n#{m.length} seasonal adventurer#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac adventurer#{'s' unless m.length==1}"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['dragon','dragons','drag','drags','drg','drgs'].include?(f.downcase)
    adv=@dragons.map{|q| q}
    str="**There are #{adv.length} dragons, including:**"
    str2=''
    m=adv.reject{|q| q[1][0,1].to_i != 1}
    str2="#{str2}\n<:Rarity_1:532086056594440231> #{m.length} one-star dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 2}
    str2="#{str2}\n<:Rarity_2:532086056254963713> #{m.length} two-star dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 3}
    str2="#{str2}\n<:Rarity_3:532086056519204864> #{m.length} three-star dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 4}
    str2="#{str2}\n<:Rarity_4:532086056301101067> #{m.length} four-star dragon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 5}
    str2="#{str2}\n<:Rarity_5:532086056737177600> #{m.length} five-star dragon#{'s' unless m.length==1}" if m.length>0
    str=extend_message(str,str2,event)
    m=adv.reject{|q| q[2]!='Flame'}
    str2="<:Element_Flame:532106087952810005> #{m.length} Flame-element dragon#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2]!='Water'}
    str2="#{str2}\n<:Element_Water:532106088221376522> #{m.length} Water-element dragon#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2]!='Wind'}
    str2="#{str2}\n<:Element_Wind:532106087948746763> #{m.length} Wind-element dragon#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2]!='Light'}
    str2="#{str2}\n<:Element_Light:532106088129101834> #{m.length} Light-element dragon#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2]!='Shadow'}
    str2="#{str2}\n<:Element_Shadow:532106088154267658> #{m.length} Shadow-element dragon#{'s' unless m.length==1}"
    str=extend_message(str,str2,event,2)
    str2=''
    x=['','Juicy Meat/Monday','Kaleidoscope/Tuesday','Floral Circlet/Wednesday','Compelling Book/Thursday','Mana Essence/Friday','']
    for i in 1...6
      m=adv.reject{|q| q[9]!=i}
      str2="#{str2}\n#{m.length} dragon#{'s' unless m.length==1} that prefer #{x[i].split('/')[0]}s, which are available on #{x[i].split('/')[1]}"
    end
    str=extend_message(str,str2,event)
    m=adv.reject{|q| q[10]!='Yes'}
    str2="#{m.length} dragon#{'s' unless m.length==1} that turn towards the source of damage they receive"
    m=adv.reject{|q| q[10]!='No'}
    str2="#{str2}\n#{m.length} dragon#{'s' unless m.length==1} that remain in position when damaged"
    str=extend_message(str,str2,event,2)
    m=adv.reject{|q| q[11]!='Yes'}
    str2="#{m.length} long-range dragon#{'s' unless m.length==1}"
    m=adv.reject{|q| q[11]!='No'}
    str2="#{str2}\n#{m.length} short-range dragon#{'s' unless m.length==1}"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      m=adv.reject{|q| q[1][1,1]!='y'}
      str2="#{m.length} story dragon#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1].length>1}
      str2="#{str2}\n#{m.length} summonable dragon#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1][1,1]!='w'}
      str2="#{str2}\n#{m.length} welfare dragon#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1][1,1]!='s'}
      str2="#{str2}\n#{m.length} seasonal dragon#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac dragon#{'s' unless m.length==1}"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(f.downcase)
    adv=@wyrmprints.map{|q| q}
    str="**There are #{adv.length} Wyrmprints, including:**"
    str2=''
    m=adv.reject{|q| q[1][0,1].to_i != 1}
    str2="#{str2}\n<:Rarity_1:532086056594440231> #{m.length} one-star print#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 2}
    str2="#{str2}\n<:Rarity_2:532086056254963713> #{m.length} two-star print#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 3}
    str2="#{str2}\n<:Rarity_3:532086056519204864> #{m.length} three-star print#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 4}
    str2="#{str2}\n<:Rarity_4:532086056301101067> #{m.length} four-star print#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[1][0,1].to_i != 5}
    str2="#{str2}\n<:Rarity_5:532086056737177600> #{m.length} five-star print#{'s' unless m.length==1}" if m.length>0
    str=extend_message(str,str2,event)
    m=adv.reject{|q| q[2]!='Attack'}
    str2="<:Type_Attack:532107867520630784> #{m.length} Attack-amulet print#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2]!='Defense'}
    str2="#{str2}\n<:Type_Defense:532107867264909314> #{m.length} Defense-amulet print#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2]!='Support'}
    str2="#{str2}\n<:Type_Support:532107867575156747> #{m.length} Support-amulet print#{'s' unless m.length==1}"
    m=adv.reject{|q| q[2]!='Healing'}
    str2="#{str2}\n<:Type_Healing:532107867348533249> #{m.length} Healing-amulet print#{'s' unless m.length==1}"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      m=adv.reject{|q| q[1].length>1}
      str2="#{m.length} summonable print#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1][1,1]!='w'}
      str2="#{str2}\n#{m.length} welfare print#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1][1,1]!='s'}
      str2="#{str2}\n#{m.length} seasonal print#{'s' unless m.length==1}"
      m=adv.reject{|q| q[1][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac print#{'s' unless m.length==1}"
      str=extend_message(str,str2,event,2)
    end
    event.respond str
    return nil
  elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(f.downcase)
    adv=@weapons.map{|q| q}
    str="**There are #{adv.length} weapons, including:**"
    m=adv.reject{|q| q[1]!='Sword'}
    str2="<:Weapon_Sword:532106114540634113> #{m.length} Sword#{'s' unless m.length==1}"
    m=adv.reject{|q| q[1]!='Blade'}
    str2="#{str2}\n<:Weapon_Blade:532106114628714496> #{m.length} Blade#{'s' unless m.length==1}"
    m=adv.reject{|q| q[1]!='Dagger'}
    str2="#{str2}\n<:Weapon_Dagger:532106116025286656> #{m.length} Dagger#{'s' unless m.length==1}"
    m=adv.reject{|q| q[1]!='Axe'}
    str2="#{str2}\n<:Weapon_Axe:532106114188443659> #{m.length} Axe#{'s' unless m.length==1}"
    m=adv.reject{|q| q[1]!='Bow'}
    str2="#{str2}\n<:Weapon_Bow:532106114909732864> #{m.length} Bow#{'s' unless m.length==1}"
    m=adv.reject{|q| q[1]!='Lance'}
    str2="#{str2}\n<:Weapon_Lance:532106114792423448> #{m.length} Lance#{'s' unless m.length==1}"
    m=adv.reject{|q| q[1]!='Wand'}
    str2="#{str2}\n<:Weapon_Wand:532106114985099264> #{m.length} Wand#{'s' unless m.length==1}"
    m=adv.reject{|q| q[1]!='Staff'}
    str2="#{str2}\n<:Weapon_Staff:532106114733441024> #{m.length} #{'Staff' if m.length==1}#{'Staves' unless m.length==1}"
    str=extend_message(str,str2,event,2)
    str2=''
    m=adv.reject{|q| q[2][0,1].to_i != 1}
    str2="#{str2}\n<:Rarity_1:532086056594440231> #{m.length} one-star weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][0,1].to_i != 2}
    str2="#{str2}\n<:Rarity_2:532086056254963713> #{m.length} two-star weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][0,1].to_i != 3}
    str2="#{str2}\n<:Rarity_3:532086056519204864> #{m.length} three-star weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][0,1].to_i != 4}
    str2="#{str2}\n<:Rarity_4:532086056301101067> #{m.length} four-star weapon#{'s' unless m.length==1}" if m.length>0
    m=adv.reject{|q| q[2][0,1].to_i != 5}
    str2="#{str2}\n<:Rarity_5:532086056737177600> #{m.length} five-star weapon#{'s' unless m.length==1}" if m.length>0
    str=extend_message(str,str2,event)
    m=adv.reject{|q| q[3]!='None'}
    str2="<:Element_Null:532106087810334741> #{m.length} weapon#{'s' unless m.length==1} without an element"
    m=adv.reject{|q| q[3]!='Flame'}
    str2="#{str2}\n<:Element_Flame:532106087952810005> #{m.length} Flame-element weapon#{'s' unless m.length==1}"
    m=adv.reject{|q| q[3]!='Water'}
    str2="#{str2}\n<:Element_Water:532106088221376522> #{m.length} Water-element weapon#{'s' unless m.length==1}"
    m=adv.reject{|q| q[3]!='Wind'}
    str2="#{str2}\n<:Element_Wind:532106087948746763> #{m.length} Wind-element weapon#{'s' unless m.length==1}"
    m=adv.reject{|q| q[3]!='Light'}
    str2="#{str2}\n<:Element_Light:532106088129101834> #{m.length} Light-element weapon#{'s' unless m.length==1}"
    m=adv.reject{|q| q[3]!='Shadow'}
    str2="#{str2}\n<:Element_Shadow:532106088154267658> #{m.length} Shadow-element weapon#{'s' unless m.length==1}"
    str=extend_message(str,str2,event,2)
    if safe_to_spam?(event)
      m=adv.reject{|q| q[2].length>1}
      str2="#{m.length} craftable weapon#{'s' unless m.length==1}"
      m=adv.reject{|q| q[2][1,1]!='w'}
      str2="#{str2}\n#{m.length} welfare weapon#{'s' unless m.length==1}"
      m=adv.reject{|q| q[2][1,1]!='s'}
      str2="#{str2}\n#{m.length} seasonal weapon#{'s' unless m.length==1}"
      m=adv.reject{|q| q[2][1,1]!='z'}
      str2="#{str2}\n#{m.length} Zodiac weapon#{'s' unless m.length==1}"
      m=adv.reject{|q| q[2][1,1]!='e'}
      str2="#{str2}\n#{m.length} starter weapon#{'s' unless m.length==1}"
      m=adv.reject{|q| q[2][1,1]!='p'}
      str2="#{str2}\n#{m.length} paid weapon#{'s' unless m.length==1}"
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
    event << "#{longFormattedNumber(b[0].reject{|q| q[0,12]!='bot.command(' || q.include?('from: 167657750971547648')}.length-b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'" && q.gsub('  ','')!="str='You are not a mod.'"}.length)} global commands, invoked with #{longFormattedNumber(all_commands(false,0).length)} different phrases."
    event << "#{longFormattedNumber(b[0].reject{|q| q.gsub('  ','')!="event.respond 'You are not a mod.'" && q.gsub('  ','')!="str='You are not a mod.'"}.length)} mod-only commands, invoked with #{longFormattedNumber(all_commands(false,1).length)} different phrases."
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
  event << "**There are #{longFormattedNumber(@adventurers.length)} *adventurers*.**"
  event << "**There are #{longFormattedNumber(@dragons.length)} *dragons*.**"
  event << "**There are #{longFormattedNumber(@wyrmprints.length)} *wyrmprints*.**"
  event << "**There are #{longFormattedNumber(@weapons.length)} *weapons*.**"
  event << ''
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='Skill'}.length)} skills."
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='Aura'}.length)} dragon auras, split into #{longFormattedNumber(@askilities.reject{|q| q[2]!='Aura'}.map{|q| q[0]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='Ability'}.length)} abilities, split into #{longFormattedNumber(@askilities.reject{|q| q[2]!='Ability'}.map{|q| q[0]}.uniq.length)} families."
  event << "There are #{longFormattedNumber(@askilities.reject{|q| q[2]!='CoAbility'}.length)} co-abilities, split into #{longFormattedNumber(@askilities.reject{|q| q[2]!='CoAbility'}.map{|q| q[0]}.uniq.length)} families."
  event << ''
  event << "There are #{longFormattedNumber(@facilities.length)} facilities."
  event << "There are #{longFormattedNumber(@mats.length)} materials."
  event << ''
  event << "**There are #{longFormattedNumber(glbl.length)} global and #{longFormattedNumber(srv_spec.length)} server-specific *aliases*.**"
  event << ''
  event << "**I am #{longFormattedNumber(File.foreach("C:/Users/Mini-Matt/Desktop/devkit/BotanBot.rb").inject(0) {|c, line| c+1})} lines of *code* long.**"
  event << "Of those, #{longFormattedNumber(b.length)} are SLOC (non-empty)."
  return nil
end

bot.command(:boop) do |event|
  return nil if overlap_prevent(event)
  return nil unless event.channel.id==532083509083373583 # only work when used by the developer
  event.channel.send_temporary_message('Please wait...',10)
  data_load()
  lookout=[]
  if File.exist?('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt')
    lookout=[]
    File.open('C:/Users/Mini-Matt/Desktop/devkit/DLSkillSubsets.txt').each_line do |line|
      lookout.push(eval line)
    end
  end
  lookout=lookout.reject{|q| q[2]!='Mat'}.map{|q| q[0]}
  m=@mats.map{|q| q[8]}.join(', ').split(', ').reject{|q| lookout.include?(q)}.uniq.sort
  str=''
  for i in 0...m.length
    str=extend_message(str,m[i],event)
  end
  event.respond str
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
    bot.user(167657750971547648).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned the #{['<:Type_Defense:532107867264909314> Defense','<:Type_Attack:532107867520630784> Attack','<:Type_Healing:532107867348533249> Healing','<:Type_Support:532107867575156747> Support','<:Element_Null:532106087810334741> Null'][(event.server.id >> 22) % 4]} class")
    bot.user(141260274144509952).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned the #{['<:Type_Defense:532107867264909314> Defense','<:Type_Attack:532107867520630784> Attack','<:Type_Healing:532107867348533249> Healing','<:Type_Support:532107867575156747> Support','<:Element_Null:532106087810334741> Null'][(event.server.id >> 22) % 4]} class")
    metadata_load()
    @server_data[0][((event.server.id >> 22) % 4)] += 1
    metadata_save()
    chn.send_message("Hello, my name is Botan.  Folks around town call me the \"naginata cutie.\" ...Hey, don't you **dare** laugh at that, jerk!\nWant data on *Dragalia Lost*?  Use commands that with the prefix `DL!`, and leave this to me!") rescue nil
  end
end

bot.server_delete do |event|
  unless @shardizard==4
    bot.user(167657750971547648).pm("Left server **#{event.server.name}**")
    bot.user(141260274144509952).pm("Left server **#{event.server.name}**")
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
  elsif !event.server.nil? && !@prefixes[event.server.id].nil? && @prefixes[event.server.id].length>0
    prf=@prefixes[event.server.id]
    if prf.downcase==s[0,prf.length]
      m=true
      puts event.message.text
      s=s[prf.length,s.length-prf.length]
    end
  end
  if @shardizard==4 && (['fea!','fef!','fea?','fef?'].include?(str[0,4]) || ['fe13!','fe14!','fe13?','fe14?'].include?(str[0,5]) || ['fe!','fe?'].include?(str[0,3]))
    str=str[4,str.length-4] if ['fea!','fef!','fea?','fef?'].include?(str[0,4])
    str=str[5,str.length-5] if ['fe13!','fe14!','fe13?','fe14?'].include?(str[0,5])
    str=str[3,str.length-3] if ['fe!','fe?'].include?(str[0,3])
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
  elsif (['!weak '].include?(str[0,6]) || ['!weakness '].include?(str[0,10]))
    if event.server.nil? || event.server.id==264445053596991498
    elsif !bot.user(304652483299377182).on(event.server.id).nil? # Robin
    elsif !bot.user(206147275775279104).on(event.server.id).nil? || @shardizard==4 || event.server.id==330850148261298176 # Pokedex
      triple_weakness(bot,event)
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
    elsif find_data_ex(:find_enemy,s,event,true).length>0
      disp_enemy_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_skill,s,event,true).length>0
      disp_skill_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_ability,s,event,true).length>0
      disp_ability_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_facility,s,event,true).length>0
      disp_facility_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_mat,s,event,true).length>0
      disp_mat_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_adventurer,s,event).length>0
      disp_adventurer_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_dragon,s,event).length>0
      disp_dragon_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_wyrmprint,s,event).length>0
      disp_wyrmprint_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_weapon,s,event).length>0
      disp_weapon_stats(bot,event,s.split(' '))
    elsif find_data_ex(:find_enemy,s,event).length>0
      disp_enemy_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_skill,s,event).length>0
      disp_skill_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_ability,s,event).length>0
      disp_ability_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_facility,s,event).length>0
      disp_facility_data(bot,event,s.split(' '))
    elsif find_data_ex(:find_mat,s,event).length>0
      disp_mat_data(bot,event,s.split(' '))
    end
  elsif event.message.text.include?('0x4') && !event.user.bot_account? && @shardizard==4
    s=event.message.text
    s=remove_format(s,'```')              # remove large code blocks
    s=remove_format(s,'`')                # remove small code blocks
    s=remove_format(s,'~~')               # remove crossed-out text
    s=remove_format(s,'||')               # remove spoiler tags
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
    elsif ['dragon','dragons','drag','drags','drg','drgs'].include?(args[0].downcase)
      args.shift
      find_dragons(bot,event,args)
    elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
      args.shift
      find_wyrmprints(bot,event,args)
    elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(args[0].downcase)
      args.shift
      find_weapons(bot,event,args)
    elsif ['mat','mats','materials','material','item','items'].include?(args[0].downcase)
      args.shift
      find_mats(bot,event,args)
    else
      find_all(bot,event,args)
    end
  elsif ['art'].include?(args[0].downcase)
    if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
      disp_adventurer_art(bot,event,args)
    elsif ['dragon','dragons','drg'].include?(args[0].downcase)
      disp_dragon_art(bot,event,args)
    elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
      disp_wyrmprint_art(bot,event,args)
    elsif ['enemy','boss'].include?(args[0].downcase)
      disp_wyrmprint_art(bot,event,args)
    elsif find_data_ex(:find_adventurer,args.join(' '),event,true).length>0
      disp_adventurer_art(bot,event,args)
    elsif find_data_ex(:find_dragon,args.join(' '),event,true).length>0
      disp_dragon_art(bot,event,args)
    elsif find_data_ex(:find_enemy,args.join(' '),event,true).length>0
      disp_boss_art(bot,event,args)
    elsif find_data_ex(:find_wyrmprint,args.join(' '),event,true).length>0
      disp_wyrmprint_art(bot,event,args)
    elsif find_data_ex(:find_adventurer,args.join(' '),event).length>0
      disp_adventurer_art(bot,event,args)
    elsif find_data_ex(:find_dragon,args.join(' '),event).length>0
      disp_dragon_art(bot,event,args)
    elsif find_data_ex(:find_wyrmprint,args.join(' '),event).length>0
      disp_wyrmprint_art(bot,event,args)
    elsif find_data_ex(:find_enemy,args.join(' '),event).length>0
      disp_boss_art(bot,event,args)
    else
      event.respond 'No matches found'
    end
  elsif ['alts','alt'].include?(args[0].downcase)
    m=false
    args.shift
    if find_data_ex(:find_adventurer,args.join(' '),event,true).length>0
      find_adv_alts(event,args,bot)
    elsif find_data_ex(:find_dragon,args.join(' '),event,true).length>0
      find_dragon_alts(event,args,bot)
    elsif find_data_ex(:find_adventurer,args.join(' '),event).length>0
      find_adv_alts(event,args,bot)
    elsif find_data_ex(:find_dragon,args.join(' '),event).length>0
      find_dragon_alts(event,args,bot)
    else
      event.respond 'No matches found.'
    end
  elsif ['adventurer','adv'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_adventurers(bot,event,args)
    elsif ['level','xp','exp'].include?(args[0].downcase)
      args.shift
      level(event,bot,args,2)
    elsif ['alt','alts'].include?(args[0].downcase)
      args.shift
      find_adv_alts(event,args,bot)
    elsif ['art'].include?(args[0].downcase)
      args.shift
      disp_adventurer_art(bot,event,args)
    else
      disp_adventurer_stats(bot,event,args)
    end
  elsif ['dragon','drg'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_dragons(bot,event,args)
    elsif ['level','xp','exp'].include?(args[0].downcase)
      args.shift
      level(event,bot,args,3)
    elsif ['alt','alts'].include?(args[0].downcase)
      args.shift
      find_dragon_alts(event,args,bot)
    elsif ['art'].include?(args[0].downcase)
      args.shift
      disp_dragon_art(bot,event,args)
    else
      disp_dragon_stats(bot,event,args)
    end
  elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_wyrmprints(bot,event,args)
    elsif ['level','xp','exp'].include?(args[0].downcase)
      args.shift
      level(event,bot,args,5)
    elsif ['art'].include?(args[0].downcase)
      args.shift
      disp_wyrmprint_art(bot,event,args)
    else
      disp_wyrmprint_stats(bot,event,args)
    end
  elsif ['weapon','weap','wep','wpn'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_weapons(bot,event,args)
    elsif ['level','xp','exp'].include?(args[0].downcase)
      args.shift
      level(event,bot,args,6)
    elsif ['lineage','craft','crafting'].include?(args[0].downcase)
      args.shift
      disp_weapon_lineage(bot,event,args)
    else
      disp_weapon_stats(bot,event,args)
    end
  elsif ['enemy','boss'].include?(args[0].downcase)
    m=false
    args.shift
    disp_enemy_data(bot,event,args)
  elsif ['skill','skil'].include?(args[0].downcase)
    m=false
    args.shift
    disp_skill_data(bot,event,args)
  elsif ['ability','abil'].include?(args[0].downcase)
    m=false
    args.shift
    disp_ability_data(bot,event,args)
  elsif ['facility','faculty','fac'].include?(args[0].downcase)
    m=false
    args.shift
    disp_facility_data(bot,event,args)
  elsif ['mat','material','item'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_mats(bot,event,args)
    else
      disp_mat_data(bot,event,args)
    end
  elsif ['lineage','craft','crafting'].include?(args[0].downcase)
    m=false
    args.shift
    disp_weapon_lineage(bot,event,args)
  elsif ['serveraliases','saliases'].include?(args[0].downcase)
    args.shift
    disp_aliases(bot,event,args,1)
    m=false
  elsif ['checkaliases','seealiases','aliases'].include?(args[0].downcase)
    args.shift
    disp_aliases(bot,event,args)
    m=false
  elsif ['xp','exp','level'].include?(args[0].downcase)
    args.shift
    level(event,bot,args)
    m=false
  elsif ['pxp','pexp','plxp','plexp','plevel','pllevel','axp','aexp','advxp','advexp','alevel','advlevel','dxp','dexp','drgxp','drgexp','dlevel','drglevel','bond','dragonbond','bxp','bexp','dbxp','dbexp','bondxp','bondexp','blevel','dblevel','bondlevel','wrxp','wrexp','wrlevel','wyrmxp','wyrmexp','wyrmlevel','wpxp','wpexp','wplevel','weaponxp','weaponexp','weaponlevel','wxp','wexp','wlevel'].include?(args[0].downcase)
    level(event,bot,args)
    m=false
  elsif ['next','schedule'].include?(args[0].downcase)
    args.shift
    next_events(event,bot,args)
    m=false
  elsif ['roost','ruin','ruins','daily','dailies','shop','store'].include?(args[0].downcase)
    args.shift
    roost(event,bot,args)
    m=false
  elsif ['today','now','tomorrow','tommorrow','tomorow','tommorow','sunday','sundae','sun','sonday','sondae','son','monday','mondae','mon','monday','mondae','tuesday','tuesdae','tues','tue','wednesday','wednesdae','wednes','wed','thursday','thursdae','thurs','thu','thur','friday','fridae','fri','fryday','frydae','fry','saturday','saturdae','sat','saturnday','saturndae','saturn','satur'].include?(args[0].downcase)
    roost(event,bot,args)
    m=false
  elsif ['victory'].include?(args[0].downcase)
    create_embed(event,'','',0xCE456B,nil,[nil,'https://cdn.discordapp.com/attachments/532352926270881792/538860577498464256/emote.png'])
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
    elsif find_data_ex(:find_enemy,name,event,true).length>0
      disp_enemy_data(bot,event,args.split(' '))
    elsif find_data_ex(:find_skill,name,event,true).length>0
      disp_skill_data(bot,event,args)
    elsif find_data_ex(:find_ability,name,event,true).length>0
      disp_ability_data(bot,event,args)
    elsif find_data_ex(:find_facility,name,event,true).length>0
      disp_facility_data(bot,event,args)
    elsif find_data_ex(:find_mat,name,event,true).length>0
      disp_mat_data(bot,event,args)
    elsif find_data_ex(:find_adventurer,name,event).length>0
      disp_adventurer_stats(bot,event,args)
    elsif find_data_ex(:find_dragon,name,event).length>0
      disp_dragon_stats(bot,event,args)
    elsif find_data_ex(:find_wyrmprint,name,event).length>0
      disp_wyrmprint_stats(bot,event,args)
    elsif find_data_ex(:find_weapon,name,event).length>0
      disp_weapon_stats(bot,event,args)
    elsif find_data_ex(:find_enemy,name,event).length>0
      disp_enemy_data(bot,event,args.split(' '))
    elsif find_data_ex(:find_skill,name,event).length>0
      disp_skill_data(bot,event,args)
    elsif find_data_ex(:find_ability,name,event).length>0
      disp_ability_data(bot,event,args)
    elsif find_data_ex(:find_facility,name,event).length>0
      disp_facility_data(bot,event,args)
    elsif find_data_ex(:find_mat,name,event).length>0
      disp_mat_data(bot,event,args)
    end
  end
end

def next_holiday(bot,mode=0)
  t=Time.now
  t-=60*60*6
  holidays=[]
  d=get_donor_list()
  d=d.reject{|q| q[2]<2}
  for i in 0...d.length
    if d[i][4][2]!='-'
      holidays.push([0,d[i][3][0],d[i][3][1],d[i][4][2],"in recognition of #{bot.user(d[i][0]).distinct}","Donator's birthday"])
      holidays[-1][5]="Donator's Day" if d[i][0]==189235935563481088
    end
  end
  for i in 0...holidays.length
    if t.month>holidays[i][1] || (t.month==holidays[i][1] && t.day>holidays[i][2])
      holidays[i][0]=t.year+1
    else
      holidays[i][0]=t.year
    end
  end
  e=calc_easter()
 # holidays.push([e[0],e[1],e[2],'','','Easter'])
  t=Time.now
  t-=60*60*6
  y8=t.year
  j8=Time.new(y8,6,8)
  fsij=8-j8.wday
  fsij-=7 if j8.sunday?
  fd=fsij+14
  if (t.month==6 && t.day>fd) || t.month>6
    y8+=1
    j8=Time.new(y8,6,8)
    fsij=8-j8.wday
    fsij-=7 if j8.sunday?
    fd=fsij+14
  end
 # holidays.push([y8,6,fd,'','',"Father's Day"])
  t=Time.now
  t-=60*60*6
  y8=t.year
  m8=Time.new(y8,5,8)
  fsim=8-m8.wday
  fsim-=7 if m8.sunday?
  md=fsim+7
  if (t.month==5 && t.day>md) || t.month>5
    y8+=1
    m8=Time.new(y8,5,8)
    fsim=8-m8.wday
    fsim-=7 if m8.sunday?
    md=fsim+14
  end
 # holidays.push([y8,5,md,'','',"Mother's Day"])
  holidays.sort! {|a,b| supersort(a,b,0) == 0 ? (supersort(a,b,1) == 0 ? (supersort(a,b,2) == 0 ? (supersort(a,b,6) == 0 ? supersort(a,b,4) : supersort(a,b,6)) : supersort(a,b,2)) : supersort(a,b,1)) : supersort(a,b,0)}
  k=[]
  for i in 0...holidays.length
    k.push(holidays[i]) if holidays[i][0]==holidays[0][0] && holidays[i][1]==holidays[0][1] && holidays[i][2]==holidays[0][2]
  end
  div=[[],
       [[0,0]],
       [[0,0],[12,0]],
       [[0,0],[8,0],[16,0]],
       [[0,0],[6,0],[12,0],[18,0]],
       [[0,0],[4,48],[9,36],[14,24],[19,12]],
       [[0,0],[4,0],[8,0],[12,0],[16,0],[20,0]],
       [[0,0],[3,26],[6,52],[10,17],[13,43],[17,8],[18,34]],
       [[0,0],[3,0],[6,0],[9,0],[12,0],[15,0],[18,0],[21,0]]]
  t=Time.now
  t-=60*60*6
  if k.length<=0
    t=Time.now
    t-=60*60*6
    bot.game='Dragalia Lost (DL!help for info)'
    bot.profile.avatar=(File.open('C:/Users/Mini-Matt/Desktop/devkit/BotanBot.png','r')) rescue nil if @shardizard.zero?
    @avvie_info=['Botan','*Dragalia Lost*','']
    t+=24*60*60
    @scheduler.at "#{t.year}/#{t.month}/#{t.day} 0000" do
      next_holiday(bot,1)
    end
  elsif t.year==k[0][0] && t.month==k[0][1] && t.day==k[0][2]
    if k.length==1
      # Only one holiday is today.  Display new avatar, and set another check for midnight
      bot.game=k[0][4]
      if @shardizard.zero?
        bot.profile.avatar=(File.open("C:/Users/Mini-Matt/Desktop/devkit/EliseImages/#{k[0][3]}.png",'r')) rescue nil
      end
      @avvie_info=[k[0][3],k[0][4],k[0][5]]
      t2= Time.now + 18*60*60
      t=Time.now
      @scheduler.at "#{t2.year}/#{t2.month}/#{t2.day} 0000" do
        next_holiday(bot,1)
      end
    else
      # multiple holidays are today.  Change avatar based on time of day, using div as a reference
      fcod=div[k.length][k.length-1]
      if t.hour>fcod[0] || (t.hour==fcod[0] && t.min>=fcod[1])
        # in last area of day.  Set avatar to the last one for the day, then set a check for tomorrow at midnight
        bot.game=k[k.length-1][4]
        if @shardizard.zero?
          bot.profile.avatar=(File.open("C:/Users/Mini-Matt/Desktop/devkit/BotanImages/#{k[k.length-1][3]}.png",'r')) rescue nil
        end
        @avvie_info=[k[k.length-1][3],k[k.length-1][4],k[k.length-1][5]]
        t2= Time.now + 18*60*60
        t=Time.now
        @scheduler.at "#{t2.year}/#{t2.month}/#{t2.day} 0000" do
          next_holiday(bot,1)
        end
      else
        # find when in the day it is and...
        j=0
        t=Time.now
        t-=60*60*6
        for i in 0...div[k.length].length-1
          j=i if t.hour<div[k.length][i+1][0] || (t.hour==div[k.length][i+1][0] && t.min<div[k.length][i+1][1])
        end
        # ...set avatar properly and set check for the beginning of the next chunk of the day
        bot.game=k[j][4]
        if @shardizard.zero?
          bot.profile.avatar=(File.open("C:/Users/Mini-Matt/Desktop/devkit/BotanImages/#{k[j][3]}.png",'r')) rescue nil
        end
        @avvie_info=[k[j][3],k[j][4],k[j][5]]
        t=Time.now
        t-=60*60*6
        @scheduler.at "#{t.year}/#{t.month}/#{t.day} #{div[k.length][j+1][0].to_s.rjust(2, '0')}#{div[k.length][j+1][1].to_s.rjust(2, '0')}" do
          next_holiday(bot,1)
        end
      end
    end
  else
    t=Time.now
    t-=60*60*6
    bot.game='Dragalia Lost (DL!help for info)'
    bot.profile.avatar=(File.open('C:/Users/Mini-Matt/Desktop/devkit/BotanBot.png','r')) rescue nil if @shardizard.zero?
    @avvie_info=['Botan','*Dragalia Lost*','']
    t+=24*60*60
    @scheduler.at "#{t.year}/#{t.month}/#{t.day} 0000" do
      next_holiday(bot,1)
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
  bot.game='Dragalia Lost (DL!help for info)'
  if @shardizard==4
    next_holiday(bot)
    bot.user(bot.profile.id).on(285663217261477889).nickname='BotanBot (Debug)' if @shardizard==4
    bot.profile.avatar=(File.open('C:/Users/Mini-Matt/Desktop/devkit/DebugBotan.png','r')) if @shardizard==4
  else
    next_holiday(bot)
  end
end

bot.run
