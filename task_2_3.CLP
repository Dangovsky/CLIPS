;;Аня, Вика и Сергей решили пойти в кино. Учитель, хорошо знавший ребят, высказал предложения:
;;Аня пойдет в кино только тогда, когда пойдут Вика и Сергей;
;;Аня и Сергей пойдут в кино вместе или же оба останутся дома;
;;чтобы Сергей пошел в кино, необходимо, чтобы пошла Вика.
;;Когда ребята пошли в кино, оказалось, что учитель немного ошибся: из трех его утверждений истинными оказались только два. Кто из ребят пошел в кино?

(deftemplate child
  (slot name(type SYMBOL))
  (slot cinema(type NUMBER)(default -1))
)

(deffacts world
  (child (name Anna))
  (child (name Sergey))
  (child (name Vika))
)

(defrule stop
  (child (name Anna)(cinema ~-1))
  (child (name Sergey)(cinema ~-1))
  (child (name Vika)(cinema ~-1))
  =>
  (halt)
)

(defrule third_rule_false
  ?vika <- (child (name Vika)(cinema -1))
  ?serg <- (child (name Sergey)(cinema -1))
  =>
  (modify ?vika (cinema 1))
  (modify ?serg (cinema 0))
)

(defrule no_first_rule_true
  (child (name Vika)(cinema ?v_cin))
  (child (name Sergey)(cinema ?s_cin))
  (or
    (test (= ?v_cin 0))
    (test (= ?s_cin 0))
  )
  ?anna <- (child (name Anna)(cinema -1))
  =>
  (modify ?anna (cinema 0))
)

(defrule second_rule_test
  (declare (salience 99))
  (child (name Anna)(cinema ?cin))
  (child (name Sergey)(cinema ?cin))
  =>
  (printout t second_rule_true crlf)
)
