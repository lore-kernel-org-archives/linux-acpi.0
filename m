From: Patrick Mochel <mochel@linux.intel.com>
Subject: Re: PATCH [1/3]: Provide generic backlight support in Asus ACPI driver
Date: Tue, 18 Apr 2006 09:11:00 -0700
Message-ID: <20060418161100.GA31763@linux.intel.com>
References: <20060418082952.GA13811@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:62149 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750769AbWDRQOe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Apr 2006 12:14:34 -0400
Content-Disposition: inline
In-Reply-To: <20060418082952.GA13811@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Apr 18, 2006 at 09:29:52AM +0100, Matthew Garrett wrote:
> This allows Asus backlight control to be performed via 
> /sys/class/backlight. It does not currently remove the legacy /proc 
> interface.

Neat, though a few questions that apply to each of the three ACPI platform drivers..


> diff -urp drivers/acpi.bak/asus_acpi.c drivers/acpi/asus_acpi.c

> +static struct backlight_device *asus_backlight_device;
> +

Why is this dynamically allocated? If there is only one per driver, then the
register() function could take that as a parameter -- instead of passing various
variable to initialize it with -- and return an error. 

> -static int read_brightness(void)
> +static int read_brightness(struct backlight_device *bd)

It seems that you're always passing NULL to this. And, if you're not passing NULL,
aren't you always referencing the single global instance above? 

> -static void set_brightness(int value)
> +static int set_brightness(struct backlight_device *bd, int value)
>  {
>  	acpi_status status = 0;
>  
> +	value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
> +	/* 0 <= value <= 15 */

Is there something wrong with:

	if (value < 0)
		value = 0;
	else if (value > 15)
		value = 15;

? Or, could you just make the parameter an unsigned int and just keep the 2nd check? 

> -		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
> -		/* 0 <= value <= 15 */
> -		set_brightness(value);
> +		set_brightness(NULL,value);

There should be a space between parameters. 

> +	asus_backlight_device = backlight_device_register ("asus_bl", NULL,
> +							   &asusbl_data);
> +
> +	if (IS_ERR (asus_backlight_device)) {
> +		printk("Unable to register backlight\n");

Could you print the name of the driver? 

> +		acpi_bus_unregister_driver(&asus_hotk_driver);
> +		remove_proc_entry(PROC_ASUS, acpi_root_dir);

If the backlight fails to register, does it mean that these must also fail? 


Thanks,


	Patrick
