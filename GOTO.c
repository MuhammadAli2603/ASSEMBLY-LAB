#include <stdio.h>

int main() {
  int arr[] = {10, 20, 30, 40, 50};
  int n = sizeof(arr) / sizeof(arr[0]);
  int max = arr[0];
  int i = 1;
  goto loop_start;
loop_start:
  if (i < n) {
    if (arr[i] > max) {
      max = arr[i];
    }
    i++;
    goto loop_start;
  }
  printf("The maximum number in the array is: %d\n", max);
  return 0;
}