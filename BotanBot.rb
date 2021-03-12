Shardizard = ARGV.first.to_i # taking a single variable from the command prompt to get the shard value
system('color 0F')
Shards = 4                   # total number of shards

require 'discordrb'                    # Download link: https://github.com/meew0/discordrb
require 'open-uri'                     # pre-installed with Ruby in Windows
require 'net/http'                     # pre-installed with Ruby in Windows
require 'certified'
require 'tzinfo/data'                  # Downloaded with active_support below, but the require must be above active_support's require
require 'rufus-scheduler'              # Download link: https://github.com/jmettraux/rufus-scheduler
require 'active_support/core_ext/time' # Download link: https://rubygems.org/gems/activesupport/versions/5.0.0
require_relative 'rot8er_functs'       # functions I use commonly in bots
$location=">Location<"

# this is required to get her to change her avatar on certain holidays
ENV['TZ'] = 'America/Chicago'
@scheduler = Rufus::Scheduler.new

# All the possible command prefixes
@prefixes={}

prefix_proc = proc do |message|
  next pseudocase(message.text[3..-1]) if message.text.downcase.start_with?('dl!')
  next pseudocase(message.text[3..-1]) if message.text.downcase.start_with?('dl?')
  load "#{$location}devkit/DLPrefix.rb"
  next if message.channel.server.nil? || @prefixes[message.channel.server.id].nil? || @prefixes[message.channel.server.id].length<=0
  prefix = @prefixes[message.channel.server.id]
  # We use [prefix.size..-1] so we can handle prefixes of any length
  next pseudocase(message.text[prefix.size..-1]) if message.text.downcase.start_with?(prefix.downcase)
end

# The bot's token is basically their password, so is censored for obvious reasons
if Shardizard==4
  bot = Discordrb::Commands::CommandBot.new token: '>Debug Token<', client_id: 431895561193390090, prefix: prefix_proc
elsif Shardizard<0
  bot = Discordrb::Commands::CommandBot.new token: '>Smol Token<', client_id: 759369481305718806, prefix: prefix_proc
elsif Shardizard>4
  bot = Discordrb::Commands::CommandBot.new token: '>Token<', shard_id: (Shardizard-1), num_shards: 4, client_id: 543373018303299585, prefix: prefix_proc
else
  bot = Discordrb::Commands::CommandBot.new token: '>Token<', shard_id: Shardizard, num_shards: 4, client_id: 543373018303299585, prefix: prefix_proc
end
bot.gateway.check_heartbeat_acks = false

def shard_data(mode=0,ignoredebug=false,s=nil)
  s=Shards*1 if s.nil?
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

if Shardizard<0
  system("color 09")
  system("title loading Smol BotanBot")
else
  system("color 0#{shard_data(3)[Shardizard,1]}")
  system("title loading #{shard_data(2)[Shardizard]} BotanBot")
end

$adventurers=[]
$dragons=[]
$wyrmprints=[]
$weapons=[]
$enemies=[]

$skills=[]
$abilities=[]

$gauntlets=[]
$void=[]
$facilities=[]
$mats=[]
$banners=[]
$statuses=[]

$stickers=[]
$npcs=[]

$aliases=[]
$groups=[]
$skilltags=[]

$feh_units=[]
FEH_rarity_stars=['<:Icon_Rarity_S:448266418035621888>',
                  '<:Icon_Rarity_1:448266417481973781>',
                  '<:Icon_Rarity_2:448266417872044032>',
                  '<:Icon_Rarity_3:448266417934958592>',
                  '<:Icon_Rarity_4:448266418459377684>',
                  '<:Icon_Rarity_5:448266417553539104>',
                  '<:Icon_Rarity_6:491487784650145812>']
$fgo_servants=[]
$fgo_crafts=[]
FGO_rarity_stars=['<:FGO_Rarity_M:577777835041751040>',
                  '<:FGO_icon_rarity_dark:571937156981981184>',
                  '<:FGO_icon_rarity_sickly:571937157095227402>',
                  '<:FGO_icon_rarity_rust:676942902953377802>',
                  '<:FGO_icon_rarity_mono:523903551144198145>',
                  '<:FGO_icon_rarity_gold:523858991571533825>',
                  '<:FGO_Rarity_S:577774548280147969>']

