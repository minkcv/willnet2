rednet.open('back')
rednet.host('rsh','rsh')
msg = {}
term.write = function(...) table.insert(msg, ...) end
while true do
    id, line, prot = rednet.receive('rsh')
    cmd = loadstring(line)
    if cmd then
        pcall(cmd)
    else
        msg = {'invalid command'}
    end
    for _, m in pairs(msg) do
        rednet.send(id, m, 'rsh')
    end
    rednet.send(id, nil, 'rsh')
    msg = {}
end
