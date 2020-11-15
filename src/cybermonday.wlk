class Local {
	var property ventas = []

	// Punto 3 
	method cantidadVentasEnPromocion() = ventas.count{ venta => venta.enPromocion() }
		
	// Punto 4.a
	method ventasEnLaFecha(fechaBuscada){
		return ventas.filter{ venta => venta.fecha() == fechaBuscada }
	}
	
	// Punto 4.b
	method dineroAhorradoPorClientes() = ventas.sum{ venta => venta.dineroAhorradoPorCliente() }
	
	// Punto 5.a
	method cantidadVentas() = ventas.size()
	
	// Punto 5.b
	method dineroMovido() = ventas.sum{ venta => venta.monto() }
	
	// Punto 7
	method tacanio() = self.cantidadVentasEnPromocion() == self.cantidadVentas()
}

class Venta {
	var property productos = []
	const property fecha
	var property ubicacion
	
	// Punto 2
	method monto() = productos.sum{ producto => producto.costo() }
	
	// Punto 3
	method enPromocion() = productos.any{ producto => producto.enDescuento()}
	
	// Punto 4.b
	method dineroAhorradoPorCliente() = productos.sum{ producto => producto.descuentoEnDinero() }
	
}

class Producto {
	var property descuentoEnPorcentaje = 0

	method costo()
	
	method enDescuento() = descuentoEnPorcentaje > 0
	
	// Punto 1
	method aplicarDescuento() = 1 - descuentoEnPorcentaje/100
	
	// Punto 4.b
	method descuentoEnDinero() = self.costo() / self.aplicarDescuento() // Si no hay descuento se divide por 1
	
	 
}

class Inducmentaria inherits Producto {
	var property talle
	const property factorConversion
	
	override method costo() = talle * factorConversion * self.aplicarDescuento()
}

class Electroncia inherits Producto {
	
	override method costo() = 15 * factorConversionElectroncia.valor() * self.aplicarDescuento()
}

object factorConversionElectroncia {
	var property valor = 10
}

class Decoracion inherits Producto {
	var property peso
	var property ancho
	var property alto
	var property materiales = #{}
	
	override method costo() = peso * ancho * alto * self.costoTotalMateriales() * self.aplicarDescuento()
	method costoTotalMateriales() = materiales.sum{ material => material.valor() } 
	
}

// Punto 5
class Shopping {
	var property locales = #{}
	
	// Punto 5.a
	method cantidadVentas() = locales.sum{ local => local.cantidadVentas()}
	
	// Punto 5.b
	method dineroMovido() = locales.sum{ local => local.dineroMovido()}
	
	// Punto 7
	method tacanio() = locales.any{ local => local.tacanio() }
}

// Punto 6
class Lugar {
	var property shoppings = #{}
	var property locales = #{}


	//Punto 6
	method mayorCantidadDeVentas() = {
		const shopping = self.shoppingConMayorVentas()
		const local = self.localConMayorVentas()
		if(shopping.cantidadVentas() > local.cantidadVentas() ){
			return shopping
		}else{
			return local
		}
	}
	
	// Por si necesito tener separado la estadistica de shoppings y locales
	method shoppingConMayorVentas() = shoppings.max{ shopping => shopping.cantidadVentas() }
	method localConMayorVentas() = locales.max{ local => local.cantidadVentas() }

	// Punto 7
	method hayLugarConClientesTacanios() = locales.any{local => local.tacanio()} || shoppings.any{shopping => shopping.tacanio()}	
}

// Punto 8: La herencia me ayudo a evitar duplicacion de codigo y que la solucion sea mas polimorfica