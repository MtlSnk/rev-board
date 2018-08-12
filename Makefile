# Name of the binary is the same as the directory it's in.
BINARY = $(shell basename $(CURDIR))

VERSION = 0.1

# GNU ARM embedded toolchain
CC    = avr-gcc
CP    = avr-objcopy
HEX   = $(CP) -O ihex

# C preprocessor flags
# 
CPPFLAGS = \
	-DVERSION="$(VERSION)" 
#     -DDEBUG

### C flags
# Warning flags
CFLAGS += -Wall -Wextra -Wmissing-prototypes -Wstrict-prototypes

# Set the language as C99 with GNU extensions.
CFLAGS += -std=gnu99

# Device-specific flags
CFLAGS += -mmcu=atmega328p

# Optimisation level
CFLAGS += -Og

# Debug level
CFLAGS += -g3

# List of source files
SOURCES = \
	src/main.c

OBJECTS = $(patsubst %.S,%.o,$(patsubst %.c,%.o,$(SOURCES)))

$(BINARY).elf: $(OBJECTS)
	$(CC) -o $@ $(OBJECTS)
	$(HEX) $(BINARY).elf $(BINARY).hex

%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

%.o: %.S
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

flash: $(BINARY).hex
	avrdude -vv -P /dev/ttyUSB0 -c arduino -p atmega328p -b 57600 -U flash:w:$(BINARY).hex 

clean:
	rm -rf \
    $(BINARY).elf \
    $(BINARY).hex \
    $(OBJECTS)
