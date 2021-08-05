{La tienda de libros Amazon Books está analizando información de algunas editoriales. Para
ello, Amazon cuenta con una tabla con las 35 áreas temáticas utilizadas para clasificar los
libros (Arte y Cultura, Historia, Literatura, etc.).
De cada libro se conoce su título, nombre de la editorial, cantidad de páginas, año de
edición, cantidad de veces que fue vendido y código del área temática (1..35).
Realizar un programa que:
A) Invoque a un módulo que lea la información de los libros hasta ingresar el título
“Relato de un náufrago” (que debe procesarse) y devuelva en una estructura de
datos adecuada para la editorial “Planeta Libros”, con la siguiente información:
- Nombre de la editorial
- Año de edición del libro más antiguo
- Cantidad de libros editados
- Cantidad total de ventas entre todos los libros
- Detalle con título, nombre del área temática y cantidad de páginas de todos
los libros con más de 250 ventas.
B) Invoque a un módulo que reciba la estructura generada en A) e imprima el nombre
de la editorial y el título de cada libro con más de 250 ventas.}

program Amazon;
type
	rango=1..35;
	cadena30=string[30];
	libro=record
		titulo:cadena30;
		editorial:cadena30;
		paginas:integer;
		anioed:integer;
		cant:integer;
		area:rango;
	end;
	libros=record
		titulo:cadena30;
		area:cadena30;
		paginas:integer;
	end;
	
	lista=^nodo;
	nodo=record
		dato:libros;
		sig:lista;
	end;
	estructura=record
		nombreed:cadena30;
		menoranio:integer;
		cantidad:integer;
		ventas:integer;
		librosesp:lista;
	end;

	vectortabla=array[rango] of cadena30;



procedure leerlibro(var l:libro);

begin
	readln(l.titulo);
	readln(l.editorial);
	readln(l.paginas);
	readln(l.anioed);
	readln(l.cant);
	readln(l.area);
end;



procedure cargarlista(var librosesp:lista; l:libro;vt:vectortabla);
var 
	aux:lista;
begin
	new(aux);
	aux^.dato.titulo:=l.titulo;
	aux^.dato.area:=vt[l.area];
	aux^.dato.paginas:=l.paginas;
	aux^.sig:=librosesp;
	librosesp:=aux;
end;




procedure leerlibros (var e:estructura; vt:vectortabla);

var
	l:libro;
begin
	e.cantidad:=0;
	e.ventas:=0;
	e.menoranio:=10000;
	e.nombreed:='Planeta libros';
	repeat
		leerlibro(l);
		if(l.editorial='Planeta libros') then
		begin
			if(l.anioed<e.menoranio) then
				e.menoranio:=l.anioed;
			e.cantidad:=e.cantidad+1;
			e.ventas:=e.ventas+l.cant;
			if(l.cant>250) then
				cargarLista(e.librosesp,l,vt);
		end;
			
			
	until (l.titulo='Relato de un naufrago');
end;


procedure Informar(e:estructura);
begin
	while(e.librosesp<>nil) do
	begin
		writeln('El libro',e.librosesp^.dato.titulo,'de la editorial',e.nombreed,'tiene mas de 250 ventas');
		e.librosesp:=e.librosesp^.sig;
	end;
end;

var 
	e:estructura;
	vt:vectortabla;
	pri: lista;
begin
	pri:=nil;
	leerlibros(e,vt);
	Informar (e);
end.






