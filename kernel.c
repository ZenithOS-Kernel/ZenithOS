// minimal kernel for Level10
extern void outb(unsigned short port, unsigned char val);
void kernel_main(void) {
    const char *s = "ZenithOS Level 10 - Hello from kernel\\n";
    char *vid = (char*)0xB8000;
    for (int i=0; s[i]; ++i) {
        vid[i*2] = s[i];
        vid[i*2+1] = 0x07;
    }
    // loop forever
    for(;;) { __asm__ volatile ("hlt"); }
}
