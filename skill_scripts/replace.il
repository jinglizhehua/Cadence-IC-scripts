procedure(replace_MOS(sch_cv replaced_inst new_PDK newInstName)
    let((inst_name inst_xy inst_orient fw l m fingers targetId min_l max_w tmp_l tmp_w new_inst cdfgData param)
        inst_name = replaced_inst~>name
        inst_xy = replaced_inst~>xy
        inst_orient = replaced_inst~>orient
        ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        min_l = "600n"
        max_w = "100u"
        tmp_w = replaced_inst~>w
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

procedure(replace_res(sch_cv replaced_inst new_PDK newInstName)
    let((inst_name inst_xy inst_orient targetId new_inst cdfgData param segW segL segments connection)
        inst_name = replaced_inst~>name
        inst_xy = replaced_inst~>xy
        inst_orient = replaced_inst~>orient
        ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        segW = replaced_inst~>segw
        segL = replaced_inst~>segl
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

procedure(replace_fuse(sch_cv replaced_inst new_PDK newInstName)
    let((inst_name inst_xy inst_orient targetId new_inst cdfgData param segW segL)
        inst_name = replaced_inst~>name
        inst_xy = replaced_inst~>xy
        inst_orient = replaced_inst~>orient
        ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        segW = replaced_inst~>w
        segL = replaced_inst~>l
        ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        targetId = dbOpenCellViewByType(new_PDK newInstName "symbol" "" "r")
        if(targetId then
            dbDeleteObject(replaced_inst)
            dbCreateInst(sch_cv targetId inst_name inst_xy inst_orient 1)
            new_inst = dbGetInstByName(sch_cv inst_name)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            new_inst~>w = segW
            new_inst~>l = segL
            ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            cdfgData=cdfGetInstCDF(new_inst)
			PasCdfFormInit(cdfgData)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            (foreach pName list("w" "l")
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

procedure(replace_MIM_CAP(sch_cv replaced_inst new_PDK newInstName)
    let((inst_name inst_xy inst_orient targetId new_inst cdfgData param l w m)
        inst_name = replaced_inst~>name
        inst_xy = replaced_inst~>xy
        inst_orient = replaced_inst~>orient
        ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        l = replaced_inst~>l
		w = replaced_inst~>w
		m = replaced_inst~>m
        ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		unless(m
			m = "1"
		)
        targetId = dbOpenCellViewByType(new_PDK newInstName "symbol" "" "r")
        if(targetId then
            dbDeleteObject(replaced_inst)
            dbCreateInst(sch_cv targetId inst_name inst_xy inst_orient 1)
            new_inst = dbGetInstByName(sch_cv inst_name)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            new_inst~>w = w
			new_inst~>l = l
			;new_inst~>m = m
			new_inst~>nf = "1"
            ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            cdfgData=cdfGetInstCDF(new_inst)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            (foreach pName list("w" "l")
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

procedure(replace_PNP(sch_cv replaced_inst new_PDK)
    let((inst_name inst_xy inst_orient targetId new_inst cdfgData param m w newInstName)
        inst_name = replaced_inst~>name
        inst_xy = replaced_inst~>xy
        inst_orient = replaced_inst~>orient
        ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        m = replaced_inst~>m
		w = replaced_inst~>w
        ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		unless(m
			m = "1"
		)
		newInstName = ""
		if(ciToFloat(w) == ciToFloat("2u")
			newInstName = "vpnp2_mv"
		)
		if(ciToFloat(w) == ciToFloat("5u")
			newInstName = "vpnp5_mv"
		)
        targetId = dbOpenCellViewByType(new_PDK newInstName "symbol" "" "r")
        if(targetId then
            dbDeleteObject(replaced_inst)
            dbCreateInst(sch_cv targetId inst_name inst_xy inst_orient 1)
            new_inst = dbGetInstByName(sch_cv inst_name)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            new_inst~>m= m
            ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            cdfgData=cdfGetInstCDF(new_inst)
			PasCdfFormInit(cdfgData)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            (foreach pName list("m")
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

procedure(replace_DIO(sch_cv replaced_inst new_PDK newInstName)
    let((inst_name inst_xy inst_orient targetId new_inst cdfgData param m w newInstName)
        inst_name = replaced_inst~>name
        inst_xy = replaced_inst~>xy
        inst_orient = replaced_inst~>orient
        ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        targetId = dbOpenCellViewByType(new_PDK newInstName "symbol" "" "r")
        if(targetId then
            dbDeleteObject(replaced_inst)
            dbCreateInst(sch_cv targetId inst_name inst_xy inst_orient 1)
            new_inst = dbGetInstByName(sch_cv inst_name)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            cdfgData=cdfGetInstCDF(new_inst)
			PasCdfFormInit(cdfgData)
            ;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            (foreach pName list("m")
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
procedure(replace(replaced_lib)
    let((cell_list sch_cv new_PDK new_PMOS new_NMOS new_res old_PDK old_PMOS old_NMOS old_res)
		;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        new_PDK = "silterraD18W"
        new_PMOS = "mpto_5"
        new_NMOS = "mnto_5"
        new_res = "mpplyb"
        new_res_POLY = "mpplyb"
        new_res_NWELL = "mndiffb"
		new_fuse_PDK = "common_3M"
		new_fuse = "polyfuse_pre"
		new_MIM_CAP = "nvarlf_5"
		new_DIO = "pns10_mv"

        old_PDK = "NDP4135_TOP"
        old_PMOS = "PMOS4"
        old_NMOS = "NMOS4"
        old_res = "res"
		old_res_POLY = "res_POLY"
		old_res_NWELL = "res_NWELL"
		old_fuse = "res_FUSE"
		old_PNP = "pnp"
		old_MIM_CAP = "CAP_MIM"
		old_DIO = "pdiode"
		;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		
		println("************************ start *********************")
        cell_list = ddGetObj(replaced_lib)~>cells~>name
        foreach(cell cell_list
            printf("replace cell: %s\n" cell)
            sch_cv = dbOpenCellViewByType(replaced_lib cell "schematic" "schematic" "a")
            if(sch_cv then
                foreach(inst sch_cv~>instances
                    cond(
                        (inst~>cellName == old_PMOS
                            replace_MOS(sch_cv inst new_PDK new_PMOS)
                        )
                        (inst~>cellName == old_NMOS
                            replace_MOS(sch_cv inst new_PDK new_NMOS)
                        )
                        (inst~>cellName == old_res
                            replace_res(sch_cv inst new_PDK new_res)
                        )
                        (inst~>cellName == old_res_POLY
                            replace_res(sch_cv inst new_PDK new_res_POLY)
                        )
                        (inst~>cellName == old_res_NWELL
                            replace_res(sch_cv inst new_PDK new_res_NWELL)
                        )
                        (inst~>cellName == old_fuse
                            replace_fuse(sch_cv inst new_fuse_PDK new_fuse)
                        )
                        (inst~>cellName == old_PNP
                            replace_PNP(sch_cv inst new_PDK)
                        )
                        (inst~>cellName == old_MIM_CAP
                            replace_MIM_CAP(sch_cv inst new_PDK new_MIM_CAP)
                        )
						(inst~>cellName == old_DIO
                            replace_MIM_CAP(sch_cv inst new_PDK new_DIO)
                        )
                    );cond
                );foreach
            );if
            dbCheck(sch_cv)
            dbSave(sch_cv)
            dbClose(sch_cv)
        );foreach
		println("************************ done *********************")
    );let
)

