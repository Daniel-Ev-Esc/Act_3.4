#lang racket


;Función principal que llama a las demás funciones, despliega las etiquetas iniciales y finales
(define (gramatica file1 file2)
  (define p1 (open-input-file file1))
  (define p2 (open-output-file file2))
  (display "<!DOCTYPE html> " p2)
  (newline p2)
  (display "<html>" p2)
  (newline p2)
  (display "<body>" p2)
  (newline p2)
  (display "</body>" p2)
  (newline p2)
  (display "</html>" p2)
  (close-output-port p2)
  (close-input-port p1)
  )