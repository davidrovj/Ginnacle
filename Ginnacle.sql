create database Ginnacle;
use Ginnacle;

select * from recordatorios;

create table Ginecologo(
    ID int primary key auto_increment,
    Nombre varchar(25),
    ApellidoP varchar (20),
    ApellidoM varchar (20),
    email varchar (30),
    contraseña varchar (25),
    numPacientes int,
    telefono varchar(10)
);

create table Pacientes(
    NumExpediente int primary key auto_increment,
    Nombre varchar(25),
    ApellidoP varchar(20),
    ApellidoM varchar(20),
    Telefono varchar(10),
    Edad int,
    Peso float,
    FUM date,
    Activo boolean,
    Sangre enum ('O+', 'O-','A+','A-','B+','B-', 'AB+', 'AB-'),
    Alergias varchar(100),
    Embarazo boolean,
    Diagnostico varchar(300),
    Ginecologo int,
    
    foreign key (Ginecologo) references Ginecologo (ID) 
);

create table Recordatorios(
    Etiqueta varchar(50),
    Fecha date,
    Hora time,
    Descripcion varchar(200),
    Completado boolean,
    Prioridad enum ('Urgencia','Emergencia'),
    Paciente int,
    Ginecologo int,
    
    primary key(Ginecologo, Paciente, Fecha, Hora)
);

select * from ginecologo;
select * from Recordatorios;
select * from pacientes;

select nombre,numPacientes from ginecologo where numPacientes >2;

select etiqueta, descripcion, paciente, completado from recordatorios where completado = true;
-- drop database ginnacle;

select nombre, apellidop, apellidom from pacientes where sangre = "O-";


-- PROCEDURE "registrarPaciente
drop procedure if exists registrarPaciente;
delimiter //
create procedure registrarPaciente (in matricula int, in nombreP varchar(25), in apellidoPat varchar(20), in apellidoMat varchar(20),
									in tel varchar(10), in edadP int, in peso float, in menst date, in act boolean,
                                    in blood enum('O+', 'O-','A+','A-','B+','B-', 'AB+', 'AB-'), in alergy varchar(100), 
                                    in pregnant boolean, in diagnost varchar(300), in doctor int, out msg varchar (80))
	BEGIN	
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
			SHOW ERRORS LIMIT 1;
            ROLLBACK;
        END;
        
        DECLARE EXIT HANDLER FOR SQLWARNING
        BEGIN
			SHOW WARNINGS LIMIT 1;
            ROLLBACK;
		END;
        
        start transaction;
        if exists(select NumExpediente,Ginecologo from pacientes where NumExpediente = matricula and Ginecologo = doctor) then
			set msg = "El paciente ya se encuentra registrado.";
        
        elseif now() < fechaIngreso then
			set msg = "Inserte una fecha válida.";
        else
			insert into pacientes (NumExpediente, Nombre, ApellidoP, ApellidoM, Telefono, Edad, Peso, FUM, Activo, Sangre, Alergias, Embarazo, 
								  Diagnostico, Ginecologo) 
				   values (matricula, nombreP, apellidoPat, apellidoMat, tel, edadP, peso, 
						   menst, act, blood, alergy, pregnant, diagnost, doctor);
			set msg = "El paciente se ha registrado exitosamente.";

        end if;
        
        select msg;
        
        COMMIT;
	END
//
delimiter ;

-- PROCEDURE "consultarPacienteID"
drop procedure if exists consultarPacienteID;
delimiter //
create procedure consultarPacienteID(in matricula int, out nombreP varchar(25), out apellidoPat varchar(20), out apellidoMat varchar(20),
									out tel varchar(10), out edadP int, out peso float, out menst date, out act boolean,
                                    out blood enum('O+', 'O-','A+','A-','B+','B-', 'AB+', 'AB-'), out alergy varchar(100), 
                                    out pregnant boolean, out diagnost varchar(300), out msg varchar (80))
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
			SHOW ERRORS LIMIT 1;
            ROLLBACK;
        END;
        
        DECLARE EXIT HANDLER FOR SQLWARNING
        BEGIN
			SHOW WARNINGS LIMIT 1;
            ROLLBACK;
		END;
        
        start transaction;
        if exists(select NumExpendiente from pacientes where NumExpediente= matricula) then
			select NumExpediente, Nombre, ApellidoP, ApellidoM, Telefono, Edad, Peso, FUM, 
				   Activo, Sangre, Alergias, Embarazo, Diagnostico into 
				   matricula, nombreP, apellidoPat, apellidoMat, tel, edadP, peso, menst, act, blood, 
                   alergy, pregnant, diagnost from pacientes where NumExpediente = matricula;-- , 
			#set msg = concat("Código del empleado: ",  codigoEmp," Nombre: ", nombreEmp, "Apellidos: ", apellidoP," ",apellidoM,
			#				 "DNI: ",dniEMP, " Fecha de Ingreso: ", CAST(fechaIngreso as CHAR), " Salario: ", sueldo," Departamento: ",dept); 
        else
			set msg = "No se ha encontrado al paciente.";
        
        end if;
        
        select msg;
        
        commit;
        
        
	END;
