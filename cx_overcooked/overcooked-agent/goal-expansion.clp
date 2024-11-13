(deffunction plan-assert-action (?name ?robot $?param-values)
" Assert an action with a unique id."
	(bind ?id-sym (gensym*))
	(bind ?id-str (sub-string 4 (str-length ?id-sym) (str-cat ?id-sym)))
	(assert (plan-action (id (string-to-field ?id-str)) (action-name ?name) (robot (str-cat ?robot)) (param-values $?param-values)))
)

(deffunction plan-assert-sequential (?plan-name ?goal-id $?action-tuples)
	(bind ?plan-id (sym-cat ?plan-name (gensym*)))
	(assert (plan (id ?plan-id) (goal-id ?goal-id) (type SEQUENTIAL)))
	(bind ?actions (create$))
	; action tuples might contain FALSE some cases, filter them out
	(foreach ?pa $?action-tuples
		(if ?pa then
			(bind ?actions (append$ ?actions ?pa))
		)
	)
	(foreach ?pa $?actions
		(modify ?pa (id ?pa-index) (plan-id ?plan-id) (goal-id ?goal-id))
	)
)

(defrule goal-expander-move-plate-from-sink-to-counter
    (declare (salience ?*SALIENCE-HIGH*))
    ?g <-   (goal   (id ?goal-id)
                    (class MOVE-PLATE-FROM-SINK-TO-COUNTER)
                    (mode SELECTED)
                    (params order ?order)
                    (assigned-to ?robot&~nil)
            )
    (domain-fact (name station-type) (param-values ?counter COUNTER))
    (domain-fact (name station-type) (param-values ?sink SINK))
    (domain-fact (name plate-at-station) (param-values ?sink ?plate))
    (not (domain-fact (name plate-on-counter) (param-values ?counter)))
    (domain-fact (name at) (param-values ?robot ?pos-start))
    =>
    (plan-assert-sequential (sym-cat MOVE-PLATE-FROM-SINK-TO-COUNTER-PLAN- (gensym*)) ?goal-id
        (plan-assert-action moveto ?robot ?robot ?pos-start ?sink)
        (plan-assert-action getplatefromsink ?robot ?robot ?sink ?plate ?order)
        (plan-assert-action moveto ?robot ?robot ?sink ?counter)
        (plan-assert-action putplateoncounter ?robot ?robot ?counter ?plate)
    )
    (modify ?g (mode EXPANDED))
)

