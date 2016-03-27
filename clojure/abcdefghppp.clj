; http://m2.hkgolden.com/view.aspx?message=6307521&type=SW&page=1
; binc

(require '[clojure.pprint :refer [print-table]])

(defn make-seq []
  (for [x (range 10) 
        y (range 10) 
        :when (and (not= x y) (not= x 0))]
    (+ (* 10 x) y)))

(defn test-form []
  (let [mq (make-seq)]
    (for [ab mq
          cd mq
          gh mq
          :let [ef (- ab cd) 
                ppp (+ ef gh) 
                form [ab cd ef gh ppp]]
          :when (and (= ppp 111)
                     (= 9 (->> form (apply str) set count)))]
      form)))

(print-table
 (map #(zipmap ["AB" "CD" "EF" "GH" "PPP"] %) (test-form)))
