(fn activate []
  (print "hi after splash"))

(fn draw [])

(fn update [dt set-mode]
  (set-mode "mode-play"))

(fn keypressed [key set-mode])

{:activate activate
 :draw draw
 :keypressed keypressed
 :update update}