(defrule goal-expander-put-cooked-beef-on-plate
    (declare (salience ?*SALIENCE-HIGH*))
    ?g <-   (goal   (id ?goal-id)
                    (class PUT-COOKED-BEEF-ON-PLATE)
                    (mode SELECTED)
                    (params order ?order)
                    (assigned-to ?robot&~nil)
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
    (domain-fact (name order-slot) (param-values ?order ?slot BEEF))
    (domain-fact (name plate-slot) (param-values ?plate ?slot NONE))
    (domain-fact (name at) (param-values ?robot ?pos-start))
    =>
    (plan-assert-sequential (sym-cat PUT-COOKED-BEEF-ON-PLATE-PLAN- (gensym*)) ?goal-id
        (plan-assert-action moveto ?robot ?robot ?pos-start ?store)
        (plan-assert-action getunprocessedingredientfromstorage ?robot ?robot ?store ?beef)
        (plan-assert-action moveto ?robot ?robot ?store ?stove)
        (plan-assert-action putbeefonstove ?robot ?robot ?stove ?beef)
        (plan-assert-action stovecookbeef ?robot ?stove ?beef)
        (plan-assert-action takebeeffromstove ?robot ?robot ?stove ?beef)
        (plan-assert-action moveto ?robot ?robot ?stove ?counter)
        (plan-assert-action putingredientonplate ?robot ?robot ?counter ?beef BEEF ?plate ?slot)
    )
    (modify ?g (mode EXPANDED))
)

(defrule goal-expander-put-bun-on-plate
    (declare (salience ?*SALIENCE-HIGH*))
    ?g <-   (goal   (id ?goal-id)
                    (class PUT-BUN-ON-PLATE)
                    (mode SELECTED)
                    (params order ?order)
                    (assigned-to ?robot&~nil)
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
    (domain-fact (name at) (param-values ?robot ?pos-start))
    =>
    (plan-assert-sequential (sym-cat PUT-BUN-ON-PLATE-PLAN- (gensym*)) ?goal-id
        (plan-assert-action moveto ?robot ?robot ?pos-start ?store)
        (plan-assert-action getprocessedingredientfromstorage ?robot ?robot ?store ?bun)
        (plan-assert-action moveto ?robot ?robot ?store ?counter)
        (plan-assert-action putingredientonplate ?robot ?robot ?counter ?bun BUN ?plate ?slot)
    )
    (modify ?g (mode EXPANDED))
)

(defrule goal-expander-put-cheese-on-plate
    (declare (salience ?*SALIENCE-HIGH*))
    ?g <-   (goal   (id ?goal-id)
                    (class PUT-CHEESE-ON-PLATE)
                    (mode SELECTED)
                    (params order ?order)
                    (assigned-to ?robot&~nil)
            )
    (domain-fact (name ingredient-type) (param-values ?cheese CHEESE))
    (domain-fact (name ingredient-at-station) (param-values ?store ?cheese))
    (domain-fact (name station-type) (param-values ?store STORAGE))
    (domain-fact (name station-type) (param-values ?counter COUNTER))
    (domain-fact (name plate-for-order) (param-values ?order ?plate))
    (domain-fact (name plate-at-station) (param-values ?counter ?plate))
    (domain-fact (name order-slot) (param-values ?order ?slot CHEESE))
    (domain-fact (name plate-slot) (param-values ?plate ?slot NONE))
    (domain-fact (name at) (param-values ?robot ?pos-start))
    =>
    (plan-assert-sequential (sym-cat PUT-CHEESE-ON-PLATE-PLAN- (gensym*)) ?goal-id
        (plan-assert-action moveto ?robot ?robot ?pos-start ?store)
        (plan-assert-action getprocessedingredientfromstorage ?robot ?robot ?store ?cheese)
        (plan-assert-action moveto ?robot ?robot ?store ?counter)
        (plan-assert-action putingredientonplate ?robot ?robot ?counter ?cheese CHEESE ?plate ?slot)
    )
    (modify ?g (mode EXPANDED))
)

(defrule goal-expander-put-chopped-lettuce-on-plate
    (declare (salience ?*SALIENCE-HIGH*))
    ?g <-   (goal   (id ?goal-id)
                    (class PUT-CHOPPED-LETTUCE-ON-PLATE)
                    (mode SELECTED)
                    (params order ?order)
                    (assigned-to ?robot&~nil)
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
    (domain-fact (name order-slot) (param-values ?order ?slot LETTUCE))
    (domain-fact (name plate-slot) (param-values ?plate ?slot NONE))
    (domain-fact (name at) (param-values ?robot ?pos-start))
    =>
    (plan-assert-sequential (sym-cat PUT-CHOPPED-LETTUCE-ON-PLATE-PLAN- (gensym*)) ?goal-id
        (plan-assert-action moveto ?robot ?robot ?pos-start ?store)
        (plan-assert-action getunprocessedingredientfromstorage ?robot ?robot ?store ?lettuce)
        (plan-assert-action moveto ?robot ?robot ?store ?cb)
        (plan-assert-action putvegetableonchoppingboard ?robot ?robot ?cb ?lettuce)
        (plan-assert-action chopvegetable ?robot ?robot ?cb ?lettuce)
        (plan-assert-action takevegetablefromchoppingboard ?robot ?robot ?cb ?lettuce)
        (plan-assert-action moveto ?robot ?robot ?cb ?counter)
        (plan-assert-action putingredientonplate ?robot ?robot ?counter ?lettuce LETTUCE ?plate ?slot)
    )
    (modify ?g (mode EXPANDED))
)

(defrule goal-expander-put-chopped-tomato-on-plate
    (declare (salience ?*SALIENCE-HIGH*))
    ?g <-   (goal   (id ?goal-id)
                    (class PUT-CHOPPED-TOMATO-ON-PLATE)
                    (mode SELECTED)
                    (params order ?order)
                    (assigned-to ?robot&~nil)
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
    (domain-fact (name order-slot) (param-values ?order ?slot TOMATO))
    (domain-fact (name plate-slot) (param-values ?plate ?slot NONE))
    (domain-fact (name at) (param-values ?robot ?pos-start))
    =>
    (plan-assert-sequential (sym-cat PUT-CHOPPED-TOMATO-ON-PLATE-PLAN- (gensym*)) ?goal-id
        (plan-assert-action moveto ?robot ?robot ?pos-start ?store)
        (plan-assert-action getunprocessedingredientfromstorage ?robot ?robot ?store ?tomato)
        (plan-assert-action moveto ?robot ?robot ?store ?cb)
        (plan-assert-action putvegetableonchoppingboard ?robot ?robot ?cb ?tomato)
        (plan-assert-action chopvegetable ?robot ?robot ?cb ?tomato)
        (plan-assert-action takevegetablefromchoppingboard ?robot ?robot ?cb ?tomato)
        (plan-assert-action moveto ?robot ?robot ?cb ?counter)
        (plan-assert-action putingredientonplate ?robot ?robot ?counter ?tomato TOMATO ?plate ?slot)
    )
    (modify ?g (mode EXPANDED))
)

(defrule goal-expander-deliver-plate
    (declare (salience ?*SALIENCE-HIGH*))
    ?g <-   (goal   (id ?goal-id)
                    (class DELIVER-PLATE)
                    (mode SELECTED)
                    (params order ?order)
                    (assigned-to ?robot&~nil)
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
    (domain-fact (name at) (param-values ?robot ?pos-start))

    =>
    (plan-assert-sequential (sym-cat DELIVER-PLATE-PLAN- (gensym*)) ?goal-id
        (plan-assert-action moveto ?robot ?robot ?pos-start ?counter)
        (plan-assert-action pickupplatefromcounter ?robot ?robot ?counter ?plate)
        (plan-assert-action moveto ?robot ?robot ?counter ?delivery)
        (plan-assert-action deliverplate ?robot ?robot ?delivery ?plate ?order ?i1 ?i2 ?i3 ?i4 ?i5)
    )
    (modify ?g (mode EXPANDED))
)

(defrule goal-reasoner-commit
	?g <- (goal (id ?goal-id) (mode EXPANDED))
    (plan (id ?plan-id) (goal-id ?goal-id))
	=>
	(modify ?g (mode COMMITTED) (committed-to ?plan-id))
)

(defrule goal-reasoner-dispatch
	?g <- (goal (mode COMMITTED))
	=>
	(modify ?g (mode DISPATCHED))
)

(defrule goal-reasoner-completed
	?g <- (goal (id ?goal-id) (mode FINISHED) (outcome COMPLETED))
	=>
	(printout t "Goal '" ?goal-id "' has been completed, cleaning up" crlf)
	(delayed-do-for-all-facts ((?p plan)) (eq ?p:goal-id ?goal-id)
		(delayed-do-for-all-facts ((?a plan-action)) (eq ?a:plan-id ?p:id)
			(retract ?a)
		)
		(retract ?p)
	)
	(retract ?g)
)