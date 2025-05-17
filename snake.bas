clear screen
screenW = 640
screenH = 480
cellSize = 20
cols = screenW / cellSize
rows = screenH / cellSize

open window screenW, screenH

dim snakeX(100), snakeY(100)
length = 5
dir$ = "right"
score = 0

rem Start in center
for i = 1 to length
  snakeX(i) = int(cols / 2) - i
  snakeY(i) = int(rows / 2)
next i

foodX = int(ran(cols))
foodY = int(ran(rows))

sub drawCell(x, y)
  fill rectangle x * cellSize, y * cellSize, (x + 1) * cellSize, (y + 1) * cellSize
end sub

sub eraseCell(x, y)
  clear fill rectangle x * cellSize, y * cellSize, (x + 1) * cellSize, (y + 1) * cellSize
end sub

do
  drawCell(foodX, foodY)
  eraseCell(snakeX(length), snakeY(length))

  for i = length to 2 step -1
    snakeX(i) = snakeX(i - 1)
    snakeY(i) = snakeY(i - 1)
  next i

  if (dir$ = "right") then
    snakeX(1) = snakeX(1) + 1
  elsif (dir$ = "left")
    snakeX(1) = snakeX(1) - 1
  elsif (dir$ = "up")
    snakeY(1) = snakeY(1) - 1
  elsif (dir$ = "down")
    snakeY(1) = snakeY(1) + 1
  endif

  drawCell(snakeX(1), snakeY(1))

  if (snakeX(1) = foodX and snakeY(1) = foodY) then
    length = length + 1
    score = score + 1
    snakeX(length) = snakeX(length - 1)
    snakeY(length) = snakeY(length - 1)
    foodX = int(ran(cols))
    foodY = int(ran(rows))
  endif

  k$ = inkey$(0.005)
  if (k$ <> "") then
    if (k$ = "w" and dir$ <> "down") dir$ = "up"
    if (k$ = "s" and dir$ <> "up") dir$ = "down"
    if (k$ = "a" and dir$ <> "right") dir$ = "left"
    if (k$ = "d" and dir$ <> "left") dir$ = "right"
  endif

  if (snakeX(1) < 0 or snakeX(1) >= cols or snakeY(1) < 0 or snakeY(1) >= rows) then
    break
  endif

  sleep 0.2
loop

rem Game over display
clear window
text screenW/2 - 30, screenH/2 - 20, "GAME OVER!", "cc"
text screenW/2 - 30, screenH/2 + 10, "Score: " + str$(score), "cc"
text screenW/2 - 100, screenH/2 + 40, "Press the ENTER key to exit."

inkey$
close window
exit
