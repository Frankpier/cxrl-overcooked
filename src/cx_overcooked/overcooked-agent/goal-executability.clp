(defrule goal-executable-move-plate-from-sink-to-counter
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
    (wm-fact (key domain fact station-type args? s ?counter tn COUNTER))
    (wm-fact (key domain fact station-type args? s ?sink tn SINK))
    (wm-fact (key domain fact item-at-station args? s ?sink i ?plate))

    (not (wm-fact (key domain fact plate-on-counter args? s ?counter)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?sink)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?counter)))
    
    (wm-fact (key domain fact arms-free args? r ?robot))
    =>
    (printout t "Goal MOVE-PLATE-FROM-SINK-TO-COUNTER executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-put-cooked-beef-on-plate
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
    (wm-fact (key domain fact ingredient-type args? i ?beef tn BEEF))
    (wm-fact (key domain fact ingredient-state args? i ?beef sn UNPROCESSED))
    (wm-fact (key domain fact item-at-station args? s ?store i ?beef))
    (wm-fact (key domain fact station-type args? s ?store tn STORAGE))
    (wm-fact (key domain fact station-type args? s ?stove tn STOVE))
    (wm-fact (key domain fact station-type args? s ?counter tn COUNTER))
    (wm-fact (key domain fact station-state args? s ?stove sn IDLE))
    (wm-fact (key domain fact plate-for-order args? o ?order p ?plate))
    (wm-fact (key domain fact item-at-station args? s ?counter i ?plate))
    (wm-fact (key domain fact started-order args? o ?order))
    (wm-fact (key domain fact order-slot args? o ?order sl ?slot in BEEF))
    (wm-fact (key domain fact plate-slot args? p ?plate sl ?slot in NONE))

    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?stove)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?store)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?counter)))
    
    (wm-fact (key domain fact arms-free args? r ?robot))
    =>
    (printout t "Goal PUT-COOKED-BEEF-ON-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-put-bun-on-plate
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

    (wm-fact (key domain fact ingredient-type args? i ?bun tn BUN))
    (wm-fact (key domain fact item-at-station args? s ?store i ?bun))
    (wm-fact (key domain fact station-type args? s ?store tn STORAGE))
    (wm-fact (key domain fact station-type args? s ?counter tn COUNTER))
    (wm-fact (key domain fact plate-for-order args? o ?order p ?plate))
    (wm-fact (key domain fact item-at-station args? s ?counter i ?plate))
    (wm-fact (key domain fact started-order args? o ?order))
    (wm-fact (key domain fact order-slot args? o ?order sl ?slot in BUN))
    (wm-fact (key domain fact plate-slot args? p ?plate sl ?slot in NONE))

    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?store)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?counter)))
    
    (wm-fact (key domain fact arms-free args? r ?robot))
    =>
    (printout t "Goal PUT-BUN-ON-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-put-cheese-on-plate
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
    (wm-fact (key domain fact ingredient-type args? i ?cheese tn CHEESE))
    (wm-fact (key domain fact item-at-station args? s ?store i ?cheese))
    (wm-fact (key domain fact station-type args? s ?store tn STORAGE))
    (wm-fact (key domain fact station-type args? s ?counter tn COUNTER))
    (wm-fact (key domain fact plate-for-order args? o ?order p ?plate))
    (wm-fact (key domain fact item-at-station args? s ?counter i ?plate))
    (wm-fact (key domain fact started-order args? o ?order))
    (wm-fact (key domain fact order-slot args? o ?order sl ?slot in CHEESE))
    (wm-fact (key domain fact plate-slot args? p ?plate sl ?slot in NONE))

    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?store)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?counter)))
    
    (wm-fact (key domain fact arms-free args? r ?robot))
    =>
    (printout t "Goal PUT-CHEESE-ON-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-put-chopped-lettuce-on-plate
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

    (wm-fact (key domain fact ingredient-type args? i ?lettuce tn LETTUCE))
    (wm-fact (key domain fact ingredient-state args? i ?lettuce sn UNPROCESSED))
    (wm-fact (key domain fact item-at-station args? s ?store i ?lettuce))
    (wm-fact (key domain fact station-type args? s ?store tn STORAGE))
    (wm-fact (key domain fact station-type args? s ?cb tn CHOPPING_BOARD))
    (wm-fact (key domain fact station-type args? s ?counter tn COUNTER))
    (wm-fact (key domain fact station-state args? s ?cb sn IDLE))
    (wm-fact (key domain fact plate-for-order args? o ?order p ?plate))
    (wm-fact (key domain fact item-at-station args? s ?counter i ?plate))
    (wm-fact (key domain fact started-order args? o ?order))
    (wm-fact (key domain fact order-slot args? o ?order sl ?slot in LETTUCE))
    (wm-fact (key domain fact plate-slot args? p ?plate sl ?slot in NONE))

    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?cb)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?store)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?counter)))
    
    (wm-fact (key domain fact arms-free args? r ?robot))
    =>
    (printout t "Goal PUT-CHOPPED-LETTUCE-ON-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-put-chopped-tomato-on-plate
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
    (wm-fact (key domain fact ingredient-type args? i ?tomato tn TOMATO))
    (wm-fact (key domain fact ingredient-state args? i ?tomato sn UNPROCESSED))
    (wm-fact (key domain fact item-at-station args? s ?store i ?tomato))
    (wm-fact (key domain fact station-type args? s ?store tn STORAGE))
    (wm-fact (key domain fact station-type args? s ?cb tn CHOPPING_BOARD))
    (wm-fact (key domain fact station-type args? s ?counter tn COUNTER))
    (wm-fact (key domain fact station-state args? s ?cb sn IDLE))
    (wm-fact (key domain fact plate-for-order args? o ?order p ?plate))
    (wm-fact (key domain fact item-at-station args? s ?counter i ?plate))
    (wm-fact (key domain fact started-order args? o ?order))
    (wm-fact (key domain fact order-slot args? o ?order sl ?slot in TOMATO))
    (wm-fact (key domain fact plate-slot args? p ?plate sl ?slot in NONE))

    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?cb)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?store)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?counter)))
    
    (wm-fact (key domain fact arms-free args? r ?robot))
    =>
    (printout t "Goal PUT-CHOPPED-TOMATO-ON-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)

(defrule goal-executable-deliver-plate
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

    (wm-fact (key domain fact station-type args? s ?delivery tn DELIVERY))
    (wm-fact (key domain fact station-type args? s ?counter tn COUNTER))
    (wm-fact (key domain fact item-at-station args? s ?counter i ?plate))

    (wm-fact (key domain fact order-slot args? o ?order sl ?s1 in ?i1))
    (wm-fact (key domain fact order-slot args? o ?order sl ?s2 in ?i2))
    (wm-fact (key domain fact order-slot args? o ?order sl ?s3 in ?i3))
    (wm-fact (key domain fact order-slot args? o ?order sl ?s4 in ?i4))
    (wm-fact (key domain fact order-slot args? o ?order sl ?s5 in ?i5))

    (wm-fact (key domain fact plate-slot args? p ?plate sl ?s1 in ?i1))
    (wm-fact (key domain fact plate-slot args? p ?plate sl ?s2 in ?i2))
    (wm-fact (key domain fact plate-slot args? p ?plate sl ?s3 in ?i3))
    (wm-fact (key domain fact plate-slot args? p ?plate sl ?s4 in ?i4))
    (wm-fact (key domain fact plate-slot args? p ?plate sl ?s5 in ?i5))

    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?delivery)))
    (not (wm-fact (key domain fact at args? r ?r&~?robot l ?counter)))
    
    (wm-fact (key domain fact arms-free args? r ?robot))  
    =>
    (printout t "Goal DELIVER-PLATE executable for " ?robot crlf)
    (modify ?g (is-executable TRUE))
)