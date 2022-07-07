# Spread Api

## Todas las Llamadas son Públicas

### Markets Spread
Entrega toda la información de cada mercado, como la última orden de venta más barata y la última orden de compra más cara. Adicionalmente, se incluye el spread al momento de la llamada, en cada mercado.
El objeto que entrega es un Array en formato JSON.
No requiere parámetros, solo una llamada Get al Endpoint.
#### http request 
get /api/v1/markets_spread

#### Detalles de la Respuesta

Key	Tipo Descripción
* market_id	[currency] = Identificador del mercado consultado
* last_price	[amount, currency] = Precio de la última orden ejecutada
* min_ask	[amount, currency] = Menor precio de venta
* max_bid	[amount, currency] = Máximo precio de compra
* volume	[amount, currency] = Volumen transado en las últimas 24 horas
* price_variation_24h	[float] = Cuanto ha variado el precio en las últimas 24 horas (porcentaje)
* price_variation_7d	[float] = Cuanto ha variado el precio el los últimos 7 días (porcentaje)
* current_spread[float] = Diferencia entre la última orden de venta más barata y la última orden de compra más cara

### Market Spread
Entrega toda la información de un mercado a elegir incluyendo el spread del momento.
Formato JSON.

#### Parámetros
* market_id -> La ID del mercado (Ej: btc-clp, eth-btc, etc).

#### http request 
* post /api/v1/market_spread

#### Detalles de la Respuesta

 Key	Tipo	Descripción

* Idénticas llaves a llamada anterior
* nueva llave ->
* current_spread[float] = Diferencia entre la última orden de venta más barata y la última orden de compra más cara

### Alert Spread
Entrega toda la información que entrega la llamada Market Spread. Adicionalmente, en la llamada, se puede especificar la cantidad de minutos/horas o días de espera, para obtener la respuesta, para ese mercado en particular.
Formato JSON. 

#### Parámetros en orden
* time_parameter -> Tiempo de espera del polling ("minutes","hours","days")
* quantity -> Cantidad unitaria del time_parameter elegido (Eje: 1)
* market_id -> La ID del mercado (Ej: btc-clp, eth-btc, etc).
* alert_spread -> Monto a comparar con el current_spread del futuro (ej: 50000.0)

#### http request 
post /api/v1/alert_spread

#### Detalles de la Respuesta

Key	Tipo	Descripción
* Idénticas llaves a llamada anterior
* nuevas llaves ->
* alert_spread[float, time] = Monto de alerta a consultar en el futuro con la fecha y hora exacta en que fue fijado.
* current_spread_variation[string,float,time] = Entrega en un tiempo futuro definido por la llamada, el valor actual del spread, si es mayor o menor al alert_spread, con la fecha y hora exacta de la respuesta.
