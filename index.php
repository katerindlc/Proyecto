<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>CRUD Productos</title>
    </head>
    <body>
        <table>
            <tr><td>
                    <form action="controller/controller.php">
                        <input type="hidden" value="listar" name="opcion">
                        <input type="submit" value="Consultar listado">
                    </form>
                </td>
                <td>
                    <form action="controller/controller.php">
                        <input type="hidden" value="listar_desc" name="opcion">
                        <input type="submit" value="Consultar listado descendente">
                    </form>
                </td><td>
                    <form action="controller/controller.php">
                        <input type="hidden" value="crear" name="opcion">
                        <input type="submit" value="Crear producto">
                    </form>
                </td></tr>
        </table>
        <table border="1">
            <tr>
                <th>CODIGO</th>
                <th>NOMBRE</th>
                <th>PRECIO</th>
                <th>CANTIDAD</th>
                <th>ELIMINAR</th>
                <th>ACTUALIZAR</th>
            </tr>
            <?php
            session_start();
           include './model/Producto.php';
//verificamos si existe en sesion el listado de productos:
            if (isset($_SESSION['listado'])) {
                $listado = unserialize($_SESSION['listado']);
                foreach ($listado as $prod) {
                    echo "<tr>";
                    echo "<td>" . $prod->getCodigo() . "</td>";
                    echo "<td>" . $prod->getNombre() . "</td>";
                    echo "<td>" . $prod->getPrecio() . "</td>";
                    echo "<td>" . $prod->getCantidad() . "</td>";
//opciones para invocar al controlador indicando la opcion eliminar o cargar
//y la fila que selecciono el usuario (con el codigo del producto):
                    echo "<td><a href='controller/controller.php?opcion=eliminar&codigo=" . $prod->getCodigo() . "'>eliminar</a></td>";
                    echo "<td><a href='controller/controller.php?opcion=cargar&codigo=" . $prod->getCodigo() . "'>actualizar</a></td>";
                    echo "</tr>";
                }
            } else {
                echo "No se han cargado datos.";
            }
            ?>
        </table>
        <?php
        if (isset($_SESSION['valorTotal'])) {
            echo "VALOR TOTAL DE PRODUCTOS: <b>" . $_SESSION['valorTotal'] . "</b>";
        }
        ?>
    </body>
</html>