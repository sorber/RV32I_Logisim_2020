"""Convert a little-endian binary image into 32-bit memory words."""

import argparse
from pathlib import Path


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("img_file", type=Path, help="binary image file")
    parser.add_argument("mem_file", type=Path, help="output hex file")
    parser.add_argument("mem_size_words", type=int, help="memory size in 32-bit words")
    parser.add_argument("--logisim", action="store_true", help="add a Logisim v2.0 raw header")
    args = parser.parse_args()

    if args.mem_size_words < 0:
        parser.error("memory size must be non-negative")
    data = args.img_file.read_bytes()
    capacity = args.mem_size_words * 4
    if len(data) > capacity:
        parser.error(f"image is {len(data)} bytes, but memory holds only {capacity}")

    data = data.ljust(capacity, b"\0")
    with args.mem_file.open("w", encoding="ascii") as output:
        if args.logisim:
            output.write("v2.0 raw\n")
        for offset in range(0, capacity, 4):
            word = int.from_bytes(data[offset:offset + 4], byteorder="little")
            output.write(f"{word:08x}\n")


if __name__ == "__main__":
    main()
