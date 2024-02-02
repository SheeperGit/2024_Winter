#lang racket

(require test-engine/racket-tests)

(provide vector-add-rec vector-add-map dot-product-rec dot-product-map scalar-vector-mult
         scalar-mult transpose-rec transpose-map add mult)

; Learning objective: practice using recursion, map and apply in Racket.
; Of course, if our task was to in fact do matrix manipulation, we would choose a more appropriate
; language, such as matlab. Here our goal is to get a lot of practice using higher order procedures.

; Throughout this module we represent a vector by a list and a matrix by a list of lists of numbers.
; You may assume all list sizes are such that we have well-defined matrices and matrix operations.
; An empty matrix is the empty list '().

(define m1 '((1 0 2)
             (2 1 4)
             (-1 1 -1)))
(define m2 '((1 2 3)
             (4 5 6)
             (7 8 9)))
(define m3 '((2 2 5)
             (6 6 10)
             (6 9 8)))
(define m1tr '((1 2 -1)
               (0 1 1)
               (2 4 -1)))
(define I `((1 0 0)
            (0 1 0)
            (0 0 1)))
(define zero `((0 0 0)
            (0 0 0)
            (0 0 0)))            

;; (vector-add-rec v1 v2) -> list?
;; v1, v2: list of numbers of the same size
;; return v1 + v2
;; a simple recursive version
(define (vector-add-rec v1 v2)
  (if (empty? v1)
      empty
      (cons (+ (first v1) (first v2))
            (vector-add-rec (rest v1) (rest v2)))))

(check-expect (vector-add-rec '(1 2 3) '(-1 3 -2)) '(0 5 1))
(check-expect (vector-add-map '(0 0 0) '(0 0 0)) '(0 0 0))
(check-expect (vector-add-map '(1) '(-2)) '(-1))

; no recursion! suggestion: use map
(define (vector-add-map v1 v2)
  (map + v1 v2 ))

(check-expect (vector-add-map '(1 2 3) '(-1 3 -2)) '(0 5 1))
(check-expect (vector-add-map '(0 0 0) '(0 0 0)) '(0 0 0))
(check-expect (vector-add-map '(1) '(-2)) '(-1))

;; (dot-product v1 v2) -> number?
;; v1, v2: list of numbers of the same size
;; returns the dot product of v1 and v2
;; a simple recursive version
(define (dot-product-rec v1 v2)
  (if (empty? v1)
      0                            ; Assuming 0 for empty vectors
      (+ (* (first v1) (first v2))
         (dot-product-rec (rest v1) (rest v2)))))

(check-expect (dot-product-rec '(1 2 3) '(-1 3 -2)) -1)
(check-expect (dot-product-rec '(1 2 3) '(1 2 -3)) -4)
(check-expect (dot-product-rec '() '()) 0)
(check-expect (dot-product-rec '(2 2) '(-1 -1)) -4)

; no recursion! suggestion: use map and apply
(define (dot-product-map v1 v2)
  (apply + (map * v1 v2)))

(check-expect (dot-product-rec '(1 2 3) '(-1 3 -2)) -1)
(check-expect (dot-product-rec '(1 2 3) '(1 2 -3)) -4)
(check-expect (dot-product-rec '() '()) 0)
(check-expect (dot-product-rec '(2 2) '(-1 -1)) -4)

;(check-expect (dot-product-map '(1 2 3) '(-1 3 -2)) -1)

;; (add m1 m2) -> list?
;; m1, m2: list of list of numbers of same dimensions
;; return m1 + m2 for matrices m1, m2
;; no recursion! suggestion: use map
(define (add m1 m2)
  (map (lambda (row1 row2) (map + row1 row2)) m1 m2))
  ; Explanation: Each row of m1, m2 is passed via the outer `map`
  ;              and the inner map adds the elements of each row. 

(check-expect (add m1 m2) m3)

;; (scalar-vector-mult k v) -> list?
;; k: number?
;; v: list of number
;; return the scalar multiplication kv
;; no recursion! suggestion: use map
(define (scalar-vector-mult k v)
  (map (lambda (x) (* k x)) v))

(check-expect (scalar-vector-mult 2 '(-1 3 -2)) '(-2 6 -4))

;; (scalar-mult k m) -> list?
;; k: number
;; m: list of list of number
;; return the scalar multiplication km
;; no recursion! suggestion: use map
(define (scalar-mult k m)
  (map (lambda (row) (map (lambda (x) (* k x)) row)) m))

(check-expect (scalar-mult 2 m1)
              '((2 0 4)
                (4 2 8)
                (-2 2 -2)))


;; (transpose m) -> list?
;; m: list of list of number, non-empty
;; return the transpose of matrix m
(define (transpose-rec m)
  (if (empty? (first m))
      empty
      (cons (map first m)
            (transpose-rec (map rest m)))))
;; Explanation: `map first m` gets the first elements of each row.

(check-expect (transpose-rec m1) m1tr)
(check-expect (transpose-rec '((42))) '((42)))

; think, think, think!
; implement transpose non recursively!
; this one's tricky! suggestion: use map and apply
(define (transpose-map m)
  (apply map list m))
; Explanation: `apply map list m` applies `map list` to every row of `m`
;               (e.g., (apply map list `((1 2) (3 4))) = (map list `(1 2) `(3 4))
;               `map list` then makes a list of every list of the j-th components of the matrix
;               (e.g., (map list `(1 2) `(3 4)) = (list (list `1 `3) (list `2 `4) 
;                = '((1 3) (2 4))                                               )

(check-expect (transpose-map m1) m1tr)
(check-expect (transpose-map '((42))) '((42)))

;; (mult m1 m2) -> list?
;; m1, m2: list of list of number
;; return the matrix multiplication m1 x m2
;; no recursion: use map and the above transpose function
(define (mult m1 m2)
  (map (lambda (row1) 
         (map (lambda (col2) 
                (apply + (map * row1 col2)))
              (transpose-map m2)))
       m1))
; Explanation: Multiply every row of m1 to every transposed rows (effectively columns) of m2

(check-expect (mult m1 m2)
              '((15 18 21)
                (34 41 48)
                (-4 -5 -6)))
(check-expect (mult I m1) m1)
(check-expect (mult I m2) m2)
(check-expect (mult I zero) zero)

(module+ main
   (test)
)

