#include <cstdlib>
#include <ctime>
#include <iostream>

using namespace std;

int main(int argc, char *argv[]) {
  if (argc != 2) {
    cout << "Usage: x main.cpp <radius>" << endl;
    return 1;
  }

  double r = atof(argv[1]);
  srand(time(0));

  int tot = 10 * 1000 * 1000;
  int inside = 0;

  for (int i = 0; i < tot; ++i) {
    double x = (double)rand() / RAND_MAX * (2 * r) - r;
    double y = (double)rand() / RAND_MAX * (2 * r) - r;

    if (x * x + y * y <= r * r) {
      inside++;
    }
  }

  double pi = 4.0 * inside / tot;
  cout << pi << endl;
  return 0;
}