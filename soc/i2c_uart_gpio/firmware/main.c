#include <stdint.h>
#include <stdlib.h>
#include "gpio_regs.h"
#include "uart_regs.h"
#include "i2c_regs.h"
#include <stdbool.h>
void delay_long()
{

    for (uint64_t i = 0; i < 1000000; i++)
        ;
}

void delay_short()
{

    for (uint64_t i = 0; i < 1; i++)
        ;
}

void uart_send_char(uint8_t my_char)
{
    while (UCSR->U_STAT_bf.READY == 0)
        ;
    UCSR->U_DATA = my_char;
    UCSR->U_CTRL_bf.START = 1;
}

void uart_send_str(uint8_t *my_str)
{

    for (uint8_t i = 0; my_str[i] != '\0'; i++)
    {
        uart_send_char(my_str[i]);
    }
}

void i2c_write(uint8_t slave_addr, const uint8_t *data, uint32_t length)
{
    while (I2C->I2C_STATUS_bf.BUSY == 1)
        ;
    // int timeout = 0;
    // bool busy = I2C->I2C_STATUS_bf.BUSY;
    // while (true)
    // {
    //     busy = I2C->I2C_STATUS_bf.BUSY;
    //     if (!busy)
    //     {
    //         break;
    //     }
    // }
    // I2C->I2C_TXDR = 0x12;
    // I2C->I2C_CTRL_bf.DIR = 0;
    // I2C->I2C_CTRL_bf.NBYTES = 1;
    // I2C->I2C_CTRL_bf.SLAVE_ADDR = slave_addr;
    // I2C->I2C_CTRL_bf.START = 1;
}

int main()
{
    while (I2C->I2C_STATUS_bf.BUSY == 1)
        ;
    // i2c_write();

    // uart_send_str("s");
    // uint8_t data = 0x12;
    // i2c_write(0x23, &data, 1);
    // int timeout = 0;
    // while (I2C->I2C_STATUS_bf.BUSY == 1 && timeout < 1000)
    // {
    //     timeout++;
    //     GCSR->GPIO_0 = 0x55;
    //     delay_short();
    //     GCSR->GPIO_0 = 0xaa;
    //     delay_short();
    // }

    // GCSR->GPIO_0 = 0x55;

    while (1)
    {
        // i2c_write(0x23, &data, 1);
        // GCSR->GPIO_0 = 0x55;
        delay_short();
        // GCSR->GPIO_0 = 0xaa;
        // delay_short();
    }
}