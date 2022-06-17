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
    if sel ~= nil then
        local notes = sel:getSelectedNotes()
        for i=1, #notes, 1 do
            notes[i]:setPitch(notes[i]:getPitch()-1)
        end
    end
    SV:finish()
end
