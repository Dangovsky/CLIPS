;;Музыкальный автомат. Имеется определенное количество пластинок,
;;автомат должен по требованию, заданному в базе фактов устанавливать
;;нужную пластинку, если такой не имеется в базе, сообщить об этом.
;;Предусмотреть счетчик времени (каждый шаг выполнения программы –
;;окончание определенного количества времени), по окончании времени
;;проигрывания пластинки она должна автоматически убираться.

(deftemplate record
  (slot name (type SYMBOL))
  (slot song (type SYMBOL)(default la_la_la))
)

(deftemplate play_record
  (slot name(type SYMBOL))
  (slot time(type NUMBER)(default 5))
  (slot played_time(type NUMBER)(default 0))
)

(deftemplate error
  (slot mes(type SYMBOL))
)

(deffacts world
  (record (name one))
  (record (name two)(song pom_pum))
  (play_record (name one))
)

(defrule stop
  (error (mes ?mes))
  =>
  (printout t ?mes crlf)
)

(defrule play
  ?play_r <- (play_record (name ?name)(time ?time)(played_time ?played_t))
  (record (name ?name)(song ?song))
  (test (< ?played_t ?time))
  =>
  (printout t ?song crlf)
  (modify ?play_r (played_time (+ ?played_t 1)))
)

(defrule check
  (play_record(time ?time)(played_time ?played_t))
  (test (= ?played_t ?time))
  =>
  (assert (error (mes tape_is_over)))
)
