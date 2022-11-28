procedure(delNetNames(worklib del_name_height)
	let((cell_list sch_cv)
		cell_list = ddGetObj(worklib)~>cells~>name

		println("************************ start ******************************")

		foreach(cell cell_list
			sch_cv = dbOpenCellViewByType(worklib cell "schematic" "schematic" "a")
			if(sch_cv then
				foreach(net sch_cv~>nets
					foreach(fig net~>figs
						if(fig~>height == del_name_height then
							dbDeleteObject(fig)
						);if
					);foreach fig
				);foreach net
			);if
			dbCheck(sch_cv)
            dbSave(sch_cv)
            dbClose(sch_cv)
		);foreach
		println("************************ done ******************************")
	);let
)
