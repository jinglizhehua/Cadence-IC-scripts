procedure(replace_4056res(sch_cv replaced_inst new_PDK newInstName)
    let((inst_name inst_xy inst_orient targetId new_inst cdfgData param segW segL segments connection)
        inst_name = replaced_inst~>name
        inst_xy = replaced_inst~>xy
        inst_orient = replaced_inst~>orient
        ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        segW = replaced_inst~>segW
        segL = replaced_inst~>segL
        segments = replaced_inst~>segments
        connection = replaced_inst~>connection
        ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		targetId = dbOpenCellViewByType(new_PDK newInstName "symbol" "" "r")
        if(targetId then
            dbDeleteObject(replaced_inst)
            dbCreateInst(sch_cv targetId inst_name inst_xy inst_orient 1)
            new_inst = dbGetInstByName(sch_cv inst_name)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            new_inst~>segW = segW
            new_inst~>segL = segL
            new_inst~>segments = segments
            ;new_inst~>connection = connection
            ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            cdfgData=cdfGetInstCDF(new_inst)
			PasCdfFormInit(cdfgData)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            (foreach pName list("segW" "segL" "segments" "connection")
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

procedure(replace4056(replaced_lib)
    let((cell_list sch_cv new_PDK new_PMOS new_NMOS new_res old_PDK old_PMOS old_NMOS old_res is_replaced)	
	println("************************ start *********************")
        cell_list = ddGetObj(replaced_lib)~>cells~>name
        foreach(cell cell_list
            is_replaced = nil
            sch_cv = dbOpenCellViewByType(replaced_lib cell "schematic" "schematic" "a")
            if(sch_cv then
                foreach(inst sch_cv~>instances
                    cond(
                        (inst~>cellName == "mpplyb"
                            replace_4056res(sch_cv inst "silterraD18W" "mpplyb")
                            is_replaced = t
                        )
                    );cond
                );foreach
            );if
            dbCheck(sch_cv)
            dbSave(sch_cv)
            dbClose(sch_cv)
            if(is_replaced then
                printf("replace cell: %s\n" cell)
            )
        );foreach
	println("************************ done *********************")
    );let
)
