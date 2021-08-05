{La Facultad de Informática desea procesar la información de los alumnos que finalizaron la carrera de Analista Programador Universitario. 
Para ello se deberá leer la información de cada alumno, a saber: número de alumno, apellido, nombres, dirección de correo electrónico, año de ingreso, 
año de egreso y las notas obtenidas en cada una de las 24 materias que aprobó (los aplazos no se registran). 
1. Realizar un módulo que lea y almacene la información de los alumnos hasta que se ingrese el alumno con número de alumno -1, el cual no debe procesarse. 
Las 24 notas correspondientes a cada alumno deben quedar ordenadas de forma descendente. 
2. Una vez leída y almacenada la información del inciso 1, se solicita calcular e informar: 
   a. El promedio de notas obtenido por cada alumno. 
   b. La cantidad de alumnos ingresantes 2012 cuyo número de alumno está  compuesto únicamente por dígitos impares. 
   c. El apellido, nombres y dirección de correo electrónico de los dos alumnos que más rápido se recibieron (o sea, que tardaron menos años) 
3. Realizar un módulo que, dado un número de alumno leído desde teclado, lo busque y elimine de la estructura generada en el inciso 1. El alumno puede no existir.
}

program ejer7repaso;
const dimF = 24;
type
  cadena20 = string[20];
  subrango = 2015..2020;
  nota = 4..10;
  vector = array [1..dimF] of nota;
  alumno = record
             num: integer;
             apellido: cadena20;
             nombre: cadena20;
             correoE: cadena20;
             anioI: subrango;
             anioE: subrango;
             notas: vector;
           end;
  lista = ^nodo;
  nodo = record
           datos: alumno;
           sig: lista;
         end;  
         
procedure CargarListaAlumnos (var pri: lista);
  procedure LeerAlumno (var a: alumno);
  
    procedure InsertarVector (var v: vector; n: nota; dimL: integer);
      Function BuscarPos (x: integer; v:Vector; dimL: integer): integer; 
      var pos : integer;  
      begin    
        pos:=1;
        while (pos <= dimL) and (x > v[pos]) do
          pos:=pos+1;
        BuscarPos:= pos;
      end; 
      Procedure Insertar (var v:vector; dimL:integer; pos: integer; elem: nota);
      var j: integer;    
      begin
        for j:= dimL downto pos do
          v [ j +1 ] := v [ j ] ;
        v [ pos ] := elem;
      end;
  
    var pos: integer;
    Begin
      pos:= BuscarPos (n, v, dimL);
      Insertar (v, dimL, pos, n);
    end;
  
  var i: integer; n: nota;
  begin
    read (a.num);
    if (a.num <> -1) then 
    begin  
      read (a.apellido);
      read (a.nombre);
      read (a.correoE);
      read (a.anioI);
      read (a.anioE);
      for i:=1 to dimF do
      begin
        read (n);
        InsertarVector (a.notas, n, i-1);
      end;
    end;
  end; 
  procedure AgregarAdelante (var pri: lista; a: alumno);
  var aux: lista;
  begin
    new(aux);
    aux^.datos:=a;
    aux^.sig:=pri;
    pri:=aux;
  end;
  
var a: alumno;
begin
  pri:= nil;
  LeerAlumno (a);
  while (a.num<>-1) do
  begin
    AgregarAdelante (pri, a);
    LeerAlumno (a);
  end;
end;

procedure ProcesarAlumnos (pri: lista);

 function promedio (v: vector): real;
 var i: integer; suma: integer;
 begin
   suma:= 0;
   for i:= 1 to dimF do
     suma:=suma + v[i];
   promedio:= suma / dimF;
 end;
 function cumple (num: integer): boolean;
 var aux:boolean;
 begin
   aux:=true;
   while (num<>0) and (aux) do 
    if((num mod 10) mod 2 = 0) then aux:=false
                               else num:=num div 10;
   cumple:=aux;
 end;
 procedure Minimos (a: alumno; var min1, min2: integer; var alu1, alu2: alumno);
 begin
   if ((a.anioE-a.anioI) < min1)
   then begin
          min2:= min1;
          alu2:=alu1; 
          min1:= a.anioE-a.anioI;
          alu1:= a;
        end
    else if ((a.anioE-a.anioI) < min2)
         then begin
                min2:= a.anioE-a.anioI;
                alu2:= a;
              end;
 end;
           
 
var cantI: integer;
    alu1, alu2: alumno;
    min1, min2: integer;
begin
  cantI:= 0;
  min1:= 999;
  while (pri <> nil) do
  begin
    writeln ('Promedio: ', promedio(pri^.datos.notas):2:2); 
    if (cumple (pri^.datos.num) ) then cantI:= cantI + 1;    
    Minimos (pri^.datos, min1, min2, alu1, alu2);
    pri:=pri^.sig;
  end;
  writeln ('Cantidad ingresantes 2012 con...' , cantI);
  writeln ('Primer alumno mas rapido:', alu1.apellido, alu1.nombre, alu1.correoE);
  writeln ('Segundo alumno mas rapido:', alu2.apellido, alu2.nombre, alu2.correoE);
end;
  
var pri: lista;
begin
  CargarListaAlumnos (pri);
  ProcesarAlumnos (pri);
end.        
