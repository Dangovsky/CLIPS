;;Закачка файлов. Имеется список файлов в очереди закачки и их размер. За
;;каждый шаг программы закачивается определенное количество байт (квота).
;;Если количество байт оставшееся для полного скачивания файла меньше,
;;чем квота, то остаток должен передаваться другому файлу.

(deftemplate file
  (slot name (type SYMBOL))
  (slot size (type NUMBER))
  (slot loadedSize(type NUMBER)(default 0))
  (slot ready(type SYMBOL)(default not))
)

(deftemplate quota
  (slot size(type NUMBER))
)

(deffacts world
  (file (name one)(size 10)(loadedSize 10))
  (file (name two)(size 10))
  (quota (size 2))
)

(defrule stop
  (not (file (ready not)))
  =>
  (halt)
)

(defrule setReady
  (declare (salience 99))
  ?file <- (file (size ?size)(loadedSize ?size)(ready not))
  =>
  (modify ?file (ready yes))
)

(defrule load
  ?file <- (file (size ?size)(loadedSize ?lSize)(ready not))
  (quota (size ?quota))
  =>
  (modify ?file(loadedSize (+ ?lSize ?quota)))
)
