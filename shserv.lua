rednet.open('back')
rednet.host('rsh','rsh')
while true do
	id, line, prot = rednet.receive('rsh')
	cmd = loadstring(line)
	setfenv(cmd, _G)
	cmd()
end
