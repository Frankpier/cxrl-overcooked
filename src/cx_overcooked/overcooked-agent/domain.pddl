(define (domain cxrl-overcooked)

  (:requirements 
    :typing :strips :negative-preconditions
   :disjunctive-preconditions)

  (:types
  	agent - object
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
      (at ?a - agent ?l - location)
      (item-at-station ?s - station ?d - dish)
      (station-type ?s - station ?tn - station-typename)
      (station-state ?s - station ?sn - station-statename)
      (location-blocked ?l - location)
      (plate-on-counter ?s - station)
      (ingredient-type ?i - ingredient ?tn - ingredient-typename)
      (ingredient-state ?i - ingredient ?sn - ingredient-statename)
      (holding ?a - agent ?d - dish)
      (arms-free ?a - agent)
      (ingredient-on-plate ?p - plate ?i - ingredient)
      (plate-for-order ?o - order ?p - plate)
      (started-order ?o - order)
      (order-delivered ?o - order)
      (plate-slot ?p - plate ?sl - slot ?in - ingredient-typename)
      (order-slot ?o - order ?sl - slot ?in - ingredient-typename)

  ) 

  (:action move-to
    :parameters (?a - agent ?from - location ?to - location)
    :precondition (and  (at ?a ?from)
                        (location-blocked ?from)
                        (not (location-blocked ?to))
                  )
    :effect (and    (not (at ?a ?from))
                    (at ?a ?to)
                    (not (location-blocked ?from))
                    (location-blocked ?to)
            )
  )

  (:action get-unprocessed-ingredient-from-storage
    :parameters (?a - agent ?s - station ?i - ingredient)
    :precondition (and  (station-type ?s STORAGE)
                        (at ?a ?s)
                        (item-at-station ?s ?i)
                        (or (ingredient-type ?i BEEF)
                            (ingredient-type ?i LETTUCE)
                            (ingredient-type ?i TOMATO)
                        )
                        (arms-free ?a)
                  )
    :effect (and  (holding ?a ?i)
                  (not (item-at-station ?s ?i))
                  (not (arms-free ?a))
                  (ingredient-state ?i UNPROCESSED)
            )
  )

  (:action get-processed-ingredient-from-storage
    :parameters (?a - agent ?s - station ?i - ingredient)
    :precondition (and  (station-type ?s STORAGE)
                        (at ?a ?s)
                        (item-at-station ?s ?i)
                        (or (ingredient-type ?i BUN)
                            (ingredient-type ?i CHEESE)
                        )
                        (arms-free ?a)
                  )
    :effect (and  (holding ?a ?i)
                  (not (item-at-station ?s ?i))
                  (not (arms-free ?a))
                  (ingredient-state ?i PROCESSED)
            )
  )

  (:action put-vegetable-on-chopping-board
    :parameters (?a - agent ?s - station ?i - ingredient)
    :precondition (and  (at ?a ?s)
                        (holding ?a ?i)
                        (station-type ?s CHOPPING_BOARD)
                        (station-state ?s IDLE)
                        (or (ingredient-type ?i LETTUCE)
                            (ingredient-type ?i TOMATO)
                        )
                        (ingredient-state ?i UNPROCESSED)
                  )
    :effect (and  (not (holding ?a ?i))
                  (arms-free ?a)
                  (item-at-station ?s ?i)
                  (not (station-state ?s IDLE))
                  (station-state ?s PROCESSING)
            )
  )

  (:action chop-vegetable
    :parameters (?a - agent ?s - station ?i - ingredient)
    :precondition (and  (at ?a ?s)
                        (arms-free ?a)
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
    :parameters (?a - agent ?s - station ?i - ingredient)
    :precondition (and  (at ?a ?s)
                        (arms-free ?a)
                        (station-type ?s CHOPPING_BOARD)
                        (station-state ?s FINISHED)
                        (item-at-station ?s ?i)
                        (or (ingredient-type ?i LETTUCE)
                            (ingredient-type ?i TOMATO)
                        )
                        (ingredient-state ?i PROCESSED)
                  )
    :effect (and  (holding ?a ?i)
                  (not (arms-free ?a))
                  (not (item-at-station ?s ?i))
                  (not (station-state ?s FINISHED))
                  (station-state ?s IDLE)
            )
  )

  (:action put-beef-on-stove
    :parameters (?a - agent ?s - station ?i - ingredient)
    :precondition (and  (at ?a ?s)
                        (station-type ?s STOVE)
                        (station-state ?s IDLE)
                        (holding ?a ?i)
                        (ingredient-type ?i BEEF)
                        (ingredient-state ?i UNPROCESSED)
                  )
    :effect (and  (item-at-station ?s ?i)
                  (not (holding ?a ?i))
                  (arms-free ?a)
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
    :parameters (?a - agent ?s - station ?i - ingredient)
    :precondition (and  (at ?a ?s)
                        (arms-free ?a)
                        (station-type ?s STOVE)
                        (station-state ?s FINISHED)
                        (ingredient-type ?i BEEF)                 
                        (ingredient-state ?i PROCESSED)
                        (item-at-station ?s ?i)
                  )
    :effect (and  (holding ?a ?i)
                  (not (arms-free ?a))
                  (not (item-at-station ?s ?i))
                  (not (station-state ?s FINISHED))
                  (station-state ?s IDLE)
            )
  )
  
  (:action get-plate-from-sink
    :parameters (?a - agent ?s - station ?p - plate ?o - order)
    :precondition (and  (station-type ?s SINK)
                        (at ?a ?s)
                        (item-at-station ?s ?p)
                        (arms-free ?a)
                        (not (started-order ?o))
                        (not (order-delivered ?o))
                  )
    :effect (and  (holding ?a ?p)
                  (not (item-at-station ?s ?p))
                  (not (arms-free ?a))
                  (started-order ?o)
                  (plate-for-order ?o ?p)
            )
  )

  (:action put-plate-on-counter
    :parameters (?a - agent ?s - station ?p - plate)
    :precondition (and  (at ?a ?s)
                        (station-type ?s COUNTER)
                        (not (plate-on-counter ?s))
                        (holding ?a ?p)
                  )
    :effect (and  (item-at-station ?s ?p)
                  (not (holding ?a ?p))
                  (arms-free ?a)
                  (plate-on-counter ?s)
            )
  )

  (:action pick-up-plate-from-counter
    :parameters (?a - agent ?s - station ?p - plate)
    :precondition (and  (at ?a ?s)
                        (station-type ?s COUNTER)
                        (plate-on-counter ?s)
                        (item-at-station ?s ?p)
                        (arms-free ?a)
                  )
    :effect (and  (holding ?a ?p)
                  (not (arms-free ?a))
                  (not (plate-on-counter ?s))
                  (not (item-at-station ?s ?p))
            )
  )

  (:action put-ingredient-on-plate
    :parameters (?a - agent ?s - station ?i - ingredient ?in - ingredient-typename ?p - plate ?sl - slot)
    :precondition (and  (at ?a ?s)
                        (station-type ?s COUNTER)
                        (ingredient-type ?i ?in)
                        (ingredient-state ?i PROCESSED)
                        (plate-on-counter ?s)
                        (item-at-station ?s ?p)
                        (holding ?a ?i)
                        (plate-slot ?p ?sl NONE)
                  )
    :effect (and  (not (holding ?a ?i))
                  (arms-free ?a)
                  (ingredient-on-plate ?p ?i)
                  (not (plate-slot ?p ?sl NONE))
                  (plate-slot ?p ?sl ?in)
            )
  )

  (:action deliver-plate
    :parameters (?a - agent ?s - station ?p - plate ?o - order ?i1 - ingredient-typename ?i2 - ingredient-typename
                  ?i3 - ingredient-typename ?i4 - ingredient-typename ?i5 - ingredient-typename
                )
    :precondition (and  (at ?a ?s)
                        (station-type ?s DELIVERY)
                        (holding ?a ?p)
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
    :effect (and  (not (holding ?a ?p))
                  (arms-free ?a)
                  (order-delivered ?o)
            )
  )
  


)
