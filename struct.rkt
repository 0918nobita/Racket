#lang racket/base

(struct book (title author))

(define book1 (book "Book" "Author"))

(displayln (book-title book1))  ; => Book
(displayln (book-author book1)) ; => Author
