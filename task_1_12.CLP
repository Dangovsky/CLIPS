;;Процесс сборки изделия. Имеются детали, которые участвуют в сборке
;;деталей. Каждая деталь должна использоваться в определенной
;;последовательности. Когда изделии собрано, автомат должен переходить к
;;сборке нового изделия. Процесс прекращается только тогда, когда сборка не
;;возможна (закончились или не хватает какой-либо детали).

(deftemplate part
  (slot name (type SYMBOL))
  (slot number (type NUMBER))
)

(deftemplate whole
  (slot name (type SYMBOL))
  (slot state (type SYMBOL)(default dont_exist))
)

(deftemplate error
  (slot mes(type SYMBOL))
)

(deffacts world
  (part (name a)(number 1))
  (part (name b)(number 1))
  (part (name c)(number 2))
  (part (name d)(number 2))
  (part (name e)(number 2))
  (part (name f)(number 1))
  (part (name g)(number 1))
  (whole(name a))
  (whole(name b))
  (whole(name c))
)

(defrule stop
  (error (mes ?mes))
  =>
  (printout t ?mes crlf)
  (halt)
)

(defrule make_first_half
  ?part <- (part (name ?)(number 1))
  ?whole <- (whole (name ?)(state dont_exist))
  =>
  (retract ?part)
  (modify ?whole  (state half_way))
)

(defrule make_second_half
  ?part <- (part (name ?)(number 2))
  ?whole <- (whole (name ?)(state half_way))
  =>
  (retract ?part)
  (modify ?whole (state exist_!))
)

(defrule error_handler_1
  (whole (name ?)(state half_way))
  (not (part (name ?)(number 2)))
  =>
  (assert (error(mes no_second_part)))
)

(defrule error_handler_2
  (part (name ?)(number 1))
  =>
  (assert (error(mes missed_first_part)))
)

(defrule error_handler_3
  (part (name ?)(number 2))
  =>
  (assert (error(mes missed_second_part)))
)

(defrule error_handler_4
  ?whole <- (whole (name ?)(state dont_exist))
  (not (part (name ?)(number 1)))
  =>
  (assert (error(mes no_first_part)))
)
