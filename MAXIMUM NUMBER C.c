#include <stdio.h>

int main() {
  int arr[] = {10, 20, 30, 40, 50};
  int n = sizeof(arr) / sizeof(arr[0]);
  int max = arr[0];
  for (int i = 1; i < n; i++) {
    if (arr[i] > max) {
      max = arr[i];
    }
  }
  printf("The maximum number in the array is: %d\n", max);
  return 0;
}