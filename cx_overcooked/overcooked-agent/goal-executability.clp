(defrule goal-executable-move-plate-from-sink-to-counter
    (declare (salience ?*SALIENCE-GOAL-EXECUTABLE-CHECK*))
    ?g <- (goal 
            (class MOVE-PLATE-FROM-SINK-TO-COUNTER) (id ?goal-id)
            (mode FORMULATED) (is-executable FALSE)
            (assigned-to ?robot&~nil)
            (params order ?order)
          )
    (not (goal  (class MOVE-PLATE-FROM-SINK-TO-COUNTER)
                (mode SELECTED|EXPANDED|COMMITTED|DISPATCHED)
         )
    )
    (domain-fact (name station-type) (param-values ?counter COUNTER))
    (domain-fact (name station-type) (param-values ?sink SINK))
    (domain-fact (name plate-at-station) (param-values ?sink ?plate))

    (not (domain-fact (name plate-on-counter) (param-values ?counter)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?sink)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?counter)))
    
    (domain-fact (name arms-free) (param-values ?robot))
    =>
    (printout t "Goal MOVE-PLATE-FROM-SINK-TO-COUNTER executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-put-cooked-beef-on-plate
    (declare (salience ?*SALIENCE-GOAL-EXECUTABLE-CHECK*))
    ?g <- (goal 
            (class PUT-COOKED-BEEF-ON-PLATE) (id ?goal-id)
            (mode FORMULATED) (is-executable FALSE)
            (assigned-to ?robot&~nil)
            (params order ?order)
          )
    (not (goal  (class PUT-COOKED-BEEF-ON-PLATE)
                (mode SELECTED|EXPANDED|COMMITTED|DISPATCHED)
         )
    )
    (domain-fact (name ingredient-type) (param-values ?beef BEEF))
    (domain-fact (name ingredient-state) (param-values ?beef UNPROCESSED))
    (domain-fact (name ingredient-at-station) (param-values ?store ?beef))
    (domain-fact (name station-type) (param-values ?store STORAGE))
    (domain-fact (name station-type) (param-values ?stove STOVE))
    (domain-fact (name station-type) (param-values ?counter COUNTER))
    (domain-fact (name station-state) (param-values ?stove IDLE))
    (domain-fact (name plate-for-order) (param-values ?order ?plate))
    (domain-fact (name plate-at-station) (param-values ?counter ?plate))
    (domain-fact (name started-order) (param-values ?order))
    (domain-fact (name order-slot) (param-values ?order ?slot BEEF))
    (domain-fact (name plate-slot) (param-values ?plate ?slot NONE))

    (not (domain-fact (name at) (param-values ?r&~?robot ?stove)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?store)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?counter)))
    
    (domain-fact (name arms-free) (param-values ?robot))
    =>
    (printout t "Goal PUT-COOKED-BEEF-ON-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-put-bun-on-plate
    (declare (salience ?*SALIENCE-GOAL-EXECUTABLE-CHECK*))
    ?g <- (goal 
            (class PUT-BUN-ON-PLATE) (id ?goal-id)
            (mode FORMULATED) (is-executable FALSE)
            (assigned-to ?robot&~nil)
            (params order ?order)
          )
    (not (goal  (class PUT-BUN-ON-PLATE)
                (mode SELECTED|EXPANDED|COMMITTED|DISPATCHED)
         )
    )

    (domain-fact (name ingredient-type) (param-values ?bun BUN))
    (domain-fact (name ingredient-at-station) (param-values ?store ?bun))
    (domain-fact (name station-type) (param-values ?store STORAGE))
    (domain-fact (name station-type) (param-values ?counter COUNTER))
    (domain-fact (name plate-for-order) (param-values ?order ?plate))
    (domain-fact (name plate-at-station) (param-values ?counter ?plate))
    (domain-fact (name started-order) (param-values ?order))
    (domain-fact (name order-slot) (param-values ?order ?slot BUN))
    (domain-fact (name plate-slot) (param-values ?plate ?slot NONE))

    (not (domain-fact (name at) (param-values ?r&~?robot ?store)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?counter)))
    
    (domain-fact (name arms-free) (param-values ?robot))
    =>
    (printout t "Goal PUT-BUN-ON-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-put-cheese-on-plate
    (declare (salience ?*SALIENCE-GOAL-EXECUTABLE-CHECK*))
    ?g <- (goal 
            (class PUT-CHEESE-ON-PLATE) (id ?goal-id)
            (mode FORMULATED) (is-executable FALSE)
            (assigned-to ?robot&~nil)
            (params order ?order)
          )
    (not (goal  (class PUT-CHEESE-ON-PLATE)
                (mode SELECTED|EXPANDED|COMMITTED|DISPATCHED)
         )
    )
    (domain-fact (name ingredient-type) (param-values ?cheese CHEESE))
    (domain-fact (name ingredient-at-station) (param-values ?store ?cheese))
    (domain-fact (name station-type) (param-values ?store STORAGE))
    (domain-fact (name station-type) (param-values ?counter COUNTER))
    (domain-fact (name plate-for-order) (param-values ?order ?plate))
    (domain-fact (name plate-at-station) (param-values ?counter ?plate))
    (domain-fact (name started-order) (param-values ?order))
    (domain-fact (name order-slot) (param-values ?order ?slot CHEESE))
    (domain-fact (name plate-slot) (param-values ?plate ?slot NONE))

    (not (domain-fact (name at) (param-values ?r&~?robot ?store)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?counter)))
    
    (domain-fact (name arms-free) (param-values ?robot))
    =>
    (printout t "Goal PUT-CHEESE-ON-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-put-chopped-lettuce-on-plate
    (declare (salience ?*SALIENCE-GOAL-EXECUTABLE-CHECK*))
    ?g <- (goal 
            (class PUT-CHOPPED-LETTUCE-ON-PLATE) (id ?goal-id)
            (mode FORMULATED) (is-executable FALSE)
            (assigned-to ?robot&~nil)
            (params order ?order)
          )
    (not (goal  (class PUT-CHOPPED-LETTUCE-ON-PLATE)
                (mode SELECTED|EXPANDED|COMMITTED|DISPATCHED)
         )
    )

    (domain-fact (name ingredient-type) (param-values ?lettuce LETTUCE))
    (domain-fact (name ingredient-state) (param-values ?lettuce UNPROCESSED))
    (domain-fact (name ingredient-at-station) (param-values ?store ?lettuce))
    (domain-fact (name station-type) (param-values ?store STORAGE))
    (domain-fact (name station-type) (param-values ?cb CHOPPING_BOARD))
    (domain-fact (name station-type) (param-values ?counter COUNTER))
    (domain-fact (name station-state) (param-values ?cb IDLE))
    (domain-fact (name plate-for-order) (param-values ?order ?plate))
    (domain-fact (name plate-at-station) (param-values ?counter ?plate))
    (domain-fact (name started-order) (param-values ?order))
    (domain-fact (name order-slot) (param-values ?order ?slot LETTUCE))
    (domain-fact (name plate-slot) (param-values ?plate ?slot NONE))

    (not (domain-fact (name at) (param-values ?r&~?robot ?cb)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?store)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?counter)))
    
    (domain-fact (name arms-free) (param-values ?robot))
    =>
    (printout t "Goal PUT-CHOPPED-LETTUCE-ON-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-put-chopped-tomato-on-plate
    (declare (salience ?*SALIENCE-GOAL-EXECUTABLE-CHECK*))
    ?g <- (goal 
            (class PUT-CHOPPED-TOMATO-ON-PLATE) (id ?goal-id)
            (mode FORMULATED) (is-executable FALSE)
            (assigned-to ?robot&~nil)
            (params order ?order)
          )
    (not (goal  (class PUT-CHOPPED-TOMATO-ON-PLATE)
                (mode SELECTED|EXPANDED|COMMITTED|DISPATCHED)
         )
    )
    (domain-fact (name ingredient-type) (param-values ?tomato TOMATO))
    (domain-fact (name ingredient-state) (param-values ?tomato UNPROCESSED))
    (domain-fact (name ingredient-at-station) (param-values ?store ?tomato))
    (domain-fact (name station-type) (param-values ?store STORAGE))
    (domain-fact (name station-type) (param-values ?cb CHOPPING_BOARD))
    (domain-fact (name station-type) (param-values ?counter COUNTER))
    (domain-fact (name station-state) (param-values ?cb IDLE))
    (domain-fact (name plate-for-order) (param-values ?order ?plate))
    (domain-fact (name plate-at-station) (param-values ?counter ?plate))
    (domain-fact (name started-order) (param-values ?order))
    (domain-fact (name order-slot) (param-values ?order ?slot TOMATO))
    (domain-fact (name plate-slot) (param-values ?plate ?slot NONE))

    (not (domain-fact (name at) (param-values ?r&~?robot ?cb)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?store)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?counter)))
    
    (domain-fact (name arms-free) (param-values ?robot))
    =>
    (printout t "Goal PUT-CHOPPED-TOMATO-ON-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-deliver-plate
    (declare (salience ?*SALIENCE-GOAL-EXECUTABLE-CHECK*))
    ?g <- (goal 
            (class DELIVER-PLATE) (id ?goal-id)
            (mode FORMULATED) (is-executable FALSE)
            (assigned-to ?robot&~nil)
            (params order ?order)
          )
    (not (goal  (class DELIVER-PLATE)
                (mode SELECTED|EXPANDED|COMMITTED|DISPATCHED)
         )
    )

    (domain-fact (name station-type) (param-values ?delivery DELIVERY))
    (domain-fact (name station-type) (param-values ?counter COUNTER))
    (domain-fact (name plate-at-station) (param-values ?counter ?plate))
    (domain-fact (name plate-for-order) (param-values ?order ?plate))

    (domain-fact (name order-slot) (param-values ?order ONE ?i1))
    (domain-fact (name order-slot) (param-values ?order TWO ?i2))
    (domain-fact (name order-slot) (param-values ?order THREE ?i3))
    (domain-fact (name order-slot) (param-values ?order FOUR ?i4))
    (domain-fact (name order-slot) (param-values ?order FIVE ?i5))

    (domain-fact (name plate-slot) (param-values ?plate ONE ?i1))
    (domain-fact (name plate-slot) (param-values ?plate TWO ?i2))
    (domain-fact (name plate-slot) (param-values ?plate THREE ?i3))
    (domain-fact (name plate-slot) (param-values ?plate FOUR ?i4))
    (domain-fact (name plate-slot) (param-values ?plate FIVE ?i5))

    (not (domain-fact (name at) (param-values ?r&~?robot ?delivery)))
    (not (domain-fact (name at) (param-values ?r&~?robot ?counter)))
    
    (domain-fact (name arms-free) (param-values ?robot))  
    =>
    (printout t "Goal DELIVER-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)