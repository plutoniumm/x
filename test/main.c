#include <stdbool.h>
#include <stdio.h>

bool stack_recurse(int *recvar) {
  int x;
  if (!recvar) {
    return stack_recurse(&x);
  } else {
    return &x > recvar;
  }
}

int main() {
  printf("Stack Direction: %s\n", stack_recurse(NULL) ? "1" : "-1");
  return 0;
}
