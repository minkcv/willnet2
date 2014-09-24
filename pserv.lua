rednet.open('back')
printer = peripheral.wrap('left')
while true do
	id, line, prot = rednet.receive('print')
	if printer.getPaperLevel() < 1 then
		rednet.send(id, 'out of paper', 'print')
	elseif printer.getInkLevel() < 1 then
		rednet.send(id, 'out of ink', 'print')
	elseif not printer.newPage() then
		rednet.send(id, 'new page failed', 'print')
	else
		printer.write(line)
		printer.endPage()
	end
end
