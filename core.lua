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
            local k,v = "SoftTargetEnemy" v = GetCVar(k) SetCVar(k, 3) 
            if (clearTargetDB == true) then
                ClearTarget()
            end
        else
            if (hiddenTextDB == true) then
                --
            else
                print('AutoTarget OFF')
            end
            local k,v = "SoftTargetEnemy" v = GetCVar(k) SetCVar(k, 0)                     
        end
    end
    if event == "ADDON_LOADED" and arg1 == "AutoTargetInCombatOnly" then
        local checkboxHideText = CreateFrame("CheckButton", "AutoTargetInCombatOnly_checkboxHideText", self,
            "InterfaceOptionsCheckButtonTemplate")
        checkboxHideText:SetPoint("TOPLEFT", 16, -16)
        checkboxHideText.Text:SetText("Hide notification in chat")
        checkboxHideText:SetChecked(hiddenTextDB)
        -- checkboxHideText.tooltipText = "description"
        checkboxHideText:SetScript("OnClick", function(self)
            local isChecked = self:GetChecked()
            hiddenTextDB = isChecked
        end)

        local checkboxClearTarget = CreateFrame("CheckButton", "AutoTargetInCombatOnly_checkboxClearTarget", self,
            "InterfaceOptionsCheckButtonTemplate")
        checkboxClearTarget:SetPoint("TOPLEFT", 16, -40)
        checkboxClearTarget.Text:SetText("Auto ClearTarget")
        checkboxClearTarget:SetChecked(hiddenTextDB)
        -- checkboxClearTarget.tooltipText = "description"
        checkboxClearTarget:SetScript("OnClick", function(self)
            local isChecked = self:GetChecked()
            clearTargetDB = isChecked
        end)

        self.name = "AutoTargetInCombatOnly" -- see panel fields
        InterfaceOptions_AddCategory(self) -- see InterfaceOptions API

        -- add widgets to the panel as desired
        local title = self:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        title:SetPoint("TOP")
        title:SetText("AutoTargetInCombatOnly")
    end
end)