$embedless=[]
@ignored=[]
@server_data=[[],[]]
$spam_channels=[]
$last_multi_reload=[0,0,0]
$rarity_stars=[['<:Rarity_Mana:706612079783575607>',
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
$avvie_info=['Botan','*Dragalia Lost*','N/A']
$voids=[]

# primary entities

class DLSentient # superclass containing all classes that characters can be.  Used by the art command to know when to invoke the "found in wyrmprints" field
  attr_accessor :name
  attr_accessor :voice_na,:voice_jp
  
  def name=(val); @name=val; end
  
  def voice_na=(val); @voice_na=val; end
  def voice_jp=(val); @voice_jp=val; end
  def tid; return 0; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!=self.objt || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}#{self.emotes(bot,true)}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class DLAdventurer < DLSentient
  attr_accessor :rarity,:availability
  attr_accessor :clzz,:element,:weapon,:weapon2
  attr_accessor :hp,:str,:defense,:skill_points
  attr_accessor :skills,:coability,:chain,:abilities
  attr_accessor :hidden_abilities,:abiltags
  attr_accessor :alts
  attr_accessor :gender,:race
  attr_accessor :games,:cygame
  attr_accessor :footer
  attr_accessor :sp_override,:damage_override
  attr_accessor :sort_data
  
  def initialize(val)
    @name=val
    @skill_points=10
  end
  
  def rarity=(val)
    @availability=''
    if !val.is_a?(String)
      @rarity=val
    elsif val.length>1
      @rarity=val[0,1].to_i
      @availability=val[1,val.length-1]
    else
      @rarity=val.to_i
    end
  end
  
  def data=(val)
    val=val.split(', ') if val.is_a?(String)
    @clzz=val[0]
    @element=val[1]
    @weapon=val[2]
    @weapon2=val[3] if val.length>3
  end
  
  def hp=(val); @hp=val.split('; ').map{|q| q.split(', ').map{|q2| q2.to_i}}; end
  def str=(val); @str=val.split('; ').map{|q| q.split(', ').map{|q2| q2.to_i}}; end
  def defense=(val)
    val=val.split(', ').map{|q| q.to_i} if val.is_a?(String)
    @defense=val[0]
    @skill_points=val[1] unless val.length<2
  end
  def skill_points=(val); @skill_points=val; end
  
  def skills=(val); @skills=val.split(';; ').reject{|q| q.length<=0 || q=='-'}; end
  def abilities=(val); @abilities=val.split(';;;; ')[0,3].map{|q| q.split(';; ')}; @abiltags=val.split(';;;; ')[3] if val.split(';;;; ').length>3; end
  def coability=(val); @coability=val.split(';; ')[0]; @chain=val.split(';; ')[1] if val.split(';; ').length>1; end
  def chain=(val); @chain=val; end
  def hidden_abilities=(val); @hidden_abilities=nil; @hidden_abilities=val.split(';;;; ').map{|q| q.split(';; ')} unless val=='-'; end
  
  def gender=(val); @gender=val; end
  def race=(val); @race=val; end
  def games=(val); @games=[]; @games=val.split(', ') unless val.nil?; end
  def alts=(val); @alts=val.split(', '); end
  def cygame=(val); @cygame=val; end
  
  def footer=(val); @footer=val; end
  def sp_override=(val); @sp_override=val.split(';; ').map{|q| q.split('; ')} end
  def damage_override=(val); @damage_override=val.split(';; ').map{|q| q.split('; ')} end
  
  def sort_data=(val); @sort_data=val; end
  def objt; return 'Adventurer'; end
  
  def dispDefense
    return @defense unless @defense.nil?
    return 10 if ['Blade','Dagger','Axe','Lance','Sword'].include?(@weapon)
    return 8 if ['Wand','Staff','Bow','Manacaster'].include?(@weapon)
    return 1
  end
  
  def stat_emotes
    return ['<:HP_S:514712247503945739>','<:MagicS:514712247289774111>','<:DefenseS:514712247461871616>'] if @games[0]=='FEH' && ['Staff','Wand'].include?(@weapon)
    return ['<:HP_S:514712247503945739>','<:StrengthS:514712248372166666>','<:DefenseS:514712247461871616>'] if @games[0]=='FEH'
    return ['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','<:FGO_Def:653485374605361162>'] if @games[0]=='FGO'
    return ['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','<:ProtoShield:642287078943752202>'] if @games[0]=='MM'
    return ['<:HP:573344832307593216>','<:Strength:573344931205349376>','<:Defense:573344832282689567>']
  end
  
  def class_header(bot,emotesonly=0,includerarity=false,includeobjt=false)
    emtz=[]; str=''
    if includerarity
      rar=$rarity_stars[0][@rarity]
      rar=FEH_rarity_stars[@rarity] if @games[0]=='FEH'
      rar=FGO_rarity_stars[@rarity] if @games[0]=='FGO'
      emtz.push(rar)
      str=generate_rarity_row(@rarity,$max_rarity[0],@games[0])
    end
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{@element}"}
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{@element.gsub('Shadow','Dark').gsub('Flame','Fire')}"} if @games[0]=='FEH'
    emtz.push(moji[0].mention) unless moji.length<=0
    str="#{str}#{"\n" if str.length>0}#{moji[0].mention unless moji.length<=0} **#{@element}**"
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{@weapon}"}
    moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Weapon_#{@weapon2}"} unless @weapon2.nil?
    if @games[0]=='FEH'
      color='Colorless'; wpn='Unknown'; srv=443172595580534784
      color='Red' if ['Flame'].include?(@element)
      color='Blue' if ['Water'].include?(@element)
      color='Green' if ['Wind'].include?(@element)
      color='Gold' if ['Light'].include?(@element) && false
      if ['Sword','Lance','Axe','Blade'].include?(@weapon)
        wpn='Blade'
        color='Red' if @weapon=='Sword'
        color='Blue' if @weapon=='Lance'
        color='Green' if @weapon=='Axe'
        color='Gold' if @weapon=='Blade'
      elsif @weapon=='Wand'
        wpn='Tome'; srv=497429938471829504
        srv=575426885048336388 if @element=='Water'
        color=@element.gsub('Shadow','Dark').gsub('Flame','Fire')
      elsif @weapon=='Manacaster'
        color='Summon'; wpn='Gun'
      else
        wpn="#{@weapon}"
      end
      moji=bot.server(srv).emoji.values.reject{|q| q.name != "#{color}_#{wpn}"}
    elsif @games[0]=='FGO'
      c='unknown'
      c='saber' if @weapon=='Sword'
      c='blade' if @weapon=='Blade'
      c='extra' if @weapon=='Dagger'
      c='berserker' if @weapon=='Axe'
      c='archer' if @weapon=='Bow'
      c='lancer' if @weapon=='Lance'
      c='caster' if @weapon=='Wand'
      c='healer' if @weapon=='Staff'
      c='mooncancer' if @weapon=='Manacaster'
      srv=523821178670940170
      srv=523825319916994564 if ['Staff','Blade'].include?(@weapon)
      clr='gold'
      clr='silver' if @rarity==4
      clr='bronze' if @rarity<4
      moji=bot.server(srv).emoji.values.reject{|q| q.name != "class_#{c}_#{clr}"}
    end
    if @games[0]=='MM'
      emtz.push('<:Icon_Weapon_Gear:641466825212821514>')
      str="#{str}\n<:Icon_Weapon_Gear:641466825212821514>[Alt-]**#{@weapon}**"
    else
      emtz.push(moji[0].mention) unless moji.length<=0
      emtz.push('<:Colorless_Dragon:443692132415438849>') if @games[0]=='FEH' && self.isManakete?
      str="#{str}\n#{moji[0].mention unless moji.length<=0}**#{"#{@weapon2} " unless @weapon2.nil?}#{@weapon}**"
    end
    str="#{str}  #{self.stat_emotes[2]} #{self.dispDefense}"
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{@clzz.gsub('Healer','Healing')}"}
    if @games[0]=='FEH'
      emo='<:Resource_Structure:510774545154572298>'
      emo='<:Skill_Weapon:444078171114045450>' if @clzz=='Attack'
      emo='<:Skill_Special:444078170665254929>' if @clzz=='Support'
      emo='<:Defense_Shield:570987444309196835>' if @clzz=='Defense'
      emo='<:Healing_Rod:570991014894895104>' if @clzz=='Healer'
    elsif @games[0]=='FGO'
      emo='<:Buster_y:526556105422274580>' if @clzz=='Attack'
      emo='<:support:572315955397394452>' if @clzz=='Support'
      emo='<:Arts_y:526556105489252352>' if @clzz=='Defense'
      emo='<:healing:572342852420501506>' if @clzz=='Healer'
    else
      emo=moji[0].mention unless moji.length<=0
    end
    emtz.push(emo) unless emo.nil?
    str="#{str}\n#{emo}**#{@clzz}**"
    if @games[0]=='FEH'
      str="#{str}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
      str="#{str}  <:Colorless_Dragon:443692132415438849>**Manakete**" if self.isManakete?
      emtz.push('<:Great_Badge_Golden:443704781068959744>')
    elsif @games[0]=='FGO'
      str="#{str}\n<:Bond:613804021119189012>**FGO Collab**"
      emtz.push('<:Bond:613804021119189012>')
    elsif @games[0]=='MM'
      str="#{str}\n<:Mega_Man:641484836304846857>**Mega Man Collab**"
      emtz.push('<:Mega_Man:641484836304846857>')
    elsif @games[0]=='MH'
      str="#{str}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**"
      emtz.push('<:MH_Rathalos:669319247670804506>')
    elsif @games[0]=='PC'
      str="#{str}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**"
      emtz.push('<:Priconne:782554046887493652>')
    elsif @games[0]=='P5S'
      str="#{str}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**"
      emtz.push('<:Take_Your_Heart:782553893204262923>')
    elsif @availability.include?('c') || @games.length>0
      str="#{str}\n**Collab**"
    end
    lookout=$skilltags.reject{|q| q[2]!='Availability' && q[2]!='Availability/Adventurer'}.map{|q| [q[0],q[1],'x',q[3],q[4]]}.uniq
    for i in 0...lookout.length
      if @availability.include?(lookout[i][3])
        if !lookout[i][4].nil? && lookout[i][4].include?('<')
          str="#{str}\n#{lookout[i][4]}**#{lookout[i][0]}**"
        else
          str="#{str}\n**#{lookout[i][0]}**"
        end
      end
    end
    return emtz if emotesonly==2
    return emtz.join('') if emotesonly==1
    return str
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return self.class_header(bot,1,includerarity,includeobjt); end
  
  def disp_color(chain=0)
    f=[]
    xcolor=0x849294
    xcolor=0xE73031 if @element=='Flame'
    xcolor=0x1890DE if @element=='Water'
    xcolor=0x00D771 if @element=='Wind'
    xcolor=0xFFB90F if @element=='Light'
    xcolor=0xA637DE if @element=='Shadow'
    f.push(xcolor)
    xcolor=nil
    xcolor=0x5A0408 if @clzz=='Attack'
    xcolor=0x00205A if @clzz=='Defense'
    xcolor=0x39045A if @clzz=='Support'
    xcolor=0x005918 if @clzz=='Healing'
    f.push(xcolor) unless xcolor.nil?
    return f[0] if chain>=f.length
    return f[chain]
  end
  
  def thumbnail(rar=0)
    rar=@rarity if rar<=0 || rar>$max_rarity[0]
    dispname=@name.gsub(' ','_')
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/Adventurers/#{dispname}_#{rar}.png?raw=true"
  end
  
  def hasManaSpiral?
    return false if @hp[1][$max_rarity[0]].nil?
    return false if @str[1][$max_rarity[0]].nil?
    return false if @hp[1][$max_rarity[0]]<=0
    return false if @str[1][$max_rarity[0]]<=0
    return true
  end
  
  def disp_stats(rar=0,level=10)
    rar=@rarity if rar<=0 || rar>$max_rarity[0]
    if level==1
      return [@hp[0][rar-3],@str[0][rar-3],self.dispDefense]
    elsif level==10 || rar<5
      return [@hp[1][rar-3],@str[1][rar-3],self.dispDefense]
    elsif level==11
      return [@hp[1][rar-1],@str[1][rar-1],self.dispDefense]
    elsif level==100
      return [@hp[1][rar],@str[1][rar],self.dispDefense]
    elsif level==101
      return [@hp[1][rar-2],@str[1][rar-2],self.dispDefense]
    end
  end
  
  def stat_grid(rar=0)
    rar=@rarity if rar<=0 || rar>$max_rarity[0]+1
    s=self.stat_emotes.map{|q| q}
    m=self.disp_stats(rar,1)
    str="**Lv.1**  #{s[0]}#{m[0]}  #{s[1]}#{m[1]}"
    m=self.disp_stats(rar,10)
    str="#{str}\n**Lv.#{30+10*rar}**  #{s[0]}#{m[0]}  #{s[1]}#{m[1]}"
    m=self.disp_stats(rar,11)
    str="#{str}\n**Max**  #{s[0]}#{m[0]}  #{s[1]}#{m[1]}" if rar==$max_rarity[0]
    return str unless rar==$max_rarity[0]+1
    m=self.disp_stats(rar,100)
    str="**Lv.100**  #{s[0]}#{m[0]}  #{s[1]}#{m[1]}"
    m=self.disp_stats(rar,101)
    str="#{str}\n**Max**  #{s[0]}#{m[0]}  #{s[1]}#{m[1]}"
    return str
  end
  
  def mini_header(bot,rar=0)
    rar=@rarity if rar<0 || rar>$max_rarity[0]+1
    c=self.class_header(bot,2)
    c=[c[0],c[1],c[3]] if @games[0]=='FEH' && self.isManakete?
    str="#{c[0]}**#{@element}  #{c[1]}#{@weapon}  #{c[2]}#{@clzz}**"
    str="#{c[0]}**#{@element}**  #{c[1]}#{@weapon2} **#{@weapon}  #{c[2]}#{@clzz}**" unless @weapon2.nil?
    c=self.stat_emotes.map{|q| q}
    m=self.disp_stats(rar,10)
    m=self.disp_stats(rar,11) if rar>=5
    m=self.disp_stats(rar,101) if rar>$max_rarity[0] || rar==0
    lvl=30+10*rar
    lvl=100 if rar>$max_rarity[0] || rar==0
    lvl="#{lvl} Max" if rar>=5 || rar==0
    str="#{str}\n**Lv.#{lvl}**  #{c[0]}#{m[0]}  #{c[1]}#{m[1]}  #{c[2]}#{m[2]}"
    if @games[0]=='FEH'
      str="#{str}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
      str="#{str}  <:Colorless_Dragon:443692132415438849>**Manakete**" if self.isManakete?
    elsif @games[0]=='FGO'
      str="#{str}\n<:Bond:613804021119189012>**FGO Collab**"
    elsif @games[0]=='MM'
      str="#{str}\n<:Mega_Man:641484836304846857>**Mega Man Collab**"
    elsif @games[0]=='MH'
      str="#{str}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**"
    elsif @games[0]=='PC'
      str="#{str}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**"
    elsif @games[0]=='P5S'
      str="#{str}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**"
    elsif @availability.include?('c') || @games.length>0
      str="#{str}\n**Collab**"
    end
    lookout=$skilltags.reject{|q| q[2]!='Availability' && q[2]!='Availability/Adventurer'}.map{|q| [q[0],q[1],'x',q[3],q[4]]}.uniq
    for i in 0...lookout.length
      if @availability.include?(lookout[i][3])
        if !lookout[i][4].nil? && lookout[i][4].include?('<')
          str="#{str}\n#{lookout[i][4]}**#{lookout[i][0]}**"
        else
          str="#{str}\n**#{lookout[i][0]}**"
        end
      end
    end
    return str
  end
  
  def ability_display(rar=0,fulltext=true)
    str=''
    lv=@abilities.map{|q| q.length}
    lv=[2,2,1] if rar==5
    lv[2]=2 if (@name=='Euden' || @rarity>=5) && rar==5
    lv=[2,2,0] if rar==4
    lv=[2,1,0] if rar==3
    lv[2]=1 if @rarity>=5 && rar<5 && rar>0
    lv=[1,1,0] if rar==2
    lv=[1,0,0] if rar==1
    m=[]
    if fulltext
      a=[[1,3,6],[1,4,6],[5,6,6]]
      a[2]=[3,5,6] if @rarity>=5; a[2]=[2,5,6] if @name=='Euden'
      unless @abiltags.nil?
        for i in 0...3
          a[i][0]=0 if @abiltags.include?("#{i+1}")
        end
      end
      for i in 0...3
        n=[]
        for i2 in 0...lv[i]
          n.push("#{@abilities[i][i2]} (F#{a[i][i2]})")
        end
        m.push(n.join(" \u2192 "))
      end
      str=m.join("\n")
    else
      for i in 0...3
        m.push("#{abilities[i][lv[i]-1]}") unless lv[i]<=0
      end
      str="**Abilities:** #{m.join(', ')}"
    end
    str="#{str}#{"\n" if fulltext}\n**Co-Ability:** #{@coability}" unless @coability.nil? || @coability.length<=0
    str="#{str}#{"\n" if fulltext}\n**Chain Co-Ability:** #{@chain}" unless @chain.nil? || @chain.length<=0
    return str
  end
  
  def collapse_abilities(mode=0)
    m=@abilities.map{|q| q[-1]}
    for i in 0...m.length
      m[i]=[i+1,m[i]]
    end
    return m if mode>0
    m2=m.reject{|q| q[1].include?('%')}.map{|q| [q[0].to_s,q[1]]}
    m=m.reject{|q| !q[1].include?('%')}.map{|q| [q[0],q[1].split(' ')[0,q[1].split(' ').length-1].join(' '),q[1].split(' ')[-1].gsub('+','').gsub('%','').to_i]}
    if m.length<=0
    elsif m.map{|q| q[1]}.uniq.length==1
      m2.push([m.map{|q| q[0]}.join('+'),"#{m[0][1]} +#{m.map{|q| q[2]}.inject(0){|sum,x| sum + x }}%"])
    elsif m[0][1]==m[1][1]
      m2.push(["#{m[0][0]}+#{m[1][0]}","#{m[0][1]} +#{m[0][2]+m[1][2]}%"])
      m2.push([m[2][0],"#{m[2][1]} +#{m[2][2]}%"])
    elsif m.length>2 && m[0][1]==m[2][1]
      m2.push(["#{m[0][0]}+#{m[2][0]}","#{m[0][1]} +#{m[0][2]+m[2][2]}%"])
      m2.push([m[1][0],"#{m[1][1]} +#{m[1][2]}%"])
    elsif m.length>2 && m[1][1]==m[2][1]
      m2.push([m[0][0],"#{m[0][1]} +#{m[0][2]}%"])
      m2.push(["#{m[1][0]}+#{m[2][0]}","#{m[1][1]} +#{m[1][2]+m[2][2]}%"])
    else
      for i in 0...m.length
        m2.push([m[i][0],"#{m[i][1]} +#{m[i][2]}%"])
      end
    end
    return m2
  end
end

class DLDragon < DLSentient
  attr_accessor :rarity,:availability
  attr_accessor :element
  attr_accessor :hp,:str,:speed
  attr_accessor :skills,:auras
  attr_accessor :hidden_abilities
  attr_accessor :sell_price
  attr_accessor :favorite
  attr_accessor :dmg_turn,:longrange
  attr_accessor :alts
  attr_accessor :gender,:games,:cygame
  attr_accessor :footer,:essence
  attr_accessor :damage_override
  attr_accessor :pseudodragon
  attr_accessor :sort_data,:thumbforce
  
  def initialize(val)
    @name=val
  end
  
  def element=(val); @element=val; end
  
  def rarity=(val)
    @availability=''
    if !val.is_a?(String)
      @rarity=val
    elsif val.length>1
      @rarity=val[0,1].to_i
      @availability=val[1,val.length-1]
    else
      @rarity=val.to_i
    end
  end
  
  def hp=(val); @hp=val.split(', ').map{|q| q.to_i}; end
  def str=(val); @str=val.split(', ').map{|q| q.to_i}; end
  def speed=(val); @speed=val.split(', ').map{|q| q.to_f}; end
  
  def skills=(val); @skills=val.split(';; ').reject{|q| q.length<=0 || q=='-'}; end
  def auras=(val); @auras=val.split(';;; ').map{|q| q.split(';; ')} unless val=='-'; end
  def hidden_abilities=(val); @hidden_abilities=nil; @hidden_abilities=val.split(';;;; ').map{|q| q.split(';; ')} unless val=='-'; end
  
  def sell_price=(val); @sell_price=val.split(', ').map{|q| q.to_i}; end
  def favorite=(val); @favorite=val.to_i; end
  def dmg_turn=(val); @dmg_turn=false; @dmg_turn=true if val=='Yes'; end
  def longrange=(val); @longrange=false; @longrange=true if val=='Yes'; end
  def essence=(val); @essence=false; @essence=true if val=='Y'; end
  def pseudodragon=(val); @pseudodragon=nil; @pseudodragon=val unless ['','-',' ',false,nil].include?(val); end
  
  def gender=(val); @gender=val; end
  def games=(val); @games=[]; @games=val.split(', ') unless val.nil?; end
  def alts=(val); @alts=val.split(', '); end
  def cygame=(val); @cygame=val; end
  
  def footer=(val); @footer=val; end
  def sp_override=(val); @sp_override=val.split(';; ').map{|q| q.split('; ')} end
  def damage_override=(val); @damage_override=val.split(';; ').map{|q| q.split('; ')} end
  
  def sort_data=(val); @sort_data=val; end
  def objt; return 'Dragon'; end
  
  def stat_emotes
    return ['<:HP_S:514712247503945739>','<:FreezeS:514712247474585610>','<:SpeedS:514712247625580555>'] if @games[0]=='FEH'
    return ['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','<:Speed:573366907357495296>'] if @games[0]=='FGO'
    return ['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','<:Speed:573366907357495296>'] if @games[0]=='MM'
    return ['<:HP:573344832307593216>','<:Strength:573344931205349376>','<:Speed:573366907357495296>']
  end
  
  def isPseudodragon?
    return true if @pseudodragon
    return true if @hp.nil? || @hp.max<=0
    return true if @str.nil? || @str.max<=0
    return true if @auras.nil?
    return false
  end
  
  def class_header(bot,emotesonly=0,includerarity=false,includeobjt=false)
    emtz=[]; str=''
    if includerarity
      rar=$rarity_stars[0][@rarity]
      rar=FEH_rarity_stars[@rarity] if @games[0]=='FEH'
      rar=FGO_rarity_stars[@rarity] if @games[0]=='FGO'
      emtz.push(rar)
      str=self.rar_row
    end
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{@element}"}
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{@element.gsub('Shadow','Dark').gsub('Flame','Fire')}"} if @games[0]=='FEH'
    emtz.push(moji[0].mention) unless moji.length<=0
    str="#{str}#{"\n" if str.length>0}#{moji[0].mention unless moji.length<=0} **#{@element}**"
    if self.isPseudodragon?
      if @games[0]=='FEH'
        m=$adventurers.reject{|q| q.name != @name}
        if m.length>0
          color='Colorless'; wpn='Unknown'; srv=443172595580534784
          if ['Sword','Lance','Axe','Blade'].include?(m[0].weapon)
            wpn='Blade'
          elsif m[0].weapon=='Wand'
            wpn='Tome'
          elsif m[0].weapon=='Manacaster'
            color='Summon'; wpn='Gun'
          else
            wpn="#{m[0].weapon}"
          end
          moji=bot.server(srv).emoji.values.reject{|q| q.name != "#{color}_#{wpn}"}
        end
        color='Colorless'; wpn='Dragon'; srv=443172595580534784
        color='Red' if ['Flame','Shadow'].include?(@element)
        color='Blue' if ['Water','Light'].include?(@element)
        color='Green' if ['Wind'].include?(@element)
        moji2=bot.server(srv).emoji.values.reject{|q| q.name != "#{color}_#{wpn}"}
        str="#{str}\n#{moji2[0].mention unless moji2.length<=0}~~Pseudodragon~~"
        emtz.push(moji2[0].mention) unless moji2.length<=0
        emtz.push(moji[0].mention) unless moji.length<=0
      else
        str="#{str}\n**Pseudodragon**"
      end
    end
    if includeobjt
      str="#{str}\n<:Tribe_Dragon:549947361745567754>**Dragon**"
      emtz.push('<:Tribe_Dragon:549947361745567754>')
    end
    if @games[0]=='FEH'
      str="#{str}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
      str="#{str}  #{moji[0].mention unless moji.length<=0}**Manakete**" if self.isPseudodragon?
      emtz.push('<:Great_Badge_Golden:443704781068959744>')
    elsif @games[0]=='FGO'
      str="#{str}\n<:Bond:613804021119189012>**FGO Collab**"
      emtz.push('<:Bond:613804021119189012>')
    elsif @games[0]=='MM'
      str="#{str}\n<:Mega_Man:641484836304846857>**Mega Man Collab**"
      emtz.push('<:Mega_Man:641484836304846857>')
    elsif @games[0]=='MH'
      str="#{str}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**"
      emtz.push('<:MH_Rathalos:669319247670804506>')
    elsif @games[0]=='PC'
      str="#{str}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**"
      emtz.push('<:Priconne:782554046887493652>')
    elsif @games[0]=='P5S'
      str="#{str}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**"
      emtz.push('<:Take_Your_Heart:782553893204262923>')
    elsif @availability.include?('c') || @games.length>0
      str="#{str}\n**Collab**"
    end
    lookout=$skilltags.reject{|q| q[2]!='Availability' && q[2]!='Availability/Dragon'}.map{|q| [q[0],q[1],'x',q[3],q[4]]}.uniq
    for i in 0...lookout.length
      if @availability.include?(lookout[i][3])
        if !lookout[i][4].nil? && lookout[i][4].include?('<')
          str="#{str}\n#{lookout[i][4]}**#{lookout[i][0]}**"
        else
          str="#{str}\n**#{lookout[i][0]}**"
        end
      end
    end
    return emtz if emotesonly==2
    return emtz.join('') if emotesonly==1
    return str
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return self.class_header(bot,1,includerarity,includeobjt); end
  
  def disp_color(chain=0)
    f=[]
    xcolor=0x849294
    xcolor=0xE73031 if @element=='Flame'
    xcolor=0x1890DE if @element=='Water'
    xcolor=0x00D771 if @element=='Wind'
    xcolor=0xFFB90F if @element=='Light'
    xcolor=0xA637DE if @element=='Shadow'
    f.push(xcolor)
    return f[0] if chain>=f.length
    return f[chain]
  end
  
  def thumbnail(ext=0)
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/#{@thumbforce}.png?raw=true" unless @thumbforce.nil?
    dispname=@name.gsub(' ','_')
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/Dragons/#{dispname}.png?raw=true"
  end
  
  def mini_header(bot)
    c=self.class_header(bot,2)
    str="#{c[0]}**#{@element}**"; str2=''
    c=self.stat_emotes.map{|q| q}
    if self.isPseudodragon?
      if @games[0]=='FEH'
        color='Colorless'; wpn='Dragon'; srv=443172595580534784
        color='Red' if ['Flame','Shadow'].include?(@element)
        color='Blue' if ['Water','Light'].include?(@element)
        color='Green' if ['Wind'].include?(@element)
        moji=bot.server(srv).emoji.values.reject{|q| q.name != "#{color}_#{wpn}"}
        str2="#{moji[0].mention unless moji.length<=0}~~Pseudodragon~~"
      else
        str="#{str}  **Pseudodragon**"
      end
    else
      str2="**Lv.#{@rarity*20}**  #{c[0]}#{@hp[1]}  #{c[1]}#{@str[1]}"
      str2="**Lv.#{@rarity*20+15}**  #{c[0]}#{@hp[2]}  #{c[1]}#{@str[2]}" if @hp.length>2 && @str.length>2
    end
    if @games[0]=='FEH'
      str2="#{str2}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
      if self.isPseudodragon?
        m=$adventurers.reject{|q| q.name != @name}
        color='Colorless'; wpn='Dragon'; srv=443172595580534784
        if m.length>0
          if ['Sword','Lance','Axe','Blade'].include?(m[0].weapon)
            wpn='Blade'
          elsif m[0].weapon=='Wand'
            wpn='Tome'
          elsif m[0].weapon=='Manacaster'
            color='Summon'; wpn='Gun'
          else
            wpn="#{m[0].weapon}"
          end
        end
        moji=bot.server(srv).emoji.values.reject{|q| q.name != "#{color}_#{wpn}"}
        str2="#{str2}  #{moji[0].mention unless moji.length<=0}**Manakete**"
      end
    elsif @games[0]=='FGO'
      str2="#{str2}\n<:Bond:613804021119189012>**FGO Collab**"
    elsif @games[0]=='MM'
      str2="#{str2}\n<:Mega_Man:641484836304846857>**Mega Man Collab**"
    elsif @games[0]=='MH'
      str2="#{str2}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**"
    elsif @games[0]=='PC'
      str2="#{str2}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**"
    elsif @games[0]=='P5S'
      str2="#{str2}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**"
    elsif @availability.include?('c') || @games.length>0
      str="#{str}  **Collab**"
    end
    lookout=$skilltags.reject{|q| q[2]!='Availability' && q[2]!='Availability/Dragon'}.map{|q| [q[0],q[1],'x',q[3],q[4]]}.uniq
    for i in 0...lookout.length
      if @availability.include?(lookout[i][3])
        if !lookout[i][4].nil? && lookout[i][4].include?('<')
          str2="#{str2}\n#{lookout[i][4]}**#{lookout[i][0]}**"
        else
          str="#{str}  **#{lookout[i][0]}**"
        end
      end
    end
    str="#{str}\n#{str2}".gsub("\n\n","\n") if str2.length>0
    return str
  end
end

class DLWyrmprint
  attr_accessor :name
  attr_accessor :rarity,:availability
  attr_accessor :amulet,:affinity
  attr_accessor :hp,:str
  attr_accessor :abilities
  attr_accessor :sell_price
  attr_accessor :artist
  attr_accessor :charas
  attr_accessor :obtain
  attr_accessor :games
  attr_accessor :sort_data
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
  def sell_price=(val); @sell_price=val.split(', ').map{|q| q.to_i}; end
  def artist=(val); @artist=val; end
  def charas=(val); @charas=val.split(';; ').map{|q| q.split(', ')}; end
  def obtain=(val); @obtain=val.gsub(';; ',"\n"); end
  def games=(val); @games=[]; @games=val.split(', ') unless val.nil?; end
  
  def rarity=(val)
    @availability=''
    if !val.is_a?(String)
      @rarity=val
    elsif val.length>1
      @rarity=val[0,1].to_i
      @availability=val[1,val.length-1]
    else
      @rarity=val.to_i
    end
  end
  
  def amulet=(val)
    @affinity=nil
    val=val.split(', ')
    @amulet=val[0]
    @affinity=val[1] unless val.length<=1 || ['None','','-'].include?(val[1])
  end
  
  def hp=(val); @hp=val.split(', ').map{|q| q.to_i}; end
  def str=(val); @str=val.split(', ').map{|q| q.to_i}; end
  
  def abilities=(val); @abilities=val.split(';;;; ').map{|q| q.split(';; ')}; end
  
  def sort_data=(val); @sort_data=val; end
  def objt; return 'Wyrmprint'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def stat_emotes
    return ['<:HP_S:514712247503945739>','<:GenericAttackS:514712247587569664>','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Really_Sacred_Coin:571011997609754624>','<:Resource_Structure:510774545154572298>'] if @games[0]=='FEH'
    return ['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','<:Limited:574682514585550848>','<:LimitBroken:574682514921095212>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>'] if @games[0]=='FGO'
    return ['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>'] if @games[0]=='MM'
    return ['<:HP:573344832307593216>','<:Strength:573344931205349376>','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>']
  end
  
  def class_header(bot,emotesonly=0,includerarity=false,includeobjt=false)
    emtz=[]; str=''
    if !@availability.nil? && @availability.include?('x') && includerarity
      str='<:Dominion:819854169128435742>'
      emtz.push('<:Dominion:819854169128435742>')
    elsif includerarity
      rar=$rarity_stars[0][@rarity]
      rar=FEH_rarity_stars[@rarity] if @games[0]=='FEH'
      rar=FGO_rarity_stars[@rarity] if @games[0]=='FGO'
      emtz.push(rar)
      str=generate_rarity_row(@rarity,0,@games[0])
      if @rarity>4
        str="#{str} - <:Fill_Gold:759999913962110978>"
      else
        str="#{str} - <:Fill_Silver:759999914062774302>"
      end
    end
    if self.isMultiprint? && !@availability.nil? && @availability.include?('x') && @affinity.nil?
      pr=$wyrmprints.reject{|q| !q.name.include?("#{@name} ")}.map{|q| q.affinity}.uniq
      boons=[]
      for i in 0...pr.length
        moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{pr[i]}"}
        boons.push("#{moji[0].mention unless moji.length<=0}#{pr[i]}")
      end
      str="#{str}\n**Possible Boons:** #{boons.join(', ')}"
    elsif @affinity.nil?
      str="#{str}\nNo affinity"
    else
      moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{@affinity}"}
      str="#{str}\n#{moji[0].mention unless moji.length<=0}**#{@affinity}**'s Boon"
      emtz.push(moji[0].mention) unless moji.length<=0
    end
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Type_#{@amulet.gsub('Healer','Healing')}"}
    if @games[0]=='FEH'
      emo='<:Resource_Structure:510774545154572298>'
      emo='<:Skill_Weapon:444078171114045450>' if @amulet=='Attack'
      emo='<:Skill_Special:444078170665254929>' if @amulet=='Support'
      emo='<:Defense_Shield:570987444309196835>' if @amulet=='Defense'
      emo='<:Healing_Rod:570991014894895104>' if @amulet=='Healer'
    elsif @games[0]=='FGO'
      emo='<:Buster_y:526556105422274580>' if @amulet=='Attack'
      emo='<:support:572315955397394452>' if @amulet=='Support'
      emo='<:Arts_y:526556105489252352>' if @amulet=='Defense'
      emo='<:healing:572342852420501506>' if @amulet=='Healer'
    else
      emo=moji[0].mention unless moji.length<=0
    end
    str="#{str}\n#{emo}**#{@amulet}**" if moji.length>0 || ['Attack','Support','Defense','Healer'].include?(@amulet)
    emtz.push(emo) unless emo.nil?
    if includeobjt
      str="#{str}\n<:Wyrmprint:560542319636381725>**Wyrmprint**"
      emtz.push('<:Wyrmprint:560542319636381725>')
    end
    if @games[0]=='FEH'
      str="#{str}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
      emtz.push('<:Great_Badge_Golden:443704781068959744>')
    elsif @games[0]=='FGO'
      str="#{str}\n<:Bond:613804021119189012>**FGO Collab**"
      emtz.push('<:Bond:613804021119189012>')
    elsif @games[0]=='MM'
      str="#{str}\n<:Mega_Man:641484836304846857>**Mega Man Collab**"
      emtz.push('<:Mega_Man:641484836304846857>')
    elsif @games[0]=='MH'
      str="#{str}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**"
      emtz.push('<:MH_Rathalos:669319247670804506>')
    elsif @games[0]=='PC'
      str="#{str}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**"
      emtz.push('<:Priconne:782554046887493652>')
    elsif @games[0]=='P5S'
      str="#{str}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**"
      emtz.push('<:Take_Your_Heart:782553893204262923>')
    elsif @availability.include?('c') || @games.length>0
      str="#{str}\n**Collab**"
    end
    lookout=$skilltags.reject{|q| q[2]!='Availability' && q[2]!='Availability/Wyrmprint'}.map{|q| [q[0],q[1],'x',q[3],q[4]]}.uniq
    for i in 0...lookout.length
      if @availability.include?(lookout[i][3])
        if !lookout[i][4].nil? && lookout[i][4].include?('<')
          str="#{str}\n#{lookout[i][4]}**#{lookout[i][0]}**"
        else
          str="#{str}\n**#{lookout[i][0]}**"
        end
      end
    end
    return emtz if emotesonly==2
    return emtz.join('') if emotesonly==1
    return str
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return self.class_header(bot,1,includerarity,includeobjt); end
  
  def disp_color(chain=0)
    f=[]
    xcolor=0x944CCD if ['Eagle','Wolf','Bull','Serpent'].include?(@affinity)
    xcolor=0xFF0031 if ['Sword','Axe','Bow','Crown','Lance'].include?(@affinity)
    xcolor=0xF68D10 if ['Dragon'].include?(@affinity)
    xcolor=0x188931 if ['Staff'].include?(@affinity)
    f.push(xcolor) unless xcolor.nil?
    xcolor=nil
    xcolor=0x5A0408 if @amulet=='Attack'
    xcolor=0x00205A if @amulet=='Defense'
    xcolor=0x39045A if @amulet=='Support'
    xcolor=0x005918 if @amulet=='Healing'
    f.push(xcolor) unless xcolor.nil?
    f.push(0x08B8A9) if !@availability.nil? && @availability.include?('x')
    return f[0] if chain>=f.length
    return f[chain]
  end
  
  def thumbnail(mub=0)
    dispname=@name.gsub(' ','_')
    mub=0 if mub<=0
    mub=1 if mub>=1
    if @name.split(' (')[-1][-8,8]=="'s Boon)"
      art="https://github.com/Rot8erConeX/BotanBot/blob/master/Wyrmprints/#{dispname}_#{mub+1}.png?raw=true"
      m=false
      IO.copy_stream(open(art), "#{$location}devkit/DLTemp#{Shardizard}.png") rescue m=true
      dispname=@name.split(' (')[0].gsub(' ','_') if File.size("#{$location}devkit/DLTemp#{Shardizard}.png")<=100 || m
    end
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/Wyrmprints/#{dispname}_#{mub+1}.png?raw=true"
  end
  
  def mini_header(bot)
    c=self.class_header(bot,2)
    str=''
    if !@availability.nil? && @availability.include?('x')
      str="#{c[0]}**#{@affinity}**'s Boon" unless @affinity.nil?
    elsif @affinity.nil?
      str="#{c[0]}**#{@amulet}**"
    else
      str="#{c[0]}**#{@affinity}**'s Boon   #{c[1]}**#{@amulet}**"
    end
    if @games[0]=='FEH'
      str="#{str}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
    elsif @games[0]=='FGO'
      str="#{str}\n<:Bond:613804021119189012>**FGO Collab**"
    elsif @games[0]=='MM'
      str="#{str}\n<:Mega_Man:641484836304846857>**Mega Man Collab**"
    elsif @games[0]=='MH'
      str="#{str}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**"
    elsif @games[0]=='PC'
      str="#{str}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**"
    elsif @games[0]=='P5S'
      str="#{str}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**"
    elsif @availability.include?('c') || @games.length>0
      str="#{str}\n**Collab**"
    end
    lookout=$skilltags.reject{|q| q[2]!='Availability' && q[2]!='Availability/Wyrmprint'}.map{|q| [q[0],q[1],'x',q[3],q[4]]}.uniq
    x="\n"
    x="   " if str.include?("\n")
    for i in 0...lookout.length
      if @availability.include?(lookout[i][3])
        if !lookout[i][4].nil? && lookout[i][4].include?('<')
          str="#{str}#{x}#{lookout[i][4]}**#{lookout[i][0]}**"
        else
          str="#{str}#{x}**#{lookout[i][0]}**"
        end
      end
    end
    return nil if str.length<=0
    return str
  end
  
  def stat_grid(bot,fullsize=true)
    c=self.stat_emotes.map{|q| q}
    l=[1,@rarity*10-10,@rarity*10]
    l=[1,@rarity*10-24,@rarity*10-10] if @rarity<4
    l[2]=5 if @rarity==1
    l[1]=l[2]-2 if @rarity<3
    l=[1,20,30] if !@availability.nil? && @availability.include?('x')
    if self.isMultiprint? || !fullsize
      str="#{c[2]*4} **Level #{l[0]}:**  #{c[0]}*HP:*\u00A0\u00A0#{@hp[0]}  #{c[1]}*Str:*\u00A0\u00A0#{@str[0]}"
      str="#{str}\n#{c[3]*2}#{c[2]*2} **Level #{l[1]}:**  #{c[0]}*HP:*\u00A0\u00A0#{@hp[1]} #{c[1]}*Str:*\u00A0\u00A0#{@str[1]}" unless @hp.length<3 || @str.length<3 || (@hp[1]<=0 && @str[1]<=0)
      str="#{str}\n#{c[3]*4} **Level #{l[2]}:**  #{c[0]}*HP:*\u00A0\u00A0#{@hp[-1]} #{c[1]}*Str:*\u00A0\u00A0#{@str[-1]}"
      unless self.isMultiprint?
        m=@abilities.map{|q| q}
        for i in 0...m.length
          if m[i].length<3
            if m[i][0]==m[i][1]
              m[i]=m[i][0]
            elsif m[i][0].split(' ')[0,m[i][0].split(' ').length-1].join(' ')==m[i][1].split(' ')[0,m[i][1].split(' ').length-1].join(' ')
              m[i]="#{m[i][0]}/#{m[i][1].split(' ')[-1]}"
            else
              m[i]=m[i][0,2].join(" \u2192 ")
            end
          elsif m[i][0]==m[i][1] && m[i][0]==m[i][2]
            m[i]=m[i][0]
          elsif m[i][0]==m[i][1] || m[i][1]==m[i][2]
            if m[i][0].split(' ')[0,m[i][0].split(' ').length-1].join(' ')==m[i][1].split(' ')[0,m[i][2].split(' ').length-1].join(' ')
              m[i]="#{m[i][0]}/#{m[i][2].split(' ')[-1]}"
            else
              m[i]="#{m[i][0]} \u2192 #{m[i][2]}"
            end
          elsif m[i][0].split(' ')[0,m[i][0].split(' ').length-1].join(' ')==m[i][1].split(' ')[0,m[i][1].split(' ').length-1].join(' ')
            m[i]="#{m[i][0]}/#{m[i][1].split(' ')[-1]}/#{m[i][2].split(' ')[-1]}"
          else
            m[i]=m[i][0,3].join(" \u2192 ")
          end
        end
        if m.length<=0
          str="#{str}\n\n__**Abilities**__" if !@affinity.nil? && $resonance.map{|q| q[0]}.include?(@affinity)
        else
          str="#{str}\n\n__**Abilities**__\n#{m.join("\n")}"
        end
      end
    else
      str="__#{c[2]*4} **Level #{l[0]}**__"
      str="#{str}\n#{c[0]}*HP:*\u00A0\u00A0#{@hp[0]}  #{c[1]}*Str:*\u00A0\u00A0#{@str[0]}"
      str="#{str}\n#{@abilities.map{|q| q[0]}.join("\n")}" unless @abilities.length<=0
      unless @hp.length<3 || @str.length<3
        s=[@hp[1]*1,@str[1]*1]
        s[0]=@hp[0]+(@hp[2]-@hp[0])*(l[1]-1)/(l[2]-1) if s[0]<=0
        s[1]=@str[0]+(@str[2]-@str[0])*(l[1]-1)/(l[2]-1) if s[1]<=0
        str="#{str}\n\n__#{c[3]*2}#{c[2]*2} **Level #{l[1]}**__"
        str="#{str}\n#{c[0]}*HP:*\u00A0\u00A0#{s[0]} #{c[1]}*Str:*\u00A0\u00A0#{s[1]}"
        str="#{str}\n#{@abilities.map{|q| q[1]}.join("\n")}" unless @abilities.length<=0
      end
      str="#{str}\n\n__#{c[3]*4} **Level #{l[2]}**__"
      str="#{str}\n#{c[0]}*HP:*\u00A0\u00A0#{@hp[-1]} #{c[1]}*Str:*\u00A0\u00A0#{@str[-1]}"
      str="#{str}\n#{@abilities.map{|q| q[-1]}.join("\n")}" unless @abilities.length<=0
    end
    ftr=nil
    if !self.isMultiprint? && !@affinity.nil? && $resonance.map{|q| q[0]}.include?(@affinity)
      kk2=$resonance.find_index{|q| q[0]==@affinity}
      unless kk2.nil?
        kk2=$resonance[kk2]
        if fullsize
          str="#{str}\n" unless @abilities.length<=0
          str="#{str}\nPair with another #{kk2[0]} affinity print to gain #{kk2[1]}" unless kk2[1].nil?
          str="#{str}\nPair with two more #{kk2[0]} affinity prints to gain #{kk2[2]}" unless kk2[2].nil?
          str="#{str}\nPair with three more #{kk2[0]} affinity prints to gain #{kk2[3]}" unless kk2[3].nil?
        else
          m=[]
          m.push(1) unless kk2[1].nil?
          m.push(2) unless kk2[2].nil?
          m.push(3) unless kk2[3].nil?
          c2=self.class_header(bot,2)
          str="#{str}\n#{c2[0]}+#{m.join('/')} (Affinity) = "
          m=kk2[1,3].compact
          m2=m[0].split(' ')
          m2.pop
          m2=m2.join(' ')
          str="#{str}#{m2} +#{m.map{|q| q.split(' ')[-1].gsub('+','')}.join('/')}"
          ftr='Affinity counts displayed are not including this print, so are off by one.'
        end
      end
    end
    return [str,ftr]
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!=self.objt || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}#{self.emotes(bot,true)}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class DLWeapon
  attr_accessor :name
  attr_accessor :rarity,:availability
  attr_accessor :type,:element
  attr_accessor :hp,:str
  attr_accessor :skills,:abilities
  attr_accessor :sell_price
  attr_accessor :id
  attr_accessor :promotes_from,:tier
  attr_accessor :smith_level
  attr_accessor :costs
  attr_accessor :craft_mats,:unbind_mats,:slot_mats,:copy_mats,:ability_mats,:bonus_mats,:refinement_mats,:post_refine_unbind_mats,:x_mats
  attr_accessor :boss_tags
  attr_accessor :print_slots
  attr_accessor :obtain
  attr_accessor :games
  attr_accessor :sort_data
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
  def type=(val); @type=val; end
  def element=(val); @element=val; end
  def sell_price=(val); @sell_price=val.split(', ').map{|q| q.to_i}; end
  def id=(val); @id=val.to_i; end
  def promotes_from=(val); @promotes_from=val.to_i; end
  def tier=(val); @tier=val.to_i; end
  def smith_level=(val); @smith_level=val.to_i; end
  def boss_tags=(val); @boss_tags=val.split(', '); end
  def print_slots=(val); @print_slots=val.split(', ').map{|q| q.to_i}; end
  def obtain=(val); @obtain=val.gsub(';; ',"\n"); end
  def games=(val); @games=[]; @games=val.split(', ') unless val.nil?; end
  
  def rarity=(val)
    @availability=''
    if !val.is_a?(String)
      @rarity=val
    elsif val.length>1
      @rarity=val[0,1].to_i
      @availability=val[1,val.length-1]
    else
      @rarity=val.to_i
    end
  end
  
  def hp=(val); @hp=val.split(', ').map{|q| q.to_i}; end
  def str=(val); @str=val.split(', ').map{|q| q.to_i}; end
  
  def skills=(val); @skills=val.split(';; ').reject{|q| q.length<=0 || q=='-'}; end
  def abilities=(val); @abilities=val.split(';;;; ').map{|q| q.split(';; ')}; end
  
  def costs=(val); @costs=val.split(', ').map{|q| q.to_i}; end
  def craft_mats=(val); @craft_mats=[]; @craft_mats=val.split(';; ').map{|q| q.split(', ')}.map{|q| [q[0],q[1].to_i]} unless val.nil? || val.length<=0 || val=='-'; end
  def unbind_mats=(val); @unbind_mats=[]; @unbind_mats=val.split(';; ').map{|q| q.split(', ')}.map{|q| [q[0],q[1].to_i]} unless val.nil? || val.length<=0 || val=='-'; end
  def slot_mats=(val); @slot_mats=[]; @slot_mats=val.split(';; ').map{|q| q.split(', ')}.map{|q| [q[0],q[1].to_i]} unless val.nil? || val.length<=0 || val=='-'; end
  def copy_mats=(val); @copy_mats=[]; @copy_mats=val.split(';; ').map{|q| q.split(', ')}.map{|q| [q[0],q[1].to_i]} unless val.nil? || val.length<=0 || val=='-'; end
  def ability_mats=(val); @ability_mats=[]; @ability_mats=val.split(';; ').map{|q| q.split(', ')}.map{|q| [q[0],q[1].to_i]} unless val.nil? || val.length<=0 || val=='-'; end
  def bonus_mats=(val); @bonus_mats=[]; @bonus_mats=val.split(';; ').map{|q| q.split(', ')}.map{|q| [q[0],q[1].to_i]} unless val.nil? || val.length<=0 || val=='-'; end
  def refinement_mats=(val); @refinement_mats=[]; @refinement_mats=val.split(';; ').map{|q| q.split(', ')}.map{|q| [q[0],q[1].to_i]} unless val.nil? || val.length<=0 || val=='-'; end
  def post_refine_unbind_mats=(val); @post_refine_unbind_mats=[]; @post_refine_unbind_mats=val.split(';; ').map{|q| q.split(', ')}.map{|q| [q[0],q[1].to_i]} unless val.nil? || val.length<=0 || val=='-'; end
  def x_mats=(val); @x_mats=[]; @x_mats=val.split(';; ').map{|q| q.split(', ')}.map{|q| [q[0],q[1].to_i]} unless val.nil? || val.length<=0 || val=='-'; end
  
  def sort_data=(val); @sort_data=val; end
  def objt; return 'Weapon'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def stat_emotes
    return ['<:HP_S:514712247503945739>','<:MagicS:514712247289774111>','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Really_Sacred_Coin:571011997609754624>','<:Resource_Structure:510774545154572298>'] if @games[0]=='FEH' && ['Staff','Wand'].include?(@type)
    return ['<:HP_S:514712247503945739>','<:StrengthS:514712248372166666>','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Really_Sacred_Coin:571011997609754624>','<:Resource_Structure:510774545154572298>'] if @games[0]=='FEH'
    return ['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','<:Limited:574682514585550848>','<:LimitBroken:574682514921095212>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>'] if @games[0]=='FGO'
    return ['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>'] if @games[0]=='MM'
    return ['<:HP:573344832307593216>','<:Strength:573344931205349376>','<:NonUnbound:534494090876682264>','<:Unbind:534494090969088000>','<:Resource_Rupies:532104504372363274>','<:Resource_Eldwater:532104503777034270>']
  end
  
  def class_header(bot,emotesonly=0,includerarity=false,includeobjt=false)
    emtz=[]; str=''
    if includerarity
      rar=$rarity_stars[0][@rarity]
      rar=FEH_rarity_stars[@rarity] if @games[0]=='FEH'
      rar=FGO_rarity_stars[@rarity] if @games[0]=='FGO'
      emtz.push(rar)
      str=generate_rarity_row(@rarity,0,@games[0])
      str="#{str} - T#{@tier}" unless @tier.nil? || @tier<=0
    end
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{@element.gsub('None','Null')}"}
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{@element.gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Anima')}"} if @games[0]=='FEH'
    emtz.push(moji[0].mention) unless moji.length<=0
    str="#{str}#{"\n" if str.length>0}#{moji[0].mention unless moji.length<=0} **#{@element}**" unless @element.nil? || @element.length<=0 || @element=='None'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Weapon_#{@type}"}
    if @games[0]=='FEH'
      color='Colorless'; wpn='Unknown'; srv=443172595580534784
      color='Red' if ['Flame'].include?(@element)
      color='Blue' if ['Water'].include?(@element)
      color='Green' if ['Wind'].include?(@element)
      color='Gold' if ['Light'].include?(@element) && false
      if ['Sword','Lance','Axe','Blade'].include?(@type)
        wpn='Blade'
        color='Red' if @type=='Sword'
        color='Blue' if @type=='Lance'
        color='Green' if @type=='Axe'
        color='Gold' if @type=='Blade'
      elsif @type=='Wand'
        wpn='Tome'; srv=497429938471829504
        srv=575426885048336388 if @element=='Water'
        color=@element.gsub('Shadow','Dark').gsub('Flame','Fire')
      elsif @type=='Manacaster'
        color='Summon'; wpn='Gun'
      else
        wpn="#{@type}"
      end
      moji=bot.server(srv).emoji.values.reject{|q| q.name != "#{color}_#{wpn}"}
    elsif @games[0]=='FGO'
      c='unknown'
      c='saber' if @type=='Sword'
      c='blade' if @type=='Blade'
      c='extra' if @type=='Dagger'
      c='berserker' if @type=='Axe'
      c='archer' if @type=='Bow'
      c='lancer' if @type=='Lance'
      c='caster' if @type=='Wand'
      c='healer' if @type=='Staff'
      c='mooncancer' if @type=='Manacaster'
      srv=523821178670940170
      srv=523825319916994564 if ['Staff','Blade'].include?(@type)
      clr='gold'
      clr='silver' if @rarity==4
      clr='bronze' if @rarity<4
      moji=bot.server(srv).emoji.values.reject{|q| q.name != "class_#{c}_#{clr}"}
    end
    cha="\n"
    cha='   ' if emotesonly<0
    emtz.push(moji[0].mention) unless moji.length<=0
    str="#{str}#{cha}#{moji[0].mention unless moji.length<=0}**#{@type}**"
    if @games[0]=='FEH'
      str="#{str}\n<:Great_Badge_Golden:443704781068959744>**FEH Collab**"
      emtz.push('<:Great_Badge_Golden:443704781068959744>')
    elsif @games[0]=='FGO'
      str="#{str}\n<:Bond:613804021119189012>**FGO Collab**"
      emtz.push('<:Bond:613804021119189012>')
    elsif @games[0]=='MM'
      str="#{str}\n<:Mega_Man:641484836304846857>**Mega Man Collab**"
      emtz.push('<:Mega_Man:641484836304846857>')
    elsif @games[0]=='MH'
      str="#{str}\n<:MH_Rathalos:669319247670804506>**Monster Hunter Collab**"
      emtz.push('<:MH_Rathalos:669319247670804506>')
    elsif @games[0]=='PC'
      str="#{str}\n<:Priconne:782554046887493652>**Princess Connect Re:Dive Collab**"
      emtz.push('<:Priconne:782554046887493652>')
    elsif @games[0]=='P5S'
      str="#{str}\n<:Take_Your_Heart:782553893204262923>**Persona 5 Strikers Collab**"
      emtz.push('<:Take_Your_Heart:782553893204262923>')
    elsif @availability.include?('c') || @games.length>0
      str="#{str}\n**Collab**"
    else
      cha="\n"
    end
    lookout=$skilltags.reject{|q| q[2]!='Availability' && q[2]!='Availability/Weapon'}.map{|q| [q[0],q[1],'x',q[3],q[4]]}.uniq
    for i in 0...lookout.length
      if @availability.include?(lookout[i][3])
        if !lookout[i][4].nil? && lookout[i][4].include?('<')
          str="#{str}#{cha}#{lookout[i][4]}**#{lookout[i][0]}**"
        else
          str="#{str}#{cha}**#{lookout[i][0]}**"
        end
        cha='   ' if emotesonly<0
      end
    end
    str="#{str}#{cha}**Seasonal**" if !@availability.nil? && @availability.include?('s')
    str="#{str}\n**Wyrmprint slots:** #{@print_slots[0]}<:Weapon_Slot_Gold:758940716427902996>, #{@print_slots[1]}<:Weapon_Slot_Silver:758940716436815872>" unless @print_slots.nil?
    if has_any?(['a','h'],@availability)
      str="#{str}\n**Weapon Bonus:** #{self.stat_emotes[0]}+1.5% #{self.stat_emotes[1]}+1.5%"
    elsif @availability.include?('m')
      str="#{str}\n**Weapon Bonus:** #{self.stat_emotes[0]}+0.5% #{self.stat_emotes[1]}+0.5%"
    elsif (@availability.nil? || @availability.length<=0) && ![nil,'',' ','-','None','Null'].include?(@element)
      str="#{str}\n**Weapon Bonus:** #{self.stat_emotes[0]}+0.5% #{self.stat_emotes[1]}+0.5%"
    end
    return emtz if emotesonly==2
    return emtz.join('') if emotesonly==1
    return str
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return self.class_header(bot,1,includerarity,includeobjt); end
  
  def thumbnail(ext=0)
    dispname=@name.gsub(' ','_')
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/Weapons/#{dispname}.png?raw=true"
  end
  
  def disp_color(chain=0)
    f=[]
    xcolor=0x849294
    xcolor=0xE73031 if @element=='Flame'
    xcolor=0x1890DE if @element=='Water'
    xcolor=0x00D771 if @element=='Wind'
    xcolor=0xFFB90F if @element=='Light'
    xcolor=0xA637DE if @element=='Shadow'
    f.push(xcolor)
    return f[0] if chain>=f.length
    return f[chain]
  end
  
  def stat_grid(bot,fullsize=2,mub=false)
    c=self.stat_emotes.map{|q| q}
    l=[1,30*@rarity-70,30*@rarity-50]
    l=[1,5*@rarity,20*@rarity-10] if @rarity<3
    l=[1,100,200] if @rarity>5
    sklz=$skills.map{|q| q}
    skl1=sklz.find_index{|q| q.name==@skills[0]}
    skl1=sklz[skl1] unless skl1.nil?
    if fullsize>1 && !skl1.nil?
      str="__#{c[2]*4} **Level #{l[0]}**__"
      str="#{str}\n#{c[0]}*HP:*\u00A0\u00A0#{@hp[0]}  #{c[1]}*Str:*\u00A0\u00A0#{@str[0]}"
      str="#{str}\n*#{skl1.name}#{skl1.energy_display(false)} [#{skl1.level_text(1,-1,true)}]* - #{skl1.sp_display(1)} SP"
      str="#{str}\n#{@abilities.map{|q| q[0]}.join("\n")}" unless @abilities.length<=0
      unless @hp.length<3 || @str.length<3
        s=[@hp[1]*1,@str[1]*1]
        s[0]=@hp[0]+(@hp[2]-@hp[0])*(l[1]-1)/(l[2]-1) if s[0]<=0
        s[1]=@str[0]+(@str[2]-@str[0])*(l[1]-1)/(l[2]-1) if s[1]<=0
        str="#{str}\n\n__#{c[2]*4} **Level #{l[1]}**__"
        str="#{str}\n*#{skl1.name}#{skl1.energy_display(false)} [#{skl1.level_text(1,-1,true)}]* - #{skl1.sp_display(1)} SP"
        str="#{str}\n#{c[0]}*HP:*\u00A0\u00A0#{s[0]} #{c[1]}*Str:*\u00A0\u00A0#{s[1]}"
        str="#{str}\n#{@abilities.map{|q| q[1]}.join("\n")}" unless @abilities.length<=0
      end
      str="#{str}\n\n__#{c[3]*4} **Level #{l[2]}**__"
      str="#{str}\n#{c[0]}*HP:*\u00A0\u00A0#{@hp[-1]} #{c[1]}*Str:*\u00A0\u00A0#{@str[-1]}"
      str="#{str}\n*#{skl1.name}* (#{'%.1f' % skl1.invulnerability} sec. invul#{", #{skl1.energy_display}" if skl1.energy_display.length>0})"
      str="#{str} - #{skl1.sp_display(1)} SP" unless skl1.sp_display(0).uniq.length>1
      str="#{str}\n#{skl1.description[-1]}"
      str="#{str}\n#{@abilities.map{|q| q[-1]}.join("\n")}" unless @abilities.length<=0
    else
      unless fullsize==1
        unless fullsize<0 && mub
          str="#{c[2]*4} **Level #{l[0]}:**  #{c[0]}*HP:*\u00A0\u00A0#{@hp[0]}  #{c[1]}*Str:*\u00A0\u00A0#{@str[0]}"
          str="#{str}\n#{c[2]*4} **Level #{l[1]}:**  #{c[0]}*HP:*\u00A0\u00A0#{@hp[1]} #{c[1]}*Str:*\u00A0\u00A0#{@str[1]}" unless @hp.length<3 || @str.length<3 || (@hp[1]<=0 && @str[1]<=0)
        end
        str="#{str}#{"\n" unless fullsize<0 && mub}#{c[3]*4} **Level #{l[2]}:**  #{c[0]}*HP:*\u00A0\u00A0#{@hp[-1]} #{c[1]}*Str:*\u00A0\u00A0#{@str[-1]}" unless fullsize<0 && !mub
      end
      if fullsize>0
        str='' if fullsize==1
        unless skl1.nil?
          str="#{str}#{"\n" unless fullsize==1}*#{skl1.name}* (#{'%.1f' % skl1.invulnerability} sec. invul#{", #{skl1.energy_display}" if skl1.energy_display.length>0})"
          str="#{str} - #{skl1.sp_display(1)} SP" unless skl1.sp_display(0).uniq.length>1
          str="#{str}\n#{skl1.description[-1]}"
        end
        str="#{str}#{"\n" unless str.length<=0}**Abilities:** #{@abilities.map{|q| q[-1]}.join(', ')}" unless @abilities.length<=0
      end
    end
    return str
  end
  
  def mini_header(bot,substats=false)
    str=self.class_header(bot,3,false)
    l=[1,30*@rarity-70,30*@rarity-50]
    l=[1,5*@rarity,20*@rarity-10] if @rarity<3
    l=[1,100,200] if @rarity>5
    str=str.split("\n").reject{|q| q.length<=0}
    c=self.stat_emotes.map{|q| q}
    unless str[0].include?('   ') || str.length<=1 || str[1].include?('   ') || str[1].include?('Wyrmprint') || str[1].include?('Weapon')
      str[1]="#{str[0]}   #{str[1]}"
      str=str[1,str.length-1]
    end
    if substats
      str="#{str[0]}\n**Lv.#{l[1]}:**  #{c[0]}*HP:*\u00A0\u00A0#{@hp[1]} #{c[1]}*Str:*\u00A0\u00A0#{@str[1]}#{"\n#{str[1,str.length-1].join("\n")}" unless str.length<=1}"
    else
      str="#{str[0]}\n**Lv.#{l[2]}:**  #{c[0]}*HP:*\u00A0\u00A0#{@hp[-1]} #{c[1]}*Str:*\u00A0\u00A0#{@str[-1]}#{"\n#{str[1,str.length-1].join("\n")}" unless str.length<=1}"
    end
    return str
  end
  
  def promotions
    return $weapons.reject{|q| q.promotes_from != @id}
  end
  
  def promoted_from
    return nil if @promotes_from<=0
    x=$weapons.find_index{|q| q.id==@promotes_from}
    return nil if x.nil?
    return $weapons[x]
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!=self.objt || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    unless saliases || !safe_to_spam?(event)
      mnm=[@element]
      mnm.push('Fire') if @element=='Flame'
      mnm.push('Dark') if @element=='Shadow'
      mnm2=[@type]
      mnm2.push('Spear') if @type=='Lance'
      mnm2.push('Katana') if @type=='Blade'
      mnm2.push('Rod') if @type=='Wand'
      data_load(['tags'])
      lists=$skilltags.reject{|q| q[2]!='Availability/Weapon'}.map{|q| [q[3],q[1]]}
      f=[]
      for i in 0...mnm.length
        for i2 in 0...mnm2.length
          if has_any?(@availability,lists.map{|q| q[0]}) || @element=='None'
          elsif !@availability.include?('p') && !@availability.include?('s')
            f.push("#{@rarity}\\*#{mnm[i]}#{mnm2[i2]}")
            f.push("#{@rarity}\\*#{mnm2[i2]}#{mnm[i]}")
            f.push("#{mnm[i]}#{@rarity}\\*#{mnm2[i2]}")
            f.push("#{mnm2[i2]}#{@rarity}\\*#{mnm[i]}")
            f.push("#{mnm[i]}#{mnm2[i2]}#{@rarity}\\*")
            f.push("#{mnm2[i2]}#{mnm[i]}#{@rarity}\\*")
          else
            mnm3=lists[lists.find_index{|q| q[0]==@availability}][1]
            mnm3=mnm3.reject{|q| q[-1]=='s' && mnm3.include?(q[0,q.length-1])}
            mnm3=mnm3.map{|q| "#{q[0].upcase}#{q[1,q.length-1].downcase}"}
            for i3 in 0...mnm3.length
              f.push("#{mnm3[i3]}#{@rarity}\\*#{mnm[i]}#{mnm2[i2]}")
              f.push("#{mnm3[i3]}#{@rarity}\\*#{mnm2[i2]}#{mnm[i]}")
              f.push("#{mnm3[i3]}#{mnm[i]}#{@rarity}\\*#{mnm2[i2]}")
              f.push("#{mnm3[i3]}#{mnm2[i2]}#{@rarity}\\*#{mnm[i]}")
              f.push("#{mnm3[i3]}#{mnm[i]}#{mnm2[i2]}#{@rarity}\\*")
              f.push("#{mnm3[i3]}#{mnm2[i2]}#{mnm[i]}#{@rarity}\\*")
              f.push("#{@rarity}\\*#{mnm3[i3]}#{mnm[i]}#{mnm2[i2]}")
              f.push("#{@rarity}\\*#{mnm3[i3]}#{mnm2[i2]}#{mnm[i]}")
              f.push("#{mnm[i]}#{mnm3[i3]}#{@rarity}\\*#{mnm2[i2]}")
              f.push("#{mnm2[i2]}#{mnm3[i3]}#{@rarity}\\*#{mnm[i]}")
              f.push("#{mnm[i]}#{mnm3[i3]}#{mnm2[i2]}#{@rarity}\\*")
              f.push("#{mnm2[i2]}#{mnm3[i3]}#{mnm[i]}#{@rarity}\\*")
              f.push("#{@rarity}\\*#{mnm[i]}#{mnm3[i3]}#{mnm2[i2]}")
              f.push("#{@rarity}\\*#{mnm2[i2]}#{mnm3[i3]}#{mnm[i]}")
              f.push("#{mnm[i]}#{@rarity}\\*#{mnm3[i3]}#{mnm2[i2]}")
              f.push("#{mnm2[i2]}#{@rarity}\\*#{mnm3[i3]}#{mnm[i]}")
              f.push("#{mnm[i]}#{mnm2[i2]}#{mnm3[i3]}#{@rarity}\\*")
              f.push("#{mnm2[i2]}#{mnm[i]}#{mnm3[i3]}#{@rarity}\\*")
              f.push("#{@rarity}\\*#{mnm[i]}#{mnm2[i2]}#{mnm3[i3]}")
              f.push("#{@rarity}\\*#{mnm2[i2]}#{mnm[i]}#{mnm3[i3]}")
              f.push("#{mnm[i]}#{@rarity}\\*#{mnm2[i2]}#{mnm3[i3]}")
              f.push("#{mnm2[i2]}#{@rarity}\\*#{mnm[i]}#{mnm3[i3]}")
              f.push("#{mnm[i]}#{mnm2[i2]}#{@rarity}\\*#{mnm3[i3]}")
              f.push("#{mnm2[i2]}#{mnm[i]}#{@rarity}\\*#{mnm3[i3]}")
            end
          end
        end
      end
      k.unshift(f)
      k.flatten!
    end
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}#{self.emotes(bot,true)}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class DLEnemy
  attr_accessor :name
  attr_accessor :stats
  attr_accessor :element,:tribe,:subdata,:event
  attr_accessor :weaknesses,:afflictions
  attr_accessor :abilities
  attr_accessor :sort_data
  
  def initialize(val)
    @name=val
    @abilities=[]
  end
  
  def name=(val); @name=val; end
  def weaknesses=(val); @weaknesses=val; end
  def afflictions=(val); @afflictions=val; end
  def abilities=(val); @abilities=[]; @abilities=val.split(';; ') unless val.nil? || val.length<=0 || val=='-'; end
  
  def stats=(val)
    val=val.split('; ').map{|q| q.split(', ')}
    for i in 0...val.length
      val[i][1]=val[i][1].to_i
      val[i][2]=val[i][2].to_i
    end
    @stats=val.map{|q| q}
  end
  
  def data=(val)
    val=val.split(', ')
    @element=val[0]
    @tribe=val[1]
    @subdata=val[2]
    @event=val[3] unless val.length<4
  end
  
  def sort_data=(val); @sort_data=val; end
  def objt; return 'Enemy'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def stat_emotes
    return ['<:HP_S:514712247503945739>','<:MagicS:514712247289774111>','Magic'] if !@event.nil? && @event[0,11]=='Fire Emblem'
    return ['<:HP_S:514712247503945739>','<:StrengthS:514712248372166666>','Strength'] if !@event.nil? && @event[0,11]=='Fire Emblem'
    return ['<:FGO_HP:653485372168470528>','<:FGO_Atk:653485372231122944>','Attack'] if !@event.nil? && false
    return ['<:ETank:641613198755364864>','<:ZSaber:641613201884053504>','Strength'] if !@event.nil? && @event[0,8]=='Mega Man'
    return ['<:HP:573344832307593216>','<:Strength:573344931205349376>','Strength']
  end
  
  def class_header(bot,emotesonly=0,includerarity=false,includeobjt=false)
    emtz=[]; str=''
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{@element.gsub('None','Null')}"}
    moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Boost_#{@element.gsub('Shadow','Dark').gsub('Flame','Fire').gsub('None','Null')}"} if !@event.nil? && @event[0,11]=='Fire Emblem'
    emtz.push(moji[0].mention) unless moji.length<=0
    str="#{moji[0].mention unless moji.length<=0} **Element:** #{@element}" unless ['High Dragon','Void','Imperial Order'].include?(@subdata)
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Tribe_#{@tribe}"}
    if !@event.nil? && @event[0,11]=='Fire Emblem'
      moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Icon_Move_Infantry"}
      moji=bot.server(443181099494146068).emoji.values.reject{|q| q.name != "Icon_Move_Armor"}unless @name.include?('(Enemy)')
    end
    emtz.push(moji[0].mention) unless moji.length<=0
    str="#{str}#{"\n" if str.length>0}#{moji[0].mention unless moji.length<=0} **Tribe:** #{@tribe}"
    if @event.nil?
    elsif @event[0,11]=='Fire Emblem'
      emtz.push('<:Great_Badge_Golden:443704781068959744>')
    elsif false
      emtz.push('<:Bond:613804021119189012>')
    elsif @event[0,8]=='Mega Man'
      emtz.push('<:Mega_Man:641484836304846857>')
    elsif @event[0,14]=='Monster Hunter'
      emtz.push('<:MH_Rathalos:669319247670804506>')
    elsif @event[0,24]=='Princess Connect Re:Dive' || @event[0,8].downcase=='priconne'
      emtz.push('<:Priconne:782554046887493652>')
    elsif @event[0,9]=='Persona 5'
      emtz.push('<:Take_Your_Heart:782553893204262923>')
    end
    return emtz if emotesonly==2
    return emtz.join('') if emotesonly==1
    return str
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return self.class_header(bot,1,includerarity,includeobjt); end
  
  def thumbnail(ext=0)
    return 'https://github.com/Rot8erConeX/BotanBot/blob/master/FightBanners/Matilda_5.png?raw=true' if @name=='Matilda'
    dispname=@name.gsub(' ','_')
    m=false
    IO.copy_stream(open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/FightBanners/Banner_#{dispname}.png"), "#{$location}devkit/DLTemp#{Shardizard}.png") rescue m=true
    if File.size("#{$location}devkit/DLTemp#{Shardizard}.png")<=100 || m
      dispname="#{dispname.gsub('_(Enemy)','')}"
    end
    return [nil,"https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/FightBanners/Banner_#{dispname}.png"]
  end
  
  def disp_color(chain=0)
    f=[]
    xcolor=0xE3F78B
    xcolor=0xEF8663 if @tribe=='Thaumian'
    xcolor=0x5AD363 if @tribe=='Physian'
    xcolor=0xAD9087 if @tribe=='Therion'
    xcolor=0x271B2F if @tribe=='Dragon'
    xcolor=0x3B4DBB if @tribe=='Demon'
    xcolor=0x495218 if @tribe=='Demihuman'
    xcolor=0xFFDC5D if @tribe=='Human'
    xcolor=0xAD82DE if @tribe=='Undead'
    f.push(xcolor)
    xcolor=nil
    xcolor=0xE73031 if @element=='Flame'
    xcolor=0x1890DE if @element=='Water'
    xcolor=0x00D771 if @element=='Wind'
    xcolor=0xFFB90F if @element=='Light'
    xcolor=0xA637DE if @element=='Shadow'
    f.push(xcolor) unless xcolor.nil?
    return f[0] if chain>=f.length
    return f[chain]
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!=self.objt || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}#{self.emotes(bot,true)}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class DLGauntlet
  attr_accessor :name
  attr_accessor :element,:stage
  attr_accessor :hp,:str
  attr_accessor :tribe,:subdata,:event
  attr_accessor :weaknesses,:afflictions
  attr_accessor :abilities
  attr_accessor :reward
  attr_accessor :sort_data
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
  def element=(val); @element=val; end
  def stage=(val); @stage=val.to_i; end
  def tribe=(val); @tribe=val; end
  def subdata=(val); @subdata=val; end
  def event=(val); @event=val; end
  def weaknesses=(val); @weaknesses=val; end
  def afflictions=(val); @afflictions=val; end
  def abilities=(val); @abilities=val.split(';; '); end
  def reward=(val); @reward=val; end
  
  def hp=(val); @hp=val.to_i; end
  def str=(val); @str=val.to_i; end
  
  def sort_data=(val); @sort_data=val; end
  def objt; return 'Gauntlet'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
