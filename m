From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: fit input devices into sysfs tree
Date: Wed, 21 Nov 2007 07:55:44 +0900
Message-ID: <20071120225543.GA25225@inferi.kami.home>
References: <200710310036.52791.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:50080 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903AbXKTWz7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Nov 2007 17:55:59 -0500
Content-Disposition: inline
In-Reply-To: <200710310036.52791.dtor@insightbb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-acpi@vger.kernel.org

On Wed, Oct 31, 2007 at 12:36:52AM -0400, Dmitry Torokhov wrote:
> Hi Mattia,

Hello Dmitry!

> Here is a small patch for sony-laptop. Untested since I don't
> have the hardware.

Now tested ;)
please go on and push it.

> 
> -- 
> Dmitry
> 
> Subject: sony-laptop: fit input devices into sysfs tree
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Properly set up parent on input devices registered by sony-laptop.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Mattia Dongili <malattia@linux.it>

> ---
>  drivers/misc/sony-laptop.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> Index: linux/drivers/misc/sony-laptop.c
> ===================================================================
> --- linux.orig/drivers/misc/sony-laptop.c
> +++ linux/drivers/misc/sony-laptop.c
> @@ -338,7 +338,7 @@ static void sony_laptop_report_input_eve
>  		dprintk("unknown input event %.2x\n", event);
>  }
>  
> -static int sony_laptop_setup_input(void)
> +static int sony_laptop_setup_input(struct acpi_device *acpi_device)
>  {
>  	struct input_dev *jog_dev;
>  	struct input_dev *key_dev;
> @@ -379,6 +379,7 @@ static int sony_laptop_setup_input(void)
>  	key_dev->name = "Sony Vaio Keys";
>  	key_dev->id.bustype = BUS_ISA;
>  	key_dev->id.vendor = PCI_VENDOR_ID_SONY;
> +	key_dev->dev.parent = &acpi_device->dev;
>  
>  	/* Initialize the Input Drivers: special keys */
>  	set_bit(EV_KEY, key_dev->evbit);
> @@ -410,6 +411,7 @@ static int sony_laptop_setup_input(void)
>  	jog_dev->name = "Sony Vaio Jogdial";
>  	jog_dev->id.bustype = BUS_ISA;
>  	jog_dev->id.vendor = PCI_VENDOR_ID_SONY;
> +	key_dev->dev.parent = &acpi_device->dev;
>  
>  	jog_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
>  	jog_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_MIDDLE);
> @@ -1006,7 +1008,7 @@ static int sony_nc_add(struct acpi_devic
>  	}
>  
>  	/* setup input devices and helper fifo */
> -	result = sony_laptop_setup_input();
> +	result = sony_laptop_setup_input(device);
>  	if (result) {
>  		printk(KERN_ERR DRV_PFX
>  				"Unabe to create input devices.\n");
> @@ -1034,7 +1036,7 @@ static int sony_nc_add(struct acpi_devic
>  			sony_backlight_device->props.brightness =
>  			    sony_backlight_get_brightness
>  			    (sony_backlight_device);
> -			sony_backlight_device->props.max_brightness = 
> +			sony_backlight_device->props.max_brightness =
>  			    SONY_MAX_BRIGHTNESS - 1;
>  		}
>  
> @@ -2453,7 +2455,7 @@ static int sony_pic_add(struct acpi_devi
>  	}
>  
>  	/* setup input devices and helper fifo */
> -	result = sony_laptop_setup_input();
> +	result = sony_laptop_setup_input(device);
>  	if (result) {
>  		printk(KERN_ERR DRV_PFX
>  				"Unabe to create input devices.\n");
> 
-- 
mattia
:wq!
