<?php

/**
 * Clase utilitaria que maneja la conexion/desconexion a la base de datos
 * mediante las funciones PDO (PHP Data Objects).
 * Utiliza el patron de diseno singleton para el manejo de la conexion.
 * @author mrea
 */
class Database {

//Propiedades estaticas con la informacion de la conexion (DSN):
    private static $dbName = 'productos';
    private static $dbHost = 'localhost'; // (ya aplicado...poner ip, o nombre del host)
    private static $dbUsername = 'root';
    private static $dbUserPassword = ''; //clavede usuario root
    //si hubiera cambiado el puerto default... private $dbport='3300';
    //luego en el metodo connect() usar la variable sumar .port='3300'
    
//Propiedad para control de la conexion:
    private static $conexion = null;

    /**
     * No se permite instanciar esta clase, se utilizan sus elementos
     * de tipo estatico.
     */
    public function __construct() {
        exit('No se permite instanciar esta clase.');
    }

    /**
     * Metodo estatico que crea una conexion a la base de datos.
     * @return type
     */
    public static function connect() {
// Una sola conexion para toda la aplicacion (singleton):
        if (null == self::$conexion) {
            try {
              //  self::$conexion = new PDO("mysql:host=" . self::$dbHost . ";" . "dbname=" . self::$dbName, self::$dbUsername, self::                      $dbUserPassword);
			self::$conexion =  new PDO('pgsql:host=ec2-54-225-196-122.compute-1.amazonaws.com;port=5433;dbname=db1bpq3mj2k1es', 'bkidxpuqmmwwyr', '33ee3cf84111691abc14fe0ac85fa37e21cab8bf6c31debcf2ac2d762f885f9e'); 
			 
            } catch (PDOException $e) {
                die($e->getMessage());
            }
        }
        return self::$conexion;
    }

    /**
     * * Metodo estatico para desconexion de la bdd.
     */
    public static function disconnect() {
        self::$conexion = null;
    }
}
?>
*/
