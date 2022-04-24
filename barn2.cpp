#include <iostream>

using namespace std;

// Complejidad: O(n)
int sumaRecursiva(int n){
  if (n == 1){
    return 1;} 
  else{
    return n + sumaRecursiva(n - 1);}}

// Complejidad: O(1)
int sumaDirecta(int n){
  int suma;
  suma = (n * (n + 1)) / 2;
  return suma;}
// Despliega la suma recursiva y directa
int main(){
  int n;
  int k;
  int contador = 1;
  cin >> k;
  
  while (contador <= k){
    contador += 1;
    cin >> n;
    cout << sumaRecursiva(n) << endl;
    cout << sumaDirecta(n) << endl;}
    return 0;}