end

# secondary entities

class DLSkill
  attr_accessor :name
  attr_accessor :description
  attr_accessor :mass_description
  attr_accessor :sp_cost,:sp_oddity
  attr_accessor :sharing
  attr_accessor :energize,:nihilimmune
  attr_accessor :invulnerability
  attr_accessor :tags
  attr_accessor :sort_data
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
  def description=(val); @description=val; end
  def mass_description=(val); @mass_description=val; end
  def sharing=(val); @sharing=val.split(', ').map{|q| q.to_i}; end
  def invulnerability=(val); @invulnerability=val.to_f; end
  def tags=(val); @tags=val.split(', '); end
  
  def sp_cost=(val)
    val=val.split(', ')
    @sp_cost=val[0,5].map{|q| q.to_i}
    @sp_oddity=[]
    if val.length>5
      val=val[5,val.length-5]
      for i in 0...val.length/7
        m=val[7*i,7].map{|q| q.to_i}
        m[0]=val[7*i]
        @sp_oddity.push(m.map{|q| q})
      end
    end
  end
  
  def energize=(val)
    @energize=false; @energize=true if val.split(', ')[0]=='Yes'
    @nihilimmune=nil
    unless val.split(', ').length<1
      @nihilimmune=false if val.split(', ')[1]=='No'
      @nihilimmune=true if val.split(', ')[1]=='Yes'
    end
  end
  
  def sort_data=(val); @sort_data=val; end
  def objt; return 'Skill'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return ''; end
  
  def inspirable?
    return false unless @tags.include?('Damage')
    return true
  end
  
  def energy_display(full=true)
    e=''; txt=[]
    if @energize
      e='<:Energize:559629242137051155>'
      txt.push('Energizable')
    end
    if self.inspirable?
      e='<:Inspiring:688916587079663625>'
      txt.push('Inspirable')
    end
    e='<:Energation:688920529771692078>' if @energize && self.inspirable?
    e="#{e}#{txt.join('/')}" if full
    if @nihilimmune==true
      e="#{e} + Nihil-immune"
    elsif @nihilimmune.nil?
      e="#{e} + partial Nihil-immune"
    end
    return e
  end
  
  def sp_display(level=0)
    return [self.sp_display(1),self.sp_display(2),self.sp_display(3),self.sp_display(4),self.sp_display(5)] if level==0
    return '' if level<0 && (@sharing.nil? || @sharing.length<=0)
    xlevel=level*1
    level=-1 if level<0
    x=@sp_cost[level-1]*1
    x=@sharing[1]*1 if level<0
    x2=x*1
    x2=23*x/20 if xlevel==-2
    x2=13*x/10 if xlevel==-3
    m=[x2]
    unless @sp_oddity.nil? || @sp_oddity.length<=0 || (@sp_oddity.map{|q| q[level]}.uniq.length<=1 && @sp_oddity[0][level]==x)
      for i in 0...@sp_oddity.length
        if xlevel==-2
          m.push(@sp_oddity[i][level]*23/20)
        elsif xlevel==-3
          m.push(@sp_oddity[i][level]*13/10)
        else
          m.push(@sp_oddity[i][level]*1)
        end
      end
    end
    return m.map{|q| longFormattedNumber(q)}.join("\u2192")
  end
  
  def share_text
    return '' if @sharing.nil? || @sharing.length<=0
    return "#{@sharing[0]}<:SkillShare:714597012733034547> / #{self.sp_display(-1)} SP when shared"
  end
  
  def level_text(l,f,long=false)
    if l<=0
      m=[]
      for i in 0...@description.length
        m.push(self.level_text(i+1,-1,long))
      end
      return m.join(" \u2192 ")
    end
    return "Lv.#{l}" if long && f<0
    return "Lv.#{l}/Floor #{f}" if long
    str="Lv.#{l}"
    m=[]
    m.push("F#{f}") if f>=0
    m.push("#{self.sp_display(l)} SP") if self.sp_display(0).uniq.length>1
    str="#{str} (#{m.join(', ')})" if m.length>0
    return str
  end
  
  def thumbnail(ext=0)
    dispname=@name.gsub(' ','_')
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/Skills/#{dispname}.png?raw=true"
  end
  
  def disp_color(chain=0)
    f=[]
    xcolor=0x02010a
    xcolor=0xE73031 if self.element=='Flame'
    xcolor=0x1890DE if self.element=='Water'
    xcolor=0x00D771 if self.element=='Wind'
    xcolor=0xFFB90F if self.element=='Light'
    xcolor=0xA637DE if self.element=='Shadow'
    f.push(xcolor) unless xcolor.nil?
    return f[0] if chain>=f.length
    return f[chain]
  end
  
  def element
    m=[]
    m.push('Flame') if @description[0].downcase.include?('flame damage')
    m.push('Water') if @description[0].downcase.include?('water damage')
    m.push('Wind') if @description[0].downcase.include?('wind damage')
    m.push('Light') if @description[0].downcase.include?('light damage')
    m.push('Shadow') if @description[0].downcase.include?('shadow damage')
    return m[0] if m.length==1
    return 'None'
  end
  
  def energy_emoji(pad=false)
    e=[]; ins=[]
    k=@tags.map{|q| q}
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
  
  def emotes(bot,includerarity=true,includeobjt=false)
    return '' if self.element=='None'
    moji=bot.server(532083509083373579).emoji.values.reject{|q| q.name != "Element_#{self.element}"}
    return moji[0].mention unless moji.length<=0
    return ''
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!=self.objt || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}#{self.emotes(bot,true)}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class DLAbility
  attr_accessor :name,:level
  attr_accessor :type
  attr_accessor :description
  attr_accessor :weight,:show
  attr_accessor :tags
  attr_accessor :nihilimmune
  
  def initialize(val,val2)
    @name=val
    @level=val2
  end
  
  def name=(val); @name=val; end
  def level=(val); @level=val; end
  def description=(val); @description=val.gsub(';; ',"\n"); end
  def weight=(val); @weight=val.to_i; end
  def show=(val); @show=false; @show=true if ['y','yes'].include?(val.downcase); end
  def tags=(val); @tags=[]; @tags=val.split(', ') unless val.nil? || val.length<=0 || val=='-'; end
  def objt; return 'Ability'; end
  
  def nihilimmune=(val)
    @nihilimmune=nil
    @nihilimmune=false if val=='No'
    @nihilimmune=true if val=='Yes'
  end
  
  def fullName(format=nil,justlast=false,sklz=nil)
    x="#{@name}"
    x="#{format}#{x}#{format.reverse}" unless format.nil?
    return x if ['-'].include?(@level) || @level.nil?
    return x if ['example'].include?(@level) && format.nil? && !justlast
    skz=$abilities.reject{|q| q.name != @name || q.level=='example' || q.type != @type}
    skz=sklz.reject{|q| q.name != @name || q.level=='example' || q.type != @type} unless sklz.nil?
    char='/'
    char=' / ' if skz.reject{|q| !q.level.include?('/')}.length>0
    if skz.length>5
      skz=[skz[0],skz[-1]]
      char=" \u2192 "
    end
    if @name[0,7]=='Hits = '
      x=" #{x}"
      return "#{@level}#{x}" unless @level=='example'
      return "#{x}" if justlast && skz.length<=0
      return "#{skz[-1].level}#{x}" if justlast
      return "#{skz.map{|q| q.level}.join(char)}#{x}"
    else
      skz=[self.clone] if skz.nil? || skz.length<=0
      x="#{x} #{'+' if skz[-1].level.include?('%')}" unless @name[-1]=='+'
      return "#{x}#{@level}" unless @level=='example'
      return "#{x}" if justlast && skz.length<=0
      return "#{x}#{skz[-1].level}" if justlast
      return "#{x}#{skz.map{|q| q.level}.join(char)}"
    end
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return ''; end
  
  def disp_color(chain=0)
    f=[]
    xcolor=0x02010a
    xcolor=0xE73031 if @name.include?('(Flame)')
    xcolor=0x1890DE if @name.include?('(Water)')
    xcolor=0x00D771 if @name.include?('(Wind)')
    xcolor=0xFFB90F if @name.include?('(Light)')
    xcolor=0xA637DE if @name.include?('(Shadow)')
    f.push(xcolor) unless xcolor.nil?
    return f[0] if chain>=f.length
    return f[chain]
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!='Ability' || ![@name,self.fullName].include?(q[2])}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{self.fullName}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
  
  def thumbnail(ext=0)
    dispname=@name.split(') ')[-1].gsub(' ','_').gsub('%','')
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/Abilities/#{dispname}.png?raw=true"
  end
  
  def adv_list(bot,event,dispslots=false,dispsubabils=false,onlyone=false)
    return [] if @type=='Aura'
    adv=$adventurers.map{|q| q.clone}
    s2s=false
    s2s=true if safe_to_spam?(event)
    list=[]
    if @type=='Ability'
      for i in 0...adv.length
        t=[]
        if dispsubabils && (s2s || onlyone)
          for i2 in 0...adv[i].abilities.length
            if adv[i].abilities[i2].length==1
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1})" if dispslots}") if adv[i].abilities[i2][0]==self.fullName
            elsif adv[i].abilities[i2].length==2
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if adv[i].abilities[i2][0]==self.fullName
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i].abilities[i2][1]==self.fullName
            else
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if adv[i].abilities[i2][0]==self.fullName
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}#{' [med]' unless dispslots}") if adv[i].abilities[i2][1]==self.fullName
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2083)" if dispslots}#{' [Max]' unless dispslots}") if adv[i].abilities[i2][2]==self.fullName
            end
          end
          unless adv[i].hidden_abilities.nil?
            for i2 in 0...adv[i].hidden_abilities.length
              if adv[i].hidden_abilities[i2].length==1
                t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name} (HA)") if adv[i].hidden_abilities[i2][0]==self.fullName
              elsif adv[i].hidden_abilities[i2].length==2
                t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2081)" if dispslots}#{' [HA-min]' unless dispslots}") if adv[i].hidden_abilities[i2][0]==self.fullName
                t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2082)" if dispslots}#{' [HA-Max]' unless dispslots}") if adv[i].hidden_abilities[i2][1]==self.fullName
              else
                t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2081)" if dispslots}#{' [HA-min]' unless dispslots}") if adv[i].hidden_abilities[i2][0]==self.fullName
                t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2082)" if dispslots}#{' [HA-med]' unless dispslots}") if adv[i].hidden_abilities[i2][1]==self.fullName
                t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2083)" if dispslots}#{' [HA-Max]' unless dispslots}") if adv[i].hidden_abilities[i2][2]==self.fullName
              end
            end
          end
        else
          m=adv[i].collapse_abilities
          for i2 in 0...m.length
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{m[i2][0]}" if dispslots}") if m[i2][1]==self.fullName
          end
          t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name} (HA)") if !adv[i].hidden_abilities.nil? && adv[i].hidden_abilities.map{|q| q[-1]}.include?(self.fullName)
        end
        if t.length>0
          for i2 in 0...t.length
            tt=adv[i].clone
            tt.name=t[i2]
            list.push(tt)
          end
        end
      end
    elsif ['CoAbility','Chain'].include?(@type)
      for i in 0...adv.length
        t=[]
        f=nil
        f=adv[i].coability if @type=='CoAbility'
        f=adv[i].chain if @type=='Chain'
        unless f.nil? || f.length<=0
          m=f.split(' ')
          mm=m[0,m.length-1].join(' ')
          m=m[-1].split('/').map{|q| "#{mm} #{'+' if q.include?('%')}#{q.gsub('+','')}"}
          t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name} [min]") if m[0]==self.fullName
          t.push("#{adv[i].class_header(bot,2)[0]}<:DLKey:692445248407863376>#{adv[i].name} [min]") if m[0]=="#{adv[i].element} #{self.fullName}"
          t.push("#{adv[i].class_header(bot,2)[1]}<:DLKey:692445248407863376>#{adv[i].name} [min]") if m[0]=="#{adv[i].weapon} #{self.fullName}"
          t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name} [Max]") if m[4]==self.fullName
          t.push("#{adv[i].class_header(bot,2)[0]}<:DLKey:692445248407863376>#{adv[i].name} [Max]") if m[4]=="#{adv[i].element} #{self.fullName}"
          t.push("#{adv[i].class_header(bot,2)[1]}<:DLKey:692445248407863376>#{adv[i].name} [Max]") if m[4]=="#{adv[i].weapon} #{self.fullName}"
        end
        if t.length>0
          for i2 in 0...t.length
            tt=adv[i].clone
            tt.name=t[i2]
            list.push(tt)
          end
        end
      end
    end
    return list
  end
  
  def drg_list(bot,event,dispslots=false,dispsubabils=false,onlyone=false)
    return [] if ['CoAbility','Chain','Ability'].include?(@type)
    adv=$dragons.map{|q| q.clone}
    s2s=false
    s2s=true if safe_to_spam?(event)
    list=[]
    for i in 0...adv.length
      ename=[self.fullName,"(#{adv[i].element}) #{self.fullName}"]
      t=[]
      if dispsubabils && (s2s || onlyone)
        for i2 in 0...adv[i].auras.length
          if adv[i].auras[i2].length==1
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1})" if dispslots}") if ename.include?(adv[i].auras[i2][0])
          elsif adv[i].auras[i2].length==2
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if ename.include?(adv[i].auras[i2][0])
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}#{' [Max]' unless dispslots}") if ename.include?(adv[i].auras[i2][1])
          elsif adv[i].auras[i2].length==3
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if ename.include?(adv[i].auras[i2][0])
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}#{' [med]' unless dispslots}") if ename.include?(adv[i].auras[i2][1])
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2083)" if dispslots}#{' [Max]' unless dispslots}") if ename.include?(adv[i].auras[i2][2])
          else
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if ename.include?(adv[i].auras[i2][0])
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}") if ename.include?(adv[i].auras[i2][1])
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2083)" if dispslots}#{' [med]' unless dispslots}") if ename.include?(adv[i].auras[i2][2])
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2084)" if dispslots}") if adv[i].auras[i2].length>4 && ename.include?(adv[i].auras[i2][3])
            t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}\u2085)" if dispslots}#{' [Max]' unless dispslots}") if ename.include?(adv[i].auras[i2][-1])
          end
        end
        unless adv[i].hidden_abilities.nil?
          for i2 in 0...adv[i].hidden_abilities.length
            if adv[i].hidden_abilities[i2].length==1
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name} (HA)") if ename.include?(adv[i].hidden_abilities[i2][0])
            elsif adv[i].hidden_abilities[i2].length==2
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2081)" if dispslots}#{' [HA-min]' unless dispslots}") if ename.include?(adv[i].hidden_abilities[i2][0])
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2082)" if dispslots}#{' [HA-Max]' unless dispslots}") if ename.include?(adv[i].hidden_abilities[i2][1])
            elsif adv[i].hidden_abilities[i2].length==3
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2081)" if dispslots}#{' [HA-min]' unless dispslots}") if ename.include?(adv[i].hidden_abilities[i2][0])
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2082)" if dispslots}#{' [HA-med]' unless dispslots}") if ename.include?(adv[i].hidden_abilities[i2][1])
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2083)" if dispslots}#{' [HA-Max]' unless dispslots}") if ename.include?(adv[i].hidden_abilities[i2][2])
            else
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2081)" if dispslots}#{' [HA-min]' unless dispslots}") if ename.include?(adv[i].hidden_abilities[i2][0])
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name} (HA\u2082)") if dispstats && ename.include?(adv[i].hidden_abilities[i2][1])
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2083)" if dispslots}#{' [HA-med]' unless dispslots}") if ename.include?(adv[i].hidden_abilities[i2][2])
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name} (HA\u2084)") if dispstats && adv[i].hidden_abilities[i2].length>4 && ename.include?(adv[i].hidden_abilities[i2][3])
              t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (HA\u2085)" if dispslots}#{' [HA-Max]' unless dispslots}") if ename.include?(adv[i].hidden_abilities[i2][-1])
            end
          end
        end
      elsif adv[i].auras.nil? || adv[i].auras.length<=0
      else
        m=adv[i].auras.map{|q| q[-1]}
        for i2 in 0...m.length
          t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name}#{" (A#{i2+1}" if dispslots}") if ename.include?(m[i2])
        end
        t.push("#{adv[i].class_header(bot,2)[0]}#{adv[i].name} (HA)") if !adv[i].hidden_abilities.nil? && has_any?(ename,adv[i].hidden_abilities.map{|q| q[-1]})
      end
      if t.length>0
        for i2 in 0...t.length
          tt=adv[i].clone
          tt.name=t[i2]
          list.push(tt)
        end
      end
    end
    return list
  end
  
  def print_list(bot,event,dispslots=false,dispsubabils=false,onlyone=false,exlength=0)
    return [] unless ['Ability'].include?(@type)
    adv=$wyrmprints.reject{|q| q.isMultiprint?}.map{|q| q.clone}
    s2s=false
    s2s=true if safe_to_spam?(event)
    list=[]
    elemo=[['Flame','<:Element_Flame:532106087952810005>'],['Water','<:Element_Water:532106088221376522>'],['Wind','<:Element_Wind:532106087948746763>'],
           ['Light','<:Element_Light:532106088129101834>'],['Shadow','<:Element_Shadow:532106088154267658>'],['Sword','<:Weapon_Sword:532106114540634113>'],
           ['Blade','<:Weapon_Blade:532106114628714496>'],['Dagger','<:Weapon_Dagger:532106116025286656>'],['Axe','<:Weapon_Axe:532106114188443659>'],
           ['Bow','<:Weapon_Bow:532106114909732864>'],['Lance','<:Weapon_Lance:532106114792423448>'],['Wand','<:Weapon_Wand:532106114985099264>'],
           ['Staff','<:Weapon_Staff:532106114733441024>'],['Manacaster','<:Weapon_Manacaster:758905122448867338>']]
    for i in 0...adv.length
      t=[]
      if dispsubabils && (s2s || onlyone)
        for i2 in 0...adv[i].abilities.length
          if adv[i].abilities[i2].length==1
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1})" if dispslots}") if adv[i].abilities[i2][0]==self.fullName
          elsif adv[i].abilities[i2].length==2
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if adv[i].abilities[i2][0]==self.fullName
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i].abilities[i2][1]==self.fullName
          elsif adv[i].abilities[i2].length==3
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if adv[i].abilities[i2][0]==self.fullName
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}#{' [med]' unless dispslots}") if adv[i].abilities[i2][1]==self.fullName
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}\u2083)" if dispslots}#{' [Max]' unless dispslots}") if adv[i].abilities[i2][2]==self.fullName
          else
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if adv[i].abilities[i2][0]==self.fullName
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}") if adv[i].abilities[i2][1]==self.fullName
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}\u2083)" if dispslots}#{' [med]' unless dispslots}") if adv[i].abilities[i2][2]==self.fullName
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}\u2084)" if dispslots}") if adv[i].abilities[i2].length>4 && adv[i].abilities[i2][3]==self.fullName
            t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}\u2085)" if dispslots}#{' [Max]' unless dispslots}") if adv[i].abilities[i2][-1]==self.fullName
          end
          for i3 in 0...elemo.length
            if adv[i].abilities[i2].length==1
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1})" if dispslots}") if adv[i].abilities[i2][0]=="#{elemo[i3][0]} #{self.fullName}"
            elsif adv[i].abilities[i2].length==2
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if adv[i].abilities[i2][0]=="#{elemo[i3][0]} #{self.fullName}"
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}#{' [Max]' unless dispslots}") if adv[i].abilities[i2][1]=="#{elemo[i3][0]} #{self.fullName}"
            elsif adv[i].abilities[i2].length==3
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if adv[i].abilities[i2][0]=="#{elemo[i3][0]} #{self.fullName}"
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}#{' [med]' unless dispslots}") if adv[i].abilities[i2][1]=="#{elemo[i3][0]} #{self.fullName}"
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}\u2083)" if dispslots}#{' [Max]' unless dispslots}") if adv[i].abilities[i2][2]=="#{elemo[i3][0]} #{self.fullName}"
            else
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if adv[i].abilities[i2][0]=="#{elemo[i3][0]} #{self.fullName}"
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}") if adv[i].abilities[i2][1]=="#{elemo[i3][0]} #{self.fullName}"
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}\u2083)" if dispslots}#{' [med]' unless dispslots}") if adv[i].abilities[i2][2]=="#{elemo[i3][0]} #{self.fullName}"
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}\u2084)" if dispslots}") if adv[i].abilities[i2].length>4 && adv[i].abilities[i2][3]=="#{elemo[i3][0]} #{self.fullName}"
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}\u2085)" if dispslots}#{' [Max]' unless dispslots}") if adv[i].abilities[i2][-1]=="#{elemo[i3][0]} #{self.fullName}"
            end
          end
        end
      else
        m=adv[i].abilities.map{|q| q[-1]}
        for i2 in 0...m.length
          t.push("<:Wyrmprint:560542319636381725>#{adv[i].name}#{" (A#{i2+1}" if dispslots}") if m[i2]==self.fullName
          if m[i2][0,1]=='('
            for i3 in 0...elemo.length
              t.push("#{elemo[i3][1]}#{adv[i].name}#{" (A#{i2+1}" if dispslots}") if m[i2]=="#{elemo[i3][0]} #{self.fullName}"
            end
          end
        end
      end
      if t.length>0
        for i2 in 0...t.length
          tt=adv[i].clone
          tt.name=t[i2]
          list.push(tt)
        end
      end
      if exlength<=0 && list.reject{|q| q.name.include?('<:Wyrmprint:560542319636381725>')}.length<=0
        for i in 0...list.length
          list[i].name=list[i].name.gsub('<:Wyrmprint:560542319636381725>','')
        end
      end
    end
    unless self.resonance_level(bot).nil? || !onlyone
      m=DLWyrmprint.new(self.resonance_level(bot))
      list.push(m)
    end
    return list
  end
  
  def wep_list(bot,event,dispslots=false,dispsubabils=false,onlyone=false)
    return [] unless ['Ability'].include?(@type)
    adv=$weapons.map{|q| q.clone}
    s2s=false
    s2s=true if safe_to_spam?(event)
    list=[]
    for i in 0...adv.length
      ename=[self.fullName,"(#{adv[i].element}) #{self.fullName}"]
      t=[]
      if dispsubabils && (s2s || onlyone)
        for i2 in 0...adv[i].abilities.length
          if adv[i].abilities[i2].length==1
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1})" if dispslots}") if ename.include?(adv[i].abilities[i2][0])
          elsif adv[i].abilities[i2].length==2
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if ename.include?(adv[i].abilities[i2][0])
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}#{' [Max]' unless dispslots}") if ename.include?(adv[i].abilities[i2][1])
          elsif adv[i].abilities[i2].length==3
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if ename.include?(adv[i].abilities[i2][0])
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}#{' [med]' unless dispslots}") if ename.include?(adv[i].abilities[i2][1])
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}\u2083)" if dispslots}#{' [Max]' unless dispslots}") if ename.include?(adv[i].abilities[i2][2])
          else
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}\u2081)" if dispslots}#{' [min]' unless dispslots}") if ename.include?(adv[i].abilities[i2][0])
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}\u2082)" if dispslots}") if ename.include?(adv[i].abilities[i2][1])
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}\u2083)" if dispslots}#{' [med]' unless dispslots}") if ename.include?(adv[i].abilities[i2][2])
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}\u2084)" if dispslots}") if adv[i].abilities[i2].length>4 && ename.include?(adv[i].abilities[i2][3])
            t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}\u2085)" if dispslots}#{' [Max]' unless dispslots}") if ename.include?(adv[i].abilities[i2][-1])
          end
        end
      elsif adv[i].abilities.nil? || adv[i].abilities.length<=0
      else
        m=adv[i].abilities.map{|q| q[-1]}
        for i2 in 0...m.length
          t.push("#{adv[i].class_header(bot,2)[0,2].reverse.join('')}#{adv[i].name}#{" (A#{i2+1}" if dispslots}") if ename.include?(m[i2])
        end
      end
      if t.length>0
        for i2 in 0...t.length
          tt=adv[i].clone
          tt.name=t[i2]
          list.push(tt)
        end
      end
    end
    return list
  end
  
  def enemy_list(bot,event,dispslots=false,dispsubabils=false,onlyone=false)
    m=$enemies.reject{|q| !q.abilities.include?(self.fullName)}.map{|q| q.clone}
    return m unless safe_to_spam?(event)
    for i in 0...m.length
      m[i].name="#{m[i].emotes(bot)}#{m[i].name}"
    end
    return m
  end
  
  def resonance_level(bot)
    return nil if $resonance.nil? || @type!='Ability'
    m=$resonance.find_index{|q| q[1,q.length-1].include?(self.fullName)}
    return nil if m.nil?
    m=$resonance[m]
    moji=bot.server(620710758841450529).emoji.values.reject{|q| q.name != "Affinity_#{m[0]}"}
    if moji.length>0
      str=moji[0].mention
    else
      str="#{m[0]} Affinity "
    end
    str="#{str}x#{m.find_index{|q| q==self.fullName}}"
    return str
  end
end

class DLFacility
  attr_accessor :name,:level
  attr_accessor :description
  attr_accessor :type,:subtype
  attr_accessor :size,:quantity
  attr_accessor :cost
  attr_accessor :mats
  attr_accessor :tags
  
  def initialize(val,val2)
    @name=val
    @level=val2.to_i unless val2.nil? || val2.length<=0 || val2=='-'
  end
  
  def name=(val); @name=val; end
  def level=(val); @level=nil; @level=val.to_i unless val.nil? || val.length<=0 || val=='-'; end
  def description=(val); @description=val unless val.nil? || val.length<=0 || val=='-'; end
  def size=(val); @size=val; end
  def quantity=(val); @quantity=val.to_i; end
  def cost=(val); @cost=val.to_i; end
  def mats=(val); @mats=[]; @mats=val.split(';; ').map{|q| q.split(', ')}.map{|q| [q[0],q[1].to_i]} unless val.nil? || val.length<=0 || val=='-' || val=='0'; end
  def tags=(val); @tags=[]; @tags=val.split(', ') unless val.nil? || val.length<=0 || val=='-'; end
  
  def type=(val)
    val=val.split(', ')
    @type=val[0]
    @subtype=val[1] unless val.length<=1
  end
  
  def objt; return 'Facility'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def disp_color(chain=0); return 0x8BE3F7; end
  
  def thumbnail
    dispname=@name.gsub(' ','_')
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/Facilities/#{dispname}.png?raw=true"
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!=self.objt || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}#{self.emotes(bot,true)}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class DLMaterial
  attr_accessor :name
  attr_accessor :rarity
  attr_accessor :category
  attr_accessor :description
  attr_accessor :obtain,:uses
  attr_accessor :pouchrar
  attr_accessor :exp
  attr_accessor :tags
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
  def rarity=(val); @rarity=val.to_i; end
  def category=(val); @category=val.to_i; end
  def description=(val); @description=val.gsub(';; ',"\n") unless val.nil? || val.length<=0 || val=='-'; end
  def obtain=(val); @obtain=[]; @obtain=val.split(';; ') unless val.nil? || val.length<=0 || val=='-'; end
  def uses=(val); @uses=[]; @uses=val.split(';; ') unless val.nil? || val.length<=0 || val=='-'; end
  def pouchrar=(val); @pouchrar=val.to_i; end
  def exp=(val); @exp=val.to_i; end
  def tags=(val); @tags=[]; @tags=val.split(', ') unless val.nil? || val.length<=0 || val=='-'; end
  def objt; return 'Material'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def mini_header
    if @category==101
      str="**Type:** Upgrade\n**Subtype:** Adventurer"
    elsif @category==102
      str="**Type:** Upgrade\n**Subtype:** Dragon"
    elsif @category==103
      str="**Type:** Upgrade\n**Subtype:** Weapon"
    elsif @category==104
      str="**Type:** Upgrade\n**Subtype:** Facility"
    elsif @category==111
      str="**Type:** Unbind\n**Subtype:** Dragon"
    elsif @category==112
      str="**Type:** Unbind\n**Subtype:** Weapon"
    elsif @category==113
      str="**Type:** Upgrade\n**Subtype:** Wyrmprint"
    elsif @category==114
      str="**Type:** Unbind\n**Subtype:** Wyrmprint"
    else
      str="**Type:** Misc."
    end
    return str
  end
  
  def class_header(bot,emotesonly=0,includerarity=false,includeobjt=false)
    emtz=[]; str=''
    if includerarity && @rarity>0
      g=''
      g='FEH' if @tags.include?('FEH')
      g='FGO' if @tags.include?('FGO')
      rar=$rarity_stars[0][@rarity]
      rar=FEH_rarity_stars[@rarity] if g=='FEH'
      rar=FGO_rarity_stars[@rarity] if g=='FGO'
      emtz.push(rar)
      str=generate_rarity_row(@rarity,0,g)
    end
    str="#{str}#{"\n" unless str.length<=0}#{self.mini_header}"
    unless @category==0
      str="#{str}\n**Drop bag:** #{['<:Pouch_1:622140100679303189> Common','<:Pouch_2:622140100960190475> Rare','<:Pouch_3:622140100888756237> Legendary'][@pouchrar]}"
      emtz.push(['<:Pouch_1:622140100679303189>','<:Pouch_2:622140100960190475>','<:Pouch_3:622140100888756237>'][@pouchrar])
    end
    
    return emtz if emotesonly==2
    return emtz.join('') if emotesonly==1
    return str
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return self.class_header(bot,1,includerarity,includeobjt); end
  
  def disp_color(chain=0); return 0xE3F78B; end
  
  def thumbnail(ext=0)
    dispname=@name.gsub(' ','_')
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/Mats/#{dispname}.png?raw=true"
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!=self.objt || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}#{self.emotes(bot,true)}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class DLStatus
  attr_accessor :name
  attr_accessor :slot
  attr_accessor :player_effect
  attr_accessor :enemy_effect
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
  def slot=(val); @slot=val.to_i; end
  def player_effect=(val); @player_effect=val.gsub(';; ',"\n"); end
  def enemy_effect=(val); @enemy_effect=val.gsub(';; ',"\n"); end
  def objy; return 'Status'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return ''; end
  
  def thumbnail(ext=0)
    dispname=@name.gsub(' ','_')
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/Status/#{dispname}.png?raw=true"
  end
  
  def disp_color(chain=0)
    f=[]
    xcolor=0xE3F78B
    xcolor=0xE73031 if @name=='Burn'
    xcolor=0x1890DE if @name=='Freeze'
    xcolor=0x00D771 if @name=='Sleep'
    xcolor=0xFFB90F if @name=='Blind'
    xcolor=0xA637DE if @name=='Curse'
    f.push(xcolor)
    return f[0] if chain>=f.length
    return f[chain]
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!=self.objt || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class DL_NPC < DLSentient
  attr_accessor :rarity,:lock
  
  def initialize(val)
    @name=val
  end
  
  def rarity=(val); @rarity=[val.to_i,6].min; end
  def lock=(val); @lock=false; @lock=true if val=='y'; end
  def objt; return 'NPC'; end
  
  def emotes(bot,includerarity=true,includeobjt=false); return ''; end
  
  def disp_color(chain=0); return 0xCE456B; end
end

