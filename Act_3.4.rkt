#lang racket

;Función de color en html en librerias
(define (libreria atomo p2)
  (display "<span style='color:yellow'>" p2)
  (display (elimina atomo) p2)
  (display "</span>" p2))

(define (elimina atomo) 
  (substring atomo 1 (-(string-length atomo)1))) 

;Función de color en html en ciclos
(define (ciclo atomo p2)
  (display "<span style='color:purple'>" p2)
  (display atomo p2)
  (display "</span>" p2))

;Función de color en html en variables
(define (variables atomo p2)
  (display "<span style='color:pink'>" p2)
  (display atomo p2)
  (display "</span>" p2))
  
;Función que identifica los elementos
(define (coincide atomo p1 p2)
  (if (regexp-match-exact? #rx"<(.*)>" atomo)
      (libreria atomo p2)
      (if (regexp-match-exact? #rx"for|while" atomo)
          (ciclo atomo p2)
          (if (regexp-match #rx"int|bool|float|string" atomo)
              (variables atomo p2)
              null))))

;Función que recorre el archivo
(define (recorre p1 p2)
  (if (eof-object? (peek-char p1))
      '()
      (append (list(coincide (symbol->string (read p1)) p1 p2)) (recorre p1 p2))))

;Función principal que llama a las demás funciones, despliega las etiquetas iniciales y finales
(define (compila file1 file2)
  (define p1 (open-input-file file1))
  (define p2 (open-output-file file2))
  (display "<!DOCTYPE html> " p2)
  (newline p2)
  (display "<html>" p2)
  (newline p2)
  (display "<body>" p2)
  (newline p2)
  (display "<span style='color:red'>Texto</span>" p2)
  (newline p2)
  (recorre p1 p2)
  (display "</body>" p2)
  (newline p2)
  (display "</html>" p2)
  (close-output-port p2)
  (close-input-port p1)
  )