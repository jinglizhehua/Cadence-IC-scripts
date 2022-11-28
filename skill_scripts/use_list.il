procedure(use_list()
	let((replaced_lib lib_name check_list cell_list use_list cnt path cell sch_cv inst)
		replaced_lib = "HTL4056_sch_local"
		lib_name = "silterraD18W"
		check_list = list("DION" "DPMOSCAP_N" "DPMOSCAP_P" "METALFUSE1" "NASY4" "NMOS4" "PASY4" "PMOS4" "PMOS4_1" "POLYCAP" "PSYM4" "RNPOLY_1" "RNPOLY_2" "RPPOLY_2" "VPNP")

		cell_list = ddGetObj(replaced_lib)~>cells~>name
		use_list = list()
		cnt = makeTable('cnt)
		path = makeTable('path)
		foreach(cell cell_list
			sch_cv = dbOpenCellViewByType(replaced_lib cell "schematic" "schematic" "r")
			if(sch_cv then
				foreach(inst sch_cv~>instances
					when(member(inst~>cellName check_list)
						when(member(inst~>cellName use_list)
							cnt[inst~>cellName] = cnt[inst~>cellName] + 1
							path[inst~>cellName] = append1(path[inst~>cellName] sch_cv~>cellName)
						)
						unless(member(inst~>cellName use_list)
							use_list = append1(use_list inst~>cellName)
							cnt[inst~>cellName] = 1
							path[inst~>cellName] = list(sch_cv~>cellName)
						)
					)
				)
			)
		)
		foreach(use use_list
			printf("%s\n" use)
			printf("count: %d\n" cnt[use])
			printf("path: ")
			foreach(tmp path[use]
				printf("%s " tmp)
			)
			printf("\n*******************************************\n")
		)
	)
)
