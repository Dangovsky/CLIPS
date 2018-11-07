;;Виктор, Роман, Леонид и Сергей заняли на олимпиаде по физике четыре
;;первых места. Когда их спросили о распределении мест, они дали три
;;ответа:
;;a) Сергей – первый, Роман – второй;
;;b) Сергей – второй, Виктор – третий;
;;c) Леонид – второй, Виктор – четвертый.
;;Известно, что в каждом ответе только одно утверждение истинно. Как
;;распределились места?

(deftemplate boy
  (slot name(type SYMBOL))
  (slot place(type NUMBER)(default 0))
)

(deffacts world
  (boy (name Sergey))
  (boy (name Roman))
  (boy (name Viktor))
  (boy (name Leonid))
)

(defrule stop
  (boy (name Sergey)(place ~0))
  (boy (name Roman)(place ~0))
  (boy (name Viktor)(place ~0))
  (boy (name Leonid)(place ~0))
  =>
  (halt)
)

(defrule first_first
  ?serg <- (boy (name Sergey)(place 0))
  (boy (name Roman)(place ~2))
  =>
  (modify ?serg (place 1))
)

(defrule second_second
  ?vik <- (boy (name Viktor)(place 0))
  (boy (name Sergey)(place ~2))
  =>
  (modify ?vik (place 3))
)

(defrule third_first
  ?leo <- (boy (name Leonid)(place 0))
  (boy (name Viktor)(place ~4))
  =>
  (modify ?leo (place 2))
)

(defrule roman
  ?rom <- (boy (name Roman)(place 0))
  =>
  (modify ?rom (place 4))
)
