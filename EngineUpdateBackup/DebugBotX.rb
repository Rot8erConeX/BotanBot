Shardizard = ARGV.first.to_i # taking a single variable from the command prompt to get the shard value
system('color 0F')
Shards = 6                   # total number of shards

require 'discordrb'                    # Download link: https://github.com/meew0/discordrb
require 'open-uri'                     # pre-installed with Ruby in Windows
require 'net/http'                     # pre-installed with Ruby in Windows
require 'certified'
require 'tzinfo/data'                  # Downloaded with active_support below, but the require must be above active_support's require
require 'rufus-scheduler'              # Download link: https://github.com/jmettraux/rufus-scheduler
require 'active_support/core_ext/time' # Download link: https://rubygems.org/gems/activesupport/versions/5.0.0
require_relative 'rot8er_functs'       # functions I use commonly in bots
$location="C:/Users/#{@mash}/Desktop/"

load "#{$location}devkit/BotanClassFunctions.rb"

# this is required to get her to change her avatar on certain holidays
ENV['TZ'] = 'America/Chicago'
@scheduler = Rufus::Scheduler.new

# All the possible command prefixes
@prefixes={}

prefix_proc = proc do |message|
  next pseudocase(message.text[2..-1]) if message.text.downcase.start_with?('d!')
  next pseudocase(message.text[2..-1]) if message.text.downcase.start_with?('d?')
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
$facilities=[]
$mats=[]
$banners=[]
$statuses=[]

$emotes=[]
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

@embedless=[]
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

class DLAdventurer
  attr_accessor :name
  attr_accessor :rarity,:availability
  attr_accessor :clzz,:element,:weapon,:weapon2
  attr_accessor :hp,:str,:defense,:skill_points
  attr_accessor :skills,:coability,:chain,:abilities
  attr_accessor :hidden_abilities,:abiltags
  attr_accessor :voice_na,:voice_jp
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
  
  def name=(val); @name=val; end
  
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
  
  def voice_na=(val); @voice_na=val; end
  def voice_jp=(val); @voice_jp=val; end
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
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
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
        for i2 in 0...lv[i]+1
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
  
  
end

class DLDragon
  attr_accessor :name
  attr_accessor :rarity,:availability
  attr_accessor :element
  attr_accessor :hp,:str,:speed
  attr_accessor :skills,:auras
  attr_accessor :hidden_abilities
  attr_accessor :sell_price
  attr_accessor :favorite
  attr_accessor :dmg_turn,:longrange
  attr_accessor :voice_na,:voice_jp
  attr_accessor :alts
  attr_accessor :gender,:games,:cygame
  attr_accessor :footer,:essence
  attr_accessor :damage_override
  attr_accessor :pseudodragon
  attr_accessor :sort_data,:thumbforce
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
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
  def auras=(val); @auras=val.split(';;;; ').map{|q| q.split(';; ')} unless val=='-'; end
  def hidden_abilities=(val); @hidden_abilities=nil; @hidden_abilities=val.split(';;;; ').map{|q| q.split(';; ')} unless val=='-'; end
  
  def sell_price=(val); @sell_price=val.split(', ').map{|q| q.to_i}; end
  def favorite=(val); @favorite=val.to_i; end
  def dmg_turn=(val); @dmg_turn=false; @dmg_turn=true if val=='Yes'; end
  def longrange=(val); @longrange=false; @longrange=true if val=='Yes'; end
  def essence=(val); @essence=false; @essence=true if val=='Y'; end
  def pseudodragon=(val); @pseudodragon=nil; @pseudodragon=val unless ['','-',' ',false,nil].include?(val); end
  
  def voice_na=(val); @voice_na=val; end
  def voice_jp=(val); @voice_jp=val; end
  def gender=(val); @gender=val; end
  def games=(val); @games=[]; @games=val.split(', ') unless val.nil?; end
  def alts=(val); @alts=val.split(', '); end
  def cygame=(val); @cygame=val; end
  
  def footer=(val); @footer=val; end
  def sp_override=(val); @sp_override=val.split(';; ').map{|q| q.split('; ')} end
  def damage_override=(val); @damage_override=val.split(';; ').map{|q| q.split('; ')} end
  
  def sort_data=(val); @sort_data=val; end
  def objt; return 'Dragon'; end
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
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
    if includerarity
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
    if @affinity.nil?
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
    str="#{str}\n#{emo}**#{@amulet}**"
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
    xcolor=0x313439
    xcolor=0x5A0408 if @amulet=='Attack'
    xcolor=0x00205A if @amulet=='Defense'
    xcolor=0x39045A if @amulet=='Support'
    xcolor=0x005918 if @amulet=='Healing'
    f.push(xcolor) unless xcolor.nil?
    return f[0] if chain>=f.length
    return f[chain]
  end
  
  def thumbnail(mub=0)
    dispname=@name.gsub(' ','_')
    mub=0 if mub<=0
    mub=1 if mub>=1
    return "https://github.com/Rot8erConeX/BotanBot/blob/master/Wyrmprints/#{dispname}_#{mub+1}.png?raw=true"
  end
  
  def mini_header(bot)
    c=self.class_header(bot,2)
    if @affinity.nil?
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
    return str
  end
  
  def stat_grid(bot,fullsize=true)
    c=self.stat_emotes.map{|q| q}
    l=[1,@rarity*10-10,@rarity*10]
    l=[1,@rarity*10-24,@rarity*10-10] if @rarity<4
    l[2]=5 if @rarity==1
    l[1]=l[2]-2 if @rarity<3
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
  attr_accessor :craft_mats,:unbind_mats,:slot_mats,:copy_mats,:ability_mats,:bonus_mats,:refinement_mats,:post_refine_unbind_mats
  attr_accessor :boss_tags
  attr_accessor :print_slots
  attr_accessor :obtain
  attr_accessor :games
  
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
        str=''
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
  
  
end

