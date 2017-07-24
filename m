From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/7] gpio: Cleanup kerneldoc
Date: Mon, 24 Jul 2017 16:57:22 +0200
Message-ID: <20170724145728.7662-1-thierry.reding@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Some kerneldoc has become stale or wasn't quite correct from the outset.
Fix up the most serious issues to silence warnings when building the
documentation.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpiolib.c      | 82 +++++++++++++++++++++++++++++++++------------
 include/linux/gpio/driver.h |  3 +-
 2 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9568708a550b..c8493f765994 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -84,7 +84,12 @@ static inline void desc_set_label(struct gpio_desc *d, const char *label)
 }
 
 /**
- * Convert a GPIO number to its descriptor
+ * gpio_to_desc - Convert a GPIO number to its descriptor
+ * @gpio: global GPIO number
+ *
+ * Returns:
+ * The GPIO descriptor associated with the given GPIO, or %NULL if no GPIO
+ * with the given number exists in the system.
  */
 struct gpio_desc *gpio_to_desc(unsigned gpio)
 {
@@ -111,7 +116,14 @@ struct gpio_desc *gpio_to_desc(unsigned gpio)
 EXPORT_SYMBOL_GPL(gpio_to_desc);
 
 /**
- * Get the GPIO descriptor corresponding to the given hw number for this chip.
+ * gpiochip_get_desc - get the GPIO descriptor corresponding to the given
+ *                     hardware number for this chip
+ * @chip: GPIO chip
+ * @hwnum: hardware number of the GPIO for this chip
+ *
+ * Returns:
+ * A pointer to the GPIO descriptor or %ERR_PTR(-EINVAL) if no GPIO exists
+ * in the given chip for the specified hardware number.
  */
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip,
 				    u16 hwnum)
@@ -125,9 +137,14 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip,
 }
 
 /**
- * Convert a GPIO descriptor to the integer namespace.
+ * desc_to_gpio - convert a GPIO descriptor to the integer namespace
+ * @desc: GPIO descriptor
+ *
  * This should disappear in the future but is needed since we still
- * use GPIO numbers for error messages and sysfs nodes
+ * use GPIO numbers for error messages and sysfs nodes.
+ *
+ * Returns:
+ * The global GPIO number for the GPIO specified by its descriptor.
  */
 int desc_to_gpio(const struct gpio_desc *desc)
 {
@@ -254,7 +271,7 @@ static int gpiodev_add_to_list(struct gpio_device *gdev)
 	return -EBUSY;
 }
 
-/**
+/*
  * Convert a GPIO name to its descriptor
  */
 static struct gpio_desc *gpio_name_to_desc(const char * const name)
@@ -879,7 +896,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	return ret;
 }
 
-/**
+/*
  * gpio_ioctl() - ioctl handler for the GPIO chardev
  */
 static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
