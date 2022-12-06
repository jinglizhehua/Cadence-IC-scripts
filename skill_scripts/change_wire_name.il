procedure( replace_symbol_pin_name(libName CellName PinName NewName)
prog((symcv order term_net term neworder)
	symcv = dbOpenCellViewByType(libName CellName "symbol" "" "a")
	order = symcv~>portOrder
	term = dbFindTermByName(symcv PinName)
	term~>name = NewName
	;old_net = dbFindNetByName(symcv PinName)
	;term_net = dbMakeNet(symcv NewName)
	;dbMergeNet(term_net old_net)
	
	neworder = list()
	unless(order
		return(nil)
	)
	foreach(item order
		if(item == PinName
			item = NewName
		)
		neworder = append1(neworder item)
	)
	symcv~>portOrder = neworder
	printf("## change symbol pin: %s-%s: %s -> %s\n" libName CellName PinName NewName)
	schVIC(symcv)
	dbSave(symcv)
	dbClose(symcv)
	return(t)
)
)

procedure( change_pin_name(inLibName inCellName oldName newName)
let((cv_sch)
	;change wire name
	change_wire_name(inLibName inCellName oldName newName)
	;change pin name
	cv_sch = dbOpenCellViewByType(inLibName inCellName "schematic" "" "a")
	dbFindTermByName(cv_sch oldName)~>name = newName
	printf("## change schematic pin: %s-%s: %s -> %s\n" inLibName inCellName oldName newName)
	;change symbol pin name
	replace_symbol_pin_name(inLibName inCellName oldName newName)
	schCheck(cv_sch)
	dbSave(cv_sch)
	dbClose(cv_sch)
)
)

procedure( change_wire_name(libName cellName oldName newName)
let((cv net pinName)
	cv = dbOpenCellViewByType(libName cellName "schematic" "" "a")
	net = dbFindNetByName(cv oldName)
	;from terms change pin name
	foreach(term net~>allInstTerms
		if(term~>inst~>libName == libName
		then
			change_pin_name(libName term~>inst~>cellName term~>name newName)
		)
	)
	;change wire name
	net~>figs~>theLabel = newName
	printf("## change wire: %s-%s: %s -> %s\n" libName cellName oldName newName)
	schCheck(cv)
	dbSave(cv)
	dbClose(cv)
)
)

procedure( change_wire_name_main(newName)
let((wire cellName libName)
	wire = car(geGetSelectedSet())
	cellName = wire~>cellView~>cellName
	libName = wire~>cellView~>lib~>name
	printf("*********start change wire name**********\n")
	change_wire_name(libName cellName wire~>net~>name newName)
	printf("*********finish**********\n")
)
)

procedure(change_wire_name_window()
	prog((NEWNAME REPLACE)
		NEWNAME = hiCreateStringField(
			?name 'newName
			?prompt "new name"
			?callback nil
			?editable t
		);hiCreateStringField

		hiCreateAppForm(
			?name             'REPLACE
			?formTitle        "replace name"
			?fields           list(NEWNAME)         
			?callback         nil               
			?buttonLayout     'OKCancel
		)
		REPLACE~>newName~>value = ""
		unless(hiDisplayForm(REPLACE)
			return(nil)
		)
		change_wire_name_main(REPLACE~>newName~>value)
		return(t)
	)
)

hiSetBindKeys( "Schematics" list(list("Ctrl<Key>H"	"change_wire_name_window()")))
