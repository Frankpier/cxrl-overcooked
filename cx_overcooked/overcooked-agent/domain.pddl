(define (domain cxrl-overcooked)

  (:requirements 
    :typing :strips :negative-preconditions
   :disjunctive-preconditions)

  (:types
  	robot - object
      dish - object
      ingredient - dish
      plate - dish
      ingredient-typename - object
      ingredient-statename - object
      station - station
      station-typename - object
      station-statename - object
      order - object
      slot - object


  )

  (:constants
      START - station
  	STOVE CHOPPING_BOARD COUNTER STORAGE DELIVERY SINK - station-typename
  	IDLE PROCESSING FINISHED  - station-statename
  	BUN BEEF CHEESE LETTUCE TOMATO NONE - ingredient-typename
      UNPROCESSED PROCESSED - ingredient-statename
      ONE TWO THREE FOUR FIVE - slot



  )

  (:predicates
      (at ?r - robot ?s - station)
      (plate-at-station ?s - station ?p - plate)
      (ingredient-at-station ?s - station ?i - ingredient)
      (station-type ?s - station ?tn - station-typename)
      (station-state ?s - station ?sn - station-statename)
      (station-blocked ?s - station)
      (plate-on-counter ?s - station)
      (ingredient-type ?i - ingredient ?tn - ingredient-typename)
      (ingredient-state ?i - ingredient ?sn - ingredient-statename)
      (holding ?r - robot ?d - dish)
      (arms-free ?r - robot)
      (ingredient-on-plate ?p - plate ?i - ingredient)
      (plate-for-order ?o - order ?p - plate)
      (started-order ?o - order)
      (order-delivered ?o - order)
      (plate-slot ?p - plate ?sl - slot ?in - ingredient-typename)
      (order-slot ?o - order ?sl - slot ?in - ingredient-typename)
  ) 

  (:action moveto
    :parameters (?r - robot ?from - station ?to - station)
    :precondition (and  (at ?r ?from)
                        (station-blocked ?from)
                        (not (station-blocked ?to))
                  )
    :effect (and    (not (at ?r ?from))
                    (at ?r ?to)
                    (not (station-blocked ?from))
                    (station-blocked ?to)
            )
  )

  (:action getunprocessedingredientfromstorage
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (station-type ?s STORAGE)
                        (at ?r ?s)
                        (ingredient-at-station ?s ?i)
                        (or (ingredient-type ?i BEEF)
                            (ingredient-type ?i LETTUCE)
                            (ingredient-type ?i TOMATO)
                        )
                        (arms-free ?r)
                  )
    :effect (and  (holding ?r ?i)
                  (not (ingredient-at-station ?s ?i))
                  (not (arms-free ?r))
                  (ingredient-state ?i UNPROCESSED)
            )
  )

  (:action getprocessedingredientfromstorage
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (station-type ?s STORAGE)
                        (at ?r ?s)
                        (ingredient-at-station ?s ?i)
                        (or (ingredient-type ?i BUN)
                            (ingredient-type ?i CHEESE)
                        )
                        (arms-free ?r)
                  )
    :effect (and  (holding ?r ?i)
                  (not (ingredient-at-station ?s ?i))
                  (not (arms-free ?r))
                  (ingredient-state ?i PROCESSED)
            )
  )

  (:action putvegetableonchoppingboard
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (at ?r ?s)
                        (holding ?r ?i)
                        (station-type ?s CHOPPING_BOARD)
                        (station-state ?s IDLE)
                        (or (ingredient-type ?i LETTUCE)
                            (ingredient-type ?i TOMATO)
                        )
                        (ingredient-state ?i UNPROCESSED)
                  )
    :effect (and  (not (holding ?r ?i))
                  (arms-free ?r)
                  (ingredient-at-station ?s ?i)
                  (not (station-state ?s IDLE))
                  (station-state ?s PROCESSING)
            )
  )

  (:action chopvegetable
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (at ?r ?s)
                        (arms-free ?r)
                        (station-type ?s CHOPPING_BOARD)
                        (station-state ?s PROCESSING)
                        (ingredient-at-station ?s ?i)
                        (or (ingredient-type ?i LETTUCE)
                            (ingredient-type ?i TOMATO)
                        )
                        (ingredient-state ?i UNPROCESSED)
                  )
    :effect (and  (ingredient-state ?i PROCESSED)
                  (not (station-state ?s PROCESSING))
                  (station-state ?s FINISHED)
            )
  )

  (:action takevegetablefromchoppingboard
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (at ?r ?s)
                        (arms-free ?r)
                        (station-type ?s CHOPPING_BOARD)
                        (station-state ?s FINISHED)
                        (ingredient-at-station ?s ?i)
                        (or (ingredient-type ?i LETTUCE)
                            (ingredient-type ?i TOMATO)
                        )
                        (ingredient-state ?i PROCESSED)
                  )
    :effect (and  (holding ?r ?i)
                  (not (arms-free ?r))
                  (not (ingredient-at-station ?s ?i))
                  (not (station-state ?s FINISHED))
                  (station-state ?s IDLE)
            )
  )

  (:action putbeefonstove
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (at ?r ?s)
                        (station-type ?s STOVE)
                        (station-state ?s IDLE)
                        (holding ?r ?i)
                        (ingredient-type ?i BEEF)
                        (ingredient-state ?i UNPROCESSED)
                  )
    :effect (and  (ingredient-at-station ?s ?i)
                  (not (holding ?r ?i))
                  (arms-free ?r)
                  (not (station-state ?s IDLE))
                  (station-state ?s PROCESSING)
            )
  )

  (:action stovecookbeef
    :parameters (?s - station ?i - ingredient)
    :precondition (and  (station-type ?s STOVE)
                        (ingredient-type ?i BEEF)
                        (ingredient-state ?i UNPROCESSED)
                        (station-state ?s PROCESSING)
                        (ingredient-at-station ?s ?i)
                  )
    :effect (and  (ingredient-state ?i PROCESSED)
                  (not (station-state ?s PROCESSING))
                  (station-state ?s FINISHED)
            )
  )

  (:action takebeeffromstove
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (at ?r ?s)
                        (arms-free ?r)
                        (station-type ?s STOVE)
                        (station-state ?s FINISHED)
                        (ingredient-type ?i BEEF)                 
                        (ingredient-state ?i PROCESSED)
                        (ingredient-at-station ?s ?i)
                  )
    :effect (and  (holding ?r ?i)
                  (not (arms-free ?r))
                  (not (ingredient-at-station ?s ?i))
                  (not (station-state ?s FINISHED))
                  (station-state ?s IDLE)
            )
  )
  
  (:action getplatefromsink
    :parameters (?r - robot ?s - station ?p - plate ?o - order)
    :precondition (and  (station-type ?s SINK)
                        (at ?r ?s)
                        (plate-at-station ?s ?p)
                        (arms-free ?r)
                        (not (started-order ?o))
                        (not (order-delivered ?o))
                  )
    :effect (and  (holding ?r ?p)
                  (not (plate-at-station ?s ?p))
                  (not (arms-free ?r))
                  (started-order ?o)
                  (plate-for-order ?o ?p)
            )
  )

  (:action putplateoncounter
    :parameters (?r - robot ?s - station ?p - plate)
    :precondition (and  (at ?r ?s)
                        (station-type ?s COUNTER)
                        (not (plate-on-counter ?s))
                        (holding ?r ?p)
                  )
    :effect (and  (plate-at-station ?s ?p)
                  (not (holding ?r ?p))
                  (arms-free ?r)
                  (plate-on-counter ?s)
            )
  )

  (:action pickupplatefromcounter
    :parameters (?r - robot ?s - station ?p - plate)
    :precondition (and  (at ?r ?s)
                        (station-type ?s COUNTER)
                        (plate-on-counter ?s)
                        (plate-at-station ?s ?p)
                        (arms-free ?r)
                  )
    :effect (and  (holding ?r ?p)
                  (not (arms-free ?r))
                  (not (plate-on-counter ?s))
                  (not (plate-at-station ?s ?p))
            )
  )

  (:action putingredientonplate
    :parameters (?r - robot ?s - station ?i - ingredient ?in - ingredient-typename ?p - plate ?sl - slot)
    :precondition (and  (at ?r ?s)
                        (station-type ?s COUNTER)
                        (ingredient-type ?i ?in)
                        (ingredient-state ?i PROCESSED)
                        (plate-on-counter ?s)
                        (plate-at-station ?s ?p)
                        (holding ?r ?i)
                        (plate-slot ?p ?sl NONE)
                  )
    :effect (and  (not (holding ?r ?i))
                  (arms-free ?r)
                  (ingredient-on-plate ?p ?i)
                  (not (plate-slot ?p ?sl NONE))
                  (plate-slot ?p ?sl ?in)
            )
  )

  (:action deliverplate
    :parameters (?r - robot ?s - station ?p - plate ?o - order ?i1 - ingredient-typename ?i2 - ingredient-typename
                  ?i3 - ingredient-typename ?i4 - ingredient-typename ?i5 - ingredient-typename
                )
    :precondition (and  (at ?r ?s)
                        (station-type ?s DELIVERY)
                        (holding ?r ?p)
                        (plate-for-order ?o ?p)
                        (plate-slot ?p ONE ?i1)
                        (plate-slot ?p TWO ?i2)
                        (plate-slot ?p THREE ?i3)
                        (plate-slot ?p FOUR ?i4)
                        (plate-slot ?p FIVE ?i5)
                        (order-slot ?o ONE ?i1)
                        (order-slot ?o TWO ?i2)
                        (order-slot ?o THREE ?i3)
                        (order-slot ?o FOUR ?i4) 
                        (order-slot ?o FIVE ?i5)
                        (started-order ?o)
                  )
    :effect (and  (not (holding ?r ?p))
                  (arms-free ?r)
                  (order-delivered ?o)
            )
  )
  


)