@@ -1078,11 +1095,9 @@ static void gpiochip_setup_devs(void)
 /**
  * gpiochip_add_data() - register a gpio_chip
  * @chip: the chip to register, with chip->base initialized
- * Context: potentially before irqs will work
+ * @data: driver-private data associated with this chip
  *
- * Returns a negative errno if the chip can't be registered, such as
- * because the chip->base is invalid or already associated with a
- * different chip.  Otherwise it returns zero as a success code.
+ * Context: potentially before irqs will work
  *
  * When gpiochip_add_data() is called very early during boot, so that GPIOs
  * can be freely used, the chip->parent device must be registered before
@@ -1094,6 +1109,11 @@ static void gpiochip_setup_devs(void)
  *
  * If chip->base is negative, this requests dynamic assignment of
  * a range of valid GPIOs.
+ *
+ * Returns:
+ * A negative errno if the chip can't be registered, such as because the
+ * chip->base is invalid or already associated with a different chip.
+ * Otherwise it returns zero as a success code.
  */
 int gpiochip_add_data(struct gpio_chip *chip, void *data)
 {
@@ -1288,6 +1308,10 @@ EXPORT_SYMBOL_GPL(gpiochip_add_data);
 
 /**
  * gpiochip_get_data() - get per-subdriver data for the chip
+ * @chip: GPIO chip
+ *
+ * Returns:
+ * The per-subdriver data for the chip.
  */
 void *gpiochip_get_data(struct gpio_chip *chip)
 {
@@ -1371,13 +1395,16 @@ static int devm_gpio_chip_match(struct device *dev, void *res, void *data)
  * devm_gpiochip_add_data() - Resource manager piochip_add_data()
  * @dev: the device pointer on which irq_chip belongs to.
  * @chip: the chip to register, with chip->base initialized
- * Context: potentially before irqs will work
+ * @data: driver-private data associated with this chip
  *
- * Returns a negative errno if the chip can't be registered, such as
- * because the chip->base is invalid or already associated with a
- * different chip.  Otherwise it returns zero as a success code.
+ * Context: potentially before irqs will work
  *
  * The gpio chip automatically be released when the device is unbound.
+ *
+ * Returns:
+ * A negative errno if the chip can't be registered, such as because the
+ * chip->base is invalid or already associated with a different chip.
+ * Otherwise it returns zero as a success code.
  */
 int devm_gpiochip_add_data(struct device *dev, struct gpio_chip *chip,
 			   void *data)
@@ -1423,7 +1450,7 @@ EXPORT_SYMBOL_GPL(devm_gpiochip_remove);
 /**
  * gpiochip_find() - iterator for locating a specific gpio_chip
  * @data: data to pass to match function
- * @callback: Callback function to check gpio_chip
+ * @match: Callback function to check gpio_chip
  *
  * Similar to bus_find_device.  It returns a reference to a gpio_chip as
  * determined by a user supplied @match callback.  The callback should return
@@ -1931,11 +1958,14 @@ EXPORT_SYMBOL_GPL(gpiochip_add_pingroup_range);
 /**
  * gpiochip_add_pin_range() - add a range for GPIO <-> pin mapping
  * @chip: the gpiochip to add the range for
- * @pinctrl_name: the dev_name() of the pin controller to map to
+ * @pinctl_name: the dev_name() of the pin controller to map to
  * @gpio_offset: the start offset in the current gpio_chip number space
  * @pin_offset: the start offset in the pin controller number space
  * @npins: the number of pins from the offset of each pin space (GPIO and
  *	pin controller) to accumulate in this range
+ *
+ * Returns:
+ * 0 on success, or a negative error-code on failure.
  */
 int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 			   unsigned int gpio_offset, unsigned int pin_offset,
@@ -2180,7 +2210,8 @@ EXPORT_SYMBOL_GPL(gpiochip_is_requested);
 
 /**
  * gpiochip_request_own_desc - Allow GPIO chip to request its own descriptor
- * @desc: GPIO descriptor to request
+ * @chip: GPIO chip
+ * @hwnum: hardware number of the GPIO for which to request the descriptor
  * @label: label for the GPIO
  *
  * Function allows GPIO chip drivers to request and use their own GPIO
@@ -2188,6 +2219,10 @@ EXPORT_SYMBOL_GPL(gpiochip_is_requested);
  * function will not increase reference count of the GPIO chip module. This
  * allows the GPIO chip module to be unloaded as needed (we assume that the
  * GPIO chip driver handles freeing the GPIOs it has requested).
+ *
+ * Returns:
+ * A pointer to the GPIO descriptor, or an ERR_PTR()-encoded negative error
+ * code on failure.
  */
 struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *chip, u16 hwnum,
 					    const char *label)
@@ -2369,12 +2404,13 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 EXPORT_SYMBOL_GPL(gpiod_direction_output);
 
 /**
- * gpiod_set_debounce - sets @debounce time for a @gpio
- * @gpio: the gpio to set debounce time
- * @debounce: debounce time is microseconds
+ * gpiod_set_debounce - sets @debounce time for a GPIO
+ * @desc: descriptor of the GPIO for which to set debounce time
+ * @debounce: debounce time in microseconds
  *
- * returns -ENOTSUPP if the controller does not support setting
- * debounce.
+ * Returns:
+ * 0 on success, %-ENOTSUPP if the controller doesn't support setting the
+ * debounce time.
  */
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 {
@@ -3323,6 +3359,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
  * @propname:	name of the firmware property representing the GPIO
  * @index:	index of the GPIO to obtain in the consumer
  * @dflags:	GPIO initialization flags
+ * @label:	label to attach to the requested GPIO
  *
  * This function can be used for drivers that get their configuration
  * from firmware.
@@ -3331,6 +3368,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
  * underlying firmware interface and then makes sure that the GPIO
  * descriptor is requested before it is returned to the caller.
  *
+ * Returns:
  * On successful request the GPIO pin is configured in accordance with
  * provided @dflags.
  *
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index af20369ec8e7..ad4150d075c3 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -327,11 +327,10 @@ int gpiochip_generic_config(struct gpio_chip *chip, unsigned offset,
 
 /**
  * struct gpio_pin_range - pin range controlled by a gpio chip
- * @head: list for maintaining set of pin ranges, used internally
+ * @node: list for maintaining set of pin ranges, used internally
  * @pctldev: pinctrl device which handles corresponding pins
  * @range: actual range of pins controlled by a gpio controller
  */
-
 struct gpio_pin_range {
 	struct list_head node;
 	struct pinctrl_dev *pctldev;
-- 
2.13.3

