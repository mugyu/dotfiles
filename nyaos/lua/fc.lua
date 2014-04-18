function nyaos.command.fc()
    local editor=os.getenv("EDITOR")
    if not editor then
        editor = "notepad"
    end
    local text = nyaos.history[ nyaos.history:len()-1 ]
    if text then
        local tempfname=os.tmpname()
        local fd = io.open(tempfname,"w")
        fd:write(text.."\n")
        fd:close()
        os.execute(editor..' \034'..tempfname..'\034' )
        os.remove( tempfname )
    else
        print("There is no history text.")
    end
end
