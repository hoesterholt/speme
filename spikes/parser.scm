(define (f p . flags)
  (if (null? flags)
     p
     (if (eq? (car flags) 'ok)
       (list 'boe p)
       (list 'beh p))))



