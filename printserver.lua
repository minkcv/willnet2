env = {printer = peripheral.wrap('left')}
rednet.open('back')
while true do
  id, line, prot = rednet.receive('print')
  print(line)
  cmd = loadstring(line)
  setfenv(cmd, env)
  cmd()
end
