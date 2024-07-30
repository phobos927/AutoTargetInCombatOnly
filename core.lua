local incombat = UnitAffectingCombat("player")
local holder = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
-- holder.name = "AutoTargetInCombatOnly"
local loaded = false
holder:RegisterEvent("ADDON_LOADED");
holder:RegisterEvent("PLAYER_REGEN_ENABLED")
holder:RegisterEvent("PLAYER_REGEN_DISABLED")

-- Locally define a function removed from Blizzard's API in 11.0
local InterfaceOptions_AddCategory = InterfaceOptions_AddCategory
if not InterfaceOptions_AddCategory then
    InterfaceOptions_AddCategory = function(frame, addOn, position)
        -- cancel is no longer a default option. May add menu extension for this.
        frame.OnCommit = frame.okay;
        frame.OnDefault = frame.default;
        frame.OnRefresh = frame.refresh;

        if frame.parent then
            local category = Settings.GetCategory(frame.parent);
            local subcategory, layout =
                Settings.RegisterCanvasLayoutSubcategory(category, frame, frame.name, frame.name);
            subcategory.ID = frame.name;
            return subcategory, category;
        else
            local category, layout = Settings.RegisterCanvasLayoutCategory(frame, frame.name, frame.name);
            category.ID = frame.name;
            Settings.RegisterAddOnCategory(category);
            return category;
        end
    end
end

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
            local k, v = "SoftTargetEnemy"
            v = GetCVar(k)
            SetCVar(k, 3)
            if (clearTargetDB == true) then
                ClearTarget()
            end
        else
            if (hiddenTextDB == true) then
                --
            else
                print('AutoTarget OFF')
            end
            local k, v = "SoftTargetEnemy"
            v = GetCVar(k)
            SetCVar(k, 0)
        end
    end
    if event == "ADDON_LOADED" and arg1 == "AutoTargetInCombatOnly" then

        local mainPanel = CreateFrame("Frame", "AutoTarget_MainFrame", self)

        local checkboxHideText = CreateFrame("CheckButton", "AutoTargetInCombatOnly_checkboxHideText", mainPanel,
            "InterfaceOptionsCheckButtonTemplate")
        checkboxHideText:SetPoint("TOPLEFT", 16, -16)
        checkboxHideText.Text:SetText("Hide notification in chat")
        checkboxHideText:SetChecked(hiddenTextDB)
        -- checkboxHideText.tooltipText = "description"
        checkboxHideText:SetScript("OnClick", function(self)
            local isChecked = self:GetChecked()
            hiddenTextDB = isChecked
        end)

        local checkboxClearTarget = CreateFrame("CheckButton", "AutoTargetInCombatOnly_checkboxClearTarget", mainPanel,
            "InterfaceOptionsCheckButtonTemplate")
        checkboxClearTarget:SetPoint("TOPLEFT", 16, -40)
        checkboxClearTarget.Text:SetText("Auto ClearTarget")
        checkboxClearTarget:SetChecked(hiddenTextDB)
        -- checkboxClearTarget.tooltipText = "description"
        checkboxClearTarget:SetScript("OnClick", function(self)
            local isChecked = self:GetChecked()
            clearTargetDB = isChecked
        end)

        mainPanel.name = "AutoTargetInCombatOnly" -- see panel fields
        -- print('AutoTargetInCombatOnly loaded')
        -- print(mainPanel)
        InterfaceOptions_AddCategory(mainPanel, "AutoTargetInCombatOnly") -- see InterfaceOptions API

        -- add widgets to the panel as desired
        local title = mainPanel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        title:SetPoint("TOP")
        title:SetText("AutoTargetInCombatOnly")
    end
end)

