wireless = peripheral.wrap('left')
wired = peripheral.wrap('back')
wireless.closeAll()
wired.closeAll()
wireless.open(rednet.CHANNEL_BROADCAST)
wired.open(rednet.CHANNEL_BROADCST)
while true do
	event, side, senderChannel, replyChannel, msg, dist = os.pullEvent('modem_message')
 print(msg)
	if side == 'back' then
		wireless.transmit(senderChannel, replyChannel, msg)
	elseif side == 'left' then
		wired.transmit(senderChannel, replyChannel, msg)
	end
end
