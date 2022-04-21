#lang racket

#|
Daniel Evaristo Escalera Bonilla A00831289
Carmina López Palacios A00830265
Alexa Geraldine Torres Charles A01568178
21/04/2022

El programa se ejecuta con el siguiente comando:
(compila "barn.cpp" "salida.html")

Resaltador de sintaxis para el lenguaje C++
|#

;Función de color en html de ciclos
(define (ciclo atomo p2)
  (display "<span style='color:purple'>" p2)
  (display atomo p2)
  (display "</span>" p2)
  (newline p2))

;Función de color en html de variables
(define (variables atomo p2)
  (display "<span style='color:pink'>" p2)
  (display atomo p2)
  (display "</span>" p2)
  (newline p2))

;Función de color en html de operadores
(define (operadores atomo p2)
  (display "<span style='color:blue'>" p2)
  (display atomo p2)
  (display "</span>" p2)
  (newline p2))

;Función de código restante en html 
(define (restante atomo p2)
  (display "<span style='color:cyan'>" p2)
  (display atomo p2)
  (display "</span>" p2)
  (newline p2))

;Función que despliega comentarios
(define (comentario atomo p1 p2)
  (display "<span style='color:green'>" p2)
  (display atomo p2)
  (display (read-line p1) p2)
  (display "</span><br>" p2)
  (newline p2))

;Función de palabras reservadas en html 
(define (reservadas atomo p2)
  (display "<span style='color:#D9DD92'>" p2)
  (display atomo p2)
  (display "</span>" p2)
  (newline p2))

;Función que identifica los elementos
(define (coincide atomo p1 p2)
  (if (null? atomo)
      null
      (if (regexp-match-exact? #rx"if|else|while" atomo)
          (ciclo atomo p2) 
          (if (regexp-match-exact? #rx"int|bool|float|string" atomo)
              (variables atomo p2)
              (if (regexp-match-exact? #rx"//.*" atomo)
                  (comentario atomo p1 p2)
                  (if (equal? atomo "+")
                      (operadores atomo p2)
                      (if (equal? atomo "*")
                          (operadores atomo p2)
                          (if (regexp-match #rx"-|/|%|&|=|<|>|!" atomo)
                              (operadores atomo p2)
                              (if (regexp-match #rx"break|return" atomo)
                                  (reservadas atomo p2)
                                  (restante atomo p2))))))))))

;Funciones auxiliares para desplegar paréntesis
(define (abrir-par p2)
  (display "<span style='color:white'>(</span>" p2)
  (newline p2)
  null)

(define (cerrar-par p2)
  (display "<span style='color:white'>)</span>" p2)
  (newline p2)
  null)


;Función que despliega los elementos de una lista
(define (despliega-lista atomo p1 p2)
  (if (null? atomo)
      (cerrar-par p2)
      (append (list(coincide (is-symbol (car atomo) p1 p2) p1 p2)) (despliega-lista (cdr atomo) p1 p2)))
  null)

(define (despliega-corchete-2 p1 p2)
  (display "<span style='color:white'>}</span><br>" p2)
  (newline p2)
  (read-char p1)
  null)

(define (despliega-corchete-1 p1 p2)
  (display "<span style='color:white'>{</span><br>" p2)
  (newline p2)
  (read-char p1)
  null)

;Funicón que revisa si es un symbolo o numero.
;Falta agregar la parte de list?
(define (is-symbol atomo p1 p2)
  (if (symbol? atomo)
      (symbol->string atomo)
      (if (number? atomo)
          (number->string atomo)
          (append (abrir-par p2) (despliega-lista atomo p1 p2)))))

;Función que despliega librerías
(define (libreria p1 p2)
  (display "<span style='color:#D9DD92'> #include </span> <span style='color:orange'>&lt" p2)
  (read-char p1)
  (read p1)
  (display (elimina (symbol->string (read p1))) p2)
  (display "&gt </span><br>" p2)
  (newline p2))

(define (elimina atomo) 
  (substring atomo 1 (-(string-length atomo)1))) 


(define (end-of-code p1 p2)
  (display "<span style='color:white'>; </span>&nbsp" p2)
  (read-char p1)
  (display "</span><br>" p2))

;Función que recorre el archivo
(define (recorre p1 p2)
  (if (eof-object? (peek-char p1))
      '()
      (if (equal? (peek-char p1) #\#)
          (append (list(libreria p1 p2) (recorre p1 p2)))
          (if (equal? (peek-char p1) #\;)
              (append (list (end-of-code p1 p2) (recorre p1 p2)))
              (if (equal? (peek-char p1) #\{)
                  (append (list (despliega-corchete-1 p1 p2) (recorre p1 p2)))
                  (if (equal? (peek-char p1) #\})
                      (append (list (despliega-corchete-2 p1 p2) (recorre p1 p2)))
                      (append (list(coincide (is-symbol (read p1) p1 p2) p1 p2)) (recorre p1 p2))))))))

;Función principal que llama a las demás funciones, despliega las etiquetas iniciales y finales
(define (compila file1 file2)
  (define p1 (open-input-file file1))
  (define p2 (open-output-file file2))
  (display "<!DOCTYPE html> " p2)
  (newline p2)
  (display "<html>" p2)
  (newline p2)
  (display "<body style='background-color:black;'>" p2)
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
