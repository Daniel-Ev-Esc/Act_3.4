#include <iostream>

using namespace std;

int main(){
    long long int n;
    int m;
    int maxC;
    
    int  d = 0;
    
    cin >> n >> m;

    maxC = n;

    while ( n > 0 ){
        d++;

        if( ( n + m ) >= maxC ){
            n = maxC;}
        
        else{
            n += m;}
        

        n -= d;}
    
    
    cout << d;
    return 0;}