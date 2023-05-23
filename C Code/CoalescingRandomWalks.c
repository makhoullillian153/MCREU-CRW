#include <stdio.h>

/* to do list */
/*  add in global variables to store all results until the end
    implement each function
    add in a writetofile function that will save the data to a csv 
    signal handler for input??
    control memory usage throughout program  */

int main(int argc, char const *argv[])
{
    printf("Welcome!\n");
    printf("~~UCONN-MCREU~~\n");
    printf("Authors: Lillian Makhoul & Bram Silbert\n");
    printf("For documentation, see github.com/makhoullillian153/MCREU-CRW\n\n");
    printf("The purpose of this program is to run the simulations more efficiently. \nTo understand the results in more depth we recommend using the Python or R code.");
    printf("----------------------------------\n\n");
    int exit = 0;

    while(exit == 0) {
        exit = menu();
    }
    
    printf("Thank you for using our program. \n ");
    writeToFile("Results.csv");
    printf("Exiting...\n");
    return 0;
}

int menu(){
    char* str = malloc(sizeof(str) * 10);
    printf("Select a function: \n1.)  coalescence(N, s) \n2.)  coal_func(k) \n3.)  annihilation(N,s) \n4.)  ann_func(k) \n5.)  survivor_steps(N, s) \n6.)  surv_func(k) \n7.)  pair_steps(N, s) \n8.)  pair_func(k) \n9.)  pair_steps2(N, s) \n10.) pair_func2(k) \n11.) corr(N, s) \n12.) corr_func(k) \n13.) pair_steps3(N, s) \n14.) pair_exp(N,s,m,n) \n15.) lyons_line(N, s) \n16.) lyons_exp(i, j, lyst) \n17.) pair_time(N, s) \n18.) taus(N, s) \n19.) tau_exp(N, s) \n20.) Exit Program \n \n Enter integer: ");
    fgets(str, 5, stdin);
    int option = atoi(str);
    // assume that the user entered an integer and in the correct range
    // can implement quality assurance, but because C is annoyingly basic, will have
    // to create signal handlers to handle the out of bounds or non-integer exceptions
    free(str);
    if(option == 20){
        return 1;
    }
    switch(option){
        case 1:
            coalescence();
            break;
        case 2:
            coal_func();
            break;
        case 3:
            annihilation();
            break;
        case 4:
            ann_func();
            break;
        case 5:
            survivor_steps();
            break;
        case 6:
            surv_func();
            break;
        case 7:
            pair_steps();
            break;
        case 8:
            pair_func();
            break;
        case 9:
            pair_steps2();
            break;
        case 10:
            pair_func2();
            break;
        case 11:
            corr();
            break;
        case 12:
            corr_func();
            break;
        case 13:
            pair_steps3();
            break;
        case 14:
            pair_exp();
            break;
        case 15:
            lyons_line();
            break;
        case 16:
            lyons_exp();
            break;
        case 17:
            pair_time();
            break;
        case 18:
            taus();
            break;
        case 19:
            tau_exp();
            break;
    }

    return 0;
}

void coalescence(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);


}

void coal_func(){
    /* Get value for k */
    char* Kstr = malloc(sizeof(Kstr) * 100);
    printf("k:");
    fgets(Kstr, 100, stdin);
    unsigned long long k = atoi(Kstr);
    free(Kstr);
}

void annihilation(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);
}

void ann_func(){
    /* Get value for k */
    char* Kstr = malloc(sizeof(Kstr) * 100);
    printf("k:");
    fgets(Kstr, 100, stdin);
    unsigned long long k = atoi(Kstr);
    free(Kstr);
}

void survivor_steps(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);
}

void surv_func(){
    /* Get value for k */
    char* Kstr = malloc(sizeof(Kstr) * 100);
    printf("k:");
    fgets(Kstr, 100, stdin);
    unsigned long long k = atoi(Kstr);
    free(Kstr);

}

void pair_steps(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);
}

void pair_func(){
    /* Get value for k */
    char* Kstr = malloc(sizeof(Kstr) * 100);
    printf("k:");
    fgets(Kstr, 100, stdin);
    unsigned long long k = atoi(Kstr);
    free(Kstr);

}

void pair_steps2(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);
}

void pair_func2(){
    /* Get value for k */
    char* Kstr = malloc(sizeof(Kstr) * 100);
    printf("k:");
    fgets(Kstr, 100, stdin);
    unsigned long long k = atoi(Kstr);
    free(Kstr);

}

void corr(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);
}
            
void corr_func(){
    /* Get value for k */
    char* Kstr = malloc(sizeof(Kstr) * 100);
    printf("k:");
    fgets(Kstr, 100, stdin);
    unsigned long long k = atoi(Kstr);
    free(Kstr);

}

void pair_steps3(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);
}

void pair_exp(){
    /* Get values for N, s, m, and n */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    char* Mstr = malloc(sizeof(Mstr) * 100);
    char* nstr = malloc(sizeof(nstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    printf("m:");
    fgets(Mstr, 100, stdin);
    printf("n:");
    fgets(nstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    unsigned long long m = atoi(Mstr);
    unsigned long long n = atoi(nstr);
    free(Nstr);
    free(Sstr);
    free(Mstr);
    free(nstr);
}

void lyons_line(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);
}

void lyons_exp(){
    /* Get values for i, j, and filename to lyst */
    char* Istr = malloc(sizeof(Istr) * 100);
    char* Jstr = malloc(sizeof(Jstr) * 100);
    char* filename = malloc(sizeof(filename) * 150);
    printf("i:");
    fgets(Istr, 100, stdin);
    printf("j:");
    fgets(Jstr, 100, stdin);
    printf("Enter filename for data of lyst: ");
    fgets(filename, 150, stdin);
    unsigned long long i = atoi(Istr);
    unsigned long long j = atoi(Jstr);
    readFromFile(filename);
    free(Istr);
    free(Jstr);
    free(filename);    
}

void pair_time(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);
}

void taus(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);
}

void tau_exp(){
    /* Get values for N and s */
    char* Nstr = malloc(sizeof(Nstr) * 100);
    char* Sstr = malloc(sizeof(Sstr) * 100);
    printf("N:");
    fgets(Nstr, 100, stdin);
    printf("s:");
    fgets(Sstr, 100, stdin);
    unsigned long long N = atoi(Nstr);
    unsigned long long s = atoi(Sstr);
    free(Nstr);
    free(Sstr);
}

void readFromFile(char* filename){
    
}

void writeToFile(char* filename){
    printf("Saving results to Results.csv...\n");
}