procedure(calc_area()
	let((insts area_sum inst AREASUM)
		insts = geGetSelectedSet()
		area_sum = 0.0
		foreach( inst insts
			if( inst~>segW
			then
				if( ciToFloat(inst~>segments)
				then
					instseg = ciToFloat(inst~>segments)
				else
					instseg = 1
				)
				area_sum = area_sum + ciToFloat(inst~>segW)*ciToFloat(inst~>segL)*instseg*1e12
			else
				if( inst~>w
				then
					if( ciToFloat(inst~>m)
					then
						instm = ciToFloat(inst~>m)
					else
						instm = 1
					)
					area_sum = area_sum + ciToFloat(inst~>w)*ciToFloat(inst~>l)*instm*1e12
				)
			)	
		)
		;printf("area = %f\n" area_sum)

		AREASUM = hiCreateStringField(
			?name 'areasum
			?prompt "areasum"
			?callback nil
			?editable t
		);hiCreateStringField

		hiCreateAppForm(
			?name             'area
			?formTitle        "area"
			?fields           list(AREASUM)         
			?callback         nil
			?help             "formHelp"                
			?buttonLayout     'OKCancel
		)
		area~>areasum~>value = artMakeString(area_sum)
		hiDisplayForm(area)
	)
)

hiSetBindKeys( "Schematics" list(list("Ctrl<Key>U"	"calc_area()")))
