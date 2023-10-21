/*******
* Dados *
*******/

int nWarehouses= ...;
range Warehouses = 1..nWarehouses;
int nCustomers = ...;
range Customers = 1..nCustomers;
int FixedCosts[Warehouses] = ...; // fixed cost para abrir um warehouse
int Capacity[Warehouses] = ...; // capacidade m�xima de cada warehouse
float SupplyCosts[Customers][Warehouses] = ...; // supply cost unit�rio entre cada Customer e cada Warehouse

int Demand[Customers] = ...; //demand de cada loja
//int MaxWarehouses = 8; // n�mero m�ximo permitido de armaz�ns abertos (cen�rio alternativo 1)
//int MinWarehouses = 5; // n�mero m�ximo permitido de armaz�ns abertos (cen�rio alternativo 2)
//int MaxWarehousesPerCustomer = 1; // n�mero m�ximo de armaz�ns que podem abastecer uma loja (cen�rio alternativo 3)

/*********************
* Vari�veis de decis�o *
*********************/
dvar boolean Open[Warehouses]; // 1 se warehouse estiver aberto, 0 se fechado
dvar int Supply[Customers][Warehouses]; // quantidade fornecida ao Customer pelo Warehouse

/*********************
* Fun��o Objetivo *
*********************/
minimize
sum( w in Warehouses ) FixedCosts[w] * Open[w]
+ sum( w in Warehouses , c in Customers ) SupplyCosts[c][w] * Supply[c][w];

/**************
* Restri��es *
**************/
subject to{

  forall( c in Customers )
	ctProcuraSatisfeita: sum( w in Warehouses ) Supply[c][w] == Demand[c];
	
  forall( w in Warehouses )
	ctCapacidadeWarehouse: sum( c in Customers ) Supply[c][w] <= Capacity[w]*Open[w];
	
  forall( w in Warehouses, c in Customers )
	ctNaoNegatividade: Supply[c][w] >= 0;
	
//// Alt1: n�mero m�ximo de armaz�ns abertos
//	ctMaxWarehouses: sum(w in Warehouses) Open[w] <= MaxWarehouses;
	
//// Alt2: n�mero m�nimo de armaz�ns abertos
//	ctMinWarehouses: sum(w in Warehouses) Open[w] >= MinWarehouses;

//// Alt3: n�mero m�ximo de armaz�ns que podem fornecer um cliente
//  forall( c in Customers )	
//	ctMaxWarehousesPerCustomer: sum(w in Warehouses : Supply[c][w] > 0) Open[w] <= MaxWarehousesPerCustomer;

}
//// Output de customers satisfeitos por cada armaz�m
//{int} Customersof[w in Warehouses] = { c | c in Customers : Supply[c][w] > 0 };

//// Output de warehouses que abastecem cada cliente
//{int} Warehousesof[c in Customers] = { w | w in Warehouses : Supply[c][w] > 0 };

//calcular n�mero total de armaz�ns abertos
int TotalWarehouses = sum(w in Warehouses) Open[w];
//calcular n�mero de warehouses por cliente
int nWarehousesperCustomer[c in Customers] = sum(w in Warehouses : Supply[c][w] > 0) Open[w];

execute {
writeln("Open=",Open);
//writeln("Customersof=",Customersof);
writeln("Total Open Warehouses=",TotalWarehouses);
//writeln("Warehousesof=",Warehousesof);
writeln("Supply=", Supply);
writeln("Numero warehouses=", nWarehousesperCustomer);
}