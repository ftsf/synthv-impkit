function getClientInfo()
    return {
        name = "Shorten Note",
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
        for i=1, #notes do
            -- shorten note
            local note = notes[i]
            local nextNote = nil
            if i+1 <= #notes and notes[i+1]:getOnset() == notes[i]:getEnd() then
                nextNote = notes[i+1]
            end
            note:setDuration(note:getDuration()/2)
            if nextNote ~= nil then
                nextNote:setOnset(note:getEnd())
            end
        end
    end
    SV:finish()
end
