local incombat = UnitAffectingCombat("player")
local holder = CreateFrame("Frame")
holder:RegisterEvent("PLAYER_REGEN_ENABLED")
holder:RegisterEvent("PLAYER_REGEN_DISABLED")
holder:SetScript("OnEvent", function(self, event)
      incombat = (event=="PLAYER_REGEN_ENABLED")
      local realInCombat = (incombat==false)           
      if (realInCombat==true)
      then
         print('Auto-target ON');
         ConsoleExec( "SoftTargetEnemy 3")
      else
         print('Auto-target OFF');
         ConsoleExec( "SoftTargetEnemy 0")
      end
end)