rednet.open('back')
rednet.host('file', 'file')
while true do
    id, cmds, prot = rednet.receive('file')
    if cmds[2] == 'list' then
        if cmds[3] ~= nil then
            files = fs.list(cmds[3])
            count = 0
            for _ in pairs(files) do count = count + 1 end
            rednet.send(id, tostring(count), 'rlist')
            for _, f in pairs(files) do
                rednet.send(id, f, 'rlist')
            end
        else
            rednet.send(id, 0, 'rlist')
        end
    elseif cmds[2] == 'get' then
        if cmds[3] ~= nil and fs.exists(cmds[3]) and not fs.isDir(cmds[3]) then
            if fs.exists(cmds[3]) then
                file = fs.open(cmds[3], 'r')
                line = file.readLine()
                while line ~= nil do
                    rednet.send(id, line, 'rfile')
                    line = file.readLine()
                end
            end
        end
        rednet.send(id, nil, 'rfile')
    elseif cmds[2] == 'put' then
        name = cmds[3]
        if name ~= 'fileserv' then
            content = ''
            id, line, prot = rednet.receive('pfile')
            while line ~= nil do
                content = content .. line .. '\n'
                id, line, prot = rednet.receive('pfile')
            end
            file = fs.open(name, 'w')
            file.write(content)
            file.close()
        end
    end
    id, line, prot = nil
end
