--[[
  Reaper Script to move the edit cursor to the start of the time selection

  Author : Malcolm Groves
  Repo : github.com/malcolmgroves/reaper_csi
]]
function move_cursor_to_end_of_selection()

  loopStart, loopEnd = reaper.GetSet_LoopTimeRange2(0, 0, 0, 0, 0, 0)
  reaper.SetEditCurPos(loopEnd, 1, 0) 
end

reaper.defer(move_cursor_to_end_of_selection)
