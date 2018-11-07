;;В школе-новостройке в каждой из двух аудиторий может находиться либо
;;кабинет информатики, либо кабинет физики. На дверях аудиторий
;;повесили шутливые таблички. На первой повесили табличку: «По крайней
;;мере, в одной из этих аудиторий размещается кабинет информатики», а на
;;второй аудитории – табличку с надписью «Кабинет физики находится в
;;другой аудитории». Проверяющему, который пришел в школу известно
;;только, что надписи либо истинны, либо обе ложны. Помогите
;;проверяющему найти кабинет информатики.

(deftemplate room
  (slot type (type SYMBOL)(default unk))
  (slot legend(type SYMBOL))
)

(deftemplate error
  (slot mes (type SYMBOL))
)

(deffacts world
  (room (type phis)(legend totally_not_physics))
  (room (type inf)(legend phis_or_inf))
)

(defrule stop
  (declare (salience -1))
  (error (mes ?mes))
  =>
  (printout t ?mes crlf)
  (halt)
)

(defrule believe
  (room (type ~phis)(legend totally_not_physics))
  (room (type phis|inf)(legend phis_or_inf))
  =>
  (assert (error(mes believe)))
)

(defrule disbelieve
  (room (type phis)(legend totally_not_physics))
  (room (type ~phis&~inf)(legend phis_or_inf))
  =>
  (assert (error(mes disbelieve)))
)

(defrule different_rooms_check
  (declare (salience 1))
  (room (type ?type)(legend totally_not_physics))
  (room (type ?type)(legend phis_or_inf))
  =>
  (assert (error (mes rooms_are_same)))
)
