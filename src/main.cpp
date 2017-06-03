#include <stdbool.h>
#include <stdint.h>
#include "nrf_delay.h"
#include "boards.h"

/**
 * @brief Function for application main entry.
 */
int main(void) {
    /* Configure board. */
    bsp_board_leds_init();

    /* Toggle LEDs. */
    while (true) {
        for (int i = 0; i < LEDS_NUMBER; i++) {
            bsp_board_led_invert(i);
            nrf_delay_ms(1000);
        }
    }
}