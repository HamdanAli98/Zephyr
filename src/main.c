#include <zephyr.h>
#include <device.h>
#include <drivers/uart.h>
#include <drivers/adc.h>
#include <sys/printk.h>
#include <logging/log.h>
#define BUFF_SIZE 256           // Adjust buffer size for larger data segments
#define RECEIVE_TIMEOUT 100     // Receive timeout in milliseconds

static uint8_t rx_buf[BUFF_SIZE] = {0};
static uint8_t tx_start_msg[] = "Starting SPS30 measurements\n";

// Commands for SPS30 sensor
static uint8_t tx_start_msg1[] = {0x7E, 0x00, 0x00, 0x02, 0x01, 0x03, 0xF9, 0x7E};
static uint8_t tx_start_msg2[] = {0x7E, 0x00, 0x01, 0x00, 0xFE, 0x7E};
static uint8_t tx_start_msg3[] = {0x7E, 0x00, 0x03, 0x00, 0xFC, 0x7E};

const struct device *uart = DEVICE_DT_GET(DT_NODELABEL(uart2));

static void uart_cb(const struct device *dev, struct uart_event *evt, void *user_data) {
    switch (evt->type) {
        case UART_RX_RDY:
            printk("Data received: ");
            for (int i = evt->data.rx.offset; i < evt->data.rx.offset + evt->data.rx.len; i++) {
                printk("%02X ", rx_buf[i]);
            }
            printk("\n");
            break;

        case UART_RX_BUF_REQUEST:
            printk("RX buffer request\n");
            uart_rx_buf_rsp(dev, rx_buf, sizeof(rx_buf));
            break;

        case UART_RX_BUF_RELEASED:
            printk("RX buffer released\n");
            break;

        case UART_RX_STOPPED:
            printk("RX stopped\n");
            break;

        case UART_RX_DISABLED:
            printk("RX disabled, re-enabling\n");
            uart_rx_enable(dev, rx_buf, sizeof(rx_buf), RECEIVE_TIMEOUT);
            break;

    }
}

void send_uart_command(const uint8_t *cmd, size_t cmd_size) {
    uint32_t err_code = uart_tx(uart, cmd, cmd_size, SYS_FOREVER_MS);
    if (err_code) {
        printk("Failed to send UART command, error %d\n", err_code);
    }
}

#define ADC_NODE DT_NODELABEL(adc)
static const struct device *adc_dev = DEVICE_DT_GET(ADC_NODE);

#define ADC_RESOLUTION 12
#define ADC_CHANNEL_COUNT 4
#define ADC_MAX_VALUE 4095
#define ADC_REF_VOLTAGE 3.3

/* Define channels */
#define ADC_CHANNEL_0_ID 0  // 0-3.3V (NO2 Sensor)
#define ADC_CHANNEL_1_ID 1  // 0-3.3V (Battery Voltage)
#define ADC_CHANNEL_3_ID 3  // 0.48-2.4V (Humidity Sensor)
#define ADC_CHANNEL_4_ID 4  // 0.48-2.4V (Temperature Sensor)

#define ADC_PORT_0 SAADC_CH_PSELP_PSELP_AnalogInput0
#define ADC_PORT_1 SAADC_CH_PSELP_PSELP_AnalogInput1
#define ADC_PORT_3 SAADC_CH_PSELP_PSELP_AnalogInput3
#define ADC_PORT_4 SAADC_CH_PSELP_PSELP_AnalogInput4

#define ADC_REFERENCE ADC_REF_INTERNAL
#define ADC_GAIN ADC_GAIN_1_6

struct adc_channel_cfg ch_cfg[ADC_CHANNEL_COUNT] = {
    {
        .gain = ADC_GAIN,
        .reference = ADC_REFERENCE,
        .acquisition_time = ADC_ACQ_TIME_DEFAULT,
        .channel_id = ADC_CHANNEL_0_ID,
#ifdef CONFIG_ADC_NRFX_SAADC
        .input_positive = ADC_PORT_0
#endif
    },
    {
        .gain = ADC_GAIN,
        .reference = ADC_REFERENCE,
        .acquisition_time = ADC_ACQ_TIME_DEFAULT,
        .channel_id = ADC_CHANNEL_1_ID,
#ifdef CONFIG_ADC_NRFX_SAADC
        .input_positive = ADC_PORT_1
#endif
    },
    {
        .gain = ADC_GAIN,
        .reference = ADC_REFERENCE,
        .acquisition_time = ADC_ACQ_TIME_DEFAULT,
        .channel_id = ADC_CHANNEL_3_ID,
#ifdef CONFIG_ADC_NRFX_SAADC
        .input_positive = ADC_PORT_3
#endif
    },
    {
        .gain = ADC_GAIN,
        .reference = ADC_REFERENCE,
        .acquisition_time = ADC_ACQ_TIME_DEFAULT,
        .channel_id = ADC_CHANNEL_4_ID,
#ifdef CONFIG_ADC_NRFX_SAADC
        .input_positive = ADC_PORT_4
#endif
    }
};

