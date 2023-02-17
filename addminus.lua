function getClientInfo()
    return {
        name = "Add Minus",
        author = "impbox",
        versionNumber = 1,
        minEditorVersion = 0
    }
end

function getTranslations(langCode)
    -- please help add translations <3
    return {}
end

-- Wrapper function to know the flow of code
function main()
    local sel = SV:getMainEditor():getSelection()
    if sel ~= nil then
        local notes = sel:getSelectedNotes()
        if #notes > 0 then
            local lastSelectedNote = notes[#notes]
            local group = lastSelectedNote:getParent()
            local i = lastSelectedNote:getIndexInParent()
            local lastNote = group:getNote(i)
            local note = SV:create("Note")
            note:setOnset(lastNote:getEnd())
            note:setPitch(lastNote:getPitch())
            note:setDuration(lastNote:getDuration())
            note:setLyrics("-")
            group:addNote(note)
            sel:clearAll()
            sel:selectNote(note)
        else
            local group = SV:getMainEditor():getCurrentGroup()
            local note = SV:create("Note")
            note:setOnset(group:getEnd())
            note:setPitch(60)
            note:setDuration(SV.QUARTER)
            note:setLyrics("-")
            group:addNote(note)
            sel:clearAll()
            sel:selectNote(note)
        end
    end
    SV:finish()
end
