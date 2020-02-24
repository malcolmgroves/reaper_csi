function move_time_sel_start_one_bar_left()

loopStart, loopEnd = reaper.GetSet_LoopTimeRange2(0, 0, 0, 0, 0, 0)
retval, division = reaper.GetSetProjectGrid(0,false)

moveLeft = true

bpm = reaper.TimeMap2_GetDividedBpmAtTime(0, loopStart)
fullAmount = (60 / bpm)

priorGridLine = loopStart % fullAmount


if priorGridLine ~= 0 then
  if moveLeft then
    newStart = loopStart-priorGridLine
  else
    newStart = loopStart+(fullAmount - priorGridLine)
  end
  reaper.GetSet_LoopTimeRange2(0,true,false,newStart,loopEnd,true)
  loopStart, loopEnd = reaper.GetSet_LoopTimeRange2(0, 0, 0, 0, 0, 0)
else
  if moveLeft then
    newStart = loopStart-fullAmount
  else
    newStart = loopStart+fullAmount
  end
  reaper.GetSet_LoopTimeRange2(0,true,false,newStart,loopEnd,true)
  loopStart, loopEnd = reaper.GetSet_LoopTimeRange2(0, 0, 0, 0, 0, 0)
end  

end

reaper.defer(move_time_sel_start_one_bar_left)
