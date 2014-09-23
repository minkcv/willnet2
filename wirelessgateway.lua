wireless = peripheral.wrap('left')
wired = peripheral.wrap('back')
--important, channels could already be open before running this program
wireless.closeAll()
wired.closeAll()
--listen to everything
--note: this causes sender id to be lost
wireless.open(65533)
wired.open(65533)
while true do
	event, side, channel, replyChannel, msg, dist = os.pullEvent('modem_message')
	print(msg.message)
	print('from'..replyChannel)
	if side == 'back' then
		wireless.transmit(65535, replyChannel, msg)
	elseif side == 'left' then
		wired.transmit(65535, replyChannel, msg)
	end
end
