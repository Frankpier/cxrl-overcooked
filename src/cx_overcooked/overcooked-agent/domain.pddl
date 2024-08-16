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
      station - location
      station-typename - object
      station-statename - object
      order - object
      slot - object


  )

  (:constants
      START - location
  	STOVE CHOPPING_BOARD COUNTER STORAGE DELIVERY SINK - station-typename
  	IDLE PROCESSING FINISHED  - station-statename
  	BUN BEEF CHEESE LETTUCE TOMATO NONE - ingredient-typename
      UNPROCESSED PROCESSED - ingredient-statename
      ONE TWO THREE FOUR FIVE - slot



  )

  (:predicates
      (at ?r - robot ?l - location)
      (item-at-station ?s - station ?i - dish)
      (station-type ?s - station ?tn - station-typename)
      (station-state ?s - station ?sn - station-statename)
      (location-blocked ?l - location)
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

  (:action move-to
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and  (at ?r ?from)
                        (location-blocked ?from)
                        (not (location-blocked ?to))
                  )
    :effect (and    (not (at ?r ?from))
                    (at ?r ?to)
                    (not (location-blocked ?from))
                    (location-blocked ?to)
            )
  )

  (:action get-unprocessed-ingredient-from-storage
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (station-type ?s STORAGE)
                        (at ?r ?s)
                        (item-at-station ?s ?i)
                        (or (ingredient-type ?i BEEF)
                            (ingredient-type ?i LETTUCE)
                            (ingredient-type ?i TOMATO)
                        )
                        (arms-free ?r)
                  )
    :effect (and  (holding ?r ?i)
                  (not (item-at-station ?s ?i))
                  (not (arms-free ?r))
                  (ingredient-state ?i UNPROCESSED)
            )
  )

  (:action get-processed-ingredient-from-storage
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (station-type ?s STORAGE)
                        (at ?r ?s)
                        (item-at-station ?s ?i)
                        (or (ingredient-type ?i BUN)
                            (ingredient-type ?i CHEESE)
                        )
                        (arms-free ?r)
                  )
    :effect (and  (holding ?r ?i)
                  (not (item-at-station ?s ?i))
                  (not (arms-free ?r))
                  (ingredient-state ?i PROCESSED)
            )
  )

  (:action put-vegetable-on-chopping-board
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
                  (item-at-station ?s ?i)
                  (not (station-state ?s IDLE))
                  (station-state ?s PROCESSING)
            )
  )

  (:action chop-vegetable
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (at ?r ?s)
                        (arms-free ?r)
                        (station-type ?s CHOPPING_BOARD)
                        (station-state ?s PROCESSING)
                        (item-at-station ?s ?i)
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

  (:action take-vegetable-from-chopping-board
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (at ?r ?s)
                        (arms-free ?r)
                        (station-type ?s CHOPPING_BOARD)
                        (station-state ?s FINISHED)
                        (item-at-station ?s ?i)
                        (or (ingredient-type ?i LETTUCE)
                            (ingredient-type ?i TOMATO)
                        )
                        (ingredient-state ?i PROCESSED)
                  )
    :effect (and  (holding ?r ?i)
                  (not (arms-free ?r))
                  (not (item-at-station ?s ?i))
                  (not (station-state ?s FINISHED))
                  (station-state ?s IDLE)
            )
  )

  (:action put-beef-on-stove
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (at ?r ?s)
                        (station-type ?s STOVE)
                        (station-state ?s IDLE)
                        (holding ?r ?i)
                        (ingredient-type ?i BEEF)
                        (ingredient-state ?i UNPROCESSED)
                  )
    :effect (and  (item-at-station ?s ?i)
                  (not (holding ?r ?i))
                  (arms-free ?r)
                  (not (station-state ?s IDLE))
                  (station-state ?s PROCESSING)
            )
  )

  (:action stove-cook-beef
    :parameters (?s - station ?i - ingredient)
    :precondition (and  (station-type ?s STOVE)
                        (ingredient-type ?i BEEF)
                        (ingredient-state ?i UNPROCESSED)
                        (station-state ?s PROCESSING)
                        (item-at-station ?s ?i)
                  )
    :effect (and  (ingredient-state ?i PROCESSED)
                  (not (station-state ?s PROCESSING))
                  (station-state ?s FINISHED)
            )
  )

  (:action take-beef-from-stove
    :parameters (?r - robot ?s - station ?i - ingredient)
    :precondition (and  (at ?r ?s)
                        (arms-free ?r)
                        (station-type ?s STOVE)
                        (station-state ?s FINISHED)
                        (ingredient-type ?i BEEF)                 
                        (ingredient-state ?i PROCESSED)
                        (item-at-station ?s ?i)
                  )
    :effect (and  (holding ?r ?i)
                  (not (arms-free ?r))
                  (not (item-at-station ?s ?i))
                  (not (station-state ?s FINISHED))
                  (station-state ?s IDLE)
            )
  )
  
  (:action get-plate-from-sink
    :parameters (?r - robot ?s - station ?p - plate ?o - order)
    :precondition (and  (station-type ?s SINK)
                        (at ?r ?s)
                        (item-at-station ?s ?p)
                        (arms-free ?r)
                        (not (started-order ?o))
                        (not (order-delivered ?o))
                  )
    :effect (and  (holding ?r ?p)
                  (not (item-at-station ?s ?p))
                  (not (arms-free ?r))
                  (started-order ?o)
                  (plate-for-order ?o ?p)
            )
  )

  (:action put-plate-on-counter
    :parameters (?r - robot ?s - station ?p - plate)
    :precondition (and  (at ?r ?s)
                        (station-type ?s COUNTER)
                        (not (plate-on-counter ?s))
                        (holding ?r ?p)
                  )
    :effect (and  (item-at-station ?s ?p)
                  (not (holding ?r ?p))
                  (arms-free ?r)
                  (plate-on-counter ?s)
            )
  )

  (:action pick-up-plate-from-counter
    :parameters (?r - robot ?s - station ?p - plate)
    :precondition (and  (at ?r ?s)
                        (station-type ?s COUNTER)
                        (plate-on-counter ?s)
                        (item-at-station ?s ?p)
                        (arms-free ?r)
                  )
    :effect (and  (holding ?r ?p)
                  (not (arms-free ?r))
                  (not (plate-on-counter ?s))
                  (not (item-at-station ?s ?p))
            )
  )

  (:action put-ingredient-on-plate
    :parameters (?r - robot ?s - station ?i - ingredient ?in - ingredient-typename ?p - plate ?sl - slot)
    :precondition (and  (at ?r ?s)
                        (station-type ?s COUNTER)
                        (ingredient-type ?i ?in)
                        (ingredient-state ?i PROCESSED)
                        (plate-on-counter ?s)
                        (item-at-station ?s ?p)
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

  (:action deliver-plate
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
