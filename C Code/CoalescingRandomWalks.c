#include <stdio.h>
#include <stdlib.h>

/* to do list */
/*  add in global variables to store all results until the end
    implement each function
    implement writetofile
    implement readFromFile
    signal handler for input??
    control memory usage throughout program  */

    int menu();
    unsigned long long coalescence(unsigned long long N, unsigned long long s);
    void coal_func(long k);
    void annihilation(unsigned long long N, unsigned long long s);
    void ann_func(long k);
    void survivor_steps(unsigned long long N, unsigned long long s);
    void surv_func(long k);
    void pair_steps(unsigned long long N, unsigned long long s);
    void pair_func(long k);
    void pair_steps2(unsigned long long N, unsigned long long s);
    void pair_func2(long k);
    void corr(unsigned long long N, unsigned long long s);
    void corr_func(long k);
    void pair_steps3(unsigned long long N, unsigned long long s);
    void pair_exp(unsigned long long N, unsigned long long s, unsigned long long n, unsigned long long m);
    void lyons_line(unsigned long long N, unsigned long long s);
    void lyons_exp(long i, long j, unsigned long long *lyst);
    void pair_time(unsigned long long N, unsigned long long s);
    void taus(unsigned long long N, unsigned long long s);
    void tau_exp(unsigned long long N, unsigned long long s);
    unsigned long long* readFromFile(char* filename);
    void writeToFile(char* filename);
    unsigned long long mean(unsigned long long* array, unsigned long long s);

int main(int argc, char const *argv[])
{
    printf("Welcome!\n");
    printf("~~UCONN-MCREU~~\n");
    printf("Authors: Lillian Makhoul & Bram Silbert\n");
    printf("For documentation, see github.com/makhoullillian153/MCREU-CRW\n\n");
    printf("The purpose of this program is to run the simulations more efficiently. \nTo understand the results in more depth we recommend using the Python or R code.");
    printf("\n----------------------------------\n");
    int exit = 0;

    while(exit == 0) {
        exit = menu();
    }
    
    writeToFile("Results.csv");
    printf("Thank you for using our program. \n");
    printf("Exiting...\n");
    return 0;
}

