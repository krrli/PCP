; GIMP Skript das ein konfigurierbares Gitternetz im GIMP zeichnet
; Im GIMP und im Menu registrieren
(script-fu-register 
 "script-fu-grid-lines" ; Funktionsname
 "New gridlines"	; Menu Punkt
 "Illustrates the structure of a GIMP script" ; Beschreibung
 "Roger Diehl"          ; Autor
 "2017, HSLU - T&A"     ; Copyright Notiz
 "October 2017"         ; Erstellungsdatum
 ""                     ; Bild Typ des Skript - "" heisst, es muss kein Bild geladen sein
 ; aktuelle Parameter von script-fu-grid-lines
 SF-ADJUSTMENT "Image width" '(200 10 10000 1 1 0 1) ; drawable_width - default 200
 SF-ADJUSTMENT "Image height" '(200 10 10000 1 1 0 1); drawable_height - default 200
 SF-ADJUSTMENT "Spacing" '(20 2 100 1 1 0 1)         ; spacing - default 20
 SF-BRUSH "Brush" '("Circle (01)" 100.0 1 0)         ; brush - default Circle (01)
 SF-COLOR "Background" '(255 255 255)                ; background color - default black
 SF-COLOR "Foreground" '(0 0 0)                      ; foreground color - default white
 SF-TOGGLE "Transparent Layer" FALSE                 ; transparent - default FALSE
 SF-TOGGLE "Horizontal lines" TRUE                   ; horizontal - default TRUE
 SF-TOGGLE "Vertical lines" FALSE                    ; vertical - default FALSE
 SF-TOGGLE "Dashed lines" FALSE                      ; dashed - default FALSE
 )
(script-fu-menu-register "script-fu-grid-lines"
                         "<Image>/File/Create/Gridlines")

; Das eigentliche Skript
(define (script-fu-grid-lines drawable_width drawable_height spacing brush background foreground transparent horizontal vertical dashed)
  
  (gimp-context-push)
  (let*(
        ; Grundeinstellungen - Farbe, Breite, Höhe, Ebene...
        (color 0)
        (image (car(gimp-image-new drawable_width drawable_height RGB)))
        (layer (car(gimp-layer-new image drawable_width drawable_height RGBA-IMAGE "grid-layer" 100 NORMAL-MODE)))
        (layer_width (car(gimp-drawable-width layer)))
        (layer_height (car(gimp-drawable-height layer)))
        ; Anfangs- und Endpunkt einer Linie definieren x1, y1, x2, y2
        (point (cons-array 4 'double))
        (invert FALSE)
        )
    ; Gimp Kontext sezten - Transparenz, Hintergrund, Vordergrund, Pinsel, Füllfarbe, Ebene...
    (if(= transparent TRUE)
       (set! color TRANSPARENT-FILL)
       (set! color BACKGROUND-FILL)
       )
    (gimp-context-set-background background)
    (gimp-context-set-foreground  foreground)
    (gimp-context-set-brush (car brush))
    (gimp-drawable-fill layer color)
    (gimp-image-add-layer image layer -1)
    
    ; Demo zum Zeichnen einer Linie
    (define (draw_line x1 y1 x2 y2)
      ; Variablen x1, y1, x2, y2 den Anfangs- und Endpunkten der Linie zuordnen
      (aset point 0 x1)
      (aset point 1 y1)
      (aset point 2 x2)
      (aset point 3 y2)
      ; Linie zeichnen
      (gimp-paintbrush-default layer 4 point)
      )
    (cond ((and (eq? vertical FALSE) (eq? horizontal FALSE))
           (draw_line spacing spacing (- layer_width spacing) (- layer_height spacing))
           ))
    
    
    ; ab hier die Gitterlinien-Funktionen...

(define (draw_h_lines restheight finishheight)
      (cond ((> (- restheight spacing) finishheight)
            (draw_line spacing (- restheight spacing) (- layer_width spacing) (- restheight spacing))
            (draw_h_lines (- restheight spacing) finishheight))
            else (gimp-message "finished")))

  
    (define (draw_v_lines restwidth finishwidth)
          (cond ((> (- restwidth spacing) finishwidth)
                (draw_line  (- restwidth spacing) spacing (- restwidth spacing) (- layer_height spacing))
                (draw_v_lines (- restwidth spacing) finishwidth))
                else (gimp-message "finished")))

    
    (define (draw_dv_lines restwidth restheight lineheight finishwidth)
      (cond ((> (- (- restheight spacing) lineheight) 0)
             (draw_line (- restwidth spacing) (- restheight spacing) (- restwidth spacing) (- (- restheight spacing) lineheight))
             (draw_dv_lines restwidth (- (- restheight spacing) lineheight) lineheight finishwidth))
            ((> (- restwidth spacing) spacing)
                  (draw_dv_lines (- restwidth spacing) layer_height lineheight finishwidth))))
    
    (define (draw_dh_lines restwidth restheight lineheight finishwidth)
      (cond ((> (- (- restwidth spacing) lineheight) 0)
             (draw_line (- restwidth spacing) (- restheight spacing) (- (- restwidth spacing) lineheight) (- restheight spacing))
             (draw_dh_lines (- (- restwidth spacing) lineheight) restheight  lineheight finishwidth))
            ((> (- restheight spacing) spacing)
                  (draw_dh_lines layer_width (- restheight spacing) lineheight finishwidth))))

    
    (cond ((and (and (eq? vertical FALSE) (eq? horizontal TRUE)) (eq? dashed FALSE))
           (draw_h_lines layer_height 0)
           ))
    (cond ((and (and (eq? vertical TRUE) (eq? horizontal FALSE)) (eq? dashed FALSE))
           (draw_v_lines layer_width 0)
         ))
    (cond ((and (and (eq? vertical TRUE) (eq? horizontal TRUE))  (eq? dashed FALSE))
           (draw_h_lines (- layer_height spacing) spacing) 
           (draw_v_lines (- layer_width spacing) spacing)
           ))
    (cond ((and (and (eq? vertical TRUE) (eq? horizontal FALSE)) (eq? dashed TRUE))
           (draw_dv_lines layer_width layer_height (- spacing 10) 0)
         ))
    (cond ((and (and (eq? vertical FALSE) (eq? horizontal TRUE)) (eq? dashed TRUE))
           (draw_dh_lines layer_width layer_height (- spacing 10) 0)
         ))
        (cond ((and (and (eq? vertical TRUE) (eq? horizontal TRUE)) (eq? dashed TRUE))
           (draw_dh_lines layer_width layer_height spacing spacing)
           (draw_dv_lines layer_width layer_height spacing spacing)
         ))


    
    ; ...Ende der Gitterlinien-Funktionen
    
    ; Bild anzeigen
    (gimp-display-new image)
    (gimp-context-pop)
    (gimp-displays-flush)
    )
  )
