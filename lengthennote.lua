function getClientInfo()
    return {
        name = "Lengthen Note",
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
        if #notes > 0 then
            local lastSelectedNote = notes[#notes]
            lastSelectedNote:setDuration(lastSelectedNote:getDuration()*2)
        end
    end
    SV:finish()
end
