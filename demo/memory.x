MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 2M
    CCRAM (xrw) : ORIGIN = 0x10000000, LENGTH = 64K
    RAM (xrw) : ORIGIN = 0x20000000, LENGTH = 192K
}
