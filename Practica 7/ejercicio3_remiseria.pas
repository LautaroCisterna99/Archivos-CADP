program remiseria;
type
	cadena50=string[50];
	viaje = record
		numviaje:integer;
		codauto:integer;
		direccionO:cadena50;
		direccionD:cadena50;
		km:real;
	end;
	lista = ^nodo;
	nodo = record
		dato:viaje;
		sig:lista;
	end;
procedure leerviaje(var v:viaje);
begin
	writeln('ingrese numero de viaje');
	readln(v.numviaje);
	if(v.numviaje <>0) then begin
	writeln('Ingrese codigo de auto');
	readln(v.codauto);
	writeln('Ingrese la direccion de origen');
	readln(v.direccionO);
	writeln('Ingrese la direccion de destino');
	readln(v.direccionD);
	writeln('Ingrese los km recorridos');
	readln(v.km);
end;
end;
procedure insertarOrdenado(var pri:lista; v:viaje);
var
	nue,act,ant:lista;
begin
	new(nue);
	nue^.dato:=v;
	act:=pri;
	ant:=pri;
	while(act <> nil) and (v.codauto < act^.dato.codauto) do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act = ant) then pri:=nue
		else
			ant^.sig:=nue;
	nue^.sig:=act;
end;

procedure cargarLista(var l:lista); {se DISPONE}
var
	v:viaje;
begin
	l:=nil;
	leerviaje(v);
	while(v.numviaje <> 0) do begin
		insertarOrdenado(l,v);
		leerviaje(v);
	end;
end;

procedure dosmaximos(var kmax1,kmax2:real; var codmax1,codmax2:integer; kmactual:real;codactual:integer);
begin
	if(kmactual > kmax1) then begin
		kmax2:=kmax1;
		codmax2:=codmax1;
		kmax1:=kmactual;
		codmax1:=codactual;
	end
	else
		if(kmactual > kmax2) then begin
			kmax2:=kmactual;
			codmax2:=codactual;
		end;
end;

procedure procesarLista(l:lista; var pri2:lista; var codmax1,codmax2:integer);
var
	kmactual,kmax1,kmax2:real;
	codactual:integer;
begin
	codmax1:=0;
	codmax2:=0;
	kmax1:=-9999;
	kmax2:=-9999;
	while(l <> nil) do begin
		kmactual:=0;
		codactual:=l^.dato.codauto;
	while(l <> nil)and (codactual = l^.dato.codauto) do begin
		kmactual:= kmactual + l^.dato.km;
		if(l^.dato.km > 5) then insertarOrdenado(pri2,l^.dato);
	l:=l^.sig;
	end;
	dosmaximos(kmax1,kmax2,codmax1,codmax2,kmactual,codactual);
	end;
end;

var
	pri2,l:lista;
	codmax1,codmax2:integer;
begin
	cargarLista(l); {se dispone}
	procesarLista(l,pri2,codmax1,codmax2);
	writeln(' los codigos de los dos autos que mas kilometros recorrieron son:',codmax1,'y',codmax2);
end.