//
delimiter ;

-- PROCEDURE "consultarPaciente"
drop procedure if exists consultarPaciente;
delimiter //
create procedure consultarPaciente(in matricula int, inout nombreP varchar(25), inout apellidoP varchar(20), inout apellidoM varchar(20),
								out tel varchar(10), out edadP int, out peso float, out menst date, out act boolean,
								out blood enum('O+', 'O-','A+','A-','B+','B-', 'AB+', 'AB-'), out alergy varchar(100), 
								out pregnant boolean, out diagnost varchar(300), in doctor int, out msg varchar (80))
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
			SHOW ERRORS LIMIT 1;
            ROLLBACK;
        END;
        
        DECLARE EXIT HANDLER FOR SQLWARNING
        BEGIN
			SHOW WARNINGS LIMIT 1;
            ROLLBACK;
		END;
        
        start transaction;
		if exists (select Nombre, ApellidoP, ApellidoM from pacientes where
				   Nombre = nombreP AND ApellidoP = apellidoPat AND ApellidoM = apellidoMat) then
                   
			select NumExpediente, Nombre, ApellidoP, ApellidoM, Telefono, Edad, Peso, FUM, 
				   Activo, Sangre, Alergias, Embarazo, Diagnostico into 
				   matricula, nombreP, apellidoPat, apellidoMat, tel, edadP, peso, menst, act, blood, 
                   alergy, pregnant, diagnost from pacientes
                   where Nombre = nombreP AND ApellidoP = apellidoPat AND ApellidoM = apellidoMat;
                   
			#set msg = concat("Código del empleado: ",  idEmp," Nombre: ", nombreEmp, "Apellidos: ", apellidoP," ",apellidoM,
			#				 "DNI: ",dniEMP, " Fecha de Ingreso: ", CAST(fechaIngreso as CHAR), " Salario: ", sueldo," Departamento: ",dept); 
        else
			set msg = "No se ha encontrado al paciente.";
		
        end if;
        
        select msg;
        
        commit;
    END;
//
delimiter ;



-- PROCEDURE "registrarProyecto"
drop procedure if exists registrarProyecto;
delimiter //
create procedure crearRecordatorio(in ficha int, in nombre varchar(30), in descrPry varchar(140), in capital decimal(14,2), in fechaI date,
								   in fechaF date, in estadoActual enum('Activo','Suspendido','Finalizado'), in nombreDept varchar(20), out msg varchar (60))
    BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
			SHOW ERRORS LIMIT 1;
            ROLLBACK;
        END;
        
        DECLARE EXIT HANDLER FOR SQLWARNING
        BEGIN
			SHOW WARNINGS LIMIT 1;
            ROLLBACK;
		END;
        
        start transaction;
		if exists(select CodigoProyecto from Proyecto where CodigoProyecto = ficha) then
				set msg = "El proyecto ya se encuentra registrado";
		
        elseif (fechaI < now() OR fechaF < fechaI)  then
		set msg = "Error al capturar fechas, intente de nuevo.";
        
        else
			insert into Proyecto(CodigoProyecto, NombreProyecto, Descripcion, Presupuesto, FechaInicio, FechaFinal, Estado, Departamento)
				   values (ficha, nombre, descrPry, capital, fechaI, fechaF, estadoActual, nombreDept);
			set msg = "Se ha registrado el proyecto exitosamente.";
        
        end if;
        
        select msg;
		
        commit;
	END;
//
delimiter ;
