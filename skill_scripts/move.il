procedure(move()
    let((STEP step_value move_right move_left move_up move_down)
        STEP = hiCreateStringField(
            ?name       'step
            ?prompt     "step"
            ?callback   nil
            ?editable   t
        )
        hiCreateAppForm(
            ?name       'step_value
            ?formTitle  "MOVE"
            ?fields     list(STEP)
            ?callback   nil
            ?help       "formHelp"
            ?buttonLayout   'OKCancel
        )
		step_value~>step~>value = "0.0625"
        hiDisplayForm(step_value)
		steprun = ciToFloat(step_value~>step~>value)

		procedure(move_by_vector(obj vec)
			let((pp tmp_pos)
				when(member(obj~>objType '("arc"))
					pp = obj~>ellipseBBox
					tmp_pos = list()
					for(i 0 1
						tmp_pos = append1(tmp_pos list(car(nth(i pp))+car(vec) cadr(nth(i pp))+cadr(vec)))
					)
					obj~>ellipseBBox = tmp_pos
				)
				when(member(obj~>objType '("rect" "ellipse"))
					pp = obj~>bBox
					tmp_pos = list()
					for(i 0 1
						tmp_pos = append1(tmp_pos list(car(nth(i pp))+car(vec) cadr(nth(i pp))+cadr(vec)))
					)
					obj~>bBox = tmp_pos
				)
				when(member(obj~>objType '("line" "polygon"))
					pp = obj~>points
					tmp_pos = list()
					for(i 0 obj~>nPoints-1
						tmp_pos = append1(tmp_pos list(car(nth(i pp))+car(vec) cadr(nth(i pp))+cadr(vec)))
					)
					obj~>points = tmp_pos
				)
				when(member(obj~>objType '("inst" "label"))
					obj~>xy = list(car(obj~>xy)+car(vec) cadr(obj~>xy)+cadr(vec))
				)
			)
		)

		procedure(move_right()
			let((selObj pp)
				foreach(selObj geGetSelSet()
					move_by_vector(selObj list(steprun 0))
				)
			)
		)
		procedure(move_left()
			let((selObj pp)
				foreach(selObj geGetSelSet()
					move_by_vector(selObj list(-steprun 0))
				)
			)
		)
		procedure(move_up()
			let((selObj pp)
				foreach(selObj geGetSelSet()
					move_by_vector(selObj list(0 steprun))
				)
			)
		)
		procedure(move_down()
			let((selObj pp)
				foreach(selObj geGetSelSet()
					move_by_vector(selObj list(0 -steprun))
				)
			)
		)
    )
)

hiSetBindKeys( "Schematics" list(list("Ctrl<Key>M" "move()")))
hiSetBindKeys( "Schematics" list(list("Shift<Key>Up" "move_up()")))
hiSetBindKeys( "Schematics" list(list("Shift<Key>Down" "move_down()")))
hiSetBindKeys( "Schematics" list(list("Shift<Key>Left" "move_left()")))
hiSetBindKeys( "Schematics" list(list("Shift<Key>Right" "move_right()")))

hiSetBindKeys( "Symbol" list(list("Ctrl<Key>M" "move()")))
hiSetBindKeys( "Symbol" list(list("Shift<Key>Up" "move_up()")))
hiSetBindKeys( "Symbol" list(list("Shift<Key>Down" "move_down()")))
hiSetBindKeys( "Symbol" list(list("Shift<Key>Left" "move_left()")))
hiSetBindKeys( "Symbol" list(list("Shift<Key>Right" "move_right()")))
