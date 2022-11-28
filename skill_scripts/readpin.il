procedure(sortfun(obj1 obj2)
    let((atan1 atan2)
        atan1 = atan2((cadr(obj1~>pos) - miny - 0.1), (car(obj1~>pos) - minx - 0.1))
        atan2 = atan2((cadr(obj2~>pos) - miny - 0.1), (car(obj2~>pos) - minx - 0.1))
		when(atan1 > 3.141592653579897 / 2
			atan1 = atan1 - 3.141592653579897 * 2
		)
		when(atan2 > 3.141592653579897 / 2
			atan2 = atan2 - 3.141592653579897 * 2
		)
        cond(
            (atan1 < atan2 t)
            (t nil)
        )
    )
)

procedure(readpin()
    let((PINS pin_tb pin_tbs minx miny selObj selInstMasterCV pins_str pins_pos sortfun)
        PINS = hiCreateStringField(
            ?name       'pins
            ?prompt     "pins"
            ?callback   nil
            ?editable   t
        )
        hiCreateAppForm(
            ?name       'Pins_Array
            ?formTitle  "PINS"
            ?fields     list(PINS)
            ?callback   nil
            ?help       "formHelp"
            ?buttonLayout   'OKCancel
        )
        pin_tbs = list()
        minx = 9999
        miny = 9999

        selObj = car(geGetSelSet())
        selInstMasterCV = dbOpenCellViewByType(selObj~>master~>libName selObj~>master~>cellName "symbol" "" "r")
        pins_str = ""
        foreach(term selInstMasterCV~>terminals
            pin_tb = makeTable( "Skill HASH" )
            pins_pos = centerBox(car(term~>pins)~>fig~>bBox)
            when(minx > car(pins_pos)
                minx = car(pins_pos)
            )
            when(miny > cadr(pins_pos)
                miny = cadr(pins_pos)
            )
            pin_tb['name] = term~>name
            pin_tb['pos] = pins_pos
            pin_tbs = append1(pin_tbs pin_tb)
        )
        pin_tbs = sort(pin_tbs 'sortfun)
        foreach(pin pin_tbs
            pins_str = strcat(pins_str strcat(pin~>name " "))
        )
        Pins_Array~>pins~>value = pins_str
        hiDisplayForm(Pins_Array)
    )
)

hiSetBindKeys( "Schematics" list(list("Ctrl<Key>P" "readpin()")))
