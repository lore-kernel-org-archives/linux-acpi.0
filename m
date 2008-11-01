From: Alan Jenkins <aj504@student.cs.york.ac.uk>
Subject: Re: [patch 2/3] acpi: compal-laptop: use rfkill switch subsystem
Date: Sat, 01 Nov 2008 10:35:20 +0000
Message-ID: <490C30E8.6050708@tuffmail.co.uk>
References: <200810292113.m9TLDM2g016601@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:15199 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbYKAKf0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Nov 2008 06:35:26 -0400
Received: by ey-out-2122.google.com with SMTP id 6so603978eyi.37
        for <linux-acpi@vger.kernel.org>; Sat, 01 Nov 2008 03:35:24 -0700 (PDT)
In-Reply-To: <200810292113.m9TLDM2g016601@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, cezary.jackiewicz@gmail.com, andi@firstfloor.org, randy.dunlap@oracle.com

allakpm@linux-foundation.org wrote:
> From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
> 
> Removing unnecessary attributes, use rfkill switch subsystem.
> 
> It depends on the rfkill changes in net-next-2.6.
> 
> [randy.dunlap@oracle.com: compal-laptop: depends on RKFILL]
> Signed-off-by: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
> Cc: Andi Kleen <andi@firstfloor.org>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Having read rfkill.txt and tested the rfkill conversion for eeepc-laptop, 
I have a few queries about this one.  I hope they are useful.

Firstly, does the hardware preserve the rfkill state over power-off / reboot,
like the EeePC?

If it does, I think rfkill.txt says you need to generate "gratuitous"
input events on init.  That would allow rfkill_input to initialize
the system rfkill state from the hardware.  You should also do so on resume,
in case someone hibernates, boots into another OS, changes the state, and then
resumes back into Linux.

Otherwise, the system rfkill state will default to enabled on boot,
and your rfkill device will be set accordingly.  If compal-laptop
used to preserve the state, I think this would be a regression.

Further comments inline.
 
