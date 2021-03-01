(local wf (require "lib/windfield"))

(var world nil)

(var player nil)

(local player-entity (require "entities/player"))

(var player-animation (. (player-entity.get-animations) (player-entity.get-state)))

(var platform nil)

(var danger-zone nil)

(fn activate []
  (set world (wf.newWorld 0 800 false))
  (world:setQueryDebugDrawing true)
  (world:addCollisionClass "Platform")
  (world:addCollisionClass "Player")
  (world:addCollisionClass "Danger")
  (set player (world:newRectangleCollider 360 100 40 100 {:collision_class "Player"}))
  (set player.speed 240)
  (player:setFixedRotation true)
  (set platform (world:newRectangleCollider 250 400 300 100 {:collision_class "Platform"}))
  (platform:setType "static")
  (set danger-zone (world:newRectangleCollider 0 550 800 50 {:collision_class "Danger"}))
  (danger-zone:setType "static"))

(fn draw []
  (world:draw)
  (let [(px py) (player:getPosition)]
    (player-animation:draw (. (player-entity.get-sprites) "sheet") px py nil (* 0.25 (player-entity.get-direction)) 0.25 130 300)))

(fn update [dt set-mode]
  (world:update dt)
  (when player.body
    (let [col-x (- (player:getX) 20)
          col-y (+ (player:getY) 50)
          colliders (world:queryRectangleArea col-x col-y 50 4 ["Platform"])]
      (if (= (length colliders) 0)
          (player-entity.set-state "jump")
          (player-entity.set-state "idle")))
    (let [(px py) (player:getPosition)]
      (when (love.keyboard.isDown "left")
        (player-entity.set-state "run")
        (player-entity.set-direction -1)
        (player:setX (- px (* player.speed dt))))
      (when (love.keyboard.isDown "right")
        (player-entity.set-state "run")
        (player-entity.set-direction 1)
        (player:setX (+ px (* player.speed dt)))))
    (when (player:enter "Danger")
      (player:destroy)))
  (set player-animation (. (player-entity.get-animations) (player-entity.get-state)))
  (player-animation:update dt))

(fn keypressed [key set-mode]
  (when (= key "space")
    (let [col-x (- (player:getX) 20)
          col-y (+ (player:getY) 50)
          colliders (world:queryRectangleArea col-x col-y 50 4 ["Platform"])]
      (when (> (length colliders) 0)
        (player:applyLinearImpulse 0 -5000)))))

(fn mousepressed [x y button istouch presses set-mode])

{:activate activate
 :draw draw
 :keypressed keypressed
 :mousepressed mousepressed
 :update update}

