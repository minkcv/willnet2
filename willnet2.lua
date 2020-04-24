function split(str, pat)
    local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
          table.insert(t,cap)
       end
       last_end = e+1
       s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
       cap = str:sub(last_end)
       table.insert(t, cap)
    end
    return t
 end

rednet.open('back')
print('Welcome to WillNet2. Type help for commands')
io.write('willnet> ')
input = io.read()
input = split(input, ' ')
cmd = input[1]
while cmd ~= 'exit' do
    if cmd == 'update' then
        willnet = fs.open('willnet','w')
        updateServerID = rednet.lookup('update')
        rednet.send(updateServerID,'request','update')
        id, line, prot = rednet.receive('updateline')
        while line ~= nil do
            willnet.writeLine(line)
            --if you filter this receive with 'update' it wont work for receiveing nil
               id, line, prot = rednet.receive() 
        end
          willnet.close()
        --not an actual error but the cleanest way to exit the program
        error('finished updating')
    elseif cmd == 'rsh' then
        id = rednet.lookup('rsh','rsh')
        print('use exit to exit the remote shell')
        io.write('willnet>rsh> ')
        cmd = io.read()
        while cmd ~= 'exit' do
            rednet.send(id, cmd, 'rsh')
            _, resp, prot = rednet.receive('rsh', 5)
            while resp ~= nil do
                print(resp)
                _, resp, prot = rednet.receive('rsh', 5)
            end
            io.write('willnet>rsh> ')
            cmd = io.read()
        end
    elseif cmd == 'print' then
        id = rednet.lookup('print','print')
        print('enter text to print')
        text = io.read()
        rednet.send(id,text,'print')
        id,line,prot = rednet.receive('print')
        print(line)
    elseif cmd == 'file' then
        id = rednet.lookup('file')
        rednet.send(id, input, 'file')
        if input[2] == 'list' then
            id, count, prot = rednet.receive('rlist')
            for i=1, count do
                id, line, prot = rednet.receive('rlist')
                print(line)
            end
        elseif input[2] == 'get' then
            content = ''
            id, line, prot = rednet.receive('rfile')
            while line ~= nil do
                content = content .. line .. '\n'
                id, line, prot = rednet.receive('rfile')
            end
            file = fs.open(input[3], 'w')
            file.write(content)
            file.close()
        elseif input[2] == 'put' then
            file = fs.open(input[3], 'r')
            line = file.readLine()
            while line ~= nil do
                rednet.send(id, line, 'pfile')
                line = file.readLine()
            end
            rednet.send(id, nil, 'pfile')
            file.close()
        end
    elseif cmd == 'help' then
          print('commands: print, update, exit, rsh, file')
    end
    io.write('willnet> ')
    input = io.read()
    input = split(input, ' ')
    cmd = input[1]
end
rednet.close('back')
