rednet.open('back')
rednet.host('update','update')
while true do
  id, line, prot = rednet.receive('update')
  if line == 'request' then
    print('answering request from '..id)
    willnet = fs.open('willnet','r')
    prgline = willnet.readLine()
    while prgline ~= nil do
      rednet.send(id,prgline,'updateline')
      prgline = willnet.readLine()
    end
    rednet.send(id, nil)
    print('finished sending')
    willnet.close()
  end
  id, line, prot = nil
end
