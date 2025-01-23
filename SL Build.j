library SaveLoadBuild requires SaveLoadGeneric, SaveLoadPreprocess

globals
    private real unit_start_x = -23180
    private real unit_start_y = 28680
endglobals



function Save_Load_Build takes integer pid, integer current_character_index returns nothing
    local integer unit_type = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_UNIT_TYPE ) )
    local integer unit_exp = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_EXP ) )
    local integer unit_str = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_STR ) )
    local integer unit_agi = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_AGI ) )
    local integer unit_int = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_INT ) )
    local integer unit_hero_state = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_HERO_STATE ) )
    local integer unit_gold = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_GOLD ) )
    local integer unit_lumber = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_LUMBER ) )
    local unit u
    local integer item_type
    local integer i
    local item temp_item
    local location loc = Location(unit_start_x, unit_start_y)
    
    // 영웅 유닛 로드
    set u = CreateUnit(Player(pid), unit_type, unit_start_x, unit_start_y, 270)
    call AddHeroXP(u, unit_exp, true)
    call SetHeroStr(u, unit_str, true)
    call SetHeroAgi(u, unit_agi, true)
    call SetHeroInt(u, unit_int, true)
    
    call Set_Player_Unit(pid, u)
    set udg_Player_Hero[pid+1] = u
    set udg_Hero_State[pid+1] = unit_hero_state
    
    call AdjustPlayerStateBJ( unit_gold, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
    call AdjustPlayerStateBJ( unit_lumber, Player(pid), PLAYER_STATE_RESOURCE_LUMBER )
    
    // 영웅 아이템 로드
    set i = -1
    loop
    set i = i + 1
    exitwhen i >= 6
        set item_type = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_USER_ITEM_0 + i ) )
        
        if item_type != -1 then
            call UnitAddItemToSlotById(u, item_type, i )
            set temp_item = UnitItemInSlot(u, i)
            call SetItemUserData(temp_item, pid+1)
        endif
    endloop
    
    // 창고 0 아이템 로드
    set i = -1
    loop
    set i = i + 1
    exitwhen i >= 6
        set item_type = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_BAG_0_ITEM_0 + i ) )
        
        if item_type != -1 then
            call UnitAddItemToSlotById(udg_Player_Bag[pid+1], item_type, i )
            set temp_item = UnitItemInSlot(udg_Player_Bag[pid+1], i)
            call SetItemUserData(temp_item, pid+1)
        endif
    endloop
    
    // 창고 1 아이템 로드
    set i = -1
    loop
    set i = i + 1
    exitwhen i >= 6
        set item_type = S2I( Get_Character_Data_Property( pid, current_character_index, CHARACTER_DATA_BAG_1_ITEM_0 + i ) )
        
        if item_type != -1 then
            call UnitAddItemToSlotById(udg_Player_ITEM_MIX[pid+1], item_type, i )
            set temp_item = UnitItemInSlot(udg_Player_ITEM_MIX[pid+1], i)
            call SetItemUserData(temp_item, pid+1)
        endif
    endloop
    
    call TriggerRegisterUnitEvent( gg_trg_Player_Hero_Die, udg_Player_Hero[pid+1], EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( gg_trg_Hero_Skill, udg_Player_Hero[pid+1], EVENT_UNIT_SPELL_EFFECT )
    call TriggerRegisterUnitEvent( gg_trg_Level_Up, udg_Player_Hero[pid+1], EVENT_UNIT_HERO_LEVEL )
    call TriggerRegisterUnitEvent( gg_trg_Damage_Event, udg_Player_Hero[pid+1], EVENT_UNIT_DAMAGED )
    call TriggerRegisterUnitEvent( gg_trg_Player_ITEM_Get, udg_Player_Hero[pid+1], EVENT_UNIT_PICKUP_ITEM )
    call TriggerRegisterUnitEvent( gg_trg_Player_ITEM_Get, udg_Player_Bag[pid+1], EVENT_UNIT_PICKUP_ITEM )
    call TriggerRegisterUnitEvent( gg_trg_Player_Bag, udg_Player_Bag[pid+1], EVENT_UNIT_SPELL_EFFECT )
    call TriggerRegisterUnitEvent( gg_trg_Hero_Reset_States, udg_Player_Bag[pid+1], EVENT_UNIT_USE_ITEM )
    set udg_Level[pid+1] = GetUnitLevel(udg_Player_Hero[(pid+1)])
    set udg_Sellect_Value[pid+1] = true
    call SetUnitUserData(udg_Player_Hero[pid+1], 0 )
    call PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_Player_Hero[pid+1]),loc, 0 )
    
    call RemoveLocation(loc)
    
    set loc = null
    set temp_item = null
endfunction

endlibrary
