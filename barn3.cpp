// Actividad de recursividad
#include <iostream>
using namespace std;

// Factorial Recursivo
// Complejidad: 0(n)
int factRecursivo(int n){
  if (n == 0){
    return 1;}
    else{
    return n * factRecursivo(n - 1);}}

// Fibonacci Recursiva
// Complejidad: 0(2^n)
int fibonacciRecursivo(int n){
  if (n < 3){
    return 1;}
  return fibonacciRecursivo(n - 1) + fibonacciRecursivo(n - 2);}

int main(){
  int n;
  cin >> n;
  // Despliega fibonacci de forma recursiva
  cout << fibonacciRecursivo(n) << endl;
  // Despliega el factorial de forma recursiva
  cout << factRecursivo(n) << endl;
  return 0;}