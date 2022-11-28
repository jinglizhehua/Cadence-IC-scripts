procedure(arrange()
	let((HORIZON VERTICAL pins_str selObj tmpObj sortfun)
		HORIZON = hiCreateStringField(
			?name 'horizon
			?prompt "horizon"
			?callback nil
			?editable t
		);hiCreateStringField
		VERTICAL = hiCreateStringField(
			?name 'vertical
			?prompt "vertical"
			?callback nil
			?editable t
		);hiCreateStringField

		hiCreateAppForm(
			?name             'range
			?formTitle        "arrange"
			?fields           list(HORIZON VERTICAL)         
			?callback         nil
			?help             "formHelp"                
			?buttonLayout     'OKCancel
		)
		range~>horizon~>value = "0"
		range~>vertical~>value = "0"
		hiDisplayForm(range)
		selObj = geGetSelSet()
		tmpObj = list()
		foreach(obj selObj
			when(obj~>objType == "inst"
				tmpObj = append1(tmpObj obj)
			)
		)
		selObj = tmpObj
		
		procedure(sortfun(num1 num2)
			cond(
				(car(num1~>xy) < car(num2~>xy) t)
				(t nil)
			)
		)
		selObj = sort(selObj 'sortfun)
		dx = ciToFloat(range~>horizon~>value)
		dy = ciToFloat(range~>vertical~>value)
		nowx = car(car(selObj)~>xy)
		nowy = cadr(car(selObj)~>xy)
		foreach(obj selObj
			obj~>xy = list(nowx nowy)
			nowx = nowx + dx
			nowy = nowy + dy
		)	
		t
	)
)

hiSetBindKeys( "Schematics" list(list("Ctrl<Key>O"	"arrange()")))
