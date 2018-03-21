int[][] nodos; //listado con los nodos del nivel
//lazos Principales
int[][] lazosPrincipales={{0,1,0,0,0,0,0,1,0,0},
                          {1,0,1,1,0,0,0,0,0,0},
                          {0,1,0,0,0,0,0,0,0,1},
                          {0,1,0,0,1,1,0,0,0,0},
                          {0,0,0,1,0,0,1,0,0,0},
                          {0,0,0,1,0,0,1,0,0,0},
                          {0,0,0,0,1,1,0,0,1,0},
                          {1,0,0,0,0,0,0,0,1,0},
                          {0,0,0,0,0,0,1,1,0,1},
                          {0,0,1,0,0,0,0,0,1,0},
};
int[][] lazosUsuario; // lazos del usuario
int[] centro={width/2,height/2};

boolean juegoTerminado;

int[][] grafo ={{1,0,0,1,0,0,1},
                {0,0,0,0,0,0,0},
                {0,0,0,1,0,0,0},
                {0,0,1,0,1,0,0},
                {0,0,0,1,0,0,0},
                {0,0,0,0,0,0,0},
                {1,0,0,1,0,0,1}};

int[] movimientos=new int[1]; //las filas indican los turnos y las columnas punto inicial a punto final
int turno=0;
int d=30;//diametro de nodos



void mouseClicked(){
  int nodo=sobreNodo(nodos,d);
  if(!juegoTerminado){
    if(turno==0){
         movimientos[turno]=nodo;
         turno++;
   }else if(nodo!=-1){
     if(movimientos[turno-1]==nodo){
       println("estas en el mismo nodo");
     }else{
      movimientos=aumentarArreglo(movimientos,1);
         movimientos[turno]=nodo;
         turno++;
     lazosUsuario[movimientos[movimientos.length-2]][movimientos[movimientos.length-1]]++;
      lazosUsuario[movimientos[movimientos.length-1]][movimientos[movimientos.length-2]]++;   
        imprimirMatriz(lazosUsuario);
     };
   };
  }else{
  
  };
};


boolean lazoPermitido(int[][] lazos){
 for(int i=0;i<lazos.length;i++){
  for(int j=0;j<lazos[0].length;j++){
    if(lazos[i][j]==1 && (lazosPrincipales[i][j]==0 && lazosPrincipales[j][i]==0)){
     return false;
    };
  };
 };
  return true;
};

boolean lazoRepetido(int[][] lazos){
 for(int i=0;i<lazos.length;i++){
  for(int j=0;j<lazos[0].length;j++){
   if(lazos[i][j]>1){
    return true;
   };
  };
 };
  return false;
};


int nNodos(int[][] grafo){
   int nNodos=0;
    if(grafo!=null){
     for(int i=0;i<grafo.length;i++){
     for(int j=0;j<(int)grafo[i].length;j++){
        if(grafo[i][j]==1){
           nNodos++;
        };
     };
  };
   }else{
     println("no se ha podidio leer el grafo");
   };
     return nNodos;
};


int[][] initNodos(int[] posicion,int[][] grafo,int ancho,int alto){
  
  int[] esquina={posicion[0]-(grafo.length/2),posicion[1]-(grafo[0].length/2)};
  
  int[][] nodos=new int[nNodos(grafo)][2];
  int factorAlto=alto/grafo.length;
   int contador=0;
   for(int i=0;i<grafo.length;i++){
      int factorAncho=ancho/grafo[i].length;
     for(int j=0;j<(int)grafo[i].length;j++){
        if(grafo[i][j]==1){
            nodos[contador][0]=esquina[0]+factorAncho*j;
            nodos[contador][1]=esquina[1]+factorAlto*i;
             contador++;
        };
     };
  };
   //TODO: Solucionar el problema del tamaño haciendo que el tamaño de pintado sea multiplo del tamaño del grafo
   return nodos;
};

int[][] initLazosUsuario(int[][] nodos){
 int[][] lazos=new int[nodos.length][nodos.length];
  for(int i=0;i<lazos.length;i++){
    for(int j=0;j<lazos[i].length;j++){
      lazos[i][j]=0;
    };
  };
  return lazos;
};