class DLSticker
  attr_accessor :name
  attr_accessor :charas
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
  def charas=(val); @charas=[]; @charas=val.split(', ') unless val.nil?; end
  def objt; return 'Sticker'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return ''; end
  
  def disp_color(chain=0); return 0xCE456B; end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    k=$aliases.reject{|q| q[0]!=self.objt || q[2]!=@name}
    k=k.reject{|q| !q[3].nil? && !q[3].include?(event.server.id)} unless event.server.nil?
    k=k.reject{|q| q[3].nil?} if saliases
    return k.map{|q| q[1]}.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')} if justaliases
    if event.server.nil?
      for i in 0...k.length
        if k[i][3].nil?
          k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")}"
        else
          f=[]
          for j in 0...k[i][3].length
            srv=(bot.server(k[i][3][j]) rescue nil)
            unless srv.nil? || bot.user(bot.profile.id).on(srv.id).nil?
              f.push("*#{bot.server(k[i][3][j]).name}*") unless event.user.on(k[i][3][j]).nil?
            end
          end
          if f.length<=0
            k[i]=nil
          else
            k[i]="#{k[i][1].gsub('`',"\`").gsub('*',"\*")} (in the following servers: #{list_lift(f,'and')})"
          end
        end
      end
      k.compact!
    else
      k=k.map{|q| "#{q[1].gsub('`',"\`").gsub('*',"\*")}#{' *[in this server only]*' unless q[3].nil? || saliases}"}
    end
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') || saliases
    k.unshift("__**#{@name}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class DLTimer
  attr_accessor :start_date,:end_date
  
  def date=(val)
    x=val.split(', ')
    @start_date=x[0].split('/').map{|q| q.to_i}
    @end_date=x[1].split('/').map{|q| q.to_i}
  end
  
  def isCurrent?(includempty=true,shift=false)
    return false if @start_date.nil?
    t=Time.now
    t+=24*60*60 if shift
    timeshift=8
    timeshift-=1 unless t.dst?
    t-=60*60*timeshift
    return true if @start_date[0]==t.day && @start_date[1]==t.month && @start_date[2]==t.year
    return false if @end_date.nil?
    return false if @start_date[2]>t.year
    return false if @start_date[2]==t.year && @start_date[1]>t.month
    return false if @start_date[2]==t.year && @start_date[1]==t.month && @start_date[0]>t.day
    return false if @end_date[2]<t.year
    return false if @end_date[2]==t.year && @end_date[1]<t.month
    return false if @end_date[2]==t.year && @end_date[1]==t.month && @end_date[0]<t.day
    return false if @end_date[2]==t.year && @end_date[1]==t.month && @end_date[0]==t.day && self.is_a?(FEHBonus) && ['Arena','Aether'].include?(@type) && t.hour>15 && !includempty
    return true
  end
  
  def startsTomorrow?
    return false if @start_date.nil?
    t=Time.now
    t+=24*60*60
    timeshift=8
    timeshift-=1 unless t.dst?
    t-=60*60*timeshift
    return true if @start_date[0]==t.day && @start_date[1]==t.month && @start_date[2]==t.year
    return false
  end
  
  def isNext?(includempty=true)
    return false if @start_date.nil?
    return false if self.isCurrent?(true)
    t=Time.now
    timeshift=8
    timeshift-=1 unless t.dst?
    t-=60*60*timeshift
    t+=7*24*60*60 # shift by a week
    return true if @start_date[0]==t.day && @start_date[1]==t.month && @start_date[2]==t.year
    return false if @end_date.nil?
    return false if @start_date[2]>t.year
    return false if @start_date[2]==t.year && @start_date[1]>t.month
    return false if @start_date[2]==t.year && @start_date[1]==t.month && @start_date[0]>t.day
    return false if @end_date[2]<t.year
    return false if @end_date[2]==t.year && @end_date[1]<t.month
    return false if @end_date[2]==t.year && @end_date[1]==t.month && @end_date[0]<t.day
    return true
  end
  
  def isFuture?
    return false if self.isCurrent? || @start_date.nil?
    t=Time.now
    timeshift=8
    timeshift-=1 unless t.dst?
    t-=60*60*timeshift
    return false if @start_date[2]<t.year
    return false if @start_date[2]==t.year && @start_date[1]<t.month
    return false if @start_date[2]==t.year && @start_date[1]==t.month && @start_date[0]<t.day
    return true
  end
  
  def isPast?(includempty=true)
    return false if self.isCurrent?(includempty)
    return false if self.isFuture?
    return false if @start_date.nil? || @end_date.nil?
    return true
  end
end

class DLBanner < DLTimer
  attr_accessor :name
  attr_accessor :advs,:drgs,:prints
  attr_accessor :tags
  attr_accessor :facilities
  attr_accessor :aliases
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
  def advs=(val); @advs=[]; @advs=val.split(', ') unless val.nil? || val.length<=0 || val=='-'; end
  def drgs=(val); @drgs=[]; @drgs=val.split(', ') unless val.nil? || val.length<=0 || val=='-'; end
  def prints=(val); @prints=[]; @prints=val.split(', ') unless val.nil? || val.length<=0 || val=='-'; end
  def tags=(val); @tags=[]; @tags=val.split(', ') unless val.nil? || val.length<=0 || val=='-'; end
  def facilities=(val); @facilities=[]; @facilities=val.split(', ') unless val.nil? || val.length<=0 || val=='-'; end
  def aliases=(val); @aliases=[]; @aliases=val.split(', ') unless val.nil? || val.length<=0 || val=='-'; end
  def objt; return 'Banner'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
  def emotes(bot,includerarity=true,includeobjt=false); return ''; end
  
  def disp_color(chain=0)
    xcolor=[]
    xcolor.push(0xE73031) if @tags.include?('Flame')
    xcolor.push(0x1890DE) if @tags.include?('Water')
    xcolor.push(0x00D771) if @tags.include?('Wind')
    xcolor.push(0xFFB90F) if @tags.include?('Light')
    xcolor.push(0xA637DE) if @tags.include?('Shadow')
    return 0x849294 unless xcolor.length==1
    return xcolor[0]
  end
  
  def thumbnail
    dispname=@name.gsub(' ','_').gsub(':','')
    return "https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/Art/SummonBanners/#{dispname}.png"
  end
  
  def alias_list(bot,event,saliases=false,justaliases=false)
    return [] if saliases && justaliases
    k=k.reject{|q| q==@name || q==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')}
    return k if justaliases
    k.unshift(@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','')) unless @name==@name.gsub('(','').gsub(')','').gsub(' ','').gsub('_','') unless saliases
    k.unshift("__**#{@name}**#{"'s server-specific aliases" if saliases}__")
    return k
  end
end

class DLGroup
  attr_accessor :name
  attr_accessor :aliases
  attr_accessor :advs,:drgs,:prints,:weps
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
  def aliases=(val); @aliases=val; end
  def advs=(val); @advs=val; end
  def drgs=(val); @drgs=val; end
  def prints=(val); @prints=val; end
  def weps=(val); @weps=val; end
  
  def objt; return 'Group'; end
end

# crossover crossreference entities

class FEHUnit
  attr_accessor :name
  attr_accessor :artist,:voice_na,:voice_jp
  attr_accessor :id
  
  def initialize(val)
    @name=val
    @id=-1
  end
  
  def name=(val); @name=val; end
  def artist=(val); @artist=val; end
  def id=(val); @id=val; end
  def tid; return 0; end
  def objt; return 'Z-FEH-Unit'; end
  
  def voice=(val)
    @voice_na=val[0].split(' & ') unless val[0].nil? || val[0].length<=0
    @voice_jp=val[1].split(' & ') unless val[1].nil? || val[1].length<=0
  end
end

class FGOServant
  attr_accessor :id
  attr_accessor :name
  attr_accessor :artist
  attr_accessor :voice_jp,:voice_na
  
  def initialize(val)
    @id=val
  end
  
  def name=(val); @name=val; end
  def artist=(val); @artist=val; end
  def voice_jp=(val); @voice_jp=val; end
  def objt; return 'Z-FGO1-Servant'; end
  
  def tid
    return @id.to_f if @id.to_i<2
    return @id.to_i
  end
end

class FGO_CE
  attr_accessor :id
  attr_accessor :name
  attr_accessor :artist
  
  def initialize(val)
    @id=val
  end
  
  def name=(val); @name=val; end
  def artist=(val); @artist=val; end
  def objt; return 'Z-FGO2-CE'; end
  def tid; return @id.to_i; end
end

def data_load(to_reload=[])
  to_reload=[to_reload] if to_reload.is_a?(String)
  reload_everything=false
  if has_any?(to_reload.map{|q| q.downcase},['everything','all'])
    reload_everything=true
    to_reload=[]
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['adventurer','adventurers','adv','advs'])
    if File.exist?("#{$location}devkit/DLAdventurers.txt")
      b=[]
      File.open("#{$location}devkit/DLAdventurers.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $adventurers=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLAdventurer.new(b[i][0])
      bob4.rarity=b[i][1]
      bob4.data=b[i][2]
      bob4.hp=b[i][3]
      bob4.str=b[i][4]
      bob4.defense=b[i][5]
      bob4.skills=b[i][6]
      bob4.coability=b[i][7]
      bob4.abilities=b[i][8]
      bob4.alts=b[i][9]
      bob4.voice_jp=b[i][10] unless b[i][10].nil? || b[i][10].length<=0
      bob4.voice_na=b[i][11] unless b[i][11].nil? || b[i][11].length<=0
      bob4.games=b[i][12]
      bob4.gender=b[i][13]
      bob4.race=b[i][14]
      bob4.hidden_abilities=b[i][15] unless b[i][15].nil? || b[i][15].length<=0
      bob4.cygame=b[i][16] unless b[i][16].nil? || b[i][16].length<=0
      bob4.footer=b[i][17] unless b[i][17].nil? || b[i][17].length<=0
      bob4.sp_override=b[i][18] unless b[i][18].nil? || b[i][18].length<=0
      bob4.damage_override=b[i][19] unless b[i][19].nil? || b[i][19].length<=0
      $adventurers.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['dragon','dragons','drag','drags','drg','drgs'])
    if File.exist?("#{$location}devkit/DLDragons.txt")
      b=[]
      File.open("#{$location}devkit/DLDragons.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $dragons=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLDragon.new(b[i][0])
      bob4.rarity=b[i][1]
      bob4.element=b[i][2]
      bob4.hp=b[i][3]
      bob4.str=b[i][4]
      bob4.skills=b[i][5]
      bob4.auras=b[i][6]
      bob4.sell_price=b[i][7]
      bob4.speed=b[i][8]
      bob4.favorite=b[i][9]
      bob4.dmg_turn=b[i][10]
      bob4.longrange=b[i][11]
      bob4.alts=b[i][12]
      bob4.voice_jp=b[i][13] unless b[i][13].nil? || b[i][13].length<=0
      bob4.voice_na=b[i][14] unless b[i][14].nil? || b[i][14].length<=0
      bob4.hidden_abilities=b[i][15] unless b[i][15].nil? || b[i][15].length<=0
      bob4.games=''
      bob4.games=b[i][16] unless b[i][16].nil? || b[i][16].length<=0
      bob4.gender=b[i][17]
      bob4.cygame=b[i][18] unless b[i][18].nil? || b[i][18].length<=0
      bob4.damage_override=b[i][19] unless b[i][19].nil? || b[i][19].length<=0
      bob4.footer=b[i][20] unless b[i][20].nil? || b[i][20].length<=0
      bob4.essence=b[i][21]
      $dragons.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'])
    if File.exist?("#{$location}devkit/DLWyrmprints.txt")
      b=[]
      File.open("#{$location}devkit/DLWyrmprints.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $wyrmprints=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLWyrmprint.new(b[i][0])
      bob4.rarity=b[i][1]
      bob4.amulet=b[i][2]
      bob4.hp=b[i][3]
      bob4.str=b[i][4]
      bob4.abilities=b[i][5]
      bob4.sell_price=b[i][6]
      bob4.artist=b[i][7] unless b[i][7].nil? || b[i][7].length<=0 || b[i][7]=='-'
      bob4.charas=b[i][8] unless b[i][8].nil? || b[i][8].length<=0 || b[i][8]=='-'
      bob4.obtain=b[i][9] unless b[i][9].nil? || b[i][9].length<=0 || b[i][9]=='-'
      bob4.games=b[i][10]
      $wyrmprints.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'])
    if File.exist?("#{$location}devkit/DLWeapons.txt")
      b=[]
      File.open("#{$location}devkit/DLWeapons.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $weapons=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLWeapon.new(b[i][0])
      bob4.type=b[i][1]
      bob4.rarity=b[i][2]
      bob4.element=b[i][3]
      bob4.hp=b[i][4]
      bob4.str=b[i][5]
      bob4.skills=b[i][6]
      bob4.sell_price=b[i][7]
      bob4.id=b[i][8]
      bob4.promotes_from=b[i][9]
      bob4.smith_level=b[i][10]
      bob4.costs=b[i][11]
      bob4.craft_mats=b[i][12]
      bob4.abilities=b[i][13]
      bob4.games=b[i][14]
      bob4.boss_tags=b[i][15]
      bob4.tier=b[i][16]
      bob4.print_slots=b[i][17]
      bob4.unbind_mats=b[i][18]
      bob4.slot_mats=b[i][19]
      bob4.copy_mats=b[i][20]
      bob4.ability_mats=b[i][21]
      bob4.bonus_mats=b[i][22]
      bob4.refinement_mats=b[i][23]
      bob4.post_refine_unbind_mats=b[i][24]
      bob4.x_mats=b[i][25]
      $weapons.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['enemies','boss','enemy','bosses','enemie','enemys','bosss','gauntlet'])
    if File.exist?("#{$location}devkit/DLEnemies.txt")
      b=[]
      File.open("#{$location}devkit/DLEnemies.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $enemies=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLEnemy.new(b[i][0])
      bob4.stats=b[i][1]
      bob4.data=b[i][2]
      bob4.weaknesses=b[i][3]
      bob4.afflictions=b[i][4]
      bob4.abilities=b[i][5] unless b[i][5].nil? || b[i][5].length<=0 || b[i][5]=='-'
      $enemies.push(bob4)
    end
    if File.exist?("#{$location}devkit/DLGauntlet.txt")
      b=[]
      File.open("#{$location}devkit/DLGauntlet.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $gauntlets=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLGauntlet.new(b[i][0])
      bob4.element=b[i][1]
      bob4.stage=b[i][2]
      bob4.hp=b[i][3]
      bob4.str=b[i][4]
      bob4.tribe=b[i][5]
      bob4.subdata=b[i][6] unless b[i][6].nil? || b[i][6].length<=0 || b[i][6]=='-'
      bob4.event=b[i][7] unless b[i][7].nil? || b[i][7].length<=0 || b[i][7]=='-'
      bob4.weaknesses=b[i][8]
      bob4.afflictions=b[i][9]
      bob4.abilities=b[i][10] unless b[i][10].nil? || b[i][10].length<=0 || b[i][10]=='-'
      bob4.reward=b[i][11] unless b[i][11].nil? || b[i][11].length<=0 || b[i][11]=='-'
      $gauntlets.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['npc','npcs'])
    if File.exist?("#{$location}devkit/DL_NPCs.txt")
      b=[]
      File.open("#{$location}devkit/DL_NPCs.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $npcs=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DL_NPC.new(b[i][0])
      bob4.rarity=b[i][1]
      bob4.lock=b[i][2]
      bob4.voice_na=b[i][3] unless b[i][3].nil? || b[i][3].length<=0 || b[i][3]=='-'
      bob4.voice_jp=b[i][4] unless b[i][4].nil? || b[i][4].length<=0 || b[i][4]=='-'
      $npcs.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['emote','emotes','sticker','stickers'])
    if File.exist?("#{$location}devkit/DLEmotes.txt")
      b=[]
      File.open("#{$location}devkit/DLEmotes.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $stickers=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLSticker.new(b[i][0])
      bob4.charas=b[i][1]
      $stickers.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['facility','faculty','fac','facilitys','faculty','facs','facilities','faculties'])
    if File.exist?("#{$location}devkit/DLFacilities.txt")
      b=[]
      File.open("#{$location}devkit/DLFacilities.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $facilities=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLFacility.new(b[i][0],b[i][1])
      bob4.description=b[i][2]
      bob4.type=b[i][3]
      bob4.size=b[i][4]
      bob4.quantity=b[i][5]
      bob4.cost=b[i][6]
      bob4.mats=b[i][7]
      bob4.tags=b[i][8]
      $facilities.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['abil','ability','abilitys','abilities','abils','coabil','coability','coabilitys','coabilities','coabils','coab','coabs','aura','auras','chaincoabil','chaincoability','chaincoabilitys','chaincoabilities','chaincoabils','chaincoab','chaincoabs','coabilchain','coabilitychain','coabilitychains','chain','coabilchains','coabchain','coabchains','cca','cc','ccas','skill','skills','skls','skl','skil','skils'])
    if File.exist?("#{$location}devkit/DLSkills.txt")
      b=[]
      File.open("#{$location}devkit/DLSkills.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $skills=[]; $abilities=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      if b[i][2]=='Skill'
        bob4=DLSkill.new(b[i][0])
        m=[]
        m.push(b[i][3].gsub(';; ',"\n"))
        m.push(b[i][4].gsub(';; ',"\n")) unless b[i][4].nil? || b[i][4].length<=0 || b[i][4]=='-'
        m.push(b[i][5].gsub(';; ',"\n")) unless b[i][5].nil? || b[i][5].length<=0 || b[i][5]=='-'
        m.push(b[i][11].gsub(';; ',"\n")) unless b[i][11].nil? || b[i][11].length<=0 || b[i][11]=='-'
        bob4.description=m.map{|q| q}
        bob4.sp_cost=b[i][6]
        bob4.energize=b[i][7]
        bob4.invulnerability=b[i][8]
        bob4.mass_description=b[i][9].gsub(';; ',"\n") unless b[i][9].nil? || b[i][9].length<=0 || b[i][9]=='-'
        bob4.tags=b[i][10]
        bob4.sharing=b[i][12] unless b[i][12].nil? || b[i][12].length<=0 || b[i][12]==', '
        $skills.push(bob4)
      else
        bob4=DLAbility.new(b[i][0],b[i][1])
        bob4.type=b[i][2]
        bob4.description=b[i][3]
        bob4.weight=b[i][4]
        bob4.show=b[i][5]
        bob4.tags=b[i][6]
        bob4.nihilimmune=b[i][7]
        $abilities.push(bob4)
      end
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['mat','mats','materials','material','item','items'])
    if File.exist?("#{$location}devkit/DLMaterials.txt")
      b=[]
      File.open("#{$location}devkit/DLMaterials.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $mats=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLMaterial.new(b[i][0])
      bob4.rarity=b[i][1]
      bob4.category=b[i][2]
      bob4.description=b[i][3]
      bob4.obtain=b[i][4]
      bob4.uses=b[i][5]
      bob4.pouchrar=b[i][6]
      bob4.exp=b[i][7]
      bob4.tags=b[i][8]
      $mats.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['status','ailment','affliction'])
    if File.exist?("#{$location}devkit/DLStatus.txt")
      b=[]
      File.open("#{$location}devkit/DLStatus.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $statuses=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLStatus.new(b[i][0])
      bob4.slot=b[i][1]
      bob4.player_effect=b[i][2] unless b[i][2].nil? || b[i][2].length<=0 || b[i][2]=='-'
      bob4.enemy_effect=b[i][3] unless b[i][3].nil? || b[i][3].length<=0 || b[i][3]=='-'
      $statuses.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['banner','banners','focus','focuses','summon','summons','summoning','summonings'])
    if File.exist?("#{$location}devkit/DLBanners.txt")
      b=[]
      File.open("#{$location}devkit/DLBanners.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $banners=[]
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=DLBanner.new(b[i][0])
      bob4.advs=b[i][1]
      bob4.drgs=b[i][2]
      bob4.prints=b[i][3]
      bob4.date=b[i][4] unless b[i][4].nil? || b[i][4].length<=0 || b[i][4]=='-'
      bob4.tags=b[i][5]
      bob4.facilities=b[i][6]
      bob4.aliases=b[i][7]
      $banners.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['groups','group'])
    if File.exist?("#{$location}devkit/DLGroups.txt")
      b=[]
      File.open("#{$location}devkit/DLGroups.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $groups=[]
    for i in 0...b.length/7
      m=eval(b[7*i,7].map{|q| q.split(' # ')[0]}.join("\n"))
      bob4=DLGroup.new(m[0])
      bob4.aliases=m[1]
      bob4.advs=m[2]
      bob4.drgs=m[3]
      bob4.weps=m[4]
      bob4.prints=m[5]
      $groups.push(bob4)
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['tags','tag'])
    $skilltags=[]
    if File.exist?("#{$location}devkit/DLSkillSubsets.txt")
      File.open("#{$location}devkit/DLSkillSubsets.txt").each_line do |line|
        $skilltags.push(eval line)
      end
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['libraries','library','librarys'])
    rtime=5
    rtime=1 if Shardizard==4
    rtime=60 if to_reload.length<=0
    t=Time.now
    if t-$last_multi_reload[0]>rtime*60
      puts 'reloading BotanClassFunctions'
      load "#{$location}devkit/BotanClassFunctions.rb"
      $last_multi_reload[0]=t
    end
  end
  if to_reload.length<=0 || has_any?(to_reload.map{|q| q.downcase},['void','voids'])
    if File.exist?("#{$location}devkit/DLVoid.txt")
      b=[]
      File.open("#{$location}devkit/DLVoid.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i].gsub("\n",'')
    end
    $voids=b.map{|q| q}
  end
  if has_any?(to_reload.map{|q| q.downcase},['feh','unit','units'])
    # UNIT DATA
    if File.exist?("#{$location}devkit/FEHUnits.txt")
      b=[]
      File.open("#{$location}devkit/FEHUnits.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    $feh_units=[]
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=FEHUnit.new(b[i][0])
      bob4.artist=b[i][6].split(';; ') if b[i][6].length>0
      bob4.voice=b[i][7].split(';; ') if b[i][7].length>0
      bob4.id=b[i][8].to_i
      $feh_units.push(bob4) if b[i][13].nil?
    end
  end
  if has_any?(to_reload.map{|q| q.downcase},['fgo','servants','crafts','servant','craft'])
    $fgo_servants=[]
    if File.exist?("#{$location}devkit/FGOServants.txt")
      b=[]
      File.open("#{$location}devkit/FGOServants.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=FGOServant.new(b[i][0])
      bob4.name=b[i][1]
      bob4.artist=b[i][24] unless b[i][24].nil?
      bob4.voice_jp=b[i][25] unless b[i][25].nil?
      $fgo_servants.push(bob4)
    end
    if File.exist?("#{$location}devkit/FGOCraftEssances.txt")
      b=[]
      File.open("#{$location}devkit/FGOCraftEssances.txt").each_line do |line|
        b.push(line)
      end
    else
      b=[]
    end
    for i in 0...b.length
      b[i]=b[i][1,b[i].length-1] if b[i][0,1]=='"'
      b[i]=b[i][0,b[i].length-1] if b[i][-1,1]=='"'
      b[i]=b[i].gsub("\n",'').split('\\'[0])
      bob4=FGO_CE.new(b[i][0])
      bob4.name=b[i][1]
      bob4.artist=b[i][9] unless b[i][9].nil?
      $fgo_crafts.push(bob4)
    end
  end
end

def prefixes_save()
  x=@prefixes
  open("#{$location}devkit/DLPrefix.rb", 'w') { |f|
    f.puts x.to_s.gsub('=>',' => ').gsub(', ',",\n  ").gsub('{',"@prefixes = {\n  ").gsub('}',"\n}")
  }
end

def metadata_load()
  if File.exist?("#{$location}devkit/DLSave.txt")
    b=[]
    File.open("#{$location}devkit/DLSave.txt").each_line do |line|
      b.push(eval line)
    end
  else
    b=[[168592191189417984, 256379815601373184],[],[],[]]
  end
  $embedless=b[0]
  $embedless=[168592191189417984, 256379815601373184] if $embedless.nil?
  @ignored=b[1]
  @ignored=[] if @ignored.nil?
  @server_data=b[2]
  @server_data=[[0,0,0,0,0],[0,0,0,0,0]] if @server_data.nil? || @server_data.length<=0
  if @server_data[0].length<Shards+1
    for i in 0...Shards+1
      @server_data[0][i]=0 if @server_data[0][i].nil?
    end
  end
  if @server_data[1].length<Shards+1
    for i in 0...Shards+1
      @server_data[1][i]=0 if @server_data[1][i].nil?
    end
  end
  $spam_channels=b[3]
  $spam_channels=[] if $spam_channels.nil?
end

def metadata_save()
  if @server_data[0].length<Shards+1
    for i in 0...Shards+1
      @server_data[0][i]=0 if @server_data[0][i].nil?
    end
  end
  if @server_data[1].length<Shards+1
    for i in 0...Shards+1
      @server_data[1][i]=0 if @server_data[1][i].nil?
    end
  end
  x=[$embedless.map{|q| q}, @ignored.map{|q| q}, @server_data.map{|q| q}, $spam_channels.map{|q| q}]
  open("#{$location}devkit/DLSave.txt", 'w') { |f|
    f.puts x[0].to_s
    f.puts x[1].to_s
    f.puts x[2].to_s
    f.puts x[3].to_s
    f.puts "\n"
  }
end

def nicknames_load(mode=1) # loads the nickname list
  if mode==2 && File.exist?("#{$location}devkit/DLNames2.txt")
    b=[]
    File.open("#{$location}devkit/DLNames2.txt").each_line do |line|
      b.push(eval line)
    end
    return b
  elsif File.exist?("#{$location}devkit/DLNames.txt")
    b=[]
    File.open("#{$location}devkit/DLNames.txt").each_line do |line|
      b.push(eval line)
    end
  else
    b=[]
  end
  b=b.reject{|q| q.nil? || q[1].nil?}.uniq
  b=b.reject{|q| q[0].include?('*')} if Shardizard<0 && mode>=0
  $aliases=b.map{|q| q}
  t=Time.now
  $aliases.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? (supersort(a,b,2,nil,1) == 0 ? (a[1].downcase <=> b[1].downcase) : supersort(a,b,2,nil,1)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
end

def remove_prefix(s,event)
  s=s[2,s.length-2] if ['d?','d!'].include?(s.downcase[0,2])
  s=s[3,s.length-3] if ['dl!','dl?'].include?(s.downcase[0,4])
  x=nil
  x=@prefixes[event.server.id] unless event.server.nil?
  s=s[x.length,s.length-x.length] if !x.nil? && x.length>0 && [x.downcase].include?(s.downcase[0,x.length])
  return s
end

def safe_to_spam?(event,chn=nil) # determines whether or not it is safe to send extremely long messages
  return true if event.server.nil? # it is safe to spam in PM
  return false if event.user.id==213048998678888448
  return false if event.message.text.downcase.split(' ').include?('smol') && Shardizard==4
  return true if Shardizard==4
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
  return true if $spam_channels.include?(chn.id)
  return false
end

def overlap_prevent(event,egg=true) # used to prevent servers with both Botan and her debug form from receiving two replies
  if event.server.nil? # failsafe code catching PMs as not a server
    return false
  elsif event.message.text.downcase.split(' ').include?('debug') && [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(event.server.id)
    return ![4].include?(Shardizard) # the debug bot can be forced to be used in the emoji servers by including the word "debug" in your message
  elsif event.message.text.downcase.split(' ').include?('smol') && [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(event.server.id)
    return ![-1].include?(Shardizard) # the debug bot can be forced to be used in the emoji servers by including the word "debug" in your message
  elsif [443172595580534784,443704357335203840,443181099494146068,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(event.server.id) # emoji servers will use default Botan otherwise
    return [4,-1].include?(Shardizard)
  end
  return false
end

alias is_mod_old? is_mod?
def is_mod?(user,server,channel,mode=0)
  return true if is_mod_old?(user,server,channel,mode)
  return true if user.id==80565838670725120 && Shardizard<0
  return true if user.id==141260274144509952 && !server.nil?
  return false
end

def all_commands(include_nil=false,permissions=-1)
  return all_commands(include_nil)-all_commands(false,1)-all_commands(false,2) if permissions==0
  k=['reboot','help','commands','commandlist','command_list','embeds','embed','prefix','channelist','channellist','spamchannels','spamlist','bugreport','suggestion','feedback','adv',
     'donate','donation','shard','attribute','safe','spam','safetospam','safe2spam','long','longreplies','invite','sortaliases','tools','links','tool','link','resources','resource',
     'avatar','avvie','backupaliases','restorealiases','sendmessage','sendpm','ignoreuser','leaveserver','cleanupaliases','snagstats','reload','update','adventurer','unit','stats',
     'stat','smol','dragon','drg','drag','wyrmprint','wyrm','print','weapon','wep','weap','wpn','lineage','craft','crafting','enemy','boss','affinity','resonance','affliction','skil',
     'status','ailment','skill','art','limit','limits','stack','stacks','wxp','wexp','wlevel','wpxp','wpexp','wplevel','weaponxp','weaponexp','weaponlevel','wrxp','wrexp','wrlevel',
     'wyrmxp','wyrmexp','wyrmxp','wyrmlevel','bxp','bexp','blevel','dbxp','dbexp','dblevel','bondlevel','bondxp','bondexp','drgxp','drgexp','drglevel','dlevel','dxp','dexp','advxp',
     'advexp','advlevel','alevel','axp','aexp','plxp','plexp','pllevel','plevel','pxp','pexp','xp','exp','level','next','schedule','tomorrow','tommorrow','tomorow','tommorow','today',
     'now','todayindl','today_in_dl','daily','dailies','reset','shop','store','ruin','ruins','roost','alt','alts','banners','banner','facility','faculty','fac','mat','material','item',
     'addalias','alias','deletealias','removealias','serveraliases','saliases','aliases','checkaliases','seealiases','seegroups','groups','checkgroups','team','backpack','mats','sp',
     'materials','node','nodes','spiral','dmg','damage','combo','sort','list','skillshare','skilshare','share','shared','prints','weapprints','wepprints','weaponprints','wpnprints',
     'weaprints','weprints','weapprint','wepprint','weaponprint','wpnprint','weaprint','weprint','synergy','synergize','find','search','lookup','ability','abil','aura','coability',
     'coabil','coab','co','chain','cca','cc','chaincoab','whybotan']
  k=['addalias','deletealias','removealias','prefix'] if permissions==1
  k=['reboot','sortaliases','status','backupaliases','restorealiases','sendmessage','sendpm','ignoreuser','leaveserver','cleanupaliases','boop','reload','update'] if permissions==2
  k=k.uniq
  k.push(nil) if include_nil
  return k
end

bot.command(:reboot, from: 167657750971547648) do |event| # reboots Botan
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 # only work when used by the developer
  puts 'DL!reboot'
  exec "cd #{$location}devkit && BotanBot.rb #{Shardizard}"
end

bot.command([:help,:commands,:command_list,:commandlist,:Help]) do |event, command, subcommand| # used to show tooltips regarding each command.  If no command name is given, shows a list of all commands
  return nil if overlap_prevent(event)
  data_load('library')
  help_text(event,bot,command,subcommand)
  return nil
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

def generate_rarity_row(rar,blanks=0,game='')
  blanks=rar*1 if blanks<=0
  disprar=rar*1
  disprar=blanks*1 if rar<=0
  return "**#{rar}-star**" if rar<0 || rar>$rarity_stars[0].length
  return "#{FGO_rarity_stars[rar]*([disprar,blanks].min)}#{'<:FGO_rarity_inverted:544568437029208094>'*(blanks-disprar) if blanks>disprar}" if game=='FGO'
  return "#{FEH_rarity_stars[rar]*([disprar,blanks].min)}#{'<:Icon_Rarity_Empty:631460895851282433>'*(blanks-disprar) if blanks>disprar}" if game=='FEH'
  return "#{$rarity_stars[0][rar]*([disprar,blanks].min)}#{$rarity_stars[1][rar]*(blanks-disprar) if blanks>disprar}"
end

def find_data_ex(callback,name,event,fullname=false,ext=false,includematch=false)
  k=method(callback).call(name,event,true,ext)
  return [k,name] if includematch && !k.nil?
  return k unless k.nil?
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(callback).call(args[i,args.length-i-i2].join(' '),event,true,ext)
      return [k,args[i,args.length-i-i2].join(' ')] if includematch && !k.nil? && args[i,args.length-i-i2].length>0
      return k if !k.nil? && args[i,args.length-i-i2].length>0
    end
  end
  return nil if fullname || name.length<=2
  k=method(callback).call(name,event,false,ext)
  return [k,name] if includematch && !k.nil?
  return k unless k.nil?
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(callback).call(args[i,args.length-i-i2].join(' '),event,false,ext)
      return [k,args[i,args.length-i-i2].join(' ')] if includematch && !k.nil? && args[i,args.length-i-i2].length>0
      return k if !k.nil? && args[i,args.length-i-i2].length>0
    end
  end
  return nil
end

def find_best_match(name,bot,event,fullname=false,ext=false,mode=1,ext2=nil)
  #           just item        default item behavior   art   stats                  alts   banners   mats   damage
  functions=[[:find_adventurer,:disp_adventurer_stats, '',   :disp_adventurer_stats,'',    '',       '',    ''],
             [:find_dragon,    :disp_dragon_stats,     '',   :disp_dragon_stats,    '',    '',       nil,   ''],
             [:find_wyrmprint, :disp_wyrmprint_stats,  '',   :disp_wyrmprint_stats, nil,   ''],
             [:find_weapon,    :disp_weapon_stats,     nil,  :disp_weapon_stats,    nil,   nil,      '',    ''],
             [:find_enemy,     :disp_enemy_data,       ''],
             [:find_skill,     :disp_skill_data],
             [:find_ability,   :disp_ability_data],
             [:find_status,    :disp_status_data],
             [:find_facility,  :disp_facility_data],
             [:find_mat,       :disp_mat_data],
             [:find_sticker,   :disp_art,              ''],
             [:find_npc,       :disp_art,              ''],
             [:find_banner,    nil,                    nil,  nil,                   nil,   '']]
  functions=functions.reject{|q| q[mode].nil?} if mode>0
  for i3 in 0...functions.length
    k=method(functions[i3][0]).call(name,event,true,ext)
    k=nil if k.is_a?(Array) && k.length<=0
    return k if (mode==0 || functions[i3][mode].is_a?(String)) && !k.nil?
    return method(functions[i3][mode]).call(bot,event,name.split(' '),ext2) if !functions[i3][mode].nil? && !k.nil?
  end
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      for i3 in 0...functions.length
        k=method(functions[i3][0]).call(args[i,args.length-i-i2].join(' '),event,true,ext)
        k=nil if k.is_a?(Array) && k.length<=0
        return k if (mode==0 || functions[i3][mode].is_a?(String)) && !k.nil?
        return method(functions[i3][mode]).call(bot,event,args,ext2) if !functions[i3][mode].nil? && !k.nil? && args[i,args.length-i-i2].length>0
      end
    end
  end
  event.respond 'No matches found.' if (fullname || name.length<=2) && mode>1 && !functions[0][mode].is_a?(String)
  return nil if fullname || name.length<=2
  for i3 in 0...functions.length
    k=method(functions[i3][0]).call(name,event,false,ext)
    k=nil if k.is_a?(Array) && k.length<=0
    return k if (mode==0 || functions[i3][mode].is_a?(String)) && !k.nil?
    return method(functions[i3][mode]).call(bot,event,name.split(' '),ext2) if !functions[i3][mode].nil? && !k.nil?
  end
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(functions[i3][0]).call(args[i,args.length-i-i2].join(' '),event,false,ext)
      k=nil if k.is_a?(Array) && k.length<=0
      return k if (mode==0 || functions[i3][mode].is_a?(String)) && !k.nil?
      return method(functions[i3][mode]).call(bot,event,args,ext2) if !functions[i3][mode].nil? && !k.nil? && args[i,args.length-i-i2].length>0
    end
  end
  event.respond 'No matches found.' unless functions[0][mode].is_a?(String) || mode==0
  return nil
end

def find_thing(thing,xname,event,fullname=false,ext=false)
  data_load([thing])
  xname=normalize(xname)
  if xname.downcase.gsub(' ','').gsub('_','')[0,2]=='<:'
    buff=xname.split(':')[1]
    buff=buff[3,buff.length-3] if !event.server.nil? && event.server.id==350067448583553024 && buff[0,3].downcase=='gp_'
    buff=buff[2,buff.length-2] if !event.server.nil? && event.server.id==350067448583553024 && buff[0,2].downcase=='gp'
    xname=buff unless find_thing(thing,buff,event,fullname).nil?
  end
  xname=xname.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return nil if xname.length<2
  return nil if thing=='Adventurer' && ext && (!find_npc(xname,event,true).nil? || xname.downcase=='mym')
  list=[]
  list=$adventurers.map{|q| q} if thing=='Adventurer'
  list=$dragons.map{|q| q} if thing=='Dragon'
  list=$wyrmprints.map{|q| q} if thing=='Wyrmprint'
  list=$weapons.map{|q| q} if thing=='Weapon'
  list=$enemies.map{|q| q} if thing=='Enemy'
  list=$skills.map{|q| q} if thing=='Skill'
  list=$stickers.map{|q| q} if thing=='Sticker'
  list=$statuses.map{|q| q} if thing=='Status'
  list=$mats.map{|q| q} if thing=='Mat'
  list=$facilities.map{|q| q} if thing=='Facility'
  list=$banners.map{|q| q} if thing=='Banner'
  list=$npcs.map{|q| q} if thing=='NPC'
  k=list.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
  return list.reject{|q| q.name != list[k].name} if thing=='Facility' && !k.nil?
  return list[k] unless k.nil?
  if thing=='Weapon' && !ext
    xtags=$skilltags.reject{|q| q[2]!='Availability/Weapon'}.map{|q| [q[3],q[1]]}.uniq
    xtags.unshift(['$',['Paid']])
    xtags.unshift(['s',['Seasonal']])
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.rarity}*#{q.element}#{q.type}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.rarity}#{q.element}#{q.type}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.rarity}*#{q.type}#{q.element}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.rarity}#{q.type}#{q.element}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.element}#{q.rarity}*#{q.type}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.element}#{q.rarity}#{q.type}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.type}#{q.rarity}*#{q.element}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.type}#{q.rarity}#{q.element}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.element}#{q.type}#{q.rarity}*".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.element}#{q.type}#{q.rarity}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.type}#{q.element}#{q.rarity}*".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    k=list.find_index{|q| !has_any?(xtags.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.type}#{q.element}#{q.rarity}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return list[k] unless k.nil?
    for i2 in 2...xtags.length
      for i3 in 0...xtags[i2][1].length
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.rarity}*#{q.element}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.rarity}#{q.element}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.rarity}*#{q.type}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.rarity}#{q.type}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.element}#{q.rarity}*#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.element}#{q.rarity}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.type}#{q.rarity}*#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.type}#{q.rarity}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.element}#{q.type}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.element}#{q.type}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.type}#{q.element}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{xtags[i2][1][i3]}#{q.type}#{q.element}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}*#{xtags[i2][1][i3]}#{q.element}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}#{xtags[i2][1][i3]}#{q.element}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}*#{xtags[i2][1][i3]}#{q.type}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}#{xtags[i2][1][i3]}#{q.type}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{xtags[i2][1][i3]}#{q.rarity}*#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{xtags[i2][1][i3]}#{q.rarity}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{xtags[i2][1][i3]}#{q.rarity}*#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{xtags[i2][1][i3]}#{q.rarity}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{xtags[i2][1][i3]}#{q.type}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{xtags[i2][1][i3]}#{q.type}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{xtags[i2][1][i3]}#{q.element}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{xtags[i2][1][i3]}#{q.element}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}*#{q.element}#{xtags[i2][1][i3]}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}#{q.element}#{xtags[i2][1][i3]}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}*#{q.type}#{xtags[i2][1][i3]}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}#{q.type}#{xtags[i2][1][i3]}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{q.rarity}*#{xtags[i2][1][i3]}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{q.rarity}#{xtags[i2][1][i3]}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{q.rarity}*#{xtags[i2][1][i3]}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{q.rarity}#{xtags[i2][1][i3]}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{q.type}#{xtags[i2][1][i3]}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{q.type}#{xtags[i2][1][i3]}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{q.element}#{xtags[i2][1][i3]}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{q.element}#{xtags[i2][1][i3]}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}*#{q.element}#{q.type}#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}#{q.element}#{q.type}#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}*#{q.type}#{q.element}#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.rarity}#{q.type}#{q.element}#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{q.rarity}*#{q.type}#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{q.rarity}#{q.type}#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{q.rarity}*#{q.element}#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{q.rarity}#{q.element}#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{q.type}#{q.rarity}*#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.element}#{q.type}#{q.rarity}#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{q.element}#{q.rarity}*#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=list.reject{|q| !q.availability.include?(xtags[i2][0]) || q.element=='None' || "#{q.type}#{q.element}#{q.rarity}#{xtags[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
      end
    end
  end
  nicknames_load()
  alz=$aliases.reject{|q| q[0]!=thing}.map{|q| [q[1],q[2],q[3]]}
  alz=$aliases.reject{|q| q[0]!='Adventurer' && !(q[0]=='NPC' && $npcs.find_index{|q2| q2.name==q[2]}.nil?)}.map{|q| [q[1],q[2],q[3]]} if thing=='Adventurer'
  g=0
  if thing=='Banner'
    for i in 0...list.length
      for i2 in 0...list[i].aliases.length
        alz.push([list[i].aliases[i2],list[i].name])
      end
    end
  end
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return list.reject{|q| q.name != alz[k][1]} if thing=='Facility' && !k.nil? && list.reject{|q| q.name != alz[k][1]}.length>0
  return list[list.find_index{|q| q.name==alz[k][1]}] unless k.nil? || list.find_index{|q| q.name==alz[k][1]}.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return list.reject{|q| q.name != alz[k][1]} if thing=='Facility' && !k.nil? && list.reject{|q| q.name != alz[k][1]}.length>0
  return list[list.find_index{|q| q.name==alz[k][1]}] unless k.nil? || list.find_index{|q| q.name==alz[k][1]}.nil?
  return nil if fullname || xname.length<=2
  return nil if thing=='Adventurer' && ext && !find_npc(xname,event).nil?
  k=list.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
  return list.reject{|q| q.name != list[k].name} if thing=='Facility' && !k.nil?
  return list[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  return list.reject{|q| q.name != alz[k][1]} if thing=='Facility' && !k.nil? && list.reject{|q| q.name != alz[k][1]}.length>0
  return list[list.find_index{|q| q.name==alz[k][1]}] unless k.nil? || list.find_index{|q| q.name==alz[k][1]}.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  return list.reject{|q| q.name != alz[k][1]} if thing=='Facility' && !k.nil? && list.reject{|q| q.name != alz[k][1]}.length>0
  return list[list.find_index{|q| q.name==alz[k][1]}] unless k.nil? || list.find_index{|q| q.name==alz[k][1]}.nil?
  return nil
end

def find_adventurer(xname,event,fullname=false,skipnpcs=false); return find_thing('Adventurer',xname,event,fullname,skipnpcs); end
def find_dragon(xname,event,fullname=false,ext=false); return find_thing('Dragon',xname,event,fullname); end
def find_wyrmprint(xname,event,fullname=false,ext=false); return find_thing('Wyrmprint',xname,event,fullname); end
def find_weapon(xname,event,fullname=false,ext=false); return find_thing('Weapon',xname,event,fullname,ext); end
def find_enemy(xname,event,fullname=false,ext=false); return find_thing('Enemy',xname,event,fullname); end
def find_skill(xname,event,fullname=false,ext=false); return find_thing('Skill',xname,event,fullname); end
def find_facility(xname,event,fullname=false,ext=false); return find_thing('Facility',xname,event,fullname); end
def find_mat(xname,event,fullname=false,ext=false); return find_thing('Mat',xname,event,fullname); end
def find_sticker(xname,event,fullname=false,ext=false); return find_thing('Sticker',xname,event,fullname); end
def find_status(xname,event,fullname=false,ext=false); return find_thing('Status',xname,event,fullname); end
def find_banner(xname,event,fullname=false,ext=false); return find_thing('Banner',xname,event,fullname); end
def find_npc(xname,event,fullname=false,ext=false); return find_thing('NPC',xname,event,fullname); end

def find_ability(xname,event,fullxname=false,ext=false)
  data_load(['ability'])
  xname=normalize(xname)
  if xname.downcase.gsub(' ','').gsub('_','')[0,2]=='<:'
    buff=xname.split(':')[1]
    buff=buff[3,buff.length-3] if !event.server.nil? && event.server.id==350067448583553024 && buff[0,3].downcase=='gp_'
    buff=buff[2,buff.length-2] if !event.server.nil? && event.server.id==350067448583553024 && buff[0,2].downcase=='gp'
    xname=buff unless find_ability(buff,event,fullname).nil?
  end
  romanums=['Ox0','I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII','XVIII','XIX','XX','XXI','XXII','XXIII','XXIV','XXV','XXVI','XXVII',
            'XXVIII','XXIX','XXX','XXXI','XXXII','XXXIII','XXXIV','XXXV','XXXVI','XXXVII','XXXVIII','XXXIX','XL','XLI','XLII','XLII','XLIII','XLIV','XLV','XLVI','XLVII','XLVIII',
            'XLIX','L']
  xname=xname.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  sklz=$abilities.map{|q| q}
  sklz2=sklz.reject{|q| !romanums.include?(q.level)}
  return nil if xname.length<2
  k=sklz2.reject{|q| "#{q.name} #{romanums.find_index{|q2| q2==q.level}}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz2.reject{|q| "#{romanums.find_index{|q2| q2==q.level}} #{q.name}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q.name} #{q.level}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q.name} +#{q.level}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q.level} #{q.name}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q.level.gsub('%','')} #{q.name}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
  return sklz.reject{|q| q.name !=sklz[k].name} unless k.nil?
  k=sklz.reject{|q| q.name.length<7 || q.name[0,7]!='Hits = ' || "#{q.level} #{q.name}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  data_load('aliases')
  alz=$aliases.reject{|q| !['Aura','Ability'].include?(q[0])}.map{|q| [q[1],q[2],q[3],q[0]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| q.fullName==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q.name !=alz[k][1]}
  end
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| q.fullName==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q.name !=alz[k][1]}
  end
  k=alz.reject{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=xname[0,q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','').length] || !(q[2].nil? || q[2].include?(g))}.sort{|b,a| a[0].length<=>b[0].length}[0]
  unless k.nil?
    sklz2=sklz.reject{|q| q.name !=k[1]}
    m=sklz2.find_index{|q| "#{k[0]}#{q.level}".downcase==xname}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}+#{q.level}".downcase==xname}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}#{q.level.gsub('%','')}".downcase==xname}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}+#{q.level.gsub('%','')}".downcase==xname}
    return sklz2[m] unless m.nil?
  end
  k=alz.reject{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')!=xname[0,q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','').length] || !(q[2].nil? || q[2].include?(g))}.sort{|b,a| a[0].length<=>b[0].length}[0]
  unless k.nil?
    sklz2=sklz.reject{|q| q.name !=k[1]}
    m=sklz2.find_index{|q| "#{k[0]}#{q.level}".downcase==xname}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}+#{q.level}".downcase==xname}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}#{q.level.gsub('%','')}".downcase==xname}
    return sklz2[m] unless m.nil?
    m=sklz2.find_index{|q| "#{k[0]}+#{q.level.gsub('%','')}".downcase==xname}
    return sklz2[m] unless m.nil?
  end
  return nil if fullxname || xname.length<=2
  k=sklz2.reject{|q| "#{romanums.find_index{|q2| q2==q.level}} #{q.name}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q.name} #{q.level}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q.name} +#{q.level}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q.level} #{q.name}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]!=xname || xname.length<=q.level.to_s.length || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.reject{|q| "#{q.level.gsub('%','')} #{q.name}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]!=xname || xname.length<=q.level.to_s.length || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=sklz.reject{|q| q.name.length<7 || q.name[0,7]!='Hits = ' || "#{q.level} #{q.name}".downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]!=xname || q.level.downcase=='example'}
  return k.reject{|q| q.name != k[0].name} unless k.nil? || k.length<=0
  k=alz.find_index{|q| q[0][0,xname.length]!=q[0][0,xname.length].to_i.to_s && q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| q.fullName==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1]}
  end
  k=alz.find_index{|q| q[0].gsub('||','')[0,xname.length]!=q[0].gsub('||','')[0,xname.length].to_i.to_s && q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  unless k.nil?
    m=sklz.find_index{|q| q.fullName==alz[k][1]}
    return sklz[m] unless m.nil?
    return sklz.reject{|q| q[0]!=alz[k][1]}
  end
  return nil
end

def log_channel
  return 431862993194582036 if Shardizard==4
  return 536307117301170187
end

def add_new_alias(bot,event,newname,unit,modifier=nil,modifier2=nil,mode=0)
  data_load()
  nicknames_load()
  err=false
  str=''
  if !event.server.nil? && event.server.id==363917126978764801
    str="You guys revoked your permission to add aliases when you refused to listen to me regarding the Erk alias for Serra."
    err=true
  elsif newname.nil? || unit.nil?
    str="The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Enemies\n- Skills\n- Abilities (including Auras, CoAbilities, Chain CoAbilities)\n- Facilities\n- Materials\n- Stickers\n- NPCs\n- Statuses\n\nYou must specify both:\n- one of the above\n- an alias you wish to give that object"
    err=true
  elsif event.user.id != 167657750971547648 && event.server.nil?
    str='Only my developer is allowed to use this command in PM.'
    err=true
  elsif (!is_mod?(event.user,event.server,event.channel) && ![368976843883151362,195303206933233665,141260274144509952].include?(event.user.id)) && event.channel.id != 532083509083373583
    str='You are not a mod.'
    err=true
  elsif newname.include?('"') || unit.include?('"')
    str='Full stop.  " is not allowed in an alias.'
    err=true
  elsif newname.include?("\n") || unit.include?("\n")
    str="Newlines aren't allowed in aliases"
    err=true
  end
  if err
    event.respond str if str.length>0 && mode==0
    args=event.message.text.downcase.split(' ')
    args.shift
    list_unit_aliases(event,args,bot) if mode==1
    return nil
  end
  str=''
  type=['Alias','Alias']
  matches=[0,0]
  matchnames=['','']
  newname=newname.gsub('!','').gsub('(','').gsub(')','').gsub('_','')
  k=find_best_match(newname,bot,event,true,false,0)
  ooo=''
  if k.nil?
  elsif k.is_a?(Array)
    ooo=k[0].objt unless k[0].nil?
  else
    ooo=k.objt
  end
  if k.nil? || (k.is_a?(Array) && k[0].nil?) || k.is_a?(DLBanner) || (['Sticker','Status'].include?(ooo) && !([368976843883151362,195303206933233665,141260274144509952].include?(event.user.id) || event.channel.id==532083509083373583))
    k=find_best_match(newname,bot,event,false,false,0)
    if k.nil? || (k.is_a?(Array) && k[0].nil?) || k.is_a?(DLBanner) || (['Sticker','Status'].include?(ooo) && !([368976843883151362,195303206933233665,141260274144509952].include?(event.user.id) || event.channel.id==532083509083373583))
    elsif k.is_a?(Array)
      k=k[0]
      type[0]="#{k.objt}*"
      matches[0]=k.fullName
      matchnames[0]="#{k.fullName}#{k.emotes(bot,true)}"
    else
      type[0]="#{k.objt}*"
      matches[0]=k.fullName
      matchnames[0]="#{k.fullName}#{k.emotes(bot,true)}"
    end
  elsif k.is_a?(Array)
    k=k[0]
    type[0]="#{k.objt}"
    matches[0]=k.fullName
    matchnames[0]="#{k.fullName}#{k.emotes(bot,true)}"
  else
    type[0]="#{k.objt}"
    matches[0]=k.fullName
    matchnames[0]="#{k.fullName}#{k.emotes(bot,true)}"
  end
  unit=unit.gsub('!','').gsub('(','').gsub(')','').gsub('_','')
  k2=find_best_match(unit,bot,event,true,false,0)
  ooo=''
  if k2.nil?
  elsif k2.is_a?(Array)
    ooo=k2[0].objt unless k2[0].nil?
  else
    ooo=k2.objt
  end
  if k2.nil? || (k2.is_a?(Array) && k2[0].nil?) || k2.is_a?(DLBanner) || (['Sticker','Status'].include?(ooo) && !([368976843883151362,195303206933233665,141260274144509952].include?(event.user.id) || event.channel.id==532083509083373583))
    k2=find_best_match(unit,bot,event,false,false,0)
    if k2.nil? || (k2.is_a?(Array) && k2[0].nil?) || k2.is_a?(DLBanner) || (['Sticker','Status'].include?(ooo) && !([368976843883151362,195303206933233665,141260274144509952].include?(event.user.id) || event.channel.id==532083509083373583))
    elsif k2.is_a?(Array)
      k2=k2[0]
      type[0]="#{k2.objt}*"
      matches[0]=k2.fullName
      matchnames[0]="#{k2.fullName}#{k2.emotes(bot,false)}"
    else
      type[0]="#{k2.objt}*"
      matches[0]=k2.fullName
      matchnames[0]="#{k2.fullName}#{k2.emotes(bot,false)}"
    end
  elsif k2.is_a?(Array)
    k2=k2[0]
    type[1]="#{k2.objt}"
    matches[1]=k2.fullName
    matchnames[1]="#{k2.fullName}#{k2.emotes(bot,false)}"
  else
    type[1]="#{k2.objt}"
    matches[1]=k2.fullName
    matchnames[1]="#{k2.fullName}#{k2.emotes(bot,false)}"
  end
  checkstr=normalize(newname,true)
  if type.reject{|q| q != 'Alias'}.length<=0
    type[0]='Alias' if type[0].include?('*')
    type[1]='Alias' if type[1].include?('*') && type[0]!='Alias'
  end
  if type.reject{|q| q=='Alias'}.length<=0
    alz1=newname
    alz2=unit
    alz1='>Censored mention<' if alz1.include?('@')
    alz2='>Censored mention<' if alz2.include?('@')
    str="The alias system can cover:\n- Adventurers\n- Dragons\n- Wyrmprints\n- Weapons\n- Enemies\n- Skills\n- Abilities (including Auras, CoAbilities, Chain CoAbilities)\n- Facilities\n- Materials\n- Stickers\n- NPCs\n- Statuses\n\nNeither #{newname} nor #{unit} is any of the above."
    err=true
  elsif type.reject{|q| q != 'Alias'}.length<=0
    alz1=newname
    alz2=unit
    alz1='>Censored mention<' if alz1.include?('@')
    alz2='>Censored mention<' if alz2.include?('@')
    x=['a','a']
    x[0]='an' if ['enemy','adventurer','ability','npc'].include?(type[0].downcase)
    x[1]='an' if ['enemy','adventurer','ability','npc'].include?(type[1].downcase)
    str="#{alz1} is #{x[0]} #{type[0].downcase}\n#{alz2} is #{x[1]} #{type[1].downcase}"
    err=true
  end
  if type[1]=='Alias' && type[0]!='Alias'
    f="#{newname}"
    newname="#{unit}"
    unit="#{f}"
    type=type.reverse.map{|q| q.gsub('*','')}
    matches.reverse!
    matchnames.reverse!
    kk1=k2
    kk2=k
  else
    kk1=k
    kk2=k2
    type=type.map{|q| q.gsub('*','')}
  end
  if newname.include?("\\u{")
    err=true
    str="#{newname} contains an Extended Unicode character (a character with a Unicode ID beyond 65,535, almost all of which are emoji).\nDue to the way I store aliases and how Ruby parses strings from text files, I could theoretically store an Extended Unicode character but be unable to find a matching alias."
  end
  if err
    str=["#{str}\nPlease try again.","#{str}\nTrying to list aliases instead."][mode]
    event.respond str if str.length>0
    args=event.message.text.downcase.split(' ')
    args.shift
    list_unit_aliases(event,args,bot) if mode==1
    return nil
  end
  logchn=log_channel()
  str2=''
  if event.server.nil?
    str2="**PM with dev:**"
  else
    str2="**Server:** #{event.server.name} (#{event.server.id}) - #{shard_data(0)[Shardizard]} Shard\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:**"
  end
  str2="#{str2} #{event.user.distinct} (#{event.user.id})"
  if checkstr.downcase =~ /(7|t)+?h+?(o|0)+?(7|t)+?/ && !(dispstr[1].include?('thot') && event.channel.id==532083509083373583)
    event.respond "#{newname} has __***NOT***__ been added to #{matchnames[1]}'s aliases."
    bot.channel(logchn).send_message("#{str2}\n~~**#{type[1].gsub('*','')} Alias:** #{newname} for #{unit}~~\n**Reason for rejection:** Begone, alias.")
    return nil
  elsif checkstr.downcase =~ /n+?((i|1)+?|(e|3)+?)(b|g|8)+?(a|4|(e|3)+?r+?)+?/
    event.respond "That name has __***NOT***__ been added to #{matchnames[1]}'s aliases."
    bot.channel(logchn).send_message("#{str2}\n~~**#{type[1].gsub('*','')} Alias:** >CENSORED< for #{unit}~~\n**Reason for rejection:** Begone, alias.")
    return nil
  end
  newname=normalize(newname,true)
  glbl=10000000000000000000000
  glbl=event.server.id unless event.server.nil?
  if event.user.id==167657750971547648 && modifier.to_i.to_s==modifier
    glbl=0
    glbl=modifier.to_i unless bot.server(modifier.to_i).nil? || bot.on(modifier.to_i).nil?
  elsif [167657750971547648,141260274144509952].include?(event.user.id) && !modifier.nil?
    glbl=0
  end
  alz=$aliases.map{|q| q}
  x=alz.find_index{|q| q[0]==type[1].gsub('*','') && q[1].downcase==newname.downcase && q[2]==matches[1]}
  mewalias=false
  if x.nil?
    m=[type[1].gsub('*',''),newname,matches[1],[glbl]]
    m=[type[1].gsub('*',''),newname,matches[1]] if glbl<=0
    alz.push(m)
    newalias=true
  else
    alz[x][3].push(glbl)
    alz[x][3]=nil if glbl<=0
  end
  str="The alias **#{newname}** for the #{type[1].gsub('*','').downcase} *#{matchnames[1]}* exists in a server already."
  str="#{str}  Making it global now." if glbl<=0
  str="#{str}  Adding this server to those that can use it." unless glbl<=0
  str="**#{newname}** has been #{'globally ' if glbl<=0}added to the aliases for the #{type[1].gsub('*','').downcase} *#{matchnames[1]}*." if newalias
  str="#{str}\nPlease double-check that the alias stuck."
  event.respond str
  (bot.channel(modifier2).send_message(str) if !modifier2.nil? && modifier2.to_i.to_s==modifier2) rescue nil
  type[1]='Multiunit' if kk2.is_a?(Array)
  str2="#{str2}\n**#{type[1].gsub('*','')} Alias:** #{newname} for #{matchnames[1]}"
  str2="#{str2} - gained a new server that supports it" unless newalias || glbl<=0
  str2="#{str2} - gone global" if !newalias && glbl<=0
  str2="#{str2} - global alias" if newalias && glbl<=0
  bot.channel(logchn).send_message(str2)
  alz.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? (supersort(a,b,2,nil,1) == 0 ? (a[1].downcase <=> b[1].downcase) : supersort(a,b,2,nil,1)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
  open("#{$location}devkit/DLNames.txt", 'w') { |f|
    f.puts alz.map{|q| q.to_s}.join("\n")
  }
  bot.channel(logchn).send_message('Alias list saved.')
  nicknames_load()
  nzz=nicknames_load(2)
  nzzz=$aliases.map{|a| a}
  if nzzz[nzzz.length-1].length>1 && nzzz[nzzz.length-1][2]>=nzz[nzz.length-1][2]
    open("#{$location}devkit/DLNames2.txt", 'w') { |f|
      f.puts alz.map{|q| q.to_s}.join("\n")
    }
    bot.channel(logchn).send_message('Alias list has been backed up.')
  end
  return nil
end

def disp_adventurer_stats(bot,event,args=nil,juststats=false)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_adventurer,args.join(' '),event)
  if k.nil?
    event.respond 'No matches found.'
    return nil
  elsif event.user.id==224870997390524416 && k.alts[0].gsub('*','')=='Noelle'
    puts 'Noelleshift for Dan.'
    x=$adventurers.reject{|q| q.alts[0].gsub('*','')!='Melody'}
    disp_adventurer_stats(bot,event,x.sample.name.split(' '),juststats)
    return nil
  end
  data_load(['skills'])
  s2s=false
  s2s=true if safe_to_spam?(event)
  juststats=true if Shardizard != 4 && event.message.text.downcase.split(' ').include?('smol')
  rar=-1
  for i in 0...args.length
    rar=args[i].to_i if rar<0 && args[i].to_i.to_s==args[i] && args[i].to_i>2 && args[i].to_i<$max_rarity[0]+1
    rar=args[i].to_i if rar<0 && args[i][1,1]=='*' && args[i][0,1].to_i.to_s==args[i][0,1] && args[i][0,1].to_i>2 && args[i][0,1].to_i<$max_rarity[0]+1
    rar=5 if rar<0 && ['50','50mc'].include?(args[i].downcase)
  end
  semirar=false
  if rar<0
    semirar=true
    rar=k.rarity*1
    unless juststats || s2s
      rar=0
      rar=$max_rarity[0] unless k.hasManaSpiral?
    end
  elsif rar>k.rarity && s2s
    semirar=true
    rar=k.rarity*1
  elsif rar>k.rarity && !k.hasManaSpiral?
    rar=k.rarity*1
    rar=$max_rarity[0] unless juststats || s2s
  end
  hdr="__**#{k.name}**__"
  unless s2s || juststats
    hdr="#{hdr} #{generate_rarity_row(rar,$max_rarity[0],k.games[0])}"
    hdr="#{hdr} (#{'Mana Spiral, ' if rar<=0}from #{k.rarity}#{k.class_header(bot,2,true)[0]})" unless k.rarity==rar
  end
  title=k.class_header(bot)
  title=k.mini_header(bot,rar) unless s2s || juststats
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
  f=nil
  ftr=nil
  if s2s || juststats
    f=[]
    for i in rar...$max_rarity[0]+1
      f.push([k.rar_row(i),k.stat_grid(i)])
    end
    f.push(["#{generate_rarity_row(0,$max_rarity[0],k.games[0])}#{"\n" unless $embedless.include?(event.user.id) || was_embedless_mentioned?(event)}Mana Unbind",k.stat_grid($max_rarity[0]+1)]) if k.hasManaSpiral?
  elsif rar==0
    ftr="Data shown is for an adventurer whose mana spiral has been unlocked.  To show data for a #{$max_rarity[0]}-star#{" or #{k.rarity}-star" unless $max_rarity[0]==k.rarity} version, please include the number in your message."
  elsif rar != k.rarity
    ftr="Data shown is for a #{rar}-star adventurer.  To show data for a #{k.rarity}-star version, please include #{k.rarity}* in your message."
  end
  ftr=k.footer unless k.footer.nil?
  str=''
  sklz=$skills.map{|q| q}
  unless juststats || k.skills.nil? || k.skills.length<=0
    skl1=sklz.find_index{|q| q.name==k.skills[0]}
    skl1=sklz[skl1] unless skl1.nil?
    skl2=sklz.find_index{|q| q.name==k.skills[1]}
    skl2=sklz[skl2] unless skl2.nil?
    str2=''; str3=''
    lll=[0,3,5,6]
    if k.skills[0].nil? || k.skills[0].length<=0 || k.skills[0]=='-'
      str2='~~Skill 1 does not exist~~'; str3='~~Skill 1 does not exist~~'
    elsif skl1.nil?
      str2="**#{k.skills[0]}** - LOAD ERROR"; str3="**#{k.skills[0]}** - LOAD ERROR"
    elsif s2s
      str2="__**#{skl1.name}** (#{'%.1f' % skl1.invulnerability} sec. invul#{", #{skl1.energy_display}" if skl1.energy_display.length>0})__"
      str2="#{str2} - #{skl1.sp_display(1)} SP" unless skl1.sp_display(0).uniq.length>1
      str2="#{str2} (#{skl1.share_text})" unless skl1.share_text.length<=0
      if skl1.mass_description.nil?
        for i in 0...skl1.description.length
          str2="#{str2}\n*#{skl1.level_text(i+1,lll[i])}:* #{skl1.description[i]}"
        end
      else
        str2="#{str2}\n#{skl1.mass_description}"
        str2="#{str2}\n#{skl1.level_text(1,lll[0])}"
        for i in 1...skl1.description.length
          str2="#{str2} \u2192 #{skl1.level_text(i+1,lll[i])}"
        end
      end
    else
      lvl=skl1.description.length
      lvl=(rar+1)/2 if rar>0
      str2="*#{skl1.name}#{skl1.energy_display(false)} [#{skl1.level_text(lvl,lll[lvl-1],true)}]* - #{skl1.sp_display(lvl)} SP"
      str3="*#{skl1.name}#{skl1.energy_display(false)} [#{skl1.level_text(lvl,lll[lvl-1],true)}]* - #{skl1.sp_display(lvl)} SP"
      str2="#{str2}\n#{skl1.description[lvl-1]}"
      str2="#{str2}\n#{skl1.share_text}" unless skl1.share_text.length<=0
      str3="#{str3}\n#{skl1.share_text}" unless skl1.share_text.length<=0
    end
    lll=[2,4,6,6]
    if k.skills[1].nil? || k.skills[1].length<=0 || k.skills[1]=='-'
      str2="#{str2}\n#{"\n" unless str2[0,2]=='~~'}~~Skill 2 does not exist~~"; str3="#{str3}\n#{"\n" unless str3[0,2]=='~~'}~~Skill 2 does not exist~~"
    elsif skl2.nil?
      str2="#{str2}\n\n**#{k.skills[1]}** - LOAD ERROR"; str3="#{str3}\n\n**#{k.skills[1]}** - LOAD ERROR"
    elsif s2s
      str2="#{str2}\n\n__**#{skl2.name}** (#{'%.1f' % skl2.invulnerability} sec. invul#{", #{skl2.energy_display}" if skl2.energy_display.length>0})__"
      str2="#{str2} - #{skl2.sp_display(1)} SP" unless skl2.sp_display(0).uniq.length>1
      str2="#{str2} (#{skl2.share_text})" unless skl2.share_text.length<=0
      if skl2.mass_description.nil?
        for i in 0...skl2.description.length
          str2="#{str2}\n*#{skl2.level_text(i+1,lll[i])}:* #{skl2.description[i]}"
        end
      else
        str2="#{str2}\n#{skl2.mass_description}"
        str2="#{str2}\n#{skl2.level_text(1,lll[0])}"
        for i in 1...skl2.description.length
          str2="#{str2} \u2192 #{skl2.level_text(i+1,lll[i])}"
        end
      end
    else
      lvl=2
      lvl=1 if rar<4
      lvl=skl2.description.length if rar<=0
      str2="#{str2}\n\n*#{skl2.name}#{skl2.energy_display(false)} [#{skl2.level_text(lvl,lll[lvl-1],true)}]* - #{skl2.sp_display(lvl)} SP"
      str3="#{str3}\n\n*#{skl2.name}#{skl2.energy_display(false)} [#{skl2.level_text(lvl,lll[lvl-1],true)}]* - #{skl2.sp_display(lvl)} SP"
      str2="#{str2}\n#{skl2.description[lvl-1]}"
      str2="#{str2}\n#{skl2.share_text}" unless skl2.share_text.length<=0
      str3="#{str3}\n#{skl2.share_text}" unless skl2.share_text.length<=0
    end
    flength=0
    flength+=ftr.length unless ftr.nil?
    if s2s
      f.push(['Skills',str2,1])
    elsif str2.length+(lng+hdr.length+flength)/2>1800
      str="#{str3}\n\n~~Skill descriptions make this data too long.  Please try again in PM.~~"
    else
      str="#{str2}"
    end
  end
  unless juststats
    if s2s
      xrar=rar*1
      xrar=0 if semirar
      f.push(['Abilities',k.ability_display(xrar)])
    else
      str="#{str}\n\n#{k.ability_display(rar,false)}"
    end
  end
  f2=nil; f3=nil
  lng+=hdr.length+str.length
  lng+=ftr.length unless ftr.nil?
  lng+=f.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length unless f.nil?
  lng+=2000 if !f.nil? && f.map{|q| q[1].length}.max>1000
  if lng>1950 && !f.nil?
    f2=f[-1].map{|q| q}
    if f[-1][0]!='Skills'
      f3=f[-1].map{|q| q}
      f2=f[-2].map{|q| q}
      f.pop
    end
    f.pop
  end
  create_embed(event,[hdr,title],str,k.disp_color,ftr,k.thumbnail(rar),f)
  unless f2.nil?
    if f2[1].length>1950
      f=f2[1].split("\n\n").map{|q| q.split("\n")}
      textform=false; str=''
      for i in 0...f.length
        if f[i][1,f[i].length-1].join("\n").length>1900 || textform
          textform=true
          str=extend_message(str,"Skill #{i+1}: #{f[i][0]}",event,2)
          for i2 in 1...f[i].length
            str=extend_message(str,f[i][i2],event)
          end
        else
          create_embed(event,"Skill #{i+1}: #{f[i][0]}",f[i][1,f[i].length-1].join("\n"),k.disp_color)
        end
      end
      event.respond str if str.length>0
    else
      create_embed(event,"__**Skills**__",f2[1],k.disp_color)
    end
  end
  create_embed(event,"__**#{f3[0]}**__",f3[1],k.disp_color) unless f3.nil?
end

def disp_wyrmprint_stats(bot,event,args=nil,juststats=false)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_wyrmprint,args.join(' '),event)
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  hdr="__**#{k.name}**__"
  title=k.class_header(bot,0,true)
  unless s2s
    title=k.mini_header(bot)
    hdr="#{hdr}#{k.rar_row}"
    if !k.availability.nil? && k.availability.include?('x')
    elsif k.rarity>4
      hdr="#{hdr} - <:Fill_Gold:759999913962110978>"
    else
      hdr="#{hdr} - <:Fill_Silver:759999914062774302>"
    end
  end
  f=nil
  mub=0
  mub=1 if has_any?(['mub','unbind','unbound','refined','refine','refinement','2ub','3ub'],evn)
  if !title.nil? && title.length>250
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
  c=k.stat_grid(bot,s2s)
  str=c[0]; ftr=c[1]
  str="#{str}\n"
  str="#{str}\n**Obtained:** #{k.obtain}" if !k.obtain.nil? && k.obtain.length>0
  if k.isMultiprint?
    str="#{str}\n#{k.multiprintText}"
  elsif !k.availability.nil? || !has_any?(['s','z','y','t','w','x'],k.availability)
    c=k.stat_emotes.map{|q| q}
    str="#{str}\n**Shop Price:** 900#{c[4]} per 2UB, 1,700#{c[4]} per MUB" if k.rarity==3
    str="#{str}\n**Shop Price:** 9,000#{c[4]} per 2UB, 17,000#{c[4]} per MUB" if k.rarity==4
    str="#{str}\n**Shop Price:** 19,000#{c[4]} per 2UB, 37,000#{c[4]} per MUB" if k.rarity==5
    str="#{str}\n**Shop Price:** 25,000#{c[4]} per 2UB, 53,000#{c[4]} per MUB" if k.rarity==6
    str="#{str}\nThese include the cost of buying, and the cost of unbinding." if k.rarity>2 && !k.availability.include?('x')
  end
  create_embed(event,[hdr,title],str,k.disp_color,ftr,k.thumbnail(mub))
end

def disp_weapon_stats(bot,event,args=nil,juststats=false,x=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if x.nil?
    k=find_data_ex(:find_weapon,args.join(' '),event,true)
    # find_in_weapons
    k=find_data_ex(:find_weapon,args.join(' '),event) if k.nil?
  else
    k=x.clone
  end
  if k.nil?
    event.respond 'No matches found.'
    return nil
  elsif k.is_a?(Array)
    args2=args.map{|q| q}
    args2=args2.reject{|q| q.to_i.to_s==q || q.gsub('*','').to_i.to_s==q}
    args2=args2.join(' ')
    args2=first_sub(args2,k[0].element.downcase,'')
    args2=first_sub(args2,'fire','') if k[0].element=='Flame'
    args2=first_sub(args2,'dark','') if k[0].element=='Shadow'
    args2=first_sub(args2,k[0].type.downcase,'')
    args2=first_sub(args2,'spear','') if k[0].type=='Lance'
    args2=first_sub(args2,'void','')
    k2=find_data_ex(:find_enemy,args2,event)
    if k2.length>0 && k2.subdata=='Void'
      k3=k.reject{|q| q.boss_tags.nil? || !q.boss_tags.include?(k2.name)}
      k=k3.map{|q| q} if k3.length>0
    end
    if k.length>5
      event.respond "Too many weapons qualify.  I will not display them all."
      return nil
    end
    for i in 0...k.length
      disp_weapon_stats(bot,event,args,juststats,k[i].clone)
    end
    return nil
  end
  data_load(['skills'])
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  juststats=true if Shardizard != 4 && evn.include?('smol')
  hdr="__**#{k.name}**__"
  title=k.class_header(bot,0,true)
  unless s2s || juststats
    hdr="#{hdr}#{k.rar_row}"
    hdr="#{hdr} - T#{k.tier}" unless k.tier.nil? || k.tier<=0
    title=k.mini_header(bot)
  end
  l=2
  l=1 unless s2s
  l=0 if juststats
  str=k.stat_grid(bot,l)
  ftr=nil
  ftr='Try using the mats command on this weapon!' if rand(10)==0
  lng=title.length
  lng+=ftr.length unless ftr.nil?
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
  unless juststats
    str2=''
    m=k.promotions.map{|q| q}
    m2=k.promoted_from
    mmm2=nil
    wpnz=$weapons.map{|q| q.clone}
    mmm2=wpnz.find_index{|q| q.type==k.type && q.element==k.element && q.availability.inculde?('m')} if k.availability.include?('a')
    mmm2=wpnz.find_index{|q| q.type==k.type && q.element==k.element && q.rarity==5} if k.availability.include?('h')
    if s2s
      str2="#{str2}#{"\n" unless m.length<=1}\n\n**Promotes from: #{m2.emotes(bot)}*#{m2.name}* **#{"\n*Smithy level required:* #{k.smith_level}" unless k.availability.include?('h')}\n*Assembly cost:* #{longFormattedNumber(k.costs[0])}#{k.stat_emotes[4]}\n*Required mats:* #{k.craft_mats.map{|q| "#{q[0]} x#{q[1]}"}.join(', ')}" unless m2.nil?
      str2="#{str2}#{"\n" unless m.length==1}\n\n**Crafting requirements: #{wpnz[mmm2].emotes(bot)}*#{wpnz[mmm2].name}* **" unless mmm2.nil?
      if m.length>0
        for i in 0...m.length
          m[i].costs='0' if m[i].costs.nil? || m[i].costs.length<=0
          str2="#{str2}#{"\n" if i==0 && m.length != 1}\n\n**#{"Promotion #{i+1}" if m.length>1}#{'Promotes into' if m.length==1}: #{m[i].class_header(bot,2,false)[0]}*#{m[i].name}* **#{"\n*Smithy level required:* #{m[i].smith_level}" unless k.availability.include?('h')}\n*Assembly cost:* #{longFormattedNumber(m[i].costs[0])}#{k.stat_emotes[4]}\n*Required mats:* #{m[i].craft_mats.map{|q| "#{q[0]} x#{q[1]}"}.join(', ')}"
        end
      end
    else
      str2="#{str2}\n**Promotes from:** #{m2.class_header(bot,2,false)[0]}#{m2.name}" unless m2.nil?
      str2="#{str2}\n**Crafting requirements:** #{mmm2.class_header(bot,2,false)[0]}#{mmm2.name}" unless mmm2.nil?
      str2="#{str2}\n**Promotes into:** #{m.map{|q| "#{q.class_header(bot,2,false)[0]}#{q.name}"}.join(', ')}" unless m.length<=0
    end
    str="#{str}#{"\n" unless s2s}#{str2}" if str2.length>0
    k.costs='0' if k.costs.nil? || k.costs.length<=0
    str="#{str}\n\n**Assembles for:** #{longFormattedNumber(k.costs[0])}#{k.stat_emotes[4]}" unless k.costs[0]<=0
  end
  if str.length>1900 && !s2s
    sklz=$skills.map{|q| q}
    skl1=sklz.find_index{|q| q.name==k.skills[0]}
    skl1=sklz[skl1] unless skl1.nil?
    str=str.gsub(skl1.description[-1],'~~The description makes this data too long.  Please try again in PM.~~')
  end
  if str.length+hdr.length+lng>=1900
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
    create_embed(event,[hdr,title],str[0],k.disp_color,nil,k.thumbnail)
    if str[1,str.length-1].join("\n\n\n").length<1900
      create_embed(event,'',str[1,str.length-1].join("\n\n\n"),k.disp_color) unless str.length<2
    else
      for i in 1...str.length
        puts str[i]
        create_embed(event,'',str[i],k.disp_color)
      end
    end
    event.respond ftr unless ftr.nil?
  else
    create_embed(event,[hdr,title],str,k.disp_color,ftr,k.thumbnail)
  end
  return nil
end

def disp_weapon_lineage(bot,event,args=nil,comparedata=nil,x=nil)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  if x.nil?
    k=find_data_ex(:find_weapon,args.join(' '),event,true)
    # find_in_weapons
    k=find_data_ex(:find_weapon,args.join(' '),event) if k.nil?
  else
    k=x.clone
  end
  if k.nil?
    event.respond 'No matches found.'
    return nil
  elsif k.is_a?(Array)
    args2=args.map{|q| q}
    args2=args2.reject{|q| q.to_i.to_s==q || q.gsub('*','').to_i.to_s==q}
    args2=args2.join(' ')
    args2=first_sub(args2,k[0].element.downcase,'')
    args2=first_sub(args2,'fire','') if k[0].element=='Flame'
    args2=first_sub(args2,'dark','') if k[0].element=='Shadow'
    args2=first_sub(args2,k[0].type.downcase,'')
    args2=first_sub(args2,'spear','') if k[0].type=='Lance'
    args2=first_sub(args2,'void','')
    k2=find_data_ex(:find_enemy,args2,event)
    if k2.length>0 && k2[2][2]=='Void'
      k3=k.reject{|q| q.boss_tags.nil? || !q.boss_tags.include?(k2.name)}
      k=k3.map{|q| q} if k3.length>0
    end
    k2=[]
    if k.length>5
      event.respond "Too many weapons qualify.  I will not display them all."
      return nil
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
      disp_weapon_lineage(bot,event,args,kx[i],k[i].clone)
    end
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  kx=comparedata.map{|q| q} unless comparedata.nil?
  mub=false
  mub=true if has_any?(['mub','unbind','unbound','refined','refine','refinement'],evn)
  val=0
  unbindnum=false
  for i in 0...args.length
    if count_in(args,args[i])<2 && args[i].to_i==k.rarity && k != kx && !args.include?("#{args[i]}*")
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
  hdr="__**#{k.name}**__"
  title=k.class_header(bot,0,true)
  str=k.stat_grid(bot,-1,mub)
  str=k.stat_grid(bot,1) unless s2s
  unless s2s
    hdr="#{hdr}#{k.rar_row}"
    hdr="#{hdr}-T#{k.tier}" unless k.tier.nil? || k.tier<=0
    hdr="#{hdr} / "
    if mub
      hdr="#{hdr}#{k.stat_emotes[3]*4}"
    else
      hdr="#{hdr}#{k.stat_emotes[2]*4}"
    end
    hdr="#{hdr} x#{val}" if val>1
    title=k.mini_header(bot,!mub)
  end
  ftr=nil
  ftr="Weapon bonus is applied to all #{k.type}-using adventurers, after this weapon is fully upgraded." if has_any?(['a','h','m'],k.availability) || ((k.availability.nil? || k.availability.length<=0) && ![nil,'',' ','-','None','Null'].include?(k.element))
  ftr='Include the word "Unbound" to show the data for MUB versions of these weapons.' unless mub || !s2s
  ftr="This is multiplying all crafts by #{val}.  For crafts for a #{val}UB weapon, include \"#{val}UB\" in your message instead." if val>1 && val<5 && !unbindnum
  lng=title.length
  lng+=ftr.length unless ftr.nil?
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
  str="#{str}#{"\n\n**Crafting shown for #{'<:Unbind:534494090969088000>'*([val-1,4].min)}#{'<:NonUnbound:534494090876682264>'*([5-val,0].max)}**" if val>1 && !mub}\n\n**This weapon#{" (x#{val})" unless val==1}**"
  str="#{str}\n*Smithy level required:* #{k.smith_level}" unless k.smith_level<=0
  k.costs='0' if k.costs.nil? || k.costs.length<=0
  str="#{str}\n*Assembly cost:* #{longFormattedNumber(val*k.costs[0])}#{k.stat_emotes[4]}#{"\n*Required mats:* #{k.craft_mats.map{|q| "#{q[0]} x#{val*q[1].to_i}"}.join(', ')}" unless k.craft_mats.nil?}"
  m2=k.promoted_from
  mmm2=nil
  wpnz=$weapons.map{|q| q.clone}
  mmm2=wpnz.find_index{|q| q.type==k.type && q.element==k.element && q.availability.inculde?('m')} if k.availability.include?('a')
  mmm2=wpnz.find_index{|q| q.type==k.type && q.element==k.element && q.rarity==5} if k.availability.include?('h')
  cost=0
  cost+=val*k.costs[0]
  mtz=[]
  unless k.craft_mats.nil?
    for i in 0...k.craft_mats.length
      mtz.push([k.craft_mats[i][0],k.craft_mats[i][1].to_i*val])
    end
  end
  str2=''
  unless m2.nil? && mmm2.nil?
    ptype='Promotes from'
    if m2.nil?
      ptype='Crafting requirements'
      m2=wpnz[mmm2].clone
      val/=5.0
    end
    m2.costs='0' if m2.costs.nil? || m2.costs.length<=0
    str2="#{str2}\n\n**#{ptype}: #{m2.emotes(bot)}*#{m2.name}* (x#{(5*val).to_i})**\n*Assembly cost:* #{longFormattedNumber((val*5*m2.costs[0]).to_i)}#{k.stat_emotes[4]}\n#{"*Required mats:* #{m2.craft_mats.map{|q| "#{q[0]} x#{(val*5*q[1].to_i).to_i}"}.join(', ')}" unless m2.craft_mats.nil?}"
    cost+=val*5*m2.costs[0]
    unless m2.craft_mats.nil?
      for i in 0...m2.craft_mats.length
        mtz.push([m2.craft_mats[i][0],m2.craft_mats[i][1].to_i*5*val])
      end
    end
    m22=m2.promoted_from
    unless m22.nil?
      m22.costs='0' if m22.costs.nil? || m22.costs.length<=0
      str2="#{str2}\n\n**Which promotes from: #{m22.emotes(bot)}*#{m22.name}* (x#{(25*val).to_i})**\n*Assembly cost:* #{longFormattedNumber((val*25*m22.costs[0]).to_i)}#{k.stat_emotes[4]}\n#{"*Required mats:* #{m22.craft_mats.map{|q| "#{q[0]} x#{(val*25*q[1].to_i).to_i}"}.join(', ')}" unless m22.craft_mats.nil?}"
      cost+=val*25*m22.costs[0]
      unless m22.craft_mats.nil?
        for i in 0...m22.craft_mats.length
          mtz.push([m22.craft_mats[i][0],m22.craft_mats[i][1].to_i*25*val])
        end
      end
      m222=m22.promoted_from
      unless m222.nil?
        m222.costs='0' if m222.costs.nil? || m222.costs.length<=0
        str2="#{str2}\n\n**Which promotes from: #{m222.emotes(bot)}*#{m222.name}* (x#{(125*val).to_i})**\n*Assembly cost:* #{longFormattedNumber((val*125*m222.costs[0]).to_i)}#{k.stat_emotes[4]}\n#{"*Required mats:* #{m222.craft_mats.map{|q| "#{q[0]} x#{(val*125*q[1].to_i).to_i}"}.join(', ')}" unless m222.craft_mats.nil?}"
        cost+=val*125*m222.costs[0]
        unless m222.craft_mats.nil?
          for i in 0...m222.craft_mats.length
            mtz.push([m222.craft_mats[i][0],m222.craft_mats[i][1].to_i*125*val])
          end
        end
        m2222=m222.promoted_from
        unless m2222.nil?
          m2222.costs='0' if m2222.costs.nil? || m2222.costs.length<=0
          str2="#{str2}\n\n**Which promotes from: #{m2222.emotes(bot)}*#{m2222.name}* (x#{(625*val).to_i})**\n*Assembly cost:* #{longFormattedNumber((val*625*m2222.costs[0]).to_i)}#{k.stat_emotes[4]}\n#{"*Required mats:* #{m2222.craft_mats.map{|q| "#{q[0]} x#{(val*625*q[1].to_i).to_i}"}.join(', ')}" unless m2222.craft_mats.nil?}"
          cost+=val*625*m2222.costs[0]
          unless m2222.craft_mats.nil?
            for i in 0...m2222.craft_mats.length
              mtz.push([m2222.craft_mats[i][0],m2222.craft_mats[i][1].to_i*625*val])
            end
          end
          m22222=m2222.promoted_from
          unless m22222.nil?
            m22222.costs='0' if m22222.costs.nil? || m22222.costs.length<=0
            str2="#{str2}\n\n**Which promotes from: #{m22222.emotes(bot)}*#{m22222.name}* (x#{(5*625*val).to_i})**\n*Assembly cost:* #{longFormattedNumber((val*5*625*m22222.costs[0]).to_i)}#{k.stat_emotes[4]}\n#{"*Required mats:* #{m22222.craft_mats.map{|q| "#{q[0]} x#{(val*5*625*q[1].to_i).to_i}"}.join(', ')}" unless m22222.craft_mats.nil?}"
            cost+=val*5*625*m22222.costs[0]
            unless m22222.craft_mats.nil?
              for i in 0...m22222.craft_mats.length
                mtz.push([m22222.craft_mats[i][0],m22222.craft_mats[i][1].to_i*5*625*val])
              end
            end
            m222222=m22222.promoted_from
          end
        end
      end
    end
  end
  unless s2s
    str2=''
    unless m2.nil? && mmm2.nil?
      str2="#{str2}\n\n**#{ptype}:** #{m2.name}"
      unless m22.nil?
        str2="#{str2}\n**Which promotes from:** #{m22.name}"
        str2="#{str2}\n**Which promotes from:** #{m222.name}" unless m222.nil?
        str2="#{str2}\n**Which promotes from:** #{m2222.name}" unless m2222.nil?
        str2="#{str2}\n**Which promotes from:** #{m22222.name}" unless m22222.nil?
      end
    end
  end
  str3=''
  unless m2.nil?
    str3="**TOTALS**\n*Assembly cost:* #{longFormattedNumber(cost.to_i)}#{k.stat_emotes[4]}\n*Required Mats:* "
    mtzz=mtz.map{|q| q[0]}.uniq
    for i in 0...mtzz.length
      str3="#{str3}#{', ' unless i==0}#{mtzz[i]} x#{mtz.reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i}.inject(0){|sum,x| sum + x }}"
    end
  end
  str="#{str}#{str2}" if str2.length>0
  if str.length+str3.length>1900 && !s2s
    sklz=$skills.map{|q| q}
    skl1=sklz.find_index{|q| q.name==k.skills[0]}
    skl1=sklz[skl1] unless skl1.nil?
    str=str.gsub(skl1.description[-1],'~~The description makes this data too long.  Please try again in PM.~~')
  end
  if str.length>1900
    str=str.split("\n\n")
    m=0
    for i in 1...str.length
      if "#{str[m]}\n\n#{str[i]}".length>1900
        m=i*1
      else
        str[m]="#{str[m]}\n\n#{str[i]}"
        str[i]=nil
      end
    end
    str=str.compact!
    str3="#{str[1]}\n\n\n#{str3}"
    str=str[0]
  end
  if str.length+str3.length+hdr.length+lng>=1900
    create_embed(event,[hdr,title],str,k.disp_color,nil,k.thumbnail)
    create_embed(event,'',str3,k.disp_color,ftr) unless str3.length<=0
    event.respond ftr if str3.length<=0
  else
    str="#{str}\n\n#{str3}" unless str3.length<=0
    create_embed(event,[hdr,title],str,k.disp_color,ftr,k.thumbnail)
  end
  return nil
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
        str="#{str}  #{k.stat_emotes[1]}*#{k.stat_emotes[2]}:* #{longFormattedNumber(kx[2])}" if kx[2]>-1
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
      abl=$abilities[abl] unless abl.nil?
      if abl.nil?
        abl=$abilities.find_index{|q| q.name==k.abilities[i]}
        abl=$abilities[abl] unless abl.nil?
      end
      if abl.nil?
        str2="#{str2}\n\n**#{k.abilities[i]}**"
        str3="#{str3}\n*#{k.abilities[i]}*"
      else
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

def disp_skill_data(bot,event,args=nil,forcetags=false,topstr=[])
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_skill,args.join(' '),event)
  forcetags=true if args.include?('tags')
  if k.nil?
    skz=$skills.map{|q| q}
    if args.join('').include?('shift')
      disp_status_data(bot,event,['skill','shift'])
    elsif args.join('').downcase.gsub('s','').include?('dragonclaw')
      disp_skill_data(bot,event,['dragon','claw'])
    elsif !find_data_ex(:find_adventurer,args.join(' '),event).nil? && has_any?(args,['s1','s2','1','2','skill1','skill2','skl1','skl2'])
      adv=find_data_ex(:find_adventurer,args.join(' '),event)
      p=0
      p=1 if has_any?(args,['s2','2','skill2','skl2'])
      if adv.skills.nil? || adv.skills.length<=0 || adv.skills[p].nil? || adv.skills[p].length<=0
        event.respond "#{adv.name}#{adv.emotes(bot)} does not have a #{['1st','2nd'][p]} skill."
        return nil
      end
      skl1=skz.find_index{|q| q.name==adv.skills[p]}
      if skl1.nil?
        event.respond "#{adv.name}#{adv.emotes(bot)}'s #{['1st','2nd'][p]} skill, #{adv.skills[p]}, has no data."
        return nil
      end
      disp_skill_data(bot,event,adv.skills[p].split(' '),forcetags)
    elsif !find_data_ex(:find_dragon,args.join(' '),event).nil?
      adv=find_data_ex(:find_dragon,args.join(' '),event)
      p=0
      p=1 if has_any?(args,['s2','2','skill2','skl2'])
      if adv.skills.nil? || adv.skills.length<=0 || adv.skills[p].nil? || adv.skills[p].length<=0
        event.respond "#{adv.name}#{adv.emotes(bot)} does not have a#{[' 1st',' 2nd'][p] if p>0 || (!adv.skills.nil? && adv.skills.length>1)} skill."
        return nil
      end
      p=0 if adv.skills.length<2
      skl1=skz.find_index{|q| q.name==adv.skills[p]}
      if skl1.nil?
        event.respond "#{adv.name}#{adv.emotes(bot)}'s#{[' 1st',' 2nd'][p] if adv.skills.length>1} skill, #{adv.skills[p]}, has no data."
        return nil
      end
      disp_skill_data(bot,event,adv.skills[p].split(' '),forcetags)
    elsif !find_data_ex(:find_weapon,args.join(' '),event).nil? && has_any?(args,['s3','skill3','skl3'])
      adv=find_data_ex(:find_weapon,args.join(' '),event)
      if adv.is_a?(Array)
        event.respond "There are multiple weapons with that criterium, and I won't display a skill for each."
        return nil
      elsif adv.skills.nil? || adv.skills.length<=0
        event.respond "#{adv.name}#{adv.emotes(bot)} does not have a skill."
        return nil
      end
      skl1=skz.find_index{|q| q.name==adv.skills[0]}
      if skl1.nil?
        event.respond "#{adv.name}#{adv.emotes(bot)}'s skill, #{adv.skills[0]}, has no data."
        return nil
      end
      disp_skill_data(bot,event,adv.skills[0].split(' '),forcetags)
    else
      event.respond 'No matches found.'
    end
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  xcolor=k.disp_color
  xcolor=topstr[1] if topstr.length>0
  str=''; title=''; str2=''
  title="**SP Cost:** #{k.sp_display(1)}" if k.sp_display(0).uniq.length<=1 && k.sp_cost[0]>0 && topstr.length<=0
  title="#{title}\n**Invulnerability duration:** #{k.invulnerability} seconds"
  title="#{title}\n**Skill Share:** *Cost:* #{k.sharing[0]}<:SkillShare:714597012733034547> / #{k.sp_display(-1)} SP\*" if !k.sharing.nil? && k.sharing.length>0
  title="#{title}\n<:Energize:559629242137051155> **Energizable**" if k.energize
  title="#{title}\n~~Not energizable~~" if !k.energize && k.inspirable?
  title="#{title}\n<:Inspiring:688916587079663625> **Inspirable**" if k.inspirable?
  title="#{title}\n~~Not inspirable~~" if !k.inspirable? && k.energize
  title="#{title}\n~~Not energizable or inspirable~~" if !k.energize && !k.inspirable?
  if k.nihilimmune==true
    title="#{title}\n**Immune to Nihil**"
  elsif k.nihilimmune.nil?
    title="#{title}\nPartially immune to Nihil"
  else
    title="#{title}\n~~Not immune to Nihil~~"
  end
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
  ftr=nil
  hdr="__**#{k.name}**__"
  if topstr.length>0
    hdr="#{topstr[0]} - #{hdr}"
  else
    hdr="#{hdr}#{k.emotes(bot)}"
  end
  str="#{k.energy_emoji(true)}".gsub(', ',"\n")
  displvl=0
  for i in 0...k.description.length
    if topstr.length<=0 || i>1 || (i==1 && k.description.length<3)
      str2="#{str2}\n\n__**Level #{i+1}**__"
      str2="#{str2} - #{k.sp_display(i+1)} SP" unless k.sp_display(0).uniq.length<=1 || k.sp_cost[i]<=0
      str2="#{str2}\n#{k.description[i]}"
    end
  end
  if !s2s && str2.length>1500
    if k.sp_display(0).uniq.length<=1 || k.sp_cost[i]<=0
      str2="__**Level #{k.description.length}**__\n#{k.description[-1]}"
      str2="#{k.mass_description}" unless k.mass_description.nil? || k.mass_description.length<=0
    else
      str2=''
      for i in 0...k.description.length
        if topstr.length<=0 || i>1 || (i==1 && k.description.length<3)
          str2="#{str2}\n\n__**Level #{i+1}**__"
          str2="#{str2} - #{k.sp_display(i+1)} SP"
          str2="#{str2}\n#{k.description[i]}" if i==k.description.length-1
        end
      end
    end
  end
  flds=[]; m=[]; advx=[]
  x=$adventurers.map{|q| q}
  for i in 0...x.length
    advx.push(x[i].name) if x[i].skills.include?(k.name)
    m.push("#{x[i].emotes(bot)}#{x[i].name} - S1") if x[i].skills[0]==k.name
    m.push("#{x[i].emotes(bot)}#{x[i].name} - S2") if x[i].skills[1]==k.name
  end
  flds.push(['Adventurers',m.join("\n")]) if m.length>0 && topstr.length<=0
  if topstr.length<=0
    m=[]
    x=$dragons.map{|q| q}
    for i in 0...x.length
      advx.push(x[i].name) if x[i].skills.include?(k.name)
      m.push("#{x[i].emotes(bot)}#{x[i].name} - S1") if x[i].skills[0]==k.name
      m.push("#{x[i].emotes(bot)}#{x[i].name} - S2") if x[i].skills[1]==k.name
    end
    flds.push(['Dragons',m.join("\n")]) if m.length>0
    m=[]
    x=$weapons.map{|q| q}
    for i in 0...x.length
      m.push("#{x[i].emotes(bot)}#{x[i].name} - S3") if x[i].skills[0]==k.name
      m.push("#{x[i].emotes(bot)}#{x[i].name} - refined S3") if x[i].skills[1]==k.name
    end
    flds.push(['Weapons',m.join("\n")]) if m.length>0
  end
  if args.include?('tags') || forcetags
    if flds.length<=0
      flds=triple_finish(k.tags.reject{|q| ['E','I'].include?(q[0,1]) && q[1,1].to_i.to_s==q[1,1]})
      str2="#{str2}\n\n__**Tags**__"
    else
      flds.push(['Tags',k.tags.reject{|q| ['E','I'].include?(q[0,1]) && q[1,1].to_i.to_s==q[1,1]}.join("\n")])
    end
  end
  str="#{str}\n\nYou may instead be searching for the ability family `Dragon's Claws`." if k.name=='Dragon Claw' && topstr.length<=0
  if !k.sharing.nil? && k.sharing.length>0
    advy=[]
    advy.push("#{k.sp_display(-2)} SP for Nef archetypes") unless advx.include?('Nefaria')
    advy.push("#{k.sp_display(-3)} SP for Hawk archetypes") unless advx.include?('Hawk')
    ch=', '
    ch="\n" if !k.sp_oddity.nil? && k.sp_oddity.length>0
    str="#{str}\n\* #{advy.join(ch)}" if advy.length>0
  end
  flds=nil if flds.length<=0
  lng+=flds.map{|q| "__#{q[0]}__\n#{q[1]}"}.join("\n\n").length unless flds.nil?
  if str.length+title.length+str2.length+lng<1800 && (displvl<2 || s2s || k.mass_description.nil? || k.mass_description.length<=0)
    str="#{str}#{str2}"
    create_embed(event,[hdr,title],str,xcolor,ftr,k.thumbnail,flds)
  elsif str2.length<1800 && (displvl<2 || s2s || k.mass_description.nil? || k.mass_description.length<=0)
    create_embed(event,[hdr,title],str,xcolor,nil,k.thumbnail)
    create_embed(event,'',str2.gsub('__**Tags**__',''),xcolor)
    create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
  elsif displvl<2 || k.mass_description.nil? || k.mass_description.length<=0
    create_embed(event,[hdr,title],str,xcolor,nil,k.thumbnail)
    m=str2.split("\n\n").reject{|q| q.nil? || q.length<=0}
    s=''
    for i in 0...m.length
      s=extend_message(s,m[i],event,2)
    end
    event.respond s
    create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
  else
    str2="\n\n#{k.mass_description}#{"\n#{k.level_text(0)}" unless k.sp_display(0).uniq.length<=1 || k.sp_cost[i]<=0}"
    if str.length+str2.length+m<1800
      str="#{str}#{str2}"
      create_embed(event,[hdr,title],str,xcolor,nil,k.thumbnail,flds)
    elsif str2.length<1800
      create_embed(event,[hdr,title],str,xcolor,nil,k.thumbnail)
      create_embed(event,'',str2,xcolor)
      create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
    else
      create_embed(event,[hdr,title],str,xcolor,nil,k.thumbnail)
      m=str2.split("\n").reject{|q| q.nil? || q.length<=0}
      s=''
      for i in 0...m.length
        s=extend_message(s,m[i],event,2)
      end
      event.respond s
      create_embed(event,'','',xcolor,nil,nil,flds) unless flds.nil?
    end
  end
  return nil
end

def disp_ability_data(bot,event,args=nil,forceaura='')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_ability,args.join(' '),event)
  s2s=false
  s2s=true if safe_to_spam?(event)
  if forceaura.nil? || k.nil? || k.length<=0
  elsif forceaura=='CoAbility' && s2s
    k=k.reject{|q| q.type !=forceaura && q.type !='Chain'}
  elsif forceaura.length>0
    k=k.reject{|q| q.type !=forceaura}
  end
  if k.nil? || k.length.zero?
    sklz=$abilities.map{|q| q}
    if forceaura.length>0 && forceaura != 'Ability'
      if forceaura=='Aura' && find_data_ex(:find_dragon,args.join(' '),event).nil?
        event.respond 'No matches found.'
        return nil
      elsif forceaura != 'Aura' && find_data_ex(:find_adventurer,args.join(' '),event).nil?
        event.respond 'No matches found.'
        return nil
      end
    end
    if !find_data_ex(:find_adventurer,args.join(' '),event).nil? && (has_any?(args,['a1','a2','a3','1','2','3','ability1','ability2','ability3','abil1','abil2','abil3','chaincoabil','chaincoability','chaincoab','coabilchain','coabilitychain','chain','coabchain','cca','cc','coabil','coability','coab']) || (forceaura.length>0 && !['Ability','Aura'].include?(forceaura)))
      adv=find_data_ex(:find_adventurer,args.join(' '),event)
      p=0
      p=1 if has_any?(args,['a2','2','ability2','abil2'])
      p=2 if has_any?(args,['a3','3','ability3','abil3'])
      pp=false
      m=nil
      m=adv.abilities[p] unless adv.abilities.nil?
      m=m[-1] unless m.nil? || m.is_a?(String)
      if forceaura.length>0 && forceaura != 'Ability'
        pp=true
        p=0
        p=1 if forceaura=='Chain'
      elsif has_any?(args,['chaincoabil','chaincoability','chaincoab','coabilchain','coabilitychain','chain','coabchain','cca','cc','coabil','coability','coab'])
        pp=true
        p=0
        p=1 if has_any?(args,['chaincoabil','chaincoability','chaincoab','coabilchain','coabilitychain','chain','coabchain','cca','cc'])
      end
      if pp
        m=[adv.coability,adv.chain][p]
        unless m.nil?
          kk=m.split(' ')
          kk=[kk[0,kk.length-1].join(' '),kk[-1].split('/')[-1]]
          kk[1]="+#{kk[1]}" if kk[1].include?('%')
          m=kk.join(' ')
        end
      end
      if m.nil?
        event.respond "#{adv.name}#{adv.emotes(bot)} does not have a #{['1st','2nd','3rd'][p]} ability." unless pp
        event.respond "#{adv.name}#{adv.emotes(bot)} does not have a #{['','chain '][p]}coability." if pp
        return nil
      end
      skl1=sklz.find_index{|q| q.type=='Ability' && q.fullName==m}
      skl1=sklz.find_index{|q| q.type==['CoAbility','Chain'][p] && q.fullName==m} if pp
      if skl1.nil?
        event.respond "#{adv.name}#{adv.emotes(bot)}'s #{['1st','2nd','3rd'][p]} ability, #{m}, has no data." unless pp
        event.respond "#{adv.name}#{adv.emotes(bot)}'s #{['','chain '][p]}coability, #{m}, has no data." if pp
        return nil
      end
      disp_ability_data(bot,event,m.split(' '),'Ability') unless pp
      disp_ability_data(bot,event,kk.join(' ').split(' '),['CoAbility','Chain'][p]) if pp
    elsif !find_data_ex(:find_dragon,args.join(' '),event).nil? && (has_any?(args,['a1','a2','a3','1','2','3','ability1','ability2','ability3','abil1','abil2','abil3']) || forceaura=='Aura')
      adv=find_data_ex(:find_dragon,args.join(' '),event)
      p=0
      p=1 if has_any?(args,['s2','2','skill2','skl2'])
      p=2 if has_any?(args,['a3','3','ability3','abil3'])
      if adv.auras.nil? || adv.auras.length<=0 || adv.auras[p].nil? || adv.auras[p].length<=0
        event.respond "#{adv.name}#{adv.emotes(bot)} does not have a #{['1st','2nd','3rd'][p]} aura."
        return nil
      end
      p=[adv.auras.length-1,p].min
      skl1=sklz.find_index{|q| q.type=='Aura' && q.fullName==adv.auras[p][-1]}
      if skl1.nil?
        event.respond "#{adv.name}#{adv.emotes(bot)}'s #{['1st','2nd','3rd'][p]} aura, #{adv.auras[p][-1]}, has no data."
        return nil
      end
      disp_ability_data(bot,event,adv.auras[p][-1].split(' '),'Aura')
    elsif !find_data_ex(:find_wyrmprint,args.join(' '),event).nil? && (has_any?(args,['a1','a2','a3','1','2','3','ability1','ability2','ability3','abil1','abil2','abil3']) || forceaura=='Ability')
      adv=find_data_ex(:find_wyrmprint,args.join(' '),event)
      puts adv.name
      p=0
      p=1 if has_any?(args,['s2','2','skill2','skl2'])
      p=2 if has_any?(args,['a3','3','ability3','abil3'])
      if adv.abilities.nil? || adv.abilities.length<=0 || adv.abilities[p].nil? || adv.abilities[p].length<=0
        event.respond "#{adv.name}#{adv.emotes(bot)} does not have a#{'n' unless p>0 || (!adv.abilities.nil? && adv.abilities.length>1)}#{[' 1st',' 2nd',' 3rd'][p] if p>0 || (!adv.abilities.nil? && adv.abilities.length>1)} ability."
        return nil
      end
      p=[adv.abilities.length-1,p].min
      skl1=sklz.find_index{|q| q.type=='Ability' && q.fullName==adv.abilities[p][-1]}
      if skl1.nil?
        event.respond "#{adv.name}#{adv.emotes(bot)}'s#{[' 1st',' 2nd',' 3rd'][p] if p>0 || (!adv.abilities.nil? && adv.abilities.length>1)} ability, #{adv.abilities[p][-1]}, has no data."
        return nil
      end
      disp_ability_data(bot,event,adv.abilities[p][-1].split(' '),'Ability')
    elsif !find_data_ex(:find_weapon,args.join(' '),event).nil? && (has_any?(args,['a1','a2','a3','1','2','3','ability1','ability2','ability3','abil1','abil2','abil3']) || forceaura=='Ability')
      adv=find_data_ex(:find_weapon,args.join(' '),event)
      puts adv.name
      p=0
      p=1 if has_any?(args,['s2','2','skill2','skl2'])
      p=2 if has_any?(args,['a3','3','ability3','abil3'])
      if adv.is_a?(Array)
        event.respond "There are multiple weapons with that criterium, and I won't display an ability for each."
        return nil
      elsif adv.abilities.nil? || adv.abilities.length<=0 || adv.abilities[p].nil? || adv.abilities[p].length<=0
        event.respond "#{adv.name}#{adv.emotes(bot)} does not have a #{['1st','2nd','3rd'][p]} ability."
        return nil
      end
      p=[adv.abilities.length-1,p].min
      skl1=sklz.find_index{|q| q.type=='Ability' && q.fullName==adv.abilities[p][-1]}
      if skl1.nil?
        event.respond "#{adv.name}#{adv.emotes(bot)}'s #{['1st','2nd','3rd'][p]} ability, #{adv.abilities[p][-1]}, has no data."
        return nil
      end
      disp_ability_data(bot,event,adv.abilities[p][-1].split(' '),'Ability')
    else
      event.respond 'No matches found.'
    end
    return nil
  end
  evn=event.message.text.downcase.split(' ')
  k=k.reject{|q| q.type=='Aura'} if k.is_a?(Array) && k.map{|q| q.type}.uniq.length>1
  i=0
  while i<k.length
    k=k.reject{|q| q.name==k[i].name && q.level==k[i].level && q.type==k[i].type && q !=k[i]}
    i+=1
  end
  dispslots=false; dispsubabils=false; ttags=false
  dispslots=true if has_any?(evn,['slots','slot'])
  dispsubabils=true if has_any?(evn,['sub','subabilities','subability','starter'])
  ttags=true if evn.include?('tags')
  typ=[]
  for i in 0...evn.length
    unless k[0].fullName.split(' ').include?(evn[i].downcase)
      typ.push('Adventurers') if ['adventurer','adventurers','adv','advs','unit','units'].include?(evn[i].downcase)
      typ.push('Dragons') if ['drg','drgs'].include?(evn[i].downcase)
      typ.push('Dragons') if ['dragon','dragons'].include?(evn[i].downcase) && evn.reject{|q| q.downcase != evn[i].downcase}.length>1
      typ.push('Wyrmprints') if ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(evn[i].downcase)
      typ.push('Weapons') if ['weapon','weapons','wpns','wpnz','wpn','weps','wepz','wep','weaps','weapz','weap'].include?(evn[i].downcase)
      typ.push('Enemies') if ['enemies','boss','enemy','bosses','enemie','enemys','bosss'].include?(evn[i].downcase)
    end
  end
  typ.uniq!
  typ=['Adventurers','Dragons','Wyrmprints','Weapons','Enemies'] if typ.length<=0
  hdr="__**#{k[0].fullName}** [#{k[0].type}]__"
  hdr="__**#{k[0].name}** [#{k[0].type} Family]__" if k.length>1
  str=''; ftr=nil; flds=nil
  k2=k.map{|q| q}.uniq
  k2=k.reject{|q| q.type != 'Ability'}.uniq if k.map{|q| q.type}.uniq.length>1 && !k.find_index{|q| q.type=='Ability'}.nil?
  if k.map{|q| q.type}.uniq.length>1 && k.map{|q| q.level}.uniq.length<=1
    hdr="__**#{k[0].fullName}** [Ability Family]__"
    for i in 0...k.length
      str="#{str}#{"\n\n" if str.length>0}__**#{k[i].type}**__\n#{k[i].description}"
      madv=k[i].adv_list(bot,event,dispslots,dispsubabils,true)
      madv=[] unless typ.include?('Adventurers')
      exlength=madv.length
      mdrg=k[i].drg_list(bot,event,dispslots,dispsubabils,true)
      mdrg=[] unless typ.include?('Dragons')
      exlength+=mdrg.length
      mwep=k[i].wep_list(bot,event,dispslots,dispsubabils,true)
      mwep=[] unless typ.include?('Weapons')
      exlength+=mwep.length
      mevil=k[i].enemy_list(bot,event,dispslots,dispsubabils,true)
      mevil=[] unless typ.include?('Enemies')
      exlength+=mevil.length
      mprint=k[i].print_list(bot,event,dispslots,dispsubabils,true,exlength)
      mprint=[] unless typ.include?('Wyrmprints')
      str="#{str}\n*Adventurers:* #{madv.map{|q| q.name}.join(', ')}" if madv.length>0
      str="#{str}\n*Dragons:* #{mdrg.map{|q| q.name}.join(', ')}" if mdrg.length>0
      str="#{str}\n*Wyrmprints:* #{mprint.map{|q| q.name}.join(', ')}" if mprint.length>0
      str="#{str}\n*Weapons:* #{mwep.map{|q| q.name}.join(', ')}" if mwep.length>0
      str="#{str}\n*Enemies:* #{mevil.map{|q| q.name}.join(', ')}" if mevil.length>0
      str="#{str}\n*Tags:* #{k[i].tags.join(', ')}" if ttags
    end
  elsif k2.length==1
    str=k2[0].description
    str="**#{k2[0].level}** - #{k2[0].description}" unless k.length<=1
    madv=k2[0].adv_list(bot,event,dispslots,dispsubabils,true)
    madv=[] unless typ.include?('Adventurers')
    exlength=madv.length
    mdrg=k2[0].drg_list(bot,event,dispslots,dispsubabils,true)
    mdrg=[] unless typ.include?('Dragons')
    exlength+=mdrg.length
    mwep=k2[0].wep_list(bot,event,dispslots,dispsubabils,true)
    mwep=[] unless typ.include?('Weapons')
    exlength+=mwep.length
    mevil=k2[0].enemy_list(bot,event,dispslots,dispsubabils,true)
    mevil=[] unless typ.include?('Enemies')
    exlength+=mevil.length
    mprint=k2[0].print_list(bot,event,dispslots,dispsubabils,true,exlength)
    mprint=[] unless typ.include?('Wyrmprints')
    flds=[]
    if madv.length>0 && mdrg.length<=0 && mprint.length<=0 && mwep.length<=0 && mevil.length<=0 # adv only
      flds.push(['<:Element_Flame:532106087952810005>Flame adventurers',madv.reject{|q| q.element != 'Flame'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
      flds.push(['<:Element_Water:532106088221376522>Water adventurers',madv.reject{|q| q.element != 'Water'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
      flds.push(['<:Element_Wind:532106087948746763>Wind adventurers',madv.reject{|q| q.element != 'Wind'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
      flds.push(['<:Element_Light:532106088129101834>Light adventurers',madv.reject{|q| q.element != 'Light'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
      flds.push(['<:Element_Shadow:532106088154267658>Shadow adventurers',madv.reject{|q| q.element != 'Shadow'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
    elsif madv.length<=0 && mdrg.length>0 && mprint.length<=0 && mwep.length<=0 && mevil.length<=0 # drg only
      flds.push(['<:Element_Flame:532106087952810005>Flame dragons',mdrg.reject{|q| q.element != 'Flame'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
      flds.push(['<:Element_Water:532106088221376522>Water dragons',mdrg.reject{|q| q.element != 'Water'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
      flds.push(['<:Element_Wind:532106087948746763>Wind dragons',mdrg.reject{|q| q.element != 'Wind'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
      flds.push(['<:Element_Light:532106088129101834>Light dragons',mdrg.reject{|q| q.element != 'Light'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
      flds.push(['<:Element_Shadow:532106088154267658>Shadow dragons',mdrg.reject{|q| q.element != 'Shadow'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
    elsif madv.length<=0 && mdrg.length<=0 && mprint.length>0 && mwep.length<=0 && mevil.length<=0 # print only
      flds.push(['Wyrmprints',mprint.map{|q| q.name}.join("\n")])
    elsif madv.length<=0 && mdrg.length<=0 && mprint.length<=0 && mwep.length>0 && mevil.length<=0 # wep only
      if mwep.map{|q| q.type}.uniq.length<=1
        x="#{mwep[0].name.split('>')[0]}>#{mwep[0].type.gsub('Staff','Stave')}s"
        for i in 0...mwep.length
          mwep[i].name=mwep[i].name.split('>')[1,q.name.split('>').length-1].join('>')
        end
        flds.push(["<:Element_Flame:532106087952810005>Flame #{x}",mwep.reject{|q| q.element != 'Flame'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(["<:Element_Water:532106088221376522>Water #{x}",mwep.reject{|q| q.element != 'Water'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(["<:Element_Wind:532106087948746763>Wind #{x}",mwep.reject{|q| q.element != 'Wind'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(["<:Element_Light:532106088129101834>Light #{x}",mwep.reject{|q| q.element != 'Light'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(["<:Element_Shadow:532106088154267658>Shadow #{x}",mwep.reject{|q| q.element != 'Shadow'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
      else
        flds.push(['<:Weapon_Sword:532106114540634113>Swords',mwep.reject{|q| q.type != 'Sword'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(['<:Weapon_Blade:532106114628714496>Blades',mwep.reject{|q| q.type != 'Blade'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(['<:Weapon_Dagger:532106116025286656>Daggers',mwep.reject{|q| q.type != 'Dagger'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(['<:Weapon_Axe:532106114188443659>Axes',mwep.reject{|q| q.type != 'Axe'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(['<:Weapon_Bow:532106114909732864>Bows',mwep.reject{|q| q.type != 'Bow'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(['<:Weapon_Lance:532106114792423448>Lances',mwep.reject{|q| q.type != 'Lance'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(['<:Weapon_Wand:532106114985099264>Wands',mwep.reject{|q| q.type != 'Wand'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(['<:Weapon_Staff:532106114733441024>Staves',mwep.reject{|q| q.type != 'Staff'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
        flds.push(['<:Weapon_Manacaster:758905122448867338>Manacasters',mwep.reject{|q| q.type != 'Manacaster'}.map{|q| q.name.split('>')[1,q.name.split('>').length-1].join('>')}.join("\n")])
      end
    elsif madv.length<=0 && mdrg.length<=0 && mprint.length<=0 && mwep.length<=0 && mevil.length>0 # enemy only
      flds.push(['Enemies',mevil.map{|q| q.name}.join("\n")])
    else # multiple entities
      flds.push(['Adventurers',madv.map{|q| q.name}.join("\n")]) if madv.length>0
      flds.push(['Dragons',mdrg.map{|q| q.name}.join("\n")]) if mdrg.length>0
      flds.push(['Wyrmprints',mprint.map{|q| q.name}.join("\n")]) if mprint.length>0
      flds.push(['Weapons',mwep.map{|q| q.name}.join("\n")]) if mwep.length>0
      flds.push(['Enemies',mevil.map{|q| q.name}.join("\n")]) if mevil.length>0
    end
    flds.push(['Tags',k2[0].tags.join("\n")]) if ttags
    flds=flds.reject{|q| q[1].nil? || q[1].length<=0}
    if flds.length==1
      str="#{str}\n\n__**#{flds[0][0]}**__"
      m=flds[0][1].split("\n")
      if m.length<=5
        str="#{str}\n#{flds[0][1]}"
        flds=nil
      else
        flds=triple_finish(m)
      end
    elsif flds.length<=0
      flds=nil
    end
    ftr='To include base abilities, include the word "subabilities" in your message.'
    ftr=nil if ['CoAbility','Chain'].include?(k2[0].type)
  else
    ftr='For a list of ways to obtain these abilities, look a single one of them up.'
    diiv=k2.length
    diiv=k2.length/2 if k2.length>=5
    diiv=k2.length/3 if k2.length>=16
    diiv=k2.length/4 if k2.length>=25
    diiv=k2.length/5 if k2.length>=32
    diiv=10 if k2.length>=50
    for i in 0...k2.length
      shw=k2[i].show
      shw=false if k2[i].level.include?('%') && k2.map{|q| q.level}.include?('example') && k2.length>=5 && i%diiv>0
      shw=false if k2[i].level != 'example' && k2[i].description.include?("\n")
      madv=k2[i].adv_list(bot,event,dispslots,dispsubabils)
      madv=[] unless typ.include?('Adventurers')
      exlength=madv.length
      mdrg=k2[i].drg_list(bot,event,dispslots,dispsubabils)
      mdrg=[] unless typ.include?('Dragons')
      exlength+=mdrg.length
      mwep=k2[i].wep_list(bot,event,dispslots,dispsubabils)
      mwep=[] unless typ.include?('Weapons')
      exlength+=mwep.length
      mevil=k2[i].enemy_list(bot,event,dispslots,dispsubabils)
      mevil=[] unless typ.include?('Enemies')
      exlength+=mevil.length
      mprint=k2[i].print_list(bot,event,dispslots,dispsubabils,false,exlength)
      unless k2[i].resonance_level(bot).nil? || !s2s
        mres=DLWyrmprint.new(k2[i].resonance_level(bot))
        mprint.push(mres)
      end
      mprint=[] unless typ.include?('Wyrmprints')
      exlength+=mprint.length
      if k2[i].level=='example'
        str="#{str}#{"\n\n" if str.length>0}#{k2[i].description}\n"
      elsif [nil,'','-'].include?(k2[i].level)
        str="#{str}#{"\n" if str.length>0}#{k2[i].description}"
      elsif s2s
        str="#{str}#{"\n" if str.length>0}#{"\n" if str.length>0 && (exlength>0 || !str.split("\n")[-1].include?('**'))}**#{k2[i].fullName}**#{" - #{k2[i].description}" if shw}"
        str="#{str}\n*Adventurers:* #{madv.map{|q| q.name}.join(', ')}" if madv.length>0
        str="#{str}\n*Dragons:* #{mdrg.map{|q| q.name}.join(', ')}" if mdrg.length>0
        str="#{str}\n*Wyrmprints:* #{mprint.map{|q| q.name}.join(', ')}" if mprint.length>0
        str="#{str}\n*Weapons:* #{mwep.map{|q| q.name}.join(', ')}" if mwep.length>0
        str="#{str}\n*Enemies:* #{mevil.map{|q| q.name}.join(', ')}" if mevil.length>0
      else
        str="#{str}#{"\n" if str.length>0}**#{k2[i].level}**"
        str="#{str} - #{k2[i].description}" if shw
        m=[]
        chrrr=', '
        if madv.length+mdrg.length+mprint.length+mwep.length+mevil.length<6 && [madv,mdrg,mprint,mwep,mevil].map{|q| q.length}.max<4
          chrrr=' - '
          m.push(madv.map{|q| q.name}.join(', ')) if madv.length>0
          m.push(mdrg.map{|q| q.name}.join(', ')) if mdrg.length>0
          m.push(mprint.map{|q| q.name}.join(', ')) if mprint.length>0
          m.push(mwep.map{|q| q.name}.join(', ')) if mwep.length>0
          m.push(mevil.map{|q| q.name}.join(', ')) if mevil.length>0
        else
          m.push("#{madv.length} adv#{'s' unless madv.length==1}") if madv.length>0
          m.push("#{mdrg.length} drg#{'s' unless mdrg.length==1}") if mdrg.length>0
          m.push("#{mprint.length} print#{'s' unless mprint.length==1}") if mprint.length>0
          m.push("#{mwep.length} wep#{'s' unless mwep.length==1}") if mwep.length>0
          m.push("#{mevil.length} enem#{'ies' unless mevil.length==1}#{'y' if mevil.length==1}") if mevil.length>0
        end
        m.push(k2[i].resonance_level(bot)) unless k2[i].resonance_level(bot).nil?
        str="#{str} - #{m.join(chrrr)}" if m.length>0
      end
    end
    str="#{str}\n\n**Tags:** #{k2[0].tags.join(', ')}" if ttags
  end
  str="#{str}\n\n**You may instead be searching for the skill `Dragon Claw`, which belongs to Gala Mym<:Rarity_5:532086056737177600><:Element_Flame:532106087952810005><:Weapon_Lance:532106114792423448><:Type_Attack:532107867520630784>.**" if "Dragon's Claws"==k[0].name
  str2=[]
  if k.map{|q| q.type}.uniq.length>1 && k.map{|q| q.level}.uniq.length>1 && !k.find_index{|q| q.type=='Ability'}.nil?
    k2=k.reject{|q| q.type != 'CoAbility' || q.level=='example'}
    str2.push("**CoAbility levels:** #{k2.map{|q| q.level}.join(', ')}") if k2.length>0
    k2=k.reject{|q| q.type != 'Chain' || q.level=='example'}
    str2.push("**Chain CoAbility levels:** #{k2.map{|q| q.level}.join(', ')}") if k2.length>0
  end
  f=$abilimits.map{|q| q.split(" \u2192 ")}
  if f.map{|q| q[0]}.include?(k[0].name) && k[0].type=='Ability'
    str2.push("**Per-adventurer wyrmprint stack limit:** #{f[f.find_index{|q| q[0]==k[0].name}][1]}")
  elsif ['Flame Res','Water Res','Wind Res','Light Res','Shadow Res'].include?(k[0].name) && f.map{|q| q[0]}.include?('Element Res') && k[0].type=='Ability'
    str2.push("**Per-adventurer wyrmprint stack limit:** #{f[f.find_index{|q| q[0]=='Element Res'}][1]}")
  end
  str="#{str}\n\n#{str2.join("\n")}" if str2.length>0
  title='~~Not immune to Nihil~~'
  title='**Immune to Nihil**' if k[0].nihilimmune==true
  title='Partially immune to Nihil' if k[0].nihilimmune.nil?
  m=hdr.length+str.length+title.length
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
  m+=ftr.length unless ftr.nil?
  m+=flds.map{|q| "__#{q[0]}__\n#{q[1]}"}.join("\n\n").length unless flds.nil?
  if m>1900
    str=str.split("\n\n")
    for i in 0...str.length
      if i==0
        str[i]=['',str[i]]
      else
        str[i]=["\n\n",str[i]]
      end
      if str[i][1].length>1900
        str[i][1]=str[i][1].split("\n")
        for i2 in 0...str[i][1].length
          if i2==0
            str[i][1][i2]=[nil,str[i][1][i2]]
          else
            str[i][1][i2]=["\n",str[i][1][i2]]
          end
          if str[i][1][i2][1].length>1900
            str[i][1][i2][1]=str[i][1][i2][1].split(', ')
            for i3 in 1...str[i][1][i2][1].length
              str[i][1][i2][1][i3]=[', ',str[i][1][i2][1][i3]]
            end
          end
        end
      end
    end
    str.flatten!
    str.compact!
    xpic=k[0].thumbnail
    j=''
    for i in 0...str.length/2
      if "#{j}#{str[2*i]}#{str[2*i+1]}".length>1900
        create_embed(event,[hdr,title],j,k[0].disp_color,nil,xpic)
        j=str[2*i+1]; hdr=''; title=nil; xpic=nil
      else
        j="#{j}#{str[2*i]}#{str[2*i+1]}"
      end
    end
    m=j.length
    m+=ftr.length unless ftr.nil?
    m+=flds.map{|q| "__#{q[0]}__\n#{q[1]}"}.join("\n\n").length unless flds.nil?
    if m<1900
      create_embed(event,[hdr,title],j,k[0].disp_color,ftr,xpic,flds)
    elsif flds.nil?
      create_embed(event,[hdr,title],j,k[0].disp_color,nil,xpic)
      create_embed(event,'','',k[0].disp_color,ftr)
    elsif flds.map{|q| "__#{q[0]}__\n#{q[1]}"}.join("\n\n").length>1900 && flds.length>1
      create_embed(event,[hdr,title],j,k[0].disp_color,nil,xpic)
      for i in 0...flds.length
        m=nil
        m=ftr if i==flds.length-1
        create_embed(event,"__#{flds[i][0]}__",'',k[0].disp_color,m,nil,triple_finish(flds[i][1].split("\n")))
      end
    else
      create_embed(event,[hdr,title],j,k[0].disp_color,nil,xpic)
      create_embed(event,'','',k[0].disp_color,ftr,nil,flds)
    end
  else
    create_embed(event,[hdr,title],str,k[0].disp_color,ftr,k[0].thumbnail,flds)
  end
end

def disp_facility_data(bot,event,args=nil)
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  kxx=find_data_ex(:find_facility,args.join(' '),event)
  if kxx.nil? || kxx.length.zero?
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
  title="**Type:** #{k.type} #{"(#{k.subtype})" unless k.subtype.nil?}"
  title="#{title}\n**Size:** #{k.size}"
  title="#{title}\n**Final Level:** #{kxx.length}" if kxx.length>1
  title="#{title}\n**Quantity available:** #{k.quantity}"
  hdr="__**#{k.name}**__"
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
  str="#{str}\n\n**Description:** #{k.description}"
  m='t'
  m='Amber' if ['Staff Dojo'].include?(k.name)
  m='Azure' if ['Blade Dojo','Lance Dojo'].include?(k.name)
  m='Jade' if ['Axe Dojo','Wand Dojo'].include?(k.name)
  m='Vermillion' if ['Sword Dojo','Bow Dojo'].include?(k.name)
  m='Violet' if ['Dagger Dojo','Manacaster Dojo'].include?(k.name)
  str="#{str}\n\n**First Dojo cost:** Dyrenell Aes x10\n**Second Dojo cost:** Dyrenell Aes x30, Dyrenell Argenteus x10, #{k.name.split(' ')[0]} Tablet x2" if k.type=='Adventurer' && k.subtype=='Dojo'
  if k.type=='Adventurer' && k.subtype=='Altar'
    if k.name=='Flame Altar'
      str="#{str}\n\n**First Altar becomes available at:** Player Level#{' (PL)' if s2s} 1\n**Second Altar becomes available at:** Player Level 40"
      str="#{str}\n\nBy default can only go to Level 10\nCan reach Level 15 at PL 12\nCan reach Level 20 at PL 24\nCan reach Level 25 at PL 37\nCan reach Level 30 at PL 67" if s2s
    elsif k.name=='Wind Altar'
      str="#{str}\n\n**First Altar becomes available at:** Player Level#{' (PL)' if s2s} 4\n**Second Altar becomes available at:** Player Level 45"
      str="#{str}\n\nBy default can only go to Level 10\nCan reach Level 15 at PL 14\nCan reach Level 20 at PL 26\nCan reach Level 25 at PL 40\nCan reach Level 30 at PL 70" if s2s
    elsif k.name=='Water Altar'
      str="#{str}\n\n**First Altar becomes available at:** Player Level#{' (PL)' if s2s} 6\n**Second Altar becomes available at:** Player Level 50"
      str="#{str}\n\nBy default can only go to Level 10\nCan reach Level 15 at PL 16\nCan reach Level 20 at PL 28\nCan reach Level 25 at PL 43\nCan reach Level 30 at PL 73" if s2s
    elsif k.name=='Shadow Altar'
      str="#{str}\n\n**First Altar becomes available at:** Player Level#{' (PL)' if s2s} 8\n**Second Altar becomes available at:** Player Level 55"
      str="#{str}\n\nBy default can only go to Level 10\nCan reach Level 15 at PL 18\nCan reach Level 20 at PL 30\nCan reach Level 25 at PL 46\nCan reach Level 30 at PL 76" if s2s
    elsif k.name=='Light Altar'
      str="#{str}\n\n**First Altar becomes available at:** Player Level#{' (PL)' if s2s} 10\n**Second Altar becomes available at:** Player Level 60"
      str="#{str}\n\nBy default can only go to Level 10\nCan reach Level 15 at PL 20\nCan reach Level 20 at PL 32\nCan reach Level 25 at PL 49\nCan reach Level 30 at PL 79" if s2s
    end
  elsif k.name=='Fafnir Statue (Flame)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Flame:532106087952810005>High Brunhilda's Trial\n**Cost:** Flamewyrm's Greatsphere x30, Talonstone x10"
  elsif k.name=='Fafnir Statue (Water)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Water:532106088221376522>High Mercury's Trial\n**Cost:** Waterwyrm's Greatsphere x30, Talonstone x10"
  elsif k.name=='Fafnir Statue (Wind)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Wind:532106087948746763>High Midgardsormr's Trial\n**Cost:** Windwyrm's Greatsphere x30, Talonstone x10"
  elsif k.name=='Fafnir Statue (Light)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Light:532106088129101834>High Jupiter's Trial\n**Cost:** Lightwyrm's Greatsphere x30, Talonstone x10"
  elsif k.name=='Fafnir Statue (Shadow)'
    str="#{str}\n\n**Unlocked by:** Completing <:Element_Shadow:532106088154267658>High Zodiark's Trial\n**Cost:** Shadowwyrm's Greatsphere x30, Talonstone x10"
  elsif k.name=='Smithy' && !s2s
    str="#{str}\n\nLevel 1-3 Smithies can craft #{generate_rarity_row(3)} weapons"
    str="#{str}\nLevel 4-6 Smithies can craft #{generate_rarity_row(4)} weapons"
    str="#{str}\nLevel 7-9 Smithies can craft #{generate_rarity_row(5)} weapons"
    str="#{str}\nLevel 9 Smithies can craft #{generate_rarity_row(6)} weapons"
    str="#{str}\nEach new level of smithy allows you to craft higher-tier weapons within the newest-allowed rarity bracket."
  end
  ftr=nil
  ftr='Use this command in PM to see the costs to upgrade this facility.' unless s2s
  create_embed(event,[hdr,title],str,k.disp_color,ftr,k.thumbnail)
  if k.name=='Smithy'
    str="__**Can craft #{generate_rarity_row(3)} weapons**__"
    str="#{str}\n*Level 1 \u2192 2:* 1,000<:Resource_Rupies:532104504372363274> - ~~no mats~~"
    str="#{str}\n*Level 2 \u2192 3:* 5,000<:Resource_Rupies:532104504372363274> - Light Metal x3"
    str="#{str}\n\n__**Can craft #{generate_rarity_row(4)} weapons**__"
    str="#{str}\n*Level 3 \u2192 4:* 20,000<:Resource_Rupies:532104504372363274> - Iron Ore x10, Fiend's Claw x10, Bat's Wing x10"
    str="#{str}\n\n__**Can craft <:Element_Null:532106087810334741>elementless #{generate_rarity_row(5)} weapons**__"
    str="#{str}\n*Level 4 \u2192 5:* 40,000<:Resource_Rupies:532104504372363274> - Iron Ore x15, Fiend's Claw x15, Bat's Wing x15, Light Metal x15"
    str="#{str}\n\n__**Can craft Elemental #{generate_rarity_row(5)} weapons**__"
    str="#{str}\n*Level 5 \u2192 6:* 60,000<:Resource_Rupies:532104504372363274> - Granite x10, Fiend's Horn x10, Ancient Bird's Feather x10"
    str="#{str}\n\n__**Can craft <:Element_Void:548467446734913536>Void and High Dragon weapons**__"
    str="#{str}\n*Level 6 \u2192 7:* 80,000<:Resource_Rupies:532104504372363274> - Granite x15, Fiend's Horn x15, Ancient Bird's Feather x15, Abyss Stone x15"
    str="#{str}\n\n__**Can craft Chimeratech and #{generate_rarity_row(6)} weapons**__"
    str="#{str}\n*Level 7 \u2192 8:* 100,000<:Resource_Rupies:532104504372363274> - Meteorite x10, Fiend's Eye x10, Bewitching Wings x10"
    str="#{str}\n*Level 8 \u2192 9:* 120,000<:Resource_Rupies:532104504372363274> - Meteorite x15, Fiend's Eye x15, Bewitching Wings x15, Crimson Core x15"
  elsif k.name=='Halidom'
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
      args[i]=args[i].split('-') if args[i].include?('-') && args[i].split('-').reject{|q| q.to_i.to_s==q}.length<=0
    end
    args.flatten!
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
    str=''
    str="**Amounts shown are for #{val} copies of this facility.**\n" unless val==1
    if nums.length<=0
      mtz=[]
      xcost=0
      for i in 0...kxx.length
        xcost+=kxx[i].cost
        if s2s && !minmax
          str="#{str}\nCreation: #{longFormattedNumber(kxx[i].cost*val)}<:Resource_Rupies:532104504372363274>" if i==0
          str="#{str}\nLevel #{i} \u2192 #{i+1}: #{longFormattedNumber(kxx[i].cost*val)}<:Resource_Rupies:532104504372363274>" unless i==0
        end
        unless kxx[i].mats.nil?
          for i2 in 0...kxx[i].mats.length
            mtz.push(kxx[i].mats[i2])
          end
          str="#{str} - #{kxx[i].mats.map{|q| "#{q[0]} x#{q[1].to_i*val}"}.sort.join(', ')}" if s2s && !minmax
        end
        if minmax && i>0
        elsif !s2s && !minmax
        elsif k.stat_buffs(i).length==1
          alta=k.stat_buffs(i)
          str="#{str}\nBuff at Level #{i+1}: Damage+#{'%.1f' % alta[0]}%"
        elsif k.stat_buffs(i).length>0
          alta=k.stat_buffs(i)
          str="#{str}\nBuffs at Level #{i+1}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
        end
      end
      str=str.gsub('Level 1:','**Initial Buff:**') if minmax
      mtzz=mtz.map{|q| q[0]}.uniq.sort
      str3="TOTAL: #{longFormattedNumber(xcost*val)}<:Resource_Rupies:532104504372363274> - "
      for i in 0...mtzz.length
        str3="#{str3}#{', ' unless i==0}#{mtzz[i]} x#{mtz.reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i*val}.inject(0){|sum,x| sum + x }}"
      end
      if k.stat_buffs(kxx.length-1).length==1
        alta=k.stat_buffs(kxx.length-1)
        str3="#{str3}\nFINAL BUFF: Damage+#{'%.1f' % alta[0]}%"
      elsif k.stat_buffs(kxx.length-1).length>1
        alta=k.stat_buffs(kxx.length-1)
        str3="#{str3}\nFINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      end
      str="#{str}\n\n**#{str3}**"
    elsif nums.length==1
      n=[nums[0],kxx.length].min
      mtz=[[],[]]
      xcost=[0,0]
      for i in 0...kxx.length
        xcost[0]+=kxx[i].cost*val if i<n
        xcost[1]+=kxx[i].cost*val unless i<n
        unless kxx[i].mats.nil?
          for i2 in 0...kxx[i].mats.length
            mtz[0].push(kxx[i].mats[i2]) if i<n
            mtz[1].push(kxx[i].mats[i2]) unless i<n
          end
        end
      end
      str3="**Total from level 1 to #{n}:** #{longFormattedNumber(xcost[0])}<:Resource_Rupies:532104504372363274>"
      mtzz=mtz[0].map{|q| q[0]}.uniq.sort
      for i in 0...mtzz.length
        str3="#{str3}#{' - ' if i==0}#{', ' unless i==0}#{mtzz[i]} x#{mtz[0].reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i*val}.inject(0){|sum,x| sum + x }}"
      end
      if k.stat_buffs(n-1).length==1
        alta=k.stat_buffs(n-1)
        str3="#{str3}\nBuff at Level #{n}: Damage+#{'%.1f' % alta[0]}%"
      elsif k.stat_buffs(n-1).length>0
        alta=k.stat_buffs(n-1)
        str3="#{str3}\nBuffs at Level #{n}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      end
      str="#{str}\n\n#{str3}" unless n==1
      str3="**Total from level #{n} to #{kxx.length}:** #{longFormattedNumber(xcost[1])}<:Resource_Rupies:532104504372363274>"
      mtzz=mtz[1].map{|q| q[0]}.uniq.sort
      for i in 0...mtzz.length
        str3="#{str3}#{' - ' if i==0}#{', ' unless i==0}#{mtzz[i]} x#{mtz[1].reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i*val}.inject(0){|sum,x| sum + x }}"
      end
      if k.stat_buffs(kxx.length-1).length==1
        alta=k.stat_buffs(kxx.length-1)
        str3="#{str3}\nFINAL BUFF: Damage+#{'%.1f' % alta[0]}%"
      elsif k.stat_buffs(kxx.length-1).length>1
        alta=k.stat_buffs(kxx.length-1)
        str3="#{str3}\nFINAL BUFF: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      end
      str="#{str}\n\n#{str3}" unless n==kxx.length
    else
      n=[nums[0,2].min,1].max
      n=1 if n>kxx.length
      n2=[nums[0,2].max,kxx.length].min
      mtz=[]
      xcost=0
      kxx=kxx[n,n2-n]
      for i in 0...kxx.length
        xcost+=kxx[i].cost
        if !s2s && i != 0
        elsif k.stat_buffs(n+i-1).length==1
          alta=k.stat_buffs(n+i-1)
          str="#{str}\nBuffs at Level #{n+i}: Damage+#{'%.1f' % alta[0]}%"
        elsif k.stat_buffs(n+i-1).length>0
          alta=k.stat_buffs(n+i-1)
          str="#{str}\nBuffs at Level #{n+i}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
        end
        str="#{str}\nLevel #{n+i} \u2192 #{n+i+1}: #{longFormattedNumber(kxx[i].cost*val)}<:Resource_Rupies:532104504372363274>" if s2s
        unless kxx[i].mats.nil?
          for i2 in 0...kxx[i].mats.length
            mtz.push(kxx[i].mats[i2])
          end
          str="#{str} - #{kxx[i].mats.map{|q| "#{q[0]} x#{q[1].to_i*val}"}.sort.join(', ')}" if s2s
        end
      end
      if !s2s
      elsif k.stat_buffs(n2-1).length==1
        alta=k.stat_buffs(n2-1)
        str="#{str}\nBuff at Level #{n2}: Damage+#{'%.1f' % alta[0]}%"
      elsif k.stat_buffs(n2-1).length>1
        alta=k.stat_buffs(n2-1)
        str="#{str}\nBuffs at Level #{n2}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      end
      mtzz=mtz.map{|q| q[0]}.uniq.sort
      str3="TOTAL from level #{n} to #{n2}: #{longFormattedNumber(xcost*val)}<:Resource_Rupies:532104504372363274> - "
      for i in 0...mtzz.length
        str3="#{str3}#{', ' unless i==0}#{mtzz[i]} x#{mtz.reject{|q| q[0]!=mtzz[i]}.map{|q| q[1].to_i*val}.inject(0){|sum,x| sum + x }}"
      end
      if k.stat_buffs(n2-1).length==1
        alta=k.stat_buffs(n2-1)
        str3="#{str3}\nBuff at level #{n2}: Damage+#{'%.1f' % alta[0]}%"
      elsif k.stat_buffs(n2-1).length>1
        alta=k.stat_buffs(n2-1)
        str3="#{str3}\nBuffs at level #{n2}: <:HP:573344832307593216>+#{'%.1f' % alta[0]}% <:Strength:573344931205349376>+#{'%.1f' % alta[1]}%"
      end
      str="#{str}\n\n**#{str3}**"
    end
  end
  str=str.gsub("\n\n","\n") if minmax
  if str.length>=1900
    str=str.split("\n")
    if str[-2][0,2]=='**' && str[-1][-2,2]=='**'
      str[-2]="#{str[-2]}\n#{str[-1]}"
      str[-1]=nil
      str.compact!
    end
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

def disp_mat_data(bot,event,args=nil,extvat=false)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_mat,args.join(' '),event)
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  title=k.class_header(bot,0,true)
  title=k.mini_header(bot) unless s2s
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
  ftr=nil
  hdr="__**#{k.name}**__"
  hdr="#{hdr}#{k.emotes(bot)}" unless s2s
  str="**Description:** #{k.description}"
  str="#{str}\n**EXP:** #{longFormattedNumber(k.exp)}" unless k.exp<=0
  if k.obtain.length<=0
  elsif s2s || k.obtain.length<=5 || k.uses.length+k.obtain.length<=8
    str="#{str}\n\n**Ways to obtain:**\n#{k.obtain.join("\n")}"
  else
    str="#{str}\n\n**Ways to obtain:**\n#{k.obtain[0,3].join("\n")}\n~~For more, please use this command in PM~~"
  end
  if k.uses.length<=0
  elsif s2s || k.uses.length<=5 || k.uses.length+k.obtain.length<=8
    str="#{str}\n\n**Uses:**\n#{k.uses.join("\n")}"
  else
    str="#{str}\n\n**Uses:**\n#{k.uses[0,3].join("\n")}\n~~For more, please use this command in PM~~"
  end
  f=nil
  f=triple_finish(k.tags.sort,true) if args.include?('tag') || args.include?('tags')
  f=nil unless s2s
  lng+=f.map{|q| q[1]}.join("\n").length+"\n\n**searching tags:**".length unless f.nil?
  
  create_embed(event,[hdr,title],str,k.disp_color,ftr,k.thumbnail,f)
end

def disp_status_data(bot,event,args=nil,extvat=false)
  dispstr=event.message.text.downcase.split(' ')
  args=event.message.text.downcase.split(' ') if args.nil?
  args=args.reject{ |a| a.match(/<@!?(?:\d+)>/) } # remove any mentions included in the inputs
  k=find_data_ex(:find_status,args.join(' '),event)
  if k.nil?
    event.respond 'No matches found.'
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  ftr=nil
  str="**Effect on player:** #{k.player_effect}" unless k.player_effect.nil?
  str="#{str}\n\n**Effect on enemy:** #{k.enemy_effect}" unless k.enemy_effect.nil?
  m=$statuses.reject{|q| q.slot != k.slot || q.name==k.name}
  ftr="#{list_lift(m.map{|q| q.name},'and')} will overwrite this status.  All other statuses will stack instead." unless k.slot==0 || m.length<=0
  ftr="If you meant to set a status, please include the word \"set\" as the first argument in this command." if event.user.id==167657750971547648 && evn[0]=='dl!status'
  create_embed(event,"__**#{k.name}**__",str,k.disp_color,ftr,k.thumbnail)
end

bot.command([:adventurer,:adv,:unit]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  if args.nil? || args.length<=0
  elsif ['level','xp','exp'].include?(args[0].downcase)
    args.shift
    level(event,bot,args,2)
    return nil
  elsif ['art'].include?(args[0].downcase)
    args[0]='adventurer'
    disp_art(bot,event,args)
    return nil
  elsif ['alt','alts'].include?(args[0].downcase)
    args[0]='adventurer'
    find_adv_alts(bot,event,args)
    return nil
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    display_adventurers(bot,event,args)
    return nil
  elsif ['mat','mats','material','materials','node','nodes'].include?(args[0].downcase)
    args[0]='adventurer'
    upgrade_mats(event,args,bot)
    return nil
  elsif ['synergy','synergize'].include?(args[0].downcase)
    args.shift
    adv_chain_list(event,args,bot)
    return nil
  end
  disp_adventurer_stats(bot,event,args)
end

bot.command([:dragon,:drg,:drag]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  if args.nil? || args.length<=0
  elsif ['level','xp','exp'].include?(args[0].downcase)
    args.shift
    level(event,bot,args,3)
    return nil
  elsif ['art'].include?(args[0].downcase)
    args[0]='dragon'
    disp_art(bot,event,args)
    return nil
  elsif ['alt','alts'].include?(args[0].downcase)
    args[0]='dragon'
    disp_alts(bot,event,args)
    return nil
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    display_dragons(bot,event,args)
    return nil
  end
  disp_dragon_stats(bot,event,args)
end

bot.command([:wyrmprint,:wyrm,:print]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  if args.nil? || args.length<=0
  elsif ['shop','store'].include?(args[0].downcase)
    reload_library()
    show_print_shop(event)
    return nil
  elsif ['level','xp','exp'].include?(args[0].downcase)
    args.shift
    level(event,bot,args,5)
    return nil
  elsif ['art'].include?(args[0].downcase)
    args[0]='print'
    disp_art(bot,event,args)
    return nil
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    display_wyrmprints(bot,event,args)
    return nil
  elsif ['synergy','synergize'].include?(args[0].downcase)
    args.shift
    print_overlap_list(event,args,bot)
    return nil
  end
  disp_wyrmprint_stats(bot,event,args)
end

bot.command([:weapon,:wep,:weap,:wpn]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['level','xp','exp'].include?(args[0].downcase)
    args.shift
    level(event,bot,args,6)
    return nil
  elsif ['lineage','craft','crafting'].include?(args[0].downcase)
    args.shift
    disp_weapon_lineage(bot,event,args)
    return nil
  elsif ['mat','mats','material','materials','node','nodes'].include?(args[0].downcase)
    args[0]='weapon'
    upgrade_mats(event,args,bot)
    return nil
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    display_weapons(bot,event,args)
    return nil
  elsif ['print','prints'].include?(args[0].downcase)
    args.shift
    print_overlap_list(event,args,bot)
    return nil
  end
  disp_weapon_stats(bot,event,args)
end

bot.command([:enemy,:boss]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  if args.nil? || args.length<=0
  elsif ['art'].include?(args[0].downcase)
    args[0]='boss'
    disp_art(bot,event,args)
    return nil
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    display_enemies(bot,event,args)
    return nil
  end
  disp_enemy_data(bot,event,args)
end

bot.command([:skill,:skil]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    display_skills(bot,event,args)
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
  data_load('library')
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
  data_load('library')
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
  data_load('library')
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
  data_load('library')
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    args=args.reject{|q| ['coabil','coability','coabilitys','coabilities','coabils','coab','coabs','aura','auras'].include?(q)}
    find_abilities(bot,event,args)
    return nil
  end
  disp_ability_data(bot,event,args,'Chain')
end

bot.command([:skillshare,:skilshare,:share,:shared]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  sort_shareable_skills(event,args,bot)
  return nil
end

bot.command([:facility,:faculty,:fac]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    display_facilities(bot,event,args)
    return nil
  end
  disp_facility_data(bot,event,args)
end

bot.command([:mat,:material,:item]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    display_mats(bot,event,args)
    return nil
  elsif ['adv','adventurer'].include?(args[0].downcase)
    args.shift
    disp_adv_mats(event,args,bot)
    return nil
  elsif ['weapon','wep','weap','wpn'].include?(args[0].downcase)
    args.shift
    disp_weapon_lineage(bot,event,args)
    return nil
  end
  disp_mat_data(bot,event,args)
end

# direct data ends here

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

bot.command([:alts,:alt]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  disp_alts(bot,event,args)
end

bot.command([:lineage,:craft,:crafting]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_weapon_lineage(bot,event,args)
end

bot.command([:ailment,:affliction]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_status_data(bot,event,args)
end

bot.command([:art]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  disp_art(bot,event,args)
end

bot.command([:banners,:banner]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_banners(bot,event,args)
    return nil
  end
  disp_banner(bot,event,args)
end

bot.command([:spiral]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  upgrade_mats(event,args,bot,true)
  return nil
end

bot.command([:mats,:materials,:node,:nodes]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  upgrade_mats(event,args,bot)
  return nil
end

bot.command([:sp,:SP]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  disp_sp_table(bot,event,args)
end

bot.command([:dmg,:damage,:combo]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  disp_damage_modifiers(bot,event,args)
end

bot.command([:find,:search,:lookup]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  display_search_results(bot,event,args)
end

bot.command([:sort,:list]) do |event, *args|
  return nil if overlap_prevent(event)
  if args.nil? || args.length<=0
  elsif ['aliases','alias'].include?(args[0].downcase) && event.user.id==167657750971547648
    data_load()
    nicknames_load()
    $aliases.uniq!
    $aliases.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? ((a[2].downcase <=> b[2].downcase) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2].downcase <=> b[2].downcase)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
    open("#{$location}devkit/DLNames.txt", 'w') { |f|
      for i in 0...$aliases.length
        f.puts "#{$aliases[i].to_s}#{"\n" if i<$aliases.length-1}"
      end
    }
    event.respond 'The alias list has been sorted alphabetically'
    return nil
  end
  sort_things(bot,event,args)
end

bot.command(:addalias) do |event, newname, unit, modifier, modifier2|
  return nil if overlap_prevent(event)
  data_load(['library'])
  add_new_alias(bot,event,newname,unit,modifier,modifier2)
  return nil
end

bot.command(:alias) do |event, newname, unit, modifier, modifier2|
  return nil if overlap_prevent(event)
  data_load(['library'])
  add_new_alias(bot,event,newname,unit,modifier,modifier2,1)
  return nil
end

bot.command([:deletealias,:removealias]) do |event, name|
  return nil if overlap_prevent(event)
  nicknames_load()
  if name.nil?
    event.respond "I can't delete nothing, silly!" if name.nil?
    return nil
  elsif event.user.id != 167657750971547648 && event.server.nil?
    event.respond 'Only my developer is allowed to use this command in PM.'
    return nil
  elsif !is_mod?(event.user,event.server,event.channel)
    event.respond 'You are not a mod.'
    return nil
  end
  saliases=true
  saliases=false if event.user.id==167657750971547648 # only my developer can delete global aliases
  canremove=false
  k=find_best_match(name,bot,event,true,false,0)
  k=k[0] if !k.nil? && k.is_a?(Array)
  cmpr=[]
  if k.nil? || k.is_a?(DLBanner)
    k=find_best_match(name,bot,event,false,false,0)
    if k.nil? || k.is_a?(DLBanner)
      event.respond "#{name} is not an alias, silly!"
    else
      f=k.alias_list(bot,event,saliases,true)
      f=f.reject{|q| q[0,name.length].downcase != name.downcase}
      if f.length<=0
        event.respond "You cannot delete a global alias."
      else
        event.respond "Please use a whole alias, not a partial one.  The following aliases begin with the text you typed:\n#{f.join("\n")}"
      end
    end
    return nil
  elsif !k.alias_list(bot,event,saliases,true).map{|q| q.downcase}.include?(name.downcase) && event.user.id != 167657750971547648
    event.respond "You cannot delete a global alias."
    return nil
  else
    k2="#{k.objt}"
    baseunt="#{k.fullName}#{k.emotes(bot,true)}"
    cmpr.push(k.fullName)
  end
  kx=0
  kx=event.server.id unless event.server.nil?
  alz=$aliases.map{|q| q}
  globalattempt=false
  for i in 0...alz.length
    if alz[i][0]==k2 && alz[i][1].downcase==name.downcase && cmpr.include?(alz[i][2])
      if alz[i][3].nil?
        if event.user.id==167657750971547648
          alz[i]=nil
        else
          globalattempt=true
        end
      elsif alz[i][3].include?(kx)
        globalattempt=false
        alz[i][3]=alz[i][3].reject{|q| q==kx}
        alz[i]=nil if alz[i][3].length<=0
      end
    end
  end
  if globalattempt
    event.respond "You cannot delete a global alias."
    return nil
  end
  alz.uniq!
  alz.compact!
  alz.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? (supersort(a,b,2,nil,1) == 0 ? (a[1].downcase <=> b[1].downcase) : supersort(a,b,2,nil,1)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
  logchn=log_channel()
  str=''
  if event.server.nil?
    str="**PM with dev:**"
  else
    str="**Server:** #{event.server.name} (#{event.server.id}) - #{shard_data(0)[Shardizard]} Shard\n**Channel:** #{event.channel.name} (#{event.channel.id})\n**User:**"
  end
  str="#{str} #{event.user.distinct} (#{event.user.id})"
  str="#{str}\n~~**#{k2} Alias:** #{name} for #{baseunt}~~ "
  if rand(1000)==0
    str="#{str}**YEETED**"
  else
    str="#{str}**DELETED**"
  end
  bot.channel(logchn).send_message(str)
  event.respond "#{name} has been removed from #{baseunt}'s aliases."
  alz.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? (supersort(a,b,2,nil,1) == 0 ? (a[1].downcase <=> b[1].downcase) : supersort(a,b,2,nil,1)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
  open("#{$location}devkit/DLNames.txt", 'w') { |f|
    f.puts alz.map{|q| q.to_s}.join("\n")
  }
  bot.channel(logchn).send_message('Alias list saved.')
  nicknames_load()
  nzz=nicknames_load(2)
  nzzz=$aliases.map{|a| a}
  if nzzz[nzzz.length-1].length>1 && nzzz[nzzz.length-1][2]>=nzz[nzz.length-1][2]
    open("#{$location}devkit/DLNames2.txt", 'w') { |f|
      f.puts alz.map{|q| q.to_s}.join("\n")
    }
    bot.channel(logchn).send_message('Alias list has been backed up.')
  end
  return nil
end

bot.command([:serveraliases,:saliases]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  list_aliases(bot,event,args,1)
  return nil
end

bot.command([:checkaliases,:aliases,:seealiases]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  list_aliases(bot,event,args)
  return nil
end

bot.command([:synergy,:synergize]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  if args.nil? || args.length<=0
  elsif ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
    args.shift
    adv_chain_list(event,args,bot)
    return nil
  elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
    args.shift
    print_overlap_list(event,args,bot)
    return nil
  end
  event.respond "What are you synergizing?  *Adventurers* on a team, or *wyrmprints* on a weapon?"
  return nil
end

bot.command([:prints,:weapprints,:wepprints,:weaponprints,:wpnprints,:weaprints,:weprints,:weapprint,:wepprint,:weaponprint,:wpnprint,:weaprint,:weprint]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  print_overlap_list(event,args,bot)
  return nil
end

bot.command([:team,:backpack]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load(['library'])
  adv_chain_list(event,args,bot)
  return nil
end

bot.command([:seegroups,:checkgroups,:groups]) do |event|
  return nil if overlap_prevent(event)
  data_load(['library'])
  disp_groups(event)
  return nil
end

bot.command([:roost]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  today_in_dl(event,bot,args,false,1)
end

bot.command([:ruin,:ruins]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  today_in_dl(event,bot,args,false,2)
end

bot.command([:shop,:store]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  if args.nil? || args.length<=0
  elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
    show_print_shop(event)
    return nil
  end
  today_in_dl(event,bot,args,false,3)
end

bot.command([:reset]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  today_in_dl(event,bot,args,false,4)
end

bot.command([:daily,:dailies]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  today_in_dl(event,bot,args)
end

bot.command([:today,:now,:todayindl,:today_in_dl]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  today_in_dl(event,bot,args,true)
end

bot.command([:tomorrow,:tommorrow,:tomorow,:tommorow]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  today_in_dl(event,bot,args,-1)
end

bot.command([:next,:schedule]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  next_events(event,bot,args)
end

bot.command([:xp,:exp,:level]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  level(event,bot,args)
end

bot.command([:plxp,:plexp,:pllevel,:plevel,:pxp,:pexp]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  level(event,bot,args,1)
end

bot.command([:advxp,:advexp,:advlevel,:alevel,:axp,:aexp]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  level(event,bot,args,2)
end

bot.command([:drgxp,:drgexp,:drglevel,:dlevel,:dxp,:dexp]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  level(event,bot,args,3)
end

bot.command([:bxp,:bexp,:blevel,:dbxp,:dbexp,:dblevel,:bondlevel,:bondxp,:bondexp]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  level(event,bot,args,4)
end

bot.command([:wrxp,:wrexp,:wrlevel,:wyrmxp,:wyrmexp,:wyrmxp,:wyrmlevel]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  level(event,bot,args,5)
end

bot.command([:wpxp,:wpexp,:wplevel,:weaponxp,:weaponexp,:weaponlevel]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  level(event,bot,args,6)
end

bot.command([:wxp,:wexp,:wlevel]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
  level(event,bot,args,7)
end

bot.command([:limit,:limits,:stack,:stacks]) do |event|
  return nil if overlap_prevent(event)
  data_load('library')
  show_abil_limits(event,bot)
end

bot.command([:affinity,:resonance]) do |event|
  return nil if overlap_prevent(event)
  data_load('library')
  affinity_resonance(event,bot)
end

bot.command(:whybotan) do |event|
  return nil if overlap_prevent(event)
  data_load(['library'])
  why_botan(event,bot)
end

bot.command([:embeds,:embed]) do |event|
  return nil if overlap_prevent(event)
  metadata_load()
  if $embedless.include?(event.user.id)
    for i in 0...$embedless.length
      $embedless[i]=nil if $embedless[i]==event.user.id
    end
    $embedless.compact!
    event.respond 'You will now see my replies as embeds again.'
  else
    $embedless.push(event.user.id)
    event.respond 'You will now see my replies as plaintext.'
  end
  metadata_save()
  return nil
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

bot.command([:bugreport,:suggestion,:feedback]) do |event, *args|
  return nil if overlap_prevent(event)
  x=['dl!','dl?']
  x.push(@prefixes[event.server.id]) unless event.server.nil? || @prefixes[event.server.id].nil?
  bug_report(bot,event,args,Shards,shard_data(0),'Shard',x,532083509083373583)
end

bot.command([:donation,:donate]) do |event, uid|
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
      elsif !File.exist?("#{$location}devkit/EliseImages/#{g[4][2]}.png")
        str="#{str}\n\n**Tier 3:** Birthday avatar\n\u2717 Not given.  Please contact <@167657750971547648> to have this corrected.\n*Birthday:* #{g[3][1]} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][g[3][0]]}\n*Character:* #{g[4][2]}"
      else
        str="#{str}\n\n**Tier 3:** Birthday avatar\n\u2713 Given\n*Birthday:* #{g[3][1]} #{['','January','February','March','April','May','June','July','August','September','October','November','December'][g[3][0]]}\n*Character:* #{g[4][2]}"
      end
    end
    create_embed(event,"__**#{n} a Tier #{g[2][2]} donor.**__",str,color)
  end
  donor_embed(bot,event)
end

bot.command([:shard,:attribute]) do |event, i, j|
  return nil if overlap_prevent(event)
  if Shardizard<0
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
    j=Shards*1
  end
  if (i.to_i.to_s==i || i.to_i==i) && i.to_i>256*256
    srv=(bot.server(i.to_i) rescue nil)
    if i.to_i==327237968047898624 && [5,6].include?(j)
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[0]} Shards." if j != Shards
      event.respond "That server would use #{shard_data(0,true,j)[0]} Shards." if j == Shards
    elsif i.to_i==327237968047898624 && j<=4
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[2]} Shards." if j != Shards
      event.respond "That server would use #{shard_data(0,true,j)[2]} Shards." if j == Shards
    elsif i.to_i==327237968047898624
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[1]} Shards." if j != Shards
      event.respond "That server would use #{shard_data(0,true,j)[1]} Shards." if j == Shards
    elsif Shardizard ==4 && j != Shards
      event.respond "In a system of #{j} shards, that server would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards."
    elsif Shardizard ==4
      event.respond "That server uses/would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards."
    elsif srv.nil? || bot.user(543373018303299585).on(srv.id).nil?
      event.respond "I am not in that server, but it would use #{shard_data(0,true,j)[(i.to_i >> 22) % j]} Shards #{"(in a system of #{j} shards)" if j != Shards}."
    elsif j != Shards
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
    event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[0]} Shards." if j != Shards
    event.respond "This server uses #{shard_data(0,true,j)[0]} Shards." if j == Shards
    return nil
  elsif event.server.id==327237968047898624 && j<=4
    event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[2]} Shards." if j != Shards
    event.respond "This server uses #{shard_data(0,true,j)[2]} Shards." if j == Shards
    return nil
  elsif event.server.id==327237968047898624
    event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[1]} Shards." if j != Shards
    event.respond "This server uses #{shard_data(0,true,j)[1]} Shards." if j == Shards
    return nil
  elsif bot.profile.id==618979409059119113
    event.respond "This is a cloned version of Botan.  There are no shards."
    return nil
  end
  event.respond "This is the debug mode, which uses #{shard_data(0,false,j)[4]} Shards." if Shardizard==4
  event.respond "PMs always use #{shard_data(0,true,j)[0]} Shards." if event.server.nil? && Shardizard != 4
  event.respond "In a system of #{j} shards, this server would use #{shard_data(0,true,j)[(event.server.id >> 22) % j]} Shards." unless event.server.nil? || Shardizard==4 || j == Shards
  event.respond "This server uses #{shard_data(0,true,j)[(event.server.id >> 22) % j]} Shards." unless event.server.nil? || Shardizard==4 || j != Shards
end

bot.command([:safe,:spam,:safetospam,:safe2spam,:long,:longreplies]) do |event, f|
  return nil if overlap_prevent(event)
  f='' if f.nil?
  metadata_load()
  if event.server.nil?
    event.respond 'It is safe for me to send long replies here because this is my PMs with you.'
  elsif [443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529].include?(event.server.id)
    event.respond 'It is safe for me to send long replies here because this is one of my emoji servers.'
  elsif Shardizard==4
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
  elsif $spam_channels.include?(event.channel.id)
    if (is_mod?(event.user,event.server,event.channel,1) || event.user.id==141260274144509952) && ['off','no','false'].include?(f.downcase)
      metadata_load()
      $spam_channels.delete(event.channel.id)
      metadata_save()
      event.respond 'This channel is no longer marked as safe for me to send long replies to.'
    else
      event << 'This channel has been specifically designated for me to be safe to send long replies to.'
      event << 'If you wish to turn them off, ask a server mod to type `DL!spam off` in this channel.'
    end
  elsif (is_mod?(event.user,event.server,event.channel,1) || event.user.id==141260274144509952) && ['on','yes','true'].include?(f.downcase)
    metadata_load()
    $spam_channels.push(event.channel.id)
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

bot.command(:status) do |event, *args|
  return nil if overlap_prevent(event)
  t=Time.now
  timeshift=6
  t-=60*60*timeshift
  if event.user.id==167657750971547648 && !args.nil? && args.length>0 && args[0]=='set' # only work when used by the developer
    args.shift
    bot.game=args.join(' ')
    event.respond 'Status set.'
    return nil
  elsif !find_data_ex(:find_status,args.join(' '),event,true).nil?
    disp_status_data(bot,event,args)
    return nil
  end
  data_load('library')
  show_bot_status(event,bot)
  return nil
end

bot.command(:sortaliases, from: 167657750971547648) do |event, *args|
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648
  data_load()
  nicknames_load()
  $aliases.uniq!
  $aliases.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? ((a[2].downcase <=> b[2].downcase) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2].downcase <=> b[2].downcase)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
  open("#{$location}devkit/DLNames.txt", 'w') { |f|
    for i in 0...$aliases.length
      f.puts "#{$aliases[i].to_s}#{"\n" if i<$aliases.length-1}"
    end
  }
  event.respond 'The alias list has been sorted alphabetically'
end

bot.command([:tools,:links,:tool,:link,:resources,:resources]) do |event|
  return nil if overlap_prevent(event)
  data_load('library')
  show_tools(event,bot)
end

bot.command([:avatar,:avvie]) do |event, *args|
  return nil if overlap_prevent(event)
  t=Time.now
  timeshift=6
  t-=60*60*timeshift
  if event.user.id==167657750971547648 && !args.nil? && args.length>0 # only work when used by the developer
    bot.game=args.join(' ')
    event.respond 'Status set.'
    return nil
  end
  data_load('library')
  show_bot_status(event,bot)
  return nil
end

bot.command(:backupaliases, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  return nil unless event.user.id==167657750971547648 || event.channel.id==386658080257212417
  nicknames_load()
  nzz=nicknames_load(2)
  $aliases.uniq!
  $aliases.sort! {|a,b| (a[0] <=> b[0]) == 0 ? ((a[2] <=> b[2]) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2] <=> b[2])) : (a[0] <=> b[0])}
  nzzzzz=$aliases.map{|a| a}
  open("#{$location}devkit/DLNames2.txt", 'w') { |f|
    for i in 0...nzzzzz.length
      f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
    end
  }
  event.respond 'Alias list has been backed up.'
end

bot.command(:restorealiases, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  return nil unless [167657750971547648,bot.profile.id].include?(event.user.id) || event.channel.id==502288368777035777
  if File.exist?("#{$location}devkit/DLNames2.txt")
    b=[]
    File.open("#{$location}devkit/DLNames2.txt").each_line do |line|
      b.push(eval line)
    end
  else
    b=[]
  end
  nzzzzz=b.uniq
  nz=nzzzzz.reject{|q| q[0]!='Adventurer'}
  if nz[nz.length-1][2]<'Zethia'
    event << 'Last backup of the alias list has been corrupted.  Restoring from manually-created backup.'
    if File.exist?("#{$location}devkit/DLNames3.txt")
      b=[]
      File.open("#{$location}devkit/DLNames3.txt").each_line do |line|
        b.push(eval line)
      end
    else
      b=[]
    end
    nzzzzz=b.uniq
  else
    event << 'Last backup of the alias list being used.'
  end
  open("#{$location}devkit/DLNames.txt", 'w') { |f|
    for i in 0...nzzzzz.length
      f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
    end
  }
  event << 'Alias list has been restored from backup.'
end

bot.command(:sendmessage, from: 167657750971547648) do |event, channel_id, *args| # sends a message to a specific channel
  return nil if overlap_prevent(event)
  dev_message(bot,event,channel_id,[141260274144509952])
end

bot.command(:sendpm, from: 167657750971547648) do |event, user_id, *args| # sends a PM to a specific user
  return nil if overlap_prevent(event)
  dev_pm(bot,event,user_id,[141260274144509952])
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
  event.channel.send_temporary_message('Please wait...',10) rescue nil
  nicknames_load()
  nmz=$aliases.map{|q| q}
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
  open("#{$location}devkit/DLNames.txt", 'w') { |f|
    for i in 0...nmz.length
      f.puts "#{nmz[i].to_s}#{"\n" if i<nmz.length-1}"
    end
  }
  event << "#{k} aliases were removed due to being from servers I'm no longer in."
  event << "#{k2} aliases were removed due to being identical to the servant's name."
end

bot.command(:snagstats) do |event, f, f2|
  return nil if overlap_prevent(event)
  data_load('library')
  snagstats(event,bot,f,f2)
  return nil
end

bot.command(:reload, from: 167657750971547648) do |event|
  return nil if overlap_prevent(event)
  return nil unless [167657750971547648,141260274144509952].include?(event.user.id) || [502288368777035777,532083509083373583].include?(event.channel.id)
  event.respond "Reload what?\n1.) Aliases, from backups#{" (unless includes the word \"git\")\n2.) Groups, from GitHub\n3.) Data, from GitHub (include \"subset\" in your message to also reload DLSkillSubsets)" if [167657750971547648,141260274144509952].include?(event.user.id)}#{"\n4.) Source code, from GitHub (include the word \"all\" to also reload rot8er_functs.rb)\n5.) Crossover data\n6.) Libraries, from code\n7.) Avatars, from GitHub" if event.user.id==167657750971547648}\nYou can include multiple numbers to load multiple things."
  event.channel.await(:bob, from: event.user.id) do |e|
    reload=false
    if e.message.text.include?('1')                                                                    # Aliases
      if e.message.text.downcase.include?('git') && [167657750971547648,141260274144509952].include?(event.user.id)
        download = open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/DLNames.txt")
        IO.copy_stream(download, "DLTemp.txt")
        if File.size("DLTemp.txt")>100 && Shardizard<0
          b=[]
          File.open("DLTemp.txt").each_line.with_index do |line, idx|
            b.push(eval line)
          end
          nicknames_load(-1)
          b2=$aliases.reject{|q| !q[0].include?('*')}
          b=b.reject{|q| b2.map{|q2| [q2[0].gsub('*',''),q2[1],q2[2]]}.include?([q[0],q[1],q[2]])}
          for i in 0...b2.length
            b.push(b2[i])
          end
          b.sort! {|a,b| (spaceship_order(a[0]) <=> spaceship_order(b[0])) == 0 ? ((a[2].downcase <=> b[2].downcase) == 0 ? (a[1].downcase <=> b[1].downcase) : (a[2].downcase <=> b[2].downcase)) : (spaceship_order(a[0]) <=> spaceship_order(b[0]))}
          b=b.map{|q| "#{q.to_s}\n"}
          open("DLNames.txt", 'w') { |f|
            f.puts b.join('')
          }
          open("DLNames2.txt", 'w') { |f|
            f.puts b.join('')
          }
          e.respond 'Alias list has been restored from GitHub, and placed in the backup as well.'
        elsif File.size("DLTemp.txt")>100
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
          e.respond 'Alias list has been restored from GitHub, and placed in the backup as well.'
        else
          e.respond 'Alias list not loaded.  File too small.'
        end
        reload=true
      else
        if File.exist?("#{$location}devkit/DLNames2.txt")
          b=[]
          File.open("#{$location}devkit/DLNames2.txt").each_line do |line|
            b.push(eval line)
          end
        else
          b=[]
        end
        nzzzzz=b.uniq
        nz=nzzzzz.reject{|q| q[0]!='Adventurer'}
        if nz[nz.length-1][2]<'Zethia'
          e.respond 'Last backup of the alias list has been corrupted.  Restoring from manually-created backup.'
          if File.exist?("#{$location}devkit/DLNames3.txt")
            b=[]
            File.open("#{$location}devkit/DLNames3.txt").each_line do |line|
              b.push(eval line)
            end
          else
            b=[]
          end
          nzzzzz=b.uniq
        else
          e.respond 'Last backup of the alias list being used.'
        end
        open("#{$location}devkit/DLNames.txt", 'w') { |f|
          for i in 0...nzzzzz.length
            f.puts "#{nzzzzz[i].to_s}#{"\n" if i<nzzzzz.length-1}"
          end
        }
        e.respond 'Alias list has been restored from backup.'
        reload=true
      end
    end
    if e.message.text.include?('2') && [167657750971547648,141260274144509952].include?(event.user.id) # Groups
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
    if e.message.text.include?('3') && [167657750971547648,141260274144509952].include?(event.user.id) # Data
      event.channel.send_temporary_message('Loading.  Please wait 5 seconds...',3) rescue nil
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
    if e.message.text.include?('4') && [167657750971547648].include?(event.user.id)                    # Source Code
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
      download = open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/BotanClassFunctions.rb")
      IO.copy_stream(download, "DLTemp.txt")
      if File.size("DLTemp.txt")>100
        b=[]
        File.open("DLTemp.txt").each_line.with_index do |line, idx|
          b.push(line)
        end
        open("BotanClassFunctions.rb", 'w') { |f|
          f.puts b.join('')
        }
      end
      download = open("https://raw.githubusercontent.com/Rot8erConeX/BotanBot/master/BotanBot.rb")
      IO.copy_stream(download, "DLTemp.txt")
      if File.size("DLTemp.txt")>100
        if File.exist?("#{$location}devkit/BotTokens.txt")
          b2=[]
          File.open("#{$location}devkit/BotTokens.txt").each_line do |line|
            b2.push(line.split(' # ')[0])
          end
        else
          b2=[]
        end
        if b2.length>0
          b=[]
          File.open("DLTemp.txt").each_line.with_index do |line, idx|
            if idx<100
              b.push(line.gsub('>Token<',b2[3]).gsub('>Debug Token<',b2[-1]).gsub('>Smol Token<',b2[-3]).gsub('>Location<',$location))
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
    if e.message.text.include?('5') && [167657750971547648].include?(event.user.id)                    # Crossdata
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
    if e.message.text.include?('6') && [167657750971547648].include?(event.user.id)                    # Library
      puts 'reloading BotanClassFunction'
      load "#{$location}devkit/BotanClassFunctions.rb"
      t=Time.now
      $last_multi_reload[0]=t
      e.respond 'Libraries force-reloaded'
      reload=true
    end
    if e.message.text.include?('7') && [167657750971547648].include?(event.user.id)                    # Avatars
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
          IO.copy_stream(download, "DLTemp#{Shardizard}.png")
          if File.size("DLTemp#{Shardizard}.png")>100
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

bot.command(:update) do |event|
  return nil if overlap_prevent(event)
  data_load('library')
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
  if ![620710758841450529,285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(event.server.id) && Shardizard==4
    (chn.send_message(get_debug_leave_message()) rescue nil)
    event.server.leave
  else
    bot.user(167657750971547648).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned the #{shard_data(0)[(event.server.id >> 22) % Shards]} Shard")
    bot.user(141260274144509952).pm("Joined server **#{event.server.name}** (#{event.server.id})\nOwner: #{event.server.owner.distinct} (#{event.server.owner.id})\nAssigned the #{shard_data(0)[(event.server.id >> 22) % Shards]} Shard")
    metadata_load()
    @server_data[0][((event.server.id >> 22) % Shards)] += 1
    metadata_save()
    chn.send_message("Hello, my name is Botan.  You're the #{longFormattedNumber(@server_data[0].inject(0){|sum,x| sum + x },true)} halidom to ask for my help.  Folks around these parts call me the \"naginata cutie.\" ...Hey, don't you **dare** laugh at that, jerk!\nWant data on *Dragalia Lost*?  Use commands that start with the prefix `DL!`, and leave this to me!") rescue nil
  end
end

bot.server_delete do |event|
  unless Shardizard==4
    bot.user(167657750971547648).pm("Left server **#{event.server.name}**\nThis server was using #{shard_data(0,true)[((event.server.id >> 22) % Shards)]} Shards")
    bot.user(141260274144509952).pm("Left server **#{event.server.name}**\nThis server was using #{shard_data(0,true)[((event.server.id >> 22) % Shards)]} Shards")
    metadata_load()
    @server_data[0][((event.server.id >> 22) % Shards)] -= 1
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
  if Shardizard==4 && (['fea!','fef!','fea?','fef?'].include?(str[0,4]) || ['fe13!','fe14!','fe13?','fe14?'].include?(str[0,5]) || ['fe!','fe?'].include?(str[0,3])) && (event.server.nil? || event.server.id==285663217261477889)
    str=str[4,str.length-4] if ['fea!','fef!','fea?','fef?'].include?(str[0,4])
    str=str[5,str.length-5] if ['fe13!','fe14!','fe13?','fe14?'].include?(str[0,5])
    str=str[3,str.length-3] if ['fe!','fe?'].include?(str[0,3])
    a=str.split(' ')
    if a[0].downcase=='reboot'
      event.respond 'Becoming Robin.  Please wait approximately ten seconds...'
      exec "cd #{$location}devkit && RobinBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond 'I am not Robin right now.  Please use `FE!reboot` to turn me into Robin.'
    end
  elsif (['feh!','feh?'].include?(str[0,4]) || ['f?','e?','h?'].include?(str[0,2])) && Shardizard==4 && (event.server.nil? || event.server.id==285663217261477889)
    s=event.message.text.downcase
    s=s[2,s.length-2] if ['f?','e?','h?'].include?(event.message.text.downcase[0,2])
    s=s[4,s.length-4] if ['feh!','feh?'].include?(event.message.text.downcase[0,4])
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming Elise.  Please wait approximately ten seconds..."
      exec "cd #{$location}devkit && PriscillaBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond "I am not Elise right now.  Please use `FEH!reboot` to turn me into Elise."
    end
  elsif (['fgo!','fgo?','liz!','liz?'].include?(str[0,4]) || ['fate!','fate?'].include?(str[0,5])) && Shardizard==4 && (event.server.nil? || event.server.id==285663217261477889)
    s=event.message.text.downcase
    s=s[5,s.length-5] if ['fate!','fate?'].include?(event.message.text.downcase[0,5])
    s=s[4,s.length-4] if ['fgo!','fgo?','liz!','liz?'].include?(event.message.text.downcase[0,4])
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming Liz.  Please wait approximately ten seconds..."
      exec "cd #{$location}devkit && LizBot.rb 4"
    elsif event.server.nil? || event.server.id==285663217261477889
      event.respond "I am not Liz right now.  Please use `FGO!reboot` to turn me into Liz."
    end
  elsif (['!weak '].include?(str[0,6]) || ['!weakness '].include?(str[0,10]))
    if event.server.nil? || event.server.id==264445053596991498
    elsif !bot.user(304652483299377182).on(event.server.id).nil? # Robin
    elsif !bot.user(206147275775279104).on(event.server.id).nil? || Shardizard==4 || event.server.id==330850148261298176 # Pokedex
      triple_weakness(bot,event)
    end
  elsif overlap_prevent(event,false)
  elsif m && !all_commands().include?(s.split(' ')[0])
    if event.message.text.downcase.gsub(' ','').gsub("'",'').include?("werenostrangerstolove") && Shardizard>=0
      event.respond "You know the rules and so do I"
    else
      find_best_match(s,bot,event)
    end
  elsif !event.server.nil? && (above_memes().include?("s#{event.server.id}") || above_memes().include?(event.server.id))
  elsif !event.channel.nil? && above_memes().include?("c#{event.channel.id}")
  elsif above_memes().include?("u#{event.user.id}") || above_memes().include?(event.user.id)
  elsif event.message.text.downcase.gsub('?','').split(' ').include?('who') && event.message.text.downcase.gsub('?','').split(' ').include?('luca') && !event.user.bot_account? && Shardizard>=0
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
  elsif event.message.text.downcase.split(' ').include?('luca') && !event.user.bot_account? && Shardizard>=0
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
  elsif event.message.text.include?('0x4') && !event.user.bot_account? && Shardizard==4
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
  data_load(['everything'])
  if !m || args.nil? || args.length<=0
  elsif ['help','commands','command_list','commandlist'].include?(args[0].downcase)
    args.shift
    help_text(event,bot,args[0],args[1])
    m=false
  elsif ['adventurer','adv'].include?(args[0].downcase)
    m=false
    args.shift
    if ['level','xp','exp'].include?(args[0].downcase)
      args.shift
      level(event,bot,args,2)
    elsif ['art'].include?(args[0].downcase)
      args[0]='adventurer'
      disp_art(bot,event,args)
    elsif ['alt','alts'].include?(args[0].downcase)
      args[0]='adventurer'
      disp_art(bot,event,args)
    elsif ['mats','mat','materials','material','node','nodes'].include?(args[0].downcase)
      args[0]='adventurer'
      upgrade_mats(event,args,bot)
    elsif ['find','search','lookup'].include?(args[0].downcase)
      args.shift
      display_adventurers(bot,event,args)
    elsif ['sort','list'].include?(args[0].downcase)
      args.shift
      sort_adventurers(bot,event,args)
    else
      disp_adventurer_stats(bot,event,args)
    end
  elsif ['dragon','drg','drag'].include?(args[0].downcase)
    m=false
    args.shift
    if ['level','xp','exp'].include?(args[0].downcase)
      args.shift
      level(event,bot,args,3)
    elsif ['art'].include?(args[0].downcase)
      args[0]='dragon'
      disp_art(bot,event,args)
    elsif ['alt','alts'].include?(args[0].downcase)
      args[0]='dragon'
      disp_art(bot,event,args)
    elsif ['find','search','lookup'].include?(args[0].downcase)
      args.shift
      display_dragons(bot,event,args)
    elsif ['sort','list'].include?(args[0].downcase)
      args.shift
      sort_dragons(bot,event,args)
    else
      disp_dragon_stats(bot,event,args)
    end
  elsif ['wyrmprint','wyrm','print'].include?(args[0].downcase)
    m=false
    args.shift
    if ['level','xp','exp'].include?(args[0].downcase)
      args.shift
      level(event,bot,args,5)
    elsif ['art'].include?(args[0].downcase)
      args[0]='print'
      disp_art(bot,event,args)
    elsif ['shop','store'].include?(args[0].downcase)
      reload_library()
      show_print_shop(event)
    elsif ['find','search','lookup'].include?(args[0].downcase)
      args.shift
      display_wyrmprints(bot,event,args)
    elsif ['sort','list'].include?(args[0].downcase)
      args.shift
      sort_wyrmprints(bot,event,args)
    else
      disp_wyrmprint_stats(bot,event,args)
    end
  elsif ['weapon','weap','wep','wpn'].include?(args[0].downcase)
    m=false
    args.shift
    if ['lineage','craft','crafting'].include?(args[0].downcase)
      args.shift
      disp_weapon_lineage(bot,event,args)
    elsif ['level','xp','exp'].include?(args[0].downcase)
      args.shift
      level(event,bot,args,6)
    elsif ['mats','mat','materials','material','node','nodes'].include?(args[0].downcase)
      args[0]='weapon'
      upgrade_mats(event,args,bot)
    elsif ['find','search','lookup'].include?(args[0].downcase)
      args.shift
      display_weapons(bot,event,args)
    elsif ['sort','list'].include?(args[0].downcase)
      args.shift
      sort_weapons(bot,event,args)
    else
      disp_weapon_stats(bot,event,args)
    end
  elsif ['enemy','boss'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search','lookup'].include?(args[0].downcase)
      args.shift
      display_enemies(bot,event,args)
    else
      disp_enemy_data(bot,event,args)
    end
  elsif ['skill','skil'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search','lookup'].include?(args[0].downcase)
      args.shift
      display_skills(bot,event,args)
    else
      disp_skill_data(bot,event,args)
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
  elsif ['facility','faculty','fac'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search','lookup'].include?(args[0].downcase)
      args.shift
      display_facilities(bot,event,args)
    else
      disp_facility_data(bot,event,args)
    end
  elsif ['mat','material','item'].include?(args[0].downcase)
    m=false
    args.shift
    if ['adv','adventurer'].include?(args[0].downcase)
      upgrade_mats(event,args,bot)
    elsif ['find','search','lookup'].include?(args[0].downcase)
      args.shift
      display_mats(bot,event,args)
    else
      disp_mat_data(bot,event,args)
    end
  elsif ['status'].include?(args[0].downcase)
    m=false
    args.shift
    disp_status_data(bot,event,args)
  elsif ['lineage','craft','crafting'].include?(args[0].downcase)
    m=false
    args.shift
    disp_weapon_lineage(bot,event,args)
  elsif ['alts','alt'].include?(args[0].downcase)
    m=false
    args.shift
    disp_alts(bot,event,args)
  elsif ['art'].include?(args[0].downcase)
    m=false
    args.shift
    disp_art(bot,event,args)
  elsif ['banner','banners'].include?(args[0].downcase)
    m=false
    args.shift
    if ['find','search','lookup'].include?(args[0].downcase)
      args.shift
      display_banners(bot,event,args)
    else
      disp_banner(bot,event,args)
    end
  elsif ['affinity','resonance'].include?(args[0].downcase)
    m=false
    affinity_resonance(event,bot)
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
  elsif ['find','search','lookup'].include?(args[0].downcase)
    m=false
    args.shift
    display_search_results(bot,event,args)
  elsif ['sort','list'].include?(args[0].downcase)
    m=false
    args.shift
    sort_things(bot,event,args)
  elsif ['groups','seegroups','checkgroups'].include?(args[0].downcase)
    m=false
    disp_groups(event)
  elsif ['limit','limits','stack','stacks'].include?(args[0].downcase)
    m=false
    show_abil_limits(event,bot)
  elsif ['xp','exp','level'].include?(args[0].downcase)
    m=false
    args.shift
    level(event,bot,args)
  elsif ['pxp','pexp','plxp','plexp','plevel','pllevel','axp','aexp','advxp','advexp','alevel','advlevel','dxp','dexp','drgxp','drgexp','dlevel','drglevel','bond','dragonbond','bxp','bexp','dbxp','dbexp','bondxp','bondexp','blevel','dblevel','bondlevel','wrxp','wrexp','wrlevel','wyrmxp','wyrmexp','wyrmlevel','wpxp','wpexp','wplevel','weaponxp','weaponexp','weaponlevel','wxp','wexp','wlevel'].include?(args[0].downcase)
    m=false
    level(event,bot,args)
  elsif ['next','schedule'].include?(args[0].downcase)
    args.shift
    next_events(event,bot,args)
    m=false
  elsif ['roost'].include?(args[0].downcase)
    args.shift
    today_in_dl(event,bot,args,false,1)
    m=false
  elsif ['ruin','ruins'].include?(args[0].downcase)
    args.shift
    today_in_dl(event,bot,args,false,2)
    m=false
  elsif ['shop','store'].include?(args[0].downcase)
    args.shift
    if ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
      show_print_shop(event)
    else
      today_in_dl(event,bot,args,false,3)
    end
    m=false
  elsif ['reset'].include?(args[0].downcase)
    args.shift
    today_in_dl(event,bot,args,false,4)
    m=false
  elsif ['daily','dailies'].include?(args[0].downcase)
    args.shift
    today_in_dl(event,bot,args)
    m=false
  elsif ['today','now','tomorrow','tommorrow','tomorow','tommorow','sunday','sundae','sun','sonday','sondae','son','monday','mondae','mon','monday','mondae','tuesday','tuesdae','tues','tue','wednesday','wednesdae','wednes','wed','thursday','thursdae','thurs','thu','thur','friday','fridae','fri','fryday','frydae','fry','saturday','saturdae','sat','saturnday','saturndae','saturn','satur'].include?(args[0].downcase)
    today_in_dl(event,bot,args)
    m=false
  elsif ['team','backpack'].include?(args[0].downcase)
    args.shift
    adv_chain_list(event,args,bot)
    m=false
  elsif ['prints','weapprints','wepprints','weaponprints','wpnprints','weaprints','weprints','weapprint','wepprint','weaponprint','wpnprint','weaprint','weprint'].include?(args[0].downcase)
    args.shift
    print_overlap_list(event,args,bot)
    m=false
  elsif ['synergy','synergize'].include?(args[0].downcase)
    args.shift
    if ['adventurer','adventurers','adv','advs','unit','units'].include?(args[0].downcase)
      args.shift
      adv_chain_list(event,args,bot)
    elsif ['wyrmprint','wyrm','print','wyrmprints','wyrms','prints'].include?(args[0].downcase)
      args.shift
      print_overlap_list(event,args,bot)
    end
    event.respond "What are you synergizing?  *Adventurers* on a team, or *wyrmprints* on a weapon?"
    m=false
  elsif ['sp'].include?(args[0].downcase)
    args.shift
    disp_sp_table(bot,event,args)
    m=false
  elsif ['dmg','damage'].include?(args[0].downcase)
    args.shift
    disp_damage_modifiers(bot,event,args)
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
  unless Shardizard<=0
  d=get_donor_list().reject{|q| q[2][2]<3 || q[4][2]=='-'}
    for i in 0...d.length
      if d[i][4][2]!='-' && d[i][0]!=141260274144509952
        holidays.push([0,d[i][3][0],d[i][3][1],d[i][4][2],"in recognition of contributions provided by #{bot.user(d[i][0]).distinct}","Donator's birthday"])
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
    bot.profile.avatar=(File.open("#{$location}devkit/BotanBot.png",'r')) rescue nil if Shardizard.zero?
    $avvie_info=['Botan','*Dragalia Lost*','']
    t+=24*60*60
    @scheduler.at "#{t.year}/#{t.month}/#{t.day} 0000" do
      next_holiday(bot,1)
    end
  elsif t.year==k[0][0] && t.month==k[0][1] && t.day==k[0][2]
    if k.length==1
      # Only one holiday is today.  Display new avatar, and set another check for midnight
      bot.game=k[0][4]
      if Shardizard.zero?
        bot.profile.avatar=(File.open("#{$location}devkit/EliseImages/#{k[0][3]}.png",'r')) rescue nil
      end
      $avvie_info=[k[0][3],k[0][4],k[0][5]]
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
        if Shardizard.zero?
          bot.profile.avatar=(File.open("#{$location}devkit/EliseImages/#{k[k.length-1][3]}.png",'r')) rescue nil
        end
        $avvie_info=[k[k.length-1][3],k[k.length-1][4],k[k.length-1][5]]
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
        if Shardizard.zero?
          bot.profile.avatar=(File.open("#{$location}devkit/EliseImages/#{k[j][3]}.png",'r')) rescue nil
        end
        $avvie_info=[k[j][3],k[j][4],k[j][5]]
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
    bot.profile.avatar=(File.open("#{$location}devkit/BotanBot.png",'r')) rescue nil if Shardizard.zero?
    $avvie_info=['Botan','*Dragalia Lost*','']
    t+=24*60*60
    @scheduler.at "#{t.year}/#{t.month}/#{t.day} 0000" do
      next_holiday(bot,1)
    end
  end
end

bot.ready do |event|
  if Shardizard==4
    for i in 0...bot.servers.values.length
      if ![620710758841450529,285663217261477889,443172595580534784,443181099494146068,443704357335203840,449988713330769920,497429938471829504,554231720698707979,523821178670940170,523830882453422120,691616574393811004,523824424437415946,523825319916994564,523822789308841985,532083509083373579,575426885048336388,620710758841450529,572792502159933440].include?(bot.servers.values[i].id)
        bot.servers.values[i].general_channel.send_message(get_debug_leave_message()) rescue nil
        bot.servers.values[i].leave
      end
    end
  end
  system("color 3#{shard_data(3)[Shardizard,1]}")
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
  $last_multi_reload[0]=Time.now
  $last_multi_reload[1]=Time.now
  puts 'reloading BotanClassFunctions'
  load "#{$location}devkit/BotanClassFunctions.rb"
  system("color 1#{shard_data(3)[Shardizard,1]}")
  system("title #{shard_data(2)[Shardizard]} BotanBot")
  system("title Smol BotanBot") if Shardizard<0
  bot.game='Dragalia Lost (DL!help for info)'
  if bot.profile.id==618979409059119113
  elsif Shardizard==4
    next_holiday(bot)
    bot.user(bot.profile.id).on(285663217261477889).nickname='BotanBot (Debug) - Mana Unbound' if Shardizard==4
    bot.profile.avatar=(File.open("#{$location}devkit/DebugBotan.png",'r')) if Shardizard==4
  else
    next_holiday(bot)
  end
  if Shardizard==4
    if File.exist?("#{$location}devkit/DebugSav.txt")
      b=[]
      File.open("#{$location}devkit/DebugSav.txt").each_line do |line|
        b.push(eval line)
      end
    else
      b=[]
    end
    bot.channel(285663217261477889).send_message("Hello!") if b[0]!='Botan'
    open("#{$location}devkit/DebugSav.txt", 'w') { |f|
      f.puts '"Botan"'
    }
  end
end

bot.run
