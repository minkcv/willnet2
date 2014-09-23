wireless = peripheral.wrap('left')
wired = peripheral.wrap('back')
--important, channels could already be open before running this program
wireless.closeAll()
wired.closeAll()
--listen to devices 0-100
for i=0,100 do
	wireless.open(i)
	wired.open(i)
end
while true do
	event, side, channel, replyChannel, msg, dist = os.pullEvent('modem_message')
	print(msg.message)
	print('from '..replyChannel)
	print('to '..channel)
	if side == 'back' then
		wireless.transmit(channel, replyChannel, msg)
	elseif side == 'left' then
		wired.transmit(channel, replyChannel, msg)
	end
end
