--[[
  Reaper Script to accept absolute midi messages and move the edit position to the 
  percentage of the project length as represented by the midi value. 

  I'm doing this to make the the touchbar on my Alphatrack Frontier work as a jogbar in 
  conjunction with the CSI project https://forums.cockos.com/showthread.php?t=183143

  Author : Malcolm Groves
  Repo : github.com/malcolmgroves/reaper_scripts
]]

function Main()
  percent = GetAbsoluteMIDIMsgAsPercent()
  JumpToProjectPercent(percent)
end

function DebugMsg(msg)
  reaper.ShowConsoleMsg("MalGMIDIJog : "..msg.."\n")
end

function GetAbsoluteMIDIMsgAsPercent()
  is_new_value,filename,sectionID,cmdID,mode,resolution,val = reaper.get_action_context()

  -- mode 0 is absolute mode
  if mode == 0 then
    DebugMsg("val = "..val)
    DebugMsg("resolution = "..resolution)
    percent = val / resolution
    DebugMsg("percent = " .. percent)
    return percent 
  else
    DebugMsg("Can only handle absolute midi messages. Moving to current position") 
    currentCursorPos = reaper.GetCursorPosition()
    projlen = reaper.GetProjectLength(0)
    currentpos = currentCursorPos / projlen
    return currentpos
  end
end

function JumpToProjectPercent(percent)
  if (percent < 0) then
    DebugMsg("invalid input. percent = "..percent)
    percent = 0 
  end   
  if (percent < 0) or (percent > 1) then
    DebugMsg("invalid input. percent = "..percent)
    percent = 1
  end   
  DebugMsg("percent = "..percent)
  projlen = reaper.GetProjectLength(0)
  DebugMsg("projlen = "..projlen)
  newpos = projlen * percent
  DebugMsg("newpos = "..newpos)
  reaper.SetEditCurPos(newpos, 1, 0)
end

Main()
