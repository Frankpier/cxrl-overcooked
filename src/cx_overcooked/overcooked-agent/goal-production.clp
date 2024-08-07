

(deffunction goal-assert-move-plate-from-sink-to-counter
    (?order ?plate ?sink ?counter)
    (bind ?goal (assert (goal 
                            (class MOVE-PLATE-FROM-SINK-TO-COUNTER) 
                            (id (sym-cat MOVE-PLATE-FROM-SINK-TO-COUNTER- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order plate ?plate sink ?sink counter ?counter)
                            (assigned-to nil) (points ?*POINTS-MOVE-PLATE-FROM-SINK-TO-COUNTER*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-put-cooked-beef-on-plate
    (?order ?beef ?stove ?plate)
    (bind ?goal (assert (goal 
                            (class PUT-COOKED-BEEF-ON-PLATE) 
                            (id (sym-cat PUT-COOKED-BEEF-ON-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order beef ?beef stove ?stove plate ?plate)
                            (assigned-to nil) (points ?*POINTS-PUT-COOKED-BEEF-ON-PLATE*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-put-bun-on-plate
    (?order ?bun ?plate)
    (bind ?goal (assert (goal 
                            (class PUT-BUN-ON-PLATE) 
                            (id (sym-cat PUT-BUN-ON-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order bun ?bun plate ?plate)
                            (assigned-to nil) (points ?*POINTS-PUT-BUN-ON-PLATE*)
                        )
                )
    )
    (return ?goal)
)


(deffunction goal-assert-put-cheese-on-plate
    (?order ?cheese ?plate)
    (bind ?goal (assert (goal 
                            (class PUT-CHEESE-ON-PLATE) 
                            (id (sym-cat PUT-CHEESE-ON-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order cheese ?cheese plate ?plate)
                            (assigned-to nil) (points ?*POINTS-PUT-CHEESE-ON-PLATE*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-put-chopped-lettuce-on-plate
    (?order ?lettuce ?chopping-board ?plate)
    (bind ?goal (assert (goal 
                            (class PUT-CHOPPED-LETTUCE-ON-PLATE) 
                            (id (sym-cat PUT-CHOPPED-LETTUCE-ON-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order lettuce ?lettuce chopping-board ?chopping-board plate ?plate)
                            (assigned-to nil) (points ?*POINTS-PUT-CHOPPED-LETTUCE-ON-PLATE*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-put-chopped-tomato-on-plate
    (?order ?tomato ?chopping-board ?plate)
    (bind ?goal (assert (goal 
                            (class PUT-CHOPPED-TOMATO-ON-PLATE) 
                            (id (sym-cat PUT-CHOPPED-TOMATO-ON-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order tomato ?tomato chopping-board ?chopping-board plate ?plate)
                            (assigned-to nil) (points ?*POINTS-PUT-CHOPPED-TOMATO-ON-PLATE*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-deliver-plate
    (?order ?plate ?delivery)
    (bind ?goal (assert (goal 
                            (class DELIVER-PLATE) 
                            (id (sym-cat DELIVER-PLATE- (gensym*)))
                            (sub-type SIMPLE) (is-executable FALSE)
                            (params order ?order plate ?plate delivery ?delivery)
                            (assigned-to nil) (points ?*DELIVER-PLATE*)
                        )
                )
    )
    (return ?goal)
)

(deffunction goal-assert-slot
    (?order ?ingredient ?plate ?stove ?board)
    (if (eq ?ingredient BUN)
    then
        (bind ?bun (sym-cat bun ?order))
        (bind ?goal (goal-assert-put-bun-on-plate ?order ?bun ?plate))
        (return ?goal)
    )
    (if (eq ?ingredient BEEF)
    then
        (bind ?beef (sym-cat beef ?order))
        (bind ?goal (goal-assert-put-cooked-beef-on-plate ?order ?beef ?stove ?plate))
        (return ?goal)
    )
    (if (eq ?ingredient CHEESE)
    then
        (bind ?cheese (sym-cat cheese ?order))
        (bind ?goal (goal-assert-put-cheese-on-plate ?order ?cheese ?plate))
        (return ?goal)
    )
    (if (eq ?ingredient LETTUCE)
    then
        (bind ?lettuce (sym-cat lettuce ?order))
        (bind ?goal (goal-assert-put-chopped-lettuce-on-plate ?order ?lettuce ?board ?plate))
        (return ?goal)
    )
    (if (eq ?ingredient TOMATO)
    then
        (bind ?tomato (sym-cat tomato ?order))
        (bind ?goal (goal-assert-put-chopped-tomato-on-plate ?order ?tomato ?plate))
        (return ?goal)
    )
)

(defrule goal-assert-order
    (domain-fact (name order-slot) (param-values ?order ONE ?ingredient1))
    (domain-fact (name order-slot) (param-values ?order TWO ?ingredient2))
    (domain-fact (name order-slot) (param-values ?order THREE ?ingredient3))
    (domain-fact (name order-slot) (param-values ?order FOUR ?ingredient4))
    (domain-fact (name order-slot) (param-values ?order FIVE ?ingredient5))

    (domain-fact (name station-type) (param-values ?sink SINK))
    (domain-fact (name station-type) (param-values ?stove STOVE))
    (domain-fact (name station-type) (param-values ?board CHOPPING_BOARD))
    (domain-fact (name station-type) (param-values ?delivery DELIVERY))
    (not (goal (params order ?order)))
    =>
    (bind ?counter (sym-cat counter ?order))
    (bind ?plate (sym-cat plate ?order))
    (goal-assert-move-plate-from-sink-to-counter ?order ?plate ?sink ?counter)
    (goal-assert-slot ?order ?ingredient1 ?plate ?stove ?board)
    (goal-assert-slot ?order ?ingredient2 ?plate ?stove ?board)
    (goal-assert-slot ?order ?ingredient3 ?plate ?stove ?board)
    (goal-assert-slot ?order ?ingredient4 ?plate ?stove ?board)
    (goal-assert-slot ?order ?ingredient5 ?plate ?stove ?board)

    (goal-assert-deliver-plate ?order ?plate ?delivery)
)