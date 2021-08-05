{7. La Facultad de Informática desea procesar la información de los alumnos que finalizaron la carrera de
Analista Programador Universitario. Para ello se deberá leer la información de cada alumno, a saber:
número de alumno, apellido, nombres, dirección de correo electrónico, año de ingreso, año de egreso
y las notas obtenidas en cada una de las 24 materias que aprobó (los aplazos no se registran).
1. Realizar un módulo que lea y almacene la información de los alumnos hasta que se ingrese el
alumno con número de alumno -1, el cual no debe procesarse. Las 24 notas correspondientes a
cada alumno deben quedar ordenadas de forma descendente.
2. Una vez leída y almacenada la información del inciso 1, se solicita calcular e informar:
a. El promedio de notas obtenido por cada alumno.
b. La cantidad de alumnos ingresantes 2012 cuyo número de alumno está compuesto
únicamente por dígitos impares.
c. El apellido, nombres y dirección de correo electrónico de los dos alumnos que más rápido
se recibieron (o sea, que tardaron menos años)
3. Realizar un módulo que, dado un número de alumno leído desde teclado, lo busque y elimine de
la estructura generada en el inciso 1. El alumno puede no existir.}
program ejercicio7;
const
	DIMF = 24;
type
	rango = 1..DIMF;
	rango2=2016..2021;
	vectornotas = array[rango] of rango;
	cadena50=string[50];
	alumno = record
		nro:integer;
		apell:cadena50;
		nom:cadena50;
		correo:cadena50;
		anioI:rango2;
		anioE:rango2;
		notas:vectornotas;
	end;
	lista = ^nodo;
	nodo = record
		dato:alumno;
		sig:lista;
	end;

procedure cargarListaAlumnos(var l:lista);
procedure leeralumno(var a:alumno);
procedure insertarVector(var v:vectornotas;n:rango; dimL:integer);
	function buscarPos(x:integer;v:vectornotas;dimL:integer):integer;
	var
		pos:integer;
	begin
		pos:=1;
		while(pos <= dimL) and (x>v[pos]) do pos:=pos+1;
		buscarPos:=pos;
	end;
	procedure insertar(var v:vectornotas;dimL:integer;pos:integer;var j:integer; elem:nota);
	begin
		for j:= DimL downto pos do 
			v[j+1]:=v[j];
			v[pos]:=elem;
		end;
	var
		pos:integer;
	begin
		pos:=buscarPos(n,v,dimL);
		insertar(v,dimL,pos,n);
	end;
	var
		i:integer;n:rango;
	begin
		writeln('INGRESE EL CODIGO DEL OBJETO');
		readln(a.nro);
		if(o.cod <> -1) then begin
		writeln('INGRESE EL APELLIDO DEL ALUMNO');
		readln(a.apell);
		writeln('INGRESE EL NOMBRE DEL ALUNO');
		readln(a.nom);
		writeln('INGRESE EL CORREO ELECTRONICO');
		readln(a.correo);
		writeln('INGRESE EL ANIO DE INGRESO');
		readln(a.anioI);
		writeln('INGRESE EL ANIO DE EGRESO');
		readln(a.anioE);
		writeln('INGRESE LAS NOTAS DE 1 A ',DIMF);
			for i:=1 to DIMF do begin
				readln(n);
				insertarVector(a.notas,n,i-1);
			end;
		end;
	end;
begin
	
	end;
end;

procedure armarnodo(var llista;a:alumno);
var
	aux:lista;
begin
	new(aux);
	aux^.dato:=o;
	aux^.sig:=l;
	l:=aux;
end;
