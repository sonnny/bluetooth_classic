
#include "pico/cyw43_arch.h"
#include "pico/stdlib.h"
#include "btstack_run_loop.h"

int btstack_main(int argc, const char * argv[]);
int main() {
  stdio_init_all();
  cyw43_arch_init();
  btstack_main(0, NULL);
  btstack_run_loop_execute();}
