function move_time_sel_end_one_bar_left()

loopStart, loopEnd = reaper.GetSet_LoopTimeRange2(0, 0, 0, 0, 0, 0)
retval, division = reaper.GetSetProjectGrid(0,false)

moveLeft = true

bpm = reaper.TimeMap2_GetDividedBpmAtTime(0, loopEnd)
fullAmount = (60 / bpm) * 4

priorGridLine = loopEnd % fullAmount


if priorGridLine ~= 0 then
  if moveLeft then
    newEnd = loopEnd-priorGridLine
  else
    newEnd = loopEnd+(fullAmount - priorGridLine)
  end
  reaper.GetSet_LoopTimeRange2(0,true,false,loopStart,newEnd,true)

  loopStart, loopEnd = reaper.GetSet_LoopTimeRange2(0, 0, 0, 0, 0, 0)
else
  if moveLeft then
    newEnd = loopEnd-fullAmount
  else
    newEnd = loopEnd+fullAmount
  end
  reaper.GetSet_LoopTimeRange2(0,true,false,loopStart,newEnd,true)
 
  loopStart, loopEnd = reaper.GetSet_LoopTimeRange2(0, 0, 0, 0, 0, 0)
end  

end

reaper.defer(move_time_sel_end_one_bar_left)
