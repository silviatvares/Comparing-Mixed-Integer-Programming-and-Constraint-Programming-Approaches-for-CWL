int nWarehouses;
int nCustomers;

execute {
  var f = new IloOplInputFile("./Data/cap51.txt");
  var data = f.readline().split(" ");
  nWarehouses = Opl.intValue(data[1]);
  nCustomers = Opl.intValue(data[2]);
  f.close();
} 

 int Capacity[1..nWarehouses];
 int FixedCosts[1..nWarehouses];
 int Demand[1..nCustomers];
 float SupplyCosts[1..nCustomers][1..nWarehouses];
 
 float lista[1..nWarehouses];

 execute {
  
  var f = new IloOplInputFile("./Data/cap51.txt"); 
  f.readline();
  var counter = 1; 
  var i = 1;
  var k = 1;
  var v = 1;
  var sc_rows = Opl.floor(nWarehouses/7) + 1;
  
  while (!f.eof) {

	//	Create Capacity and FixedCosts vectors
  	while (counter <= nWarehouses) {
  		data = f.readline().split(" ");  	
	    Capacity[i] = Opl.intValue(data[1]);
	    FixedCosts[i] = Opl.floatValue(data[2]);
	    counter += 1;
	    i += 1;
  	}
  	
	var data = f.readline();  
	//	Create Demand vectors 	
	if (data.length != 0) {  		
 		Demand[k] = Opl.intValue(data.split(" ")[1]);
 		k += 1;
	
		var y = 1;
		for (var j=1; j<=sc_rows; j++) {
			 var data = f.readline().split(" ");
			 for (var x=1; x<=data.length-2; x++) {	
				 lista[y] = Opl.floatValue(data[x]);
				 y += 1; 
			 }	 
			 counter += 1;
		}
	
		for (j=1; j<=nWarehouses; j++) {
			SupplyCosts[v][j] = lista[j];		
		}		
		v += 1;
	}	
  		
 } // end of file
  f.close();
  
  
  // converter supply costs em valores unitários para cada warehouse
  
  for (var c=1; c <= nCustomers; c++) {
	for (var w=1; w <= nWarehouses; w++) {	
		SupplyCosts[c][w] = SupplyCosts[c][w] / Demand[c];
	}	 
  }
  
  
   writeln(nWarehouses);
   writeln(nCustomers); 
   writeln(Capacity);
   writeln(FixedCosts); 
   writeln(Demand); 
   writeln(SupplyCosts);    
}
