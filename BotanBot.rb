@shardizard=ARGV.first.to_i # taking a single variable from the command prompt to get the shard value
system('color 0F')
@shards = 4                 # total number of shards

require 'discordrb'                    # Download link: https://github.com/meew0/discordrb
require 'open-uri'                     # pre-installed with Ruby in Windows
require 'net/http'                     # pre-installed with Ruby in Windows
require 'certified'
require 'tzinfo/data'                  # Downloaded with active_support below, but the require must be above active_support's require
require 'rufus-scheduler'              # Download link: https://github.com/jmettraux/rufus-scheduler
require 'active_support/core_ext/time' # Download link: https://rubygems.org/gems/activesupport/versions/5.0.0
require_relative 'rot8er_functs'       # functions I use commonly in bots
@location=">Location<"

load "#{@location}devkit/BotanText.rb"

# this is required to get her to change her avatar on certain holidays
ENV['TZ'] = 'America/Chicago'
@scheduler = Rufus::Scheduler.new

# All the possible command prefixes
@prefixes={}

prefix_proc = proc do |message|
  next pseudocase(message.text[3..-1]) if message.text.downcase.start_with?('dl!')
  next pseudocase(message.text[3..-1]) if message.text.downcase.start_with?('dl?')
  load "#{@location}devkit/DLPrefix.rb"
  next if message.channel.server.nil? || @prefixes[message.channel.server.id].nil? || @prefixes[message.channel.server.id].length<=0
  prefix = @prefixes[message.channel.server.id]
  # We use [prefix.size..-1] so we can handle prefixes of any length
  next pseudocase(message.text[prefix.size..-1]) if message.text.downcase.start_with?(prefix.downcase)
end

# The bot's token is basically their password, so is censored for obvious reasons
if @shardizard==4
  bot = Discordrb::Commands::CommandBot.new token: '>Debug Token<', client_id: 431895561193390090, prefix: prefix_proc
elsif @shardizard<0
  bot = Discordrb::Commands::CommandBot.new token: '>Smol Token<', client_id: 759369481305718806, prefix: prefix_proc
elsif @shardizard>4
  bot = Discordrb::Commands::CommandBot.new token: '>Token<', shard_id: (@shardizard-1), num_shards: 4, client_id: 543373018303299585, prefix: prefix_proc
else
  bot = Discordrb::Commands::CommandBot.new token: '>Token<', shard_id: @shardizard, num_shards: 4, client_id: 543373018303299585, prefix: prefix_proc
end
bot.gateway.check_heartbeat_acks = false

def shard_data(mode=0,ignoredebug=false,s=nil)
  s=@shards*1 if s.nil?
  if mode==0 # shard icons + names
    k=['<:Type_Defense:532107867264909314> Defense','<:Type_Attack:532107867520630784> Attack','<:Type_Healing:532107867348533249> Healing','<:Type_Support:532107867575156747> Support','<:Element_Null:532106087810334741> Null'] if s<=4
    k=['<:Element_Shadow:532106088154267658> Shadow','<:Element_Flame:532106087952810005> Fire','<:Element_Water:532106088221376522> Water','<:Element_Wind:532106087948746763> Wind','<:Element_Null:532106087810334741> Null','<:Element_Light:532106088129101834> Light','<:Element_Void:548467446734913536> Void'] if s>4 && s<7
    k=['<:Weapon_Lance:532106114792423448> Lance','<:Weapon_Sword:532106114540634113> Sword','<:Weapon_Blade:532106114628714496> Blade','<:Weapon_Dagger:532106116025286656> Dagger','<:Element_Null:532106087810334741> Null','<:Weapon_Axe:532106114188443659> Axe','<:Weapon_Bow:532106114909732864> Bow','<:Weapon_Wand:532106114985099264> Wand','<:Weapon_Staff:532106114733441024> Staff','<:Weapon_Manacaster:758905122448867338> Manacaster'] if s>6 && s<10
    k=['<:Affinity_Queen:758912216115314690> Queen','<:Affinity_Hatchet:758912216413241354> Hatchet','<:Affinity_Duel:758912216052269076> Duel','<:Affinity_Barrage:758912216401051720> Barrage','<:Element_Null:532106087810334741> Null','<:Affinity_Draco:758912216048205824> Draco','<:Affinity_Trident:758912216333549619> Trident','<:Affinity_Phoenix:758912216073240677> Phoenix','<:Affinity_Wolf:758912216274567189> Wolf','<:Affinity_Bull:758912215733895169> Bull','<:Affinity_Serpent:758912216304189471> Serpent','<:Affinity_Divinity:758912216031952907> Divine'] if s>9
    k=['<:Type_Defense:532107867264909314> Defense','<:Type_Attack:532107867520630784> Attack','<:Type_Healing:532107867348533249> Healing','<:Type_Support:532107867575156747> Support','<:Element_Null:532106087810334741> Null','<:Element_Flame:532106087952810005> Fire','<:Element_Water:532106088221376522> Water','<:Element_Wind:532106087948746763> Wind','<:Element_Light:532106088129101834> Light','<:Element_Shadow:532106088154267658> Shadow','<:Weapon_Sword:532106114540634113> Sword','<:Weapon_Blade:532106114628714496> Blade','<:Weapon_Dagger:532106116025286656> Dagger','<:Weapon_Axe:532106114188443659> Axe','<:Weapon_Bow:532106114909732864> Bow','<:Weapon_Lance:532106114792423448> Lance','<:Weapon_Wand:532106114985099264> Wand','<:Weapon_Staff:532106114733441024> Staff','<:Weapon_Manacaster:758905122448867338> Manacaster','<:Affinity_Queen:758912216115314690> Queen','<:Affinity_Hatchet:758912216413241354> Hatchet','<:Affinity_Duel:758912216052269076> Duel','<:Affinity_Barrage:758912216401051720> Barrage','<:Affinity_Draco:758912216048205824> Draco','<:Affinity_Trident:758912216333549619> Trident','<:Affinity_Phoenix:758912216073240677> Phoenix','<:Affinity_Wolf:758912216274567189> Wolf','<:Affinity_Bull:758912215733895169> Bull','<:Affinity_Serpent:758912216304189471> Serpent','<:Affinity_Divinity:758912216031952907> Divine','<:Element_Void:548467446734913536> Void'] if s>11
    if s>30
      k2=['<:Type_Attack:532107867520630784> Attack','<:Type_Defense:532107867264909314> Defense','<:Type_Healing:532107867348533249> Healing','<:Type_Support:532107867575156747> Support','<:Element_Flame:532106087952810005> Fire','<:Element_Water:532106088221376522> Water','<:Element_Wind:532106087948746763> Wind','<:Element_Light:532106088129101834> Light','<:Element_Shadow:532106088154267658> Shadow','<:Weapon_Sword:532106114540634113> Sword','<:Weapon_Blade:532106114628714496> Blade','<:Weapon_Dagger:532106116025286656> Dagger','<:Weapon_Axe:532106114188443659> Axe','<:Weapon_Bow:532106114909732864> Bow','<:Weapon_Lance:532106114792423448> Lance','<:Weapon_Wand:532106114985099264> Wand','<:Weapon_Staff:532106114733441024> Staff','<:Weapon_Manacaster:758905122448867338> Manacaster','<:Affinity_Queen:758912216115314690> Queen','<:Affinity_Hatchet:758912216413241354> Hatchet','<:Affinity_Duel:758912216052269076> Duel','<:Affinity_Barrage:758912216401051720> Barrage','<:Affinity_Draco:758912216048205824> Draco','<:Affinity_Trident:758912216333549619> Trident','<:Affinity_Phoenix:758912216073240677> Phoenix','<:Affinity_Wolf:758912216274567189> Wolf','<:Affinity_Bull:758912215733895169> Bull','<:Affinity_Serpent:758912216304189471> Serpent','<:Affinity_Divinity:758912216031952907> Divine','<:Element_Void:548467446734913536> Void']
      i=2
      while k.length<s+1
        k3=k2.map{|q| "#{q}#{i}"}
        for j in 0...k3.length
          k.push(k3[j])
        end
        i+=1
      end
    end
  elsif mode==1 # shard icons without names
    k=['<:Type_Defense:532107867264909314>','<:Type_Attack:532107867520630784>','<:Type_Healing:532107867348533249>','<:Type_Support:532107867575156747>','<:Element_Null:532106087810334741>'] if s<=4
    k=['<:Element_Shadow:532106088154267658>','<:Element_Flame:532106087952810005>','<:Element_Water:532106088221376522>','<:Element_Wind:532106087948746763>','<:Element_Null:532106087810334741>','<:Element_Light:532106088129101834>','<:Element_Void:548467446734913536>'] if s>4 && s<7
    k=['<:Weapon_Lance:532106114792423448>','<:Weapon_Sword:532106114540634113>','<:Weapon_Blade:532106114628714496>','<:Weapon_Dagger:532106116025286656>','<:Element_Null:532106087810334741>','<:Weapon_Axe:532106114188443659>','<:Weapon_Bow:532106114909732864>','<:Weapon_Wand:532106114985099264>','<:Weapon_Staff:532106114733441024>','<:Weapon_Manacaster:758905122448867338>'] if s>6 && s<10
    k=['<:Affinity_Queen:758912216115314690>','<:Affinity_Hatchet:758912216413241354>','<:Affinity_Duel:758912216052269076>','<:Affinity_Barrage:758912216401051720>','<:Element_Null:532106087810334741>','<:Affinity_Draco:758912216048205824>','<:Affinity_Trident:758912216333549619>','<:Affinity_Phoenix:758912216073240677>','<:Affinity_Wolf:758912216274567189>','<:Affinity_Bull:758912215733895169>','<:Affinity_Serpent:758912216304189471>','<:Affinity_Divinity:758912216031952907>'] if s>9
    k=['<:Type_Defense:532107867264909314>','<:Type_Attack:532107867520630784>','<:Type_Healing:532107867348533249>','<:Type_Support:532107867575156747>','<:Element_Null:532106087810334741>','<:Element_Flame:532106087952810005>','<:Element_Water:532106088221376522>','<:Element_Wind:532106087948746763>','<:Element_Light:532106088129101834>','<:Element_Shadow:532106088154267658>','<:Weapon_Sword:532106114540634113>','<:Weapon_Blade:532106114628714496>','<:Weapon_Dagger:532106116025286656>','<:Weapon_Axe:532106114188443659>','<:Weapon_Bow:532106114909732864>','<:Weapon_Lance:532106114792423448>','<:Weapon_Wand:532106114985099264>','<:Weapon_Staff:532106114733441024>','<:Weapon_Manacaster:758905122448867338>','<:Affinity_Queen:758912216115314690>','<:Affinity_Hatchet:758912216413241354>','<:Affinity_Duel:758912216052269076>','<:Affinity_Barrage:758912216401051720>','<:Affinity_Draco:758912216048205824>','<:Affinity_Trident:758912216333549619>','<:Affinity_Phoenix:758912216073240677>','<:Affinity_Wolf:758912216274567189>','<:Affinity_Bull:758912215733895169>','<:Affinity_Serpent:758912216304189471>','<:Affinity_Divinity:758912216031952907>','<:Element_Void:548467446734913536>'] if s>11
    if s>30
      k2=['<:Type_Attack:532107867520630784>','<:Type_Defense:532107867264909314>','<:Type_Healing:532107867348533249>','<:Type_Support:532107867575156747>','<:Element_Flame:532106087952810005>','<:Element_Water:532106088221376522>','<:Element_Wind:532106087948746763>','<:Element_Light:532106088129101834>','<:Element_Shadow:532106088154267658>','<:Weapon_Sword:532106114540634113>','<:Weapon_Blade:532106114628714496>','<:Weapon_Dagger:532106116025286656>','<:Weapon_Axe:532106114188443659>','<:Weapon_Bow:532106114909732864>','<:Weapon_Lance:532106114792423448>','<:Weapon_Wand:532106114985099264>','<:Weapon_Staff:532106114733441024>','<:Weapon_Manacaster:758905122448867338>','<:Affinity_Queen:758912216115314690>','<:Affinity_Hatchet:758912216413241354>','<:Affinity_Duel:758912216052269076>','<:Affinity_Barrage:758912216401051720>','<:Affinity_Draco:758912216048205824>','<:Affinity_Trident:758912216333549619>','<:Affinity_Phoenix:758912216073240677>','<:Affinity_Wolf:758912216274567189>','<:Affinity_Bull:758912215733895169>','<:Affinity_Serpent:758912216304189471>','<:Affinity_Divinity:758912216031952907>','<:Element_Void:548467446734913536>']
      i=2
      while k.length<s+1
        k3=k2.map{|q| "#{q}*#{i}*"}
        for j in 0...k3.length
          k.push(k3[j])
        end
        i+=1
      end
    end
  elsif mode==2 # shard names without icons
    k=['Defense','Attack','Healing','Support','Null'] if s<=4
    k=['Shadow','Fire','Water','Wind','Null','Light','Void'] if s>4 && s<7
    k=['Lance','Sword','Blade','Dagger','Null','Axe','Bow','Wand','Staff','Manacaster'] if s>6 && s<10
    k=['Queen','Hatchet','Duel','Barrage','Null','Draco','Trident','Phoenix','Wolf','Bull','Serpent','Divine'] if s>9
    k=['Defense','Attack','Healing','Support','Null','Fire','Water','Wind','Light','Shadow','Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff','Manacaster','Queen','Hatchet','Duel','Barrage','Draco','Trident','Phoenix','Wolf','Bull','Serpent','Divine','Void'] if s>11
    if s>30
      k2=['Attack','Defense','Healing','Support','Fire','Water','Wind','Light','Shadow','Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff','Manacaster','Queen','Hatchet','Duel','Barrage','Draco','Trident','Phoenix','Wolf','Bull','Serpent','Divine','Void']
      i=2
      while k.length<s+1
        k3=k2.map{|q| "#{q}#{i}"}
        for j in 0...k3.length
          k.push(k3[j])
        end
        i+=1
      end
    end
  elsif mode==3 # bright command prompt text color
    k=['B','C','A','D','F'] if s<=4
    k=['9','C','B','A','F','E','7'] if s>4 && s<7
    k=['4','4','4','4','F','6','4','D','D','D','D','A'] if s>9 && s<12
    return 'F'*(s+1) if s>6 && !(s>9 && s<12)
  end
  if ignoredebug
    k[4]=nil
    k.compact!
  end
  return k.join('') if mode>2
  return k
end

system("color 0#{shard_data(3)[@shardizard,1]}")
system("title loading #{shard_data(2)[@shardizard]} BotanBot")
system("title loading Smol BotanBot") if @shardizard<0

@adventurers=[]
@dragons=[]
@wyrmprints=[]
@weapons=[]
@enemies=[]

@askilities=[]

@facilities=[]
@mats=[]
@banners=[]
@statuses=[]

@emotes=[]
@npcs=[]

@aliases=[]

@embedless=[]
@ignored=[]
@server_data=[[],[]]
@spam_channels=[]
@last_multi_reload=[0,0,0]
@rarity_stars=[['<:Rarity_Mana:706612079783575607>',
                '<:Rarity_1:532086056594440231>',
                '<:Rarity_2:532086056254963713>',
                '<:Rarity_3:532086056519204864>',
                '<:Rarity_4:532086056301101067>',
                '<:Rarity_5:532086056737177600>',
                '<:Rarity_6:660289379520086046>'],
               ['<:Rarity_6_Blank:660289380807737354>',
                '<:Rarity_1_Blank:555459856476274691>',
                '<:Rarity_2_Blank:555459856400908299>',
                '<:Rarity_3_Blank:555459856568418314>',
                '<:Rarity_4_Blank:555459856497246218>',
                '<:Rarity_5_Blank:555459856190930955>',
                '<:Rarity_6_Blank:660289380807737354>']]
@avvie_info=['Botan','*Dragalia Lost*','N/A']
@voids=[]

def all_commands(include_nil=false,permissions=-1)
  return all_commands(include_nil)-all_commands(false,1)-all_commands(false,2) if permissions==0
  k=['reboot','adventurer','adv','addalias','checkaliases','aliases','seealiases','saliases','serveraliases','deletealias','removealias','channellist','long','group','groups','find',
     'channelist','spamlist','spamchannels','bugreport','suggestion','feedback','donation','donate','shard','attribute','safe','spam','safetospam','safe2spam','seegroups','drg','sp',
     'longreplies','sortaliases','status','backupaliases','restorealiases','sendmessage','sendpm','ignoreuser','leaveserver','cleanupaliases','snagstats','combo','chaincoab','dmg',
     'search','dragon','help','wyrmprint','wyrm','print','weapon','wep','weap','wpn','skill','skil','ability','abil','aura','roost','today','ruin','ruins','share','skilshare','dbxp',
     'daily','now','dailies','todayindl','today_in_dl','tomorrow','tommorrow','tomorow','tommorow','shop','store','exp','level','xp','plxp','plexp','pllevel','cca','cc','skillshare',
     'plevel','pxp','pexp','advxp','advexp','advlevel','alevel','axp','aexp','drgxp','drgexp','drglevel','dlevel','dxp','dexp','bxp','bexp','blevel','team','backpack','coab','chain',
     'dbexp','dblevel','bondlevel','bondxp','bondexp','wrxp','wrexp','wrlevel','wyrmxp','wyrmexp','wyrmlevel','wpxp','wpexp','wplevel','weaponxp','weaponexp','coability','coabil',
     'weaponlevel','wxp','wexp','wlevel','facility','faculty','fac','mat','material','item','list','lookup','invite','boop','alts','alt','lineage','alias','nodes','damage','limit',
     'craft','crafting','tools','tool','links','link','resources','resource','next','enemy','boss','banners','banner','prefix','art','stats','reset','materials','spiral','node','mats',
     'limits','stack','stacks','sort','list','unit','avvie','avatar','affliction','ailment','smol','reload','update','shared','affinity','resonance']
  k=['addalias','deletealias','removealias','prefix'] if permissions==1
  k=['reboot','sortaliases','status','backupaliases','restorealiases','sendmessage','sendpm','ignoreuser','leaveserver','cleanupaliases','boop','reload','update'] if permissions==2
  k=k.uniq
  k.push(nil) if include_nil
  return k
end

def safe_to_spam?(event,chn=nil) # determines whether or not it is safe to send extremely long messages
  return true if event.server.nil? # it is safe to spam in PM
  return false if event.user.id==213048998678888448
  return false if event.message.text.downcase.split(' ').include?('smol') && @shardizard==4
  return true if @shardizard==4
  return false if event.message.text.downcase.split(' ').include?('xsmol') && [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529].include?(event.server.id) # it is safe to spam in the emoji servers
  return true if [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529].include?(event.server.id) # it is safe to spam in the emoji servers
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

alias is_mod_old? is_mod?
def is_mod?(user,server,channel,mode=0)
  return true if is_mod_old?(user,server,channel,mode)
  return true if user.id==80565838670725120 && @shardizard<0
  return true if user.id==141260274144509952 && !server.nil?
  return false
end

def data_load()
  if File.exist?("#{@location}devkit/DLAdventurers.txt")
    b=[]
    File.open("#{@location}devkit/DLAdventurers.txt").each_line do |line|
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
    b[i][5]=b[i][5].split(', ').map{|q| q.to_i}
    b[i][6]=b[i][6].split(';; ')
    b[i][7]=b[i][7].split(';; ')
    b[i][8]=b[i][8].split(';;;; ').map{|q| q.split(';; ')}
    b[i][8][3]=b[i][8][3].join(';; ') unless b[i][8].length<=3
    b[i][9]=b[i][9].split(', ')
    b[i][15]=b[i][15].split(';;;; ').map{|q| q.split(';; ')} unless b[i][15].nil?
    b[i][18]=b[i][18].split(';; ').map{|q| q.split('; ')} unless b[i][18].nil?
    b[i][19]=b[i][19].split(';; ').map{|q| q.split('; ')} unless b[i][19].nil?
  end
  @adventurers=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLDragons.txt")
    b=[]
    File.open("#{@location}devkit/DLDragons.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][3]=b[i][3].split(', ').map{|q| q.to_i}
    b[i][4]=b[i][4].split(', ').map{|q| q.to_i}
    b[i][5]=b[i][5].split(';; ') unless b[i][5].nil?
    b[i][6]=b[i][6].split(';;; ').map{|q| q.split(';; ')}
    b[i][7]=b[i][7].split(', ').map{|q| q.to_i}
    b[i][8]=b[i][8].split(', ').map{|q| q.to_f}
    b[i][9]=b[i][9].to_i
    b[i][12]=b[i][12].split(', ')
    b[i][15]=b[i][15].split(';;;; ').map{|q| q.split(';; ')} unless b[i][15].nil?
    b[i][19]=b[i][19].split(';; ').map{|q| q.split('; ')} unless b[i][19].nil?
  end
  @dragons=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLWyrmprints.txt")
    b=[]
    File.open("#{@location}devkit/DLWyrmprints.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][2]=b[i][2].split(', ')
    b[i][3]=b[i][3].split(', ').map{|q| q.to_i}
    b[i][4]=b[i][4].split(', ').map{|q| q.to_i}
    b[i][5]=b[i][5].split(';;;; ').map{|q| q.split(';; ')}
    b[i][6]=b[i][6].split(', ').map{|q| q.to_i}
    b[i][8]=b[i][8].split(';; ').map{|q| q.split(', ')} unless b[i][8].nil?
  end
  @wyrmprints=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLWeapons.txt")
    b=[]
    File.open("#{@location}devkit/DLWeapons.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][4]=b[i][4].split(', ').map{|q| q.to_i}
    b[i][5]=b[i][5].split(', ').map{|q| q.to_i}
    b[i][6]=b[i][6].split(';; ')
    b[i][7]=b[i][7].split(', ').map{|q| q.to_i}
    b[i][11]=b[i][11].split(', ').map{|q| q.to_i}
    b[i][12]=b[i][12].split(';; ').map{|q| q.split(', ')} unless b[i][12].nil?
    b[i][13]=b[i][13].split(';;;; ').map{|q| q.split(';; ')} unless b[i][13].nil?
    b[i][16]='0' if b[i][16].nil?
    b[i][16]=b[i][16].to_i
    b[i][17]=b[i][17].split(', ').map{|q| q.to_i} unless b[i][17].nil?
    b[i][18]=b[i][18].split(';; ').map{|q| q.split(', ')} unless b[i][18].nil?
    b[i][19]=b[i][19].split(';; ').map{|q| q.split(', ')} unless b[i][19].nil?
    b[i][20]=b[i][20].split(';; ').map{|q| q.split(', ')} unless b[i][20].nil?
    b[i][21]=b[i][21].split(';; ').map{|q| q.split(', ')} unless b[i][21].nil?
    b[i][22]=b[i][22].split(';; ').map{|q| q.split(', ')} unless b[i][22].nil?
    b[i][23]=b[i][23].split(';; ').map{|q| q.split(', ')} unless b[i][23].nil?
    b[i][24]=b[i][24].split(';; ').map{|q| q.split(', ')} unless b[i][24].nil?
  end
  @weapons=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLSkills.txt")
    b=[]
    File.open("#{@location}devkit/DLSkills.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    if b[i][2]=='Skill'
      b[i][6]=b[i][6].split(', ')
      for i2 in 0...b[i][6].length
        b[i][6][i2]=b[i][6][i2].to_i unless i2%7==5
      end
      b[i][8]=b[i][8].to_f
      b[i][10]=b[i][10].split(', ') unless b[i][10].nil?
      b[i][12]=b[i][12].split(', ').map{|q| q.to_i}
    elsif b[i][2]=='Aura'
      b[i][4]=b[i][4].to_i
      b[i][6]=b[i][6].split(', ') unless b[i][6].nil?
    elsif b[i][2]=='Ability'
      b[i][4]=b[i][4].to_i
      b[i][6]=b[i][6].split(', ') unless b[i][6].nil?
    elsif b[i][2]=='CoAbility'
      b[i][4]=b[i][4].to_i
      b[i][6]=b[i][6].split(', ') unless b[i][6].nil?
    elsif b[i][2]=='Chain'
      b[i][4]=b[i][4].to_i
      b[i][6]=b[i][6].split(', ') unless b[i][6].nil?
    end
  end
  @askilities=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLFacilities.txt")
    b=[]
    File.open("#{@location}devkit/DLFacilities.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][3]=b[i][3].split(', ')
    b[i][5]=b[i][5].to_i
    b[i][6]=b[i][6].to_i
    if b[i][7]=='0'
      b[i][7]=nil
    else
      b[i][7]=b[i][7].split(';; ').map{|q| q.split(', ')}
      for i2 in 0...b[i][7].length
        b[i][7][i2][1]=b[i][7][i2][1].to_i
      end
    end
    b[i][8]=b[i][8].split(', ') unless b[i][8].nil?
  end
  @facilities=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLMaterials.txt")
    b=[]
    File.open("#{@location}devkit/DLMaterials.txt").each_line do |line|
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
    b[i][8]=b[i][8].split(', ') unless b[i][8].nil?
  end
  @mats=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLEnemies.txt")
    b=[]
    File.open("#{@location}devkit/DLEnemies.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][1]=b[i][1].split('; ').map{|q| q.split(', ')}.map{|q2| [q2[0],q2[1].to_i,q2[2].to_i]}
    b[i][2]=b[i][2].split(', ')
    b[i][3]=b[i][3].split(', ')
    b[i][4]=b[i][4].split(', ')
    b[i][5]=b[i][5].split(';; ') unless b[i][5].nil?
  end
  @enemies=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLBanners.txt")
    b=[]
    File.open("#{@location}devkit/DLBanners.txt").each_line do |line|
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
    b[i][7]=b[i][7].split(', ') unless b[i][7].nil?
  end
  @banners=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLEmotes.txt")
    b=[]
    File.open("#{@location}devkit/DLEmotes.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
  end
  @emotes=b.map{|q| q}
  if File.exist?("#{@location}devkit/DL_NPCs.txt")
    b=[]
    File.open("#{@location}devkit/DL_NPCs.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][1]=b[i][1].to_i
  end
  @npcs=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLStatus.txt")
    b=[]
    File.open("#{@location}devkit/DLStatus.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'').split('\\'[0])
    b[i][1]=b[i][1].to_i
  end
  @statuses=b.map{|q| q}
  if File.exist?("#{@location}devkit/DLVoid.txt")
    b=[]
    File.open("#{@location}devkit/DLVoid.txt").each_line do |line|
      b.push(line)
    end
  else
    b=[]
  end
  for i in 0...b.length
    b[i]=b[i].gsub("\n",'')
  end
  @voids=b.map{|q| q}
end

def prefixes_save()
  x=@prefixes
  open("#{@location}devkit/DLPrefix.rb", 'w') { |f|
    f.puts x.to_s.gsub('=>',' => ').gsub(', ',",\n  ").gsub('{',"@prefixes = {\n  ").gsub('}',"\n}")
  }
end

def metadata_load()
  if File.exist?("#{@location}devkit/DLSave.txt")
    b=[]
    File.open("#{@location}devkit/DLSave.txt").each_line do |line|
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
  if @server_data[0].length<@shards+1
    for i in 0...@shards+1
      @server_data[0][i]=0 if @server_data[0][i].nil?
    end
  end
  if @server_data[1].length<@shards+1
    for i in 0...@shards+1
      @server_data[1][i]=0 if @server_data[1][i].nil?
    end
  end
  @spam_channels=b[3]
  @spam_channels=[] if @spam_channels.nil?
end

def metadata_save()
  if @server_data[0].length<@shards+1
    for i in 0...@shards+1
      @server_data[0][i]=0 if @server_data[0][i].nil?
    end
  end
  if @server_data[1].length<@shards+1
    for i in 0...@shards+1
      @server_data[1][i]=0 if @server_data[1][i].nil?
    end
  end
  x=[@embedless.map{|q| q}, @ignored.map{|q| q}, @server_data.map{|q| q}, @spam_channels.map{|q| q}]
  open("#{@location}devkit/DLSave.txt", 'w') { |f|
    f.puts x[0].to_s
    f.puts x[1].to_s
    f.puts x[2].to_s
    f.puts x[3].to_s
    f.puts "\n"
  }
end

def nicknames_load(mode=1)
  if mode==2 && File.exist?("#{@location}devkit/DLNames2.txt")
    b=[]
    File.open("#{@location}devkit/DLNames.txt").each_line do |line|
      b.push(eval line)
    end
    return b
  elsif File.exist?("#{@location}devkit/DLNames.txt")
    b=[]
    File.open("#{@location}devkit/DLNames.txt").each_line do |line|
      b.push(eval line)
    end
  else
    b=[]
  end
  @aliases=b.reject{|q| q.nil? || q[1].nil? || q[2].nil?}.uniq
end

bot.command(:reboot, from: 167657750971547648) do |event| # reboots Botan - TRANSFERRED
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  puts 'DL!reboot'
  exec "cd #{@location}devkit && BotanBot.rb #{@shardizard}"
end

bot.command([:help,:commands,:command_list,:commandlist,:Help]) do |event, command, subcommand| # TRANSFERRED
  return nil if overlap_prevent(event)
  help_text(event,bot,command,subcommand)
end

def reload_library(x='')
  t=Time.now
  if x.downcase=='joke'
    if t-@last_multi_reload[0]>10*60
      @last_multi_reload[0]=t
      return true
    end
    return false
  end
  if t-@last_multi_reload[1]>60*60 || (@shardizard==4 && t-@last_multi_reload[1]>60)
    puts 'reloading BotanText'
    load "#{@location}devkit/BotanText.rb"
    @last_multi_reload[1]=t
  end
end

def help_text(event,bot,command=nil,subcommand=nil)
  reload_library()
  help_text_disp(event,bot,command,subcommand)
  return nil
end

def overlap_prevent(event,egg=true) # used to prevent servers with both Botan and her debug form from receiving two replies
  if event.server.nil? # failsafe code catching PMs as not a server
    return false
  elsif event.message.text.downcase.split(' ').include?('debug') && [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(event.server.id)
    return ![4].include?(@shardizard) # the debug bot can be forced to be used in the emoji servers by including the word "debug" in your message
  elsif event.message.text.downcase.split(' ').include?('smol') && [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(event.server.id)
    return ![-1].include?(@shardizard) # the debug bot can be forced to be used in the emoji servers by including the word "debug" in your message
  elsif [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(event.server.id) # emoji servers will use default Botan otherwise
    return [4,-1].include?(@shardizard)
  end
  return false
end

def find_adventurer(name,event,fullname=false,skipnpcs=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  adv=@adventurers.map{|q| q}
  return [] if name.length<2
  return [] if (find_npc(name,event,true).length>0 || name.downcase=='mym') && skipnpcs
  k=adv.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return adv[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Adventurer' && !(q[0]=='NPC' && @npcs.find_index{|q2| q2[0]==q[2]}.nil?)}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return adv[adv.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return adv[adv.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname || name.length<=2
  return [] if find_npc(name,event).length>0 && skipnpcs
  k=adv.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return adv[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return adv[adv.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return adv[adv.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_dragon(name,event,fullname=false,ext=false)
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
  return [] if fullname || name.length<=2
  k=@dragons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @dragons[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @dragons[@dragons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @dragons[@dragons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_wyrmprint(name,event,fullname=false,ext=false)
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
  return [] if fullname || name.length<=2
  k=@wyrmprints.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @wyrmprints[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @wyrmprints[@wyrmprints.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @wyrmprints[@wyrmprints.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_weapon(name,event,fullname=false,ext=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@weapons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @weapons[k] unless k.nil?
  lists=get_lookout_tags().reject{|q| q[2]!='Availability/Weapon'}.map{|q| [q[3],q[1]]}
  lists.unshift(['$',['Paid']])
  lists.unshift(['s',['Seasonal']])
  unless ext
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[2][0,1]}*#{q[3]}#{q[1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[2][0,1]}#{q[3]}#{q[1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[2][0,1]}*#{q[1]}#{q[3]}".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[2][0,1]}#{q[1]}#{q[3]}".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[3]}#{q[2][0,1]}*#{q[1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[3]}#{q[2][0,1]}#{q[1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[1]}#{q[2][0,1]}*#{q[3]}".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[1]}#{q[2][0,1]}#{q[3]}".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[3]}#{q[1]}#{q[2][0,1]}*".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[3]}#{q[1]}#{q[2][0,1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[1]}#{q[3]}#{q[2][0,1]}*".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    k=@weapons.find_index{|q| !lists.map{|q2| q2[0]}.include?(q[2][1,1]) && q[3]!='None' && "#{q[1]}#{q[3]}#{q[2][0,1]}".downcase==name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q[14]!='FEH'}
    return @weapons[k] unless k.nil?
    for i2 in 2...lists.length
      for i3 in 0...lists[i2][1].length
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[2][0,1]}*#{q[3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[2][0,1]}#{q[3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[2][0,1]}*#{q[1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[2][0,1]}#{q[1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[3]}#{q[2][0,1]}*#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[3]}#{q[2][0,1]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[1]}#{q[2][0,1]}*#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[1]}#{q[2][0,1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[3]}#{q[1]}#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[3]}#{q[1]}#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[1]}#{q[3]}#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{lists[i2][1][i3]}#{q[1]}#{q[3]}#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}*#{lists[i2][1][i3]}#{q[3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}#{lists[i2][1][i3]}#{q[3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}*#{lists[i2][1][i3]}#{q[1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}#{lists[i2][1][i3]}#{q[1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{lists[i2][1][i3]}#{q[2][0,1]}*#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{lists[i2][1][i3]}#{q[2][0,1]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{lists[i2][1][i3]}#{q[2][0,1]}*#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{lists[i2][1][i3]}#{q[2][0,1]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{lists[i2][1][i3]}#{q[1]}#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{lists[i2][1][i3]}#{q[1]}#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{lists[i2][1][i3]}#{q[3]}#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{lists[i2][1][i3]}#{q[3]}#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}*#{q[3]}#{lists[i2][1][i3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}#{q[3]}#{lists[i2][1][i3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}*#{q[1]}#{lists[i2][1][i3]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}#{q[1]}#{lists[i2][1][i3]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{q[2][0,1]}*#{lists[i2][1][i3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{q[2][0,1]}#{lists[i2][1][i3]}#{q[1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{q[2][0,1]}*#{lists[i2][1][i3]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{q[2][0,1]}#{lists[i2][1][i3]}#{q[3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{q[1]}#{lists[i2][1][i3]}#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{q[1]}#{lists[i2][1][i3]}#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{q[3]}#{lists[i2][1][i3]}#{q[2][0,1]}*".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{q[3]}#{lists[i2][1][i3]}#{q[2][0,1]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}*#{q[3]}#{q[1]}#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}#{q[3]}#{q[1]}#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}*#{q[1]}#{q[3]}#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[2][0,1]}#{q[1]}#{q[3]}#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{q[2][0,1]}*#{q[1]}#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{q[2][0,1]}#{q[1]}#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{q[2][0,1]}*#{q[3]}#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{q[2][0,1]}#{q[3]}#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{q[1]}#{q[2][0,1]}*#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[3]}#{q[1]}#{q[2][0,1]}#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{q[3]}#{q[2][0,1]}*#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=@weapons.reject{|q| q[2][1,1]!=lists[i2][0] || q[3]=='None' || "#{q[1]}#{q[3]}#{q[2][0,1]}#{lists[i2][1][i3]}".downcase != name.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
      end
    end
  end
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Weapon'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @weapons[@weapons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @weapons[@weapons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname || name.length<=2
  k=@weapons.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @weapons[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @weapons[@weapons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @weapons[@weapons.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_skill(name,event,fullname=false,ext=false)
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
  return [] if fullname || name.length<=2
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return sklz[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return sklz[sklz.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return sklz[sklz.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_ability(name,event,fullname=false,ext=false)
  data_load()
  name=normalize(name)
  romanums=['Ox0','I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII','XVIII','XIX','XX','XXI','XXII','XXIII','XXIV',
            'XXV','XXVI','XXVII','XXVIII','XXIX','XXX','XXXI','XXXII','XXXIII','XXXIV','XXXV','XXXVI','XXXVII','XXXVIII','XXXIX','XL','XLI','XLII','XLII',
            'XLIII','XLIV','XLV','XLVI','XLVII','XLVIII','XLIX','L']
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  sklz=@askilities.reject{|q| q[2]=='Skill' || q[1].nil?}
  sklz2=sklz.reject{|q| !romanums.include?(q[1])}
  return [] if name.length<2
  k=sklz2.reject{|q| "#{q[0]} #{romanums.find_index{|q2| q2==q[1]}}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz2.reject{|q| "#{romanums.find_index{|q2| q2==q[1]}} #{q[0]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[0]} #{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[0]} +#{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[1]} #{q[0]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[1].gsub('%','')} #{q[0]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return sklz.reject{|q| q[0]!=sklz[k][0]} unless k.nil?
  k=sklz.reject{|q| q[0].length<7 || q[0][0,7]!='Hits = ' || "#{q[1]} #{q[0]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
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
  k=alz.reject{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name[0,q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','').length] || !(q[2].nil? || q[2].include?(g))}.sort{|b,a| a[0].length<=>b[0].length}[0]
  unless k.nil?
    sklz2=sklz.reject{|q| q[0]!=k[1]}
    m=sklz2.find_index{|q| "#{k[0]}#{q[1]}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}+#{q[1]}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}#{q[1].gsub('%','')}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}+#{q[1].gsub('%','')}".downcase==name}
    return sklz2[m] unless m.nil?
  end
  k=alz.reject{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=name[0,q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','').length] || !(q[2].nil? || q[2].include?(g))}.sort{|b,a| a[0].length<=>b[0].length}[0]
  unless k.nil?
    sklz2=sklz.reject{|q| q[0]!=k[1]}
    m=sklz2.find_index{|q| "#{k[0]}#{q[1]}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}+#{q[1]}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}#{q[1].gsub('%','')}".downcase==name}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}+#{q[1].gsub('%','')}".downcase==name}
    return sklz2[m] unless m.nil?
  end
  return [] if fullname || name.length<=2
  k=sklz2.reject{|q| "#{romanums.find_index{|q2| q2==q[1]}} #{q[0]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[0]} #{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[0]} +#{q[1]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return sklz.reject{|q| q[0]!=sklz[k][0]} unless k.nil?
  k=sklz.reject{|q| "#{q[1]} #{q[0]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]!=name || name.length<=q[1].to_s.length || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q[1].gsub('%','')} #{q[0]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]!=name || name.length<=q[1].to_s.length || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=sklz.reject{|q| q[0].length<7 || q[0][0,7]!='Hits = ' || "#{q[1]} #{q[0]}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]!=name || q[1].downcase=='example'}
  return k.reject{|q| q[0]!=k[0][0]} unless k.nil? || k.length<=0
  k=alz.find_index{|q| q[0][0,name.length]!=q[0][0,name.length].to_i.to_s && q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| "#{q[0]} #{q[1]}"==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1]}
  end
  k=alz.find_index{|q| q[0].gsub('||','')[0,name.length]!=q[0].gsub('||','')[0,name.length].to_i.to_s && q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| "#{q[0]} #{q[1]}"==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1]}
  end
  return []
end

def find_facility(name,event,fullname=false,ext=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@facilities.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @facilities.reject{|q| q[0]!=@facilities[k][0]} unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Facility'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @facilities.reject{|q| q[0]!=alz[k][1]} unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @facilities.reject{|q| q[0]!=alz[k][1]} unless k.nil?
  return [] if fullname || name.length<=2
  k=@facilities.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @facilities.reject{|q| q[0]!=@facilities[k][0]} unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @facilities.reject{|q| q[0]!=alz[k][1]} unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @facilities.reject{|q| q[0]!=alz[k][1]} unless k.nil?
  return []
end

def find_mat(name,event,fullname=false,ext=false)
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
  return [] if fullname || name.length<=2
  k=@mats.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @mats[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @mats[@mats.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @mats[@mats.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_enemy(name,event,fullname=false,ext=false)
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
  return [] if fullname || name.length<=2
  k=@enemies.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @enemies[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @enemies[@enemies.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @enemies[@enemies.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_emote(name,event,fullname=false,ext=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@emotes.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @emotes[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Sticker'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @emotes[@emotes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @emotes[@emotes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname || name.length<=2
  k=@emotes.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @emotes[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @emotes[@emotes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @emotes[@emotes.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_npc(name,event,fullname=false,ext=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@npcs.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @npcs[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='NPC'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @npcs[@npcs.find_index{|q| q[0]==alz[k][1]}] unless k.nil? || @npcs.find_index{|q| q[0]==alz[k][1]}.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @npcs[@npcs.find_index{|q| q[0]==alz[k][1]}] unless k.nil? || @npcs.find_index{|q| q[0]==alz[k][1]}.nil?
  return [] if fullname || name.length<=2
  k=@npcs.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @npcs[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @npcs[@npcs.find_index{|q| q[0]==alz[k][1]}] unless k.nil? || @npcs.find_index{|q| q[0]==alz[k][1]}.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @npcs[@npcs.find_index{|q| q[0]==alz[k][1]}] unless k.nil? || @npcs.find_index{|q| q[0]==alz[k][1]}.nil?
  return []
end

def find_status(name,event,fullname=false,ext=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@statuses.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @statuses[k] unless k.nil?
  nicknames_load()
  alz=@aliases.reject{|q| q[0]!='Status'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @statuses[@statuses.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name && (q[2].nil? || q[2].include?(g))}
  return @statuses[@statuses.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return [] if fullname || name.length<=2
  k=@statuses.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @statuses[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @statuses[@statuses.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && (q[2].nil? || q[2].include?(g))}
  return @statuses[@statuses.find_index{|q| q[0]==alz[k][1]}] unless k.nil?
  return []
end

def find_banner(name,event,fullname=false,ext=false)
  data_load()
  name=normalize(name)
  name=name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return [] if name.length<2
  k=@banners.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==name}
  return @banners[k] unless k.nil?
  k=@banners.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')=="the#{name}" && q[0][0,4].downcase=='the '}
  return @banners[k] unless k.nil?
  k=@banners.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')=="a#{name}" && q[0][0,2].downcase=='a '}
  return @banners[k] unless k.nil?
  k=@banners.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')=="an#{name}" && q[0][0,3].downcase=='an '}
  return @banners[k] unless k.nil?
  k=@banners.find_index{|q| !q[7].nil? && q[7].map{|q2| q2.downcase}.include?(name)}
  return @banners[k] unless k.nil?
  return [] if fullname || name.length<=2
  k=@banners.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name}
  return @banners[k] unless k.nil?
  k=@banners.find_index{|q| q[0].downcase.gsub('the ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[0][0,4].downcase=='the '}
  return @banners[k] unless k.nil?
  k=@banners.find_index{|q| q[0].downcase.gsub('a ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[0][0,2].downcase=='a '}
  return @banners[k] unless k.nil?
  k=@banners.find_index{|q| q[0].downcase.gsub('an ','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,name.length]==name && q[0][0,3].downcase=='an '}
  return @banners[k] unless k.nil?
  k=@banners.find_index{|q| !q[7].nil? && q[7].map{|q2| q2[0,name.length].downcase}.include?(name)}
  return @banners[k] unless k.nil?
  return []
end

def find_data_ex(callback,name,event,fullname=false,ext=false,includematch=false)
  k=method(callback).call(name,event,true,ext)
  return [k,name] if includematch && k.length>0
  return k if k.length>0
  blank=[]
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(callback).call(args[i,args.length-i-i2].join(' '),event,true,ext)
      return [k,args[i,args.length-i-i2].join(' ')] if includematch && k.length>0 && args[i,args.length-i-i2].length>0
      return k if k.length>0 && args[i,args.length-i-i2].length>0
    end
  end
  return blank if fullname || name.length<=2
  k=method(callback).call(name,event,false,ext)
  return [k,name] if includematch && k.length>0
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(callback).call(args[i,args.length-i-i2].join(' '),event,false,ext)
      return [k,args[i,args.length-i-i2].join(' ')] if includematch && k.length>0 && args[i,args.length-i-i2].length>0
      return k if k.length>0 && args[i,args.length-i-i2].length>0
    end
  end
  return blank
end

def find_best_match(name,bot,event,fullname=false,ext=false,mode=1,ext2=nil)
  functions=[[:find_adventurer,:disp_adventurer_stats,:disp_adventurer_art,:disp_adventurer_stats,:find_adv_alts],
             [:find_dragon,:disp_dragon_stats,:disp_dragon_art,:disp_dragon_stats,:find_dragon_alts],
             [:find_wyrmprint,:disp_wyrmprint_stats,:disp_wyrmprint_art,:disp_wyrmprint_stats],
             [:find_weapon,:disp_weapon_stats,nil,:disp_weapon_stats],
             [:find_enemy,:disp_enemy_data,:disp_boss_art],
             [:find_skill,:disp_skill_data],
             [:find_ability,:disp_ability_data],
             [:find_status,:disp_status_data],
             [:find_facility,:disp_facility_data],
             [:find_mat,:disp_mat_data],
             [:find_emote,:disp_emote_art,:disp_emote_art],
             [:find_npc,:disp_npc_art,:disp_npc_art]]
  for i3 in 0...functions.length
    k=method(functions[i3][0]).call(name,event,true,ext)
    return method(functions[i3][mode]).call(bot,event,name.split(' '),ext2) if !functions[i3][mode].nil? && k.length>0
  end
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      for i3 in 0...functions.length
        k=method(functions[i3][0]).call(args[i,args.length-i-i2].join(' '),event,true,ext)
        return method(functions[i3][mode]).call(bot,event,args,ext2) if !functions[i3][mode].nil? && k.length>0 && args[i,args.length-i-i2].length>0
      end
    end
  end
  event.respond 'No matches found.' if (fullname || name.length<=2) && mode>1
  return nil if fullname || name.length<=2
  for i3 in 0...functions.length
    k=method(functions[i3][0]).call(name,event,false,ext)
    return method(functions[i3][mode]).call(bot,event,name.split(' '),ext2) if !functions[i3][mode].nil? && k.length>0
  end
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(functions[i3][0]).call(args[i,args.length-i-i2].join(' '),event,false,ext)
      return method(functions[i3][mode]).call(bot,event,args,ext2) if !functions[i3][mode].nil? && k.length>0 && args[i,args.length-i-i2].length>0
    end
  end
  event.respond 'No matches found.' if mode>1
  return nil
end

def generate_rarity_row(rar,blanks=0,feh='',hyperblanks=false)
  blanks=rar*1 if blanks<=0
  disprar=rar*1
  disprar=blanks*1 if rar<=0
  return "#{['<:FGO_Rarity_S:577774548280147969>','<:FGO_icon_rarity_dark:571937156981981184>','<:FGO_icon_rarity_sickly:571937157095227402>','<:FGO_icon_rarity_rust:523903558928826372>','<:FGO_icon_rarity_mono:523903551144198145>','<:FGO_icon_rarity_gold:523858991571533825>'][rar]*([disprar,blanks].min)}#{'<:FGO_rarity_inverted:544568437029208094>'*(blanks-disprar) if blanks>disprar}#{'<:Blank:676220519690928179>'*(6-blanks) if hyperblanks}" if feh=='FGO'
  return "#{['<:Icon_Rarity_S:448266418035621888>','<:Icon_Rarity_1:448266417481973781>','<:Icon_Rarity_2:448266417872044032>','<:Icon_Rarity_3:448266417934958592>','<:Icon_Rarity_4:448266418459377684>','<:Icon_Rarity_5:448266417553539104>','<:Icon_Rarity_6:491487784650145812>','<:Icon_Rarity_S:448266418035621888>'][rar]*([disprar,blanks].min)}#{'<:Icon_Rarity_Empty:631460895851282433>'*(blanks-disprar) if blanks>disprar}#{'<:Blank:676220519690928179>'*(6-blanks) if hyperblanks}" if feh=='FEH'
  return "#{@rarity_stars[0][rar]*([disprar,blanks].min)}#{@rarity_stars[1][rar]*(blanks-disprar) if blanks>disprar}#{'<:Blank:676220519690928179>'*(6-blanks) if hyperblanks}"
end

def element_color(ele)
  return 0xE73031 if ele=='Flame'
  return 0x1890DE if ele=='Water'
  return 0x00D771 if ele=='Wind'
  return 0xFFB90F if ele=='Light'
  return 0xA637DE if ele=='Shadow'
  return 0x849294
end

def element_emote(ele,bot,feh='')
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{ele.gsub('None','Null')}"}
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{ele.gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Anima')}"} if feh=='FEH'
  return moji[0].mention if moji.length>0
  return ''
end

def adv_emoji(k,bot,ignorefeh=false,advheader=false)
  t=Time.now
  timeshift=7
  timeshift-=1 unless (t-24*60*60).dst?
  t-=60*60*timeshift
  if advheader
    ignorefeh=false
  elsif t.year==2019
    ignorefeh=false if t.month==4
    ignorefeh=false if t.month==5 && t.day<=12
  end
  str=''
  if !k[12].nil? && k[12]=='MM'
    str=@rarity_stars[0][k[1][0,1].to_i] unless advheader
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][1]}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}#{"#{k[2][1]}  " if advheader}"
    wpn='<:Icon_Weapon_Gear:641466825212821514>'
    str="#{str}#{wpn}#{"#{k[2][2]}  " if advheader}"
    unless k[2][3].nil?
      moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "MC_#{k[2][3].gsub(' ','_')}"}
      str="#{str}#{moji[0].mention unless moji.length<=0}#{"#{k[2][3]}  " if advheader}"
    end
    moji=[]
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2][0].gsub('Healer','Healing')}"} unless k[2][0].nil?
    str="#{str}#{moji[0].mention unless moji.length<=0}#{k[2][0] if advheader}"
    str="#{str}<:Mega_Man:641484836304846857>" if !k[12].nil? && k[12]=='MM' && !advheader
  elsif !k[12].nil? && k[12]=='FEH' && !ignorefeh
    str=['','<:Icon_Rarity_1:448266417481973781>','<:Icon_Rarity_2:448266417872044032>','<:Icon_Rarity_3:448266417934958592>','<:Icon_Rarity_4:448266418459377684>','<:Icon_Rarity_5:448266417553539104>','<:Icon_Rarity_6:491487784650145812>'][k[1][0,1].to_i] unless advheader
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[2][1].gsub('Shadow','Dark').gsub('Flame','Fire')}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}#{"#{k[2][1]}  " if advheader}"
    wpn='<:Gold_Unknown:774013610908188682>'
    wpn='<:Red_Blade:443172811830198282>' if k[2][2]=='Sword'
    wpn='<:Colorless_Blade:443692132310712322>' if k[2][2]=='Blade'
    wpn='<:Colorless_Dagger:443692132683743232>' if k[2][2]=='Dagger'
    wpn='<:Green_Blade:467122927230386207>' if k[2][2]=='Axe'
    wpn='<:Colorless_Bow:443692132616896512>' if k[2][2]=='Bow'
    wpn='<:Blue_Blade:467112472768151562>' if k[2][2]=='Lance'
    wpn='<:Colorless_Tome:443692133317345290>' if k[2][2]=='Wand'
    wpn='<:Red_Tome:443172811826003968>' if k[2][2]=='Wand' && ['Flame','Shadow'].include?(k[2][1])
    wpn='<:Blue_Tome:467112472394858508>' if k[2][2]=='Wand' && ['Water','Light'].include?(k[2][1])
    wpn='<:Green_Tome:467122927666593822>' if k[2][2]=='Wand' && k[2][1]=='Wind'
    wpn='<:Colorless_Staff:443692132323295243>' if k[2][2]=='Staff'
    wpn='<:Summon_Gun:467557566050861074>' if k[2][2]=='Manacaster'
    str="#{str}#{wpn}#{"#{k[2][2]}  " if advheader}"
    clzz='<:Resource_Structure:510774545154572298>'
    clzz='<:Skill_Weapon:444078171114045450>' if k[2][0]=='Attack'
    clzz='<:Skill_Special:444078170665254929>' if k[2][0]=='Support'
    clzz='<:Defense_Shield:570987444309196835>' if k[2][0]=='Defense'
    clzz='<:Healing_Rod:570991014894895104>' if k[2][0]=='Healer'
    str="#{str}#{clzz}#{k[2][0] if advheader}"
    str="#{str}<:Great_Badge_Golden:443704781068959744>" if !k[12].nil? && k[12]=='FEH' && !advheader
  elsif !k[12].nil? && k[12]=='FGO' && !ignorefeh
    str=''
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][1]}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}#{"#{k[2][1]}  " if advheader}"
    clzz='unknown'
    clzz='saber' if k[2][2]=='Sword'
    clzz='blade' if k[2][2]=='Blade'
    clzz='extra' if k[2][2]=='Dagger'
    clzz='berserker' if k[2][2]=='Axe'
    clzz='archer' if k[2][2]=='Bow'
    clzz='lancer' if k[2][2]=='Lance'
    clzz='caster' if k[2][2]=='Wand'
    clzz='healer' if k[2][2]=='Staff'
    clzz='mooncancer' if k[2][2]=='Manacaster'
    srv=523821178670940170
    srv=523825319916994564 if ['Staff','Blade'].include?(k[2][2])
    unless k[2][3].nil?
      moji=bot.server(523830882453422120).emoji.values.reject{|q| q.name != "FGO_#{k[2][3].gsub(' ','_')}"}
      str="#{str}#{moji[0].mention unless moji.length<=0}#{"#{k[2][3]}  " if advheader}"
    end
    clr='gold'
    clr='silver' if k[1][0,1].to_i==4
    clr='bronze' if k[1][0,1].to_i<4
    moji=bot.server(srv).emoji.values.reject{|q| q.name != "class_#{clzz}_#{clr}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}#{"#{k[2][2]}  " if advheader}"
    clzz=''
    clzz='<:Buster_y:526556105422274580>' if k[2][0]=='Attack'
    clzz='<:support:572315955397394452>' if k[2][0]=='Support'
    clzz='<:Arts_y:526556105489252352>' if k[2][0]=='Defense'
    clzz='<:healing:572342852420501506>' if k[2][0]=='Healer'
    str="#{str}#{clzz}#{k[2][0] if advheader}"
    str="#{str}<:Bond:613804021119189012>" if !k[12].nil? && k[12]=='FGO' && !advheader
  else
    str=@rarity_stars[0][k[1][0,1].to_i] unless advheader
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][1]}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}#{"#{k[2][1]}  " if advheader}"
    unless k[2][3].nil?
      moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "MC_#{k[2][3].gsub(' ','_')}"}
      str="#{str}#{moji[0].mention unless moji.length<=0}#{"#{k[2][3]}  " if advheader}"
    end
    moji=[]
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[2][2]}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}#{"#{k[2][2]}  " if advheader}"
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2][0].gsub('Healer','Healing')}"} unless k[2][0].nil?
    str="#{str}#{moji[0].mention unless moji.length<=0}#{k[2][0] if advheader}"
    str="#{str}<:MH_Rathalos:669319247670804506>" if !k[12].nil? && k[12]=='MH' && !advheader
    str="#{str}<:Mega_Man:641484836304846857>" if !k[12].nil? && k[12]=='MM' && !advheader
    str="#{str}<:Great_Badge_Golden:443704781068959744>" if !k[12].nil? && k[12]=='FEH' && !advheader
    str="#{str}<:Bond:613804021119189012>" if !k[12].nil? && k[12]=='FGO' && !advheader
    str="#{str}<:Priconne:782554046887493652>" if !k[12].nil? && k[12]=='PC' && !advheader
    str="#{str}<:Take_Your_Heart:782553893204262923>" if !k[12].nil? && k[12]=='P5S' && !advheader
  end
  return str
end

def dragon_emoji(k,bot,ignorefeh=false)
  t=Time.now
  timeshift=7
  timeshift-=1 unless (t-24*60*60).dst?
  t-=60*60*timeshift
  if t.year==2019
    ignorefeh=false if t.month==4
    ignorefeh=false if t.month==5 && t.day<=12
  end
  if !k[16].nil? && k[16]=='FEH' && !ignorefeh
    str=['','<:Icon_Rarity_1:448266417481973781>','<:Icon_Rarity_2:448266417872044032>','<:Icon_Rarity_3:448266417934958592>','<:Icon_Rarity_4:448266418459377684>','<:Icon_Rarity_5:448266417553539104>','<:Icon_Rarity_6:491487784650145812>'][k[1][0,1].to_i]
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[2].gsub('Shadow','Dark').gsub('Flame','Fire')}"}
    color='Colorless'
    color='Red' if ['Flame','Shadow'].include?(k[2])
    color='Blue' if ['Water','Light'].include?(k[2])
    color='Green' if ['Wind'].include?(k[0][2])
    moji2=bot.server(443172595580534784).emoji.values.reject{|q| q.name != "#{color}_Dragon"}
    str="#{str}#{moji[0].mention unless moji.length<=0}#{moji2[0].mention unless moji2.length<=0}<:Great_Badge_Golden:443704781068959744>"
  elsif !k[16].nil? && k[16]=='FGO' && !ignorefeh
    str=['','<:FGO_icon_rarity_dark:571937156981981184>','<:FGO_icon_rarity_sickly:571937157095227402>','<:FGO_icon_rarity_rust:523903558928826372>','<:FGO_icon_rarity_mono:523903551144198145>','<:FGO_icon_rarity_gold:523858991571533825>'][k[1][0,1].to_i]
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2]}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}<:Bond:613804021119189012>"
  else
    str=@rarity_stars[0][k[1][0,1].to_i]
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2]}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}"
    str="#{str}<:Great_Badge_Golden:443704781068959744>" if !k[16].nil? && k[16]=='FEH'
    str="#{str}<:MH_Rathalos:669319247670804506>" if !k[16].nil? && k[16]=='MH'
    str="#{str}<:Mega_Man:641484836304846857>" if !k[16].nil? && k[16]=='MM'
    str="#{str}<:Bond:613804021119189012>" if !k[16].nil? && k[16]=='FGO'
    str="#{str}<:Priconne:782554046887493652>" if !k[16].nil? && k[16]=='PC' && !advheader
    str="#{str}<:Take_Your_Heart:782553893204262923>" if !k[16].nil? && k[16]=='P5S' && !advheader
  end
  return str
end

def print_emoji(k,bot,ignorefeh=false)
  t=Time.now
  timeshift=7
  timeshift-=1 unless (t-24*60*60).dst?
  t-=60*60*timeshift
  if t.year==2019
    ignorefeh=false if t.month==4
    ignorefeh=false if t.month==5 && t.day<=12
  end
  if !k[10].nil? && k[10]=='FEH' && !ignorefeh
    str=['','<:Icon_Rarity_1:448266417481973781>','<:Icon_Rarity_2:448266417872044032>','<:Icon_Rarity_3:448266417934958592>','<:Icon_Rarity_4:448266418459377684>','<:Icon_Rarity_5:448266417553539104>','<:Icon_Rarity_6:491487784650145812>'][k[1][0,1].to_i]
    clzz='<:Resource_Structure:510774545154572298>'
    clzz='<:Skill_Weapon:444078171114045450>' if k[2][0]=='Attack'
    clzz='<:Skill_Special:444078170665254929>' if k[2][0]=='Support'
    clzz='<:Defense_Shield:570987444309196835>' if k[2][0]=='Defense'
    clzz='<:Healing_Rod:570991014894895104>' if k[2][0]=='Healer'
    str="#{str}#{clzz}"
  elsif !k[10].nil? && k[10]=='FGO' && !ignorefeh
    str=['','<:FGO_icon_rarity_dark:571937156981981184>','<:FGO_icon_rarity_sickly:571937157095227402>','<:FGO_icon_rarity_rust:523903558928826372>','<:FGO_icon_rarity_mono:523903551144198145>','<:FGO_icon_rarity_gold:523858991571533825>'][k[1][0,1].to_i]
    clzz=''
    clzz='<:Buster_y:526556105422274580>' if k[2][0]=='Attack'
    clzz='<:support:572315955397394452>' if k[2][0]=='Support'
    clzz='<:Arts_y:526556105489252352>' if k[2][0]=='Defense'
    clzz='<:healing:572342852420501506>' if k[2][0]=='Healer'
    str="#{str}#{clzz}"
  else
    str=@rarity_stars[0][k[1][0,1].to_i]
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2][0]}"}
    moji2=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{k[2][1]}"}
    str="<:Wyrmprint:560542319636381725>#{str}#{moji2[0].mention unless moji2.length<=0}#{moji[0].mention unless moji.length<=0}"
    str="#{str}<:Great_Badge_Golden:443704781068959744>" if !k[10].nil? && k[10]=='FEH'
    str="#{str}<:MH_Rathalos:669319247670804506>" if !k[10].nil? && k[10]=='MH'
    str="#{str}<:Mega_Man:641484836304846857>" if !k[10].nil? && k[10]=='MM'
    str="#{str}<:Bond:613804021119189012>" if !k[10].nil? && k[10]=='FGO'
    str="#{str}<:Priconne:782554046887493652>" if !k[10].nil? && k[10]=='PC' && !advheader
    str="#{str}<:Take_Your_Heart:782553893204262923>" if !k[10].nil? && k[10]=='P5S' && !advheader
  end
  return str
end

def weapon_emoji(k,bot,ignorefeh=false)
  t=Time.now
  timeshift=7
  timeshift-=1 unless (t-24*60*60).dst?
  t-=60*60*timeshift
  if t.year==2019
    ignorefeh=false if t.month==4
    ignorefeh=false if t.month==5 && t.day<=12
  end
  if !k[14].nil? && k[14]=='FEH' && !ignorefeh
    str=['','<:Icon_Rarity_1:448266417481973781>','<:Icon_Rarity_2:448266417872044032>','<:Icon_Rarity_3:448266417934958592>','<:Icon_Rarity_4:448266418459377684>','<:Icon_Rarity_5:448266417553539104>','<:Icon_Rarity_6:491487784650145812>'][k[2][0,1].to_i]
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[3].gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Anima')}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}"
    wpn='<:Gold_Unknown:774013610908188682>'
    wpn='<:Red_Blade:443172811830198282>' if k[1]=='Sword'
    wpn='<:Colorless_Blade:443692132310712322>' if k[1]=='Blade'
    wpn='<:Colorless_Dagger:443692132683743232>' if k[1]=='Dagger'
    wpn='<:Green_Blade:467122927230386207>' if k[1]=='Axe'
    wpn='<:Colorless_Bow:443692132616896512>' if k[1]=='Bow'
    wpn='<:Blue_Blade:467112472768151562>' if k[1]=='Lance'
    wpn='<:Colorless_Tome:443692133317345290>' if k[1]=='Wand'
    wpn='<:Red_Tome:443172811826003968>' if k[1]=='Wand' && ['Flame','Shadow'].include?(k[3])
    wpn='<:Blue_Tome:467112472394858508>' if k[1]=='Wand' && ['Water','Light'].include?(k[3])
    wpn='<:Green_Tome:467122927666593822>' if k[1]=='Wand' && k[3]=='Wind'
    wpn='<:Colorless_Staff:443692132323295243>' if k[1]=='Staff'
    wpn='<:Summon_Gun:467557566050861074>' if k[1]=='Manacaster'
    str="#{str}#{wpn}"
    str="#{str}<:Current_Tempest_Bonus:498797966740422656>" if k[2].length>1 && k[2][1,1].downcase=='v'
  elsif !k[14].nil? && k[14]=='FGO' && !ignorefeh
    str=['','<:FGO_icon_rarity_dark:571937156981981184>','<:FGO_icon_rarity_sickly:571937157095227402>','<:FGO_icon_rarity_rust:523903558928826372>','<:FGO_icon_rarity_mono:523903551144198145>','<:FGO_icon_rarity_gold:523858991571533825>'][k[2][0,1].to_i]
    str=''
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[3]}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}"
    clzz='unknown'
    clzz='saber' if k[1]=='Sword'
    clzz='blade' if k[1]=='Blade'
    clzz='extra' if k[1]=='Dagger'
    clzz='berserker' if k[1]=='Axe'
    clzz='archer' if k[1]=='Bow'
    clzz='lancer' if k[1]=='Lance'
    clzz='caster' if k[1]=='Wand'
    clzz='healer' if k[1]=='Staff'
    clzz='mooncancer' if k[1]=='Manacaster'
    srv=523821178670940170
    srv=523825319916994564 if ['Staff','Blade'].include?(k[1])
    clr='gold'
    clr='silver' if k[2][0,1].to_i==4
    clr='bronze' if k[2][0,1].to_i<4
    moji=bot.server(srv).emoji.values.reject{|q| q.name != "class_#{clzz}_#{clr}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}"
    str="#{str}<:class_beast_gold:562413138356731905>" if k[2].length>1 && k[2][1,1].downcase=='v'
  else
    str=@rarity_stars[0][k[2][0,1].to_i]
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[3].gsub('None','Null')}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}"
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[1]}"}
    str="#{str}#{moji[0].mention unless moji.length<=0}"
    str="#{str}<:Element_Void:548467446734913536>" if k[2].length>1 && k[2][1,1].downcase=='v'
    str="#{str}<:Tribe_Dragon:549947361745567754>" if k[2].length>1 && k[2][1,1].downcase=='h'
    str="#{str}<:Great_Badge_Golden:443704781068959744>" if !k[14].nil? && k[14]=='FEH'
    str="#{str}<:Mega_Man:641484836304846857>" if !k[14].nil? && k[14]=='MM'
    str="#{str}<:MH_Rathalos:669319247670804506>" if !k[14].nil? && k[14]=='MH'
    str="#{str}<:Bond:613804021119189012>" if !k[14].nil? && k[14]=='FGO'
    str="#{str}<:Priconne:782554046887493652>" if !k[14].nil? && k[14]=='PC' && !advheader
    str="#{str}<:Take_Your_Heart:782553893204262923>" if !k[14].nil? && k[14]=='P5S' && !advheader
  end
  return str
end

def enemy_emoji(k,bot)
  str=''
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][0]}"}
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[2][0].gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Null')}"} if k[2].length>3 && k[2][3][0,11]=='Fire Emblem'
  str="#{str}#{moji[0].mention unless moji.length<=0}"
  moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{k[2][1]}"}
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Icon_Move_Infantry"} if k[2].length>3 && k[2][3][0,11]=='Fire Emblem'
  moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Icon_Move_Armor"} if k[2].length>3 && k[2][3][0,11]=='Fire Emblem' && !k[0].include?('(Enemy)')
  sty=''
  sty='<:Great_Badge_Golden:443704781068959744>' if k[2].length>3 && k[2][3][0,11]=='Fire Emblem'
  sty='<:Mega_Man:641484836304846857>' if k[2].length>3 && k[2][3]=='Mega Man: Chaos Protocol'
  sty='<:MH_Rathalos:669319247670804506>' if k[2].length>3 && k[2][3]=='Monster Hunter: Primal Crisis'
  str="#{str}#{moji[0].mention unless moji.length<=0}#{sty}"
  return str
end

def energy_emoji(k,pad=false)
  e=[]
  ins=[]
  for i in 0...k.length
    e.push(k[i][1,k[i].length-1].to_i) if k[i][0,1]=='E' && k[i][1,k[i].length-1].to_i.to_s==k[i][1,k[i].length-1]
    ins.push(k[i][1,k[i].length-1].to_i) if k[i][0,1]=='I' && k[i][1,k[i].length-1].to_i.to_s==k[i][1,k[i].length-1]
  end
  s=''
  if pad
    s=", <:Energy:534451856286679040>#{e.sort.map{|q|micronumber(q)}.join(' ')} Energy increase" if e.length>0
    s="#{s}, <:Inspiration:688916574643421283>#{ins.sort.map{|q|micronumber(q)}.join(' ')} Inspiration increase" if ins.length>0
  else
    s="<:Energy:534451856286679040>#{e.sort.map{|q|micronumber(q)}.join(' ')}" if e.length>0
    s="#{s}<:Inspiration:688916574643421283>#{ins.sort.map{|q|micronumber(q)}.join(' ')}" if ins.length>0
  end
  return s
end

def get_lookout_tags()
  if File.exist?("#{@location}devkit/DLSkillSubsets.txt")
    lookout=[]
    File.open("#{@location}devkit/DLSkillSubsets.txt").each_line do |line|
      lookout.push(eval line)
    end
  else
    lookout=[]
  end
  return lookout
end

def disp_adventurer_stats(bot,event,args=nil,juststats=false)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_adventurer,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  elsif event.user.id==224870997390524416 && k[9][0].gsub('*','')=='Noelle'
    puts 'Noelleshift for Dan.'
    x=@adventurers.reject{|q| q[9][0].gsub('*','')!='Melody'}
    disp_adventurer_stats(bot,event,x.sample[0].split(' '),juststats)
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  juststats=true if @shardizard != 4 && event.message.text.downcase.split(' ').include?('smol')
  rar=-1
  for i in 0...args.length
    rar=args[i].to_i if rar<0 && args[i].to_i.to_s==args[i] && args[i].to_i>2 && args[i].to_i<@max_rarity[0]+2
    rar=args[i].to_i if rar<0 && args[i][1,1]=='*' && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>2 && args[i][0,1].to_i<@max_rarity[0]+2
    rar=5 if rar<0 && ['50','50mc'].include?(args[i].downcase)
  end
  semirar=false
  if rar<0
    semirar=true
    rar=k[1][0,1].to_i
    unless juststats || s2s
      rar=0
      rar=@max_rarity[0] unless (!k[3][1][@max_rarity[0]].nil? && k[3][1][@max_rarity[0]]>0) || (!k[4][1][@max_rarity[0]].nil? && k[4][1][@max_rarity[0]]>0)
    end
  elsif rar>k[1][0,1].to_i && s2s
    semirar=true
    rar=k[1][0,1].to_i
  elsif rar>k[1][0,1].to_i && !((!k[3][1][@max_rarity[0]].nil? && k[3][1][@max_rarity[0]]>0) || (!k[4][1][@max_rarity[0]].nil? && k[4][1][@max_rarity[0]]>0))
    rar=k[1][0,1].to_i
    rar=@max_rarity[0] unless juststats || s2s
  end
  title=''
  titlex=[]
  str=''
  if !k[12].nil? && k[12]=='MM'
    unless s2s || juststats
      str="#{generate_rarity_row(rar,@max_rarity[0],'',false)}"
      str="#{str} (#{"Mana Spiral, " if rar>@max_rarity[0]}from #{k[1][0,1].to_i}#{@rarity_stars[0][k[1][0,1].to_i]})" unless rar==k[1][0,1].to_i
    end
    titlex=["#{generate_rarity_row(rar,@max_rarity[0],'',false)}"]
    titlex.push("(#{"Mana Spiral, " if rar>@max_rarity[0]}from #{k[1][0,1].to_i}#{@rarity_stars[0][k[1][0,1].to_i]})") unless rar==k[1][0,1].to_i
    titlex.push("<:ProtoShield:642287078943752202>#{longFormattedNumber(k[5][0])}")
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][1]}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][1]}**"
    wpn='<:Icon_Weapon_Gear:641466825212821514>'
    title="#{title}\n#{wpn}[Alt-]**#{k[2][2]}**  <:ProtoShield:642287078943752202>#{longFormattedNumber(k[5][0])}"
    moji=[]
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2][0].gsub('Healer','Healing')}"} unless k[2][0].nil?
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][0]}**"
    title="#{title}\n<:Mega_Man:641484836304846857>**Mega Man Collab**"
  elsif !k[12].nil? && ['MH','PC','P5S'].include?(k[12])
    unless s2s || juststats
      str="#{generate_rarity_row(rar,@max_rarity[0],'',false)}"
      str="#{str} (#{"Mana Spiral, " if rar>@max_rarity[0]}from #{k[1][0,1].to_i}#{@rarity_stars[0][k[1][0,1].to_i]})" unless rar==k[1][0,1].to_i
    end
    titlex=["#{generate_rarity_row(rar,@max_rarity[0],'',false)}"]
    titlex.push("(#{"Mana Spiral, " if rar>@max_rarity[0]}from #{k[1][0,1].to_i}#{@rarity_stars[0][k[1][0,1].to_i]})") unless rar==k[1][0,1].to_i
    titlex.push("<:Defense:573344832282689567>#{longFormattedNumber(k[5][0])}")
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][1]}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][1]}**"
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[2][2]}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][2]}**  <:Defense:573344832282689567>#{longFormattedNumber(k[5][0])}"
    title="#{title}\n #{k[2][3]}" unless k[2][3].nil?
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2][0].gsub('Healer','Healing')}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][0]}**"
    title="#{title}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**" if k[12]=='MH'
    title="#{title}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**" if k[12]=='PC'
    title="#{title}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**" if k[12]=='P5S'
  elsif !k[12].nil? && k[12]=='FEH'
    unless s2s || juststats
      str="#{generate_rarity_row(rar,@max_rarity[0],'FEH',false)}"
      str="#{str} (#{"Mana Spiral, " if rar>@max_rarity[0]}from #{k[1][0,1].to_i}#{['','<:Icon_Rarity_1:448266417481973781>','<:Icon_Rarity_2:448266417872044032>','<:Icon_Rarity_3:448266417934958592>','<:Icon_Rarity_4:448266418459377684>','<:Icon_Rarity_5:448266417553539104>','<:Icon_Rarity_6:491487784650145812>'][k[1][0,1].to_i]})" unless rar==k[1][0,1].to_i
    end
    titlex=["#{generate_rarity_row(rar,@max_rarity[0],'FEH',false)}"]
    titlex.push("(#{"Mana Spiral, " if rar>@max_rarity[0]}from #{k[1][0,1].to_i}#{['','<:Icon_Rarity_1:448266417481973781>','<:Icon_Rarity_2:448266417872044032>','<:Icon_Rarity_3:448266417934958592>','<:Icon_Rarity_4:448266418459377684>','<:Icon_Rarity_5:448266417553539104>','<:Icon_Rarity_6:491487784650145812>'][k[1][0,1].to_i]})") unless rar==k[1][0,1].to_i
    titlex.push("<:DefenseS:514712247461871616>#{longFormattedNumber(k[5][0])}")
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[2][1].gsub('Shadow','Dark').gsub('Flame','Fire')}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][1]}**"
    wpn='<:Gold_Unknown:774013610908188682>'
    wpn='<:Red_Blade:443172811830198282>' if k[2][2]=='Sword'
    wpn='<:Colorless_Blade:443692132310712322>' if k[2][2]=='Blade'
    wpn='<:Colorless_Dagger:443692132683743232>' if k[2][2]=='Dagger'
    wpn='<:Green_Blade:467122927230386207>' if k[2][2]=='Axe'
    wpn='<:Colorless_Bow:443692132616896512>' if k[2][2]=='Bow'
    wpn='<:Blue_Blade:467112472768151562>' if k[2][2]=='Lance'
    wpn='<:Colorless_Tome:443692133317345290>' if k[2][2]=='Wand'
    wpn='<:Red_Tome:443172811826003968>' if k[2][2]=='Wand' && ['Flame','Shadow'].include?(k[2][1])
    wpn='<:Blue_Tome:467112472394858508>' if k[2][2]=='Wand' && ['Water','Light'].include?(k[2][1])
    wpn='<:Green_Tome:467122927666593822>' if k[2][2]=='Wand' && k[2][1]=='Wind'
    wpn='<:Colorless_Staff:443692132323295243>' if k[2][2]=='Staff'
    wpn='<:Summon_Gun:467557566050861074>' if k[2][2]=='Manacaster'
    title="#{title}\n#{wpn}**#{k[2][2]}**  <:DefenseS:514712247461871616>#{longFormattedNumber(k[5][0])}"
    title="#{title}\n #{k[2][3]}" unless k[2][3].nil?
    clzz='<:Resource_Structure:510774545154572298>'
    clzz='<:Skill_Weapon:444078171114045450>' if k[2][0]=='Attack'
    clzz='<:Skill_Special:444078170665254929>' if k[2][0]=='Support'
    clzz='<:Defense_Shield:570987444309196835>' if k[2][0]=='Defense'
    clzz='<:Healing_Rod:570991014894895104>' if k[2][0]=='Healer'
    title="#{title}\n#{clzz}**#{k[2][0]}**"
    title="#{title}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
  elsif !k[12].nil? && k[12]=='FGO'
    unless s2s || juststats
      str="#{generate_rarity_row(rar,@max_rarity[0],'FGO',false)}"
      str="#{str} (#{"Mana Spiral, " if rar>@max_rarity[0]}from #{k[1][0,1].to_i}#{['','<:FGO_icon_rarity_dark:571937156981981184>','<:FGO_icon_rarity_sickly:571937157095227402>','<:FGO_icon_rarity_rust:523903558928826372>','<:FGO_icon_rarity_mono:523903551144198145>','<:FGO_icon_rarity_gold:523858991571533825>'][k[1][0,1].to_i]})" unless rar==k[1][0,1].to_i
    end
    titlex=["#{generate_rarity_row(rar,@max_rarity[0],'FGO',false)}"]
    titlex.push("(#{"Mana Spiral, " if rar>@max_rarity[0]}from #{k[1][0,1].to_i}#{['','<:FGO_icon_rarity_dark:571937156981981184>','<:FGO_icon_rarity_sickly:571937157095227402>','<:FGO_icon_rarity_rust:523903558928826372>','<:FGO_icon_rarity_mono:523903551144198145>','<:FGO_icon_rarity_gold:523858991571533825>'][k[1][0,1].to_i]})") unless rar==k[1][0,1].to_i
    titlex.push("*Def:* #{longFormattedNumber(k[5][0])}")
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][1]}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][1]}**"
    clzz='unknown'
    clzz='saber' if k[2][2]=='Sword'
    clzz='blade' if k[2][2]=='Blade'
    clzz='extra' if k[2][2]=='Dagger'
    clzz='berserker' if k[2][2]=='Axe'
    clzz='archer' if k[2][2]=='Bow'
    clzz='lancer' if k[2][2]=='Lance'
    clzz='caster' if k[2][2]=='Wand'
    clzz='healer' if k[2][2]=='Staff'
    clzz='mooncancer' if k[2][2]=='Manacaster'
    srv=523821178670940170
    srv=523825319916994564 if ['Staff','Blade'].include?(k[2][2])
    clr='gold'
    clr='silver' if k[1][0,1].to_i==4
    clr='bronze' if k[1][0,1].to_i<4
    moji=bot.server(srv).emoji.values.reject{|q| q.name != "class_#{clzz}_#{clr}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][2]}**  *Def:* #{longFormattedNumber(k[5][0])}"
    title="#{title}\n #{k[2][3]}" unless k[2][3].nil?
    clzz=''
    clzz='<:Buster_y:526556105422274580>' if k[2][0]=='Attack'
    clzz='<:support:572315955397394452>' if k[2][0]=='Support'
    clzz='<:Arts_y:526556105489252352>' if k[2][0]=='Defense'
    clzz='<:healing:572342852420501506>' if k[2][0]=='Healer'
    title="#{title}\n#{clzz}**#{k[2][0]}**"
    title="#{title}\n<:Bond:613804021119189012>**FGO Collab**"
    titlex=[]
  else
    unless s2s || juststats
      str="#{generate_rarity_row(rar,@max_rarity[0],'',false)}"
      str="#{str} (#{"Mana Spiral, " if rar>@max_rarity[0]}from #{k[1][0,1].to_i}#{@rarity_stars[0][k[1][0,1].to_i]})" unless rar==k[1][0,1].to_i
    end
    titlex=["#{generate_rarity_row(rar,@max_rarity[0],'',false)}"]
    titlex.push("(#{"Mana Spiral, " if rar>@max_rarity[0]}from #{k[1][0,1].to_i}#{@rarity_stars[0][k[1][0,1].to_i]})") unless rar==k[1][0,1].to_i
    titlex.push("<:Defense:573344832282689567>#{longFormattedNumber(k[5][0])}")
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[2][1]}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][1]}**"
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[2][2]}"}
    if k[2][3].nil?
      title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][2]}**  <:Defense:573344832282689567>#{longFormattedNumber(k[5][0])}"
    else
      moji2=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "MC_#{k[2][3].gsub(' ','_')}"}
      title="#{title}\n#{moji2[0].mention unless moji2.length<=0}#{moji[0].mention unless moji.length<=0}#{k[2][3]} **#{k[2][2]}**  <:Defense:573344832282689567>#{longFormattedNumber(k[5][0])}"
    end
    moji=[]
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2][0].gsub('Healer','Healing')}"} unless k[2][0].nil?
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][0]}**"
    title="#{title}\n**Collab**" unless k[12].nil? || k[12].length<=0 || (k[1].length>1 && k[1][1,1].downcase=='c')
    title="#{title}\n**Collab**" if k[1].length>1 && k[1][1,1].downcase=='c'
  end
  lookout=get_lookout_tags().reject{|q| q[2]!='Availability' && q[2]!='Availability/Adventurer'}
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
  title="#{title}\n**Unavailable**" if k[1].length>1 && k[1][1,1].downcase=='-'
  flds=nil
  xpic=nil
  sklz=@askilities.map{|q| q}
  skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6][0]}
  skl1=sklz[skl1] unless skl1.nil?
  skl1[12][1]=skl1[6][-1] unless skl1.nil? || skl1[12].nil? || skl1[12].length<=0 || skl1[12].length>1
  skl2=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6][1]}
  skl2=sklz[skl2] unless skl2.nil?
  skl2[12][1]=skl2[6][-1] unless skl2.nil? || skl2[12].nil? || skl2[12].length<=0 || skl2[12].length>1
  ftr=nil
  feh=false
  feh=true if !k[12].nil? && k[12]=='FEH'
  dispname=k[0].gsub(' ','_')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Adventurers/#{dispname}_#{k[1][0,1]}.png?raw=true"
  semoji=['<:HP:573344832307593216>','<:Strength:573344931205349376>','<:Defense:573344832282689567>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>']
  semoji=['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','<:FGO_Def:653485374605361162>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if !k[12].nil? && k[12]=='FGO'
  semoji=['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','<:ProtoShield:642287078943752202>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if !k[12].nil? && k[12]=='MM'
  semoji=['<:HP_S:514712247503945739>','<:StrengthS:514712248372166666>','<:DefenseS:514712247461871616>','<:FEHEnergized:587684963000909845>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if feh
  if s2s || juststats
    flds=[]
    fehm=''
    fehm='FEH' if feh
    fehm='FGO' if !k[12].nil? && k[12]=='FGO'
    for i in rar...@max_rarity[0]+1
      flds.push([generate_rarity_row(i,@max_rarity[0],fehm,true),"**Lv.1**  #{semoji[0]}#{longFormattedNumber(k[3][0][i-3])}  #{semoji[1]}#{longFormattedNumber(k[4][0][i-3])}\n**Lv.#{30+10*i}**  #{semoji[0]}#{longFormattedNumber(k[3][1][i-3])}  #{semoji[1]}#{longFormattedNumber(k[4][1][i-3])}#{"\n**Max**  #{semoji[0]}#{longFormattedNumber(k[3][1][@max_rarity[0]-1])}  #{semoji[1]}#{longFormattedNumber(k[4][1][@max_rarity[0]-1])}" if i==@max_rarity[0] && (!k[3][1][@max_rarity[0]-1].nil? || !k[4][1][@max_rarity[0]-1].nil?)}"])
    end
    if (!k[3][1][@max_rarity[0]].nil? && k[3][1][@max_rarity[0]]>0) || (!k[4][1][@max_rarity[0]].nil? && k[4][1][@max_rarity[0]]>0)
      flds.push(["#{generate_rarity_row(0,@max_rarity[0],fehm,true)}\n**Mana Spiral**","**Lv.100**  #{semoji[0]}#{longFormattedNumber(k[3][1][@max_rarity[0]])}  #{semoji[1]}#{longFormattedNumber(k[4][1][@max_rarity[0]])}\n**Max**  #{semoji[0]}#{longFormattedNumber(k[3][1][@max_rarity[0]-2])}  #{semoji[1]}#{longFormattedNumber(k[4][1][@max_rarity[0]-2])}"])
      flds[-1].push(true) if flds.length==3
    end
    unless juststats
      if skl1.nil?
        str2="**#{k[6][0]}** - LOAD ERROR"
      else
        mx=skl1[3,3].reject{|q| q.nil? || q.length<=0}
        mx.push(skl1[11]) if !skl1[11].nil? && skl1[11].length>0
        if skl1.length>13
          for i in 13...skl1.length
            mx.push(skl1[i]) if !skl1[i].nil? && skl1[i].length>0
          end
        end
        eng=''
        eng=", #{semoji[3]}Energizable" if skl1[7]=='Yes'
        eng=", #{semoji[4]}Inspirable" if skl1[10].include?('Damage')
        eng=", #{semoji[5]}Energizable/Inspirable" if skl1[7]=='Yes' && skl1[10].include?('Damage')
        smolsp=[skl1[6][mx.length-1]]
        smolsp=[] if skl1[6][0,mx.length].max != skl1[6][0,mx.length].min
        smolsp2=[]
        kk=[]
        kk=skl1[6][5,skl1[6].length-5] if skl1[6].length>5
        if kk.length>0
          for i in 0...kk.length/7
            smolsp.push(kk[i*7+mx.length]) unless kk[i*7+mx.length]==skl1[6][0]
            smolsp2.push(kk[i*7+6]) unless kk[i*7+6]==skl1[12][1]
          end
        end
        str2="__**#{skl1[0]}** (#{skl1[8]} sec invul#{eng}#{energy_emoji(skl1[10],true)})__#{' -' if (skl1[6][0,mx.length].max==skl1[6][0,mx.length].min && skl1[6][0]>0) || !(skl1[12].nil? || skl1[12].length<=0)}#{" #{smolsp.join("\u2192")} SP" if skl1[6][0,mx.length].max===skl1[6][0,mx.length].min && skl1[6][0]>0}#{" (#{skl1[12][0]}<:SkillShare:714597012733034547> / #{longFormattedNumber(skl1[12][1])}#{"\u2192#{smolsp2.join("\u2192")}" if smolsp2.length>0} SP when shared)" unless skl1[12].nil? || skl1[12].length<=0}"
        if (skl1[9].nil? || skl1[9].length<=0) && skl1[6][0,mx.length].max != skl1[6][0,mx.length].min
          str2="#{str2}\n*Lv.1 (F0, #{skl1[6][0]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==1} SP):* #{skl1[3].gsub(';; ',"\n")}\n*Lv.2 (F3, #{skl1[6][1]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==2} SP):* #{skl1[4].gsub(';; ',"\n")}\n*Lv.3 (F5, #{skl1[6][2]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==3} SP):* #{skl1[5].gsub(';; ',"\n")}"
          str2="#{str2}\n*Lv.4 (F6, #{skl1[6][3]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==4} SP):* #{skl1[11].gsub(';; ',"\n")}" unless skl1[11].nil? || skl1[11].length<=0
        elsif skl1[9].nil? || skl1[9].length<=0
          str2="#{str2}\n*Lv.1 (F0):* #{skl1[3].gsub(';; ',"\n")}\n*Lv.2 (F3):* #{skl1[4].gsub(';; ',"\n")}\n*Lv.3 (F5):* #{skl1[5].gsub(';; ',"\n")}"
          str2="#{str2}\n*Lv.4 (F6):* #{skl1[11].gsub(';; ',"\n")}" unless skl1[11].nil? || skl1[11].length<=0
        elsif skl1[6][0,mx.length].max != skl1[6][0,mx.length].min
          str2="#{str2}\n*Effect:* #{skl1[9].gsub(';; ',"\n")}\n*Lv.1 (F0, #{skl1[6][0]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==1} SP) \u2192 Lv.2 (F3, #{skl1[6][1]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==2} SP) \u2192 Lv.3 (F5, #{skl1[6][2]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==3} SP)*"
          str2="#{str2} \u2192 *Lv.4 (F6, #{skl1[6][3]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==4} SP)*" unless skl1[11].nil? || skl1[11].length<=0
        else
          str2="#{str2}\n*Effect:* #{skl1[9].gsub(';; ',"\n")}\n*Lv.1 (F0) \u2192 Lv.2 (F3) \u2192 Lv.3 (F5)*"
          str2="#{str2} \u2192 *Lv.4 (F6)*" unless skl1[11].nil? || skl1[11].length<=0
        end
      end
      if skl2.nil?
        str2="#{str2}\n#{"\n" unless skl1.nil?}**#{k[6][1]}** - LOAD ERROR"
      else
        mx=skl2[3,3].reject{|q| q.nil? || q.length<=0}
        mx.push(skl2[11]) if !skl2[11].nil? && skl2[11].length>0
        if skl2.length>13
          for i in 13...skl2.length
            mx.push(skl2[i]) if !skl2[i].nil? && skl2[i].length>0
          end
        end
        eng=''
        eng=", #{semoji[3]}Energizable" if skl2[7]=='Yes'
        eng=", #{semoji[4]}Inspirable" if skl2[10].include?('Damage')
        eng=", #{semoji[5]}Energizable/Inspirable" if skl2[7]=='Yes' && skl2[10].include?('Damage')
        smolsp=[skl2[6][mx.length-1]]
        smolsp=[] if skl2[6][0,mx.length].max != skl2[6][0,mx.length].min
        smolsp2=[]
        kk=[]
        kk=skl2[6][5,skl2[6].length-5] if skl2[6].length>5
        if kk.length>0
          for i in 0...kk.length/7
            smolsp.push(kk[i*7+mx.length]) unless kk[i*7+mx.length]==skl2[6][0]
            smolsp2.push(kk[i*7+6]) unless kk[i*7+6]==skl2[12][1]
          end
        end
        str2="#{str2}\n\n__**#{skl2[0]}** (#{skl2[8]} sec invul#{eng}#{energy_emoji(skl2[10],true)})__#{' -' if (skl2[6][0,mx.length].max===skl2[6][0,mx.length].min && skl2[6][0]>0) || !(skl2[12].nil? || skl2[12].length<=0)}#{" #{smolsp.join("\u2192")} SP" if skl2[6][0,mx.length].max===skl2[6][0,mx.length].min && skl2[6][0]>0}#{" (#{skl2[12][0]}<:SkillShare:714597012733034547> / #{longFormattedNumber(skl2[12][1])}#{"\u2192#{smolsp2.join("\u2192")}" if smolsp2.length>0} SP when shared)" unless skl2[12].nil? || skl2[12].length<=0}"
        if (skl2[9].nil? || skl2[9].length<=0) && skl2[6][0,mx.length].max != skl2[6][0,mx.length].min
          str2="#{str2}\n*Lv.1 (F2, #{skl2[6][0]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==1} SP):* #{skl2[3].gsub(';; ',"\n")}\n*Lv.2 (F4, #{skl2[6][1]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==2} SP):* #{skl2[4].gsub(';; ',"\n")}"
          str2="#{str2}\n*Lv.3 (F6, #{skl2[6][2]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==3} SP):* #{skl2[5].gsub(';; ',"\n")}" if !skl2[5].nil? && skl2[5].length>0
        elsif skl2[9].nil? || skl2[9].length<=0
          str2="#{str2}\n*Lv.1 (F2):* #{skl2[3].gsub(';; ',"\n")}\n*Lv.2 (F4):* #{skl2[4].gsub(';; ',"\n")}"
          str2="#{str2}\n*Lv.3 (F6):* #{skl2[5].gsub(';; ',"\n")}" if !skl2[5].nil? && skl2[5].length>0
        elsif skl2[6][0,mx.length].max != skl2[6][0,mx.length].min
          str2="#{str2}\n*Effect:* #{skl2[9].gsub(';; ',"\n")}\n*Lv.1 (F2, #{skl2[6][0]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==1} SP) \u2192 Lv.2 (F4, #{skl2[6][1]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==2} SP)*"
          str2="#{str2} \u2192 *Lv.3 (F6, #{skl2[6][2]}#{"\u2192#{smolsp.join("\u2192")}" if smolsp.length>0 && mx.length==3} SP)*" if !skl2[5].nil? && skl2[5].length>0
        else
          str2="#{str2}\n*Effect:* #{skl2[9].gsub(';; ',"\n")}\n*Lv.1 (F2) \u2192 Lv.2 (F4)*"
          str2="#{str2} \u2192 *Lv.3 (F6)*" if !skl2[5].nil? && skl2[5].length>0
        end
      end
      str2="#{str2}\n#{"\n" unless skl1.nil? && skl2.nil?}<:SkillShare:714597012733034547> *Skill Sharing capacity:* #{longFormattedNumber(k[5][1])}" if k[5].length>1 && k[5][1]>0
      flds.push(['Skills',str2,1])
      nde=1
      nde=0 if !k[8][3].nil? && k[8][3].include?('3')
      unless k[8].nil? || k[8].length<=0
        a3="#{k[8][2][0]} (F#{5*nde})"
        a3="#{k[8][2][0]} (F#{3*nde}) \u2192 #{k[8][2][1]} (F5)" if k[1][0,1].to_i==5
        a3="#{k[8][2][0]} (F#{2*nde}) \u2192 #{k[8][2][1]} (F5)" if k[0]=='Euden'
        m=1
        m=2 if k[1][0,1].to_i==5 || k[0]=='Euden'
        if !k[8][2][m].nil? && k[8][2][m].length>1
          a3="#{a3} \u2192 #{k[8][2][m,k[8][2].length-m].join(" \u2192 ")} (F6)"
          m+=1
        end
        nde=1
        nde=0 if !k[8][3].nil? && k[8][3].include?('1')
        flds.push(['Abilities',"#{k[8][0][0]} (F#{nde}) \u2192 #{k[8][0][1]} (F3)#{" \u2192 #{k[8][0][2]} (F6)" unless k[8][0].length<3 || k[8][0][2].length<=0}\n#{k[8][1][0]} (F1) \u2192 #{k[8][1][1]} (F4)#{" \u2192 #{k[8][1][2]} (F6)" unless k[8][1].length<3 || k[8][1][2].length<=0}\n#{a3}\n\n*Co-Ability:* #{k[7][0]}#{"\n\n*Chain Co-Ability:* #{k[7][1]}" if k[7].length>1}"])
      end
    end
    titlex=[]
  else
    xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Adventurers/#{dispname}_#{[rar,k[1][0,1].to_i].max}.png?raw=true" unless semirar
    str=''
    lvl=30+10*rar
    lvl=100 if rar==0
    title="#{adv_emoji(k,bot,true,true)}\n**Lv.#{lvl}**  #{semoji[0]}#{longFormattedNumber(k[3][1][rar-3])}  #{semoji[1]}#{longFormattedNumber(k[4][1][rar-3])}"
    if rar>@max_rarity[0] || rar==0
      title="#{adv_emoji(k,bot,true,true)}\n**Lv.100 Max**  #{semoji[0]}#{longFormattedNumber(k[3][1][@max_rarity[0]-2])}  #{semoji[1]}#{longFormattedNumber(k[4][1][@max_rarity[0]-2])}"
    elsif rar==@max_rarity[0] && (!k[3][1][@max_rarity[0]-1].nil? || !k[4][1][@max_rarity[0]-1].nil?)
      title="#{adv_emoji(k,bot,true,true)}\n**Lv.#{30+10*rar} Max**  #{semoji[0]}#{longFormattedNumber(k[3][1][@max_rarity[0]-1])}  #{semoji[1]}#{longFormattedNumber(k[4][1][@max_rarity[0]-1])}"
    end
    title="#{title}  #{titlex[-1]}"
    lv=[3,3,k[8][0].length,k[8][1].length,k[8][2].length]
    lv[0]=4 unless skl1[11].nil? || skl1[11].length<=0
    lv[1]=2 if skl2[5].nil? || skl2[5].length<=0
    lv=[3,2,2,2,1] if rar==5
    lv[4]=2 if k[1][0,1].to_i==5 && rar==5
    lv[4]=2 if k[0]=='Euden' && rar==5
    lv=[2,2,2,2,0] if rar==4
    lv=[2,1,2,1,0] if rar==3
    lv[4]=1 if k[1][0,1].to_i==5 && rar<5 && rar>0
    lv=[1,1,1,1,0] if rar==2
    lv=[1,1,1,0,0] if rar==1
    x=[skl1[3,3],skl2[3,3]]
    x[0].push(skl1[11])
    x[1].push(skl2[11])
    for i in 13...skl1.length
      x[0].push(skl1[i])
    end
    for i in 13...skl2.length
      x[1].push(skl2[i])
    end
    x=x.map{|q| q.reject{|q2| q2.nil? || q2.length<=0}}
    x[0]=x[0][[lv[0],x[0].length].min-1].gsub(';; ',"\n")
    x[1]=x[1][[lv[1],x[1].length].min-1].gsub(';; ',"\n")
    strx="__**Skills:**__"
    strx="<:Mega_Man:641484836304846857>**Mega Man Collab**\n\n#{strx}" if !k[12].nil? && k[12]=='MM'
    strx="<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**\n\n#{strx}" if !k[12].nil? && k[12]=='MH'
    strx="<:Great_Badge_Golden:443704781068959744>**FEH Collab**\n\n#{strx}" if !k[12].nil? && k[12]=='FEH'
    strx="<:Bond:613804021119189012>**FGO Collab**\n\n#{strx}" if !k[12].nil? && k[12]=='FGO'
    strx2="**Skills:**"
    if skl1.nil?
      strx="#{strx}\n\n*#{k[6][0]}* - LOAD ERROR"
      strx2="#{strx2}\n*#{k[6][0]}* - LOAD ERROR"
    else
      mx=skl1[3,3].reject{|q| q.nil? || q.length<=0}
      mx.push(skl1[11]) if !skl1[11].nil? && skl1[11].length>0
      if skl1.length>13
        for i in 13...skl1.length
          mx.push(skl1[i]) if !skl1[i].nil? && skl1[i].length>0
        end
      end
      smolsp=[longFormattedNumber(skl1[6][lv[0]-1])]
      smolsp2=[]
      kk=[]
      kk=skl1[6][5,skl1[6].length-5] if skl1[6].length>5
      if kk.length>0
        for i in 0...kk.length/7
          smolsp.push(longFormattedNumber(kk[i*7+lv[0]])) unless kk[i*7+lv[0]]==skl1[12][1]
          smolsp2.push(longFormattedNumber(kk[i*7+6])) unless kk[i*7+6]==skl1[12][1]
        end
      end
      eng=''
      eng=semoji[3] if skl1[7]=='Yes'
      eng=semoji[4] if !skl1[10].nil? && skl1[10].include?('Damage')
      eng=semoji[5] if skl1[7]=='Yes' && !skl1[10].nil? && skl1[10].include?('Damage')
      strx="#{strx}\n*#{k[6][0]}#{eng}#{energy_emoji(skl1[10])} [Lv.#{lv[0]}] - #{smolsp.join("\u2192")} SP*\n#{x[0]}"
      strx="#{strx}\n#{skl1[12][0]}<:SkillShare:714597012733034547> / #{longFormattedNumber(skl1[12][1])}#{"\u2192#{smolsp2.join("\u2192")}" if smolsp2.length>0} SP when shared" unless skl1[12].nil? || skl1[12].length<=0
      strx2="#{strx2}\n#{k[6][0]}#{eng}#{energy_emoji(skl1[10])} [Lv.#{lv[0]}] - #{smolsp.join("\u2192")} SP"
      strx2="#{strx2}\n#{skl1[12][0]}<:SkillShare:714597012733034547> / #{longFormattedNumber(skl1[12][1])}#{"\u2192#{smolsp2.join("\u2192")}" if smolsp2.length>0} SP when shared" unless skl1[12].nil? || skl1[12].length<=0
    end
    if skl2.nil?
      strx="#{strx}\n\n*#{k[6][1]}* - LOAD ERROR"
      strx2="#{strx2}\n*#{k[6][1]}* - LOAD ERROR"
    else
      mx=skl2[3,3].reject{|q| q.nil? || q.length<=0}
      mx.push(skl2[11]) if !skl2[11].nil? && skl2[11].length>0
      if skl2.length>13
        for i in 13...skl2.length
          mx.push(skl2[i]) if !skl2[i].nil? && skl2[i].length>0
        end
      end
      smolsp=[longFormattedNumber(skl2[6][mx.length-1])]
      smolsp2=[]
      kk=[]
      kk=skl2[6][5,skl2[6].length-5] if skl2[6].length>5
      if kk.length>0
        for i in 0...kk.length/7
          smolsp.push(longFormattedNumber(kk[i*7+mx.length])) unless kk[i*7+mx.length]==skl2[12][1]
          smolsp2.push(longFormattedNumber(kk[i*7+6])) unless kk[i*7+6]==skl2[12][1]
        end
      end
      eng=''
      eng=semoji[3] if skl2[7]=='Yes'
      eng=semoji[4] if !skl2[10].nil? && skl2[10].include?('Damage')
      eng=semoji[5] if skl2[7]=='Yes' && !skl2[10].nil? && skl2[10].include?('Damage')
      strx="#{strx}\n\n*#{k[6][1]}#{eng}#{energy_emoji(skl2[10])} [Lv.#{lv[1]}] - #{smolsp.join("\u2192")} SP*\n#{x[1]}"
      strx="#{strx}\n#{skl2[12][0]}<:SkillShare:714597012733034547> / #{longFormattedNumber(skl2[12][1])} SP when shared" unless skl2[12].nil? || skl2[12].length<=0
      strx2="#{strx2}\n#{k[6][1]}#{eng}#{energy_emoji(skl2[10])} [Lv.#{lv[1]}] - #{smolsp.join("\u2192")} SP"
      strx2="#{strx2}\n#{skl2[12][0]}<:SkillShare:714597012733034547> / #{longFormattedNumber(skl2[12][1])} SP when shared" unless skl2[12].nil? || skl2[12].length<=0
    end
    strx="#{strx}\n#{"\n" unless skl1.nil? && skl2.nil?}<:SkillShare:714597012733034547> *Skill Sharing capacity:* #{longFormattedNumber(k[5][1])}" if k[5].length>1 && k[5][1]>0
    strx2="#{strx2}\n#{"\n" unless skl1.nil? && skl2.nil?}<:SkillShare:714597012733034547> *Skill Sharing capacity:* #{longFormattedNumber(k[5][1])}" if k[5].length>1 && k[5][1]>0
    if k[8].nil? || k[8].length<=0
      str="#{str}\n\n;;;;;\n"
    else
      m=[]
      for i in 0...3
        m.push(k[8][i][lv[i+2]-1]) if lv[i+2]>0
      end
      str="#{str}\n\n;;;;;\n\n**Abilities:** #{m.join(', ')}"
      str="#{str}\n**Co-Ability:** #{k[7][0]}"
      str="#{str}\n**Chain Co-Ability:** #{k[7][1]}" if k[7].length>1
      if str.gsub(';;;;;',strx).length>=1800
        str=str.gsub(';;;;;',"#{strx2}\n~~Skill descriptions make this data too long.  Please try again in PM.~~#{"\n\n<:SkillShare:714597012733034547> *Skill Sharing capacity:* #{longFormattedNumber(k[5][1])}" if k[5].length>1 && k[5][1]>0}")
      else
        str=str.gsub(';;;;;',strx)
      end
    end
    ftr="Data shown is for a #{rar}-star adventurer.  To show all data, use this command in PM or include #{@max_rarity[0]}* in your message." unless rar>=@max_rarity[0]
    ftr="Data shown is for a #{@max_rarity[0]}-star adventurer.  To show data for a #{k[1][0,1]}-star version, please include #{k[1][0,1]}* in your message." if semirar
    ftr="Data shown is for an adventurer whose mana spiral has been unlocked.  To show data for a #{@max_rarity[0]}-star#{" or #{k[1][0,1]}-star" unless @max_rarity[0]==k[1][0,1]} version, please include the number in your message." if rar>@max_rarity[0]
    ftr=nil if k[1][0,1].to_i==@max_rarity[0]
  end
  ftr2=nil
  ftr2=k[17] unless k[17].nil? || k[17].gsub(' ','').length<=0
  hdr="__**#{k[0]}**__"
  if titlex.length>0
    hdr="#{hdr} #{titlex[0]}"
    hdr="#{hdr} #{titlex[1]}" if titlex.length>2
  end
  mstr=''
  if title.length>250
    title=title.split("\n")
    if flds.nil?
      mstr="#{title[1]}"
    else
      str="#{title[1]}\n\n#{str}"
    end
    title="#{title[0]}"
  end
  if flds.nil?
    ftr=ftr2 unless ftr2.nil?
    f=0
    f=ftr.length unless ftr.nil?
    if str.length+title.length+f>=1500
      create_embed(event,[hdr,title],mstr,element_color(k[2][1]),nil,xpic)
      create_embed(event,'',str,element_color(k[2][1]),ftr)
    else
      create_embed(event,[hdr,title],"#{mstr}\n\n#{str}".gsub("\n\n\n","\n\n").gsub("\n\n\n","\n\n").gsub("\n\n\n","\n\n"),element_color(k[2][1]),ftr,xpic)
    end
  elsif flds.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length+title.length+str.length>=1500 && juststats
    create_embed(event,[hdr,title],str,element_color(k[2][1]),nil,xpic,flds[0,flds.length-1])
    create_embed(event,'','',element_color(k[2][1]),ftr,nil,flds[flds.length-1,1])
  elsif flds.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length+title.length+str.length>=1500
    create_embed(event,[hdr,title],str,element_color(k[2][1]),ftr,xpic,flds[0,flds.length-2])
    if flds[-2][1].length>=1900
      s1=flds[-2][1].split("\n\n")
      if s1[-1][0,1]=='<'
        flds[-1]=['',"#{s1[-1].gsub('*','**')}\n\n__**#{flds[-1][0]}**__\n#{flds[-1][1]}"]
        s1[-1]=nil
        s1.compact!
      end
      for i in 0...s1.length
        s2=s1[i].split("\n")
        ftr3=nil
        ftr3="#{ftr2}" if !ftr2.nil? && i==s1.length-1
        create_embed(event,"__Skill #{i+1}: #{s2[0].gsub('__','')}__",s2[1,s2.length-1].join("\n"),element_color(k[2][1]),ftr3)
      end
    else
      create_embed(event,"__**#{flds[-2][0]}**__",flds[-2][1],element_color(k[2][1]),ftr2)
    end
    create_embed(event,"#{"__**#{flds[-1][0]}**__" unless flds[-1][0].length<=0}",flds[-1][1],element_color(k[2][1]))
  else
    ftr=ftr2 unless ftr2.nil?
    create_embed(event,[hdr,title],str,element_color(k[2][1]),ftr,xpic,flds)
  end
end

def disp_dragon_stats(bot,event,args=nil,juststats=false)
  reload_library()
  return dragon_data(bot,event,args,juststats)
end

def disp_wyrmprint_stats(bot,event,args=nil,juststats=false)
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
  dispname=k[0].gsub(' ','_')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Wyrmprints/#{dispname}_1.png?raw=true"
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Wyrmprints/#{dispname}_2.png?raw=true" if has_any?(['mub','unbind','unbound','refined','refine','refinement','2ub','3ub'],evn)
  str=generate_rarity_row(k[1][0,1].to_i,0,k[10])
  if k[1][0,1].to_i>4
    str="#{str} - <:Fill_Gold:759999913962110978>"
  else
    str="#{str} - <:Fill_Silver:759999914062774302>"
  end
  if !k[10].nil? && k[10]=='FEH'
    clzz='<:Resource_Structure:510774545154572298>'
    clzz='<:Skill_Weapon:444078171114045450>' if k[2][0]=='Attack'
    clzz='<:Skill_Special:444078170665254929>' if k[2][0]=='Support'
    clzz='<:Defense_Shield:570987444309196835>' if k[2][0]=='Defense'
    clzz='<:Healing_Rod:570991014894895104>' if k[2][0]=='Healer'
    moji2=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{k[2][1]}"}
    title="#{moji2[0].mention unless moji2.length<=0}**#{k[2][1]}'s Boon**".gsub("None's Boon",'No affinity')
    title="#{title}\n#{clzz}**#{k[2][0]}**"
    title="#{title}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
  elsif !k[10].nil? && k[10]=='FGO'
    clzz=''
    clzz='<:Buster_y:526556105422274580>' if k[2][0]=='Attack'
    clzz='<:support:572315955397394452>' if k[2][0]=='Support'
    clzz='<:Arts_y:526556105489252352>' if k[2][0]=='Defense'
    clzz='<:healing:572342852420501506>' if k[2][0]=='Healer'
    moji2=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{k[2][1]}"}
    title="#{moji2[0].mention unless moji2.length<=0}**#{k[2][1]}'s Boon**".gsub("None's Boon",'No affinity')
    title="#{title}\n#{clzz}**#{k[2][0]}**"
    title="#{title}\n<:Bond:613804021119189012>**FGO Collab**"
  else
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{k[2][0]}"}
    moji2=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{k[2][1]}"}
    title="#{moji2[0].mention unless moji2.length<=0}**#{k[2][1]}'s Boon**".gsub("None's Boon",'No affinity')
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[2][0]}**"
    if !k[10].nil? && k[10]=='MM'
      title="#{title}\n<:Mega_Man:641484836304846857>**Mega Man Collab**"
    elsif !k[10].nil? && k[10]=='MH'
      title="#{title}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**"
    elsif !k[10].nil? && k[10]=='PC'
      title="#{title}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**"
    elsif !k[10].nil? && k[10]=='P5S'
      title="#{title}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**"
    else
      title="#{title}\n**Collab**" unless k[10].nil? || k[10].length<=0
      title="#{title}\n**Collab**" if k[1].length>1 && k[1][1,1].downcase=='c'
    end
  end
  xcolor=0x313439
  xcolor=0x5A0408 if k[2][0]=='Attack'
  xcolor=0x00205A if k[2][0]=='Defense'
  xcolor=0x39045A if k[2][0]=='Support'
  xcolor=0x005918 if k[2][0]=='Healing'
  xcolor=0x944CCD if ['Eagle','Wolf','Bull','Serpent'].include?(k[2][1])
  xcolor=0xFF0031 if ['Sword','Axe','Bow','Crown','Lance'].include?(k[2][1])
  xcolor=0xF68D10 if ['Dragon'].include?(k[2][1])
  xcolor=0x188931 if ['Staff'].include?(k[2][1])
  lookout=get_lookout_tags().reject{|q| q[2]!='Availability' && q[2]!='Availability/Wyrmprint'}
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
  f=k[1][0,1].to_i*10
  f-=10 if k[1][0,1].to_i<4
  f=5 if k[1][0,1].to_i==1
  f2=f-10
  f2=f-4 if k[1][0,1].to_i<4
  f2=f-2 if k[1][0,1].to_i<3
  semoji=['<:HP:573344832307593216>','<:Strength:573344931205349376>','<:Defense:573344832282689567>']
  semoji=['<:HP_S:514712247503945739>','<:StrengthS:514712248372166666>','<:Defense:573344832282689567>'] if !k[10].nil? && k[10]=='FEH'
  semoji=['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','<:FGO_Def:653485374605361162>'] if !k[10].nil? && k[10]=='FGO'
  semoji=['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','<:ProtoShield:642287078943752202>'] if !k[10].nil? && k[10]=='MM'
  bemoji=['<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>']
  bemoji=['<:Limited:574682514585550848>','<:LimitBroken:574682514921095212>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>'] if !k[16].nil? && k[16]=='FGO'
  if ['Wily Warriors','Greatwyrm'].include?(k[0])
    str="#{str}\n\n**#{bemoji[0]*4} Level 1**  #{semoji[0]}*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][0])}  #{semoji[1]}*Str:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}"
    str="#{str}\n**#{bemoji[1]*2}#{bemoji[0]*2} Level #{f2}**  #{semoji[0]}*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][1])}  #{semoji[1]}*Str:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}"
    str="#{str}\n**#{bemoji[1]*4} Level #{f}**  #{semoji[0]}*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][2])}  #{semoji[1]}*Str:*\u00A0\u00A0#{longFormattedNumber(k[4][2])}"
  elsif s2s
    str="#{str}\n\n__**#{bemoji[0]*4} Level 1**__"
    str="#{str}\n#{semoji[0]}*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][0])}  #{semoji[1]}*Str:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}"
    str="#{str}\n#{k[5].map{|q| q[0]}.join("\n")}" unless k[5].length<=0
    str="#{str}\n\n__**#{bemoji[1]*2}#{bemoji[0]*2} Level #{f2}**__"
    str="#{str}\n#{semoji[0]}*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][1])}  #{semoji[1]}*Str:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}"
    str="#{str}\n#{k[5].map{|q| q[1]}.join("\n")}" unless k[5].length<=0
    str="#{str}\n\n__**#{bemoji[1]*4} Level #{f}**__"
    str="#{str}\n#{semoji[0]}*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][2])}  #{semoji[1]}*Str:*\u00A0\u00A0#{longFormattedNumber(k[4][2])}"
    str="#{str}\n#{k[5].map{|q| "#{q[2] if q.length>2}#{q[1] if q.length<3}"}.join("\n")}" unless k[5].length<=0
  else
    str="#{str}\n\n**#{bemoji[0]*4} Level 1**  #{semoji[0]}*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][0])}  #{semoji[1]}*Str:*\u00A0\u00A0#{longFormattedNumber(k[4][0])}"
    str="#{str}\n**#{bemoji[1]*2}#{bemoji[0]*2} Level #{f2}**  #{semoji[0]}*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][1])}  #{semoji[1]}*Str:*\u00A0\u00A0#{longFormattedNumber(k[4][1])}"
    str="#{str}\n**#{bemoji[1]*4} Level #{f}**  #{semoji[0]}*HP:*\u00A0\u00A0#{longFormattedNumber(k[3][2])}  #{semoji[1]}*Str:*\u00A0\u00A0#{longFormattedNumber(k[4][2])}"
    for i in 0...k[5].length
      if k[5][i].length<3
        if k[5][i][0]==k[5][i][1]
          k[5][i]=k[5][i][0]
        elsif k[5][i][0].split(' ')[0,k[5][i][0].split(' ').length-1].join(' ')==k[5][i][1].split(' ')[0,k[5][i][1].split(' ').length-1].join(' ')
          k[5][i]="#{k[5][i][0]}/#{k[5][i][1].split(' ')[-1]}"
        else
          k[5][i]=k[5][i][0,2].join(" \u2192 ")
        end
      elsif k[5][i][0]==k[5][i][1] && k[5][i][0]==k[5][i][2]
        k[5][i]=k[5][i][0]
      elsif k[5][i][0]==k[5][i][1] || k[5][i][1]==k[5][i][2]
        if k[5][i][0].split(' ')[0,k[5][i][0].split(' ').length-1].join(' ')==k[5][i][1].split(' ')[0,k[5][i][2].split(' ').length-1].join(' ')
          k[5][i]="#{k[5][i][0]}/#{k[5][i][2].split(' ')[-1]}"
        else
          k[5][i]="#{k[5][i][0]} \u2192 #{k[5][i][2]}"
        end
      elsif k[5][i][0].split(' ')[0,k[5][i][0].split(' ').length-1].join(' ')==k[5][i][1].split(' ')[0,k[5][i][1].split(' ').length-1].join(' ')
        k[5][i]="#{k[5][i][0]}/#{k[5][i][1].split(' ')[-1]}/#{k[5][i][2].split(' ')[-1]}"
      else
        k[5][i]=k[5][i][0,3].join(" \u2192 ")
      end
    end
    if k[5].length<=0
      str="#{str}\n\n__**Abilities**__" if @resonance.map{|q| q[0]}.include?(k[2][1])
    else
      str="#{str}\n\n__**Abilities**__\n#{k[5].join("\n")}"
    end
  end
  ftr=nil
  if @resonance.map{|q| q[0]}.include?(k[2][1])
    kk2=@resonance.find_index{|q| q[0]==k[2][1]}
    unless kk2.nil?
      kk2=@resonance[kk2]
      if safe_to_spam?(event)
        str="#{str}\n" unless k[5].length<=0
        str="#{str}\nPair with another #{kk2[0]} affinity print to gain #{kk2[1]}" unless kk2[1].nil?
        str="#{str}\nPair with two more #{kk2[0]} affinity prints to gain #{kk2[2]}" unless kk2[2].nil?
        str="#{str}\nPair with three more #{kk2[0]} affinity prints to gain #{kk2[3]}" unless kk2[3].nil?
      else
        m=[]
        m.push(1) unless kk2[1].nil?
        m.push(2) unless kk2[2].nil?
        m.push(3) unless kk2[3].nil?
        str="#{str}\n#{moji2[0].mention unless moji2.length<=0}+#{m.join('/')} (Affinity) = "
        m=kk2[1,3].compact
        m2=m[0].split(' ')
        m2.pop
        m2=m2.join(' ')
        str="#{str}#{m2} +#{m.map{|q| q.split(' ')[-1].gsub('+','')}.join('/')}"
        ftr='Affinity counts displayed are not including this print, so are off by one.'
      end
    end
  end
  str="#{str}\n"
  str="#{str}\n**Obtained:** #{k[9]}" if !k[9].nil? && k[9].length>0
  if k[0]=='Wily Warriors'
    pr=@wyrmprints.reject{|q| !q[0].include?('Wily Warriors ')}.map{|q| q[0].gsub('Wily Warriors ','')}.uniq
    str="#{str}\nThis print entry only exists to contain the combined art of the Wily Warriors series of wyrmprints.  For individual pieces of this series, use their subtitles:\n#{pr.join("\n")}"
  elsif k[0]=='Greatwyrm'
    pr=@wyrmprints.reject{|q| !q[0].include?('Greatwyrm ')}.uniq
    str="#{str}\nThis print entry only exists to contain the combined art of the Greatwyrm series of wyrmprints.  For individual pieces of this series, use their full names:\n#{pr.join("\n")}"
  elsif k[1].length<=1 || !['s','z','y','t','w'].include?(k[1][1,1].downcase)
    str="#{str}\n**Shop Price:** 900#{bemoji[3]} per 2UB, 1,700#{bemoji[3]} per MUB" if k[1][0,1].to_i==3
    str="#{str}\n**Shop Price:** 9,000#{bemoji[3]} per 2UB, 17,000#{bemoji[3]} per MUB" if k[1][0,1].to_i==4
    str="#{str}\n**Shop Price:** 19,000#{bemoji[3]} per 2UB, 37,000#{bemoji[3]} per MUB" if k[1][0,1].to_i==5
    str="#{str}\n**Shop Price:** 25,000#{bemoji[3]} per 2UB, 53,000#{bemoji[3]} per MUB" if k[1][0,1].to_i==6
    str="#{str}\nThese include the cost of buying, and the cost of unbinding." if k[1][0,1].to_i>2
  end
  create_embed(event,["__**#{k[0]}**__",title],str,xcolor,ftr,xpic)
end

def disp_weapon_stats(bot,event,args=nil,juststats=false)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_weapon,args.join(' '),event,true)
  if k.length.zero? || k[0]=='Water Dagger'
    k4=find_in_weapons(bot,event,args,2,false,true)
    unless k4.nil? || k4.length<=0
      args2=args.map{|q| q}
      args2=args2.reject{|q| q.to_i.to_s==q || q.gsub('*','').to_i.to_s==q.gsub('*','')} if k4.map{|q| q[2][0,1]}.uniq.length==1
      args2=args2.join(' ')
      if k4.map{|q| q[3]}.uniq.length==1
        args2=first_sub(args2,k4[0][3].downcase,'')
        args2=first_sub(args2,'fire','') if k4[0][3]=='Flame'
        args2=first_sub(args2,'dark','') if k4[0][3]=='Shadow'
      end
      if k4.map{|q| q[1]}.uniq.length==1
        args2=first_sub(args2,k4[0][1].downcase,'')
        args2=first_sub(args2,'spear','') if k4[0][1]=='Lance'
      end
      args2=first_sub(args2,'void','') if k4.reject{|q| q[1][1,1]!='v'}.length<=0
      k2=find_data_ex(:find_enemy,args2,event)
      if k2.length>0 && k2[2][2]=='Void'
        k3=k4.reject{|q| q[15].nil? || q[15]!=k2[0]}
        k4=k3.map{|q| q} if k3.length>0
      end
      kk5=3
      kk5=8 if safe_to_spam?(event)
      if k4.length>kk5 && find_data_ex(:find_weapon,args.join(' '),event).length<=0
        event.respond "Too many weapons qualify.  I will not display them all."
        return nil
      end
      unless k4.length>3
        for i in 0...k4.length
          disp_weapon_stats(bot,event,k4[i][0].split(' '),juststats)
        end
        return nil
      end
    end
  end
  k=find_data_ex(:find_weapon,args.join(' '),event) if k.length.zero?
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  elsif k[0].is_a?(Array)
    args2=args.map{|q| q}
    args2=args2.reject{|q| q.to_i.to_s==q || q.gsub('*','').to_i.to_s==q}
    args2=args2.join(' ')
    args2=first_sub(args2,k[0][3].downcase,'')
    args2=first_sub(args2,'fire','') if k[0][3]=='Flame'
    args2=first_sub(args2,'dark','') if k[0][3]=='Shadow'
    args2=first_sub(args2,k[0][1].downcase,'')
    args2=first_sub(args2,'spear','') if k[0][1]=='Lance'
    args2=first_sub(args2,'void','')
    k2=find_data_ex(:find_enemy,args2,event)
    if k2.length>0 && k2[2][2]=='Void'
      k3=k.reject{|q| q[15].nil? || q[15]!=k2[0]}
      k=k3.map{|q| q} if k3.length>0
    end
    if k.length>5
      event.respond "Too many weapons qualify.  I will not display them all."
      return nil
    end
    for i in 0...k.length
      disp_weapon_stats(bot,event,k[i][0].split(' '),juststats)
    end
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  feh=false
  feh=true if !k[14].nil? && k[14]=='FEH'
  evn=event.message.text.downcase.split(' ')
  juststats=true if @shardizard != 4 && evn.include?('smol')
  dispname=k[0].gsub(' ','_')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Weapons/#{dispname}.png?raw=true"
  str=''
  if !k[14].nil? && k[14]=='FEH'
    str=generate_rarity_row(k[2][0,1].to_i,0,'FEH',(k[16]==0))
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[3].gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Anima')}"}
    title="#{moji[0].mention unless moji.length<=0}**#{k[3]}**"
    wpn='<:Gold_Unknown:774013610908188682>'
    wpn='<:Red_Blade:443172811830198282>' if k[1]=='Sword'
    wpn='<:Colorless_Blade:443692132310712322>' if k[1]=='Blade'
    wpn='<:Colorless_Dagger:443692132683743232>' if k[1]=='Dagger'
    wpn='<:Green_Blade:467122927230386207>' if k[1]=='Axe'
    wpn='<:Colorless_Bow:443692132616896512>' if k[1]=='Bow'
    wpn='<:Blue_Blade:467112472768151562>' if k[1]=='Lance'
    wpn='<:Colorless_Tome:443692133317345290>' if k[1]=='Wand'
    wpn='<:Red_Tome:443172811826003968>' if k[1]=='Wand' && ['Flame','Shadow'].include?(k[3])
    wpn='<:Blue_Tome:467112472394858508>' if k[1]=='Wand' && ['Water','Light'].include?(k[3])
    wpn='<:Green_Tome:467122927666593822>' if k[1]=='Wand' && k[3]=='Wind'
    wpn='<:Colorless_Staff:443692132323295243>' if k[1]=='Staff'
    wpn='<:Summon_Gun:467557566050861074>' if k[1]=='Manacaster'
    title="#{title}\n#{wpn}**#{k[1]}**"
    title="#{title}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
  elsif !k[14].nil? && k[14]=='FGO'
    str=generate_rarity_row(k[2][0,1].to_i,0,'FGO',(k[16]==0))
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[3].gsub('None','Null')}"}
    title="#{moji[0].mention unless moji.length<=0}**#{k[3]}**"
    clzz='unknown'
    clzz='saber' if k[1]=='Sword'
    clzz='blade' if k[1]=='Blade'
    clzz='extra' if k[1]=='Dagger'
    clzz='berserker' if k[1]=='Axe'
    clzz='archer' if k[1]=='Bow'
    clzz='lancer' if k[1]=='Lance'
    clzz='caster' if k[1]=='Wand'
    clzz='healer' if k[1]=='Staff'
    clzz='mooncancer' if k[1]=='Manacaster'
    srv=523821178670940170
    srv=523825319916994564 if ['Staff','Blade'].include?(k[1])
    clr='gold'
    clr='silver' if k[2][0,1].to_i==4
    clr='bronze' if k[2][0,1].to_i<4
    moji=bot.server(srv).emoji.values.reject{|q| q.name != "class_#{clzz}_#{clr}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[1]}**"
    title="#{title}\n<:Bond:613804021119189012>**FGO Collab**"
  else
    str=generate_rarity_row(k[2][0,1].to_i,0,'',(k[16]==0))
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[3].gsub('None','Null')}"}
    title="#{moji[0].mention unless moji.length<=0}**#{k[3]}**"
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[1]}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[1]}**"
    title="#{title}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**" if !k[14].nil? && k[14]=='MH'
    title="#{title}\n<:Mega_Man:641484836304846857>**Mega Man Collab**" if !k[14].nil? && k[14]=='MM'
    title="#{title}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**" if !k[14].nil? && k[14]=='PC'
    title="#{title}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**" if !k[14].nil? && k[14]=='P5S'
    title="#{title}\n**Collab**" unless k[14].nil? || k[14].length<=0 || ['MM','MH','PC','P5S'].include?(k[14])
    title="#{title}\n**Collab**" if k[2].length>1 && k[2][1,1].downcase=='c' && !['MM','MH','PC','P5S'].include?(k[14])
  end
  str="#{str} - T#{k[16]}" unless k[16]==0
  str="#{str}\n**Wyrmprint slots:** #{k[17][0]}<:Weapon_Slot_Gold:758940716427902996>, #{k[17][1]}<:Weapon_Slot_Silver:758940716436815872>" unless k[17].nil?
  if ['a','h'].include?(k[2][1,1])
    str="#{str}\n**Weapon Bonus:** <:HP:573344832307593216>+1.5% <:Strength:573344931205349376>+1.5%"
  elsif ['m'].include?(k[2][1,1])
    str="#{str}\n**Weapon Bonus:** <:HP:573344832307593216>+0.5% <:Strength:573344931205349376>+0.5%"
  elsif k[2].to_i.to_s==k[2] && ![nil,'',' ','-','None','Null'].include?(k[3])
    str="#{str}\n**Weapon Bonus:** <:HP:573344832307593216>+0.5% <:Strength:573344931205349376>+0.5%"
  end
  lookout=get_lookout_tags().reject{|q| q[2]!='Availability' && q[2]!='Availability/Weapon'}
  for i in 0...lookout.length
    if k[2].length>1 && k[2][1,1].downcase==lookout[i][3]
      if !lookout[i][4].nil? && lookout[i][4].include?('<')
        if !k[14].nil? && k[14]=='FEH' && !lookout[i][5].nil? && lookout[i][5].length>0
          title="#{title}\n#{lookout[i][5][0]}**#{lookout[i][0]}**"
        elsif !k[14].nil? && k[14]=='FGO' && !lookout[i][5].nil? && lookout[i][5].length>0
          title="#{title}\n#{lookout[i][5][1]}**#{lookout[i][0]}**"
        else
          title="#{title}\n#{lookout[i][4]}**#{lookout[i][0]}**"
        end
      else
        title="#{title}\n**#{lookout[i][0]}**"
      end
    end
  end
  title="#{title}\n**Seasonal**" if k[2].length>1 && k[2][1,1].downcase=='s'
  f=30*k[2][0,1].to_i-50
  f+=40-10*k[2][0,1].to_i if k[2][0,1].to_i<3
  f=200 if k[2][0,1].to_i>5
  f0=30*k[2][0,1].to_i-70
  f0=5*k[2][0,1].to_i if k[2][0,1].to_i<3
  f0=100 if k[2][0,1].to_i>5
  wpnz=@weapons.map{|q| q}
  sklz=@askilities.map{|q| q}
  skl=nil
  skl=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6][0]} if !k[6].nil? && k[6].length>0 && !k[6][0].nil? && k[6][0].length>0
  unless skl.nil?
    skl=sklz[skl]
    mx=skl[3,3].reject{|q| q.nil? || q.length<=0}
    mx.push(skl[11]) if !skl[11].nil? && skl[11].length>0
    if skl.length>13
      for i in 13...skl.length
        mx.push(skl[i]) if !skl[i].nil? && skl[i].length>0
      end
    end
    smolsp=[skl[6][mx.length-1]]
    smolsp=[] if skl[6][0,mx.length].max != skl[6][0,mx.length].min
    smolsp2=[]
    kk=[]
    kk=skl[6][5,skl[6].length-5] if skl[6].length>5
    if kk.length>0
      for i in 0...kk.length/7
        smolsp.push(kk[i*7+mx.length]) unless kk[i*7+mx.length]==skl[6][0]
        smolsp2.push(kk[i*7+6]) unless kk[i*7+6]==skl[12][1]
      end
    end
  end
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
  semoji=['<:HP:573344832307593216>','<:Strength:573344931205349376>','<:Defense:573344832282689567>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>']
  semoji=['<:HP_S:514712247503945739>','<:StrengthS:514712248372166666>','<:Defense:573344832282689567>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if feh
  semoji=['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','<:ProtoShield:642287078943752202>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if !k[14].nil? && k[14]=='MM'
  semoji=['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','<:FGO_Def:653485374605361162>','<:Energize:559629242137051155>','<:Inspiring:688916587079663625>','<:Energation:688920529771692078>'] if !k[14].nil? && k[14]=='FGO'
  bemoji=['<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>']
  if s2s && !skl.nil? && !juststats
    eng=''
    eng=semoji[3] if skl[7]=='Yes'
    eng=semoji[4] if skl[10].include?('Damage')
    eng=semoji[5] if skl[7]=='Yes' && skl[10].include?('Damage')
    str="#{str}\n\n__**#{bemoji[0]*4} Level 1**__"
    str="#{str}\n#{semoji[0]}#{longFormattedNumber(k[4][0])}  #{semoji[1]}#{longFormattedNumber(k[5][0])}"
    str="#{str}\n*#{skl[0]}*#{eng}#{energy_emoji(skl[10])} - #{longFormattedNumber(skl[6][0])} SP#{"\n#{skl[3].gsub(';; ',"\n")}" unless skl[3].length>250}"
    str="#{str}\n*#{abl[0]}#{" #{'+' if abl[1].include?('%')}#{abl[1]}" unless abl[1]=='-'}*" unless abl.nil?
    str="#{str}\n*#{ablx[0]}#{" #{'+' if ablx[1].include?('%')}#{ablx[1]}" unless ablx[1]=='-'}*" unless ablx.nil?
    if (k[4][1]>0 || k[5][1]>0)
      str="#{str}\n\n__**#{bemoji[0]*4} Level #{f0}**__"
      str="#{str}\n#{semoji[0]}#{longFormattedNumber(k[4][1])}  #{semoji[1]}#{longFormattedNumber(k[5][1])}"
      str="#{str}\n*#{skl[0]}*#{eng}#{energy_emoji(skl[10])} - #{longFormattedNumber(skl[6][0])} SP#{"\n#{skl[3].gsub(';; ',"\n")}" unless skl[3].length>100}"
      str="#{str}\n*#{abl[0]}#{" #{'+' if abl[1].include?('%')}#{abl[1]}" unless abl[1]=='-'}*" unless abl.nil?
      str="#{str}\n*#{ablx[0]}#{" #{'+' if ablx[1].include?('%')}#{ablx[1]}" unless ablx[1]=='-'}*" unless ablx.nil?
    end
    eng=''
    if !k[6].nil? && k[6].length>1 && !k[6][1].nil? && k[6][1].length>0
      sklx=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6][1]}
      unless sklx.nil?
        skl=sklz[sklx]
        mx=skl[3,3].reject{|q| q.nil? || q.length<=0}
        mx.push(skl[11]) if !skl[11].nil? && skl[11].length>0
        if skl.length>13
          for i in 13...skl.length
            mx.push(skl[i]) if !skl[i].nil? && skl[i].length>0
          end
        end
        smolsp=[skl[6][mx.length-1]]
        smolsp=[] if skl[6][0,mx.length].max != skl[6][0,mx.length].min
        smolsp2=[]
        kk=[]
        kk=skl[6][5,skl[6].length-5] if skl[6].length>5
        if kk.length>0
          for i in 0...kk.length/7
            smolsp.push(kk[i*7+mx.length]) unless kk[i*7+mx.length]==skl[6][0]
            smolsp2.push(kk[i*7+6]) unless kk[i*7+6]==skl[12][1]
          end
        end
      end
    end
    eng=" - #{semoji[3]}Energizable" if skl[7]=='Yes'
    eng=" - #{semoji[4]}Inspirable" if skl[10].include?('Damage')
    eng=" - #{semoji[5]}Energizable/Inspirable" if skl[7]=='Yes' && skl[10].include?('Damage')
    str="#{str}\n\n__**#{bemoji[1]*4} Level #{f}**__"
    str="#{str}\n#{semoji[0]}#{longFormattedNumber(k[4][2])}  #{semoji[1]}#{longFormattedNumber(k[5][2])}"
    str="#{str}\n*#{skl[0]}*#{eng}#{energy_emoji(skl[10],true)}#{" - #{longFormattedNumber(skl[6][0])} SP" unless skl[6][1]<=0}\n#{skl[4].gsub(';; ',"\n")}"
    str="#{str}\n*#{abl2[0]}#{" #{'+' if abl2[1].include?('%')}#{abl2[1]}" unless abl2[1]=='-'}*" unless abl2.nil?
    str="#{str}\n*#{abl[0]}#{" #{'+' if abl[1].include?('%')}#{abl[1]}" unless abl[1]=='-'}*" if abl2.nil? && !abl.nil?
    str="#{str}\n*#{ablx2[0]}#{" #{'+' if ablx2[1].include?('%')}#{ablx2[1]}" unless ablx2[1]=='-'}*" unless ablx2.nil?
    str="#{str}\n*#{ablx[0]}#{" #{'+' if ablx[1].include?('%')}#{ablx[1]}" unless ablx[1]=='-'}*" if ablx2.nil? && !ablx.nil?
  else
    str="#{str}\n\n**#{bemoji[0]*4} Level 1**  #{semoji[0]}#{longFormattedNumber(k[4][0])}  #{semoji[1]}#{longFormattedNumber(k[5][0])}"
    str="#{str}\n**#{bemoji[0]*4} Level #{f0}**  #{semoji[0]}#{longFormattedNumber(k[4][1])}  #{semoji[1]}#{longFormattedNumber(k[5][1])}" if (k[4][1]>0 || k[5][1]>0)
    str="#{str}\n**#{bemoji[1]*4} Level #{f}**  #{semoji[0]}#{longFormattedNumber(k[4][2])}  #{semoji[1]}#{longFormattedNumber(k[5][2])}"
    strx=''
    unless juststats
      unless skl.nil?
        eng=''
        eng=" - #{semoji[3]}Energizable" if skl[7]=='Yes'
        eng=" - #{semoji[4]}Inspirable" if skl[10].include?('Damage')
        eng=" - #{semoji[5]}Energizable/Inspirable" if skl[7]=='Yes' && skl[10].include?('Damage')
        str="#{str}\n\n**Skill:** *#{skl[0]}*#{eng}#{energy_emoji(skl[10])}"
        if skl[6][0]==skl[6][1] || skl[6][1]<=0
          str="#{str}#{" - #{longFormattedNumber(skl[6][0])} SP" unless skl[6][0]<=0};;;;;"
        else
          str="#{str} - #{longFormattedNumber(skl[6][0])} (L1) \u2192 #{longFormattedNumber(skl[6][1])} (L2) SP;;;;;"
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
  end
  str2=''
  unless juststats
    if s2s
      m2=wpnz.find_index{|q| q[8]==k[9] && !['','0',0].include?(q[8])}
      m=wpnz.reject{|q| q[9]!=k[8] || ['','0',0].include?(q[9])}
      mmm2=nil
      mmm2=wpnz.find_index{|q| q[1]==k[1] && q[3]==k[3] && q[2][1,1]=='m'} if k[2][1,1]=='a'
      mmm2=wpnz.find_index{|q| q[1]==k[1] && q[3]==k[3] && q[2]=='5'} if k[2][1,1]=='h'
      str2="#{str2}#{"\n" unless m.length==1}\n\n**Promotes from: #{weapon_emoji(wpnz[m2],bot)}*#{wpnz[m2][0]}* **#{"\n*Smithy level required:* #{k[10]}" unless k[2][1,1]=='h'}\n*Assembly cost:* #{longFormattedNumber(k[11][0])}#{bemoji[2]}\n*Required mats:* #{k[12].map{|q| "#{q[0]} x#{q[1]}"}.join(', ')}" unless m2.nil?
      str2="#{str2}#{"\n" unless m.length==1}\n\n**Crafting requirements: #{weapon_emoji(wpnz[mmm2],bot)}*#{wpnz[mmm2][0]}* **" unless mmm2.nil?
      if m.length>0
        for i in 0...m.length
          str2="#{str2}#{"\n" if i==0 && m.length != 1}\n\n**#{"Promotion #{i+1}" if m.length>1}#{'Promotes into' if m.length==1}: #{element_emote(m[i][3],bot)}*#{m[i][0]}* **#{"\n*Smithy level required:* #{m[i][10]}" unless k[2][1,1]=='h'}\n*Assembly cost:* #{longFormattedNumber(m[i][11][0])}#{bemoji[2]}\n*Required mats:* #{m[i][12].map{|q| "#{q[0]} x#{q[1]}"}.join(', ')}"
        end
      end
    else
      m=wpnz.find_index{|q| q[8]==k[9] && !['','0',0].include?(q[8])}
      str2="#{str2}\n**Promotes from:** #{element_emote(wpnz[m][3],bot)}#{wpnz[m][0]}" unless m.nil?
      mmm2=nil
      mmm2=wpnz.find_index{|q| q[1]==k[1] && q[3]==k[3] && q[2][1,1]=='m'} if k[2][1,1]=='a'
      mmm2=wpnz.find_index{|q| q[1]==k[1] && q[3]==k[3] && q[2]=='5'} if k[2][1,1]=='h'
      str2="#{str2}\n**Crafting requirement:** #{element_emote(wpnz[mmm2][3],bot)}#{wpnz[mmm2][0]}" unless mmm2.nil?
      m=wpnz.reject{|q| q[9]!=k[8] || ['','0',0].include?(q[9])}
      str2="#{str2}\n**Promotes into:** #{m.map{|q| "#{element_emote(q[3],bot)}#{q[0]}"}.join(', ')}" unless m.length<=0
    end
    str="#{str}#{"\n" unless s2s}#{str2}" if str2.length>0
    str="#{str}\n**Assembles for:** #{longFormattedNumber(k[11][0])}#{bemoji[2]}"
  end
  unless s2s
    if str.gsub(';;;;;',"\n#{strx}").length>=1900
      str=str.gsub(';;;;;',"\n~~The description makes this data too long.  Please try again in PM.~~")
    else
      str=str.gsub(';;;;;',"\n#{strx}")
    end
  end
  ftr='Try using the mats command on this weapon!'
  ftl=0
  ftl=ftr.length unless ftr.nil?
  if str.length+title.length+ftl>=1900
    str=str.split("\n\n\n")
    if str[0].length>=1900
      str[0]=str[0].split("**Promotes ")
      for i in 1...str[0].length
        str[0][i]="**Promotes #{str[0][i]}"
      end
      str.flatten!
      if str[0].length>=1900
        str[0]=str[0].split("\n\n")
        stp=0
        for i in 1...str[0].length
          if "#{str[0][stp]}\n\n#{str[0][i]}".length<1900
            str[0][stp]="#{str[0][stp]}\n\n#{str[0][i]}"
            str[0][i]=nil
          else
            stp=i*1
          end
        end
        str[0].compact!
        str.flatten!
      end
    end
    create_embed(event,["__**#{k[0]}**__",title],str[0],element_color(k[3]),nil,xpic)
    if str[1,str.length-1].join("\n\n\n").length<1900
      create_embed(event,'',str[1,str.length-1].join("\n\n\n"),element_color(k[3])) unless str.length<2
    else
      for i in 1...str.length
        create_embed(event,'',str[i],element_color(k[3]))
      end
    end
    event.respond ftr unless ftr.nil?
  else
    create_embed(event,["__**#{k[0]}**__",title],str,element_color(k[3]),ftr,xpic)
  end
  return nil
end

def disp_weapon_lineage(bot,event,args=nil,comparedata=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_weapon,args.join(' '),event,true)
  kx=find_data_ex(:find_weapon,args.join(' '),event,true,true)
  kx=comparedata.map{|q| q} unless comparedata.nil?
  if k.length.zero? || k[0]=='Water Dagger'
    k4=find_in_weapons(bot,event,args,2,false,true)
    unless k4.nil? || k4.length<=0
      args2=args.map{|q| q}
      args2=args2.reject{|q| q.to_i.to_s==q || q.gsub('*','').to_i.to_s==q.gsub('*','')} if k4.map{|q| q[2][0,1]}.uniq.length==1
      args2=args2.join(' ')
      if k4.map{|q| q[3]}.uniq.length==1
        args2=first_sub(args2,k4[0][3].downcase,'')
        args2=first_sub(args2,'fire','') if k4[0][3]=='Flame'
        args2=first_sub(args2,'dark','') if k4[0][3]=='Shadow'
      end
      if k4.map{|q| q[1]}.uniq.length==1
        args2=first_sub(args2,k4[0][1].downcase,'')
        args2=first_sub(args2,'spear','') if k4[0][1]=='Lance'
      end
      args2=first_sub(args2,'void','') if k4.reject{|q| q[1][1,1]!='v'}.length<=0
      k2=find_data_ex(:find_enemy,args2,event)
      if k2.length>0 && k2[2][2]=='Void'
        k3=k4.reject{|q| q[15].nil? || q[15]!=k2[0]}
        k4=k3.map{|q| q} if k3.length>0
      end
      kk5=3
      kk5=8 if safe_to_spam?(event)
      if k4.length>kk5 && find_data_ex(:find_weapon,args.join(' '),event).length<=0
        event.respond "Too many weapons qualify.  I will not display them all."
        return nil
      end
      unless k4.length>3
        if kx.length<=0
          kx=[[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
        elsif !kx[0].is_a?(Array)
          kx=[kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx]
        elsif k.length>k2.length
          for i in 0...k.length-k2.length+1
            k2.push(k2[i])
          end
        end
        for i in 0...k4.length
          disp_weapon_lineage(bot,event,k4[i][0].split(' '),kx[i])
        end
        return nil
      end
    end
  end
  if k.length.zero?
    k=find_data_ex(:find_weapon,args.join(' '),event)
    kx=find_data_ex(:find_weapon,args.join(' '),event,false,true)
  end
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  elsif k[0].is_a?(Array)
    k2=find_data_ex(:find_enemy,args.join(' '),event)
    if k2.length>0 && k2[2][2]=='Void'
      k3=k.reject{|q| q[15].nil? || q[15]!=k2[0]}
      k=k3.map{|q| q} if k3.length>0
    end
    if kx.length<=0
      kx=[[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
    elsif !kx[0].is_a?(Array)
      kx=[kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx,kx]
    elsif k.length>k2.length
      for i in 0...k.length-k2.length+1
        k2.push(k2[i])
      end
    end
    for i in 0...k.length
      disp_weapon_lineage(bot,event,k[i][0].split(' '),kx[i])
    end
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  feh=false
  feh=true if !k[14].nil? && k[14]=='FEH'
  evn=event.message.text.downcase.split(' ')
  dispname=k[0].gsub(' ','_')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Weapons/#{dispname}.png?raw=true"
  mub=false
  mub=true if has_any?(['mub','unbind','unbound','refined','refine','refinement'],evn)
  val=0
  unbindnum=false
  for i in 0...args.length
    if count_in(args,args[i])<2 && args[i].to_i==k[2][0,1].to_i && k != kx && !args.include?("#{args[i]}*")
    elsif args[i].to_i.to_s==args[i] && args[i].to_i>0
      val=args[i].to_i unless unbindnum || val>0
    elsif args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<5 && ['ub','unbind','unbound','unbinds','unbounds'].include?(args[i][1,args[i].length-1].downcase)
      val=args[i].to_i+1 unless val>0
      unbindnum=true
    end
  end
  val=1 if val<=0
  val=1 if val>1 && k[0].include?(" #{val}") && !args.map{|q| q.downcase}.include?(k[0].downcase.gsub(' ','')) && count_in(args.map{|q| q.downcase},val.to_s)<2
  if val%5==0 && !mub
    mub=true
    val/=5
  end
  if !k[14].nil? && k[14]=='FEH'
    str=generate_rarity_row(k[2][0,1].to_i,0,'FEH',(k[16]==0))
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{k[3].gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Anima')}"}
    title="#{moji[0].mention unless moji.length<=0}**#{k[3]}**"
    wpn='<:Gold_Unknown:774013610908188682>'
    wpn='<:Red_Blade:443172811830198282>' if k[1]=='Sword'
    wpn='<:Colorless_Blade:443692132310712322>' if k[1]=='Blade'
    wpn='<:Colorless_Dagger:443692132683743232>' if k[1]=='Dagger'
    wpn='<:Green_Blade:467122927230386207>' if k[1]=='Axe'
    wpn='<:Colorless_Bow:443692132616896512>' if k[1]=='Bow'
    wpn='<:Blue_Blade:467112472768151562>' if k[1]=='Lance'
    wpn='<:Colorless_Tome:443692133317345290>' if k[1]=='Wand'
    wpn='<:Red_Tome:443172811826003968>' if k[1]=='Wand' && ['Flame','Shadow'].include?(k[3])
    wpn='<:Blue_Tome:467112472394858508>' if k[1]=='Wand' && ['Water','Light'].include?(k[3])
    wpn='<:Green_Tome:467122927666593822>' if k[1]=='Wand' && k[3]=='Wind'
    wpn='<:Colorless_Staff:443692132323295243>' if k[1]=='Staff'
    wpn='<:Summon_Gun:467557566050861074>' if k[1]=='Manacaster'
    title="#{title}\n#{wpn}**#{k[1]}**"
    title="#{title}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
  elsif !k[14].nil? && k[14]=='FGO'
    str=generate_rarity_row(k[2][0,1].to_i,0,'FGO',(k[16]==0))
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[3].gsub('None','Null')}"}
    title="#{moji[0].mention unless moji.length<=0}**#{k[3]}**"
    clzz='unknown'
    clzz='saber' if k[1]=='Sword'
    clzz='blade' if k[1]=='Blade'
    clzz='extra' if k[1]=='Dagger'
    clzz='berserker' if k[1]=='Axe'
    clzz='archer' if k[1]=='Bow'
    clzz='lancer' if k[1]=='Lance'
    clzz='caster' if k[1]=='Wand'
    clzz='healer' if k[1]=='Staff'
    clzz='mooncancer' if k[1]=='Manacaster'
    srv=523821178670940170
    srv=523825319916994564 if ['Staff','Blade'].include?(k[1])
    clr='gold'
    clr='silver' if k[2][0,1].to_i==4
    clr='bronze' if k[2][0,1].to_i<4
    moji=bot.server(srv).emoji.values.reject{|q| q.name != "class_#{clzz}_#{clr}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[1]}**"
    title="#{title}\n<:Bond:613804021119189012>**FGO Collab**"
  else
    str=generate_rarity_row(k[2][0,1].to_i,0,'',(k[16]==0))
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{k[3].gsub('None','Null')}"}
    title="#{moji[0].mention unless moji.length<=0}**#{k[3]}**"
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{k[1]}"}
    title="#{title}\n#{moji[0].mention unless moji.length<=0}**#{k[1]}**"
    title="#{title}\n<:Mega_Man:641484836304846857>**Mega Man Collab**" if !k[14].nil? && k[14]=='MM'
    title="#{title}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**" if !k[14].nil? && k[14]=='MH'
    title="#{title}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**" if !k[14].nil? && k[14]=='PC'
    title="#{title}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**" if !k[14].nil? && k[14]=='P5S'
    title="#{title}\n**Collab**" unless k[14].nil? || k[14].length<=0 || ['MM','MH','PC','P5S'].include?(k[14])
    title="#{title}\n**Collab**" if k[2].length>1 && k[2][1,1].downcase=='c' && !['MM','MH','PC','P5S'].include?(k[14])
  end
  str="#{str} - T#{k[16]}" unless k[16]==0
  str="#{str}\n**Wyrmprint slots:** #{k[17][0]}<:Weapon_Slot_Gold:758940716427902996>, #{k[17][1]}<:Weapon_Slot_Silver:758940716436815872>" unless k[17].nil?
  bftr=false
  if ['a','h'].include?(k[2][1,1])
    str="#{str}\n**Weapon Bonus:** <:HP:573344832307593216>+1.5% <:Strength:573344931205349376>+1.5%"
    bftr=true
  elsif ['m'].include?(k[2][1,1])
    str="#{str}\n**Weapon Bonus:** <:HP:573344832307593216>+0.5% <:Strength:573344931205349376>+0.5%"
    bftr=true
  elsif k[2].to_i.to_s==k[2] && ![nil,'',' ','-','None','Null'].include?(k[3])
    str="#{str}\n**Weapon Bonus:** <:HP:573344832307593216>+0.5% <:Strength:573344931205349376>+0.5%"
    bftr=true
  end
  lookout=get_lookout_tags().reject{|q| q[2]!='Availability' && q[2]!='Availability/Weapon'}
  for i in 0...lookout.length
    if k[2].length>1 && k[2][1,1].downcase==lookout[i][3]
      if !lookout[i][4].nil? && lookout[i][4].include?('<')
        if !k[14].nil? && k[14]=='FEH' && !lookout[i][5].nil? && lookout[i][5].length>0
          title="#{title}\n#{lookout[i][5][0]}**#{lookout[i][0]}**"
        elsif !k[14].nil? && k[14]=='FGO' && !lookout[i][5].nil? && lookout[i][5].length>0
          title="#{title}\n#{lookout[i][5][1]}**#{lookout[i][0]}**"
        else
          title="#{title}\n#{lookout[i][4]}**#{lookout[i][0]}**"
        end
      else
        title="#{title}\n**#{lookout[i][0]}**"
      end
    end
  end
  title="#{title}\n**Seasonal**" if k[2].length>1 && k[2][1,1].downcase=='s'
  f=30*k[2][0,1].to_i-50
  f+=20 if k[2][0,1].to_i<3
  f=200 if k[2][0,1].to_i>5
  f0=30*k[2][0,1].to_i-70
  f0=5*k[2][0,1].to_i if k[2][0,1].to_i<3
  f0=100 if k[2][0,1].to_i>5
  wpnz=@weapons.map{|q| q}
  sklz=@askilities.map{|q| q}
  skl=nil
  skl=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6][0]} if !k[6].nil? && k[6].length>0 && !k[6][0].nil? && k[6][0].length>0
  skl=sklz.find_index{|q| q[2]=='Skill' && q[0]==k[6][1]} if mub && !k[6].nil? && k[6].length>1 && !k[6][1].nil? && k[6][1].length>0
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
  semoji=['<:HP:573344832307593216>','<:Strength:573344931205349376>','<:Defense:573344832282689567>']
  semoji=['<:HP_S:514712247503945739>','<:StrengthS:514712248372166666>','<:Defense:573344832282689567>'] if feh
  semoji=['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','<:FGO_Def:653485374605361162>'] if !k[14].nil? && k[14]=='FGO'
  semoji=['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','<:ProtoShield:642287078943752202>'] if !k[14].nil? && k[14]=='MM'
  bemoji=['<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>']
  str="#{str}\n"
  if mub
    str="#{str}\n**#{bemoji[1]*4} Level #{f}**  #{semoji[0]}#{longFormattedNumber(k[4][2])}  #{semoji[1]}#{longFormattedNumber(k[5][2])}"
  else
    str="#{str}\n**#{bemoji[0]*4} Level 1**  #{semoji[0]}#{longFormattedNumber(k[4][0])}  #{semoji[1]}#{longFormattedNumber(k[5][0])}"
    str="#{str}\n**#{bemoji[0]*4} Level #{f0}**  #{semoji[0]}#{longFormattedNumber(k[4][1])}  #{semoji[1]}#{longFormattedNumber(k[5][1])}" if (k[4][1]>0 || k[5][1]>0)
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
  val*=5 if mub
  ftr=nil
  str="#{str}#{"\n\n**Crafting shown for #{'<:Unbind:534494090969088000>'*([val-1,4].min)}#{'<:NonUnbound:534494090876682264>'*([5-val,0].max)}**" if val>1 && !mub}\n\n**This weapon#{" (x#{val})" unless val==1}**"
  str="#{str}\n*Smithy level required:* #{k[10]}" unless k[10].to_i<=0
  str="#{str}\n*Assembly cost:* #{longFormattedNumber(val*k[11][0])}#{bemoji[2]}#{"\n*Required mats:* #{k[12].map{|q| "#{q[0]} x#{val*q[1].to_i}"}.join(', ')}" unless k[12].nil?}"
  m2=wpnz.find_index{|q| q[8]==k[9] && !['','0',0].include?(q[8])}
  mmm2=nil
  mmm2=wpnz.find_index{|q| q[1]==k[1] && q[3]==k[3] && q[2][1,1]=='m'} if k[2][1,1]=='a'
  mmm2=wpnz.find_index{|q| q[1]==k[1] && q[3]==k[3] && q[2]=='5'} if k[2][1,1]=='h'
  cost=0
  cost+=val*k[11][0]
  mtz=[]
  unless k[12].nil?
    for i in 0...k[12].length
      mtz.push([k[12][i][0],k[12][i][1].to_i*val])
    end
  end
  unless m2.nil? && mmm2.nil?
    ptype='Promotes from'
    if m2.nil?
      ptype='Crafting requirements'
      m2=mmm2*1
      val/=5.0
    end
    str2="#{str2}\n\n**#{ptype}: #{weapon_emoji(wpnz[m2],bot)}*#{wpnz[m2][0]}* (x#{(5*val).to_i})**\n*Assembly cost:* #{longFormattedNumber((val*5*wpnz[m2][11][0]).to_i)}#{bemoji[2]}\n#{"*Required mats:* #{wpnz[m2][12].map{|q| "#{q[0]} x#{(val*5*q[1].to_i).to_i}"}.join(', ')}" unless wpnz[m2][12].nil?}"
    cost+=val*5*wpnz[m2][11][0]
    unless wpnz[m2][12].nil?
      for i in 0...wpnz[m2][12].length
        mtz.push([wpnz[m2][12][i][0],wpnz[m2][12][i][1].to_i*5*val])
      end
    end
    m22=wpnz.find_index{|q| q[8]==wpnz[m2][9] && !['','0',0].include?(q[8])}
    unless m22.nil?
      str2="#{str2}\n\n**Which promotes from: #{element_emote(wpnz[m22][3],bot)}*#{wpnz[m22][0]}* (x#{(25*val).to_i})**\n*Assembly cost:* #{longFormattedNumber((val*25*wpnz[m22][11][0]).to_i)}#{bemoji[2]}\n*#{"Required mats:* #{wpnz[m22][12].map{|q| "#{q[0]} x#{(val*25*q[1].to_i).to_i}"}.join(', ')}" unless wpnz[m22][12].nil?}"
      cost+=val*25*wpnz[m22][11][0]
      unless wpnz[m22][12].nil?
        for i in 0...wpnz[m22][12].length
          mtz.push([wpnz[m22][12][i][0],wpnz[m22][12][i][1].to_i*25*val])
        end
      end
      m222=wpnz.find_index{|q| q[8]==wpnz[m22][9] && !['','0',0].include?(q[8])}
      unless m222.nil?
        str2="#{str2}\n\n**Which promotes from: #{element_emote(wpnz[m222][3],bot)}*#{wpnz[m222][0]}* (x#{(125*val).to_i})**\n*Assembly cost:* #{longFormattedNumber((val*125*wpnz[m222][11][0]).to_i)}#{bemoji[2]}\n#{"*Required mats:* #{wpnz[m222][12].map{|q| "#{q[0]} x#{(val*125*q[1].to_i).to_i}"}.join(', ')}" unless wpnz[m222][12].nil?}"
        cost+=val*125*wpnz[m222][11][0]
        unless wpnz[m222][12].nil?
          for i in 0...wpnz[m222][12].length
            mtz.push([wpnz[m222][12][i][0],wpnz[m222][12][i][1].to_i*125*val])
          end
        end
      end
    end
  end
  ftr='Include the word "Unbound" to show the data for MUB versions of these weapons.' unless mub || !s2s
  ftr="This is multiplying all crafts by #{val}.  For crafts for a #{val}UB weapon, include \"#{val}UB\" in your message instead." if val>1 && val<5 && !unbindnum
  ftr="Weapon bonus is applied to all #{k[1]}-using adventurers, after this weapon is fully upgraded."
  unless s2s
    str2=''
    unless m2.nil? && mmm2.nil?
      ptype='Promotes from'
      ptype='Crafting requirements' if m2.nil?
      str2="#{str2}\n\n**#{ptype}:** #{wpnz[m2][0]}"
      unless m22.nil?
        str2="#{str2}\n**Which promotes from:** #{wpnz[m22][0]}"
        str2="#{str2}\n**Which promotes from:** #{wpnz[m222][0]}" unless m222.nil?
      end
    end
  end
  str3=''
  unless m2.nil?
    str3="**TOTALS**\n*Assembly cost:* #{longFormattedNumber(cost.to_i)}#{bemoji[2]}\n*Required Mats:* "
    mtzz=mtz.map{|q| q[0]}.uniq
    for i in 0...mtzz.length
      str3="#{str3}#{', ' unless i==0}#{mtzz[i]} x#{mtz.reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i}.inject(0){|sum,x| sum + x }}"
    end
  end
  str="#{str}#{str2}" if str2.length>0
  unless s2s
    if str.gsub(';;;;;',"\n#{strx}").length>=1200
      str=str.gsub(';;;;;',"\n~~The description makes this data too long.  Please try again in PM.~~")
    else
      str=str.gsub(';;;;;',"\n#{strx}")
    end
  end
  if str.length+str3.length+title.length>=1900
    create_embed(event,["__**#{k[0]}**__",title],str,element_color(k[3]),nil,xpic)
    create_embed(event,'',str3,element_color(k[3]),ftr)
  else
    create_embed(event,["__**#{k[0]}**__",title],"#{str}\n\n#{str3}",element_color(k[3]),ftr,xpic)
  end
end

def disp_enemy_data(bot,event,args=nil,ignoresub=false)
  reload_library()
  return enemy_data(bot,event,args,ignoresub)
end

def disp_skill_data(bot,event,args=nil,forcetags=false,topstr=[])
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_skill,args.join(' '),event)
  forcetags=true if args.include?('tags')
  if k.length.zero?
    sklz=@askilities.map{|q| q}
    if args.join('').include?('shift')
      disp_status_data(bot,event,['skill','shift'])
    elsif args.join('').downcase.gsub('s','').include?('dragonclaw')
      disp_skill_data(bot,event,['dragon','claw'])
    elsif find_data_ex(:find_adventurer,args.join(' '),event).length>0 && has_any?(args,['s1','s2','1','2','skill1','skill2','skl1','skl2'])
      adv=find_data_ex(:find_adventurer,args.join(' '),event)
      p=0
      p=1 if has_any?(args,['s2','2','skill2','skl2'])
      if adv[6].nil? || adv[6].length<=0 || adv[6][p].nil? || adv[6][p].length<=0
        event.respond "#{adv[0]} does not have a #{['1st','2nd'][p]} skill."
        return nil
      end
      skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==adv[6][p]}
      if skl1.nil?
        event.respond "#{adv[0]}'s #{['1st','2nd'][p]} skill, #{adv[6][p]}, has no data."
        return nil
      end
      disp_skill_data(bot,event,adv[6][p].split(' '),forcetags)
    elsif find_data_ex(:find_dragon,args.join(' '),event).length>0
      adv=find_data_ex(:find_dragon,args.join(' '),event)
      p=0
      p=1 if has_any?(args,['s2','2','skill2','skl2'])
      if adv[5].nil? || adv[5].length<=0 || adv[5][p].nil? || adv[5][p].length<=0
        event.respond "#{adv[0]} does not have a#{[' 1st',' 2nd'][p] if p>0 || (!adv[5].nil? && adv[5].length>1)} skill."
        return nil
      end
      p=0 if adv[5].length<2
      skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==adv[5][p]}
      if skl1.nil?
        event.respond "#{adv[0]}'s#{[' 1st',' 2nd'][p] if adv[5].length>1} skill, #{adv[5]}, has no data."
        return nil
      end
      disp_skill_data(bot,event,adv[5].split(' '),forcetags)
    elsif find_data_ex(:find_weapon,args.join(' '),event).length>0 && has_any?(args,['s3','skill3','skl3'])
      adv=find_data_ex(:find_weapon,args.join(' '),event)
      if adv[0].is_a?(Array)
        event.respond "There are multiple weapons with that criterium, and I won't display a skill for each."
        return nil
      elsif adv[6].nil? || adv[6].length<=0
        event.respond "#{adv[0]} does not have a skill."
        return nil
      end
      skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==adv[6]}
      if skl1.nil?
        event.respond "#{adv[0]}'s skill, #{adv[6]}, has no data."
        return nil
      end
      disp_skill_data(bot,event,adv[6].split(' '),forcetags)
    else
      event.respond 'No matches found.'
    end
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  dispname=k[0].gsub(' ','_')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Skills/#{dispname}.png?raw=true"
  xcolor=0x02010a
  xcolor=topstr[1] if topstr.length>0
  mx=k[3,3].reject{|q| q.nil? || q.length<=0}
  mx.push(k[11]) if !k[11].nil? && k[11].length>0
  if k.length>13
    for i in 13...k.length
      mx.push(k[i]) if !k[i].nil? && k[i].length>0
    end
  end
  str=''
  title=''
  smolsp=[longFormattedNumber(k[6][0])]
  smolsp2=k[6][0,5].map{|q| [q]}
  kk=[]
  kk=k[6][5,k[6].length-5] if k[6].length>5
  if kk.length>0
    for i in 0...kk.length/7
      smolsp.push(longFormattedNumber(kk[i*7+1])) unless kk[i*7+1]==k[6][0]
      for i2 in 0...mx.length
        smolsp2[i2].push(kk[i*7+i2+1])
      end
    end
  end
  smolsp2=smolsp2[0,mx.length]
  for i in 0...smolsp2.length
    if smolsp2[i].uniq.length==1
      smolsp2[i]=longFormattedNumber(smolsp2[i][0])
    else
      smolsp2[i]=smolsp2[i].map{|q| longFormattedNumber(q)}.join("\u2192")
    end
  end
  title="**SP Cost:** #{smolsp.join("\u2192")}" if smolsp2.uniq.length<=1 && k[6][0]>0 && topstr.length<=0
  title="#{title}\n**Invulnerability duration:** #{k[8]} seconds"
  k[12][1]=k[6][-1] if !k[12].nil? && k[12].length==1
  smolsp=[]
  unless k[12].nil? || k[12].length<=0
    smolsp=[longFormattedNumber(k[12][1])]
    kk=[]
    kk=k[6][5,k[6].length-5] if k[6].length>5
    if kk.length>0
      for i in 0...kk.length/7
        smolsp.push(longFormattedNumber(kk[i*7+6])) unless kk[i*7+6]==k[12][1]
      end
    end
  end
  title="#{title}\n**Skill Share:** *Cost:* #{k[12][0]}<:SkillShare:714597012733034547> / #{smolsp.join("\u2192")} SP\*" if !k[12].nil? && k[12].length>0
  title="#{title}\n<:Energize:559629242137051155> **Energizable**" if k[7]=='Yes'
  title="#{title}\n~~Not energizable~~" if k[7]=='No' && k[10].include?('Damage')
  title="#{title}\n<:Inspiring:688916587079663625> **Inspirable**" if k[10].include?('Damage')
  title="#{title}\n~~Not inspirable~~" if !k[10].include?('Damage') && k[7]!='No'
  title="#{title}\n~~Not energizable or inspirable~~" if k[7]=='No' && !k[10].include?('Damage')
  str="#{energy_emoji(k[10],true)}".gsub(', ',"\n")
  str2=''
  displvl=0
  for i in 0...mx.length
    if topstr.length<=0 || i>1 || (i==1 && mx.length<3)
      displvl+=1
      str2="#{str2}\n\n__**Level #{i+1}**__"
      str2="#{str2} - #{smolsp2[i]} SP" unless smolsp2.uniq.length<=1 || k[6][i]<=0
      if i>=3
        str2="#{str2}\n#{k[i+8].gsub(';; ',"\n")}"
      else
        str2="#{str2}\n#{k[i+3].gsub(';; ',"\n")}"
      end
    end
  end
  flds=[]
  m=[]
  advx=[]
  x=@adventurers.map{|q| q}
  for i in 0...x.length
    advx.push(x[i][0]) if x[i][6].include?(k[0])
    m.push("#{adv_emoji(x[i],bot)}#{x[i][0]} - S1") if x[i][6][0]==k[0]
    m.push("#{adv_emoji(x[i],bot)}#{x[i][0]} - S2") if x[i][6][1]==k[0]
  end
  flds.push(['Adventurers',m.join("\n")]) if m.length>0 && topstr.length<=0
  if topstr.length<=0
    m=[]
    x=@dragons.map{|q| q}
    for i in 0...x.length
      m.push("#{dragon_emoji(x[i],bot)}#{x[i][0]}") if x[i][5][0]==k[0] && x[i][5].length<2
      m.push("#{dragon_emoji(x[i],bot)}#{x[i][0]} - S1d") if x[i][5][0]==k[0] && x[i][5].length>1
      m.push("#{dragon_emoji(x[i],bot)}#{x[i][0]} - S2d") if x[i][5][1]==k[0] && x[i][5].length>1
    end
    flds.push(['Dragons',m.join("\n")]) if m.length>0
    m=[]
    x=@weapons.map{|q| q}
    for i in 0...x.length
      m.push("#{weapon_emoji(x[i],bot)}#{x[i][0]} - S3") if x[i][6][0]==k[0]
      m.push("#{weapon_emoji(x[i],bot)}#{x[i][0]} - refined S3") if x[i][6][1]==k[0]
    end
    flds.push(['Weapons',m.join("\n")]) if m.length>0
  end
  if args.include?('tags') || forcetags
    if flds.length<=0
      flds=triple_finish(k[10].reject{|q| ['E','I'].include?(q[0,1]) && q[1,1].to_i.to_s==q[1,1]})
      str2="#{str2}\n\n__**Tags**__"
    else
      flds.push(['Tags',k[10].reject{|q| ['E','I'].include?(q[0,1]) && q[1,1].to_i.to_s==q[1,1]}.join("\n")])
    end
  end
  str="#{str}\n\nYou may instead be searching for the ability family `Dragon's Claws`." if k[0]=='Dragon Claw' && topstr.length<=0
  kk=[]
  if !k[12].nil? && k[12].length>0
    advy=[]
    smolsp=[longFormattedNumber(23*k[12][1]/20)]
    kk=k[6][5,k[6].length-5] if k[6].length>5
    if kk.length>0
      for i in 0...kk.length/7
        smolsp.push(longFormattedNumber(23*kk[i*7+6]/20)) unless kk[i*7+6]==k[12][1]
      end
    end
    advy.push("#{smolsp.join("\u2192")} SP for Nef archetypes") unless advx.include?('Nefaria')
    smolsp=[longFormattedNumber(13*k[12][1]/10)]
    kk=[]
    kk=k[6][5,k[6].length-5] if k[6].length>5
    if kk.length>0
      for i in 0...kk.length/7
        smolsp.push(longFormattedNumber(13*kk[i*7+6]/10)) unless kk[i*7+6]==k[12][1]
      end
    end
    advy.push("#{smolsp.join("\u2192")} SP for Hawk archetypes") unless advx.include?('Hawk')
    ch=', '
    ch="\n" if kk.length>0
    str="#{str}\n\* #{advy.join(ch)}" if advy.length>0
  end
  flds=nil if flds.length<=0
  m=0
  m=flds.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length unless flds.nil?
  k[0]="__**#{k[0]}**__"
  k[0]="#{topstr[0]} - #{k[0]}" if topstr.length>0
  if str.length+title.length+str2.length+m<1800 && (displvl<2 || s2s || k[9].nil? || k[9].length<=0)
    str="#{str}#{str2}"
    create_embed(event,["#{k[0]}",title],str,xcolor,nil,xpic,flds)
  elsif str2.length<1800 && (displvl<2 || s2s || k[9].nil? || k[9].length<=0)
    create_embed(event,["#{k[0]}",title],str,xcolor,nil,xpic)
    create_embed(event,'',str2.gsub('__**Tags**__',''),xcolor)
    create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
  elsif displvl<2 || k[9].nil? || k[9].length<=0
    create_embed(event,["#{k[0]}",title],str,xcolor,nil,xpic)
    m=str2.split("\n\n").reject{|q| q.nil? || q.length<=0}
    s=''
    for i in 0...m.length
      s=extend_message(s,m[i],event,2)
    end
    event.respond s
    create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
  else
    str2="\n\n#{k[9].gsub(';; ',"\n")}"
    if k[6][0,mx.length].max==k[6][0,mx.length].min
      if kk.length>0
        for i2 in 0...kk.length/7
          str2="#{str2}#{"\n" if i2==0}\n#{kk[i2*7]} = #{longFormattedNumber(kk[i2*7+mx.length])} SP" unless kk[i2+mx.length]==k[6][0]
        end
      end
    else
      kxx=k[6][0,mx.length].reject{|q| q != k[6][0]}.length
      for i in 0...mx.length
        str2="#{str2}#{"\n" if i==0}\nL#{i+1}#{"-#{kxx}" if i==0} = #{longFormattedNumber(k[6][i])} SP" unless i>0 && k[6][i]==k[6][0]
        if kk.length>0 && !(i>0 && k[6][i]==k[6][0])
          for i2 in 0...kk.length/7
            str2="#{str2} / *#{kk[i2*7]} = #{longFormattedNumber(kk[i+7*i2+1])} SP*" unless kk[i+7*i2+1]==k[6][i]
          end
        end
      end
    end
    if str.length+str2.length+m<1800
      str="#{str}#{str2}"
      create_embed(event,["#{k[0]}",title],str,xcolor,nil,xpic,flds)
    elsif str2.length<1800
      create_embed(event,["#{k[0]}",title],str,xcolor,nil,xpic)
      create_embed(event,'',str2,xcolor)
      create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
    else
      create_embed(event,["#{k[0]}",title],str,xcolor,nil,xpic)
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

def disp_ability_data(bot,event,args=nil,forceaura='')
  reload_library()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_ability,args.join(' '),event)
  s2s=false
  s2s=true if safe_to_spam?(event)
  if forceaura.nil?
  elsif forceaura=='CoAbility' && s2s
    k=k.reject{|q| q[2]!=forceaura && q[2]!='Chain'}
  elsif forceaura.length>0
    k=k.reject{|q| q[2]!=forceaura}
  end
  if k.length.zero?
    sklz=@askilities.map{|q| q}
    if forceaura.length>0 && forceaura != 'Ability'
      if find_data_ex(:find_adventurer,args.join(' '),event).length>0
      else
        event.respond 'No matches found.'
        return nil
      end
    end
    if find_data_ex(:find_adventurer,args.join(' '),event).length>0 && (has_any?(args,['a1','a2','a3','1','2','3','ability1','ability2','ability3','abil1','abil2','abil3','chaincoabil','chaincoability','chaincoab','coabilchain','coabilitychain','chain','coabchain','cca','cc','coabil','coability','coab']) || (forceaura.length>0 && forceaura != 'Ability'))
      adv=find_data_ex(:find_adventurer,args.join(' '),event)
      pp=8
      p=0
      p=1 if has_any?(args,['a2','2','ability2','abil2'])
      p=2 if has_any?(args,['a3','3','ability3','abil3'])
      if forceaura.length>0 && forceaura != 'Ability'
        pp=7
        p=0
        p=1 if forceaura=='Chain'
      elsif has_any?(args,['chaincoabil','chaincoability','chaincoab','coabilchain','coabilitychain','chain','coabchain','cca','cc','coabil','coability','coab'])
        pp=7
        p=0
        p=1 if has_any?(args,['chaincoabil','chaincoability','chaincoab','coabilchain','coabilitychain','chain','coabchain','cca','cc'])
      end
      if adv[pp].nil? || adv[pp].length<=0 || adv[pp][p].nil? || adv[pp][p].length<=0
        event.respond "#{adv[0]} does not have a #{['1st','2nd','3rd'][p]} ability." if pp==8
        event.respond "#{adv[0]} does not have a #{['','chain '][p]}coability." if pp==7
        return nil
      end
      skl1=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==adv[pp][p][-1]}
      if pp==7
        kk=adv[pp][p].split(' ')
        kk=[kk[0,kk.length-1].join(' '),kk[-1].split('/')[-1]]
        kk[1]="+#{kk[1]}" if kk[1].include?('%')
        skl1=sklz.find_index{|q| q[2]==['CoAbility','Chain'][p] && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==kk.join(' ')}
      end
      if skl1.nil?
        event.respond "#{adv[0]}'s #{['1st','2nd','3rd'][p]} ability, #{adv[pp][p][-1]}, has no data." if pp==8
        event.respond "#{adv[0]}'s #{['','chain '][p]}coability, #{kk.join(' ')}, has no data." if pp==7
        return nil
      end
      disp_ability_data(bot,event,adv[8][p][-1].split(' ')) if pp==8
      disp_ability_data(bot,event,kk.join(' ').split(' '),['CoAbility','Chain'][p]) if pp==7
    elsif find_data_ex(:find_dragon,args.join(' '),event).length>0 && has_any?(args,['a1','a2','a3','1','2','3','ability1','ability2','ability3','abil1','abil2','abil3'])
      adv=find_data_ex(:find_dragon,args.join(' '),event)
      p=0
      p=1 if has_any?(args,['s2','2','skill2','skl2'])
      p=2 if has_any?(args,['a3','3','ability3','abil3'])
      if adv[6].nil? || adv[6].length<=0 || adv[6][p].nil? || adv[6][p].length<=0
        event.respond "#{adv[0]} does not have a #{['1st','2nd','3rd'][p]} aura."
        return nil
      end
      p=[adv[6].length-1,p].min
      skl1=sklz.find_index{|q| q[2]=='Aura' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==adv[6][p][-1]}
      if skl1.nil?
        event.respond "#{adv[0]}'s #{['1st','2nd','3rd'][p]} aura, #{adv[6][p][-1]}, has no data."
        return nil
      end
      disp_ability_data(bot,event,adv[6][p][-1].split(' '),'Aura')
    elsif find_data_ex(:find_wyrmprint,args.join(' '),event).length>0 && has_any?(args,['a1','a2','a3','1','2','3','ability1','ability2','ability3','abil1','abil2','abil3'])
      adv=find_data_ex(:find_wyrmprint,args.join(' '),event)
      p=0
      p=1 if has_any?(args,['s2','2','skill2','skl2'])
      p=2 if has_any?(args,['a3','3','ability3','abil3'])
      if adv[5].nil? || adv[5].length<=0 || adv[5][p].nil? || adv[5][p].length<=0
        event.respond "#{adv[0]} does not have a#{'n' unless p>0 || (!adv[5].nil? && adv[5].length>1)}#{[' 1st',' 2nd',' 3rd'][p] if p>0 || (!adv[5].nil? && adv[5].length>1)} ability."
        return nil
      end
      p=[adv[5].length-1,p].min
      skl1=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==adv[5][p][-1]}
      if skl1.nil?
        event.respond "#{adv[0]}'s#{[' 1st',' 2nd',' 3rd'][p] if p>0 || (!adv[5].nil? && adv[5].length>1)} ability, #{adv[5][p][-1]}, has no data."
        return nil
      end
      disp_ability_data(bot,event,adv[5][p][-1].split(' '))
    elsif find_data_ex(:find_weapon,args.join(' '),event).length>0 && has_any?(args,['a1','a2','a3','1','2','3','ability1','ability2','ability3','abil1','abil2','abil3'])
      adv=find_data_ex(:find_weapon,args.join(' '),event)
      p=0
      p=1 if has_any?(args,['s2','2','skill2','skl2'])
      p=2 if has_any?(args,['a3','3','ability3','abil3'])
      if adv[0].is_a?(Array)
        event.respond "There are multiple weapons with that criterium, and I won't display an ability for each."
        return nil
      elsif adv[13].nil? || adv[13].length<=0 || adv[13][p].nil? || adv[13][p].length<=0
        event.respond "#{adv[0]} does not have a #{['1st','2nd','3rd'][p]} ability."
        return nil
      end
      p=[adv[13].length-1,p].min
      skl1=sklz.find_index{|q| q[2]=='Ability' && "#{q[0]}#{" #{'+' if q[1].include?('%')}#{q[1]}" unless q[1]=='-'}"==adv[13][p][-1]}
      if skl1.nil?
        event.respond "#{adv[0]}'s #{['1st','2nd','3rd'][p]} ability, #{adv[13][p][-1]}, has no data."
        return nil
      end
      disp_ability_data(bot,event,adv[13][p][-1].split(' '))
    else
      event.respond 'No matches found.'
    end
    return nil
  end
  evn=event.message.text.downcase.split(' ')
  k=k.reject{|q| q[2]=='Aura'} if k.is_a?(Array) && k.map{|q| q[2]}.uniq.length>1
  k=k[0] if k[0].is_a?(Array) && k.length<=1
  data_load()
  if k[0].is_a?(Array) && k.map{|q| q[1]}.uniq.length>1
    m=@askilities.reject{|q| q[0]!=k[0][0] || !k.map{|q2| q2[2]}.include?(q[2])}
    k=m.map{|q| q}.uniq
  end
  str=''
  hdr=''
  xpic=k[0]
  adv=@adventurers.map{|q| q}
  drg=@dragons.map{|q| q}
  wrm=@wyrmprints.map{|q| q}
  wep=@weapons.map{|q| q}
  enm=@enemies.map{|q| q}
  typ=[]
  n=k[0]
  n=k[0][0] if k[0].is_a?(Array)
  n=n.downcase.split(' ')
  for i in 0...evn.length
    unless n.include?(evn[i].downcase)
      typ.push('Adventurers') if ['adventurer','adventurers','adv','advs','unit','units'].include?(evn[i].downcase)
      typ.push('Dragons') if ['drg','drgs'].include?(evn[i].downcase)
      typ.push('Dragons') if ['dragon','dragons'].include?(evn[i].downcase) && evn.reject{|q| q.downcase != evn[i].downcase}.length>1
      typ.push('Wyrmprints') if ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(evn[i].downcase)
      typ.push('Weapons') if ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(evn[i].downcase)
      typ.push('Enemies') if ['enemies','boss','enemy','bosses','enemie','enemys','bosss'].include?(evn[i].downcase)
    end
  end
  unless typ.length<=0 || forceaura.length>0
    adv=[] unless typ.include?('Adventurers')
    drg=[] unless typ.include?('Dragons')
    wrm=[] unless typ.include?('Wyrmprints')
    wep=[] unless typ.include?('Weapons')
    enm=[] unless typ.include?('Enemies')
  end
  unless has_any?(evn,['sub','subabilities','subability','starter']) || adv.length<=0
    for i in 0...adv.length
      unless adv[i][8].nil? || adv[i][8].length<=0 || adv[i][8][0].nil? || adv[i][8][0].length<=0
        m=[adv[i][8][0][-1].split(' '),adv[i][8][1][-1].split(' '),adv[i][8][2][-1].split(' ')]
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
  end
  ftr=nil
  flds=nil
  dispslots=false
  dispslots=true if evn.include?('slots') || evn.include?('slot')
  t=Time.now
  timeshift=7
  timeshift-=1 unless (t-24*60*60).dst?
  t-=60*60*timeshift
  ignorefeh=true
  elemo=[['Flame','<:Element_Flame:532106087952810005>','<:Boost_Fire:498863399116079123>'],
         ['Water','<:Element_Water:532106088221376522>','<:Boost_Water:498863398944243712>'],
         ['Wind','<:Element_Wind:532106087948746763>','<:Boost_Wind:498863398918815745>'],
         ['Light','<:Element_Light:532106088129101834>','<:Boost_Light:521910176047955968>'],
         ['Shadow','<:Element_Shadow:532106088154267658>','<:Boost_Dark:521910175968395275>'],
         ['Sword','<:Weapon_Sword:532106114540634113>','<:Red_Blade:443172811830198282>'],
         ['Blade','<:Weapon_Blade:532106114628714496>','<:Colorless_Blade:443692132310712322>'],
         ['Dagger','<:Weapon_Dagger:532106116025286656>','<:Colorless_Dagger:443692132683743232>'],
         ['Axe','<:Weapon_Axe:532106114188443659>','<:Green_Blade:467122927230386207>'],
         ['Bow','<:Weapon_Bow:532106114909732864>','<:Colorless_Bow:443692132616896512>'],
         ['Lance','<:Weapon_Lance:532106114792423448>','<:Blue_Blade:467112472768151562>'],
         ['Wand','<:Weapon_Wand:532106114985099264>','<:Colorless_Tome:443692133317345290>'],
         ['Staff','<:Weapon_Staff:532106114733441024>','<:Colorless_Staff:443692132323295243>'],
         ['Manacaster','<:Weapon_Manacaster:758905122448867338>','<:Summon_Gun:467557566050861074>']]
  elemo=elemo.map{|q| [q[0],q[1],q[1]]} if ignorefeh
  if k[0].is_a?(Array)
    emo=''
    emo='<:Element_Null:532106087810334741>' unless @askilities.find_index{|q| q[2]==k[0][2] && q[0].include?(") #{k[0][0]}")}.nil?
    emo2=''
    emo2='<:Element_Null:532106087810334741>' unless @askilities.find_index{|q| q[2]==k[0][2] && q[0].include?(") #{k[0][0]}")}.nil?
    emo2='<:Boost_Anima:521910175955943444>' unless @askilities.find_index{|q| q[2]==k[0][2] && q[0].include?(") #{k[0][0]}")}.nil? || ignorefeh
    hdr="__**#{k[0][0]}**__ [#{k[0][2].gsub('Chain','CoAbility').gsub('Co','')} family]"
    xpic=k[0][0]
    xcolor=0x7D7682
    xcolor=0xC6BEB6 if k[0][2]=='Aura'
    xcolor=0x342E4C if k[0][2]=='CoAbility' && k.map{|q| q[2]}.uniq.length==1
    xcolor=0x442E3C if k[0][2]=='Chain' && k.map{|q| q[2]}.uniq.length==1
    k2=k.reject{|q| q[2]!='Ability'}
    k3=k.reject{|q| q[2]!='CoAbility'}
    k4=k.reject{|q| q[2]!='Chain'}
    if k2.length>0 && (k3.length>0 || k4.length>0)
      if k.map{|q| q[1]}.uniq.length<=1
        hdr="__**#{k[0][0]} #{'+' if k[0][1].include?('%')}#{k[0][1]}**__ [Ability family]"
        hdr="__**#{k[0][1]} #{k[0][0]}**__ [Ability family]" if k[0][0][0,5]=='Hits '
        m=k2[0]
        str="__**Ability**__"
        str="#{str}\n*Effect:* #{m[3].gsub(';;',"\n")}" unless m[5]=='n'
        m2=[]
        checkstr="#{k[0][0]} #{'+' if k[0][1].include?('%')}#{k[0][1]}"
        checkstr="#{k[0][1]} #{k[0][0]}" if k[0][0][0,7]=='Hits = '
        checkstr="#{k[0][0]}" if k[0][1]=='-'
        for i in 0...adv.length
          unless adv[i][8].nil? || adv[i][8].length<=0 || adv[i][8][0].nil? || adv[i][8][0].length<=0
            advemo=element_emote(adv[i][2][1],bot,adv[i][12])
            advemo=element_emote(adv[i][2][1],bot) if ignorefeh
            if has_any?(evn,['sub','subabilities','subability','starter'])
              for i4 in 0...3
                if adv[i][8][i4].length<=1
                  m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}" if dispslots}") if adv[i][8][i4][0]==checkstr
                elsif adv[i][8][i4].length<=2
                  m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][i4][0]==checkstr
                  m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][i4][1]==checkstr
                else
                  m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][i4][0]==checkstr
                  m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2082)" if dispslots}#{' [med]' unless dispslots}") if adv[i][8][i4][1]==checkstr
                  m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2083)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][i4][2]==checkstr
                end
              end
            else
              m2.push("#{advemo}#{adv[i][0]}#{" (A1)" if dispslots}") if adv[i][8][0].reject{|q| q.length<=0}[-1]==checkstr
              m2.push("#{advemo}#{adv[i][0]}#{" (A2)" if dispslots}") if adv[i][8][1].reject{|q| q.length<=0}[-1]==checkstr
              m2.push("#{advemo}#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2].reject{|q| q.length<=0}[-1]==checkstr
              m2.push("#{advemo}#{adv[i][0]}#{" (A1+3)" if dispslots}") if adv[i][8][3][0]==checkstr
              m2.push("#{advemo}#{adv[i][0]}#{" (A2+3)" if dispslots}") if adv[i][8][3][1]==checkstr
            end
            if !adv[i][15].nil? && adv[i][15].length>0
              for i4 in 0...adv[i][15].length
                if has_any?(evn,['sub','subabilities','subability','starter'])
                  m2.push("#{advemo}#{adv[i][0]}#{" (HA\u2081)" if dispslots}#{' [HA-Min]' unless dispslots}") if adv[i][15][i4][0]==checkstr
                  m2.push("#{advemo}#{adv[i][0]}#{" (HA\u2082)" if dispslots}#{' [HA-Med]' unless dispslots}") if adv[i][15][i4][1]==checkstr && adv[i][15][i4].length>2
                  m2.push("#{advemo}#{adv[i][0]}#{" (HA\u2082)" if dispslots}#{' [HA-Max]' unless dispslots}") if adv[i][15][i4][-1]==checkstr
                else
                  m2.push("#{advemo}#{adv[i][0]} (HA)") if adv[i][15][i4][1]==checkstr
                end
              end
            end
          end
        end
        str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
        m2=[]
        for i in 0...drg.length
          unless drg[i][15].nil? || drg[i][15].length<=0
            checkstr2="(#{drg[i][2]}) #{checkstr}"
            drgemo=element_emote(drg[i][2],bot,drg[i][16])
            drgemo=element_emote(drg[i][2],bot) if ignorefeh
            for ix in 0...drg[i][6].length
              m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2081)") if drg[i][6][ix][0]==checkstr
              m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2082)") if drg[i][6][ix][1]==checkstr
              m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2083)") if drg[i][6][ix][2]==checkstr
              m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2081)") if drg[i][6][ix][0]==checkstr2
              m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2082)") if drg[i][6][ix][1]==checkstr2
              m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2083)") if drg[i][6][ix][2]==checkstr2
            end
            for i4 in 0...drg[i][15].length
              if has_any?(evn,['sub','subabilities','subability','starter'])
                m2.push("#{drgemo}#{drg[i][0]} (HA\u2081)") if drg[i][15][i4][0]==checkstr
                m2.push("#{drgemo}#{drg[i][0]} (HA\u2082)") if drg[i][15][i4][1]==checkstr
                m2.push("#{drgemo}#{drg[i][0]} (HA\u2083)") if drg[i][15][i4][2]==checkstr
                m2.push("#{drgemo}#{drg[i][0]} (HA\u2081)") if drg[i][15][i4][0]==checkstr2
                m2.push("#{drgemo}#{drg[i][0]} (HA\u2082)") if drg[i][15][i4][1]==checkstr2
                m2.push("#{drgemo}#{drg[i][0]} (HA\u2083)") if drg[i][15][i4][2]==checkstr2
              else
                m2.push("#{drgemo}#{drg[i][0]} (HA)") if drg[i][15][i4][-1]==checkstr
                m2.push("#{drgemo}#{drg[i][0]} (HA)") if drg[i][15][i4][-1]==checkstr2
              end
            end
          end
        end
        str="#{str}\n*Dragons:* #{m2.join(', ')}" if m2.length>0
        m2=[]
        for i in 0...wrm.length
          if has_any?(evn,['sub','subabilities','subability','starter'])
            m2.push("#{emo}#{wrm[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5][0][0]==checkstr
            m2.push("#{emo}#{wrm[i][0]}#{" (A1\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5][0][1]==checkstr
            m2.push("#{emo}#{wrm[i][0]}#{" (A1\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5][0][2]==checkstr
            m2.push("#{emo}#{wrm[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr
            m2.push("#{emo}#{wrm[i][0]}#{" (A2\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
            m2.push("#{emo}#{wrm[i][0]}#{" (A2\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][2]==checkstr
            m2.push("#{emo}#{wrm[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr
            m2.push("#{emo}#{wrm[i][0]}#{" (A3\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
            m2.push("#{emo}#{wrm[i][0]}#{" (A3\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][2]==checkstr
          else
            m2.push("#{emo}#{wrm[i][0]}#{" (A1)" if dispslots}") if wrm[i][5][0][-1]==checkstr
            m2.push("#{emo}#{wrm[i][0]}#{" (A2)" if dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][-1]==checkstr
            m2.push("#{emo}#{wrm[i][0]}#{" (A3)" if dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][-1]==checkstr
          end
          for i2 in 0...elemo.length
            checkstr2="(#{elemo[i2][0]}) #{checkstr}"
            if has_any?(evn,['sub','subabilities','subability','starter'])
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5][0][0]==checkstr2
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5][0][1]==checkstr2
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5][0][2]==checkstr2
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr2
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr2
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][2]==checkstr2
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr2
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr2
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][2]==checkstr2
            else
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1)" if dispslots}") if wrm[i][5][0][-1]==checkstr2
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2)" if dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][-1]==checkstr2
              m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3)" if dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][-1]==checkstr2
            end
          end
        end
        str="#{str}\n*Wyrmprints:* #{m2.join(', ')}" if m2.length>0
        m2=[]
        for i in 0...wep.length
          unless wep[i][13].nil? || wep[i][13].length<=0
            wemo=''
            moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wep[i][1]}"}
            wemo=moji[0].mention if moji.length>0
            if !wep[i][14].nil? && wep[i][14]=='FEH' && !ignorefeh
              wemo='<:Gold_Unknown:774013610908188682>'
              wemo='<:Red_Blade:443172811830198282>' if wep[i][1]=='Sword'
              wemo='<:Colorless_Blade:443692132310712322>' if wep[i][1]=='Blade'
              wemo='<:Colorless_Dagger:443692132683743232>' if wep[i][1]=='Dagger'
              wemo='<:Green_Blade:467122927230386207>' if wep[i][1]=='Axe'
              wemo='<:Colorless_Bow:443692132616896512>' if wep[i][1]=='Bow'
              wemo='<:Blue_Blade:467112472768151562>' if wep[i][1]=='Lance'
              wemo='<:Colorless_Tome:443692133317345290>' if wep[i][1]=='Wand'
              wemo='<:Colorless_Staff:443692132323295243>' if wep[i][1]=='Staff'
              wemo='<:Summon_Gun:467557566050861074>' if wep[i][1]=='Manacaster'
            end
            if has_any?(evn,['sub','subabilities','subability','starter'])
              m2.push("#{wemo}#{wep[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][0]==checkstr
              m2.push("#{wemo}#{wep[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][1]==checkstr
              m2.push("#{wemo}#{wep[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][0]==checkstr
              m2.push("#{wemo}#{wep[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr
            else
              m2.push("#{wemo}#{wep[i][0]}#{" (A1)" if dispslots}") if wep[i][13][0][-1]==checkstr
              m2.push("#{wemo}#{wep[i][0]}#{" (A2)" if dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][-1]==checkstr
            end
            for i2 in 0...elemo.length
              checkstr2="(#{elemo[i2][0]}) #{checkstr}"
              wpemo=elemo[i2][1]
              wpemo=elemo[i2][2] if !wep[i][14].nil? && wep[i][14]=='FEH'
              if has_any?(evn,['sub','subabilities','subability','starter'])
                m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][0]==checkstr2
                m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][1]==checkstr2
                m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][0]==checkstr2
                m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr2
              else
                m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A1)" if dispslots}") if wep[i][13][0][-1]==checkstr2
                m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A2)" if dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][-1]==checkstr2
              end
            end
          end
        end
        str="#{str}\n*Weapons:* #{m2.join(', ')}" if m2.length>0
        unless @resonance.find_index{|q| q[1,3].include?(checkstr)}.nil?
          m2=@resonance[@resonance.find_index{|q| q[1,3].include?(checkstr)}].map{|q| q}
          moji2=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{m2[0]}"}
          m2[0]="#{moji2[0].mention}#{m2[0]}" unless moji2.length<=0
          str="#{str}\n*Wyrmprint Affinity:* #{m2[0]} x#{m2.find_index{|q| q==checkstr}+1}"
        end
        m2=[]
        for i in 0...enm.length
          unless enm[i][5].nil? || enm.length<=0
            for i2 in 0...enm[i][5].length
              m2.push("#{enm[i][0]}#{" (A#{i2+1})" if dispslots}") if enm[i][5][i2]==checkstr
            end
          end
        end
        str="#{str}\n*Enemies:* #{m2.join(', ')}" if m2.length>0
        if k3.length>0
          m=k3[0]
          str="#{str}\n\n__**Co-Ability**__"
          str="#{str}\n*Effect:* #{m[3]}" unless m[5]=='n'
          m2=[]
          for i in 0...adv.length
            mx=adv[i][7][0].split(' ')
            mxx=mx[0,mx.length-1].join(' ')
            mx=mx[-1].split('/').map{|q| "#{mxx} #{q}"}
            advemo=element_emote(adv[i][2][1],bot,adv[i][12])
            advemo=element_emote(adv[i][2][1],bot) if ignorefeh
            for i2 in 0...mx.length
              m2.push("#{advemo}#{adv[i][0]} (Co#{["\u2081","\u2082","\u2083","\u2084","\u2085"][i2]})") if checkstr==mx[i2]
            end
          end
          str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
        end
        if k4.length>0
          m=k4[0]
          str="#{str}\n\n__**Chain Co-Ability**__"
          str="#{str}\n*Effect:* #{m[3]}" unless m[5]=='n'
          m2=[]
          for i in 0...adv.length
            unless adv[i][7].length<=1
              mx=adv[i][7][1].split(' ')
              mxx=mx[0,mx.length-1].join(' ')
              mx=mx[-1].split('/').map{|q| "#{mxx} #{q}"}
              advemo=element_emote(adv[i][2][1],bot,adv[i][12])
              advemo=element_emote(adv[i][2][1],bot) if ignorefeh
              for i2 in 0...mx.length
                m2.push("#{advemo}#{adv[i][0]} (Ch#{["\u2081","\u2082","\u2083","\u2084","\u2085"][i2]})") if checkstr==mx[i2]
              end
            end
          end
          str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
        end
        ftr='The numbers in parenthesis indicate which CoAbility stage the adventurer needs to have.'
        f=@abilimits.map{|q| q.split(" \u2192 ")}
        if f.map{|q| q[0]}.include?(k[0][0])
          str="#{str}\n\n**Per-adventurer wyrmprint stack limit:** #{f[f.find_index{|q| q[0]==k[0][0]}][1]}"
        elsif ['Flame Res','Water Res','Wind Res','Light Res','Shadow Res'].include?(k[0][0]) && f.map{|q| q[0]}.include?('Element Res')
          str="#{str}\n\n**Per-adventurer wyrmprint stack limit:** #{f[f.find_index{|q| q[0]=='Element Res'}][1]}"
        elsif "Dragon's Claws"==k[0][0]
          str="#{str}\n\n**You may instead be searching for the skill `Dragon Claw`, which belongs to Gala Mym<:Rarity_5:532086056737177600><:Element_Flame:532106087952810005><:Weapon_Lance:532106114792423448><:Type_Attack:532107867520630784>.**"
        end
      else
        str=""
        for i in 0...k2.length
          checkstr="#{k2[i][0]} #{'+' if k2[i][1].include?('%')}#{k2[i][1]}"
          checkstr="#{k2[i][1]} #{k2[i][0]}" if k2[i][0][0,7]=='Hits = '
          checkstr="#{k2[i][0]}" if k2[i][1]=='-'
          str="#{str}\n**Example effect:** #{k2[i][3].gsub(';;',"\n")}\n" if k2[i][1].downcase=='example'
          str="#{str}\n**#{k2[i][1]}**" unless k2[i][1].downcase=='example'
          brk=false
          m2=[]
          for i3 in 0...adv.length
            unless adv[i3][8].nil? || adv[i3][8].length<=0 || adv[i3][8][0].nil? || adv[i3][8][0].length<=0
              if has_any?(evn,['sub','subabilities','subability','starter'])
                for i4 in 0...3
                  if adv[i3][8][i4].length<=1
                    m2.push("#{advemo}#{adv[i3][0]}#{" (A#{i4+1}" if dispslots}") if adv[i][8][i4][0]==checkstr
                  elsif adv[i3][8][i4].length<=2
                    m2.push("#{advemo}#{adv[i3][0]}#{" (A#{i4+1}\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i3][8][i4][0]==checkstr
                    m2.push("#{advemo}#{adv[i3][0]}#{" (A#{i4+1}\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i3][8][i4][1]==checkstr
                  else
                    m2.push("#{advemo}#{adv[i3][0]}#{" (A#{i4+1}\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i3][8][i4][0]==checkstr
                    m2.push("#{advemo}#{adv[i3][0]}#{" (A#{i4+1}\u2082)" if dispslots}#{' [med]' unless dispslots}") if adv[i3][8][i4][1]==checkstr
                    m2.push("#{advemo}#{adv[i3][0]}#{" (A#{i4+1}\u2083)" if dispslots}#{' [Max]' unless dispslots}") if adv[i3][8][i4][2]==checkstr
                  end
                end
                m2.push("#{advemo}#{adv[i3][0]}#{" (HA\u2081)" if dispslots}#{' [HA-Min]' unless dispslots}") if adv[i3][15].map{|q| q[0]}.include?(checkstr)
                m2.push("#{advemo}#{adv[i3][0]}#{" (HA\u2082)" if dispslots}#{' [HA-Med]' unless dispslots}") if adv[i3][15].reject{|q| q.length<=2}.map{|q| q[1]}.include?(checkstr)
                m2.push("#{advemo}#{adv[i3][0]}#{" (HA\u2082)" if dispslots}#{' [HA-Max]' unless dispslots}") if adv[i3][15].map{|q| q[-1]}.include?(checkstr)
              else
                advabils=[adv[i3][8][0][-1],adv[i3][8][1][-1],adv[i3][8][2][-1]]
                advabils.push(adv[i3][8][3][0]) if adv[i3][8].length>3
                advabils.push(adv[i3][8][3][1]) if adv[i3][8].length>3
                if advabils.include?(checkstr)
                  if !adv[i3][12].nil? && adv[i3][12]=='FEH' && !ignorefeh
                    m2.push("#{emo2}*#{adv[i3][0]}*")
                  else
                    m2.push("#{emo}*#{adv[i3][0]}*")
                  end
                end
                m2.push("#{advemo}#{adv[i3][0]} (HA)") if !adv[i3][15].nil? && adv[i3][15].length>0 && adv[i3][15].map{|q| q[1]}.include?(checkstr)
              end
            end
          end
          if m2.length>3 && !s2s
            str="#{str} - #{m2.length} adventurers"
          elsif m2.length>0
            str="#{str} - #{m2.join(', ')}"
          end
          m2=[]
          for i3 in 0...wrm.length
            if has_any?(evn,['sub','subabilities','subability','starter'])
              m2.push("#{emo}#{wrm[i3][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i3][5][0][0]==checkstr
              m2.push("#{emo}#{wrm[i3][0]}#{" (A1\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i3][5][0][1]==checkstr
              m2.push("#{emo}#{wrm[i3][0]}#{" (A1\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i3][5][0][2]==checkstr
              m2.push("#{emo}#{wrm[i3][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i3][5].length>1 && wrm[i3][5][1][0]==checkstr
              m2.push("#{emo}#{wrm[i3][0]}#{" (A2\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i3][5].length>1 && wrm[i3][5][1][1]==checkstr
              m2.push("#{emo}#{wrm[i3][0]}#{" (A2\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i3][5].length>1 && wrm[i3][5][1][2]==checkstr
              m2.push("#{emo}#{wrm[i3][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i3][5].length>2 && wrm[i3][5][2][0]==checkstr
              m2.push("#{emo}#{wrm[i3][0]}#{" (A3\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i3][5].length>2 && wrm[i3][5][2][1]==checkstr
              m2.push("#{emo}#{wrm[i3][0]}#{" (A3\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i3][5].length>2 && wrm[i3][5][2][2]==checkstr
            else
              m2.push("#{emo}#{wrm[i3][0]}") if wrm[i3][5].map{|q| q[-1]}.include?(checkstr)
              for i2 in 0...elemo.length
                checkstr2="(#{elemo[i2][0]}) #{checkstr}"
                m2.push("#{elemo[i2][1]}#{wrm[i3][0]}") if wrm[i3][5].map{|q| q[-1]}.include?(checkstr2)
              end
            end
          end
          if m2.length>3 && !s2s
            str="#{str} - #{m2.length} wyrmprints"
            c=' - '
          elsif m2.length>0
            str="#{str} - #{m2.join(', ')}"
            c=' - '
          end
          m2=[]
          for i3 in 0...wep.length
            if has_any?(evn,['sub','subabilities','subability','starter'])
              unless wep[i][13].nil? || wep[i][13].length<=0
                m2.push("#{wemo}#{wep[i3][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i3][13][0].length<2}") if wep[i3][13][0][0]==checkstr
                m2.push("#{wemo}#{wep[i3][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i3][13][0].length<2}") if wep[i3][13][0][1]==checkstr
                m2.push("#{wemo}#{wep[i3][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i3][13][1].length<2}") if !wep[i3][13][1].nil? && wep[i3][13][1].length>0 && wep[i3][13][1][0]==checkstr
                m2.push("#{wemo}#{wep[i3][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i3][13][1].length<2}") if !wep[i3][13][1].nil? && wep[i3][13][1].length>0 && wep[i3][13][1][1]==checkstr
              end
            elsif !wep[i3][13].nil? && wep[i3][13].length>0
              wemo=''
              moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wep[i3][1]}"}
              wemo=moji[0].mention if moji.length>0
              if !wep[i][14].nil? && wep[i][14]=='FEH' && !ignorefeh
                wemo='<:Gold_Unknown:774013610908188682>'
                wemo='<:Red_Blade:443172811830198282>' if wep[i][1]=='Sword'
                wemo='<:Colorless_Blade:443692132310712322>' if wep[i][1]=='Blade'
                wemo='<:Colorless_Dagger:443692132683743232>' if wep[i][1]=='Dagger'
                wemo='<:Green_Blade:467122927230386207>' if wep[i][1]=='Axe'
                wemo='<:Colorless_Bow:443692132616896512>' if wep[i][1]=='Bow'
                wemo='<:Blue_Blade:467112472768151562>' if wep[i][1]=='Lance'
                wemo='<:Colorless_Tome:443692133317345290>' if wep[i][1]=='Wand'
                wemo='<:Colorless_Staff:443692132323295243>' if wep[i][1]=='Staff'
                wemo='<:Summon_Gun:467557566050861074>' if wep[i][1]=='Manacaster'
              end
              m2.push("#{wemo}#{wep[i3][0]}") if wep[i3][13][0][-1]==checkstr
              m2.push("#{wemo}#{wep[i3][0]}") if !wep[i3][13][1].nil? && wep[i3][13][1].length>0 && wep[i3][13][1][-1]==checkstr
              for i2 in 0...elemo.length
                wpemo=elemo[i2][1]
                wpemo=elemo[i2][2] if !wep[i][14].nil? && wep[i][14]=='FEH'
                checkstr2="(#{elemo[i2][0]}) #{checkstr}"
                m2.push("#{wemo}#{wpemo}#{wep[i3][0]}") if wep[i3][13][0][-1]==checkstr2
                m2.push("#{wemo}#{wpemo}#{wep[i3][0]}") if !wep[i3][13][1].nil? && wep[i3][13][1].length>0 && wep[i3][13][1][-1]==checkstr2
              end
            end
          end
          m2.uniq!
          if m2.length>3 && !s2s
            str="#{str} - #{m2.length} weapons"
          elsif m2.length>0
            str="#{str} - #{m2.join(', ')}"
          end
          unless @resonance.find_index{|q| q[1,3].include?(checkstr)}.nil?
            m2=@resonance[@resonance.find_index{|q| q[1,3].include?(checkstr)}].map{|q| q}
            moji2=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{m2[0]}"}
            m2[0]="#{moji2[0].mention}#{m2[0]}" unless moji2.length<=0
            str="#{str} - *Affinity:* #{m2[0]} x#{m2.find_index{|q| q==checkstr}+1}"
          end
        end
        str="#{str}\n\n**CoAbility Levels:** #{k3.map{|q| q[1]}.join(', ')}" if k3.length>0
        str="#{str}\n**Chain CoAbility Levels:** #{k4.reject{|q| q[1]=='example'}.map{|q| q[1]}.join(', ')}" if k4.length>0
        f=@abilimits.map{|q| q.split(" \u2192 ")}
        if f.map{|q| q[0]}.include?(k[0][0])
          str="#{str}\n**Per-adventurer wyrmprint stack limit:** #{f[f.find_index{|q| q[0]==k[0][0]}][1]}"
        elsif ['Flame Res','Water Res','Wind Res','Light Res','Shadow Res'].include?(k[0][0]) && f.map{|q| q[0]}.include?('Element Res')
          str="#{str}\n**Per-adventurer wyrmprint stack limit:** #{f[f.find_index{|q| q[0]=='Element Res'}][1]}"
        elsif "Dragon's Claws"==k[0][0]
          str="#{str}\n\n**You may instead be searching for the skill `Dragon Claw`, which belongs to Gala Mym<:Rarity_5:532086056737177600><:Element_Flame:532106087952810005><:Weapon_Lance:532106114792423448><:Type_Attack:532107867520630784>.**"
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
      lng=false if k[0][1].downcase=='example'
      for ii2 in 0...k.length
        if k[ii2][1]=='example'
          str="#{str}\n__**Example #{'Chain ' if k[ii2][2]=='Chain' && k.map{|q| q[2]}.uniq.length>1}Effect**__\n#{k[ii2][3].gsub(';;',"\n")}\n"
        elsif s2s
          if k[ii2][0][0,7]=='Hits = '
            str="#{str}\n\n#{'__' if lng}**#{k[ii2][1]} #{k[ii2][0]}**#{'__' if lng}"
          else
            str="#{str}\n\n#{'__' if lng}**#{k[ii2][0]} #{'+' if k[ii2][1].include?('%')}#{k[ii2][1]}**#{'__' if lng}"
          end
          str="#{str} [Chain]" if k[ii2][2]=='Chain' && k.map{|q| q[2]}.uniq.length>1
          str="#{str}\n*Effect:* #{k[ii2][3]}" if lng
        else
          str="#{str}\n#{"\n__" if lng}**#{'+' if k[ii2][1].include?('%')}#{k[ii2][1]}**#{'__' if lng}"
          str="#{str} [Chain]" if k[ii2][2]=='Chain' && k.map{|q| q[2]}.uniq.length>1
          str="#{str} - #{k[ii2][3]}" if lng
        end
        checkstr="#{k[ii2][0]} #{'+' if k[ii2][1].include?('%')}#{k[ii2][1]}"
        checkstr="#{k[ii2][1]} #{k[ii2][0]}" if k[ii2][0][0,7]=='Hits = '
        checkstr="#{k[ii2][0]}" if k[ii2][1]=='-'
        if s2s
          m2=[]
          if k[ii2][2]=='Ability'
            for i in 0...adv.length
              unless adv[i][8].nil? || adv[i][8].length<=0 || adv[i][8][0].nil? || adv[i][8][0].length<=0
                advemo=element_emote(adv[i][2][1],bot,adv[i][12])
                advemo=element_emote(adv[i][2][1],bot) if ignorefeh
                if has_any?(evn,['sub','subabilities','subability','starter'])
                  for i4 in 0...3
                    if adv[i][8][i4].length<=1
                      m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}" if dispslots}") if adv[i][8][i4][0]==checkstr
                    elsif adv[i][8][i4].length<=2
                      m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][i4][0]==checkstr
                      m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][i4][1]==checkstr
                    else
                      m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][i4][0]==checkstr
                      m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2082)" if dispslots}#{' [med]' unless dispslots}") if adv[i][8][i4][1]==checkstr
                      m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2083)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][i4][2]==checkstr
                    end
                  end
                else
                  m2.push("#{advemo}#{adv[i][0]}#{" (A1)" if dispslots}") if adv[i][8][0].reject{|q| q.length<=0}[-1]==checkstr
                  m2.push("#{advemo}#{adv[i][0]}#{" (A2)" if dispslots}") if adv[i][8][1].reject{|q| q.length<=0}[-1]==checkstr
                  m2.push("#{advemo}#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2].reject{|q| q.length<=0}[-1]==checkstr
                  m2.push("#{advemo}#{adv[i][0]}#{" (A1+3)" if dispslots}") if adv[i][8][3][0]==checkstr
                  m2.push("#{advemo}#{adv[i][0]}#{" (A2+3)" if dispslots}") if adv[i][8][3][1]==checkstr
                end
                if !adv[i][15].nil? && adv[i][15].length>0
                  for i4 in 0...adv[i][15].length
                    if has_any?(evn,['sub','subabilities','subability','starter'])
                      m2.push("#{advemo}#{adv[i][0]}#{" (HA\u2081)" if dispslots}#{' [HA-Min]' unless dispslots}") if adv[i][15][i4][0]==checkstr
                      m2.push("#{advemo}#{adv[i][0]}#{" (HA\u2082)" if dispslots}#{' [HA-Max]' unless dispslots}") if adv[i][15][i4][1]==checkstr
                    else
                      m2.push("#{advemo}#{adv[i][0]} (HA)") if adv[i][15][i4][1]==checkstr
                    end
                  end
                end
              end
            end
            str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
            m2=[]
            for i in 0...wrm.length
              if has_any?(evn,['sub','subabilities','subability','starter'])
                m2.push("#{emo}#{wrm[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5][0][0]==checkstr
                m2.push("#{emo}#{wrm[i][0]}#{" (A1\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5][0][1]==checkstr
                m2.push("#{emo}#{wrm[i][0]}#{" (A1\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5][0][2]==checkstr
                m2.push("#{emo}#{wrm[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr
                m2.push("#{emo}#{wrm[i][0]}#{" (A2\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
                m2.push("#{emo}#{wrm[i][0]}#{" (A2\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][2]==checkstr
                m2.push("#{emo}#{wrm[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr
                m2.push("#{emo}#{wrm[i][0]}#{" (A3\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
                m2.push("#{emo}#{wrm[i][0]}#{" (A3\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][2]==checkstr
              else
                m2.push("#{emo}#{wrm[i][0]}#{" (A1)" if dispslots}") if wrm[i][5][0][-1]==checkstr
                m2.push("#{emo}#{wrm[i][0]}#{" (A2)" if dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][-1]==checkstr
                m2.push("#{emo}#{wrm[i][0]}#{" (A3)" if dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][-1]==checkstr
              end
              for i2 in 0...elemo.length
                checkstr2="(#{elemo[i2][0]}) #{checkstr}"
                if has_any?(evn,['sub','subabilities','subability','starter'])
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5][0][0]==checkstr2
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5][0][1]==checkstr2
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5][0][2]==checkstr2
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr2
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr2
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][2]==checkstr2
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr2
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr2
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][2]==checkstr2
                else
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1)" if dispslots}") if wrm[i][5][0][-1]==checkstr2
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2)" if dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][-1]==checkstr2
                  m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3)" if dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][-1]==checkstr2
                end
              end
            end
            str="#{str}\n*Wyrmprints:* #{m2.join(', ')}" if m2.length>0
            m2=[]
            for i in 0...wep.length
              unless wep[i][13].nil? || wep[i][13].length<=0
                wemo=''
                moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wep[i][1]}"}
                wemo=moji[0].mention if moji.length>0
                if !wep[i][14].nil? && wep[i][14]=='FEH' && !ignorefeh
                  wemo='<:Gold_Unknown:774013610908188682>'
                  wemo='<:Red_Blade:443172811830198282>' if wep[i][1]=='Sword'
                  wemo='<:Colorless_Blade:443692132310712322>' if wep[i][1]=='Blade'
                  wemo='<:Colorless_Dagger:443692132683743232>' if wep[i][1]=='Dagger'
                  wemo='<:Green_Blade:467122927230386207>' if wep[i][1]=='Axe'
                  wemo='<:Colorless_Bow:443692132616896512>' if wep[i][1]=='Bow'
                  wemo='<:Blue_Blade:467112472768151562>' if wep[i][1]=='Lance'
                  wemo='<:Colorless_Tome:443692133317345290>' if wep[i][1]=='Wand'
                  wemo='<:Colorless_Staff:443692132323295243>' if wep[i][1]=='Staff'
                  wemo='<:Summon_Gun:467557566050861074>' if wep[i][1]=='Manacaster'
                end
                if has_any?(evn,['sub','subabilities','subability','starter'])
                  m2.push("#{wemo}#{wep[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][0]==checkstr
                  m2.push("#{wemo}#{wep[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][1]==checkstr
                  m2.push("#{wemo}#{wep[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][0]==checkstr
                  m2.push("#{wemo}#{wep[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr
                else
                  m2.push("#{wemo}#{wep[i][0]}#{" (A1)" if dispslots}") if wep[i][13][0][-1]==checkstr
                  m2.push("#{wemo}#{wep[i][0]}#{" (A2)" if dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][-1]==checkstr
                end
                for i2 in 0...elemo.length
                  checkstr2="(#{elemo[i2][0]}) #{checkstr}"
                  wpemo=elemo[i2][1]
                  wpemo=elemo[i2][2] if !wep[i][14].nil? && wep[i][14]=='FEH'
                  if has_any?(evn,['sub','subabilities','subability','starter'])
                    m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][0]==checkstr2
                    m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][1]==checkstr2
                    m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][0]==checkstr2
                    m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr2
                  else
                    m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A1)" if dispslots}") if wep[i][13][0][-1]==checkstr2
                    m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A2)" if dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][-1]==checkstr2
                  end
                end
              end
            end
            str="#{str}\n*Weapons:* #{m2.join(', ')}" if m2.length>0
            unless @resonance.find_index{|q| q[1,3].include?(checkstr)}.nil?
              m2=@resonance[@resonance.find_index{|q| q[1,3].include?(checkstr)}].map{|q| q}
              moji2=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{m2[0]}"}
              m2[0]="#{moji2[0].mention}#{m2[0]}" unless moji2.length<=0
              str="#{str}\n*Wyrmprint Affinity:* #{m2[0]} x#{m2.find_index{|q| q==checkstr}+1}"
            end
            m2=[]
            for i in 0...enm.length
              unless enm[i][5].nil? || enm.length<=0
                for i2 in 0...enm[i][5].length
                  m2.push("#{enm[i][0]}#{" (A#{i2+1})" if dispslots}") if enm[i][5][i2]==checkstr
                end
              end
            end
            str="#{str}\n*Enemies:* #{m2.join(', ')}" if m2.length>0
          elsif k[ii2][2]=='CoAbility'
            for i in 0...adv.length
              unless adv[i][7].nil? || adv[i][7].length<=0 || adv[i][7][0].nil?
                mx=adv[i][7][0].split(' ')
                mxx=mx[0,mx.length-1].join(' ')
                mx=mx[-1].split('/').map{|q| "#{mxx} #{'+' if q.include?('%')}#{q.gsub('+','')}"}
                advemo=element_emote(adv[i][2][1],bot,adv[i][12])
                advemo=element_emote(adv[i][2][1],bot) if ignorefeh
                m2.push("#{advemo}#{adv[i][0]} [Min]") if checkstr==mx[0]
                m2.push("#{advemo}<:DLKey:692445248407863376>#{adv[i][0]} [Min]") if "(#{adv[i][2][1]}) #{checkstr}"==mx[0]
                m2.push("#{advemo}#{adv[i][0]} [Max]") if checkstr==mx[4]
                m2.push("#{advemo}<:DLKey:692445248407863376>#{adv[i][0]} [Max]") if "(#{adv[i][2][1]}) #{checkstr}"==mx[4]
              end
            end
            str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
          elsif k[ii2][2]=='Chain'
            for i in 0...adv.length
              unless adv[i][7].nil? || adv[i][7].length<=1 || adv[i][7][1].nil?
                mx=adv[i][7][1].split(' ')
                mxx=mx[0,mx.length-1].join(' ')
                mx=mx[-1].split('/').map{|q| "#{mxx} #{'+' if q.include?('%')}#{q.gsub('+','')}"}
                advemo=element_emote(adv[i][2][1],bot,adv[i][12])
                advemo=element_emote(adv[i][2][1],bot) if ignorefeh
                m2.push("#{advemo}#{adv[i][0]} [Min]") if checkstr==mx[0]
                m2.push("#{advemo}<:DLKey:692445248407863376>#{adv[i][0]} [Min]") if "(#{adv[i][2][1]}) #{checkstr}"==mx[0]
                m2.push("#{advemo}#{adv[i][0]} [Max]") if checkstr==mx[4]
                m2.push("#{advemo}<:DLKey:692445248407863376>#{adv[i][0]} [Max]") if "(#{adv[i][2][1]}) #{checkstr}"==mx[4]
              end
            end
            str="#{str}\n*Adventurers:* #{m2.join(', ')}" if m2.length>0
          elsif k[ii2][2]=='Aura'
            for i in 0...drg.length
              drgemo='<:Element_Null:532106087810334741>'
              drgemo='<:Boost_Anima:521910175955943444>' if !drg[i][16].nil? && drg[i][16]=='FEH'
              for ix in 0...drg[i][6].length
                m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2081)") if drg[i][6][ix][0]==checkstr
                m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2082)") if drg[i][6][ix][1]==checkstr
                m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2083)") if drg[i][6][ix][2]==checkstr
                m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2084)") if drg[i][6][ix][3]==checkstr
                m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2085)") if drg[i][6][ix][4]==checkstr
              end
              unless drg[i][15].nil? || drg[i][15].length<=0
                for i4 in 0...drg[i][15].length
                  m2.push("#{drgemo}#{drg[i][0]} (HA\u2081)") if drg[i][15][i4][0]==checkstr
                  m2.push("#{drgemo}#{drg[i][0]} (HA\u2082)") if drg[i][15][i4][1]==checkstr
                  m2.push("#{drgemo}#{drg[i][0]} (HA\u2083)") if drg[i][15][i4][2]==checkstr
                  m2.push("#{drgemo}#{drg[i][0]} (HA\u2084)") if drg[i][15][i4][3]==checkstr
                  m2.push("#{drgemo}#{drg[i][0]} (HA\u2085)") if drg[i][15][i4][4]==checkstr
                end
              end
              for i2 in 0...elemo.length
                checkstr2="(#{elemo[i2][0]}) #{checkstr}"
                for ix in 0...drg[i][6].length
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (A#{ix+1}\u2081)") if drg[i][6][ix][0]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (A#{ix+1}\u2082)") if drg[i][6][ix][1]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (A#{ix+1}\u2083)") if drg[i][6][ix][2]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (A#{ix+1}\u2084)") if drg[i][6][ix][3]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (A#{ix+1}\u2085)") if drg[i][6][ix][4]==checkstr2
                end
                unless drg[i][15].nil? || drg[i][15].length<=0
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (HA\u2081)") if drg[i][15][0][0]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (HA\u2082)") if drg[i][15][0][1]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (HA\u2083)") if drg[i][15][0][2]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (HA\u2084)") if drg[i][15][0][3]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (HA\u2085)") if drg[i][15][0][4]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (HA\u2081)") if drg[i][15].length>1 && drg[i][15][1][0]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (HA\u2082)") if drg[i][15].length>1 && drg[i][15][1][1]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (HA\u2083)") if drg[i][15].length>1 && drg[i][15][1][2]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (HA\u2084)") if drg[i][15].length>1 && drg[i][15][1][3]==checkstr2
                  m2.push("#{elemo[i2][1]}#{drg[i][0]} (HA\u2085)") if drg[i][15].length>1 && drg[i][15][1][4]==checkstr2
                end
              end
            end
            str="#{str}\n*Dragons:* #{m2.join(', ')}" if m2.length>0
          end
        else
          if k[ii2][2]=='Ability'
            c=' - '
            c="\n" if lng
            brk=false
            m2=[]
            for i3 in 0...adv.length
              unless adv[i][8].nil? || adv[i][8].length<=0 || adv[i][8][0].nil? || adv[i][8][0].length<=0
                advabils=[adv[i3][8][0][-1],adv[i3][8][1][-1],adv[i3][8][2][-1]]
                advabils.push(adv[i3][8][3][-1]) if adv[i3][8].length>3
                advemo=element_emote(adv[i3][2][1],bot,adv[i3][12])
                advemo=element_emote(adv[i3][2][1],bot) if ignorefeh
                mm2=1
                mm2=2 if adv[i3][12]=='FEH' && !ignorefeh
                m2.push("#{advemo}*#{adv[i3][0]}*") if advabils.include?(checkstr)
                for i2 in 0...elemo.length
                  m2.push("#{elemo[i2][mm2]}#{adv[i3][0]}") if advabils.include?("(#{elemo[i2][0]}) #{checkstr}")
                end
                m2.push("#{advemo}#{adv[i3][0]} [HA]") if !adv[i3][15].nil? && adv[i3][15].length>0 && adv[i3][15].map{|q| q[1]}.include?(checkstr)
              end
            end
            if m2.length>3 
              str="#{str}#{c}#{m2.length} adventurers"
              c=' - '
            elsif m2.length>0
              str="#{str}#{c}#{m2.join(', ')}"
              c=' - '
            end
            m2=[]
            for i in 0...wrm.length
              m2.push("#{emo}#{wrm[i][0]}") if wrm[i][5].map{|q| q[-1]}.include?(checkstr)
              for i2 in 0...elemo.length
                m2.push("#{elemo[i2][1]}#{wrm[i][0]}") if wrm[i][5].map{|q| q[-1]}.include?("(#{elemo[i2][0]}) #{checkstr}")
              end
            end
            if m2.length>3 
              str="#{str}#{c}#{m2.length} wyrmprints"
              c=' - '
            elsif m2.length>0
              str="#{str}#{c}#{m2.join(', ')}"
              c=' - '
            end
            m2=[]
            for i in 0...wep.length
              unless wep[i][13].nil? || wep[i][13].length<=0
                wemo=''
                moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wep[i][1]}"}
                wemo=moji[0].mention if moji.length>0
                if !wep[i][14].nil? && wep[i][14]=='FEH' && !ignorefeh
                  wemo='<:Gold_Unknown:774013610908188682>'
                  wemo='<:Red_Blade:443172811830198282>' if wep[i][1]=='Sword'
                  wemo='<:Colorless_Blade:443692132310712322>' if wep[i][1]=='Blade'
                  wemo='<:Colorless_Dagger:443692132683743232>' if wep[i][1]=='Dagger'
                  wemo='<:Green_Blade:467122927230386207>' if wep[i][1]=='Axe'
                  wemo='<:Colorless_Bow:443692132616896512>' if wep[i][1]=='Bow'
                  wemo='<:Blue_Blade:467112472768151562>' if wep[i][1]=='Lance'
                  wemo='<:Colorless_Tome:443692133317345290>' if wep[i][1]=='Wand'
                  wemo='<:Colorless_Staff:443692132323295243>' if wep[i][1]=='Staff'
                  wemo='<:Summon_Gun:467557566050861074>' if wep[i][1]=='Manacaster'
                end
                m2.push("#{wemo}#{wep[i][0]}") if wep[i][13][0][-1]==checkstr
                m2.push("#{wemo}#{wep[i][0]}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][-1]==checkstr
                for i2 in 0...elemo.length
                  wpemo=elemo[i2][1]
                  wpemo=elemo[i2][2] if !wep[i][14].nil? && wep[i][14]=='FEH'
                  checkstr2="(#{elemo[i2][0]}) #{checkstr}"
                  m2.push("#{wemo}#{wpemo}#{wep[i][0]}") if wep[i][13][0][-1]==checkstr2
                  m2.push("#{wemo}#{wpemo}#{wep[i][0]}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][-1]==checkstr2
                end
              end
            end
            m2.uniq!
            if m2.length>3 
              str="#{str}#{c}#{m2.length} weapons"
              c=' - '
            elsif m2.length>0
              str="#{str}#{c}#{m2.join(', ')}"
              c=' - '
            end
            unless @resonance.find_index{|q| q[1,3].include?(checkstr)}.nil?
              m2=@resonance[@resonance.find_index{|q| q[1,3].include?(checkstr)}].map{|q| q}
              moji2=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{m2[0]}"}
              m2[0]="#{moji2[0].mention}#{m2[0]}" unless moji2.length<=0
              str="#{str} - *Affinity:* #{m2[0]} x#{m2.find_index{|q| q==checkstr}+1}"
            end
          elsif k[ii2][2]=='CoAbility'
            m2=[]
            for i in 0...adv.length
              mx=adv[i][7][0].split(' ')
              mxx=mx[0,mx.length-1].join(' ')
              mx=mx[-1].split('/').map{|q| "#{mxx} #{'+' if q.include?('%')}#{q.gsub('+','')}"}
              advemo=element_emote(adv[i][2][1],bot,adv[i][12])
              advemo=element_emote(adv[i][2][1],bot) if ignorefeh
              m2.push("#{advemo}#{adv[i][0]}") if checkstr==mx[4]
              m2.push("#{advemo}<:DLKey:692445248407863376>#{adv[i][0]}") if "(#{adv[i][2][1]}) #{checkstr}"==mx[4]
            end
            str="#{str} - #{m2.join(', ')}" if m2.length>0
          elsif k[ii2][2]=='Chain'
            m2=[]
            for i in 0...adv.length
              mx=adv[i][7][1].split(' ')
              mxx=mx[0,mx.length-1].join(' ')
              mx=mx[-1].split('/').map{|q| "#{mxx} #{'+' if q.include?('%')}#{q.gsub('+','')}"}
              advemo=element_emote(adv[i][2][1],bot,adv[i][12])
              advemo=element_emote(adv[i][2][1],bot) if ignorefeh
              m2.push("#{advemo}#{adv[i][0]}") if checkstr==mx[4]
              m2.push("#{advemo}<:DLKey:692445248407863376>#{adv[i][0]}") if "(#{adv[i][2][1]}) #{checkstr}"==mx[4]
            end
            str="#{str} - #{m2.join(', ')}" if m2.length>0
          elsif k[ii2][2]=='Aura'
            m2=[]
            for i in 0...drg.length
              checkstr2="(#{drg[i][2]}) #{checkstr}"
              drgemo=element_emote(drg[i][2],bot,drg[i][16])
              drgemo=element_emote(drg[i][2],bot) if ignorefeh
              for ix in 0...drg[i][6].length
                m2.push("#{drgemo}#{drg[i][0]}") if drg[i][6][ix][-1]==checkstr
                m2.push("#{drgemo}#{drg[i][0]}") if drg[i][6][ix][-1]==checkstr2
              end
              unless drg[i][15].nil? || drg[i][15].length<=0
                for i4 in 0...drg[i][15].length
                  m2.push("#{drgemo}#{drg[i][0]} (HA)") if drg[i][15][i4][-1]==checkstr
                  m2.push("#{drgemo}#{drg[i][0]} (HA)") if drg[i][15][i4][-1]==checkstr2
                end
              end
              for i2 in 0...elemo.length
                drgemo=elemo[i2][1]
                drgemo=elemo[i2][2] if drg[i][16]=='FEH' && !ignorefeh
                m2.push("#{drgemo}#{drg[i][0]}") if drg[i][6][0][-1]=="(#{elemo[i2][0]}) #{checkstr}"
                unless drg[i][15].nil? || drg[i][15].length<=0
                  m2.push("#{drgemo}#{drg[i][0]} (HA)") if drg[i][15][0][-1]=="(#{elemo[i2][0]}) #{checkstr}"
                  m2.push("#{drgemo}#{drg[i][0]} (HA)") if drg[i][15].length>1 && drg[i][15][1][-1]=="(#{elemo[i2][0]}) #{checkstr}"
                end
              end
            end
            str="#{str} - #{m2.uniq.join(', ')}" if m2.length>0
          end
        end
      end
      f=@abilimits.map{|q| q.split(" \u2192 ")}
      if f.map{|q| q[0]}.include?(k[0][0])
        str="#{str}\n\n**Per-adventurer wyrmprint stack limit:** #{f[f.find_index{|q| q[0]==k[0][0]}][1]}"
      elsif ['Flame Res','Water Res','Wind Res','Light Res','Shadow Res'].include?(k[0][0]) && f.map{|q| q[0]}.include?('Element Res')
        str="#{str}\n\n**Per-adventurer wyrmprint stack limit:** #{f[f.find_index{|q| q[0]=='Element Res'}][1]}"
      elsif "Dragon's Claws"==k[0][0]
        str="#{str}\n\n**You may instead be searching for the skill `Dragon Claw`, which belongs to Gala Mym<:Rarity_5:532086056737177600><:Element_Flame:532106087952810005><:Weapon_Lance:532106114792423448><:Type_Attack:532107867520630784>.**"
      end
    end
    ftr='To include base abilities, include the word "subabilities" in your message.' unless !ftr.nil? || has_any?(evn,['sub','subabilities','subability','starter'])
    ftr=nil if k.reject{|q| q[2]=='CoAbility'}.length<=0
  else
    emo=''
    emo='<:Element_Null:532106087810334741>' unless @askilities.find_index{|q| q[2]==k[2] && "#{q[0]}#{" #{q[1]}" unless q[1]=='-'}".include?(") #{k[0]}#{" #{k[1]}" unless k[1]=='-'}")}.nil?
    atyp="#{k[2]}"
    atyp='Chain CoAbility' if atyp=='Chain'
    hdr="__**#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}**__ [#{atyp}]"
    hdr="__**#{k[1]} #{k[0]}**__ [#{atyp}]" if k[0][0,7]=='Hits = '
    hdr="__**#{k[0]}**__ [#{atyp}]" if k[1]=='-'
    xcolor=0x555058
    xcolor=0x87817C if k[2]=='Aura'
    xcolor=0x242035 if k[2]=='CoAbility'
    xcolor=0x342025 if k[2]=='Chain'
    str="**Effect:** #{k[3].gsub(';;',"\n")}" if k[5]=='y' || k[2]=='Aura'
    str2=''
    flds=[]
    if k[2]=='Ability'
      m2=[]
      checkstr="#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}"
      checkstr="#{k[1]} #{k[0]}" if k[0][0,7]=='Hits = '
      checkstr="#{k[0]}" if k[1]=='-'
      for i in 0...adv.length
        unless adv[i][8].nil? || adv[i][8].length<=0 || adv[i][8][0].nil? || adv[i][8][0].length<=0
          advemo=element_emote(adv[i][2][1],bot,adv[i][12])
          advemo=element_emote(adv[i][2][1],bot) if ignorefeh
          if has_any?(evn,['sub','subabilities','subability','starter'])
            for i4 in 0...3
              if adv[i][8][i4].length<=1
                m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}" if dispslots}") if adv[i][8][i4][0]==checkstr
              elsif adv[i][8][i4].length<=2
                m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][i4][0]==checkstr
                m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][i4][1]==checkstr
              else
                m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2081)" if dispslots}#{' [Min]' unless dispslots}") if adv[i][8][i4][0]==checkstr
                m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2082)" if dispslots}#{' [mid]' unless dispslots}") if adv[i][8][i4][1]==checkstr
                m2.push("#{advemo}#{adv[i][0]}#{" (A#{i4+1}\u2083)" if dispslots}#{' [Max]' unless dispslots}") if adv[i][8][i4][2]==checkstr
              end
            end
          else
            m2.push("#{advemo}#{adv[i][0]}#{" (A1)" if dispslots}") if adv[i][8][0].reject{|q| q.length<=0}[-1]==checkstr
            m2.push("#{advemo}#{adv[i][0]}#{" (A2)" if dispslots}") if adv[i][8][1].reject{|q| q.length<=0}[-1]==checkstr
            m2.push("#{advemo}#{adv[i][0]}#{" (A3)" if dispslots}") if adv[i][8][2].reject{|q| q.length<=0}[-1]==checkstr
            m2.push("#{advemo}#{adv[i][0]}#{" (A1+3)" if dispslots}") if adv[i][8][3][0]==checkstr
            m2.push("#{advemo}#{adv[i][0]}#{" (A2+3)" if dispslots}") if adv[i][8][3][1]==checkstr
          end
          if !adv[i][15].nil? && adv[i][15].length>0
            for i4 in 0...adv[i][15].length
              if has_any?(evn,['sub','subabilities','subability','starter'])
                m2.push("#{advemo}#{adv[i][0]}#{" (HA\u2081)" if dispslots}#{' [HA-Min]' unless dispslots}") if adv[i][15][i4][0]==checkstr
                m2.push("#{advemo}#{adv[i][0]}#{" (HA\u2082)" if dispslots}#{' [HA-Max]' unless dispslots}") if adv[i][15][i4][1]==checkstr
              else
                m2.push("#{advemo}#{adv[i][0]} (HA)") if adv[i][15][i4][1]==checkstr
              end
            end
          end
        end
      end
      if m2.length>0
        if m2.length>25 && !s2s
          str2="#{str2}\n#{m2.length} total adventurers"
        elsif !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Adventurers:** #{m2.join(', ')}"
        else
          flds.push(['Adventurers',m2.join("\n")])
        end
      end
      m2=[]
      for i in 0...wrm.length
        if has_any?(evn,['sub','subabilities','subability','starter'])
          m2.push("#{emo}#{wrm[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5][0][0]==checkstr
          m2.push("#{emo}#{wrm[i][0]}#{" (A1\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5][0][1]==checkstr
          m2.push("#{emo}#{wrm[i][0]}#{" (A1\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5][0][2]==checkstr
          m2.push("#{emo}#{wrm[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr
          m2.push("#{emo}#{wrm[i][0]}#{" (A2\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr
          m2.push("#{emo}#{wrm[i][0]}#{" (A2\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][2]==checkstr
          m2.push("#{emo}#{wrm[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr
          m2.push("#{emo}#{wrm[i][0]}#{" (A3\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr
          m2.push("#{emo}#{wrm[i][0]}#{" (A3\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][2]==checkstr
        else
          m2.push("#{emo}#{wrm[i][0]}#{" (A1)" if dispslots}") if wrm[i][5][0][-1]==checkstr
          m2.push("#{emo}#{wrm[i][0]}#{" (A2)" if dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][-1]==checkstr
          m2.push("#{emo}#{wrm[i][0]}#{" (A3)" if dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][-1]==checkstr
        end
        for i2 in 0...elemo.length
          checkstr2="(#{elemo[i2][0]}) #{checkstr}"
          if has_any?(evn,['sub','subabilities','subability','starter'])
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5][0][0]==checkstr2
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5][0][1]==checkstr2
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5][0][2]==checkstr2
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][0]==checkstr2
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][1]==checkstr2
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][2]==checkstr2
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3\u2081)" if dispslots}#{' [Min]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][0]==checkstr2
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3\u2082)" if dispslots}#{' [Med]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][1]==checkstr2
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3\u2083)" if dispslots}#{' [Max]' unless dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][2]==checkstr2
          else
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A1)" if dispslots}") if wrm[i][5][0][-1]==checkstr2
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A2)" if dispslots}") if wrm[i][5].length>1 && wrm[i][5][1][-1]==checkstr2
            m2.push("#{elemo[i2][1]}#{wrm[i][0]}#{" (A3)" if dispslots}") if wrm[i][5].length>2 && wrm[i][5][2][-1]==checkstr2
          end
        end
      end
      if m2.length>0
        if m2.length>25 && !s2s
          str2="#{str2}\n#{m2.length} total wyrmprints"
        elsif !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Wyrmprints:** #{m2.join(', ')}"
        else
          flds.push(['Wyrmprints',m2.join("\n")])
        end
      end
      m2=[]
      for i in 0...wep.length
        unless wep[i][13].nil? || wep[i][13].length<=0
          wemo=''
          moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wep[i][1]}"}
          wemo=moji[0].mention if moji.length>0
          if !wep[i][14].nil? && wep[i][14]=='FEH' && !ignorefeh
            wemo='<:Gold_Unknown:774013610908188682>'
            wemo='<:Red_Blade:443172811830198282>' if wep[i][1]=='Sword'
            wemo='<:Colorless_Blade:443692132310712322>' if wep[i][1]=='Blade'
            wemo='<:Colorless_Dagger:443692132683743232>' if wep[i][1]=='Dagger'
            wemo='<:Green_Blade:467122927230386207>' if wep[i][1]=='Axe'
            wemo='<:Colorless_Bow:443692132616896512>' if wep[i][1]=='Bow'
            wemo='<:Blue_Blade:467112472768151562>' if wep[i][1]=='Lance'
            wemo='<:Colorless_Tome:443692133317345290>' if wep[i][1]=='Wand'
            wemo='<:Colorless_Staff:443692132323295243>' if wep[i][1]=='Staff'
            wemo='<:Summon_Gun:467557566050861074>' if wep[i][1]=='Manacaster'
          end
          if has_any?(evn,['sub','subabilities','subability','starter'])
            m2.push("#{wemo}#{wep[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][0]==checkstr
            m2.push("#{wemo}#{wep[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][1]==checkstr
            m2.push("#{wemo}#{wep[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][0]==checkstr
            m2.push("#{wemo}#{wep[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr
          else
            m2.push("#{wemo}#{wep[i][0]}#{" (A1)" if dispslots}") if wep[i][13][0][-1]==checkstr
            m2.push("#{wemo}#{wep[i][0]}#{" (A2)" if dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][-1]==checkstr
          end
          for i2 in 0...elemo.length
            checkstr2="(#{elemo[i2][0]}) #{checkstr}"
            wpemo=elemo[i2][1]
            wpemo=elemo[i2][2] if !wep[i][14].nil? && wep[i][14]=='FEH'
            if has_any?(evn,['sub','subabilities','subability','starter'])
              m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A1\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][0]==checkstr2
              m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A1\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][0].length<2}") if wep[i][13][0][1]==checkstr2
              m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A2\u2081)" if dispslots}#{' [Min]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][0]==checkstr2
              m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A2\u2082)" if dispslots}#{' [Max]' unless dispslots || wep[i][13][1].length<2}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][1]==checkstr2
            else
              m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A1)" if dispslots}") if wep[i][13][0][-1]==checkstr2
              m2.push("#{wemo}#{wpemo}#{wep[i][0]}#{" (A2)" if dispslots}") if !wep[i][13][1].nil? && wep[i][13][1].length>0 && wep[i][13][1][-1]==checkstr2
            end
          end
        end
      end
      if m2.length>0
        if m2.length>25 && !s2s
          str2="#{str2}\n#{m2.length} total weapons"
        elsif !s2s || was_embedless_mentioned?(event)
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
        if m2.length>25 && !s2s
          str2="#{str2}\n#{m2.length} total enemies"
        elsif !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Enemies:** #{m2.join(', ')}"
        else
          flds.push(['Enemies',m2.join("\n")])
        end
      end
    elsif k[2]=='CoAbility'
      m2=[]
      checkstr="#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}"
      checkstr="#{k[1]} #{k[0]}" if k[0][0,7]=='Hits = '
      checkstr="#{k[0]}" if k[1]=='-'
      for i in 0...adv.length
        unless adv[i][7].nil? || adv[i][7].length<=0 || adv[i][7][0].nil?
          mx=adv[i][7][0].split(' ')
          mxx=mx[0,mx.length-1].join(' ')
          mx=mx[-1].split('/').map{|q| "#{mxx} #{'+' if q.include?('%') && !q.include?('+')}#{q}"}
          advemo=element_emote(adv[i][2][1],bot,adv[i][12])
          advemo=element_emote(adv[i][2][1],bot) if ignorefeh
          for i2 in 0...mx.length
            m2.push("#{advemo}#{adv[i][0]} (Co#{["\u2081","\u2082","\u2083","\u2084","\u2085"][i2]})") if checkstr==mx[i2]
          end
        end
      end
      if m2.length>0
        if m2.length>25 && !s2s
          str2="#{str2}\n#{m2.length} total adventurers"
        elsif !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Adventurers:** #{m2.join(', ')}"
        else
          flds.push(['Adventurers',m2.join("\n")])
        end
      end
      ftr='The numbers in parenthesis indicate which CoAbility stage the adventurer needs to have.'
    elsif k[2]=='Chain'
      m2=[]
      checkstr="#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}"
      checkstr="#{k[1]} #{k[0]}" if k[0][0,7]=='Hits = '
      checkstr="#{k[0]}" if k[1]=='-'
      for i in 0...adv.length
        unless adv[i][7].nil? || adv[i][7].length<=1 || adv[i][7][1].nil?
          mx=adv[i][7][1].split(' ')
          mxx=mx[0,mx.length-1].join(' ')
          mx=mx[-1].split('/').map{|q| "#{mxx} #{'+' if q.include?('%') && !q.include?('+')}#{q}"}
          advemo=element_emote(adv[i][2][1],bot,adv[i][12])
          advemo=element_emote(adv[i][2][1],bot) if ignorefeh
          for i2 in 0...mx.length
            m2.push("#{advemo}#{adv[i][0]} (Ch#{["\u2081","\u2082","\u2083","\u2084","\u2085"][i2]})") if checkstr==mx[i2]
          end
        end
      end
      if m2.length>0
        if m2.length>25 && !s2s
          str2="#{str2}\n#{m2.length} total adventurers"
        elsif !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Adventurers:** #{m2.join(', ')}"
        else
          flds.push(['Adventurers',m2.join("\n")])
        end
      end
      ftr='The numbers in parenthesis indicate which CoAbility stage the adventurer needs to have.'
    elsif k[2]=='Aura'
      m2=[]
      checkstr="#{k[0]} #{'+' if k[1].include?('%')}#{k[1]}"
      checkstr="#{k[1]} #{k[0]}" if k[0][0,7]=='Hits = '
      checkstr="#{k[0]}" if k[1]=='-'
      for i in 0...drg.length
        checkstr2="(#{drg[i][2]}) #{checkstr}"
        drgemo=element_emote(drg[i][2],bot,drg[i][16])
        drgemo=element_emote(drg[i][2],bot) if ignorefeh
        for ix in 0...drg[i][6].length
          m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2081)") if drg[i][6][ix][0]==checkstr
          m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2082)") if drg[i][6][ix][1]==checkstr
          m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2083)") if drg[i][6][ix][2]==checkstr
          m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2084)") if drg[i][6][ix][3]==checkstr
          m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2085)") if drg[i][6][ix][4]==checkstr
          m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2081)") if drg[i][6][ix][0]==checkstr2
          m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2082)") if drg[i][6][ix][1]==checkstr2
          m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2083)") if drg[i][6][ix][2]==checkstr2
          m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2084)") if drg[i][6][ix][3]==checkstr2
          m2.push("#{drgemo}#{drg[i][0]} (A#{ix+1}\u2085)") if drg[i][6][ix][4]==checkstr2
        end
        unless drg[i][15].nil? || drg[i][15].length<=0
          for i4 in 0...drg[i][15].length
            m2.push("#{drgemo}#{drg[i][0]} (HA\u2081)") if drg[i][15][i4][0]==checkstr
            m2.push("#{drgemo}#{drg[i][0]} (HA\u2082)") if drg[i][15][i4][1]==checkstr
            m2.push("#{drgemo}#{drg[i][0]} (HA\u2083)") if drg[i][15][i4][2]==checkstr
            m2.push("#{drgemo}#{drg[i][0]} (HA\u2084)") if drg[i][15][i4][3]==checkstr
            m2.push("#{drgemo}#{drg[i][0]} (HA\u2085)") if drg[i][15][i4][4]==checkstr
            m2.push("#{drgemo}#{drg[i][0]} (HA\u2081)") if drg[i][15][i4][0]==checkstr2
            m2.push("#{drgemo}#{drg[i][0]} (HA\u2082)") if drg[i][15][i4][1]==checkstr2
            m2.push("#{drgemo}#{drg[i][0]} (HA\u2083)") if drg[i][15][i4][2]==checkstr2
            m2.push("#{drgemo}#{drg[i][0]} (HA\u2084)") if drg[i][15][i4][3]==checkstr2
            m2.push("#{drgemo}#{drg[i][0]} (HA\u2085)") if drg[i][15][i4][4]==checkstr2
          end
        end
      end
      if m2.length>0
        if m2.length>25 && !s2s
          str2="#{str2}\n#{m2.length} total dragons"
        elsif !s2s || was_embedless_mentioned?(event)
          str2="#{str2}\n**Dragons:** #{m2.join(', ')}"
        else
          flds.push(['Dragons',m2.join("\n")])
        end
      end
    end
    str="#{str}\n#{str2}" if str2.length>0
    if "Dragon's Claws"==k[0]
      str="#{str}\n\n**You may instead be searching for the skill `Dragon Claw`, which belongs to Gala Mym<:Rarity_5:532086056737177600><:Element_Flame:532106087952810005><:Weapon_Lance:532106114792423448><:Type_Attack:532107867520630784>.**"
    end
    flds=nil if flds.length<=0
  end
  xpic=xpic.split(') ')[-1].gsub(' ','_').gsub('%','')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Abilities/#{xpic}.png?raw=true"
  flds=nil if !flds.nil? && flds.length<=0
  unless flds.nil? || flds.length>1
    m=flds[0][1].split("\n")
    elemo=[['Base','<:Element_Null:532106087810334741>','<:Boost_Anima:521910175955943444>'],
           ['Flame','<:Element_Flame:532106087952810005>','<:Boost_Fire:498863399116079123>'],
           ['Water','<:Element_Water:532106088221376522>','<:Boost_Water:498863398944243712>'],
           ['Wind','<:Element_Wind:532106087948746763>','<:Boost_Wind:498863398918815745>'],
           ['Light','<:Element_Light:532106088129101834>','<:Boost_Light:521910176047955968>'],
           ['Shadow','<:Element_Shadow:532106088154267658>','<:Boost_Dark:521910175968395275>']]
    flds2=[]
    for i in 0...elemo.length
      k=m.reject{|q| !q.include?(elemo[i][1]) && !q.include?(elemo[i][2])}.map{|q| q.gsub(elemo[i][1],'')}
      elemoo="#{elemo[i][1]}"
      elemoo="#{elemo[i][2]}" if k.reject{|q| q.include?(elemo[i][2])}.length<=0
      k=k.map{|q| q.gsub(elemo[i][2],'')}
      flds2.push(["#{elemoo}#{elemo[i][0]} #{flds[0][0]}",k.join("\n")]) if k.length>0
    end
    if flds2.length<=0
      m=flds[0][1].split("\n")
      elemo=[['Swords','<:Weapon_Sword:532106114540634113>','<:Red_Blade:443172811830198282>'],
             ['Blades','<:Weapon_Blade:532106114628714496>','<:Colorless_Blade:443692132310712322>'],
             ['Daggers','<:Weapon_Dagger:532106116025286656>','<:Colorless_Dagger:443692132683743232>'],
             ['Axes','<:Weapon_Axe:532106114188443659>','<:Green_Blade:467122927230386207>'],
             ['Bows','<:Weapon_Bow:532106114909732864>','<:Colorless_Bow:443692132616896512>'],
             ['Lances','<:Weapon_Lance:532106114792423448>','<:Blue_Blade:467112472768151562>'],
             ['Wands','<:Weapon_Wand:532106114985099264>','<:Colorless_Tome:443692133317345290>'],
             ['Staves','<:Weapon_Staff:532106114733441024>','<:Colorless_Staff:443692132323295243>'],
             ['Manacasters','<:Weapon_Manacaster:758905122448867338>','<:Summon_Gun:467557566050861074>']]
      flds2=[]
      for i in 0...elemo.length
        k=m.reject{|q| !q.include?(elemo[i][1]) && !q.include?(elemo[i][2])}.map{|q| q.gsub(elemo[i][1],'')}
        elemoo="#{elemo[i][1]}"
        elemoo="#{elemo[i][2]}" if k.reject{|q| q.include?(elemo[i][2])}.length<=0
        k=k.map{|q| q.gsub(elemo[i][2],'')}
        flds2.push(["#{elemoo}#{elemo[i][0]}",k.join("\n")]) if k.length>0
      end
      if flds2.length<=0
        flds=triple_finish(m)
      else
        flds=flds2.map{|q| q}
      end
    else
      flds=flds2.map{|q| q}
    end
  end
  f=0
  f=flds.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length unless flds.nil?
  f+=ftr.length unless ftr.nil?
  hdr="#{hdr}\n*Showing only:* #{typ.join(', ')}" if typ.length>0
  if hdr.length+str.length+f>=1900
    if hdr.length+str.length>=1900
      m=[2,0,str.split("\n\n")]
      for i in 0...m[2].length
        if m[2][i].length>=1990
          m[2][i]=m[2][i].split("\n")
          for i2 in 0...m[2][i].length
            m[2][i][i2]=m[2][i][i2].split(', ') if m[2][i][i2].length>=1990
          end
        end
      end
      m[2].flatten!
      str=''
      for i in 0...m[2].length
        lne=', '
        lne='' if i==0
        lne="\n" if m[2][i][0,1]=='*'
        lne="\n"*m[0] if i>0 && m[2][i-1].include?('__**Example')
        lne="\n"*m[0] if m[2][i].include?("\n")
        lne="\n"*m[0] if m[2][i][0,2]=='**'
        if "#{str}#{lne}#{m[2][i]}".length>=1900
          if m[1]==0
            create_embed(event,hdr,str,xcolor,nil,xpic)
          else
            create_embed(event,'',str,xcolor)
          end
          m[1]+=1
          str="#{m[2][i]}"
        else
          str="#{str}#{lne}#{m[2][i]}"
        end
      end
      if m[1]==0
        create_embed(event,hdr,str,xcolor,nil,xpic)
      else
        create_embed(event,'',str,xcolor)
      end
    else
      create_embed(event,hdr,str,xcolor,nil,xpic)
    end
    unless flds.nil?
      if flds.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length>=1500
        for i in 0...flds.length
          if flds[i][1].length>=1800
            str2="**#{flds[i][0]}** - "
            f=flds[i][1].split("\n")
            for i2 in 0...f.length
              m=''
              m=', ' unless i2==0
              str2=extend_message(str2,f[i2],event,1,m)
            end
            event.respond str2
          else
            create_embed(event,flds[i][0],'',xcolor,nil,nil,triple_finish(flds[i][1].split("\n")))
          end
        end
      else
        create_embed(event,'','',xcolor,nil,nil,flds)
      end
    end
    event.respond ftr unless ftr.nil?
  else
    ftr=nil unless ftr.nil? || ftr.length>0
    if !flds.nil? && flds.length==1
      x=flds[0][0]
      y=flds[0][1].split("\n")
      flds=triple_finish(y,true).map{|q| [x,q[1]]}
    end
    create_embed(event,hdr,str,xcolor,ftr,xpic,flds)
  end
  if evn.include?('tags')
    skill=k.map{|q| q}
    skill=k[0].map{|q| q} if k[0].is_a?(Array)
    create_embed(event,'Sorting tags','',xcolor,nil,nil,triple_finish(skill[6]))
  end
end

def disp_facility_data(bot,event,args=nil,extvat=false)
  reload_library()
  return fac_stats(bot,event,args)
end

def disp_mat_data(bot,event,args=nil,extvat=false)
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
  title=generate_rarity_row(k[1])
  if k[2]==101
    title="#{title}\n**Type:** Upgrade\n**Subtype:** Adventurer"
  elsif k[2]==102
    title="#{title}\n**Type:** Upgrade\n**Subtype:** Dragon"
  elsif k[2]==103
    title="#{title}\n**Type:** Upgrade\n**Subtype:** Weapon"
  elsif k[2]==104
    title="#{title}\n**Type:** Upgrade\n**Subtype:** Facility"
  elsif k[2]==111
    title="#{title}\n**Type:** Unbind\n**Subtype:** Dragon"
  elsif k[2]==112
    title="#{title}\n**Type:** Unbind\n**Subtype:** Weapon"
  elsif k[2]==113
    title="#{title}\n**Type:** Upgrade\n**Subtype:** Wyrmprint"
  elsif k[2]==114
    title="#{title}\n**Type:** Unbind\n**Subtype:** Wyrmprint"
  else
    title="#{title}\n**Type:** Misc."
  end
  title="#{title}\n**Drop bag:** #{['<:Pouch_1:622140100679303189> Common','<:Pouch_2:622140100960190475> Rare','<:Pouch_3:622140100888756237> Legendary'][k[6]]}" unless k[2]==0
  str="**Description:** #{k[3].gsub(';; ',"\n")}"
  str="#{str}\n**EXP:** #{longFormattedNumber(k[7])}" unless k[7]<=0
  if s2s || k[4].length<=5 || k[5].length+k[4].length<=8
    str="#{str}\n\n**Ways to obtain:**\n#{k[4].join("\n")}"
  else
    str="#{str}\n\n**Ways to obtain:**\n#{k[4][0,3].join("\n")}\n~~For more, please use this command in PM~~"
  end
  if s2s || k[5].length<=5 || k[5].length+k[4].length<=8
    str="#{str}\n\n**Uses:**\n#{k[5].join("\n")}"
  else
    str="#{str}\n\n**Uses:**\n#{k[5][0,3].join("\n")}\n~~For more, please use this command in PM~~"
  end
  dispname=k[0].gsub(' ','_')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Mats/#{dispname}.png?raw=true"
  flds=nil
  flds=triple_finish(k[8].sort,true) if args.include?('tag') || args.include?('tags')
  flds=nil unless s2s
  f=0
  f=flds.map{|q| q[1]}.join("\n").length+"\n\n**searching tags:**".length unless flds.nil?
  if str.length+title.length+f>=1800
    str=str.split("\n\n")
    str[0]="#{str[0]}\n\n#{str[1]}"
    str[1]=nil
    str.compact!
    if s2s
      create_embed(event,["__**#{k[0]}**__",title],str[0],0xE3F78B,nil,xpic)
      if str.length>=3 && "#{str[1]}\n\n#{str[2]}".length<1900
        create_embed(event,'',"#{str[1]}\n\n#{str[2]}",0xE3F78B)
      else
        create_embed(event,'',str[1],0xE3F78B)
        create_embed(event,'',str[2],0xE3F78B) if str.length>=3
      end
      create_embed(event,'','Searching tags',0xE3F78B,nil,nil,flds) unless flds.nil?
    else
      create_embed(event,["__**#{k[0]}**__",title],"#{str[0]}#{"\n\n**Searching Tags:**" unless flds.nil?}",0xE3F78B,'For obtainment methods, please use this command in PM.  Including them made this reply too long.',xpic,flds)
    end
  else
    create_embed(event,["__**#{k[0]}**__",title],"#{str}#{"\n\n**Searching Tags:**" unless flds.nil?}",0xE3F78B,nil,xpic,flds)
  end
end  

def disp_status_data(bot,event,args=nil,extvat=false)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_status,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  ftr=nil
  xcolor=0xE3F78B
  xcolor=0xE73031 if k[0]=='Burn'
  xcolor=0x1890DE if k[0]=='Freeze'
  xcolor=0x00D771 if k[0]=='Sleep'
  xcolor=0xFFB90F if k[0]=='Blind'
  xcolor=0xA637DE if k[0]=='Curse'
  str="**Effect on player:** #{k[2].gsub(';; ',"\n")}" unless k[2]=='-'
  str="#{str}\n\n**Effect on enemy:** #{k[3].gsub(';; ',"\n")}" unless k[3]=='-'
  m=@statuses.reject{|q| q[1]!=k[1] || q[0]==k[0]}
  xpic=k[0].gsub(' ','_')
  xpic="https://github.com/Rot8erConeX/BotanBot/blob/master/Status/#{xpic}.png?raw=true"
  ftr="#{list_lift(m.map{|q| q[0]},'and')} will overwrite this status.  All other statuses will stack instead." unless k[1]==0 || m.length<=0
  create_embed(event,"__**#{k[0]}**__",str,xcolor,ftr,xpic)
end

def disp_adventurer_art(bot,event,args=nil,justatats=false)
  reload_library()
  return art_of_adventure(bot,event,args)
end

def disp_dragon_art(bot,event,args=nil,justatats=false)
  reload_library()
  return art_of_dragon(bot,event,args)
end

def disp_wyrmprint_art(bot,event,args=nil,justatats=false)
  reload_library()
  return art_of_printing(bot,event,args)
end

def disp_boss_art(bot,event,args=nil,juststats=false)
  reload_library()
  return art_of_the_boss(bot,event,args)
end

def disp_emote_art(bot,event,args=nil,justatats=false)
  reload_library()
  return art_of_emotion(bot,event,args)
end

def disp_npc_art(bot,event,args=nil,juststats=false)
  reload_library()
  return art_of_the_nobody(bot,event,args)
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
  bbb=@banners.reject{|q| q[4].nil? || q[4].length<=0 || q[4][0]=='-'}
  bb=bbb.reject{|q| q[4][0].split('/').reverse.join('').to_i>tm || !(q[4].length==1 || q[4][1].split('/').reverse.join('').to_i>=tm)}
  if bb.length<=0
    event.respond "No matches found." if showerr
  else
    for iq in 0...bb.length
      b=bb[iq]
      adv=@adventurers.map{|q| q}
      drg=@dragons.map{|q| q}
      wrm=@wyrmprints.map{|q| q}
      unless b[1]=='-' || b[1][0]=='-'
        for i in 0...b[1].length
          a=adv.find_index{|q| q[0]==b[1][i].gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')}
          if b[1].length+b[2].length+b[3].length<=10
            b[1][i]="#{b[1][i]}#{adv_emoji(adv[a],bot)}" unless a.nil?
          elsif a.nil?
            b[1][i]="~~#{b[1][i]}~~"
          end
        end
      end
      unless b[2]=='-' || b[2][0]=='-'
        for i in 0...b[2].length
          a=drg.find_index{|q| q[0]==b[2][i].gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')}
          if b[1].length+b[2].length+b[3].length<=10
            b[2][i]="#{b[2][i]}#{dragon_emoji(drg[a],bot)}" unless a.nil?
          elsif a.nil?
            b[2][i]="~~#{b[2][i]}~~"
          end
        end
      end
      unless b[3]=='-' || b[3][0]=='-'
        for i in 0...b[3].length
          a=wrm.find_index{|q| q[0]==b[3][i].gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')}
          if b[1].length+b[2].length+b[3].length<=10
            b[3][i]="#{b[3][i]}#{print_emoji(wrm[a],bot)}" unless a.nil?
          elsif a.nil?
            b[3][i]="~~#{b[3][i]}~~"
          end
        end
      end
      f=[]
      f.push(['Adventurers',b[1].join("\n")]) unless b[1]=='-' || b[1][0]=='-'
      f.push(['Dragons',b[2].join("\n")]) unless b[2]=='-' || b[2][0]=='-'
      f.push(['Wyrmprints',b[3].join("\n")]) unless b[3]=='-' || b[3][0]=='-'
      f=nil if f.length<=0
      if b[4].length>1 && !b[4][1].nil?
        t2=b[4][1].split('/').map{|q| q.to_i}
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
      else
        str2=''
      end
      ftr=nil
      ftr="Associated Facility: #{b[6]}" unless b[6].nil? || b[6].length<=0
      xcolor=0xCE456B
      xcolor=element_color(b[5][0]) if ['Flame','Water','Wind','Light','Shadow'].include?(b[5][0])
      xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/SummonBanners/#{b[0].gsub(' ','_').gsub(':','')}.png"
      create_embed(event,"#{msg}__**#{b[0]}**__#{str2}",'',xcolor,ftr,[nil,xpic],f) unless !safe_to_spam?(event) && iq>0
    end
  end
  return nil
end

def old_banner(bot,event,args=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  data_load()
  b=find_data_ex(:find_banner,args.join(' '),event)
  if b.length<=0
    event.respond "No matches found."
  else
    adv=@adventurers.map{|q| q}
    drg=@dragons.map{|q| q}
    wrm=@wyrmprints.map{|q| q}
    unless b[1]=='-' || b[1][0]=='-'
      for i in 0...b[1].length
        a=adv.find_index{|q| q[0]==b[1][i].gsub('*','')}
        if b[1].length+b[2].length+b[3].length<=12
          b[1][i]="#{b[1][i]}#{adv_emoji(adv[a],bot)}" unless a.nil?
        elsif a.nil?
          b[1][i]="~~#{b[1][i]}~~"
        end
      end
    end
    unless b[2]=='-' || b[2][0]=='-'
      for i in 0...b[2].length
        a=drg.find_index{|q| q[0]==b[2][i].gsub('*','')}
        if b[1].length+b[2].length+b[3].length<=12
          b[2][i]="#{b[2][i]}#{dragon_emoji(drg[a],bot)}" unless a.nil?
        elsif a.nil?
          b[2][i]="~~#{b[2][i]}~~"
        end
      end
    end
    unless b[3]=='-' || b[3][0]=='-'
      for i in 0...b[3].length
        a=wrm.find_index{|q| q[0]==b[3][i].gsub('*','')}
        if b[1].length+b[2].length+b[3].length<=12
          b[3][i]="#{b[3][i]}#{print_emoji(wrm[a],bot)}" unless a.nil?
        elsif a.nil?
          b[3][i]="~~#{b[3][i]}~~"
        end
      end
    end
    f=[]
    f.push(['Adventurers',b[1].join("\n")]) unless b[1]=='-' || b[1][0]=='-'
    f.push(['Dragons',b[2].join("\n")]) unless b[2]=='-' || b[2][0]=='-'
    f.push(['Wyrmprints',b[3].join("\n")]) unless b[3]=='-' || b[3][0]=='-'
    ftr=nil
    ftr="Associated Facility: #{b[6]}" unless b[6].nil? || b[6].length<=0
    xcolor=0xCE456B
    xcolor=element_color(b[5][0]) if ['Flame','Water','Wind','Light','Shadow'].include?(b[5][0])
    kk=b[4].map{|q| q.split('/')}.map{|q| "#{q[0]} #{['','Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'][q[1].to_i]} #{q[2]}"}
    disp=''
    disp="**Real-world date:** #{kk[0]} - #{kk[1]}\n(assuming reset is at midnight)" if disp
    xpic="https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/SummonBanners/#{b[0].gsub(' ','_').gsub(':','')}.png"
    create_embed(event,"__**#{b[0]}**__",disp,xcolor,ftr,[nil,xpic],f)
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
  k=find_data_ex(:find_adventurer,args.join(' '),event,true)
  if k.length.zero?
    k=find_data_ex(:find_dragon,args.join(' '),event,true)
    if k.length.zero?
      k=find_data_ex(:find_wyrmprint,args.join(' '),event,true)
      if k.length.zero?
        k=find_data_ex(:find_banner,args.join(' '),event,true)
        if k.length.zero?
          k=find_data_ex(:find_adventurer,args.join(' '),event)
          if k.length.zero?
            k=find_data_ex(:find_dragon,args.join(' '),event)
            if k.length.zero?
              k=find_data_ex(:find_wyrmprint,args.join(' '),event)
              if k.length.zero?
                k=find_data_ex(:find_banner,args.join(' '),event)
                if k.length.zero?
                  current_banner(bot,event,args,"No matches found.  Showing current banner instead.\n\n")
                else
                  old_banner(bot,event)
                end
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
          old_banner(bot,event)
          return nil
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
  bnr=[]
  bbb=@banners.map{|q| q}
  bnr.push("*Launch #{p[1]}*") if bbb[0][p[0]].include?(k[0])
  for i in 1...bbb.length
    if bbb[i][p[0]].map{|q| q.gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')}.include?(k[0])
      str="#{'*Banner Name:* ' if s2s}#{bbb[i][0]}"
      kk=bbb[i][4].map{|q| q.split('/')}.map{|q| "#{q[0]}#{['','Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'][q[1].to_i]}#{q[2]}"}
      if s2s || (i==1 && bnr.length<=0)
        str="#{str}\n*Real-world date:* #{kk[0]} - #{kk[1]}"
        str="#{str}\n<:Wyrmsigil:759937956672045066> *#{k[0]} is sparkable*" unless bbb[i][p[0]].map{|q| q.gsub('*','')}.include?(k[0])
        str="#{str}\n*Focus Adventurers:* #{bbb[i][1].reject{|q| q.gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')==k[0]}.map{|q| q.gsub('*','')}.sort.join(', ')}" unless bbb[i][1]==['-'] || bbb[i][1].reject{|q| q.gsub('*','')==k[0]}.length<=0
        str="#{str}\n*Focus Dragons:* #{bbb[i][2].reject{|q| q.gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')==k[0]}.map{|q| q.gsub('*','')}.sort.join(', ')}" unless bbb[i][2]==['-'] || bbb[i][2].reject{|q| q.gsub('*','')==k[0]}.length<=0
        str="#{str}\n*Focus Wyrmprints:* #{bbb[i][3].reject{|q| q.gsub('*','').gsub(' <:Wyrmsigil:759937956672045066>','').gsub('<:Wyrmsigil:759937956672045066>','')==k[0]}.map{|q| q.gsub('*','')}.sort.join(', ')}" unless bbb[i][3]==['-'] || bbb[i][3].reject{|q| q.gsub('*','')==k[0]}.length<=0
        str="#{str}\n*Associated Facility:* #{bbb[i][6]}" unless bbb[i][6].nil? || bbb[i][6].length<=0
      else
        str="*#{str}*  (#{kk[0]}-#{kk[1]})"
      end
      bnr.push(str)
    end
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
  if "__**#{k[0]}**'s Banners__".length+bnr.join("#{"\n" if s2s}\n").length>=1900
    str="__**#{k[0]}**'s Banners__"
    for i in 0...bnr.length
      str=extend_message(str,bnr[i],event,2) if s2s
      str=extend_message(str,bnr[i],event) unless s2s
    end
    event.respond str
  else
    create_embed(event,"__**#{k[0]}**'s Banners__",bnr.join("#{"\n" if s2s}\n"),xcolor,'All banners display dates as if reset is at midnight.',xpic)
  end
end

def disp_sp_table(bot,event,args=nil)
  reload_library()
  return sp_table(bot,event,args)
end

def disp_damage_modifiers(bot,event,args=nil)
  reload_library()
  return damage_modifiers(bot,event,args)
end

def find_in_adventurers(bot,event,args=nil,mode=0,allowstr=0)
  reload_library()
  return find_the_adventure(bot,event,args,mode,allowstr)
end

def find_in_dragons(bot,event,args=nil,mode=0,allowstr=true)
  reload_library()
  return find_the_dragon(bot,event,args,mode,allowstr)
end

def find_in_wyrmprints(bot,event,args=nil,mode=0,allowstr=true)
  reload_library()
  return find_the_printer(bot,event,args,mode,allowstr)
end

def find_in_weapons(bot,event,args=nil,mode=0,allowstr=true,juststats=false)
  reload_library()
  return find_the_stick(bot,event,args,mode,allowstr,juststats)
end

def find_in_mats(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  rarity=[]
  pouch=[]
  tags=[]
  lookout=get_lookout_tags().reject{|q| q[2]!='Mat'}
  for i in 0...args.length
    rarity.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>1 && args[i].to_i<6
    rarity.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>1 && args[i][0,1].to_i<6
    pouch.push(args[i].to_i) if args[i].to_i.to_s==args[i] && args[i].to_i>=0 && args[i].to_i<2
    pouch.push(args[i][0,1].to_i) if args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>=0 && args[i][0,1].to_i<2
    pouch.push(0) if ['common','commons'].include?(args[i])
    pouch.push(1) if ['rare','rares'].include?(args[i])
    pouch.push(2) if ['legend','legendary','legends','legendarys','legendaries'].include?(args[i])
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
    search.push("*Rarities*: #{rarity.map{|q| "#{q}#{@rarity_stars[0][q]}"}.join(', ')}")
  end
  if pouch.length>0
    char=char.reject{|q| !pouch.include?(q[6].to_i)}.uniq
    search.push("*Pouch Rarities*: #{pouch.map{|q| "#{['<:Pouch_1:622140100679303189> Common','<:Pouch_2:622140100960190475> Rare','<:Pouch_3:622140100888756237> Legendary'][q]}"}.join(', ')}")
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
        char=char.reject{|q| q[8].nil? || !q[8].include?(tags[i])}.uniq
      end
    end
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length+textra.length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,textra,char]
  end
end

def find_in_banners(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  elem=[]
  tags=[]
  lookout=get_lookout_tags().reject{|q| q[2]!='Banner'}
  for i in 0...args.length
    elem.push('Flame') if ['flame','fire','flames','fires'].include?(args[i].downcase)
    elem.push('Water') if ['water','waters'].include?(args[i].downcase)
    elem.push('Wind') if ['wind','air','winds','airs'].include?(args[i].downcase)
    elem.push('Wind') if ['earth','earths'].include?(args[i].downcase) && event.user.id==192821228468305920
    elem.push('Light') if ['light','lights'].include?(args[i].downcase)
    elem.push('Shadow') if ['shadow','dark','shadows','darks'].include?(args[i].downcase)
    elem.push('None') if ['none','no-element','no_element','noelement','elementless'].include?(args[i].downcase)
    for i2 in 0...lookout.length
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  elem.uniq!
  tags.uniq!
  emo=[]
  search=[]
  char=@banners.map{|q| q}
  if elem.length>0
    char=char.reject{|q| !has_any?(elem,q[5])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if tags.length>0
    char=char.reject{|q| !has_any?(tags,q[5])}.uniq
    search.push("*Tags*: #{tags.join(', ')}")
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,'',char]
  end
end

def find_in_skills(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  elem=[]
  wpn2=[]
  tags=[]
  lookout=get_lookout_tags().reject{|q| q[2]!='Askillity'}
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
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  elem.uniq!
  wpn2.uniq!
  tags.uniq!
  emo=[]
  search=[]
  char=@askilities.reject{|q| q[2]!='Skill'}
  adv=@adventurers.map{|q| q}
  drg=@dragons.map{|q| q}
  wpn=@weapons.map{|q| q}
  textra=''
  if elem.length>0
    for i in 0...char.length
      m=adv.find_index{|q| q[6].include?(char[i][0])}
      char[i][10].push(adv[m][2][1]) unless m.nil?
      m=drg.find_index{|q| q[5]==char[i][0]}
      char[i][10].push(drg[m][2]) unless m.nil?
      m=wpn.find_index{|q| q[6]==char[i][0]}
      char[i][10].push(wpn[m][3]) unless m.nil?
    end
    char=char.reject{|q| !has_any?(elem,q[10])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if wpn2.length>0
    for i in 0...char.length
      m=adv.find_index{|q| q[6].include?(char[i][0])}
      char[i][10].push(adv[m][2][2]) unless m.nil?
      m=wpn.find_index{|q| q[6]==char[i][0]}
      char[i][10].push(wpn[m][1]) unless m.nil?
    end
    char=char.reject{|q| !has_any?(wpn2,q[10])}.uniq
    for i in 0...wpn2.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn2[i]}"}
      emo.push(moji[0].mention) if wpn2.length<2 && moji.length>0
      wpn2[i]="#{moji[0].mention}#{wpn2[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn2.join(', ')}")
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
    if tags.include?('Cleanse') && tags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...@cleaning.length
        if tags.include?(@cleaning[i][0]) && !tags.include?(@cleaning[i][1])
          tags.push("#{@cleaning[i][1]}")
          tags2.push("#{@cleaning[i][0]}")
        end
      end
      if tags2.length>0
        tags=tags.reject{|q| tags2.include?(q) || q=='Cleanse'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Cleanse tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Cleanse tag, remove #{mm}.\nTo search for just #{mm}, remove the Cleanse tag."
      end
    end
    search.push("*Tags*: #{tags.join(', ')}")
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for skills with any listed tag)" if tags.length>1
      char=char.reject{|q| !has_any?(tags,q[10])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for skills with all listed tags)" if tags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for skills with all listed tags.\nTo search for skills with any of the listed tags, perform the search again with the word \"any\" in your message." if tags.length>1
      for i in 0...tags.length
        char=char.reject{|q| q[10].nil? || !q[10].include?(tags[i])}.uniq
      end
    end
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,textra,char]
  end
end

def find_in_abilities(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  elem=[]
  wpn=[]
  tags=[]
  abiltypes=[]
  lookout=get_lookout_tags().reject{|q| q[2]!='Askillity'}
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
      tags.push(lookout[i2][0]) if lookout[i2][1].include?(args[i])
    end
  end
  elem.uniq!
  wpn.uniq!
  abiltypes.uniq!
  tags.uniq!
  emo=[]
  search=[]
  char=@askilities.reject{|q| q[2]=='Skill'}
  textra=''
  if elem.length>0
    char=char.reject{|q| !has_any?(elem,q[6])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if wpn.length>0
    char=char.reject{|q| !has_any?(wpn,q[6])}.uniq
    for i in 0...wpn.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{wpn[i]}"}
      emo.push(moji[0].mention) if wpn.length<2 && moji.length>0
      wpn[i]="#{moji[0].mention}#{wpn[i]}" if moji.length>0
    end
    search.push("*Weapon*: #{wpn.join(', ')}")
  end
  if abiltypes.length>0
    char=char.reject{|q| !abiltypes.include?(q[2])}.uniq
    search.push("*Categories*: #{abiltypes.join(', ')}")
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
    if tags.include?('Cleanse') && tags.length>1 && !args.include?('any')
      tags2=[]
      for i in 0...@cleaning.length
        if tags.include?(@cleaning[i][0]) && !tags.include?(@cleaning[i][1])
          tags.push("#{@cleaning[i][1]}")
          tags2.push("#{@cleaning[i][0]}")
        end
      end
      if tags2.length>0
        tags=tags.reject{|q| tags2.include?(q) || q=='Punisher'}
        mm='those tags'
        mm="the #{tags2[0]} tag" if tags2.length<2
        textra="#{textra}\n\nThe Cleanse tag is being hybridized with the #{list_lift(tags2,'and')} tag#{'s' if tags2.length>1}.\nTo search for just the Cleanse tag, remove #{mm}.\nTo search for just #{mm}, remove the Cleanse tag."
      end
    end
    search.push("*Tags*: #{tags.join(', ')}")
    if args.include?('any')
      search[-1]="#{search[-1]}\n(searching for abilities with any listed tag)" if tags.length>1
      char=char.reject{|q| !has_any?(tags,q[6])}.uniq
    else
      search[-1]="#{search[-1]}\n(searching for abilities with all listed tags)" if tags.length>1
      textra="#{textra}\n\nTags searching defaults to searching for abilities with all listed tags.\nTo search for abilities with any of the listed tags, perform the search again with the word \"any\" in your message." if tags.length>1
      for i in 0...tags.length
        char=char.reject{|q| q[6].nil? || !q[6].include?(tags[i])}.uniq
      end
    end
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,textra,char]
  end
end

def find_in_enemies(bot,event,args=nil,mode=0)
  data_load()
  args=normalize(event.message.text.downcase).gsub(',','').split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
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
  char=@enemies.reject{|q| q[0]=='Matilda'}
  textra=''
  if elem.length>0
    char=char.reject{|q| !elem.include?(q[2][0])}.uniq
    for i in 0...elem.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{elem[i].gsub('None','Null')}"}
      emo.push(moji[0].mention) if elem.length<2 && moji.length>0
      elem[i]="#{moji[0].mention}#{elem[i]}" if moji.length>0
    end
    search.push("*Elements*: #{elem.join(', ')}")
  end
  if tribes.length>0
    char=char.reject{|q| !tribes.include?(q[2][1])}.uniq
    for i in 0...tribes.length
      moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{tribes[i]}"}
      emo.push(moji[0].mention) if tribes.length<2 && moji.length>0
      tribes[i]="#{moji[0].mention}#{tribes[i]}" if moji.length>0
    end
    search.push("*Tribes*: #{tribes.join(', ')}")
  end
  if (char.length>50 || char.map{|q| q[0]}.join("\n").length+search.join("\n").length>=1900) && !safe_to_spam?(event) && mode<2
    event.respond "__**Search**__\n#{search.join("\n")}\n\n__**Note**__\nAt #{char.length} entries, too much data is trying to be displayed.  Please use this command in PM." if mode==0
    return nil
  else
    return [search,textra,char]
  end
end

def find_in_facilities(bot,event,args=nil,mode=0,allowstr=true)
  reload_library()
  return find_the_faculty(bot,event,args,mode,allowstr)
end

def find_adventurers(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_adventurers(bot,event,args)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a[0].gsub('*','')<=>b[0].gsub('*','')}
  textra=k[3]
  flds=nil
  unless char.length<=0
    flds=triple_finish(char.map{|q| q[0]}.uniq)
    if char.map{|q| q[2][1]}.uniq.length>1
      flds=[]
      flds.push(['<:Element_Flame:532106087952810005>Flame',char.reject{|q| q[2][1]!='Flame'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Water:532106088221376522>Water',char.reject{|q| q[2][1]!='Water'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Wind:532106087948746763>Wind',char.reject{|q| q[2][1]!='Wind'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Light:532106088129101834>Light',char.reject{|q| q[2][1]!='Light'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Shadow:532106088154267658>Shadow',char.reject{|q| q[2][1]!='Shadow'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Null',char.reject{|q| ['Flame','Water','Wind','Light','Shadow'].include?(q[2][1])}.map{|q| q[0]}.uniq.join("\n")])
    elsif char.map{|q| q[2][2]}.uniq.length>1
      flds=[]
      flds.push(['<:Weapon_Sword:532106114540634113>Sword',char.reject{|q| q[2][2]!='Sword'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Blade:532106114628714496>Blade',char.reject{|q| q[2][2]!='Blade'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Dagger:532106116025286656>Dagger',char.reject{|q| q[2][2]!='Dagger'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Axe:532106114188443659>Axe',char.reject{|q| q[2][2]!='Axe'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Bow:532106114909732864>Bow',char.reject{|q| q[2][2]!='Bow'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Lance:532106114792423448>Lance',char.reject{|q| q[2][2]!='Lance'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Wand:532106114985099264>Wand',char.reject{|q| q[2][2]!='Wand'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Staff:532106114733441024>Staff',char.reject{|q| q[2][2]!='Staff'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Manacaster:758905122448867338>Manacaster',char.reject{|q| q[2][2]!='Manacaster'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Other',char.reject{|q| ['Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff','Manacaster'].include?(q[2][2])}.map{|q| q[0]}.uniq.join("\n")])
    elsif char.map{|q| q[1][0,1]}.uniq.length>1
      flds=[]
      mrar=[]
      for i in 0...@max_rarity[0]+1
        flds.push([generate_rarity_row(i,@max_rarity[0],'',true),char.reject{|q| q[1][0,1]!=i.to_s}.map{|q| q[0]}.uniq.join("\n")])
        mrar.push(i.to_s)
      end
      flds.push(['Unknown rarity',char.reject{|q| mrar.include?(q[1][0,1])}.map{|q| q[0]}.uniq.join("\n")])
    elsif char.map{|q| q[2][0]}.uniq.length>1
      flds=[]
      flds.push(['<:Type_Attack:532107867520630784>Attack',char.reject{|q| q[2][0]!='Attack'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Type_Defense:532107867264909314>Defense',char.reject{|q| q[2][0]!='Defense'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Type_Support:532107867575156747>Support',char.reject{|q| q[2][0]!='Support'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Type_Healing:532107867348533249>Healing',char.reject{|q| q[2][0]!='Healing'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Other',char.reject{|q| ['Attack','Defense','Support','Healing'].include?(q[2][0])}.map{|q| q[0]}.uniq.join("\n")])
    end
    flds=flds.reject{|q| q[1].length<=0}
  end
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.map{|q| q[0]}.uniq.join("\n").length+search.join("\n").length>=1900
    str="__**Adventurer Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i][0],event)
    end
    str=extend_message(str,"#{char.length} total#{", #{char.reject{|q| q[0].include?('*')}.length} available to players" unless char.reject{|q| !q[0].gsub('*[','').gsub(']*','').include?('*')}.length<=0}",event,2)
    event.respond str
  else
    textra="**No adventurers match your search**" if char.length<=0
    create_embed(event,"__**Adventurer Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total#{", #{char.reject{|q| q[0].gsub('*[','').gsub(']*','').include?('*')}.length} available to players" unless char.reject{|q| !q[0].include?('*')}.length<=0}",nil,flds)
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
  char=char.sort{|a,b| a[0]<=>b[0]}
  textra=k[3]
  flds=nil
  unless char.length<=0
    flds=triple_finish(char.map{|q| q[0]}.uniq)
    if char.map{|q| q[2]}.uniq.length>1
      flds=[]
      flds.push(['<:Element_Flame:532106087952810005>Flame',char.reject{|q| q[2]!='Flame'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Water:532106088221376522>Water',char.reject{|q| q[2]!='Water'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Wind:532106087948746763>Wind',char.reject{|q| q[2]!='Wind'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Light:532106088129101834>Light',char.reject{|q| q[2]!='Light'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Shadow:532106088154267658>Shadow',char.reject{|q| q[2]!='Shadow'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Null',char.reject{|q| ['Flame','Water','Wind','Light','Shadow'].include?(q[2])}.map{|q| q[0]}.uniq.join("\n")])
    elsif char.map{|q| q[1][0,1]}.uniq.length>1
      flds=[]
      mrar=[]
      for i in 0...@max_rarity[1]+1
        flds.push([generate_rarity_row(i,0,'',true),char.reject{|q| q[1][0,1]!=i.to_s}.map{|q| q[0]}.uniq.join("\n")])
        mrar.push(i.to_s)
      end
      flds.push(['Unknown rarity',char.reject{|q| mrar.include?(q[1][0,1])}.map{|q| q[0]}.uniq.join("\n")])
    end
    flds=flds.reject{|q| q[1].length<=0}
  end
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.map{|q| q[0]}.uniq.join("\n").length+search.join("\n").length>=1900
    str="__**Dragon Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i][0],event)
    end
    str=extend_message(str,"#{char.length} total#{", #{char.reject{|q| q[0].include?('*')}.length} available to players" unless char.reject{|q| !q[0].gsub('*[','').gsub(']*','').include?('*')}.length<=0}",event,2)
    event.respond str
  else
    textra="**No dragons match your search**" if char.length<=0
    create_embed(event,"__**Dragon Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total#{", #{char.reject{|q| q[0].gsub('*[','').gsub(']*','').include?('*')}.length} available to players" unless char.reject{|q| !q[0].include?('*')}.length<=0}",nil,flds)
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
  char=char.sort{|a,b| a[0]<=>b[0]}
  textra=k[3]
  flds=nil
  unless char.length<=0
    flds=triple_finish(char.map{|q| q[0]}.uniq)
    if char.map{|q| q[1][0,1]}.uniq.length>1
      flds=[]
      mrar=[]
      for i in 0...@max_rarity[2]+1
        flds.push([generate_rarity_row(i,0,'',true),char.reject{|q| q[1][0,1]!=i.to_s}.map{|q| q[0]}.uniq.join("\n")])
        mrar.push(i.to_s)
      end
      flds.push(['Unknown rarity',char.reject{|q| mrar.include?(q[1][0,1])}.map{|q| q[0]}.uniq.join("\n")])
    elsif char.map{|q| q[2]}.uniq.length>1
      flds=[]
      flds.push(['<:Type_Attack:532107867520630784>Attack',char.reject{|q| q[2]!='Attack'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Type_Defense:532107867264909314>Defense',char.reject{|q| q[2]!='Defense'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Type_Support:532107867575156747>Support',char.reject{|q| q[2]!='Support'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Type_Healing:532107867348533249>Healing',char.reject{|q| q[2]!='Healing'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Other',char.reject{|q| ['Attack','Defense','Support','Healing'].include?(q[2])}.map{|q| q[0]}.uniq.join("\n")])
    end
    flds=flds.reject{|q| q[1].length<=0}
  end
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.map{|q| q[0]}.uniq.join("\n").length+search.join("\n").length>=1900
    str="__**Wyrmprint Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i][0],event)
    end
    str=extend_message(str,"#{char.length} total#{", #{char.reject{|q| q[0].include?('*')}.length} available to players" unless char.reject{|q| !q[0].gsub('*[','').gsub(']*','').include?('*')}.length<=0}",event,2)
    event.respond str
  else
    textra="**No wyrmprints match your search**" if char.length<=0
    create_embed(event,"__**Wyrmprint Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total#{", #{char.reject{|q| q[0].gsub('*[','').gsub(']*','').include?('*')}.length} available to players" unless char.reject{|q| !q[0].include?('*')}.length<=0}",nil,flds)
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
  char=char.sort{|a,b| a[0]<=>b[0]}
  textra=k[3]
  flds=nil
  unless char.length<=0
    flds=triple_finish(char.map{|q| q[0]}.uniq)
    if char.map{|q| q[1]}.uniq.length>1
      flds=[]
      flds.push(['<:Weapon_Sword:532106114540634113>Sword',char.reject{|q| q[1]!='Sword'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Blade:532106114628714496>Blade',char.reject{|q| q[1]!='Blade'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Dagger:532106116025286656>Dagger',char.reject{|q| q[1]!='Dagger'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Axe:532106114188443659>Axe',char.reject{|q| q[1]!='Axe'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Bow:532106114909732864>Bow',char.reject{|q| q[1]!='Bow'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Lance:532106114792423448>Lance',char.reject{|q| q[1]!='Lance'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Wand:532106114985099264>Wand',char.reject{|q| q[1]!='Wand'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Staff:532106114733441024>Staff',char.reject{|q| q[1]!='Staff'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Weapon_Manacaster:758905122448867338>Manacaster',char.reject{|q| q[1]!='Manacaster'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Other',char.reject{|q| ['Sword','Blade','Dagger','Axe','Bow','Lance','Wand','Staff','Manacaster'].include?(q[1])}.map{|q| q[0]}.uniq.join("\n")])
    elsif char.map{|q| q[3]}.uniq.length>1
      flds=[]
      flds.push(['<:Element_Flame:532106087952810005>Flame',char.reject{|q| q[3]!='Flame'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Water:532106088221376522>Water',char.reject{|q| q[3]!='Water'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Wind:532106087948746763>Wind',char.reject{|q| q[3]!='Wind'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Light:532106088129101834>Light',char.reject{|q| q[3]!='Light'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Shadow:532106088154267658>Shadow',char.reject{|q| q[3]!='Shadow'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Null',char.reject{|q| ['Flame','Water','Wind','Light','Shadow'].include?(q[3])}.map{|q| q[0]}.uniq.join("\n")])
    elsif char.map{|q| q[2][0,1]}.uniq.length>1
      flds=[]
      mrar=[]
      for i in 0...@max_rarity[3]+1
        flds.push([generate_rarity_row(i,0,'',true),char.reject{|q| q[1][0,1]!=i.to_s}.map{|q| q[0]}.uniq.join("\n")])
        mrar.push(i.to_s)
      end
      flds.push(['Unknown rarity',char.reject{|q| mrar.include?(q[1][0,1])}.map{|q| q[0]}.uniq.join("\n")])
    elsif char.map{|q| q[16]}.uniq.length>1
      flds=[]
      flds.push(['Tier 0 weapons',char.reject{|q| q[16]!=0}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['Tier 1 weapons',char.reject{|q| q[16]!=1}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['Tier 2 weapons',char.reject{|q| q[16]!=2}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['Tier 3 weapons',char.reject{|q| q[16]!=3}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['Unknown tier',char.reject{|q| [0,1,2,3].include?(q[16])}.map{|q| q[0]}.uniq.join("\n")])
    end
    flds=flds.reject{|q| q[1].length<=0}
  end
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.map{|q| q[0]}.uniq.join("\n").length+search.join("\n").length>=1900
    str="__**Weapon Search**__\n#{search.join("\n")}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i][0],event)
    end
    str=extend_message(str,"#{char.length} total#{", #{char.reject{|q| q[0].include?('*')}.length} available to players" unless char.reject{|q| !q[0].gsub('*[','').gsub(']*','').include?('*')}.length<=0}",event,2)
    event.respond str
  else
    textra="**No weapons match your search**" if char.length<=0
    create_embed(event,"__**Weapons Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total#{", #{char.reject{|q| q[0].gsub('*[','').gsub(']*','').include?('*')}.length} available to players" unless char.reject{|q| !q[0].include?('*')}.length<=0}",nil,flds)
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

def find_banners(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_banners(bot,event,args)
  return nil if k.nil?
  search=k[0]
  textra=k[1]
  char=k[2]
  for i in 0...char.length
    char[i][4]=char[i][4].map{|q| q.split('/')}.map{|q| "#{q[0]}#{['','Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'][q[1].to_i]}#{q[2]}"} unless char[i][4].nil?
  end
  char=char.map{|q| "#{q[0]}#{" (#{q[4].join(' - ')})" unless q[4].nil? || q[4].length<=0 || q[4]=='-'}"}.uniq
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length>=1900
    str="__**Banner Search**__\n#{search.join("\n")}#{"\n\n__**Notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    textra="#{textra}\n\n**No banners match your search**" if char.length<=0
    create_embed(event,"__**Banner Search**__\n#{search.join("\n")}\n\n__**Results**__","#{textra}\n\n#{char.join("\n")}",0xCE456B,"#{char.length} total")
  end
end

def find_skills(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_skills(bot,event,args)
  return nil if k.nil?
  search=k[0]
  textra=k[1]
  char=k[2]
  char=char.sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  #puts k.map{|q| q.to_s}
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length>=1900
    str="__**Skill Search**__\n#{search.join("\n")}#{"\n\n__**Notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    flds=nil
    flds=triple_finish(char) unless char.length<=0
    textra="#{textra}\n\n**No skills match your search**" if char.length<=0
    create_embed(event,"__**Skill Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

def find_abilities(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_abilities(bot,event,args)
  return nil if k.nil?
  search=k[0]
  textra=k[1]
  char=k[2]
  subchar=char.map{|q| [q[0],q[2]]}.uniq
  m=char.map{|q| q}
  char=[]
  for i in 0...subchar.length
    k=m.reject{|q| q[1]=='example' || q[0]!=subchar[i][0] || q[2]!=subchar[i][1]}
    ccc='/'
    ccc=', ' unless k.find_index{|q| q[1].include?('/')}.nil?
    if k.length>3
      ccc=' -> '
      k=[k[0],k[k.length-1]]
    end
    name="#{k[0][0]} #{'+' if k[0][1].include?('%')}#{k.map{|q| q[1]}.join(ccc)}"
    name="#{k.map{|q| q[1]}.join(ccc)} #{k[0][0]}" if k[0][0][0,7]=='Hits = '
    name="#{k[0][0]}"
    char.push([name,k[0][2]])
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
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || f+search.join("\n").length>=1500
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

def find_enemies(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_enemies(bot,event,args)
  return nil if k.nil?
  search=k[0]
  textra=k[1]
  char=k[2]
  char=char.sort{|a,b| a[0]<=>b[0]}.uniq
  flds=nil
  unless char.length<=0
    flds=triple_finish(char.map{|q| q[0]},true)
    if char.map{|q| q[2][0]}.uniq.length>1
      flds=[]
      flds.push(['<:Element_Flame:532106087952810005>Flame',char.reject{|q| q[2][0]!='Flame'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Water:532106088221376522>Water',char.reject{|q| q[2][0]!='Water'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Wind:532106087948746763>Wind',char.reject{|q| q[2][0]!='Wind'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Light:532106088129101834>Light',char.reject{|q| q[2][0]!='Light'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Shadow:532106088154267658>Shadow',char.reject{|q| q[2][0]!='Shadow'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Null',char.reject{|q| ['Flame','Water','Wind','Light','Shadow'].include?(q[2][0])}.map{|q| q[0]}.uniq.join("\n")])
    elsif char.map{|q| q[2][1]}.uniq.length>1
      flds=[]
      flds.push(['<:Tribe_Thaumian:549698154602168322>Thaumian',char.reject{|q| q[2][1]!='Thaumian'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Tribe_Physian:549698154707288085>Physian',char.reject{|q| q[2][1]!='Physian'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Tribe_Therion:549702939309113354>Therion',char.reject{|q| q[2][1]!='Therion'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Tribe_Dragon:549947361745567754>Dragon',char.reject{|q| q[2][1]!='Dragon'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Tribe_Demon:549716599788011521>Demon',char.reject{|q| q[2][1]!='Demon'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Tribe_Demihuman:584222665376792586>Demihuman',char.reject{|q| q[2][1]!='Demihuman'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Tribe_Human:573588507331657766>Human',char.reject{|q| q[2][1]!='Human'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Tribe_Undead:550712824230313985>Undead',char.reject{|q| q[2][1]!='Undead'}.map{|q| q[0]}.uniq.join("\n")])
      flds.push(['<:Element_Null:532106087810334741>Null',char.reject{|q| ['Thaumian','Physian','Therion','Dragon','Demon','Demihuman','Human','Undead'].include?(q[2][1])}.map{|q| q[0]}.uniq.join("\n")])
    end
    flds=flds.reject{|q| q[1].length<=0}
  end
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.map{|q| q[0]}.join("\n").length+search.join("\n").length>=1900
    str="__**Enemy Search**__\n#{search.join("\n")}#{"\n\n__**Notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i][0],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    textra="#{textra}\n\n**No materials/items match your search**" if char.length<=0
    create_embed(event,"__**Enemy Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

def find_facilities(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_facilities(bot,event,args)
  return nil if k.nil? || k.is_a?(String)
  search=k[0]
  char=k[1]
  textra=k[3]
  char=char.sort{|a,b| a[0]<=>b[0]}.map{|q| q[0]}.uniq
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || char.join("\n").length+search.join("\n").length>=1900
    str="__**Facility Search**__\n#{search.join("\n")}#{"\n\n__**Notes**__\n#{textra}" if textra.length>0}\n\n__**Results**__"
    for i in 0...char.length
      str=extend_message(str,char[i],event)
    end
    str=extend_message(str,"#{char.length} total",event,2)
    event.respond str
  else
    flds=nil
    flds=triple_finish(char) unless char.length<=0
    textra="#{textra}\n\n**No facilities match your search**" if char.length<=0
    create_embed(event,"__**Facilities Search**__\n#{search.join("\n")}\n\n__**Results**__",textra,0xCE456B,"#{char.length} total",nil,flds)
  end
end

def find_all(bot,event,args=nil)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  adv=find_in_adventurers(bot,event,args,2)
  drg=find_in_dragons(bot,event,args,2)
  wrm=find_in_wyrmprints(bot,event,args,2)
  wpn=find_in_weapons(bot,event,args,2)
  adv=nil if !adv.nil? && adv[1].length>=@adventurers.length
  drg=nil if !drg.nil? && drg[1].length>=@dragons.reject{|q| q[0]=='Puppy'}.length
  wrm=nil if !wrm.nil? && wrm[1].length>=@wyrmprints.reject{|q| ['Wily Warriors','Greatwyrm'].include?(q[0])}.uniq.length
  wpn=nil if !wpn.nil? && wpn[1].length>=@weapons.length
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
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || str.length+adv[1].join("\n").length+drg[1].join("\n").length+wrm[1].join("\n").length+wpn[1].join("\n").length+"Totals: #{adv[1].length} adventurers, #{drg[1].length} dragons, #{wrm[4]} wyrmprints#{' (not shown)' if wrm[4]>wrm[1].length}, #{wpn[1].length} weapons".length+textra.length>=1800
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
      wrm[4]=@wyrmprints.reject{|q| ['Wily Warriors','Greatwyrm'].include?(q[0])}.uniq.length if wrm[0].length<=0 && wrm[1].length<=0 && search.length<=0
      wpn[1]=@weapons.uniq if wpn[0].length<=0 && wpn[1].length<=0
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

def sort_adventurers(bot,event,args=nil,mode=0)
  args=normalize(event.message.text.downcase).split(' ') if args.nil?
  args=args.map{|q| normalize(q.downcase)}
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) }
  k=find_in_adventurers(bot,event,args,2,1)
  return nil if k.nil?
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a[0].gsub('*','')<=>b[0].gsub('*','')}.uniq
  textra=k[3]
  srt=[1,1,1,1,1]
  srtt=0
  lvl=-1
  rar=-1
  for i in 0...args.length
    rar=args[i].to_i if rar<0 && args[i].to_i.to_s==args[i] && args[i].to_i>0 && args[i].to_i<@max_rarity[0]+1
    rar=args[i][0,1].to_i if rar<0 && args[i]=="#{args[i][0,1]}*" && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>0 && args[i][0,1].to_i<@max_rarity[0]+1
    rar=@max_rarity[0]+1 if ['base'].include?(args[i].downcase)
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
    end
  end
  textra="**No adventurers match your search**" if char.length<=0
  if lvl<0
    lvl=0
    if srt.reject{|q| q<3}.length>0
      if rar>@max_rarity[0]
        textra="#{textra}#{"\n\n" if textra.length>0}Sorting at default max level.\nIf you want to sort at absolute max stats, include the word \"max\" in your message."
      elsif rar==@max_rarity[0]
        textra="#{textra}#{"\n\n" if textra.length>0}Sorting at level #{30+10*rar} with no modifiers.\nIf you want to sort at absolute max stats, include the word \"max\" in your message."
      end
    end
  end
  if rar<0
    rar=@max_rarity[0]+1-lvl
    textra="#{textra}#{"\n\n" if textra.length>0}Sorting at each adventurer's default available rarity.\nIf you want to sort at a specific rarity, include that rarity in your message." unless rar==@max_rarity[0] || srt.reject{|q| q<3}.length<=0
  end
  srt[srtt]=0
  char=char.reject{|q| q[0][0,1]=='*'}
  char=char.reject{|q| q[1][0,1].to_i>rar} unless rar>@max_rarity[0] || args.map{|q| q.downcase}.include?('alladv')
  stats=['Name','','','HP','Strength','Defense','','Capacity']
  for i in 0...char.length
    m=rar-3
    m=char[i][1][0,1].to_i-3 if rar>@max_rarity[0]
    m+=lvl if m==2
    char[i][3]=char[i][3][1][m]
    char[i][4]=char[i][4][1][m]
    char[i][7]=char[i][5][1]
    char[i][7]=10 if char[i][5].length<=1
    char[i][5]=char[i][5][0]
    m2=[]
    for i2 in 0...srt.length
      unless srt[i2]<3
        if rar>@max_rarity[0] && m==3
          m2.push("#{char[i][srt[i2]]} max #{stats[srt[i2]]}")
        elsif rar>@max_rarity[0]
          m2.push("#{char[i][srt[i2]]} #{stats[srt[i2]]}")
        else
          m2.push("#{char[i][srt[i2]]} #{stats[srt[i2]]}")
        end
      end
    end
    char[i][6]="**#{char[i][0]}**#{adv_emoji(char[i],bot)}"
    char[i][6]="#{char[i][6]}#{" (Lv#{30+10*char[i][1][0,1].to_i})" if rar==6 && m != 3} - #{m2.join(', ')}" if m2.length>0
  end
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
  fpop=@rarity_stars[0][0,@max_rarity[0]+1]
  fpop[fpop.length-1]="#{fpop[fpop.length-1]}, absolute max stats" if lvl==1
  fpop.push('Default rarity')
  stats=['Name','','','<:HP:573344832307593216>HP','<:Strength:573344931205349376>Strength','<:Defense:573344832282689567>Defense','','<:SkillShare:714597012733034547>Skill Share capacity']
  disp="__**Adventurer Search**__\n#{search.join("\n")}#{"\n" unless search.length<=0}*Sorted By:* #{srt.map{|q| stats[q]}.reject{|q| q.length<=0}.join(', ')}\n*Sorted at:* #{rar unless rar>@max_rarity[0]}#{fpop[rar]}#{"\n#{@max_rarity[0]}#{@rarity_stars[0][@max_rarity[0]]}s will be shown with absolute max stats" if rar>@max_rarity[1] && lvl==1}"
  disp=extend_message(disp,"__**Notes**__\n#{textra}",event,2) if textra.length>0
  disp=extend_message(disp,"__**Results**__",event,2) if char.length>0
  for i in 0...char.length
    disp=extend_message(disp,char[i][6],event)
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
  char=char.sort{|a,b| a[0].gsub('*','')<=>b[0].gsub('*','')}.uniq
  textra=k[3]
  srt=[1,1,1,1]
  srtt=0
  for i in 0...args.length
    if ['hp','health'].include?(args[i].downcase) && !srt.include?(3)
      srt[srtt]=3
      srtt+=1
    elsif ['strength','str','atkstat','attstat','attackstat','statatk','statatt','statattack','statk','statt','stattack','statstr','attack','att','atk'].include?(args[i].downcase) && !srt.include?(4)
      srt[srtt]=4
      srtt+=1
    end
  end
  textra="**No dragons match your search**" if char.length<=0
  srt[srtt]=0
  char=char.reject{|q| q[0][0,1]=='*'}
  stats=['Name','','','HP','Strength']
  for i in 0...char.length
    char[i][3]=char[i][3][-1]
    char[i][4]=char[i][4][-1]
    m2=[]
    for i2 in 0...srt.length
      m2.push("#{char[i][srt[i2]]} #{stats[srt[i2]]}") unless srt[i2]<3
    end
    char[i][6]="**#{char[i][0]}**#{dragon_emoji(char[i],bot)}"
    char[i][6]="#{char[i][6]} - #{m2.join(', ')}" if m2.length>0
  end
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
  stats=['Name','','','<:HP:573344832307593216>HP','<:Strength:573344931205349376>Strength']
  disp="__**Dragon Search**__\n#{search.join("\n")}\n*Sorted By:* #{srt.map{|q| stats[q]}.reject{|q| q.length<=0}.join(', ')}"
  disp=extend_message(disp,"__**Notes**__\n#{textra}",event,2) if textra.length>0
  disp=extend_message(disp,"__**Results**__",event,2) if char.length>0
  for i in 0...char.length
    disp=extend_message(disp,char[i][6],event)
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
  char=char.sort{|a,b| a[0].gsub('*','')<=>b[0].gsub('*','')}.uniq
  textra=k[3]
  srt=[1,1,1,1]
  srtt=0
  for i in 0...args.length
    if ['hp','health'].include?(args[i].downcase) && !srt.include?(3)
      srt[srtt]=3
      srtt+=1
    elsif ['strength','str','atkstat','attstat','attackstat','statatk','statatt','statattack','statk','statt','stattack','statstr','attack','att','atk'].include?(args[i].downcase) && !srt.include?(4)
      srt[srtt]=4
      srtt+=1
    end
  end
  textra="**No wyrmprints match your search**" if char.length<=0
  srt[srtt]=0
  char=char.reject{|q| q[0][0,1]=='*'}
  stats=['Name','','','HP','Strength']
  for i in 0...char.length
    char[i][3]=char[i][3][2]
    char[i][4]=char[i][4][2]
    m2=[]
    for i2 in 0...srt.length
      m2.push("#{char[i][srt[i2]]} #{stats[srt[i2]]}") unless srt[i2]<3
    end
    char[i][6]="**#{char[i][0]}**#{print_emoji(char[i],bot)}"
    char[i][6]="#{char[i][6]} - #{m2.join(', ')}" if m2.length>0
  end
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
  stats=['Name','','','<:HP:573344832307593216>HP','<:Strength:573344931205349376>Strength']
  disp="__**Wyrmprint Search**__\n#{search.join("\n")}\n*Sorted By:* #{srt.map{|q| stats[q]}.reject{|q| q.length<=0}.join(', ')}"
  disp=extend_message(disp,"__**Notes**__\n#{textra}",event,2) if textra.length>0
  disp=extend_message(disp,"__**Results**__",event,2) if char.length>0
  for i in 0...char.length
    disp=extend_message(disp,char[i][6],event)
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
  char=char.sort{|a,b| a[0].gsub('*','')<=>b[0].gsub('*','')}.uniq
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
  char=char.reject{|q| q[0][0,1]=='*'}
  stats=['Name','','','','HP','Strength']
  for i in 0...char.length
    char[i][4]=char[i][4][x]
    char[i][5]=char[i][5][x]
    m2=[]
    for i2 in 0...srt.length
      m2.push("#{char[i][srt[i2]]} #{stats[srt[i2]]}") unless srt[i2]<3
    end
    char[i][6]="**#{char[i][0]}**#{weapon_emoji(char[i],bot)}"
    char[i][6]="#{char[i][6]} - #{m2.join(', ')}" if m2.length>0
  end
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
    disp=extend_message(disp,char[i][6],event)
  end
  event.respond disp
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
  return 10 if x=='Sticker'
  return 11 if x=='NPC'
  return 12 if x=='Status'
  return 1300
end

def add_new_alias(bot,event,newname=nil,unit=nil,modifier=nil,modifier2=nil,mode=0)
  reload_library()
  return add_a_new_alias(bot,event,newname,unit,modifier,modifier2,mode)
end

def disp_aliases(bot,event,args=nil,mode=0)
  reload_library()
  return disp_alias_list(bot,event,args,mode)
end

def roost(event,bot,args=nil,ignoreinputs=false,mode=0)
  reload_library()
  return grab_today(event,bot,args,ignoreinputs,mode)
end

def next_events(event,bot,args=nil)
  reload_library()
  return future_events(event,bot,args)
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
    str2="#{str2}\nFocused feeding time shown for #{k[0]}, whose favored bondfood is #{['Golden Chalice (Sunday)','Juicy Meat (Monday)','Kaleidoscope (Tuesday)','Floral Circlet (Wednesday)','Compelling Book (Thursday)','Mana Essence (Friday)','Golden Chalice (Saturday)'][k[9]]}" if k.length>0
    if nums.length<=0
      m=bxp.map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
      str2="#{str2}\n*To get from level 1 to level #{bxp.length}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
      str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
      str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k[9],m)} days starting from today" if k.length>0
      str2="#{str2}\n*Semi-focused feeding time:*  #{focus_feed(k[9],m,true)} days starting from today" if k.length>0
      str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[bxp.length-1][1]-bxp[0][1])} additional seconds ~~(from #{bxp[0][1]} sec to #{bxp[bxp.length-1][1]} sec)~~"
    elsif nums.length==1
      n=[nums[0],bxp.length].min
      unless n==1
        m=bxp[0,n-1].map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}#{"\n" unless n==bxp.length}\n*To get from level 1 to level #{n}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
        str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
        str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k[9],m)} days starting from today" if k.length>0
        str2="#{str2}\n*Semi-focused feeding time:*  #{focus_feed(k[9],m,true)} days starting from today" if k.length>0
        str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[n-1][1]-bxp[0][1])} additional seconds ~~(from #{bxp[0][1]} sec to #{bxp[n-1][1]} sec)~~"
      end
      unless n==bxp.length
        m=bxp[n-1,bxp.length-n].map{|q| q[0]*10}.inject(0){|sum,x| sum + x }
        str2="#{str2}#{"\n" unless n==1}\n*To get from level #{n} to level #{bxp.length}:*  \u200B  \u200B  #{longFormattedNumber(m)} EXP required"
        str2="#{str2}\n*Optimal feeding:*  \u200B  \u200B  #{exp_shift(m,4)}"
        str2="#{str2}\n*Focused feeding time:*  #{focus_feed(k[9],m)} days starting from today" if k.length>0
        str2="#{str2}\n*Semi-focused feeding time:*  #{focus_feed(k[9],m,true)} days starting from today" if k.length>0
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
      str2="#{str2}\n*Semi-focused feeding time:*  #{focus_feed(k[9],m,true)} days starting from today" if k.length>0
      str2="#{str2}\n*Resulting shapeshift time increase:*  \u200B  \u200B  #{'%.1f' % (bxp[n2-1][1]-bxp[n-1][1])} additional seconds ~~(from #{bxp[n-1][1]} sec to #{bxp[n2-1][1]} sec)~~"
    end
    str2="#{str2}\n\nInclude a dragon's name to show focused feeding times." if k.length<=0
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

def show_abil_limits(event,bot)
  create_embed(event,'__**Wyrmprint ability stacking limits**__','',0xCE456B,'Limits shown here are for wyrmprint totals per adventurer, not per team or including native adventurer abilities',nil,triple_finish(@abilimits,true))
end

def find_adv_alts(bot,event,args,juststats=false)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_adventurer,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  name=k[9][0].gsub('*','')
  k=@adventurers.reject{|q| q[9].nil? || q[9][0].nil? || q[9][0].gsub('*','')!=name}.uniq
  untz2=[]
  color=[]
  for i in 0...k.length
    color.push(element_color(k[i][2][1]))
    m=[]
    m.push('default') if k[i][0]==k[i][9][0] || k[i][9][0][k[i][9][0].length-1,1]=='*'
    m.push('default') if k[i][9][0][0,1]=='*' && k[i][9].length>1
    m.push('sensible') if k[i][9][0][0,1]=='*' && k[i][9].length<2
    m.push('seasonal') if k[i][1][1,1]=='s'
    m.push('~~seasonal~~') if k[i][1][1,1]=='f'
    m.push('Gala') if k[i][0][0,5]=='Gala ' && m.length<=0
    m.push('out-of-left-field') if m.length<=0
    n=''
    unless k[i][0]==k[i][9] || k[i][9][k[i][9].length-1,1]=='*'
      k2=k.reject{|q| q[9][0].gsub('*','')!=k[i][9][0].gsub('*','') || q[0]==k[i][0] || !(q[0]==q[9][0] || q[9][0].include?('*'))}
      n='x' if k2.length<=0
    end
    untz2.push(["#{k[i][0]}#{adv_emoji(k[i],bot)} - #{m.uniq.join(', ')}",k[i][9].map{|q| q.gsub('*','')}])
  end
  k=@dragons.reject{|q| q[12].nil? || q[12][0].nil? || q[12][0].gsub('*','')!=name}.uniq
  for i in 0...k.length
    color.push(element_color(k[i][2]))
    m=[]
    m.push('default') if k[i][0]==k[i][12][0] || k[i][12][0][k[i][12][0].length-1,1]=='*'
    m.push('default') if k[i][12][0][0,1]=='*' && k[i][12].length>1
    m.push('sensible') if k[i][12][0][0,1]=='*' && k[i][12].length<2
    m.push('seasonal') if k[i][1][1,1]=='s'
    m.push('~~seasonal~~') if k[i][1][1,1]=='f'
    m.push('out-of-left-field') if m.length<=0
    n=''
    unless k[i][0]==k[i][12] || k[i][12][k[i][12].length-1,1]=='*'
      k2=k.reject{|q| q[12][0].gsub('*','')!=k[i][12][0].gsub('*','') || q[0]==k[i][0] || !(q[0]==q[12][0] || q[12][0].include?('*'))}
      n='x' if k2.length<=0
    end
    untz2.push(["*[Drg]* #{k[i][0]}#{dragon_emoji(k[i],bot)} - #{m.uniq.join(', ')}",k[i][12].map{|q| q.gsub('*','')}])
  end
  if color.length.zero?
    color=0xFFD800
  else
    color=avg_color(color)
  end
  k=@adventurers.reject{|q| q[9][0].gsub('*','')!=name}.map{|q| q[9]}.uniq
  k2=k.map{|q| q.length}
  k3=@dragons.reject{|q| q[12][0].gsub('*','')!=name}.map{|q| q[12]}.uniq
  for i in 0...k3.length
    k.push(k3[i])
    k2.push(k3[i].length)
  end
  if k2.max>1
    k2=k.map{|q| q[1]}.uniq.map{|q| ["#{name}(#{q})",[],q]}
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

def find_dragon_alts(bot,event,args,justatats=false)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_dragon,args.join(' '),event)
  if k.length.zero?
    event.respond 'No matches found.'
    return nil
  end
  name=k[12][0].gsub('*','')
  k=@dragons.reject{|q| q[12].nil? || q[12][0].nil? || q[12][0].gsub('*','')!=name}.uniq
  untz2=[]
  color=[]
  for i in 0...k.length
    color.push(element_color(k[i][2]))
    m=[]
    m.push('default') if k[i][0]==k[i][12][0] || k[i][12][0][k[i][12][0].length-1,1]=='*'
    m.push('default') if k[i][12][0][0,1]=='*' && k[i][12].length>1
    m.push('sensible') if k[i][12][0][0,1]=='*' && k[i][12].length<2
    m.push('seasonal') if k[i][1][1,1]=='s'
    m.push('~~seasonal~~') if k[i][1][1,1]=='f'
    m.push('out-of-left-field') if m.length<=0
    n=''
    unless k[i][0]==k[i][12] || k[i][12][k[i][12].length-1,1]=='*'
      k2=k.reject{|q| q[12][0].gsub('*','')!=k[i][12][0].gsub('*','') || q[0]==k[i][0] || !(q[0]==q[12][0] || q[12][0].include?('*'))}
      n='x' if k2.length<=0
    end
    untz2.push(["#{k[i][0]}#{dragon_emoji(k[i],bot)} - #{m.uniq.join(', ')}",k[i][12].map{|q| q.gsub('*','')}])
  end
  k=@adventurers.reject{|q| q[9].nil? || q[9][0].nil? || q[9][0].gsub('*','')!=name}.uniq
  for i in 0...k.length
    color.push(element_color(k[i][2][1]))
    m=[]
    m.push('default') if k[i][0]==k[i][9][0] || k[i][9][0][k[i][9][0].length-1,1]=='*'
    m.push('default') if k[i][9][0][0,1]=='*' && k[i][9].length>1
    m.push('sensible') if k[i][9][0][0,1]=='*' && k[i][9].length<2
    m.push('seasonal') if k[i][1][1,1]=='s'
    m.push('~~seasonal~~') if k[i][1][1,1]=='f'
    m.push('Gala') if k[i][0][0,5]=='Gala ' && m.length<=0
    m.push('out-of-left-field') if m.length<=0
    n=''
    unless k[i][0]==k[i][9] || k[i][9][k[i][9].length-1,1]=='*'
      k2=k.reject{|q| q[9][0].gsub('*','')!=k[i][9][0].gsub('*','') || q[0]==k[i][0] || !(q[0]==q[9][0] || q[9][0].include?('*'))}
      n='x' if k2.length<=0
    end
    untz2.push(["*[Adv]* #{k[i][0]}#{adv_emoji(k[i],bot)} - #{m.uniq.join(', ')}",k[i][9].map{|q| q.gsub('*','')}])
  end
  if color.length.zero?
    color=0xFFD800
  else
    color=avg_color(color)
  end
  k=@dragons.reject{|q| q[12][0].gsub('*','')!=name}.map{|q| q[12]}.uniq
  k2=k.map{|q| q.length}
  k3=@adventurers.reject{|q| q[9][0].gsub('*','')!=name}.map{|q| q[9]}.uniq
  for i in 0...k3.length
    k.push(k3[i])
    k2.push(k3[i].length)
  end
  if k2.max>1
    k2=k.map{|q| q[1]}.uniq.map{|q| ["#{name}(#{q})",[],q]}
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

def disp_adv_mats(event,args,bot,forcespiral=false)
  reload_library()
  return adv_mats(event,args,bot,forcespiral)
end

def adv_chain_list(event,args,bot)
  reload_library()
  return disp_adv_chain(event,args,bot)
end

def sort_shareable_skills(event,args,bot)
  data_load()
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k2=find_data_ex(:find_adventurer,args.join(' '),event,true)
  k=find_in_adventurers(bot,event,args,2,2)
  k2=find_data_ex(:find_adventurer,args.join(' '),event) if (k2.nil? || k2.length<=0) && !(!k.nil? && k.length>0 && k[1].length>0 && k[1].length<@adventurers.length)
  sklz=@askilities.map{|q| q}
  unless k2.nil? || k2.length<=0
    skl1=sklz.find_index{|q| q[2]=='Skill' && q[0]==k2[6][0]}
    skl1=sklz[skl1] unless skl1.nil?
    skl1[12][1]=skl1[6][-1] unless skl1.nil? || skl1[12].nil? || skl1[12].length<=0 || skl1[12].length>1
    skl2=sklz.find_index{|q| q[2]=='Skill' && q[0]==k2[6][1]}
    skl2=sklz[skl2] unless skl2.nil?
    skl2[12][1]=skl2[6][-1] unless skl2.nil? || skl2[12].nil? || skl2[12].length<=0 || skl2[12].length>1
    if (skl1.nil? || skl1[12].nil? || skl1[12].length<=0 || skl1[12].max<=0) && (skl2.nil? || skl2[12].nil? || skl2[12].length<=0 || skl2[12].max<=0)
      event.respond "#{adv_emoji(k2,bot)}*#{k2[0]}* does not have any skills that can be shared."
      return nil
    end
    disp_skill_data(bot,event,k2[6][0].split(' '),(args.include?('tags')),topstr=["#{adv_emoji(k2,bot)}*#{k2[0]}* [S1]",element_color(k2[2][1])]) unless skl1.nil? || skl1[12].nil? || skl1[12].length<=0 || skl1[12].max<=0
    disp_skill_data(bot,event,k2[6][1].split(' '),(args.include?('tags')),topstr=["#{adv_emoji(k2,bot)}*#{k2[0]}* [S2]",element_color(k2[2][1])]) unless skl2.nil? || skl2[12].nil? || skl2[12].length<=0 || skl2[12].max<=0
    return nil
  end
  search=k[0]
  char=k[1]
  char=char.sort{|a,b| a[0].gsub('*','')<=>b[0].gsub('*','')}.uniq
  textra=k[3]
  textra="**No adventurers match your search**" if char.length<=0
  char2=[]
  for i in 0...char.length
    if char[i][0].include?(' *[S1/2]*') || char[i][0].include?(' *[S1]*')
      skz=sklz.find_index{|q| q[0]==char[i][6][0]}
      unless skz.nil?
        skz=sklz[skz].map{|q| q}
        skz[12][1]=skz[6][-1] if skz[12][1].nil? || skz[12][1]<=0
        skz[1]="#{char[i][0].split(' *[')[0]} - #{skz[0]}"
        skz[0]="#{adv_emoji(char[i],bot)}#{char[i][0].split(' *[')[0]} *[S1]*: #{skz[0]} - #{skz[12][0]}<:SkillShare:714597012733034547>, #{skz[12][1]} SP"
        char2.push(skz.map{|q| q})
      end
    end
    if char[i][0].include?(' *[S1/2]*') || char[i][0].include?(' *[S2]*')
      skz=sklz.find_index{|q| q[0]==char[i][6][1]}
      unless skz.nil?
        skz=sklz[skz].map{|q| q}
        skz[12][1]=skz[6][-1] if skz[12][1].nil? || skz[12][1]<=0
        skz[1]="#{char[i][0].split(' *[')[0]} - #{skz[0]}"
        skz[0]="#{adv_emoji(char[i],bot)}#{char[i][0].split(' *[')[0]} *[S2]*: #{skz[0]} - #{skz[12][0]}<:SkillShare:714597012733034547>, #{skz[12][1]} SP"
        char2.push(skz.map{|q| q})
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
  char=char2.map{|q| q}
  char=char.reject{|q| q[12][0]<costlimit[0] || q[12][0]>costlimit[1] || q[12][1]<splimit[0] || q[12][1]>splimit[1]}
  char=char.sort{|a,b| (supersort(a,b,12,0)==0) ? (supersort(b,a,1)) : (supersort(a,b,12,0))}
  char=char.sort{|a,b| (supersort(a,b,12,1)==0) ? ((supersort(a,b,12,0)==0) ? (supersort(b,a,1)) : (supersort(a,b,12,0))) : (supersort(a,b,12,1))} if sortbysp
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

def display_groups(event)
  grps=get_group_data().sort{|a,b| a[0]<=>b[0]}
  for i in 0...grps.length
    grps[i][2].sort! unless grps[i][2].nil?
    grps[i][3].sort! unless grps[i][3].nil?
    grps[i][4].sort! unless grps[i][4].nil?
    grps[i][5].sort! unless grps[i][5].nil?
  end
  str=''
  for i in 0...grps.length
    str2=grps[i][0]
    if safe_to_spam?(event)
      str=extend_message(str,"__**#{str2}**__",event,2)
      unless grps[i][2].nil? || grps[i][2].length<=0
        if "*Adventurers:* #{grps[i][2].join(', ')}".length>1900
          str=extend_message(str,"*Adventurers:* #{grps[i][2][0]}",event)
          for i2 in 1...grps[i][2].length
            str=extend_message(str,grps[i][2][i2],event,1,', ')
          end
        else
          str=extend_message(str,"*Adventurers:* #{grps[i][2].join(', ')}",event)
        end
      end
      unless grps[i][3].nil? || grps[i][3].length<=0
        if "*Dragons:* #{grps[i][3].join(', ')}".length>1900
          str=extend_message(str,"*Dragons:* #{grps[i][3][0]}",event)
          for i2 in 1...grps[i][3].length
            str=extend_message(str,grps[i][3][i2],event,1,', ')
          end
        else
          str=extend_message(str,"*Dragons:* #{grps[i][3].join(', ')}",event)
        end
      end
      unless grps[i][4].nil? || grps[i][4].length<=0
        if "*Weapons:* #{grps[i][4].join(', ')}".length>1900
          str=extend_message(str,"*Weapons:* #{grps[i][4][0]}",event)
          for i2 in 1...grps[i][4].length
            str=extend_message(str,grps[i][4][i2],event,1,', ')
          end
        else
          str=extend_message(str,"*Weapons:* #{grps[i][4].join(', ')}",event)
        end
      end
      unless grps[i][5].nil? || grps[i][5].length<=0
        if "*Wyrmprints:* #{grps[i][5].join(', ')}".length>1900
          str=extend_message(str,"*Wyrmprints:* #{grps[i][5][0]}",event)
          for i2 in 1...grps[i][5].length
            str=extend_message(str,grps[i][5][i2],event,1,', ')
          end
        else
          str=extend_message(str,"*Wyrmprints:* #{grps[i][5].join(', ')}",event)
        end
      end
    else
      str2="*#{str2}*"
      x=[]
      x.push("#{grps[i][2].length} adventurer#{'s' unless grps[i][2].length==1}") unless grps[i][2].nil? || grps[i][2].length<=0
      x.push("#{grps[i][3].length} dragon#{'s' unless grps[i][3].length==1}") unless grps[i][3].nil? || grps[i][3].length<=0
      x.push("#{grps[i][4].length} weapon#{'s' unless grps[i][4].length==1}") unless grps[i][4].nil? || grps[i][4].length<=0
      x.push("#{grps[i][5].length} wyrmprint#{'s' unless grps[i][5].length==1}") unless grps[i][5].nil? || grps[i][5].length<=0
      str=extend_message(str,"#{str2} - #{list_lift(x,'and')}",event)
    end
  end
  event.respond str
end

bot.command([:affinity,:resonance]) do |event|
  return nil if overlap_prevent(event)
  reload_library()
  affinity_resonance(event,bot)
  return nil
end

bot.command([:seegroups,:checkgroups,:groups]) do |event|
  return nil if overlap_prevent(event)
  display_groups(event)
  return nil
end

bot.command([:skillshare,:skilshare,:share,:shared]) do |event, *args|
  return nil if overlap_prevent(event)
  sort_shareable_skills(event,args,bot)
  return nil
end

bot.command([:team,:backpack]) do |event, *args|
  return nil if overlap_prevent(event)
  adv_chain_list(event,args,bot)
  return nil
end

bot.command([:spiral]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_adv_mats(event,args,bot,true)
  return nil
end

bot.command([:mats,:materials,:node,:nodes]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_adv_mats(event,args,bot)
  return nil
end

bot.command([:embeds,:embed]) do |event| # TRANSFERRED
  return nil if overlap_prevent(event)
  metadata_load()
  if @embedless.include?(event.user.id)
    for i in 0...@embedless.length
      @embedless[i]=nil if @embedless[i]==event.user.id
    end
    @embedless.compact!
    event.respond 'You will now see my replies as embeds again.'
  else
    @embedless.push(event.user.id)
    event.respond 'You will now see my replies as plaintext.'
  end
  metadata_save()
  return nil
end

bot.command([:adventurer,:adv,:unit]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
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
    find_adv_alts(bot,event,args)
    return nil
  elsif ['mat','mats','material','materials','node','nodes'].include?(args[0].downcase)
    args.shift
    disp_adv_mats(event,args,bot)
    return nil
  end
  disp_adventurer_stats(bot,event,args)
end

bot.command([:dragon,:drg,:drag]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_dragons(bot,event,args)
    return nil
  elsif ['level','xp','exp'].include?(args[0].downcase)
    args.shift
    level(event,bot,args,3)
    return nil
  elsif ['alt','alts'].include?(args[0].downcase)
    args.shift
    find_dragon_alts(bot,event,args)
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
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_wyrmprints(bot,event,args)
    return nil
  elsif ['shop','store'].include?(args[0].downcase)
    reload_library()
    show_print_shop(event)
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
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
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
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_skills(bot,event,args)
    return nil
  elsif ['share','shared'].include?(args[0].downcase)
    args.shift
    sort_shareable_skills(event,args,bot)
    return nil
  end
  disp_skill_data(bot,event,args)
end

bot.command([:ability,:abil]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_abilities(bot,event,args)
    return nil
  elsif ['limit','limits','stack','stacks'].include?(args[0].downcase)
    show_abil_limits(event,bot)
    return nil
  end
  disp_ability_data(bot,event,args)
end

bot.command([:aura]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc'].include?(q)}
    find_abilities(bot,event,args)
    return nil
  end
  disp_ability_data(bot,event,args,'Aura')
end

bot.command([:coability,:coabil,:coab,:co]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    args=args.reject{|q| ['aura','auras','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','cca','cc','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains'].include?(q)}
    find_abilities(bot,event,args)
    return nil
  end
  disp_ability_data(bot,event,args,'CoAbility')
end

bot.command([:chain,:cca,:cc,:chaincoab]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','aura','auras'].include?(q)}
    find_abilities(bot,event,args)
    return nil
  end
  disp_ability_data(bot,event,args,'Chain')
end

bot.command([:facility,:faculty,:fac]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_facilities(bot,event,args)
    return nil
  end
  disp_facility_data(bot,event,args)
end

bot.command([:mat,:material,:item]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['find','search'].include?(args[0].downcase)
    args.shift
    find_mats(bot,event,args)
    return nil
  elsif ['adv','adventurer'].include?(args[0].downcase)
    args.shift
    disp_adv_mats(event,args,bot)
    return nil
  end
  disp_mat_data(bot,event,args)
end

bot.command([:sp,:SP]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_sp_table(bot,event,args)
end

bot.command([:dmg,:damage,:combo]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_damage_modifiers(bot,event,args)
end

bot.command([:stats,:stat,:smol]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    disp_adventurer_stats(bot,event,args,true)
  elsif ['dragon','dragons','drg'].include?(args[0].downcase)
    disp_dragon_stats(bot,event,args,true)
  elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
    disp_wyrmprint_stats(bot,event,args)
  elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(args[0].downcase)
    disp_weapon_stats(bot,event,args,true)
  else
    find_best_match(args.join(' '),bot,event,false,false,3,true)
  end
  return nil
end

bot.command([:art]) do |event, *args|
  return nil if overlap_prevent(event)
  if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    disp_adventurer_art(bot,event,args)
  elsif ['dragon','dragons','drg'].include?(args[0].downcase) && !(find_data_ex(:find_wyrmprint,args.join(' '),event,true).length>0 && find_data_ex(:find_wyrmprint,args.join(' '),event,true)[0][0,7].downcase=='dragon '.downcase)
    args.shift
    disp_dragon_art(bot,event,args)
  elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
    disp_wyrmprint_art(bot,event,args)
  elsif ['enemy','boss'].include?(args[0].downcase)
    disp_boss_art(bot,event,args)
  elsif ['emote','emoji','sticker'].include?(args[0].downcase)
    disp_emote_art(bot,event,args)
  elsif ['npc'].include?(args[0].downcase)
    disp_npc_art(bot,event,args)
  else
    find_best_match(args.join(' '),bot,event,false,false,2)
  end
  return nil
end

bot.command([:enemy,:boss]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_enemies(bot,event,args)
    return nil
  end
  disp_enemy_data(bot,event,args)
end

bot.command([:banners,:banner]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_banners(bot,event,args)
    return nil
  end
  disp_banner(bot,event,args)
end

bot.command([:lineage,:craft,:crafting]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_weapon_lineage(bot,event,args)
end

bot.command([:alts,:alt]) do |event, *args|
  return nil if overlap_prevent(event)
  find_best_match(args.join(' '),bot,event,false,false,4)
  return nil
end

bot.command([:find,:search,:lookup]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0 || event.server.nil? || bot.user(141260274144509952).on(event.server.id).nil? || event.user.id==141260274144509952
  elsif ['help'].include?(args[0].downcase)
    subcommand=nil
    subcommand=args[0] unless args.nil? || args.length.zero?
    subcommand='' if subcommand.nil?
    help_text(event,bot,'find',subcommand)
    return nil
  else
    f=['vanille','van']
    trig=['love','adventurer','adventurers','adv','advs','unit','units','dragon','dragons','drg','drag','drgs','drags','wyrmprint','wyrm','print','weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap','mat','mats','materials','material','item','items','banner','banners','summon','summoning','summons','summonings','abil','ability','abilitys','abilities','abils','aura','auras','coabil','coability','coabilitys','coabilities','coabils','coab','coabs','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc','skill','skills','skls','skl','skil','skils','enemies','boss','enemy','bosses','enemie','enemys','bosss','facility','facilities','facilitys','fac','facs','faculties','faculty','facultys']
    m=bot.user(141260274144509952).on(event.server.id).display_name.gsub(' ','')
    f.push(m) unless trig.include?(m)
    f.push(m[0,args[0].length]) unless args[0].length<=5 || args[0].length>m.length || trig.include?(m[0,args[0].length])
    if f.include?(args[0].downcase)
      args.shift
      if reload_library('joke')
        event.respond 'I found Van here!  See?  <@141260274144509952>'
        return nil
      elsif args.length<=0
        event.respond "I'm not showing everything, you jerk!"
        return nil
      end
    end
  end
  if args.nil? || args.length<=0
  elsif ['love'].include?(args[0].downcase) || ['true love'].include?("#{args[0]} #{args[1]}".downcase)
    event.respond "Aren't we all?"
    return nil
  elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    args.shift
    find_adventurers(bot,event,args)
    return nil
  elsif ['dragon','dragons','drg','drag','drgs','drags'].include?(args[0].downcase)
    args.shift
    find_dragons(bot,event,args)
    return nil
  elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
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
  elsif ['banner','banners','summon','summoning','summons','summonings'].include?(args[0].downcase)
    args.shift
    find_banners(bot,event,args)
    return nil
  elsif ['abil','ability','abilitys','abilities','abils'].include?(args[0].downcase)
    args.shift
    find_abilities(bot,event,args)
    return nil
  elsif ['aura','auras'].include?(args[0].downcase)
    args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc','ccas'].include?(q)}
    find_abilities(bot,event,args)
    return nil
  elsif ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs'].include?(args[0].downcase)
    args=args.reject{|q| ['aura','auras','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','cca','cc','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','ccas'].include?(q)}
    find_abilities(bot,event,args)
    return nil
  elsif ['chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc','ccas'].include?(args[0].downcase)
    args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','aura','auras'].include?(q)}
    find_abilities(bot,event,args)
    return nil
  elsif ['skill','skills','skls','skl','skil','skils'].include?(args[0].downcase)
    args.shift
    find_skills(bot,event,args)
    return nil
  elsif ['enemies','boss','enemy','bosses','enemie','enemys','bosss'].include?(args[0].downcase)
    args.shift
    find_enemies(bot,event,args)
    return nil
  elsif ['facility','facilities','facilitys','fac','facs','faculties','faculty','facultys','facils','facil'].include?(args[0].downcase)
    args.shift
    find_facilities(bot,event,args)
    return nil
  end
  find_all(bot,event,args)
end

bot.command([:sort,:list]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['aliases','alias'].include?(args[0].downcase) && event.user.id==167657750971547648
    data_load()
    nicknames_load()
    @aliases.uniq!
    @aliases.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? ((a[2].downcase <=> b[2].downcase) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2].downcase <=> b[2].downcase)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
    open("#{@location}devkit/DLNames.txt", 'w') { |f|
      for i in 0...@aliases.length
        f.puts "#{@aliases[i].to_s}#{"\n" if i<@aliases.length-1}"
      end
    }
    event.respond 'The alias list has been sorted alphabetically'
    return nil
  elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    args.shift
    sort_adventurers(bot,event,args)
    return nil
  elsif ['skill','share','shared','skillshare'].include?(args[0].downcase)
    args.shift
    sort_shareable_skills(event,args,bot)
    return nil
  elsif ['dragon','dragons','drg','drag','drgs','drags'].include?(args[0].downcase)
    args.shift
    sort_dragons(bot,event,args)
    return nil
  elsif ['wyrmprint','wyrm','print','wyrmprint','wyrm','print'].include?(args[0].downcase)
    args.shift
    sort_wyrmprints(bot,event,args)
    return nil
  elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(args[0].downcase)
    args.shift
    sort_weapons(bot,event,args)
    return nil
  end
  sort_adventurers(bot,event,args,1)
end

bot.command([:limit,:limits,:stack,:stacks]) do |event|
  return nil if overlap_prevent(event)
  show_abil_limits(event,bot)
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

bot.command([:roost]) do |event, *args|
  return nil if overlap_prevent(event)
  roost(event,bot,args,false,1)
end

bot.command([:ruin,:ruins]) do |event, *args|
  return nil if overlap_prevent(event)
  roost(event,bot,args,false,2)
end

bot.command([:shop,:store]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
    reload_library()
    show_print_shop(event)
    return nil
  end
  roost(event,bot,args,false,3)
end

bot.command([:reset]) do |event, *args|
  return nil if overlap_prevent(event)
  roost(event,bot,args,false,4)
end

bot.command([:daily,:dailies]) do |event, *args|
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

bot.command(:prefix) do |event, prefix| # TRANSFERRED
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
    j=["Facility","#{j[0][0]}"]
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
    j=["Facility","#{j[0][0]}"]
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
  open("#{@location}devkit/DLNames.txt", 'w') { |f|
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
    open("#{@location}devkit/DLNames.txt", 'w') { |f|
      for i in 0...nzzz.length
        f.puts "#{nzzz[i].to_s}#{"\n" if i<nzzz.length-1}"
      end
    }
    bot.channel(logchn).send_message("Alias list has been backed up.")
  end
  return nil
end

bot.command([:channellist,:chanelist,:spamchannels,:spamlist]) do |event| # TRANSFERRED
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

bot.command([:bugreport, :suggestion, :feedback]) do |event, *args| # TRANSFERRED
  return nil if overlap_prevent(event)
  x=['dl!','dl?']
  x.push(@prefixes[event.server.id]) unless event.server.nil? || @prefixes[event.server.id].nil?
  bug_report(bot,event,args,@shards,shard_data(0),'Shard',x,532083509083373583)
end

bot.command([:donation, :donate]) do |event, uid| # TRANSFERRED
  return nil if overlap_prevent(event)
  uid="#{event.user.id}" if uid.nil? || uid.length.zero?
  if /<@!?(?:\d+)>/ =~ uid
    uid=event.message.mentions[0].id
  else
    uid=uid.to_i
    uid=event.user.id if uid==0
  end
  g=get_donor_list()
  if uid==167657750971547648
    n=["#{bot.user(uid).distinct} is","He"]
    n=["You are","You"] if uid==event.user.id
    create_embed(event,"#{n[0]} my developer.","#{n[1]} can have whatever permissions #{n[1].downcase} want#{'s' unless uid==event.user.id} to have.",0x00DAFA)
  elsif uid==141260274144509952
    n=["#{bot.user(uid).distinct} is","He"]
    n=["You are","You"] if uid==event.user.id
    create_embed(event,"#{n[0]} my data input guy.","#{n[1]} can have whatever permissions #{n[1].downcase} want#{'s' unless uid==event.user.id} to have.",0xEEB7CA)
  elsif g.map{|q| q[0]}.include?(uid)
    n="#{bot.user(uid).distinct} is"
    n="You are" if uid==event.user.id
    g=g[g.find_index{|q| q[0]==uid}]
    str=""
    n4=bot.user(uid).name
    n4=n4[0,[3,n4.length].min]
    n4=" #{n4}" if n4.length<2
    n2=n4.downcase
    n3=[]
    for i in 0...n2.length
      if "abcdefghijklmnopqrstuvwxyz".include?(n2[i])
        n3.push(9*("abcdefghijklmnopqrstuvwxyz".split(n2[i])[0].length)+25)
        n3[i]+=5 if n4[i]!=n2[i]
      elsif n2[i].to_i.to_s==n2[i]
        n3.push(n2[i].to_i*2+1)
      else
        n3.push(0)
      end
    end
    color=n3[0]*256*256+n3[1]*256+n3[2]
    str="**Tier 1:** Access to the donor-exclusive channel in my debug server.\n\u2713 This perk cannot be checked dynamically.\nYou can check if it was given to you by clicking this channel link: <#590642838497394689>" if g[2].max>=1
    str="#{str}\n\n**Tier 2:** Ability to give server-specific aliases in any server\n\u2713 Given" if g[2].max>=2
    if g[2][2]>=3
      if g[3].nil? || g[3].length.zero? || g[4].nil? || g[4].length.zero?
        str="#{str}\n\n**Tier 3:** Birthday avatar\n\u2717 Not given.  Please contact <@167657750971547648> to have this corrected."
      elsif g[4][2]=='-'
        str="#{str}\n\n**Tier 3:** Birthday avatar\n\u2713 May be given via another bot."
      elsif !File.exist?("#{@location}devkit/EliseImages/#{g[4][2]}.png")
        str="#{str}\n\n**Tier 3:** Birthday avatar\n\u2717 Not given.  Please contact <@167657750971547648> to have this corrected.\n*Birthday:* #{g[3][1]} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][g[3][0]]}\n*Character:* #{g[4][2]}"
      else
        str="#{str}\n\n**Tier 3:** Birthday avatar\n\u2713 Given\n*Birthday:* #{g[3][1]} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][g[3][0]]}\n*Character:* #{g[4][2]}"
      end
    end
    create_embed(event,"__**#{n} a Tier #{g[2][2]} donor.**__",str,color)
  end
  donor_embed(bot,event)
end

bot.command([:shard,:attribute]) do |event, i, j| # TRANSFERRED
  return nil if overlap_prevent(event)
  if @shardizard<0
    event.respond "This is the Smol Shard."
    return nil
  end
  if j.to_i.to_s==j
    j=j.to_i
    if j>256*256 && i.to_i.to_s==i && i.to_i<=256*256
      k=j*1
      j=i.to_i
      i=k*1
    end
  else
    j=@shards*1
  end
  if (i.to_i.to_s==i || i.to_i==i) && i.to_i>256*256
    srv=(bot.server(i.to_i) rescue nil)
    if i.to_i==327237968047898624 && [5,6].include?(j)
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[0]} Shards." if j != @shards
      event.respond "That server would use #{shard_data(0,true,j)[0]} Shards." if j == @shards
    elsif i.to_i==327237968047898624 && j<=4
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[2]} Shards." if j != @shards
      event.respond "That server would use #{shard_data(0,true,j)[2]} Shards." if j == @shards
    elsif i.to_i==327237968047898624
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[1]} Shards." if j != @shards
      event.respond "That server would use #{shard_data(0,true,j)[1]} Shards." if j == @shards
    elsif @shardizard ==4 && j != @shards
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards."
    elsif @shardizard ==4
      event.respond "That server uses/would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards."
    elsif srv.nil? || bot.user(543373018303299585).on(srv.id).nil?
      event.respond "I am not in that server, but it would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards #{"(in a system of #{j} shards)" if j != @shards}."
    elsif j != @shards
      event.respond "In a system of #{j} shards, *#{srv.name}* would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards."
    else
      event.respond "*#{srv.name}* uses #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards."
    end
    return nil
  elsif i.to_i.to_s==i
    j=i.to_i*1
    i=0
  end
  if event.server.id==327237968047898624 && [5,6].include?(j)
    event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[0]} Shards." if j != @shards
    event.respond "This server uses #{shard_data(0,true,j)[0]} Shards." if j == @shards
    return nil
  elsif event.server.id==327237968047898624 && j<=4
    event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[2]} Shards." if j != @shards
    event.respond "This server uses #{shard_data(0,true,j)[2]} Shards." if j == @shards
    return nil
  elsif event.server.id==327237968047898624
    event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[1]} Shards." if j != @shards
    event.respond "This server uses #{shard_data(0,true,j)[1]} Shards." if j == @shards
    return nil
  elsif bot.profile.id==618979409059119113
    event.respond "This is a cloned version of Botan.  There are no shards."
    return nil
  end
  event.respond "This is the debug mode, which uses #{shard_data(0,false,j)[4]} Shards." if @shardizard==4
  event.respond "PMs always use #{shard_data(0,true,j)[0]} Shards." if event.server.nil? && @shardizard != 4
  event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[(event.server.id >> 22) % j]} Shards." unless event.server.nil? || @shardizard==4 || j == @shards
  event.respond "This server uses #{shard_data(0,true,j)[(event.server.id >> 22) % j]} Shards." unless event.server.nil? || @shardizard==4 || j != @shards
end

bot.command([:safe,:spam,:safetospam,:safe2spam,:long,:longreplies]) do |event, f| # TRANSFERRED
  return nil if overlap_prevent(event)
  f='' if f.nil?
  metadata_load()
  if event.server.nil?
    event.respond 'It is safe for me to send long replies here because this is my PMs with you.'
  elsif [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529].include?(event.server.id)
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
    if (is_mod?(event.user,event.server,event.channel,1) || event.user.id==141260274144509952) && ['off','no','false'].include?(f.downcase)
      metadata_load()
      @spam_channels.delete(event.channel.id)
      metadata_save()
      event.respond 'This channel is no longer marked as safe for me to send long replies to.'
    else
      event << 'This channel has been specifically designated for me to be safe to send long replies to.'
      event << 'If you wish to turn them off, ask a server mod to type `DL!spam off` in this channel.'
    end
  elsif (is_mod?(event.user,event.server,event.channel,1) || event.user.id==141260274144509952) && ['on','yes','true'].include?(f.downcase)
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

bot.command(:invite) do |event, user| # TRANSFERRED
  return nil if overlap_prevent(event)
  usr=event.user
  txt="**You can invite me to your server with this link: <https://goo.gl/mp77kQ>**\nTo look at my source code: <https://github.com/Rot8erConeX/BotanBot/blob/master/BotanBot.rb>\nTo follow my coder's development Twitter and learn of updates: <https://twitter.com/EliseBotDev>\nIf you suggested me to server mods and they ask what I do, show them this image: https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/MarketingBotan.png"
  user_to_name="you"
  user=nil if event.message.mentions.length<=0 && user.to_i.to_s != user
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

bot.command(:sortaliases, from: 167657750971547648) do |event, *args| # TRANSFERRED
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648
  data_load()
  nicknames_load()
  @aliases.uniq!
  @aliases.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? ((a[2].downcase <=> b[2].downcase) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2].downcase <=> b[2].downcase)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
  open("#{@location}devkit/DLNames.txt", 'w') { |f|
    for i in 0...@aliases.length
      f.puts "#{@aliases[i].to_s}#{"\n" if i<@aliases.length-1}"
    end
  }
  event.respond 'The alias list has been sorted alphabetically'
end

bot.command([:tools,:links,:tool,:link,:resources,:resources]) do |event| # TRANSFERRED
  return nil if overlap_prevent(event)
  if @embedless.include?(event.user.id) || was_embedless_mentioned?(event) || event.message.text.downcase.include?('mobile') || event.message.text.downcase.include?('phone')
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

bot.command([:ailment, :affliction]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_status_data(bot,event,args)
end

bot.command(:status) do |event, *args|
  return nil if overlap_prevent(event)
  t=Time.now
  timeshift=6
  t-=60*60*timeshift
  if event.user.id==167657750971547648 && !args.nil? && args.length>0 && args[0]=='set' # only work when used by the developer
    args.shift
  elsif find_data_ex(:find_status,args.join(' '),event,true).length>0
    disp_status_data(bot,event,args)
    return nil
  end
  if event.user.id==167657750971547648 && !args.nil? && args.length>0 # only work when used by the developer
    bot.game=args.join(' ')
    event.respond 'Status set.'
    return nil
  end
  reload_library()
  show_bot_status(event,bot)
  return nil
end

bot.command([:avatar, :avvie]) do |event, *args| # TRANSFERRED
  return nil if overlap_prevent(event)
  t=Time.now
  timeshift=6
  t-=60*60*timeshift
  if event.user.id==167657750971547648 && !args.nil? && args.length>0 # only work when used by the developer
    bot.game=args.join(' ')
    event.respond 'Status set.'
    return nil
  end
  reload_library()
  show_bot_status(event,bot)
  return nil
end

bot.command(:backupaliases, from: 167657750971547648) do |event| # TRANSFERRED
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 || event.channel.id==386658080257212417
  nicknames_load()
  nzz=nicknames_load(2)
  @aliases.uniq!
  @aliases.sort! {|a,b| (a[0] <=> b[0]) == 0 ? ((a[2] <=> b[2]) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2] <=> b[2])) : (a[0] <=> b[0])}
  nzzzzz=@aliases.map{|a| a}
  open("#{@location}devkit/DLNames2.txt", 'w') { |f|
    for i in 0...nzzzzz.length
      f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
    end
  }
  event.respond 'Alias list has been backed up.'
end

bot.command(:restorealiases, from: 167657750971547648) do |event| # TRANSFERRED
  return nil if overlap_prevent(event)
  return nil unless [167657750971547648,bot.profile.id].include?(event.user.id) || event.channel.id==502288368777035777
  if File.exist?("#{@location}devkit/DLNames2.txt")
    b=[]
    File.open("#{@location}devkit/DLNames2.txt").each_line do |line|
      b.push(eval line)
    end
  else
    b=[]
  end
  nzzzzz=b.uniq
  nz=nzzzzz.reject{|q| q[0]!='Adventurer'}
  if nz[nz.length-1][2]<'Zethia'
    event << 'Last backup of the alias list has been corrupted.  Restoring from manually-created backup.'
    if File.exist?("#{@location}devkit/DLNames3.txt")
      b=[]
      File.open("#{@location}devkit/DLNames3.txt").each_line do |line|
        b.push(eval line)
      end
    else
      b=[]
    end
    nzzzzz=b.uniq
  else
    event << 'Last backup of the alias list being used.'
  end
  open("#{@location}devkit/DLNames.txt", 'w') { |f|
    for i in 0...nzzzzz.length
      f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
    end
  }
  event << 'Alias list has been restored from backup.'
end

bot.command(:sendmessage, from: 167657750971547648) do |event, channel_id, *args| # sends a message to a specific channel - TRANSFERRED
  return nil if overlap_prevent(event)
  dev_message(bot,event,channel_id,[141260274144509952])
end

bot.command(:sendpm, from: 167657750971547648) do |event, user_id, *args| # sends a PM to a specific user - TRANSFERRED
  return nil if overlap_prevent(event)
  dev_pm(bot,event,user_id,[141260274144509952])
end

bot.command(:ignoreuser, from: 167657750971547648) do |event, user_id| # causes Botan to ignore the specified user - TRANSFERRED
  return nil if overlap_prevent(event)
  bliss_mode(bot,event,user_id)
end

bot.command(:leaveserver, from: 167657750971547648) do |event, server_id| # forces Botan to leave a server - TRANFERRED
  return nil if overlap_prevent(event)
  walk_away(bot,event,server_id)
end

bot.command(:cleanupaliases, from: 167657750971547648) do |event| # TRANSFERRED
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
  open("#{@location}devkit/DLNames.txt", 'w') { |f|
    for i in 0...nmz.length
      f.puts "#{nmz[i].to_s}#{"\n" if i<nmz.length-1}"
    end
  }
  event << "#{k} aliases were removed due to being from servers I'm no longer in."
  event << "#{k2} aliases were removed due to being identical to the servant's name."
end

bot.command(:snagstats) do |event, f, f2| # TRANSFERRED
  return nil if overlap_prevent(event)
  reload_library()
  snagstats(event,bot,f,f2)
  return nil
end

bot.command(:boop) do |event| # NO NEED TO TRANSFERRED
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 || event.user.id==141260274144509952
  return nil unless event.channel.id==532083509083373583 || @shardizard==4 # only work when used by the developer
  reload_library()
  disp_boop_tags(event)
end

bot.command(:reload, from: 167657750971547648) do |event| # TRANSFERRED
  return nil if overlap_prevent(event)
  return nil unless [167657750971547648,141260274144509952].include?(event.user.id) || [502288368777035777,532083509083373583].include?(event.channel.id)
  event.respond "Reload what?\n1.) Aliases, from backups#{" (unless includes the word \"git\")\n2.) Groups, from GitHub\n3.) Data, from GitHub (include \"subset\" in your message to also reload DLSkillSubsets)" if [167657750971547648,141260274144509952].include?(event.user.id)}#{"\n4.) Source code, from GitHub (include the word \"all\" to also reload rot8er_functs.rb)\n5.) Crossover data\n6.) Libraries, from code\n7.) Avatars, from GitHub" if event.user.id==167657750971547648}\nYou can include multiple numbers to load multiple things."
  event.channel.await(:bob, from: event.user.id) do |e|
    reload=false
    if e.message.text.include?('1')
      if e.message.text.downcase.include?('git') && [167657750971547648,141260274144509952].include?(event.user.id)
        download = open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/DLNames.txt")
        IO.copy_stream(download, "DLTemp.txt")
        if File.size("DLTemp.txt")>100
          b=[]
          File.open("DLTemp.txt").each_line.with_index do |line, idx|
            b.push(line)
          end
          open("DLNames.txt", 'w') { |f|
            f.puts b.join('')
          }
          open("DLNames2.txt", 'w') { |f|
            f.puts b.join('')
          }
        end
        e.respond 'Alias list has been restored from GitHub, and placed in the backup as well.'
        reload=true
      else
        if File.exist?("#{@location}devkit/DLNames2.txt")
          b=[]
          File.open("#{@location}devkit/DLNames2.txt").each_line do |line|
            b.push(eval line)
          end
        else
          b=[]
        end
        nzzzzz=b.uniq
        nz=nzzzzz.reject{|q| q[0]!='Adventurer'}
        if nz[nz.length-1][2]<'Zethia'
          e.respond 'Last backup of the alias list has been corrupted.  Restoring from manually-created backup.'
          if File.exist?("#{@location}devkit/DLNames3.txt")
            b=[]
            File.open("#{@location}devkit/DLNames3.txt").each_line do |line|
              b.push(eval line)
            end
          else
            b=[]
          end
          nzzzzz=b.uniq
        else
          e.respond 'Last backup of the alias list being used.'
        end
        open("#{@location}devkit/DLNames.txt", 'w') { |f|
          for i in 0...nzzzzz.length
            f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
          end
        }
        e.respond 'Alias list has been restored from backup.'
        reload=true
      end
    end
    if e.message.text.include?('2')
      download = open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/DLGroups.txt")
      IO.copy_stream(download, "DLTemp.txt")
      if File.size("DLTemp.txt")>100
        b=[]
        File.open("DLTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("DLGroups.txt", 'w') { |f|
          f.puts b.join('')
        }
      end
      e.respond 'Group list has been restored from GitHub, and placed in the backup as well.'
      reload=true
    end
    if e.message.text.include?('3') && [167657750971547648,141260274144509952].include?(event.user.id)
      event.channel.send_temporary_message('Loading.  Please wait 5 seconds...',3)
      to_reload=['Adventurers','Dragons','Wyrmprints','Weapons','Skills','Banners','Emotes','Enemies','Gauntlet','SkillSubsets','Facilities','Materials','Status','Void','_NPCs','Groups']
      stx=''
      for i in 0...to_reload.length
        download = open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/DL#{to_reload[i]}.txt")
        IO.copy_stream(download, "DLTemp.txt")
        if to_reload[i]=='Skills' && File.size("DLTemp.txt")<File.size("DLSkills.txt")*2/3
          stx='Skills were not reloaded because the file was loaded from the wrong sheet.'
        elsif to_reload[i]=='SkillSubsets' && File.size("DLTemp.txt")<File.size("DLSkillSubsets.txt") && !e.message.text.downcase.include?('subset')
        elsif File.size("DLTemp.txt")>100
          b=[]
          File.open("DLTemp.txt").each_line.with_index do |line, idx|
            b.push(line)
          end
          open("DL#{to_reload[i]}.txt", 'w') { |f|
            f.puts b.join('')
          }
        end
      end
      stx="#{stx}#{"\n" if stx.length>0}DLSkillSubsets also reloaded" if e.message.text.include?('subset')
      e.respond "New data loaded.\n#{stx}"
      reload=true
    end
    if e.message.text.include?('4') && [167657750971547648].include?(event.user.id)
      download = open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/rot8er_functs.rb")
      IO.copy_stream(download, "DLTemp.txt")
      if File.size("DLTemp.txt")>100 && e.message.text.include?('all')
        b=[]
        File.open("DLTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("rot8er_functs.rb", 'w') { |f|
          f.puts b.join('')
        }
      end
      download = open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/BotanText.rb")
      IO.copy_stream(download, "DLTemp.txt")
      if File.size("DLTemp.txt")>100
        b=[]
        File.open("DLTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("BotanText.rb", 'w') { |f|
          f.puts b.join('')
        }
      end
      download = open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/BotanBot.rb")
      IO.copy_stream(download, "DLTemp.txt")
      if File.size("DLTemp.txt")>100
        if File.exist?("#{@location}devkit/BotTokens.txt")
          b2=[]
          File.open("#{@location}devkit/BotTokens.txt").each_line do |line|
            b2.push(line.split(' # ')[0])
          end
        else
          b2=[]
        end
        if b2.length>0
          b=[]
          File.open("DLTemp.txt").each_line.with_index do |line, idx|
            if idx<100
              b.push(line.gsub('>Token<',b2[3]).gsub('>Debug Token<',b2[-1]).gsub('>Smol Token<',b2[-3]).gsub('>Location<',@location))
            else
              b.push(line)
            end
          end
          open("BotanBot.rb", 'w') { |f|
            f.puts b.join('')
          }
          e.respond 'New source code loaded.'
          reload=true
        end
      end
    end
    if e.message.text.include?('5') && [167657750971547648].include?(event.user.id)
      download = open("https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOServants.txt")
      IO.copy_stream(download, "DLTemp.txt")
      if File.size("DLTemp.txt")>100
        b=[]
        File.open("DLTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("FGOServants.txt", 'w') { |f|
          f.puts b.join('')
        }
      end
      download = open("https://raw.githubusercontent.com/Rot8erConeX/LizBot/master/FGOCraftEssances.txt")
      IO.copy_stream(download, "DLTemp.txt")
      if File.size("DLTemp.txt")>100
        b=[]
        File.open("DLTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("FGOCraftEssances.txt", 'w') { |f|
          f.puts b.join('')
        }
      end
      download = open("https://raw.githubusercontent.com/Rot8erConeX/EliseBot/master/EliseBot/FEHUnits.txt")
      IO.copy_stream(download, "DLTemp.txt")
      if File.size("DLTemp.txt")>100
        b=[]
        File.open("DLTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("FEHUnits.txt", 'w') { |f|
          f.puts b.join('')
        }
      end
      e.respond 'New cross-data loaded.'
      reload=true
    end
    if e.message.text.include?('6') && [167657750971547648].include?(event.user.id)
      puts 'reloading BotanText'
      load "#{@location}devkit/BotanText.rb"
      t=Time.now
      @last_multi_reload[1]=t
      e.respond 'Libraries force-reloaded'
      reload=true
    end
    if e.message.text.include?('7') && [167657750971547648].include?(event.user.id)
      download = open("https://raw.githubusercontent.com/Rot8erConeX/EliseBot/master/EliseBot/FEHDonorList.txt")
      IO.copy_stream(download, "DLTemp.txt")
      if File.size("DLTemp.txt")>100
        b=[]
        File.open("DLTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("FEHDonorList.txt", 'w') { |f|
          f.puts b.join('')
        }
      end
      download = open("https://raw.githubusercontent.com/Rot8erConeX/EliseBot/master/EliseBot/FEHBotArtList.txt")
      IO.copy_stream(download, "DLTemp.txt")
      x=[]
      if File.size("DLTemp.txt")>100
        b=[]
        File.open("DLTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        x=b[2].gsub("\n",'').split('\\'[0])
        for i in 0...x.length
          download = open("https://raw.githubusercontent.com/Rot8erConeX/EliseBot/master/EliseBot/EliseImages/#{x[i]}.png")
          IO.copy_stream(download, "DLTemp#{@shardizard}.png")
          if File.size("DLTemp#{@shardizard}.png")>100
            download = open("https://raw.githubusercontent.com/Rot8erConeX/EliseBot/master/EliseBot/EliseImages/#{x[i]}.png")
            IO.copy_stream(download, "EliseImages/#{x[i]}.png")
          end
        end
      end
      e.respond 'Avatars reloaded'
      reload=true
    end
    e.respond 'Nothing reloaded.  If you meant to use the command, please try it again.' unless reload
  end
  return nil
end

bot.command(:update) do |event| # TRANSFERRED
  return nil if overlap_prevent(event)
  reload_library()
  disp_update_list()
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
  if ![620710758841450529,285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(event.server.id) && @shardizard==4
    (chn.send_message(get_debug_leave_message()) rescue nil)
    event.server.leave
  else
    bot.user(167657750971547648).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned the #{shard_data(0)[(event.server.id >> 22) % @shards]} Shard")
    bot.user(141260274144509952).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned the #{shard_data(0)[(event.server.id >> 22) % @shards]} Shard")
    metadata_load()
    @server_data[0][((event.server.id >> 22) % @shards)] += 1
    metadata_save()
    chn.send_message("Hello, my name is Botan.  You're the #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x },true)} halidom to ask for my help.  Folks around these parts call me the \"naginata cutie.\" ...Hey, don't you **dare** laugh at that, jerk!\nWant data on *Dragalia Lost*?  Use commands that start with the prefix `DL!`, and leave this to me!") rescue nil
  end
end

bot.server_delete do |event|
  unless @shardizard==4
    bot.user(167657750971547648).pm("Left server **#{event.server.name}**\nThis server was using #{shard_data(0,true)[((event.server.id >> 22) % @shards)]} Shards")
    bot.user(141260274144509952).pm("Left server **#{event.server.name}**\nThis server was using #{shard_data(0,true)[((event.server.id >> 22) % @shards)]} Shards")
    metadata_load()
    @server_data[0][((event.server.id >> 22) % @shards)] -= 1
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
  if @shardizard==4 && (['fea!','fef!','fea?','fef?'].include?(str[0,4]) || ['fe13!','fe14!','fe13?','fe14?'].include?(str[0,5]) || ['fe!','fe?'].include?(str[0,3])) && (event.server.nil? || event.server.id==285663217261477889)
    str=str[4,str.length-4] if ['fea!','fef!','fea?','fef?'].include?(str[0,4])
    str=str[5,str.length-5] if ['fe13!','fe14!','fe13?','fe14?'].include?(str[0,5])
    str=str[3,str.length-3] if ['fe!','fe?'].include?(str[0,3])
    a=str.split(' ')
    if a[0].downcase=='reboot'
      event.respond 'Becoming Robin.  Please wait approximately ten seconds...'
      exec "cd #{@location}devkit && RobinBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond 'I am not Robin right now.  Please use `FE!reboot` to turn me into Robin.'
    end
  elsif (['feh!','feh?'].include?(str[0,4]) || ['f?','e?','h?'].include?(str[0,2])) && @shardizard==4 && (event.server.nil? || event.server.id==285663217261477889)
    s=event.message.text.downcase
    s=s[2,s.length-2] if ['f?','e?','h?'].include?(event.message.text.downcase[0,2])
    s=s[4,s.length-4] if ['feh!','feh?'].include?(event.message.text.downcase[0,4])
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming Elise.  Please wait approximately ten seconds..."
      exec "cd #{@location}devkit && PriscillaBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond "I am not Elise right now.  Please use `FEH!reboot` to turn me into Elise."
    end
  elsif ['d!','d?'].include?(str[0,2]) && @shardizard==4 && (event.server.nil? || event.server.id==285663217261477889)
    s=event.message.text.downcase
    s=s[2,s.length-2] if ['d?','d!'].include?(event.message.text.downcase[0,2])
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming BotanX.  Please wait approximately ten seconds..."
      exec "cd #{@location}devkit && DebugBotX.rb 4"
    end
  elsif (['fgo!','fgo?','liz!','liz?'].include?(str[0,4]) || ['fate!','fate?'].include?(str[0,5])) && @shardizard==4 && (event.server.nil? || event.server.id==285663217261477889)
    s=event.message.text.downcase
    s=s[5,s.length-5] if ['fate!','fate?'].include?(event.message.text.downcase[0,5])
    s=s[4,s.length-4] if ['fgo!','fgo?','liz!','liz?'].include?(event.message.text.downcase[0,4])
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming Liz.  Please wait approximately ten seconds..."
      exec "cd #{@location}devkit && LizBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond "I am not Liz right now.  Please use `FGO!reboot` to turn me into Liz."
    end
  elsif (['!weak '].include?(str[0,6]) || ['!weakness '].include?(str[0,10]))
    if event.server.nil? || event.server.id==264445053596991498
    elsif !bot.user(304652483299377182).on(event.server.id).nil? # Robin
    elsif !bot.user(206147275775279104).on(event.server.id).nil? || @shardizard==4 || event.server.id==330850148261298176 # Pokedex
      triple_weakness(bot,event)
    end
  elsif overlap_prevent(event,false)
  elsif m && !all_commands().include?(s.split(' ')[0])
    if event.message.text.downcase.gsub(' ','').gsub("'",'').include?("werenostrangerstolove") && @shardizard>=0
      event.respond "You know the rules and so do I"
    else
      find_best_match(s,bot,event)
    end
  elsif !event.server.nil? && (above_memes().include?("s#{event.server.id}") || above_memes().include?(event.server.id))
  elsif !event.channel.nil? && above_memes().include?("c#{event.channel.id}")
  elsif above_memes().include?("u#{event.user.id}") || above_memes().include?(event.user.id)
  elsif event.message.text.downcase.gsub('?','').split(' ').include?('who') && event.message.text.downcase.gsub('?','').split(' ').include?('luca') && !event.user.bot_account? && @shardizard>=0
    s=event.message.text.downcase.gsub('?','')
    s=remove_format(s,'```')              # remove large code blocks
    s=remove_format(s,'`')                # remove small code blocks
    s=remove_format(s,'~~')               # remove crossed-out text
    s=remove_format(s,'||')               # remove spoiler tags
    if s.include?('who is luca')
      event.respond "> Who is Luca?\n#{"#{event.user.mention} " unless event.server.nil?}Nobody knows.  He just...exists.  Sometimes."
    elsif s.split(' ').include?('who') && s.split(' ').include?('luca')
      event.respond "#{"#{event.user.mention} " unless event.server.nil?}Nobody knows who Luca is, he just...exists?  Sometimes."
    end
  elsif event.message.text.downcase.split(' ').include?('luca') && !event.user.bot_account? && @shardizard>=0
    s=event.message.text.downcase.gsub('?','')
    s=remove_format(s,'```')              # remove large code blocks
    s=remove_format(s,'`')                # remove small code blocks
    s=remove_format(s,'~~')               # remove crossed-out text
    s=remove_format(s,'||')               # remove spoiler tags
    if s.split(' ').include?('luca') && rand(1000)<13
      puts "Luca is Kellam'd"
      event.respond "who?"
    elsif s.split(' ').include?('luca')
      puts "Saw mention of Luca, didn't bother to respond."
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
  if !m || args.nil? || args.length<=0
  elsif ['help','commands','command_list','commandlist'].include?(args[0].downcase)
    args.shift
    help_text(event,bot,args[0],args[1])
    m=false
  elsif ['find','search','lineup'].include?(args[0].downcase)
    m=false
    args.shift
    nodisp=false
    if args.nil? || args.length<=0 || event.server.nil? || bot.user(141260274144509952).on(event.server.id).nil? || event.user.id==141260274144509952
    else
      f=['vanille','van']
      trig=['love','adventurer','adventurers','adv','advs','unit','units','dragon','dragons','drg','drag','drgs','drags','wyrmprint','wyrm','print','weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap','mat','mats','materials','material','item','items','banner','banners','summon','summoning','summons','summonings','abil','ability','abilitys','abilities','abils','aura','auras','coabil','coability','coabilitys','coabilities','coabils','coab','coabs','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc','skill','skills','skls','skl','skil','skils','enemies','boss','enemy','bosses','enemie','enemys','bosss','help']
      m=bot.user(141260274144509952).on(event.server.id).display_name.gsub(' ','')
      f.push(m) unless trig.include?(m)
      f.push(m[0,args[0].length]) unless args[0].length<=5 || args[0].length>m.length || trig.include?(m[0,args[0].length])
      if f.include?(args[0].downcase)
        args.shift
        if reload_library('joke')
          event.respond 'I found Van here!  See?  <@141260274144509952>'
          nodisp=true
        elsif args.length<=0
          event.respond "I'm not showing everything, you jerk!"
          nodisp=true
        end
      end
    end
    if args.length<=0 || nodisp
    elsif ['help'].include?(args[0].downcase)
      subcommand=nil
      subcommand=args[0] unless args.nil? || args.length.zero?
      subcommand='' if subcommand.nil?
      help_text(event,bot,'find',subcommand)
    elsif ['love'].include?(args[0].downcase) || ['true love'].include?("#{args[0]} #{args[1]}".downcase)
      event.respond "Aren't we all?"
    elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
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
    elsif ['banner','banners','summon','summoning','summons','summonings'].include?(args[0].downcase)
      args.shift
      find_banners(bot,event,args)
    elsif ['abil','ability','abilitys','abilities','abils'].include?(args[0].downcase)
      args.shift
      find_abilities(bot,event,args)
    elsif ['aura','auras'].include?(args[0].downcase)
      args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','chaincoabil','chaincoability','chaincoabilitys','cca','cc','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','ccas'].include?(q)}
      find_abilities(bot,event,args)
    elsif ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs'].include?(args[0].downcase)
      args=args.reject{|q| ['aura','auras','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','cca','cc','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','ccas'].include?(q)}
      find_abilities(bot,event,args)
    elsif ['chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc','ccas'].include?(args[0].downcase)
      args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','aura','auras'].include?(q)}
      find_abilities(bot,event,args)
    elsif ['skill','skills','skls','skl','skil','skils'].include?(args[0].downcase)
      args.shift
      find_skills(bot,event,args)
    elsif ['enemies','boss','enemy','bosses','enemie','enemys','bosss'].include?(args[0].downcase)
      args.shift
      find_enemies(bot,event,args)
    elsif ['facility','facilities','facilitys','fac','facs','faculties','faculty','facultys','facil','facils'].include?(args[0].downcase)
      args.shift
      find_facilities(bot,event,args)
    else
      find_all(bot,event,args)
    end
  elsif ['sort','list'].include?(args[0].downcase)
    m=false
    if args.length<=0
    elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
      args.shift
      sort_adventurers(bot,event,args)
    elsif ['skill','share','shared','skillshare'].include?(args[0].downcase)
      args.shift
      sort_shareable_skills(event,args,bot)
    elsif ['dragon','dragons','drg','drags'].include?(args[0].downcase)
      args.shift
      sort_dragons(bot,event,args)
    elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
      args.shift
      sort_wyrmprints(bot,event,args)
    elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(args[0].downcase)
      args.shift
      sort_weapons(bot,event,args)
    else
      sort_adventurers(bot,event,args,1)
    end
  elsif ['art'].include?(args[0].downcase)
    m=false
    args.shift
    if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
      disp_adventurer_art(bot,event,args)
    elsif ['dragon','dragons','drg','drag'].include?(args[0].downcase) && !(find_data_ex(:find_wyrmprint,args.join(' '),event,true).length>0 && find_data_ex(:find_wyrmprint,args.join(' '),event,true)[0][0,7].downcase=='dragon '.downcase)
      disp_dragon_art(bot,event,args)
    elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
      disp_wyrmprint_art(bot,event,args)
    elsif ['enemy','boss'].include?(args[0].downcase)
      disp_boss_art(bot,event,args)
    elsif ['emote','emoji','sticker'].include?(args[0].downcase)
      disp_emote_art(bot,event,args)
    elsif ['npc'].include?(args[0].downcase)
      disp_npc_art(bot,event,args)
    else
      find_best_match(args.join(' '),bot,event,false,false,2)
    end
  elsif ['alts','alt'].include?(args[0].downcase)
    m=false
    args.shift
    find_best_match(args.join(' '),bot,event,false,false,4)
  elsif ['skillshare','share','shared','skilshare'].include?(args[0].downcase)
    args.shift
    sort_shareable_skills(event,args,bot)
    m=false
  elsif ['banner','banners'].include?(args[0].downcase)
    m=false
    args.shift
    if args.length>0 && ['find','search'].include?(args[0].downcase)
      args.shift
      find_banners(bot,event,args)
    else
      disp_banner(bot,event,args)
    end
  elsif ['stats','stat'].include?(args[0].downcase)
    m=false
    if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
      disp_adventurer_stats(bot,event,args,true)
    elsif ['dragon','dragons','drg','drag'].include?(args[0].downcase)
      disp_dragon_stats(bot,event,args,true)
    elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
      disp_wyrmprint_stats(bot,event,args)
    elsif ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(args[0].downcase)
      disp_weapon_stats(bot,event,args,true)
    else
      find_best_match(args.join(' '),bot,event,false,false,3,true)
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
      find_adv_alts(bot,event,args)
    elsif ['art'].include?(args[0].downcase)
      args.shift
      disp_adventurer_art(bot,event,args)
    elsif ['mats','mat','materials','material','node','nodes'].include?(args[0].downcase)
      args.shift
      disp_adv_mats(event,args,bot)
    else
      disp_adventurer_stats(bot,event,args)
    end
  elsif ['dragon','drg','drag'].include?(args[0].downcase)
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
      find_dragon_alts(bot,event,args)
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
    elsif ['shop','store'].include?(args[0].downcase)
      reload_library()
      show_print_shop(event)
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
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_enemies(bot,event,args)
    else
      disp_enemy_data(bot,event,args)
    end
  elsif ['status'].include?(args[0].downcase)
    m=false
    args.shift
    disp_status_data(bot,event,args)
  elsif ['skill','skil'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_skills(bot,event,args)
    elsif ['share','shared'].include?(args[0].downcase)
      sort_shareable_skills(event,args,bot)
    else
      disp_skill_data(bot,event,args)
    end
  elsif ['limit','limits','stack','stacks'].include?(args[0].downcase)
    m=false
    show_abil_limits(event,bot)
  elsif ['aura'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc'].include?(q)}
      find_abilities(bot,event,args)
    else
      disp_ability_data(bot,event,args,'Aura')
    end
  elsif ['coabil','coability','coab'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      args=args.reject{|q| ['aura','auras','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc'].include?(q)}
      find_abilities(bot,event,args)
    else
      disp_ability_data(bot,event,args,'Aura')
    end
  elsif ['chain','cca','cc'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','aura','auras'].include?(q)}
      find_abilities(bot,event,args)
    else
      disp_ability_data(bot,event,args,'Aura')
    end
  elsif ['ability','abil'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_abilities(bot,event,args)
    elsif ['limit','limits','stack','stacks'].include?(args[0].downcase)
      show_abil_limits(event,bot)
    else
      disp_ability_data(bot,event,args)
    end
  elsif ['facility','faculty','fac'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_facilities(bot,event,args)
    else
      disp_facility_data(bot,event,args)
    end
  elsif ['mat','material','item'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search'].include?(args[0].downcase)
      args.shift
      find_mats(bot,event,args)
    elsif ['adv','adventurer'].include?(args[0].downcase)
      args.shift
      disp_adv_mats(event,args,bot)
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
  elsif ['team','backpack'].include?(args[0].downcase)
    args.shift
    adv_chain_list(event,args,bot)
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
  elsif ['roost'].include?(args[0].downcase)
    args.shift
    roost(event,bot,args,false,1)
    m=false
  elsif ['ruin','ruins'].include?(args[0].downcase)
    args.shift
    roost(event,bot,args,false,2)
    m=false
  elsif ['shop','store'].include?(args[0].downcase)
    args.shift
    if ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
      reload_library()
      show_print_shop(event)
    else
      roost(event,bot,args,false,3)
    end
    m=false
  elsif ['reset'].include?(args[0].downcase)
    args.shift
    roost(event,bot,args,false,4)
    m=false
  elsif ['daily','dailies'].include?(args[0].downcase)
    args.shift
    roost(event,bot,args)
    m=false
  elsif ['sp'].include?(args[0].downcase)
    args.shift
    disp_sp_table(bot,event,args)
    m=false
  elsif ['dmg','damage'].include?(args[0].downcase)
    args.shift
    disp_damage_modifiers(bot,event,args)
    m=false
  elsif ['today','now','tomorrow','tommorrow','tomorow','tommorow','sunday','sundae','sun','sonday','sondae','son','monday','mondae','mon','monday','mondae','tuesday','tuesdae','tues','tue','wednesday','wednesdae','wednes','wed','thursday','thursdae','thurs','thu','thur','friday','fridae','fri','fryday','frydae','fry','saturday','saturdae','sat','saturnday','saturndae','saturn','satur'].include?(args[0].downcase)
    roost(event,bot,args)
    m=false
  end
  if m
    if event.message.text.downcase.gsub(' ','').gsub("'",'').include?("werenostrangerstolove")
      event.respond "You know the rules and so do I"
    else
      find_best_match(args.join(' '),bot,event)
    end
  end
end

def next_holiday(bot,mode=0)
  return nil if bot.profile.id==618979409059119113
  t=Time.now
  t-=60*60*6
  holidays=[[0,3,22,'Karina',"with this sweet eyepatch","Info gatherer's birthday"],
            [0,5,10,'Melody(Maid)','errand-girl for Master','Maid Day']]
  unless @shardizard<=0
  d=get_donor_list().reject{|q| q[2][2]<3 || q[4][2]=='-'}
    for i in 0...d.length
      if d[i][4][2]!='-' && d[i][0]!=141260274144509952
        holidays.push([0,d[i][3][0],d[i][3][1],d[i][4][2],"in recognition of #{bot.user(d[i][0]).distinct}","Donator's birthday"])
        holidays[-1][5]="Donator's Day" if d[i][0]==189235935563481088
      end
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
    bot.profile.avatar=(File.open("#{@location}devkit/BotanBot.png",'r')) rescue nil if @shardizard.zero?
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
        bot.profile.avatar=(File.open("#{@location}devkit/EliseImages/#{k[0][3]}.png",'r')) rescue nil
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
          bot.profile.avatar=(File.open("#{@location}devkit/EliseImages/#{k[k.length-1][3]}.png",'r')) rescue nil
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
          bot.profile.avatar=(File.open("#{@location}devkit/EliseImages/#{k[j][3]}.png",'r')) rescue nil
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
    bot.profile.avatar=(File.open("#{@location}devkit/BotanBot.png",'r')) rescue nil if @shardizard.zero?
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
      if ![620710758841450529,285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(bot.servers.values[i].id)
        bot.servers.values[i].general_channel.send_message(get_debug_leave_message()) rescue nil
        bot.servers.values[i].leave
      end
    end
  end
  system("color 3#{shard_data(3)[@shardizard,1]}")
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
  @last_multi_reload[0]=Time.now
  @last_multi_reload[1]=Time.now
  puts 'reloading BotanText'
  load "#{@location}devkit/BotanText.rb"
  system("color 1#{shard_data(3)[@shardizard,1]}")
  system("title #{shard_data(2)[@shardizard]} BotanBot")
  system("title Smol BotanBot") if @shardizard<0
  bot.game='Dragalia Lost (DL!help for info)'
  if bot.profile.id==618979409059119113
  elsif @shardizard==4
    next_holiday(bot)
    bot.user(bot.profile.id).on(285663217261477889).nickname='BotanBot (Debug)' if @shardizard==4
    bot.profile.avatar=(File.open("#{@location}devkit/DebugBotan.png",'r')) if @shardizard==4
  else
    next_holiday(bot)
  end
  if @shardizard==4
    if File.exist?("#{@location}devkit/DebugSav.txt")
      b=[]
      File.open("#{@location}devkit/DebugSav.txt").each_line do |line|
        b.push(eval line)
      end
    else
      b=[]
    end
    bot.channel(285663217261477889).send_message("Hello!") if b[0]!='Botan'
    open("#{@location}devkit/DebugSav.txt", 'w') { |f|
      f.puts '"Botan"'
    }
  end
end

bot.run