# secondary entities

class DLSkill
  attr_accessor :name
  attr_accessor :description
  attr_accessor :mass_description
  attr_accessor :sp_cost,:sp_oddity
  attr_accessor :sharing
  attr_accessor :energize
  attr_accessor :invulnerability
  attr_accessor :tags
  
  def initialize(val)
    @name=val
  end
  
  def name=(val); @name=val; end
  def description=(val); @description=val; end
  def mass_description=(val); @mass_description=val; end
  def sharing=(val); @sharing=val.split(', ').map{|q| q.to_i}; end
  def energize=(val); @energize=false; @energize=true if val=='Yes'; end
  def invulnerability=(val); @invulnerability=val.to_f; end
  def tags=(val); @tags=val.split(', '); end
  def objt; return 'Skill'; end
  
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
  
  def fullName(format=nil)
    return @name if format.nil?
    return "#{format}#{@name}#{format.reverse}"
  end
  
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
    return e
  end
  
  def sp_display(level=0)
    return [self.sp_display(1),self.sp_display(2),self.sp_display(3),self.sp_display(4),self.sp_display(5)] if level==0
    return '' if level<0 && (@sharing.nil? || @sharing.length<=0)
    level=-1 if level<0
    x=@sp_cost[level-1]*1
    x=@sharing[1]*1 if level<0
    m=[x*1]
    unless @sp_oddity.nil? || @sp_oddity.length<=0 || (@sp_oddity.map{|q| q[level]}.uniq.length<=1 && @sp_oddity[0][level]==x)
      for i in 0...@sp_oddity.length
        m.push(@sp_oddity[i][level]*1)
      end
    end
    return m.map{|q| longFormattedNumber(q)}.join("\u2192")
  end
  
  def share_text
    return '' if @sharing.nil? || @sharing.length<=0
    return "#{@sharing[0]}<:SkillShare:714597012733034547> / #{self.sp_display(-1)} SP when shared"
  end
  
  def level_text(l,f,long=false)
    return "Lv.#{l}" if long && f<0
    return "Lv.#{l}/Floor #{f}" if long
    str="Lv.#{l}"
    m=[]
    m.push("F#{f}") if f>=0
    m.push("#{self.sp_display(l)} SP") if self.sp_display(0).uniq.length>1
    str="#{str} (#{m.join(', ')})" if m.length>0
    return str
  end
end

