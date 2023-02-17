function getClientInfo()
    return {
        name = "Move Note Down",
        author = "impbox",
        versionNumber = 1,
        minEditorVersion = 0
    }
end

function getTranslations(langCode)
    -- please help add translations <3
    return {}
end

function main()
    local sel = SV:getMainEditor():getSelection()
    local moved = false
    if sel ~= nil then
        local notes = sel:getSelectedNotes()
        for i=1, #notes, 1 do
            notes[i]:setPitch(notes[i]:getPitch()-1)
            moved = true
        end
    end
    if not moved then
        -- scroll down
        local nav = SV:getMainEditor():getNavigation()
        local range = nav:getValueViewRange()
        local mid = (range[1] + range[2]) / 2.0
        nav:setValueCenter(mid - 1.0)
    end
    SV:finish()
end