int menu(){
    char* str = malloc(sizeof(str) * 10);
    printf("\nSelect a function: \n1.)  coalescence(N, s) \n2.)  coal_func(k) \n3.)  annihilation(N,s) \n4.)  ann_func(k) \n5.)  survivor_steps(N, s) \n6.)  surv_func(k) \n7.)  pair_steps(N, s) \n8.)  pair_func(k) \n9.)  pair_steps2(N, s) \n10.) pair_func2(k) \n11.) corr(N, s) \n12.) corr_func(k) \n13.) pair_steps3(N, s) \n14.) pair_exp(N,s,m,n) \n15.) lyons_line(N, s) \n16.) lyons_exp(i, j, lyst) \n17.) pair_time(N, s) \n18.) taus(N, s) \n19.) tau_exp(N, s) \n20.) Exit Program \n \nEnter integer: ");
    fgets(str, 5, stdin);
    int option = atoi(str);
    // assume that the user entered an integer and in the correct range
    // can implement quality assurance, but because C is annoyingly basic, will have
    // to create signal handlers to handle the out of bounds or non-integer exceptions
    free(str);
    if(option == 20){
        return 1;
    }
    printf("\n");
    char* Nstr, Sstr, Kstr, Mstr, nstr, Istr, Jstr;
    unsigned long long N, s, m, n;
    long k;

    switch(option){
        case 1:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = (unsigned long long) atoi(Nstr);
            s = (unsigned long long) atoi(Sstr);
            free(Nstr); free(Sstr);
            coalescence(N, s);
            free(N); free(s);
            break;
        case 2:
            /* Get value for k */
            Kstr = malloc(sizeof(Kstr) * 100);
            printf("k:");
            fgets(Kstr, 100, stdin);
            k = atoi(Kstr);
            free(Kstr);
            coal_func(k);
            break;
        case 3:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            free(Nstr); free(Sstr);
            annihilation(N, s);
            free(N); free(s);
            break;
        case 4:
            /* Get value for k */
            Kstr = malloc(sizeof(Kstr) * 100);
            printf("k:");
            fgets(Kstr, 100, stdin);
            k = atoi(Kstr);
            free(Kstr);
            ann_func(k);
            free(k);
            break;
        case 5:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            free(Nstr); free(Sstr);
            survivor_steps(N, s);
            free(N); free(s);
            break;
        case 6:
            /* Get value for k */
            Kstr = malloc(sizeof(Kstr) * 100);
            printf("k:");
            fgets(Kstr, 100, stdin);
            long k = atoi(Kstr);
            free(Kstr);
            surv_func(k);
            free(k);
            break;
        case 7:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            free(Nstr); free(Sstr);
            pair_steps(N, s);
            free(N); free(s);
            break;
        case 8:
            /* Get value for k */
            Kstr = malloc(sizeof(Kstr) * 100);
            printf("k:");
            fgets(Kstr, 100, stdin);
            k = atoi(Kstr);
            free(Kstr);
            pair_func(k);
            free(k);
            break;
        case 9:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            free(Nstr); free(Sstr);
            pair_steps2(N, s);
            free(N); free(s);
            break;
        case 10:
            /* Get value for k */
            Kstr = malloc(sizeof(Kstr) * 100);
            printf("k:");
            fgets(Kstr, 100, stdin);
            k = atoi(Kstr);
            free(Kstr);
            pair_func2(k);
            free(k);
            break;
        case 11:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            corr(N, s);
            free(N); free(s); free(Nstr); free(Sstr);
            break;
        case 12:
            /* Get value for k */
            Kstr = malloc(sizeof(Kstr) * 100);
            printf("k:");
            fgets(Kstr, 100, stdin);
            k = atoi(Kstr);
            free(Kstr);
            corr_func(k);
            break;
        case 13:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            pair_steps3(N, s);
            free(N); free(s); free(Nstr); free(Sstr);
            break;
        case 14:
            /* Get values for N, s, m, and n */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            Mstr = malloc(sizeof(Mstr) * 100);
            nstr = malloc(sizeof(nstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            printf("m:");
            fgets(Mstr, 100, stdin);
            printf("n:");
            fgets(nstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            m = atoi(Mstr);
            n = atoi(nstr);
            free(Nstr); free(Sstr); free(Mstr); free(nstr);
            pair_exp(N, s, m, n);
            free(N); free(s); free(m); free(n);
            break;
        case 15:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            free(Nstr); free(Sstr);
            lyons_line(N, s);
            free(N); free(s);
            break;
        case 16:
            /* Get values for i, j, and filename to lyst */
            Istr = malloc(sizeof(Istr) * 100);
            Jstr = malloc(sizeof(Jstr) * 100);
            char* filename = malloc(sizeof(filename) * 150);
            printf("i:");
            fgets(Istr, 100, stdin);
            printf("j:");
            fgets(Jstr, 100, stdin);
            printf("Enter filename for data of lyst: ");
            fgets(filename, 150, stdin);
            long i = atoi(Istr);
            long j = atoi(Jstr);
            // unsigned long long *lyst = readFromFile(filename);
            free(Istr); free(Jstr); free(filename);
            // lyons_exp(i, j, lyst);
            // free(i); free(j); free(lyst);
            break;
        case 17:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            free(Nstr); free(Sstr);
            pair_time(N, s);
            free(N); free(s);
            break;
        case 18:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            free(Nstr); free(Sstr);
            taus(N, s);
            free(N); free(s);
            break;
        case 19:
            /* Get values for N and s */
            Nstr = malloc(sizeof(Nstr) * 100);
            Sstr = malloc(sizeof(Sstr) * 100);
            printf("N:");
            fgets(Nstr, 100, stdin);
            printf("s:");
            fgets(Sstr, 100, stdin);
            N = atoi(Nstr);
            s = atoi(Sstr);
            free(Nstr); free(Sstr);
            tau_exp(N, s);
            free(N); free(s);
            break;
    }

    return 0;
}

unsigned long long coalescence(unsigned long long N, unsigned long long s){
    unsigned long long* times = malloc((s + 1) * sizeof(times));
    
    if(N == 1){
        printf("Average time: 0");
        return;
    }

    if(N == 2){
        printf("Average time: 1");
        return;
    }

    for(unsigned long long i = 1; i <= s; i++){
        unsigned long long* RW = malloc((N + 1) * sizeof(RW));
        for(unsigned long long j = 0; j < N; j++){
            RW[j] = j + 1;
        }

        while(1){
            // randomly sample from RW
            unsigned long long vertex;
            while(1){
                vertex = rand() * N;
                if(RW[vertex] != 0){
                    break;
                }
            }
            times[i]++;

            // shift/coalesce particles
            if(vertex == (N - 1)){
                RW[0] = RW[vertex];
                RW[vertex] = 0;
            } else {
                RW[vertex + 1] = RW[vertex];
                RW[vertex] = 0;
            }

            // case where only one particle remains
            int notZero = 0;
            int coalesced = 1;
            for(unsigned long long j = 0; j < N; j ++){
                if(RW[j] != 0){
                    notZero++;
                }
                if(notZero > 1) {
                    coalesced = 0;
                    break;
                }
            }
            if(coalesced == 1){
                break;
            }
        }
    }
    unsigned long long averageTime = mean(times, s);
    printf("Average time of %llu particles: %llu", N, averageTime);

    return averageTime;
}

void coal_func(long k){
    long* nvals = malloc((k+1) * sizeof(nvals));
    for(long i = 0; i < k; i++){
        nvals[i] = i + 1;
    }
    unsigned long long* t_avg = malloc((k+1) * sizeof(t_avg));

    for(long i = 0; i < k; i++){
        printf("i: %d", i + 1);
        t_avg[i] <- coalescence((unsigned long long) i + 1, 100000);
        printf("average time for %d particles: %llu", i + 1, t_avg[i]);
    }
}

void annihilation(unsigned long long N, unsigned long long s){
}

void ann_func(long k){
}

void survivor_steps(unsigned long long N, unsigned long long s){

}

void surv_func(long k){


}

void pair_steps(unsigned long long N, unsigned long long s){
    
}

void pair_func(long k){
    

}

void pair_steps2(unsigned long long N, unsigned long long s){
    
}

void pair_func2(long k){

}

void corr(unsigned long long N, unsigned long long s){
    
}
            
void corr_func(long k){

}

void pair_steps3(unsigned long long N, unsigned long long s){
    
}

void pair_exp(unsigned long long N, unsigned long long s, unsigned long long n, unsigned long long m){
}

void lyons_line(unsigned long long N, unsigned long long s){
    
}

void lyons_exp(long i, long j, unsigned long long *lyst){
    
}

void pair_time(unsigned long long N, unsigned long long s){
}

void taus(unsigned long long N, unsigned long long s){
    
}

void tau_exp(unsigned long long N, unsigned long long s){
    
}

unsigned long long* readFromFile(char* filename){

}

void writeToFile(char* filename){
    printf("Saving results to Results.csv...\n");
}

unsigned long long mean(unsigned long long* array, unsigned long long s){
    unsigned long long avg = 0;
    for(unsigned long long i = 0; i < s; i++){
        avg += array[i];
    }
    avg /= s;
    return avg;
}