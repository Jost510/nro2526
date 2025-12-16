#include <iostream>
#include <cmath>
#include <iomanip>

using namespace std;

double calcAtan(double x, int N_steps) {
    double sum = 0.0;
    for (int n = 0; n < N_steps; n++) {
        double term = pow(-1, n) * pow(x, 2 * n + 1) / (2 * n + 1);
        sum += term;
    }
    return sum;
}

double f(double x) {
    return exp(3 * x) * calcAtan(x / 2.0, 20);
}

int main() {
    double a = 0;
    double b = 3.14159265359 / 4.0; // pi/4

    // Parametri za trapezno metodo
    int n = 10000;          
    double h = (b - a) / n;

    double sum = f(a) + f(b);

    for (int i = 1; i < n; i++) {
        double x_i = a + i * h;
        sum += 2 * f(x_i);
    }

    // Končni rezultat
    double integral = (h / 2.0) * sum;

    cout << fixed << setprecision(6);
    cout << "Rezultat integrala je: " << integral << endl;

    return 0;
}