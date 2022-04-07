#lang racket
;A00831289 Daniel Evaristo Escalera Bonilla
;20/03/2022
;Diccionario de elementos en un archivo

;Función que despliega los datos y su definición en el archivo de salida
;Complejidad: O(n)
(define (imprime lista p2)
  ;Función que despliega uno de los datos y su definición en el archivo
  ;Complejidad: O(1)
  (define (despliega lista p2)
    (display (first lista) p2)
    (display " " p2)
    (display (second lista) p2)
    (newline p2)
    1)

  ;Función que despliega todos los elementos de un comentario
  ;Complejidad: O(n)
  (define (despliega-comentario lista p2)
    (if (null? lista)
        (newline p2)
        (display (car lista) p2))
    (if (null? lista)
        null
        (display " " p2))
    (if (null? lista)
        null
        (despliega-comentario (cdr lista) p2)))

  ;Función que despliega elementos complejos como comentarios o listas
  ;Complejidad: O(n)
  (define (despliega-long lista p2)
    (if (null? lista)
        null
        (if (equal? (first lista) '//)
            (despliega-comentario lista p2)
            (if (<= (length lista) 2)
                (despliega lista p2)
                (+ (despliega (append (list(car lista)) (list (cadr lista))) p2) (despliega-long (cddr lista) p2)))))
    1)
  
  (if (empty? lista)
      0
      (if (<= (length (car lista)) 2)
          (+ (despliega (car lista) p2) (imprime (cdr lista) p2))
          (+ (despliega-long (car lista) p2) (imprime (cdr lista) p2)))))

;Función que identifica números y si son enteros o flotantes (Reales)
;Complejidad: O(1)
(define (numero atomo)
  (if (exact-integer? atomo)
      (list atomo "Entero")
      (list atomo "Real")))

;Función que identifica los elementos dentro de una lista
;Complejidad: O(n)
(define (lista atomo p1)
  (if (null? atomo)
      (list ")" "Parentesis que cierra")
      (append (convierte (car atomo) p1) (lista (cdr atomo) p1))))

;Función que concatena comentarios y les aplica la definición
;Complejidad: O(n)
(define (comentario atomo p1)
  (if (or (equal? (peek-char p1) #\newline) (eof-object? (peek-char p1)))
      (append (list atomo) (list "Comentario"))
      (append (list atomo) (comentario (read p1) p1))))

;Función que identifica operadores y variables
;Complejidad: O(1)
(define (variable atomo)
  (if (equal? atomo '+)
      (list atomo "Suma")
      (if (equal? atomo '-)
          (list atomo "Resta")
          (if (equal? atomo '/)
              (list atomo "División")
              (if (equal? atomo '*)
                  (list atomo "Multiplicación")
                  (if (equal? atomo '=)
                      (list atomo "Asignación")
                      (if (equal? atomo '^)
                          (list atomo "Potencia")
                          (list atomo "Variable"))))))))

;Función que identifica la naturaleza de un elemento y le da una definición
;Complejidad: Mejor caso O(1) Peor caso: O(n)
(define (convierte atomo p1)
  (if (number? atomo)
      (numero atomo)
      (if (list? atomo)
          (append (list "(" "Parentesis que abre") (lista atomo p1))
          (if (equal? atomo '//)
              (comentario atomo p1)
              (variable atomo)))))

;Función que recorre todos los elementos de un archivo para definirlos
;Complejidad: O(n)
(define (recorre-2 p1)
  (if (eof-object? (peek-char p1))
      '()
      (append (list(convierte (read p1) p1)) (recorre-2 p1))))

;Función que recorre un archivo, almacena sus elementos y los depliega en oteo archivo con sus definiciones
;Complejidad: O(n)
(define (recorre file1 file2)
  (define p1 (open-input-file file1))
  (define p2 (open-output-file file2))
  (define lista (recorre-2 p1))
  (display lista)
  (define cantidad (imprime lista p2))
  (display "Cantidad de Tokens: " p2)
  (display cantidad p2)
  (close-output-port p2)
  (close-input-port p1)
  )