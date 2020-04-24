turtle.select(1)
turtle.refuel()
turtle.select(2)
refill = false
dist = 0
torch = 0
while true do
    if turtle.getFuelLevel() > 40 and not refill then
        slot = turtle.getSelectedSlot()
        while turtle.getItemCount(slot) < 1 and not refill do
            slot = slot + 1
            if slot == 16 then
                refill = true
                slot = 1
            end
            turtle.select(slot)
        end
        if not refill then
            turtle.forward()
            turtle.placeDown()
            dist = dist + 1
            torch = torch + 1
            if torch > 8 then
                turtle.select(16)
                turtle.turnRight()
                turtle.turnRight()
                turtle.place()
                turtle.select(slot)
                turtle.turnRight()
                turtle.turnRight()
                torch = 0
            end
        end
    else
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
        i = 0
        while i < dist do
            turtle.forward()
            i = i + 1
        end
    end
end