class DLAbility
  attr_accessor :name,:level
  attr_accessor :type
  attr_accessor :description
  attr_accessor :weight,:show
  attr_accessor :tags
  
  def initialize(val,val2)
    @name=val
    @level=val2
  end
  
  def name=(val); @name=val; end
  def level=(val); @level=val; end
  def description=(val); @description=val; end
  def weight=(val); @weight=val.to_i; end
  def show=(val); @show=false; @show=true if ['y','yes'].include?(val.downcase); end
  def tags=(val); @tags=[]; @tags=val.split(', ') unless val.nil? || val.length<=0 || val=='-'; end
  def objy; return 'Ability'; end
  
  def fullName(format=nil,justlast=false,sklz=nil)
    x="#{@name}"
    x="#{format}#{x}#{format.reverse}" unless format.nil?
    return x if ['-'].include?(@level) || @level.nil?
    return x if ['example'].include?(@level) && format.nil? && !justlast
    x="#{x} " unless @name[-1]=='+'
    return "#{x}#{@level}" unless @level=='example'
    skz=$abilities.reject{|q| q.name != @name || q.type != @type || q.level=='example'}
    skz=sklz.reject{|q| q.name != @name || q.type != @type || q.level=='example'} unless sklz.nil?
    return "#{x}" if justlast && skz.length<=0
    return "#{x}#{skz[-1].level}" if justlast
    return "#{x}#{skz.map{|q| q.level}.join('/')}"
  end
  
  
end

class DLStatus
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
  
  def voice=(val)
    @voice_na=val[0].split(' & ') unless val[0].nil? || val[0].length<=0
    @voice_jp=val[1].split(' & ') unless val[1].nil? || val[1].length<=0
  end
end

class FGOServant
  attr_accessor :id
  attr_accessor :name
  attr_accessor :artist
  attr_accessor :voice_jp
  
  def initialize(val)
    @id=val
  end
  
  def name=(val); @name=val; end
  def artist=(val); @artist=val; end
  def voice_jp=(val); @voice_jp=val; end
  
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
end

def data_load(to_reload=[])
  to_reload=[to_reload] if to_reload.is_a?(String)
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
      bob4.games=b[i][12] unless b[i][11].nil? || b[i][11].length<=0
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
        $abilities.push(bob4)
      end
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
    t=Time.now
    if t-$last_multi_reload[0]>5*60 || (Shardizard==4 && t-$last_multi_reload[0]>60)
      puts 'reloading BotanClasses'
      load "#{$location}devkit/BotanClassFunctions.rb"
      $last_multi_reload[0]=t
    end
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
  @embedless=b[0]
  @embedless=[168592191189417984, 256379815601373184] if @embedless.nil?
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
  x=[@embedless.map{|q| q}, @ignored.map{|q| q}, @server_data.map{|q| q}, $spam_channels.map{|q| q}]
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
    File.open("#{$location}devkit/DLNames.txt").each_line do |line|
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
  $aliases=b.reject{|q| q.nil? || q[1].nil?}.uniq
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
     'stat','smol','dragon','drg','drag','wyrmprint','wyrm','print','weapon','wep','weap','wpn','lineage','craft','crafting','enemy','boss','affinity','resonance']
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
  exec "cd #{$location}devkit && DebugBotX.rb #{Shardizard}"
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

def generate_rarity_row(rar,blanks=0,feh='')
  blanks=rar*1 if blanks<=0
  disprar=rar*1
  disprar=blanks*1 if rar<=0
  return "#{FGO_rarity_stars[rar]*([disprar,blanks].min)}#{'<:FGO_rarity_inverted:544568437029208094>'*(blanks-disprar) if blanks>disprar}" if feh=='FGO'
  return "#{FEH_rarity_stars[rar]*([disprar,blanks].min)}#{'<:Icon_Rarity_Empty:631460895851282433>'*(blanks-disprar) if blanks>disprar}" if feh=='FEH'
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
    return method(functions[i3][mode]).call(bot,event,name.split(' '),ext2) if !functions[i3][mode].nil? && !k.nil?
  end
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      for i3 in 0...functions.length
        k=method(functions[i3][0]).call(args[i,args.length-i-i2].join(' '),event,true,ext)
        return method(functions[i3][mode]).call(bot,event,args,ext2) if !functions[i3][mode].nil? && !k.nil? && args[i,args.length-i-i2].length>0
      end
    end
  end
  event.respond 'No matches found.' if (fullname || name.length<=2) && mode>1
  return nil if fullname || name.length<=2
  for i3 in 0...functions.length
    k=method(functions[i3][0]).call(name,event,false,ext)
    return method(functions[i3][mode]).call(bot,event,name.split(' '),ext2) if !functions[i3][mode].nil? && !k.nil?
  end
  args=name.split(' ')
  for i in 0...args.length
    for i2 in 0...args.length-i
      k=method(functions[i3][0]).call(args[i,args.length-i-i2].join(' '),event,false,ext)
      return method(functions[i3][mode]).call(bot,event,args,ext2) if !functions[i3][mode].nil? && !k.nil? && args[i,args.length-i-i2].length>0
    end
  end
  event.respond 'No matches found.' if mode>1
  return nil
