# nRF24LE1 Framework

This project contains everything you need in order to program the nRF24LE1 using a buspirate. It contains nrfprog that allows you to program the chip and also an SDK to make the programming easier.

`main.c` is an example. It blinks the pin P0_1.

## Usage

1. Download the necessary compiler, [sdcc](https://sourceforge.net/projects/sdcc/files/)
2. Add the bin folder to your path: Add `export PATH=$PATH:/path/to/dir/sdcc-3.6.0/bin/` to your `~/.profile` and then execute `source ~/.profile`.
3. Inside this project folder, execute `make tools` in order to compile the SDK and the nrfprog.
4. Execute `make` in order to compile `main.c` and then to upload to the nRF24LE1.

If you intend to compile and upload a file that is not named `main.c`, you can do so by `make MAIN=your_file_name.c`

By default, the device port is `/dev/cu.usbserial-AL03OO4E` but can be changed by either modifying the Makefile or by executing  `make FLASH_BP_PORT=/dev/your_device` insead of `make`

You can also use `make compile` to only compile and `make upload` to only transfer to the nRF24LE1.

## Hardware

| bus pirate   | nrf 24 pin | nrf 32 pin | nrf 48 pin |
| ------------ | ---------- | ---------- | ---------- |
| GND (brown)  | GND        | GND        | GND        |
| 3V3 (red)    | PROG       | PROG       | PROG       |
| AUX (blue)   | RESET      | RESET      | RESET      |
| CS (white)   | P0.5       | P1.1       | P2.0       |
| MISO (black) | P0.4       | P1.0       | P1.6       |
| MOSI (grey)  | P0.3       | P0.7       | P1.5       |
| CLK (purple) | P0.2       | P0.5       | P1.2       |

## Troubleshooting

If the uploading fails, it is probably because your cable from the buspirate to the nRF24LE1 is too long. Make sure they are not too long. Also, it is possible to reduce the speed of the transfer via the SPI. In order to do that, a couple of values need to be changed in `nRF24LE1_PROG/nrfprog.c`. Please do a diff between the `nRF24LE1_PROG/nrfprog.c` and the `nRF24LE1_PROG/nrfprog.fast.c` file to see what values need to be changed.

## Other informations

- If you intend  to use nRF24LU1 instead of nRF24LE1, look at the commit [87bd1371fdc29e5af2a216959b82cfb132bbcf60](https://github.com/zerog2k/nrfprog/commit/87bd1371fdc29e5af2a216959b82cfb132bbcf60) from [zerog2k/nrfprog](https://github.com/zerog2k/nrfprog)
- [SDK Documentation](https://github.com/justind000/nrf24le1_wiring)
- [nRF24LE1 Datasheet](https://www.nordicsemi.com/kor/nordic/content_download/2443/29442/file/nRF24LE1_Product_Specification_rev1_6.pdf)
- [nRF24LU1 Datasheet](https://www.nordicsemi.com/eng/nordic/content_download/2727/34078/file/Product_Specification_nRF24LU1_v1_1.pdf)



Thank you to:

- [zerog2k/nrf24le1_wiring](https://github.com/zerog2k/nrf24le1_wiring)