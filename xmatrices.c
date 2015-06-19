#include <stdio.h>
#include <time.h>
#include<stdlib.h>

int main()
{
    int a = 3,b = 3,c = 3,d = 3,i,j,k;
    
    /*printf("Ingrese el numero de filas de la matriz A: ");
    scanf("%d",&a);
    printf("\nIngrese el numero de columnas de la matriz A: ");
    scanf("%d",&b);
    printf("Ingrese el numero de filas de la matriz B: ");
    scanf("%d",&c);
    printf("\nIngrese el numero de columnas de la matriz B: ");
    scanf("%d",&d);*/
    
    
    //int x[a][b],y[c][d],i,j,k;
    //int** x;int** y;int** z;
    int** x=(int**)malloc(a*sizeof(int));
    int** y=(int**)malloc(c*sizeof(int));
    
    for(i=0; i < a; i++)
     {
      x[i] = (int*)malloc(b*sizeof(int));
     }
    
    for(i=0; i < c; i++)
     {
      y[i] = (int*)malloc(d*sizeof(int));
     }
    
    srand(time(NULL));
    
    printf("Matriz A: \n");
    
    for (i=0;i<a;i++)
       {
        for (j=0;j<b;j++)
        { 
         x[i][j] = rand()%10;
         printf("\t%d",x[i][j]);
        }
        printf("\n\n");
       }
    
    printf("Matriz B: \n");
       
    for (i=0;i<c;i++)
       {
        for (j=0;j<d;j++)
        { 
         y[i][j] = rand()%10;
         printf("\t%d",y[i][j]);
        }
        printf("\n\n");
       }
    
         
   /////////////////////////////////////////////////
    
    int** z = (int**)malloc(a*sizeof(int));
    
    for(i=0; i < a; i++)
     {
      z[i] = (int*)malloc(d*sizeof(int));
     }
    
    if(b == c)
     {
      //int z[b][c];
      
      for (i=0;i<a;i++)
       {
        for (j=0;j<d;j++)
        {
         z[i][j]=0;
         for (k=0;k<b;k++)
          {
           z[i][j] = z[i][j] + x[i][k]*y[k][j];
          }
        }
       }
       
      printf("\nLA MULTIPLICACION DE LAS MATRICES ES:\n\n");
      for (i=0;i<b;i++)
       {
        for (j=0;j<c;j++)
        { 
         printf("\t%d",z[i][j]);
        }
        printf("\n\n");
       }
     }
    else 
     printf("Matrices no multiplicables!!!");
 
 free(*x);free(*y);free(*z);    
 free(x);free(y);free(z);
 
    return 0;
}
