wireless = peripheral.wrap('left')
wired = peripheral.wrap('back')
wireless.closeAll()
wired.closeAll()
wireless.open(65535)
wired.open(65535)
while true do
	event, side, senderChannel, replyChannel, msg, dist = os.pullEvent('modem_message')
 print(msg)
	if side == 'back' then
		wireless.transmit(senderChannel, replyChannel, msg)
	elseif side == 'left' then
		wired.transmit(senderChannel, replyChannel, msg)
	end
end
