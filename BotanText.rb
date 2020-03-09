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
