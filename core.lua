local incombat = UnitAffectingCombat("player")
local holder = CreateFrame("Frame")
local loaded = false
holder:RegisterEvent("ADDON_LOADED");
holder:RegisterEvent("PLAYER_REGEN_ENABLED")
holder:RegisterEvent("PLAYER_REGEN_DISABLED")
holder:SetScript("OnEvent", function(self, event, arg1)
    incombat = (event == "PLAYER_REGEN_ENABLED")
    if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED" then
        local realInCombat = (incombat == false)
        if (realInCombat == true) then
            if (hiddenTextDB == true) then
                --
            else
                print('AutoTarget ON')
            end
            ConsoleExec("SoftTargetEnemy 3")
        else
            if (hiddenTextDB == true) then
               --
            else
                print('AutoTarget OFF')
            end
            ConsoleExec("SoftTargetEnemy 0")
        end
    end
    if event == "ADDON_LOADED" and arg1 == "AutoTargetInCombatOnly" then
        local myCheckbox = CreateFrame("CheckButton", "AutoTargetInCombatOnly_MyCheckbox", self,
            "InterfaceOptionsCheckButtonTemplate")
        myCheckbox:SetPoint("TOPLEFT", 16, -16)
        myCheckbox.Text:SetText("Hide notification in chat")
        myCheckbox:SetChecked(hiddenTextDB)
        -- myCheckbox.tooltipText = "description"
        myCheckbox:SetScript("OnClick", function(self)
            local isChecked = self:GetChecked()
            hiddenTextDB = isChecked
        end)

        self.name = "AutoTargetInCombatOnly" -- see panel fields
        InterfaceOptions_AddCategory(self) -- see InterfaceOptions API

        -- add widgets to the panel as desired
        local title = self:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        title:SetPoint("TOP")
        title:SetText("AutoTargetInCombatOnly")
    end
end)