end

def find_adventurer(xname,event,fullname=false,skipnpcs=false)
  data_load(['adventurer','npc'])
  xname=normalize(xname)
  xname=xname.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  adv=$adventurers.map{|q| q}
  return nil if xname.length<2
 # return [] if (find_npc(xname,event,true).length>0 || xname.downcase=='mym') && skipnpcs
  k=adv.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
  return adv[k] unless k.nil?
  nicknames_load()
 # alz=$aliases.reject{|q| q[0]!='Adventurer' && !(q[0]=='NPC' && @npcs.find_index{|q2| q2[0]==q[2]}.nil?)}.map{|q| [q[1],q[2],q[3]]}
  alz=$aliases.reject{|q| q[0]!='Adventurer'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return adv[adv.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return adv[adv.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  return nil if fullname || xname.length<=2
 # return nil if find_npc(xname,event).length>0 && skipnpcs
  k=adv.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
  return adv[k] unless k.nil?
  k=alz.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  return adv[adv.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  return adv[adv.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  return nil
end

def find_dragon(xname,event,fullname=false,ext=false)
  data_load(['dragon'])
  xname=normalize(xname)
  xname=xname.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return nil if xname.length<2
  k=$dragons.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
  return $dragons[k] unless k.nil?
  nicknames_load()
  alz=$aliases.reject{|q| q[0]!='Dragon'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return $dragons[$dragons.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return $dragons[$dragons.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  return nil if fullname || xname.length<=2
  k=$dragons.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
  return $dragons[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  return $dragons[$dragons.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  return $dragons[$dragons.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  return nil
end

def find_wyrmprint(xname,event,fullname=false,ext=false)
  data_load(['print'])
  xname=normalize(xname)
  xname=xname.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return nil if xname.length<2
  k=$wyrmprints.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
  return $wyrmprints[k] unless k.nil?
  nicknames_load()
  alz=$aliases.reject{|q| q[0]!='Wyrmprint'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return $wyrmprints[$wyrmprints.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return $wyrmprints[$wyrmprints.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  return nil if fullname || xname.length<=2
  k=$wyrmprints.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
  return $wyrmprints[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  return $wyrmprints[$wyrmprints.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  return $wyrmprints[$wyrmprints.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  return nil
end

def find_weapon(xname,event,fullname=false,ext=false)
  data_load()
  xname=normalize(xname)
  xname=xname.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return nil if xname.length<2
  k=$weapons.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname}
  return $weapons[k] unless k.nil?
  lists=$skilltags.reject{|q| q[2]!='Availability/Weapon'}.map{|q| [q[3],q[1]]}.uniq
  lists.unshift(['$',['Paid']])
  lists.unshift(['s',['Seasonal']])
  unless ext
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.rarity}*#{q.element}#{q.type}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.rarity}#{q.element}#{q.type}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.rarity}*#{q.type}#{q.element}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.rarity}#{q.type}#{q.element}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.element}#{q.rarity}*#{q.type}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.element}#{q.rarity}#{q.type}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.type}#{q.rarity}*#{q.element}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.type}#{q.rarity}#{q.element}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.element}#{q.type}#{q.rarity}*".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.element}#{q.type}#{q.rarity}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.type}#{q.element}#{q.rarity}*".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    k=$weapons.find_index{|q| !has_any?(lists.map{|q2| q2[0]},q.availability) && q.element !='None' && "#{q.type}#{q.element}#{q.rarity}".downcase==xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand') && q.games.length<=0}
    return $weapons[k] unless k.nil?
    for i2 in 2...lists.length
      for i3 in 0...lists[i2][1].length
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.rarity}*#{q.element}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.rarity}#{q.element}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.rarity}*#{q.type}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.rarity}#{q.type}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.element}#{q.rarity}*#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.element}#{q.rarity}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.type}#{q.rarity}*#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.type}#{q.rarity}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.element}#{q.type}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.element}#{q.type}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.type}#{q.element}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{lists[i2][1][i3]}#{q.type}#{q.element}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}*#{lists[i2][1][i3]}#{q.element}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}#{lists[i2][1][i3]}#{q.element}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}*#{lists[i2][1][i3]}#{q.type}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}#{lists[i2][1][i3]}#{q.type}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{lists[i2][1][i3]}#{q.rarity}*#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{lists[i2][1][i3]}#{q.rarity}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{lists[i2][1][i3]}#{q.rarity}*#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{lists[i2][1][i3]}#{q.rarity}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{lists[i2][1][i3]}#{q.type}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{lists[i2][1][i3]}#{q.type}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{lists[i2][1][i3]}#{q.element}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{lists[i2][1][i3]}#{q.element}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}*#{q.element}#{lists[i2][1][i3]}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}#{q.element}#{lists[i2][1][i3]}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}*#{q.type}#{lists[i2][1][i3]}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}#{q.type}#{lists[i2][1][i3]}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{q.rarity}*#{lists[i2][1][i3]}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{q.rarity}#{lists[i2][1][i3]}#{q.type}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{q.rarity}*#{lists[i2][1][i3]}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{q.rarity}#{lists[i2][1][i3]}#{q.element}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{q.type}#{lists[i2][1][i3]}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{q.type}#{lists[i2][1][i3]}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{q.element}#{lists[i2][1][i3]}#{q.rarity}*".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{q.element}#{lists[i2][1][i3]}#{q.rarity}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}*#{q.element}#{q.type}#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}#{q.element}#{q.type}#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}*#{q.type}#{q.element}#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.rarity}#{q.type}#{q.element}#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{q.rarity}*#{q.type}#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{q.rarity}#{q.type}#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{q.rarity}*#{q.element}#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{q.rarity}#{q.element}#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{q.type}#{q.rarity}*#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.element}#{q.type}#{q.rarity}#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{q.element}#{q.rarity}*#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
        k=$weapons.reject{|q| !q.availability.include?(lists[i2][0]) || q.element=='None' || "#{q.type}#{q.element}#{q.rarity}#{lists[i2][1][i3]}".downcase != xname.gsub('fire','flame').gsub('dark','shadow').gsub('spear','lance').gsub('katana','blade').gsub('rod','wand')}
        return k if k.length>0
      end
    end
  end
  nicknames_load()
  alz=$aliases.reject{|q| q[0]!='Weapon'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return $weapons[$weapons.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xname && (q[2].nil? || q[2].include?(g))}
  return $weapons[$weapons.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  return nil if fullname || xname.length<=2
  k=$weapons.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname}
  return $weapons[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  return $weapons[$weapons.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xname.length]==xname && (q[2].nil? || q[2].include?(g))}
  return $weapons[$weapons.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  return nil
end

def find_enemy(xnam,event,fullname=false,ext=false)
  data_load()
  xnam=normalize(xnam)
  xnam=xnam.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')
  return nil if xnam.length<2
  k=$enemies.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xnam}
  return $enemies[k] unless k.nil?
  nicknames_load()
  alz=$aliases.reject{|q| q[0]!='Enemy'}.map{|q| [q[1],q[2],q[3]]}
  g=0
  g=event.server.id unless event.server.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xnam && (q[2].nil? || q[2].include?(g))}
  return $enemies[$enemies.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')==xnam && (q[2].nil? || q[2].include?(g))}
  return $enemies[$enemies.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  return nil if fullname || xnam.length<=2
  k=$enemies.find_index{|q| q.name.downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xnam.length]==xnam}
  return $enemies[k] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xnam.length]==xnam && (q[2].nil? || q[2].include?(g))}
  return $enemies[$enemies.find_index{|q| q.name==alz[k][1]}] unless k.nil?
  k=alz.find_index{|q| q[0].downcase.gsub('||','').gsub(' ','').gsub('(','').gsub(')','').gsub('!','').gsub(',','').gsub('?','').gsub('_','').gsub("'",'').gsub('"','').gsub(':','')[0,xnam.length]==xnam && (q[2].nil? || q[2].include?(g))}
  return $enemies[$enemies.find_index{|q| q.name==alz[k][1]}] unless k.nil?
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
      f.push([generate_rarity_row(i,$max_rarity[0],k.games[0]),k.stat_grid(i)])
    end
    f.push(["#{generate_rarity_row(0,$max_rarity[0],k.games[0])}\nMana Unbind",k.stat_grid($max_rarity[0]+1)]) if k.hasManaSpiral?
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
    lll=[2,4,6]
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
    if s2s
      f.push(['Skills',str2,1])
    elsif str2.length>1500
      str="#{str3}\n\n~~Skill descriptions make this data too long.  Please try again in PM.~~"
    else
      str="#{str2}"
    end
  end
  unless juststats
    if s2s
      f.push(['Abilities',k.ability_display(rar)])
    else
      str="#{str}\n\n#{k.ability_display(rar,false)}"
    end
  end
  f2=nil; f3=nil
  lng+=hdr.length+str.length
  lng+=ftr.length unless ftr.nil?
  lng+=f.map{|q| "#{q[0]}\n#{q[1]}"}.join("\n\n").length unless f.nil?
  if lng>1950
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
    hdr="#{hdr}#{generate_rarity_row(k.rarity,0,k.games[0])}"
    if k.rarity>4
      hdr="#{hdr} - <:Fill_Gold:759999913962110978>"
    else
      hdr="#{hdr} - <:Fill_Silver:759999914062774302>"
    end
  end
  f=nil
  mub=0
  mub=1 if has_any?(['mub','unbind','unbound','refined','refine','refinement','2ub','3ub'],evn)
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
  c=k.stat_grid(bot,s2s)
  str=c[0]; ftr=c[1]
  str="#{str}\n"
  str="#{str}\n**Obtained:** #{k.obtain}" if !k.obtain.nil? && k.obtain.length>0
  if k.isMultiprint?
    str="#{str}\n#{k.multiprintText}"
  elsif !k.availability.nil? || !has_any?(['s','z','y','t','w'],k.availability)
    c=k.stat_emotes.map{|q| q}
    str="#{str}\n**Shop Price:** 900#{c[4]} per 2UB, 1,700#{c[4]} per MUB" if k.rarity==3
    str="#{str}\n**Shop Price:** 9,000#{c[4]} per 2UB, 17,000#{c[4]} per MUB" if k.rarity==4
    str="#{str}\n**Shop Price:** 19,000#{c[4]} per 2UB, 37,000#{c[4]} per MUB" if k.rarity==5
    str="#{str}\n**Shop Price:** 25,000#{c[4]} per 2UB, 53,000#{c[4]} per MUB" if k.rarity==6
    str="#{str}\nThese include the cost of buying, and the cost of unbinding." if k.rarity>2
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
=begin
    k2=find_data_ex(:find_enemy,args2,event)
    if k2.length>0 && k2[2][2]=='Void'
      k3=k.reject{|q| q.boss_tags.nil? || !q.boss_tags.include?(k2.name)}
      k=k3.map{|q| q} if k3.length>0
    end
=end
    if k.length>5
      event.respond "Too many weapons qualify.  I will not display them all."
      return nil
    end
    for i in 0...k.length
      disp_weapon_stats(bot,event,args,juststats,k[i].clone)
    end
    return nil
  end
  s2s=false
  s2s=true if safe_to_spam?(event)
  evn=event.message.text.downcase.split(' ')
  juststats=true if Shardizard != 4 && evn.include?('smol')
  hdr="__**#{k.name}**__"
  title=k.class_header(bot,0,true)
  unless s2s || juststats
    hdr="#{hdr}#{generate_rarity_row(k.rarity,0,k.games[0])}"
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
    mmm2=wpnz.find_index{|q| q.type==k.type && q.element==k.element && q.availability.inculde?('m')} if k.availability.include?('a')
    mmm2=wpnz.find_index{|q| q.type==k.type && q.element==k.element && q.rarity==5} if k.availability.include?('h')
    if s2s
      str2="#{str2}#{"\n" unless m.length<=1}\n\n**Promotes from: #{m2.emotes(bot)}*#{m2.name}* **#{"\n*Smithy level required:* #{k.smith_level}" unless k.availability.include?('h')}\n*Assembly cost:* #{longFormattedNumber(k.costs[0])}#{k.stat_emotes[4]}\n*Required mats:* #{k.craft_mats.map{|q| "#{q[0]} x#{q[1]}"}.join(', ')}" unless m2.nil?
      str2="#{str2}#{"\n" unless m.length==1}\n\n**Crafting requirements: #{mm2.emotes(bot)}*#{mm2.name}* **" unless mmm2.nil?
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
=begin
    k2=find_data_ex(:find_enemy,args2,event)
    if k2.length>0 && k2[2][2]=='Void'
      k3=k.reject{|q| q.boss_tags.nil? || !q.boss_tags.include?(k2.name)}
      k=k3.map{|q| q} if k3.length>0
    end
=end
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
    hdr="#{hdr}#{generate_rarity_row(k.rarity,0,k.games[0])}"
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

bot.command([:adventurer,:adv,:unit]) do |event, *args|
  return nil if overlap_prevent(event)
=begin
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
=end
  disp_adventurer_stats(bot,event,args)
end

bot.command([:dragon,:drg,:drag]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
=begin
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
=end
  disp_dragon_stats(bot,event,args)
end

bot.command([:wyrmprint,:wyrm,:print]) do |event, *args|
  return nil if overlap_prevent(event)
=begin
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
=end
  disp_wyrmprint_stats(bot,event,args)
end

bot.command([:weapon,:wep,:weap,:wpn]) do |event, *args|
  return nil if overlap_prevent(event)
=begin
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
=end
  disp_weapon_stats(bot,event,args)
end

bot.command([:enemy,:boss]) do |event, *args|
  return nil if overlap_prevent(event)
  data_load('library')
=begin
  if args.nil? || args.length<=0
  elsif ['find','search'].include?(args[0].downcase)
    args.shift
    find_enemies(bot,event,args)
    return nil
  end
=end
  disp_enemy_data(bot,event,args)
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

bot.command([:lineage,:craft,:crafting]) do |event, *args|
  return nil if overlap_prevent(event)
  disp_weapon_lineage(bot,event,args)
end



bot.command([:affinity,:resonance]) do |event|
  return nil if overlap_prevent(event)
  data_load('library')
  affinity_resonance(event,bot)
end

bot.command([:embeds,:embed]) do |event|
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

bot.command([:bugreport, :suggestion, :feedback]) do |event, *args|
  return nil if overlap_prevent(event)
  x=['dl!','dl?']
  x.push(@prefixes[event.server.id]) unless event.server.nil? || @prefixes[event.server.id].nil?
  bug_report(bot,event,args,Shards,shard_data(0),'Shard',x,532083509083373583)
end

bot.command([:donation, :donate]) do |event, uid|
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

bot.command([:avatar, :avvie]) do |event, *args|
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
  event.channel.send_temporary_message('Please wait...',10)
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
      puts 'reloading BotanClassFunction'
      load "#{$location}devkit/BotanClassFunctions.rb"
      t=Time.now
      $last_multi_reload[1]=t
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
  elsif ['d!','d?'].include?(str[0,2]) && Shardizard==4 && (event.server.nil? || event.server.id==285663217261477889)
    s=event.message.text.downcase
    s=s[2,s.length-2] if ['d?','d!'].include?(event.message.text.downcase[0,2])
    a=s.split(' ')
    if a[0].downcase=='reboot'
      event.respond "Becoming BotanX.  Please wait approximately ten seconds..."
      exec "cd #{$location}devkit && DebugBotX.rb 4"
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
  data_load('library')
  if !m || args.nil? || args.length<=0
  elsif ['help','commands','command_list','commandlist'].include?(args[0].downcase)
    args.shift
    help_text(event,bot,args[0],args[1])
    m=false
  elsif ['adventurer','adv'].include?(args[0].downcase)
    m=false
    args.shift
    disp_adventurer_stats(bot,event,args)
  elsif ['dragon','drg','drag'].include?(args[0].downcase)
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
    if ['lineage','craft','crafting'].include?(args[0].downcase)
      args.shift
      disp_weapon_lineage(bot,event,args)
    else
      disp_weapon_stats(bot,event,args)
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
  puts 'reloading BotanText'
  load "#{$location}devkit/BotanClassFunctions.rb"
  system("color 1#{shard_data(3)[Shardizard,1]}")
  system("title #{shard_data(2)[Shardizard]} BotanBot")
  system("title Smol BotanBot") if Shardizard<0
  bot.game='Dragalia Lost (DL!help for info)'
  if bot.profile.id==618979409059119113
  elsif Shardizard==4
    next_holiday(bot)
    bot.user(bot.profile.id).on(285663217261477889).nickname='BotanBot (DebugX)' if Shardizard==4
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
    bot.channel(285663217261477889).send_message("Hello!") if b[0]!='BotanX'
    open("#{$location}devkit/DebugSav.txt", 'w') { |f|
      f.puts '"BotanX"'
    }
  end
end

bot.run