int16_t sample_buffer[ADC_CHANNEL_COUNT];

struct adc_sequence sequence = {
    /* individual channels will be added below */
    .channels = BIT(ADC_CHANNEL_0_ID) | BIT(ADC_CHANNEL_1_ID) | BIT(ADC_CHANNEL_3_ID) | BIT(ADC_CHANNEL_4_ID),
    .buffer = sample_buffer,
    /* buffer size in bytes, not number of samples */
    .buffer_size = sizeof(sample_buffer),
    .resolution = ADC_RESOLUTION
};

void UART(void) {
    printk("SPS30 Sensor UART Example\n");

    if (!device_is_ready(uart)) {
        printk("UART device not ready\n");
        // return 1;
    }

    // Send the initial UART message
    send_uart_command(tx_start_msg1, sizeof(tx_start_msg1));
     k_sleep(K_MSEC(100));
	  // Start the SPS30 measurement
    send_uart_command(tx_start_msg2, sizeof(tx_start_msg2));
    k_sleep(K_MSEC(100));  // Wait for the sensor to start and stabilize

    // // Optionally read measurements
    send_uart_command(tx_start_msg3, sizeof(tx_start_msg3));
    k_sleep(K_MSEC(100));  // Delay to allow data reception before stopping

    // // Stop the SPS30 measurement
    // send_uart_command(stop_measurement_cmd, sizeof(stop_measurement_cmd));


    // Register the UART callback function
    if (uart_callback_set(uart, uart_cb, NULL) != 0) {
        printk("Failed to set UART callback\n");
        // return 1;
    }

    // Enable UART RX
    if (uart_rx_enable(uart, rx_buf, sizeof(rx_buf), RECEIVE_TIMEOUT) != 0) {
        printk("Failed to enable UART RX\n");
        // return 1;
    }

  
    // return 0;
}

void read_adc(void) {
    int err;

    if (!device_is_ready(adc_dev)) {
        printk("adc_dev not ready\n");
        return;
    }

    for (int i = 0; i < ADC_CHANNEL_COUNT; i++) {
        err = adc_channel_setup(adc_dev, &ch_cfg[i]);
        if (err != 0) {
            printk("ADC adc_channel_setup failed for channel %d with error %d.\n", ch_cfg[i].channel_id, err);
            return;
        }
    }

        err = adc_read(adc_dev, &sequence);
        if (err != 0) {
            printk("ADC reading failed with error %d.\n", err);
            return;
        }

        for (int i = 0; i < ADC_CHANNEL_COUNT; i++) {
            int16_t adc_value = sample_buffer[i];
            float real_value;
            float voltage;
            char output_string[64];

            switch (ch_cfg[i].channel_id) {
                case ADC_CHANNEL_0_ID:  // NO2 Sensor
                    voltage = ((float)adc_value / ADC_MAX_VALUE) * ADC_REF_VOLTAGE;
                    snprintf(output_string, sizeof(output_string), "NO2 Sensor value: %.2f V\n", voltage);
                    printk("%s", output_string);
                    break;
                case ADC_CHANNEL_1_ID:  // Battery Voltage
                    voltage = ((float)adc_value / ADC_MAX_VALUE) * ADC_REF_VOLTAGE;
                    snprintf(output_string, sizeof(output_string), "Battery Voltage: %.2f V\n", voltage);
                    printk("%s", output_string);
                    break;
                case ADC_CHANNEL_3_ID:  // Humidity Sensor
                    voltage = ((float)adc_value / ADC_MAX_VALUE) * ADC_REF_VOLTAGE;
                    real_value = ((voltage - 0.48) / (2.4 - 0.48)) * 100.0;
                    snprintf(output_string, sizeof(output_string), "Humidity: %.2f %%\n", real_value);
                    printk("%s", output_string);
                    break;
                case ADC_CHANNEL_4_ID:  // Temperature Sensor
                    voltage = ((float)adc_value / ADC_MAX_VALUE) * ADC_REF_VOLTAGE;
                    real_value = ((voltage - 0.48) / (2.4 - 0.48)) * 165.0 - 40.0;
                    snprintf(output_string, sizeof(output_string), "Temperature: %.2f °C\n", real_value);
                    printk("%s", output_string);
                    break;
                default:
                    snprintf(output_string, sizeof(output_string), "Unused ADC channel %d\n", ch_cfg[i].channel_id);
                    printk("%s", output_string);
                    break;
            }
        }
        k_sleep(K_MSEC(1000)); // Sleep for 1 second
    }
void main(void){
	while(1){
		read_adc();
		UART();
	}
}