>  drivers/misc/Kconfig         |    2 
>  drivers/misc/compal-laptop.c |  278 ++++++++++++++-------------------
>  2 files changed, 128 insertions(+), 152 deletions(-)
> 
> diff -puN drivers/misc/Kconfig~acpi-compal-laptop-use-rfkill-switch-subsystem drivers/misc/Kconfig
> --- a/drivers/misc/Kconfig~acpi-compal-laptop-use-rfkill-switch-subsystem
> +++ a/drivers/misc/Kconfig
> @@ -232,6 +232,7 @@ config MSI_LAPTOP
>          depends on X86
>          depends on ACPI_EC
>          depends on BACKLIGHT_CLASS_DEVICE
> +	depends on RFKILL
>          ---help---
>  	  This is a driver for laptops built by MSI (MICRO-STAR
>  	  INTERNATIONAL):
> @@ -262,6 +263,7 @@ config COMPAL_LAPTOP
>  	depends on X86
>  	depends on ACPI_EC
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on RFKILL
>  	---help---
>  	  This is a driver for laptops built by Compal:
>  
> diff -puN drivers/misc/compal-laptop.c~acpi-compal-laptop-use-rfkill-switch-subsystem drivers/misc/compal-laptop.c
> --- a/drivers/misc/compal-laptop.c~acpi-compal-laptop-use-rfkill-switch-subsystem
> +++ a/drivers/misc/compal-laptop.c
> @@ -24,19 +24,10 @@
>   */
>  
>  /*
> - * comapl-laptop.c - Compal laptop support.
> + * compal-laptop.c - Compal laptop support.
>   *
> - * This driver exports a few files in /sys/devices/platform/compal-laptop/:
> - *
> - *   wlan - wlan subsystem state: contains 0 or 1 (rw)
> - *
> - *   bluetooth - Bluetooth subsystem state: contains 0 or 1 (rw)
> - *
> - *   raw - raw value taken from embedded controller register (ro)
> - *
> - * In addition to these platform device attributes the driver
> - * registers itself in the Linux backlight control subsystem and is
> - * available to userspace under /sys/class/backlight/compal-laptop/.
> + * This driver registers itself in the Linux backlight control subsystem
> + * and rfkill switch subsystem.
>   *
>   * This driver might work on other laptops produced by Compal. If you
>   * want to try it you can pass force=1 as argument to the module which
> @@ -52,8 +43,12 @@
>  #include <linux/backlight.h>
>  #include <linux/platform_device.h>
>  #include <linux/autoconf.h>
> +#include <linux/rfkill.h>
>  
> -#define COMPAL_DRIVER_VERSION "0.2.6"
> +#define COMPAL_DRIVER_VERSION "0.3.0"
> +#define COMPAL_DRIVER_NAME "compal-laptop"
> +#define COMPAL_ERR KERN_ERR COMPAL_DRIVER_NAME ": "
> +#define COMPAL_INFO KERN_INFO COMPAL_DRIVER_NAME ": "
>  
>  #define COMPAL_LCD_LEVEL_MAX 8
>  
> @@ -64,6 +59,10 @@
>  #define WLAN_MASK	0x01
>  #define BT_MASK 	0x02
>  
> +/* rfkill switches */
> +static struct rfkill *bluetooth_rfkill;
> +static struct rfkill *wlan_rfkill;
> +
>  static int force;
>  module_param(force, bool, 0);
>  MODULE_PARM_DESC(force, "Force driver load, ignore DMI data");
> @@ -89,67 +88,6 @@ static int get_lcd_level(void)
>  	return (int) result;
>  }
>  
> -static int set_wlan_state(int state)
> -{
> -	u8 result, value;
> -
> -	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
> -
> -	if ((result & KILLSWITCH_MASK) == 0)
> -		return -EINVAL;
> -	else {
> -		if (state)
> -			value = (u8) (result | WLAN_MASK);
> -		else
> -			value = (u8) (result & ~WLAN_MASK);
> -		ec_write(COMPAL_EC_COMMAND_WIRELESS, value);
> -	}
> -
> -	return 0;
> -}
> -
> -static int set_bluetooth_state(int state)
> -{
> -	u8 result, value;
> -
> -	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
> -
> -	if ((result & KILLSWITCH_MASK) == 0)
> -		return -EINVAL;
> -	else {
> -		if (state)
> -			value = (u8) (result | BT_MASK);
> -		else
> -			value = (u8) (result & ~BT_MASK);
> -		ec_write(COMPAL_EC_COMMAND_WIRELESS, value);
> -	}
> -
> -	return 0;
> -}
> -
> -static int get_wireless_state(int *wlan, int *bluetooth)
> -{
> -	u8 result;
> -
> -	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
> -
> -	if (wlan) {
> -		if ((result & KILLSWITCH_MASK) == 0)
> -			*wlan = 0;
> -		else
> -			*wlan = result & WLAN_MASK;
> -	}
> -
> -	if (bluetooth) {
> -		if ((result & KILLSWITCH_MASK) == 0)
> -			*bluetooth = 0;
> -		else
> -			*bluetooth = (result & BT_MASK) >> 1;
> -	}
> -
> -	return 0;
> -}
> -
>  /* Backlight device stuff */
>  
>  static int bl_get_brightness(struct backlight_device *b)
> @@ -172,99 +110,121 @@ static struct backlight_device *compalbl
>  
>  /* Platform device */
>  
> -static ssize_t show_wlan(struct device *dev,
> -	struct device_attribute *attr, char *buf)
> -{
> -	int ret, enabled;
> +static struct platform_driver compal_driver = {
> +	.driver = {
> +		.name = COMPAL_DRIVER_NAME,
> +		.owner = THIS_MODULE,
> +	}
> +};
>  
> -	ret = get_wireless_state(&enabled, NULL);
> -	if (ret < 0)
> -		return ret;
> +static struct platform_device *compal_device;
>  
> -	return sprintf(buf, "%i\n", enabled);
> -}
> +/* rfkill stuff */
>  
> -static ssize_t show_raw(struct device *dev,
> -	struct device_attribute *attr, char *buf)
> +static int wlan_rfk_set(void *data, enum rfkill_state state)
>  {
> -	u8 result;
> +	u8 result, value;
>  
>  	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
>  
> -	return sprintf(buf, "%i\n", result);
> +	if ((result & KILLSWITCH_MASK) == 0)
> +		return 0;
> +	else {
> +		if (state == RFKILL_STATE_ON)
> +			value = (u8) (result | WLAN_MASK);
> +		else
> +			value = (u8) (result & ~WLAN_MASK);
> +		ec_write(COMPAL_EC_COMMAND_WIRELESS, value);
> +	}
> +
> +	return 0;
>  }
>  
> -static ssize_t show_bluetooth(struct device *dev,
> -	struct device_attribute *attr, char *buf)
> +static int wlan_rfk_get(void *data, enum rfkill_state *state)
>  {
> -	int ret, enabled;
> +	u8 result;
>  
> -	ret = get_wireless_state(NULL, &enabled);
> -	if (ret < 0)
> -		return ret;
> +	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
>  
> -	return sprintf(buf, "%i\n", enabled);
> +	if ((result & KILLSWITCH_MASK) == 0)
> +		*state = RFKILL_STATE_OFF;

Shouldn't new code use RFKILL_STATE_UNBLOCKED and co.?

> +	else
> +		*state = result & WLAN_MASK;
> +
> +	return 0;
>  }

