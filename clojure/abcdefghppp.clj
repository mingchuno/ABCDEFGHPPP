; http://m2.hkgolden.com/view.aspx?message=6307521&type=SW&page=1
; binc

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

(prn (test-form))

;; $ java -cp /opt/clojure/clojure-1.8.0.jar clojure.main abcdefghppp.clj 
;; ([85 46 39 72 111] [86 54 32 79 111] [90 27 63 48 111] [90 63 27 84 111] [95 27 68 43 111])
