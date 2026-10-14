/* separate_bruker_forbidden.c

   This program takes data of the form td,td3=2,td2,td1 and separates into two different data sets
     that are allowed and forbidden

   These data sets can then be manipulated with addNMR

   Dec 14, 2015  Lewis E. Kay

*/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>


#define MAXDATA (16384*2)
  main(argc,argv)
     int argc;
     char *argv[];

  {
    FILE *fi,*fi1,*fi2;
    int td1,td,td_a,i,num_pts,q;
    float aa;
    static int data_1[MAXDATA],data_2[MAXDATA];


    if(argc != 7)
    {
      printf("Usage\n");
      printf("Arguement 1: Data set input\n");
      printf("Arguement 2: Data set 1 output\n");
      printf("Arguement 3: Data set 2 output\n");
      printf("Arguement 4: td1\n");
      printf("Arguement 5: td\n");
      printf("Argument  6: Number of points in time series\n");
      exit(1);
    }

    fi  = fopen(argv[1],"r");
    fi1  = fopen(argv[2],"w");
    fi2  = fopen(argv[3],"w");
    if (fi==NULL) {
        fprintf(stderr,"file 1 cannot open\n");
        exit(1);
    }
    td1 = atoi(argv[4]);
    td = atoi(argv[5]);

    num_pts = atoi(argv[6]);

    if (td > MAXDATA) {
 	fprintf(stderr,"t2 point exeeds limit %d\n",MAXDATA);
	exit(1);
    }

   aa = ceil(td/256.0);

   td_a = (int) (aa*256.0);
   printf("value of td_a is %d",td_a);

    for(i=1; i<= td1; i++) {
     for(q=1; q<=num_pts; q++) {

       fread(&data_1[1],4,td_a,fi);
       fread(&data_2[1],4,td_a,fi);

       fwrite(&data_1[1],4,td_a,fi1);
       fwrite(&data_2[1],4,td_a,fi2);
      }
   }

      fclose(fi); fclose(fi1); fclose(fi2);

  }
