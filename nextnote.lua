function getClientInfo()
    return {
        name = "Next Note",
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
            local group = lastSelectedNote:getParent()
            local i = lastSelectedNote:getIndexInParent()
            if i < group:getNumNotes() then
                local newNote = group:getNote(i + 1)
                sel:clearAll()
                sel:selectNote(newNote)
            end
        else
            -- select first note
            local group = SV:getMainEditor():getCurrentGroup():getTarget()
            if group then
                local nNotes = group:getNumNotes()
                if nNotes > 0 then
                    local note = group:getNote(1)
                    sel:clearAll()
                    sel:selectNote(note)
                end
            end
        end
    end
    SV:finish()
end
