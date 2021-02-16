(local o_ten_one (require "lib/o-ten-one"))

(var splash nil)

(fn activate [set-mode]
  (var s (o_ten_one))
  (set s.onDone (fn [] (set-mode "mode-mainmenu")))
  (set splash s))

(fn draw []
  (splash:draw))

(fn update [dt set-mode]
  (when splash
    (splash:update dt)))

(fn keypressed [key set-mode]
  (splash:skip))

{:activate activate
 :draw draw
 :keypressed keypressed
 :update update}

