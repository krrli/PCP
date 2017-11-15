;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname prolog-uebung1-sw05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ------------ uebung 1 ------------
; 1a)
;(42 + (25 - 3 * 4)) / 11
(/(+ 42 (- 25 (* 3 4))) 11)

;(24 + 32) / 7 + 3 * (17 - 15)
; 1b)
; aso so: ((24 +32) / 7) + (3 * (17-15)) 
(+ (/ (+ 24 32) 7) (* 3 (- 17 15)))

; 1c)
;34428 / 38 - (1103 - 197)
(- (/ 34428 38) (- 1103 197))

; ------------ uebung 2 ------------
(/ 1 (+ 1 1))
(/ 1 (+ 1 (/ 1 (+ 1 1))))
(/ 1 (+ 1 (/ 1 (+ 1 (/ 1 (+ 1 1))))))


; ------------ uebung 3 ------------
; sqr: square root
; sqrt: square
; d = (a^2 + b^2)^(1/2)
(define (diagonale l b) (sqrt (+ (sqr l) (sqr b))))
; (diagonale 3 4)


; ------------ uebung 4 ------------
; 4a)
;-(10a + 20b - 40c) - (-(7a - 14c) - (-(15b - 4c) - (27a – 5b)))

(define (komplex a b c)
  (-
   (* -1 (- (+ (* 10 a) (* 20 b)) (* 40 c)))
   (* -1 (- (* 7 a) (* 14 c)))
   (* -1 (- (* -15 b) (* 4 c) ))
   (- (* 27 a) (* 5 b)))
  )

; (komplex 2 5 20)

; 4b)
; vereinfachen?
;(komplex 0 0 1)
;(komplex 0 1 0)
;(komplex 1 0 0)

; ------------ uebung 5 ------------
; 5a)
(define (checkTemp temperatur) (cond
    ((> temperatur 35) "heiss")
    ((> temperatur 25) "warm")
    ((> temperatur 15) "mittel")
    (else "kalt"))
  )

(define (checkTempII temperatur) (cond
                                   ((> temperatur 15) "mittel")
                                   ((> temperatur 25) "warm")
                                   ((> temperatur 35) "heiss")
                                   (else "kalt"))
  )

; Ausdrücke dürfen nicht getauscht werden!
; weil (checkTempII 30) ==> 30 ist grösser 15 UND grösser 25.
; beim ersten Mal true wird cond verlassen.

;5b)
(define (checkTeilbar zahl)
  (cond
    ((zero? (remainder zahl 2)) "durch 2 teilbar")
    ((zero? (remainder zahl 3)) "durch 3 teilbar")
    (else "weder durch 2 noch durch 3 teilbar"))
  )

(define (checkTeilbarII zahl)
  (cond
    ((zero? (remainder zahl 3)) "durch 3 teilbar")
    ((zero? (remainder zahl 2)) "durch 2 teilbar")    
    (else "weder durch 2 noch durch 3 teilbar"))
  )

; nicht dieselbe ausgabe ==> semantik geändert!
; (checkTeilbarII 6)
; zuerst durch 3 teilbar, weils halt durch 3 teilbar ist.

; ------------ uebung 6 ------------

(define (toll total-weight)
  (cond
    ((not (number? total-weight)) "Eingabe muss Zahl sein!")
    ((<= total-weight 0) "Zahl muss größer 0 sein!")
    ((<= total-weight 1000) 20)
    ((<= total-weight 2000) 30)
    ((<= total-weight 5000) 50)
    ((<= total-weight 10000) 100)
    (else 250)))

(define (tollVerchert total-weight)
  (cond
    ((not (number? total-weight)) "Eingabe muss Zahl sein!")
    ((<= total-weight 0) "Zahl muss größer 0 sein!")
    ((<= total-weight 10000) 100)
    ((<= total-weight 1000) 20)
    ((<= total-weight 2000) 30)
    ((<= total-weight 5000) 50)
    (else 250)))

; 6a): prüfen, ob zahl eine nummer ist. falls nicht, "Eingabe muss Zahl sein" ausgeben.
; 6b): Sonst gibt (tollVerchert 600) auch 100. der erste Wert, bei dem true zurückkommt, wird genommen!
; c): Wenn sich die conditions gegenseitig ausschliessen, kann man das machen:

(define (checkGerade zahl)
  (cond
    ((zero?  (remainder zahl 2)) "Die Zahl ist gerade")
    ((not(zero? (remainder zahl 2))) "Die Zahl ist ungerade")
  )
 )


; ------------ uebung 7 ------------

(define (doubleCheck a b)
  (* (cond
       ((> a b) a)
       ((< a b) b)
       (else -1)
     )
     (+ a 1)
  )
)

; 7a) so wies in der aufgabe steht: nein, a und b sind nicht definiert
; 7b)
; (doubleCheck 2 3)
; gibt 9.
; (doubleCheck 3 2)
; gibt 12
; (doubleCheck 3 3)
; gibt -4

; ==> Ausdruck gültig, a und b müssen halt definiert sein.


; ------------ uebung 8 ------------
(define-struct point (x y))
;(define (point-scaling p scale)
;  (make-point (* (point-x p) scale)
;              (* (point-y p) scale))
;  )

; (define p (make-point 2 3))
; (define q (point-scaling p 2.5))
; (point-x q)
; (point-y q)


(define (abstand p)
  (sqrt( + (sqr (point-x p)) (sqr(point-y p)))))

; ------ hier: -----
; zum usgä:
; (define p (make-point 3 4))
; (abstand p)

; ------------ uebung 9 ------------
(define-struct man(alter geschlecht oberschaenkellaengi))
(define schnauz (make-man 45 "m" 50))        ; definition daten
(define keiSchnauz (make-man 30 "w" 49))     ; definition daten
(define oepis(make-man 35 "mw" 30))          ; definition daten

(define (blength m)
  (cond
    ((string=? (man-geschlecht m) "m") ; du besch es männli
     (- (+ 69.089 (* 2.238 (man-oberschaenkellaengi m))) (* 0.06 (man-alter m)))
     )
    ; weitere condition: >= 30 gilt diese berechnung, für <30: 0.06cm pro jahr nicht abziehen
    ((string=? (man-geschlecht m) "w") ; du besch es wiibli
     (- (+ 61.412 (* 2.317 (man-oberschaenkellaengi m))) (* 0.06 (man-alter m)))
     )
    (else "don't know"))) ; bi der weiss mers ned

; mit "man-oberschaenkellaengi m" wird die oberschenkellänge des man objekts geholt (m as param)

; (blength schnauz)
; (blength keiSchnauz)
; (blength oepis)
