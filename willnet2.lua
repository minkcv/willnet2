rednet.open('back')
print('Welcome to WillNet2. Type help for commands')
io.write('willnet> ')
cmd = io.read()
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
		error('finished updating')
	elseif cmd == 'help' then
  	print('commands: print, update')
	end
	io.write('willnet> ')
	cmd = io.read()
end
rednet.close('back')
