(local wf (require "lib/windfield"))

(var world nil)

(var player nil)

(var platform nil)

(var danger-zone nil)

(fn activate []
  (set world (wf.newWorld 0 800 false))
  (world:addCollisionClass "Platform")
  (world:addCollisionClass "Player")
  (world:addCollisionClass "Danger")
  (set player (world:newRectangleCollider 360 100 80 80 {:collision_class "Player"}))
  (set player.speed 240)
  (player:setFixedRotation true)
  (set platform (world:newRectangleCollider 250 400 300 100 {:collision_class "Platform"}))
  (platform:setType "static")
  (set danger-zone (world:newRectangleCollider 0 550 800 50 {:collision_class "Danger"}))
  (danger-zone:setType "static"))

(fn draw []
  (world:draw))

(fn update [dt set-mode]
  (world:update dt)
  (when player.body
    (let [(px py) (player:getPosition)]
      (when (love.keyboard.isDown "left")
        (player:setX (- px (* player.speed dt))))
      (when (love.keyboard.isDown "right")
        (player:setX (+ px (* player.speed dt)))))
    (when (player:enter "Danger")
      (player:destroy))))

(fn keypressed [key set-mode]
  (when (= key "space")
    (player:applyLinearImpulse 0 -5000)))

{:activate activate
 :draw draw
 :keypressed keypressed
 :update update}

