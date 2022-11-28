procedure(replace_select_MOS(sch_cv replaced_inst new_PDK newInstName)
    let((inst_name inst_xy inst_orient fw l m fingers targetId min_l max_w tmp_l tmp_w new_inst cdfgData param)
        inst_name = replaced_inst~>name
        inst_xy = replaced_inst~>xy
        inst_orient = replaced_inst~>orient
        ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        min_l = "600n"
        max_w = "100u"
        tmp_w = replaced_inst~>fw
        tmp_l = replaced_inst~>l
        ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		if(ciToFloat(tmp_w) > ciToFloat(max_w)
			tmp_w = max_w
		)
		if(ciToFloat(tmp_l) < ciToFloat(min_l)
			tmp_l = min_l
		)
        ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        fw = artMakeString(tmp_w)
        l = artMakeString(tmp_l)
        m = replaced_inst~>m
        fingers = replaced_inst~>fingers
        ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        unless(m
		m = "1"
        )
	unless(fingers
		fingers = "1"
        )
        targetId = dbOpenCellViewByType(new_PDK newInstName "symbol" "" "r")
        if(targetId then
            dbDeleteObject(replaced_inst)
            dbCreateInst(sch_cv targetId inst_name inst_xy inst_orient 1)
            new_inst = dbGetInstByName(sch_cv inst_name)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            new_inst~>fw = fw
            new_inst~>l = l
            new_inst~>m = m
            new_inst~>fingers = fingers
            ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            cdfgData=cdfGetInstCDF(new_inst)
			PasCdfFormInit(cdfgData)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            (foreach pName list("m" "l" "fw" "fingers")
            ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                param=cdfFindParamByName(cdfgData pName)
                (when param~>callback
                    evalstring(param~>callback)
                );when
            );foreach
            dbClose(targetId)
        )
    )
)

procedure(replace_select()
	let((selMOS selCellView sch_cv replace_select_MOS)
		foreach(selMOS geGetSelectedSet()
			if((selMOS~>cellName == "mp5")||(selMOS~>cellName == "mn5") then
				printf("replace %s    " selMOS~>name)
				selCellView = selMOS~>cellView
				sch_cv = dbOpenCellViewByType(selCellView~>libName selCellView~>cellName "schematic" "schematic" "a")
				replace_select_MOS(sch_cv selMOS selMOS~>libName selMOS~>cellName)
				printf("done.\n")
			)
		);foreach
	)
)

hiSetBindKeys( "Schematics" list(list("Ctrl<Key>I"	"replace_select()")))
