#include <stdio.h>
#include <stdbool.h>

bool stack_recurse(int *recvar){
  int x;
  if(!recvar){
    return stack_recurse(&x);
  } else {
    return &x > recvar;
  }
}

int main(){
  printf("Stack Direction: %s\n", stack_recurse(NULL) ? "Up" : "Down");
  return 0;
}
