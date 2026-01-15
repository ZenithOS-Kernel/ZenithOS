# ==============================
# ZenithOS Level 10 - BIOS Only
# ==============================

AS      = nasm
CC      = gcc
LD      = ld
CFLAGS  = -m32 -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T linker.ld -m elf_i386

SRCDIR   = src
BUILDDIR = build
BOOTDIR  = boot
GRUBDIR  = $(BOOTDIR)/grub

OBJS = $(BUILDDIR)/entry.o $(BUILDDIR)/kernel.o


# Default
all: $(BUILDDIR)/kernel.elf


# Build directories
$(BUILDDIR):
	mkdir -p $(BUILDDIR)
	mkdir -p $(GRUBDIR)


# Assemble entry
$(BUILDDIR)/entry.o: $(SRCDIR)/entry.S | $(BUILDDIR)
	$(CC) $(CFLAGS) -c -o $@ $<


# Kernel C
$(BUILDDIR)/kernel.o: $(SRCDIR)/kernel.c | $(BUILDDIR)
	$(CC) $(CFLAGS) -c -o $@ $<


# Link ELF
$(BUILDDIR)/kernel.elf: $(OBJS) linker.ld | $(BUILDDIR)
	$(LD) $(LDFLAGS) -o $@
	cp $@ $(BOOTDIR)/kernel.elf
	cp grub.cfg $(GRUBDIR)/grub.cfg


# Create ISO
iso: all
	rm -f $(BUILDDIR)/ZenithOS.iso
	grub-mkrescue -o $(BUILDDIR)/ZenithOS.iso $(BOOTDIR)


# Run
run: iso
	qemu-system-i386 -cdrom $(BUILDDIR)/ZenithOS.iso -m 512


# Clean
clean:
	rm -rf $(BUILDDIR) $(BOOTDIR)/kernel.elf
