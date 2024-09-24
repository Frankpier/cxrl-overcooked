

(deffunction goal-assert-move-plate-from-sink-to-counter(?order)
    (bind ?goal (assert (goal 
                            (class MOVE-PLATE-FROM-SINK-TO-COUNTER) 
                            (id (sym-cat MOVE-PLATE-FROM-SINK-TO-COUNTER- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order)
                            (assigned-to nil) (points ?*POINTS-MOVE-PLATE-FROM-SINK-TO-COUNTER*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-put-cooked-beef-on-plate(?order)
    (bind ?goal (assert (goal 
                            (class PUT-COOKED-BEEF-ON-PLATE) 
                            (id (sym-cat PUT-COOKED-BEEF-ON-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order)
                            (assigned-to nil) (points ?*POINTS-PUT-COOKED-BEEF-ON-PLATE*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-put-bun-on-plate(?order)
    (bind ?goal (assert (goal 
                            (class PUT-BUN-ON-PLATE) 
                            (id (sym-cat PUT-BUN-ON-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order)
                            (assigned-to nil) (points ?*POINTS-PUT-BUN-ON-PLATE*)
                        )
                )
    )
    (return ?goal)
)


(deffunction goal-assert-put-cheese-on-plate(?order)
    (bind ?goal (assert (goal 
                            (class PUT-CHEESE-ON-PLATE) 
                            (id (sym-cat PUT-CHEESE-ON-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order)
                            (assigned-to nil) (points ?*POINTS-PUT-CHEESE-ON-PLATE*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-put-chopped-lettuce-on-plate(?order)
    (bind ?goal (assert (goal 
                            (class PUT-CHOPPED-LETTUCE-ON-PLATE) 
                            (id (sym-cat PUT-CHOPPED-LETTUCE-ON-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order)
                            (assigned-to nil) (points ?*POINTS-PUT-CHOPPED-LETTUCE-ON-PLATE*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-put-chopped-tomato-on-plate(?order)
    (bind ?goal (assert (goal 
                            (class PUT-CHOPPED-TOMATO-ON-PLATE) 
                            (id (sym-cat PUT-CHOPPED-TOMATO-ON-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order)
                            (assigned-to nil) (points ?*POINTS-PUT-CHOPPED-TOMATO-ON-PLATE*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-deliver-plate (?order ?complexity)
    (bind ?points 0)
    (switch ?complexity
        (case 1
            then (bind ?points ?*POINTS-DELIVER-PLATE-I1*))
        (case 2
            then (bind ?points ?*POINTS-DELIVER-PLATE-I2*))
        (case 3
            then (bind ?points ?*POINTS-DELIVER-PLATE-I3*))
        (case 4
            then (bind ?points ?*POINTS-DELIVER-PLATE-I4*))
        (case 5
            then (bind ?points ?*POINTS-DELIVER-PLATE-I5*))
    )
    (bind ?goal (assert (goal 
                            (class DELIVER-PLATE) 
                            (id (sym-cat DELIVER-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order)
                            (assigned-to nil) (points ?points)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-slot(?order ?ingredient)
    (if (eq ?ingredient BUN)
    then
        (bind ?goal (goal-assert-put-bun-on-plate ?order))
        (return ?goal)
    )
    (if (eq ?ingredient BEEF)
    then
        (bind ?goal (goal-assert-put-cooked-beef-on-plate ?order))
        (return ?goal)
    )
    (if (eq ?ingredient CHEESE)
    then
        (bind ?goal (goal-assert-put-cheese-on-plate ?order))
        (return ?goal)
    )
    (if (eq ?ingredient LETTUCE)
    then
        (bind ?goal (goal-assert-put-chopped-lettuce-on-plate ?order))
        (return ?goal)
    )
    (if (eq ?ingredient TOMATO)
    then
        (bind ?goal (goal-assert-put-chopped-tomato-on-plate ?order))
        (return ?goal)
    )
)

(defrule goal-assert-order
    (declare (salience ?*SALIENCE-MODERATE*))
    (domain-fact (name order-slot) (param-values ?order ONE ?ingredient1))
    (domain-fact (name order-slot) (param-values ?order TWO ?ingredient2))
    (domain-fact (name order-slot) (param-values ?order THREE ?ingredient3))
    (domain-fact (name order-slot) (param-values ?order FOUR ?ingredient4))
    (domain-fact (name order-slot) (param-values ?order FIVE ?ingredient5))
    (not (domain-fact (name started-order) (param-values ?order)))
    (not (goal (params order ?order)))
    =>
    (goal-assert-move-plate-from-sink-to-counter ?order)
    (goal-assert-slot ?order ?ingredient1)
    (goal-assert-slot ?order ?ingredient2)
    (goal-assert-slot ?order ?ingredient3)
    (goal-assert-slot ?order ?ingredient4)
    (goal-assert-slot ?order ?ingredient5)

    (bind ?complexity 0)
    (if (neq ?ingredient1 NONE)
    then
        (bind ?complexity (+ ?complexity 1))
    )
    (if (neq ?ingredient2 NONE)
    then
        (bind ?complexity (+ ?complexity 1))
    )
    (if (neq ?ingredient3 NONE)
    then
        (bind ?complexity (+ ?complexity 1))
    )
    (if (neq ?ingredient4 NONE)
    then
        (bind ?complexity (+ ?complexity 1))
    )
    (if (neq ?ingredient5 NONE)
    then
        (bind ?complexity (+ ?complexity 1))
    )

    (goal-assert-deliver-plate ?order ?complexity)
    (printout t "Asserted goals for order " ?order crlf)
)