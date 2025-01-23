library SaveLoadGeneric

globals
    integer user_custom_int_0
    integer user_custom_int_1
    integer user_custom_int_2
    
    boolean is_save_possible = true

    private unit player_unit
    private unit player_bag /* Local */

    
    private integer save_count = 5
    
    private integer character_count = 3
    
    private string MAP_ID = "TERRA"
    private string SECRET_KEY = "8f0f09e0-4ff0-44d4-ae73-b3c53ffac16d"

    private string user_id
    
    private integer current_character_index = -1
    
    private string array character_data_str[12][3]
    private string array resource_data_str[12]
    
    private string character_index = "character_index"
    private string resource = "resource"
    
    
    constant integer CHARACTER_DATA_LEVEL = 0
    constant integer CHARACTER_DATA_UNIT_TYPE = 1
    constant integer CHARACTER_DATA_EXP = 2
    constant integer CHARACTER_DATA_STR = 3
    constant integer CHARACTER_DATA_AGI = 4
    constant integer CHARACTER_DATA_INT = 5
    constant integer CHARACTER_DATA_HERO_STATE = 6
    constant integer CHARACTER_DATA_GOLD = 7
    constant integer CHARACTER_DATA_LUMBER = 8
    constant integer CHARACTER_DATA_USER_ITEM_0 = 9
    constant integer CHARACTER_DATA_USER_ITEM_1 = 10
    constant integer CHARACTER_DATA_USER_ITEM_2 = 11
    constant integer CHARACTER_DATA_USER_ITEM_3 = 12
    constant integer CHARACTER_DATA_USER_ITEM_4 = 13
    constant integer CHARACTER_DATA_USER_ITEM_5 = 14
    constant integer CHARACTER_DATA_BAG_0_ITEM_0 = 15
    constant integer CHARACTER_DATA_BAG_0_ITEM_1 = 16
    constant integer CHARACTER_DATA_BAG_0_ITEM_2 = 17
    constant integer CHARACTER_DATA_BAG_0_ITEM_3 = 18
    constant integer CHARACTER_DATA_BAG_0_ITEM_4 = 19
    constant integer CHARACTER_DATA_BAG_0_ITEM_5 = 20
    constant integer CHARACTER_DATA_BAG_1_ITEM_0 = 21
    constant integer CHARACTER_DATA_BAG_2_ITEM_1 = 22
    constant integer CHARACTER_DATA_BAG_3_ITEM_2 = 23
    constant integer CHARACTER_DATA_BAG_4_ITEM_3 = 24
    constant integer CHARACTER_DATA_BAG_5_ITEM_4 = 25
    constant integer CHARACTER_DATA_BAG_6_ITEM_5 = 26
    
    
    
    
endglobals

// ===== Battle Net Check =====
function Is_Battle_Net takes nothing returns boolean
    if JNGetConnectionState() == 1112425812 then
        return true
    else
        return false
    endif
endfunction

// ===== SET =====

function Set_Save_Count takes integer value returns nothing
    set save_count = value
endfunction

function Set_Current_Character_Index takes integer index returns nothing
    set current_character_index = index
endfunction

function Set_Player_Unit takes integer pid, unit u returns nothing
    if GetLocalPlayer() == Player(pid) then
        set player_unit = u
    endif
endfunction

function Set_Resource_Data_String takes integer pid, string str returns nothing
    set resource_data_str[pid] = str
endfunction

function Set_Character_Data_String takes integer pid, integer index, string str returns nothing
    set character_data_str[pid][index] = str
endfunction

function Set_User_ID takes string str returns nothing
    set user_id = str
endfunction

// ===== GET =====

function Get_Save_Count takes nothing returns integer
    return save_count
endfunction

function Get_Current_Character_Index takes nothing returns integer
    return current_character_index
endfunction

function Get_Player_Unit takes nothing returns unit
    return player_unit
endfunction

function Get_Resource_Data_Property takes integer pid, integer property returns string
    return JNStringSplit(resource_data_str[pid], "/", property)
endfunction

function Get_Character_Data_Property takes integer pid, integer index, integer property returns string
    return JNStringSplit(character_data_str[pid][index], "/", property)
endfunction

function Get_Resource_String takes nothing returns string
    return resource
endfunction

function Get_Characater_Index takes integer index returns string
    return character_index + I2S(index)
endfunction

function Get_Character_Data_String takes integer pid, integer index returns string
    return character_data_str[pid][index]
endfunction

function Get_User_Id takes nothing returns string
    return user_id
endfunction

function Get_Secret_Key takes nothing returns string
    return SECRET_KEY
endfunction

function Get_Map_Id takes nothing returns string
    return MAP_ID
endfunction

function Get_Character_Count takes nothing returns integer
    return character_count
endfunction

endlibrary