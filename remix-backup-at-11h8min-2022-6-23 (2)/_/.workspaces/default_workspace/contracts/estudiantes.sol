// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract estudiante 
{
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping (string => uint) private notas_materias;
    string[] private recorrerMapping; 

    // Declaro todas las variables y diccionario necesarios

    constructor (string memory nombre_, string memory apellido_, string memory curso_)
    {
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;

        // Le pedimos al usuario de este contrato, que ingreso tanto su nombre como apellido y curso
        // Establecemos que el unico que puede setear los valores en el constructor sea quien la haya llamado, en este caso el docente
    }

    function apellido() public view returns (string memory)
    {
        return _apellido;

        // Devolvemos el apellido
    }

    function nombre_completo() public view returns (string memory)
    {
        return string (abi.encodePacked(_nombre, " ", _apellido));
        //_nombre_completo = string.concat(_nombre,_apellido); Esa era otra forma que habia encontrado de hacer, pero que no me termino de funcionar

        // Concatenamos los strings de nombre y apellido en uno solo mediante la funcion de abi.encodePacked
    }

    function curso() public view returns(string memory)
    {
        return _curso;

        // Devolvemos el curso
    }

    function set_nota_materia(uint nota, string memory materia) public 
    {
        require(msg.sender == _docente, "Sola la docente puede poner notas");
        notas_materias[materia] = nota;
        recorrerMapping.push(materia);

        // Establecemos que el uncio que puede llamar esta funcion sea el que haya establecido los valores de apellido, nombre y curso, que es el docente
        // Hacemos que la materia que nos ingresa por input sea la Key, y la nota que nos ingresa por input sea el Value

        // Le vamos agregando las keys al array que creamos para que tengan los mismos valores que el maping. Esto puesto que las materias que seta en el mapping son las mismas de las cuales queremos sacar el promedio con el array.

    }

    function nota_materia(string memory materia) public view returns (uint)
    { 
        return notas_materias[materia];

        // Devolvemos el valor de la nota de la materia que ingresamos por Input.
        // Estos datos tiene que haber sido previamente ingresados en la funcion de setear notas
    } 

    function aprobo(string memory materia) public view returns (bool)
    {
        if (notas_materias[materia] >= 60)
        {
            return true;
        }
        return false;

        // Se ingresa por input la materia de la cual queremos saber si el estudiante aprobo
        // Si la nota de esta materia es igual o mayor a 60, significa que el estudiante aprobo, por lo que devolvemos un true de que haya aprobado 
        // En cambio, si tiene una nota menor a esta, el estudiantee habra desaprobado, por lo que devolvemos un false, indicando que no aprobo
    }

    function promedio() public view returns (uint)
    {
        uint cantidadMaterias = recorrerMapping.length;
        uint notas_totales = 0;
        
        for (uint8 i = 0; i < cantidadMaterias; i++)
        {
            notas_totales += notas_materias[recorrerMapping[i]];
        }

        return notas_totales / cantidadMaterias;

        // Creo una variable que almacena el numero de longitud de nuestro array, que esta almacenando las materias, por lo que estamos haciendo que sea la cantidad de materias que haya seteado
        // Declaro una variable donde le voy a sumar el valor de todas las materias que me vaya ingresando
        // Mediante un for, recorro el array por completo, y dependiendo de la materia, le devuelve la nota.
        // Esto sucede puesto que la key del array, que es la materia, esta adentro del mapping, por lo que toma esto y devuelve la parte de valor del mapping, que es la nota (No se si me explique bien, pero creo que funciona asi)
        // Estas notas se van sumando en una sola variable, que posteriormente se divide por la cantidad de materias para saber el promedio.
        // Finalmente, devolvemos este numero como unit8

        // Checkear lo de LookUpTable
    }


}
