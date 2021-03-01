(local a8 (require "lib/anim8/anim8"))

(local sprites {:sheet (love.graphics.newImage "assets/sheets/playerSheet.png")})

(local grid (a8.newGrid 614 564 (sprites.sheet:getWidth) (sprites.sheet:getHeight)))

(local animations {:idle (a8.newAnimation (grid "1-15" 1) 0.1)
                   :jump (a8.newAnimation (grid "1-7" 2) 0.1)
                   :run (a8.newAnimation (grid "1-15" 3) 0.1)})

(var state "idle")

(var direction 1)

(fn get-sprites []
  sprites)

(fn get-animations []
  animations)

(fn get-state []
  state)

(fn set-state [state-in]
  (set state state-in))

(fn get-direction []
  direction)

(fn set-direction [direction-in]
  (set direction direction-in))

{:get-animations get-animations
 :get-direction get-direction
 :get-sprites get-sprites
 :get-state get-state
 :set-direction set-direction
 :set-state set-state}

