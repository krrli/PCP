;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname prolog-uebung2-sw06) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ------------ uebung 3 ------------
; a)
; (g (list 1 2 3 4 5 6))

(define (f liste)
  (if (empty? liste) empty
      (if
       (empty? (rest liste)) (first liste)
       (f (rest liste)))
      )
  )

; rest = tail @prolog
; wenn liste leer: leer zurückgeben
; wenn rest der liste leer: erstes element der liste zurückgeben
; sonst rekursiver aufruf (f(rest liste)) mit rest

; b)
; (g (list 1 2 3 4 5 6))

(define (g liste)
  (cond
    ((empty? liste) empty)
    ((empty? (rest liste)) (first liste))
    (else
     (if (> (first liste) (g (rest liste))) (first liste)
         (g (rest liste))))))

; wenn liste leer: leer zurückgeben
; wenn rest der liste leer: der erste teil der liste zurückgeben
; sonst:
;    wenn der erste teil der liste (head) grösser als der rest der liste: der erste teil der liste ausgeben
;    sonst sich selbst aufrufen mit rest der liste.
; ==> das grösste element der liste finden

; ------------ uebung 4 ------------
; (delete 3 (list 1 2 3 4))
; (delete 'c '(a b c d))
; (delete 'f '(a b c d))
; (delete 'f empty)
; (delete 'f (list 1 2 3 4))

(define (delete item a-list)