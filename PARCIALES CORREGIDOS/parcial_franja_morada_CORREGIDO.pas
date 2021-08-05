program empresa;
type
    rango = 'a'..'e';
    cadena50=string[50];
    vpremios= array[1..5] of real;
    empleado = record
        dni:integer;
        apell:cadena50;
        nom:cadena50;
        categoria:rango;
        sueldo:real;
        monto:vpremios;
        cantpremios:integer;
        antiguedad:integer;
    end;
    vcontador = array[rango] of integer;
   lista = ^nodo;
   nodo = record
	dato:empleado;
	sig:lista;
	end;
procedure inicializarvector(var vc:vcontador);
var
    i:char;
begin
    for i:='a' to 'e' do
        vc[i]:=0;
    end;


procedure leerempleado(var e:empleado);
var
    aux:real;
begin
	writeln('Dni del empleado');
    readln(e.dni);
    if(e.dni<>-1) then begin
		writeln('Apellido');
        readln(e.apell);
        writeln('Nombre:');
        readln(e.nom);
        writeln('Categoria de A a E');
        readln(e.categoria);
        writeln('Sueldo basico:');
        readln(e.sueldo);
        e.cantpremios:=0;
        aux:=0;
        writeln('monto de premios');
        readln(aux);
        while(e.cantpremios<5) do begin
            e.cantpremios:=e.cantpremios+1;
            e.monto[e.cantpremios]:=aux;
            writeln('monto de premios');
            readln(aux);
        end;
        writeln('Antiguedad en la empresa');
        readln(e.antiguedad);
    end;
end;

procedure insertarOrdenado(var l:lista;e:empleado);
var
    ant,act,nue:lista;
begin
    new(nue);
    nue^.dato:=e;
    ant:=l;
    act:=l;
    while(act<>nil) and (act^.dato.dni < e.dni) do begin
        ant:=act;
        act:=act^.sig;
    end;
    if(act=ant) then l:=nue
    else
        ant^.sig:=nue;
    nue^.sig:=act;
end;

procedure cargarlista(var l:lista);
var
    e:empleado;
begin
    l:=nil;
    leerempleado(e);
    while(e.dni<>-1) do begin
        insertarOrdenado(l,e);
        leerempleado(e);
    end;
end;
function calcularsueldomensual(categoria:rango;v:vpremios;dimL:integer;antiguedad:integer;sueldo:real):real;
begin
    if(categoria = 'a')or(categoria = 'b')or(categoria = 'c') then calcularsueldomensual:=sueldo+v[dimL]
    else
    if(categoria = 'd')or(categoria = 'e')then calcularsueldomensual := v[dimL]+1000*antiguedad;
end;

procedure armarNodo(var pri:lista; dni:integer; sueldo:real);
var
    aux:lista;
begin
    new(aux);
    aux^.dato.dni:=dni;
    aux^.dato.sueldo:=sueldo;
    aux^.sig:=pri;
    pri:=aux;
end;
procedure Informar(vc:vcontador);
var
    i:char;
begin
    for i:='a' to 'e' do begin
        writeln('hay',vc[i],'empleados en la categoria',i);
    end;
end;

procedure eliminar(var l:lista;x:integer;var exito:boolean);
var
    ant,act:lista;
begin
	exito:=false;
    ant:=l;
    act:=l;
    while(act<>nil) and (act^.dato.dni <> x) do begin
        ant:=act;
        act:=act^.sig;
    end;
    if(act<>nil ) then begin
        exito:=true;
        if(act=l) then l:=act^.sig
        else
            ant^.sig:=act^.sig;
    dispose(act);
end;
end;

procedure procesarlista(l:Lista; var vc:vcontador; var pri:lista);
var
    sueldoT:real;
begin
    pri:=nil;
    while(l<>nil)do begin
        vc[l^.dato.categoria]:=vc[l^.dato.categoria]+1;
        sueldoT:=0;
        sueldoT:=calcularsueldomensual(l^.dato.categoria,l^.dato.monto,l^.dato.cantpremios,l^.dato.antiguedad,l^.dato.sueldo);
        armarNodo(pri,l^.dato.dni,sueldoT);
        l:=l^.sig;
    end;
end;
procedure recorrerlista(pri:lista);
begin
	while(pri<>nil) do begin
		writeln('LISTA NUEVA');
	    writeln('dni',pri^.dato.dni);
	    writeln('sueldo',pri^.dato.sueldo:2:2);
	pri:=pri^.sig;
	end;
end;
var
    l,pri:lista;
    vc:vcontador;
    exito:boolean;
begin
    cargarlista(l);
    procesarlista(l,vc,pri);
    Informar(vc);
    recorrerlista(pri);
    eliminar(l,555,exito);
    if(exito) then writeln('se borro con exito')
    else
		writeln('no existe o no se elimino');
end.
