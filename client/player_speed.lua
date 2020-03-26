

local running_speed_added = 40
local normal_speed_added = 30
local crouched_speed_added = 20

local pressing =
{
  F=false,
  B=false,
  L=false,
  R=false
}

AddEvent("OnGameTick",function(ds)
    if GetInputAxisValue("MoveForward") == 1.0 then
        pressing["F"] = true
        pressing["B"] = false
      end
     if GetInputAxisValue("MoveForward") == -1.0 then
       pressing["F"] = false
       pressing["B"] = true
     end
     if GetInputAxisValue("MoveForward") == 0 then
       pressing["F"] = false
       pressing["B"] = false
     end
    if GetInputAxisValue("MoveRight") == 1.0 then
      pressing["R"] = true
      pressing["L"] = false
    end
   if GetInputAxisValue("MoveRight") == -1.0 then
     pressing["R"] = false
     pressing["L"] = true
   end
   if GetInputAxisValue("MoveRight") == 0 then
     pressing["R"] = false
     pressing["L"] = false
   end
end)

AddEvent("OnGameTick",function(ds)
   if GetPlayerMovementSpeed(GetPlayerId()) ~= 0 then
   if (running_speed_added ~= 0 or normal_speed_added ~= 0 or crouched_speed_added ~= 0) then
    local speed = 0
    if (GetPlayerMovementMode(GetPlayerId()) == 2 or GetPlayerMovementMode(GetPlayerId()) == 3 or GetPlayerMovementMode(GetPlayerId()) == 4) then
       if GetPlayerMovementMode(GetPlayerId()) == 2 then
           speed = normal_speed_added
       elseif GetPlayerMovementMode(GetPlayerId()) == 3 then
           speed = running_speed_added
       elseif GetPlayerMovementMode(GetPlayerId()) == 4 then
           speed = crouched_speed_added
       end
       local fx, fy, fz = GetPlayerForwardVector(GetPlayerId())
       local rx, ry, rz = GetPlayerRightVector(GetPlayerId())
       local x, y, z = GetPlayerLocation()
       speed = speed * 10
       fx2 = fx*(speed*ds)
       fy2 = fy*(speed*ds)
       fx3 = fx2*3.5
       fy3 = fy2*3.5
       actor = GetPlayerActor(GetPlayerId())
       local impact = false
       local mult = 24
       local mult2 = 10
       local hittype, hitid, impactX, impactY, impactZ = 0,0,0,0,0
       local hittype2, hitid2, impactX2, impactY2, impactZ2 = 0,0,0,0,0
       local hittype3, hitid3, impactX3, impactY3, impactZ3 = 0,0,0,0,0
       local hittype4, hitid4, impactX4, impactY4, impactZ4 = 0,0,0,0,0
       if GetPlayerMovementMode(GetPlayerId()) ~= 4 then
          hittype, hitid, impactX, impactY, impactZ = LineTrace(x+fx*mult, y+fy*mult, z-40, x+fx*mult+fx3, y+fy*mult+fy3, z-40)
          hittype2, hitid2, impactX2, impactY2, impactZ2 = LineTrace(x+fx*mult, y+fy*mult, z+40, x+fx*mult+fx3, y+fy*mult+fy3, z+40)
          hittype3, hitid3, impactX3, impactY3, impactZ3 = LineTrace((x+fx*mult)+rx*mult2, (y+fy*mult)+ry*mult2, z+40, (x+fx*mult)+rx*mult2+fx3, (y+fy*mult)+ry*mult2+fy3, z+40)
          hittype4, hitid4, impactX4, impactY4, impactZ4 = LineTrace((x+fx*mult)-rx*mult2, (y+fy*mult)-ry*mult2, z+40, (x+fx*mult)-rx*mult2+fx3, (y+fy*mult)-ry*mult2+fy3, z+40)
          if (impactX3 ~= 0 and impactY3 ~= 0) then
            impact = true
         end
       else
          mult = 5
          local mult3 = 15
          hittype, hitid, impactX, impactY, impactZ = LineTrace(x+fx*mult, y+fy*mult, z+25, x+fx*mult+fx3, y+fy*mult+fy3, z+25)
          hittype2, hitid2, impactX2, impactY2, impactZ2 = LineTrace((x+fx*mult3)+rx*mult2, (y+fy*mult3)+ry*mult2, z+30, (x+fx*mult3)+rx*mult2+fx3, (y+fy*mult3)+ry*mult2+fy3, z+30)
          hittype3, hitid3, impactX3, impactY3, impactZ3 = LineTrace((x+fx*mult3)-rx*mult2, (y+fy*mult3)-ry*mult2, z+30, (x+fx*mult3)-rx*mult2+fx3, (y+fy*mult3)-ry*mult2+fy3, z+30)
          if (impactX3 ~= 0 and impactY3 ~= 0) then
             local isself = false
             if (hittype3 == 2 and hitid3 == GetPlayerId()) then
                isself = true
             end
             if not isself then
               impact = true
             end
         end
       end
       if (impactX ~= 0 and impactY ~= 0) then
          impact = true
       end
       if (impactX2 ~= 0 and impactY2 ~= 0) then
          impact = true
       end
      if (impactX4 ~= 0 and impactY4 ~= 0) then
         impact = true
      end
       if not impact then
          if (pressing['F'] or pressing['B'] or pressing['L'] or pressing['R']) then
             actor:SetActorLocation(FVector(x+fx2, y+fy2, z))
          end
       end
    end
   end
  end
end)