<snip>

> +static int __init compal_rfkill(struct rfkill **rfk,
> +				const enum rfkill_type rfktype,
> +				const char *name,
> +				int (*toggle_radio)(void *, enum rfkill_state),
> +				int (*get_state)(void *, enum rfkill_state *))
> +{
> +	int res;
> +
> +	(*rfk) = rfkill_allocate(&compal_device->dev, rfktype);
> +	if (!*rfk) {
> +		printk(COMPAL_ERR
> +				"failed to allocate memory for rfkill class\n");
> +		return -ENOMEM;
>  	}
> -};
>  
> -static struct platform_device *compal_device;
> +	(*rfk)->name = name;
> +	(*rfk)->get_state = get_state;
> +	(*rfk)->toggle_radio = toggle_radio;
> +	(*rfk)->user_claim_unsupported = 1;

I think this is also required to set (*rfk)->state (to whatever the current state
of the rfkill device happens to be).

> +	res = rfkill_register(*rfk);
> +	if (res < 0) {
> +		printk(COMPAL_ERR
> +				"failed to register %s rfkill switch: %d\n",
> +				name, res);
> +		rfkill_free(*rfk);
> +		*rfk = NULL;
> +		return res;
> +	}
> +
> +	return 0;
> +}

<snip>  

> @@ -347,23 +308,28 @@ static int __init compal_init(void)
>  
>  	ret = platform_device_add(compal_device);
>  	if (ret)
> -		goto fail_platform_device1;
> +		goto fail_platform_device;
>  
> -	ret = sysfs_create_group(&compal_device->dev.kobj,
> -		&compal_attribute_group);
> -	if (ret)
> -		goto fail_platform_device2;
> -
> -	printk(KERN_INFO "compal-laptop: driver "COMPAL_DRIVER_VERSION
> -		" successfully loaded.\n");
> +	/* Register rfkill stuff */
>  
> -	return 0;
> +	compal_rfkill(&wlan_rfkill,
> +					RFKILL_TYPE_WLAN,
> +					"compal_laptop_wlan_sw",
> +					wlan_rfk_set,
> +					wlan_rfk_get);
> +
> +	compal_rfkill(&bluetooth_rfkill,
> +					RFKILL_TYPE_BLUETOOTH,
> +					"compal_laptop_bluetooth_sw",
> +					bluetooth_rfk_set,
> +					bluetooth_rfk_get);

Nit:
You don't test for allocation failure here - if there's not enough
memory, you just print a warning and go on without the rfkill devices.

I don't think there's a law against it, but it just strikes me as odd.
  
> -fail_platform_device2:
> +	printk(COMPAL_INFO "driver "COMPAL_DRIVER_VERSION
> +			" successfully loaded.\n");
>  
> -	platform_device_del(compal_device);
> +	return 0;
>  
> -fail_platform_device1:
> +fail_platform_device:
>  
>  	platform_device_put(compal_device);
>  
> @@ -380,13 +346,21 @@ fail_backlight:
>  
