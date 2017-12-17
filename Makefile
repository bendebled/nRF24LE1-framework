CC         := sdcc --verbose
PACKIHX    := packihx
CFLAGS     := -L ./lib/* --std-sdcc99 --model-large
LFLAGS     := --iram-size 256 --code-loc 0x0000 --code-size 0x4000 --xram-loc 0x0000 --xram-size 0x400
MAIN       := main

NRFPROG_DIR := nRF24LE1_PROG
FLASH_BP    := $(NRFPROG_DIR)/nrfprog
FLASH_BP_PORT   ?= /dev/cu.usbserial-AL03OO4E

SDK_DIR            := nRF24LE1_SDK
PINS               := 32
INCLUDE            += -I include -I $(SDK_DIR)/include -I $(SDK_DIR)/_target_sdcc_nrf24le1_$(PINS)/include
LIBS               += -L $(SDK_DIR)/_target_sdcc_nrf24le1_$(PINS)/lib -lnrf24le1
REL_EXTERNAL_DIR   := $(SDK_DIR)/_target_sdcc_nrf24le1_$(PINS)/obj
REL_EXTERNAL_FILES += $(REL_EXTERNAL_DIR)/delay/delay_us.rel
REL_EXTERNAL_FILES += $(REL_EXTERNAL_DIR)/delay/delay_ms.rel
REL_EXTERNAL_FILES += $(REL_EXTERNAL_DIR)/delay/delay_s.rel

BUILD_DIR := build_output
REL_SRC := $(MAIN).c
REL_OBJ := $(patsubst %.c,%.rel,$(REL_SRC))
REL_OBJ2 := $(patsubst %.c,%.rel,$(BUILD_DIR)/$(REL_SRC))

all: compile upload
compile: rel build
tools: sdk nrfprog

$(shell   mkdir -p $(BUILD_DIR))

%.rel: %.c
	$(CC) -c $(INCLUDE) $(CFLAGS) $(LFLAGS) $(LIBS) $^ -o $(BUILD_DIR)/

rel: $(REL_OBJ)

build:
	$(CC) $(CFLAGS) $(LFLAGS) $(LIBS) $(REL_OBJ2) $(REL_EXTERNAL_FILES) -o $(BUILD_DIR)/
	$(PACKIHX) $(BUILD_DIR)/$(MAIN).ihx > $(BUILD_DIR)/$(MAIN).hex
	tail -n5 $(BUILD_DIR)/$(MAIN).mem

clean:
	rm -r $(BUILD_DIR)

test:
	@echo $(REL_EXTERNAL_FILES)

sdk:
	cd $(SDK_DIR) && make

nrfprog:
	cd $(NRFPROG_DIR) && make

upload:
	$(FLASH_BP) $(FLASH_BP_PORT) $(BUILD_DIR)/$(MAIN).hex
