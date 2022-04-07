#lang racket

(define (libreria atomo p2)
  (display "<span style='color:yellow'>" p2)
  (display atomo p2)
  (display "</span>" p2))

(define (coincide atomo p1 p2)
  (if (regexp-match-exact? #rx"<(.*)>" atomo)
      (libreria atomo p2)
      null))


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