// Arreglos
int longitudArreglo(int[] arreglo){
  return arreglo.length;
};
//Aumenta un arreglo en "posiciones" casillas
int[] aumentarArreglo(int[] arreglo,int posiciones){
 int[] arregloAumentado=new int[longitudArreglo(arreglo)+posiciones];
  for(int i=0;i<longitudArreglo(arreglo);i++){
    arregloAumentado[i]=arreglo[i];
  };
   return arregloAumentado;
};

//posicion del punto
int[] initPunto(int x,int y){
  int[] punto=new int[2];
   punto[0]=x;
   punto[1]=y;
   return punto;
};

//imprime un arreglo en consola
void imprimirArreglo(int[] arreglo){
  if(longitudArreglo(arreglo)==0){
    println("[ ]");
  }else{
     print("[");
    int penultimo=longitudArreglo(arreglo)-1;
  for(int i=0;i<penultimo;i++){
   print(" "+arreglo[i]+" ,");
  };
   print(" "+arreglo[penultimo]+" ]");
   println();
  };
};

void pintarNivel(int[][] nodos,int d,int [][]lazosPrincipales){
 
  pushStyle();
   pintarLazos(nodos,lazosPrincipales);
  popStyle();
  
  pushStyle();
   pintarNodos(nodos,d);
  popStyle();
  
};

//pinta los nodos almacenados en nodos , con diametro d
void pintarNodos(int[][] nodos,int d) {
  for (int i=0; i<nodos.length; i++) {
    ellipse(nodos[i][X], nodos[i][Y], d, d);
  };
};

void pintarLazos(int[][] nodos,int[][] lazos){
  for(int i=0;i<lazos.length;i++){
    for(int j=0;j<lazos[i].length;j++){
       if(lazos[i][j]==1){
         line(nodos[i][0],nodos[i][1],nodos[j][0],nodos[j][1]);
            // nodos 1 x, nodos 1 y, nodos 2 x, nodo 2 y;
       };
    };
  };
};
void imprimirMatriz(int[][] matriz){
  for(int i=0;i<matriz.length;i++){
    imprimirArreglo(matriz[i]);
  };
};
// indica el nodos sobre el que está el mouse
int sobreNodo(int[][] nodos,int d){
  for(int i=0;i<nodos.length;i++){
      int p=(int)sqrt(sq(d/2)-sq(mouseX-nodos[i][0]))+nodos[i][1]; // perimetro descrito de manera funcional
      if ((nodos[i][0]-(d/2))<=mouseX && mouseX<=nodos[i][0]+(d/2)) {
       if ((-p+(2*nodos[i][1]))<=mouseY && mouseY<=p) {
       return i;
      };
    };
    
  };
   return -1;
};

void keyTyped(){
 if(key=='R' || key=='r'){
  juegoTerminado=!juegoTerminado;
   lazosUsuario=initLazosUsuario(nodos);
    movimientos=new int[1];
      turno=0;
 };
};



void jugar(){
 if(!juegoTerminado){
   if(lazoRepetido(lazosUsuario) || !lazoPermitido(lazosUsuario)){
    juegoTerminado=!juegoTerminado;
   };
 }else{
   println("usted ha perdido, presione r para reiniciar");
 };
  if(!lazoPermitido(lazosUsuario)){
   println("no se puede hacer esa conexion");
  };
};

boolean won(int[][] lazosUsuario,int[][] lazosPermitidos){
  boolena won=false;
 for(int i=0;i<lazosUsuario.length;i++){
  for(int j=0;j<lazosUsuario[i].length;j++){
     won|=(lazosUsuario[i][j]==lazosPermitidos[i][j]);
  };
 };
  return won;
};


void setup(){
   size(500,500);
   nodos=initNodos(centro,grafo,350,350);
    lazosUsuario=initLazosUsuario(nodos);
};

void draw(){
  clear();
   pintarNivel(nodos,d,lazosPrincipales);
   pushStyle();
    stroke(#FF0000);
     pintarLazos(nodos,lazosUsuario);
   popStyle();
    jugar();
    
};
