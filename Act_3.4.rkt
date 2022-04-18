#lang racket

;Función de color en html de librerias
(define (libreria atomo p2)
  (display "<span style='color:orange'>&lt" p2)
  (display (elimina atomo) p2)
  (display "&gt </span><br>" p2))

(define (elimina atomo) 
  (substring atomo 1 (-(string-length atomo)1))) 

;Función de color en html de ciclos
(define (ciclo atomo p2)
  (display "<span style='color:purple'>" p2)
  (display atomo p2)
  (display "</span>&nbsp;" p2))

;Función de color en html de variables
(define (variables atomo p2)
  (display "<span style='color:pink'>" p2)
  (display atomo p2)
  (display "</span>&nbsp;" p2))

;Función de color en html de operadores
(define (operadores atomo p2)
  (display "<span style='color:blue'>" p2)
  (display atomo p2)
  (display "</span>&nbsp;" p2))

;Función de salto de línea en html
(define (puntoComa atomo p2)
  (display "<span>" p2)
  (display atomo p2)
  (display "</span><br>" p2))

;Función de código restante en html 
(define (restante atomo p2)
  (display "<span>" p2)
  (display atomo p2)
  (display "</span>&nbsp;" p2))

;Función que despliega comentarios
(define (comentario atomo p1 p2)
  (display "<span style='color:green'>" p2)
  (display "</span>&nbsp;" p2)
  )

;Función que identifica los elementos
(define (coincide atomo p1 p2)
  (if (regexp-match-exact? #rx"<(.*)>" atomo)
      (libreria atomo p2)
      (if (regexp-match-exact? #rx"for|while" atomo)
          (ciclo atomo p2)
          (if (regexp-match-exact? #rx"int|bool|float|string" atomo)
              (variables atomo p2)
              (if (regexp-match-exact? #rx"//.*" atomo)
                  (comentario atomo p1 p2)
                  (if (equal? atomo "+")
                      (operadores atomo p2)
                      (if (equal? atomo "*")
                          (operadores atomo p2)
                          (if (regexp-match-exact? #rx";" atomo)
                              (puntoComa atomo p2)
                              (if (regexp-match #rx"-|/|%|&|=|<|>|!" atomo)
                                  (operadores atomo p2)
                                  (restante atomo p2))))))))))

;Funicón que revisa si es un symbolo o numero.
;Falta agregar la parte de comentarios? y list?
(define (is-symbol atomo)
  (if (symbol? atomo)
      (symbol->string atomo)
      (number->string atomo)))


;Función que recorre el archivo
(define (recorre p1 p2)
  (if (eof-object? (peek-char p1))
      '()
      (if (equal? (peek-char p1) #\#)
          (display "hola")
          (append (list(coincide (is-symbol (read p1)) p1 p2)) (recorre p1 p2)))))

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
  ;(display "<span style='color:red'>Texto</span>" p2)
  (newline p2)
  (recorre p1 p2)
  (display "</body>" p2)
  (newline p2)
  (display "</html>" p2)
  (close-output-port p2)
  (close-input-port p1)
  )
