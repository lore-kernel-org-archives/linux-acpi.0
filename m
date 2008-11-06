From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 06/11] ACPI: remove CONFIG_ACPI_EC
Date: Thu, 06 Nov 2008 15:57:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811061552110.3106@localhost.localdomain>
References: <20081105231710.26131.3110.stgit@bob.kio>
 <20081105231803.26131.36330.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:35033 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYKFVgy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 16:36:54 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9X008LMJJDGQ30@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 14:57:14 -0600 (CST)
In-reply-to: <20081105231803.26131.36330.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

applied.

thanks,
-Len

On Wed, 5 Nov 2008, Bjorn Helgaas wrote:

> Remove CONFIG_ACPI_EC.  It was always set the same as CONFIG_ACPI,
> and it had no menu label, so there was no way to set it to anything
> other than "y".
> 
> Per section 6.5.4 of the ACPI 3.0b specification,
> 
>     OSPM must make Embedded Controller operation regions, accessed
>     via the Embedded Controllers described in ECDT, available before
>     executing any control method.
> 
> The ECDT table is optional, but if it is present, the above text
> means that the EC it describes is a required part of the ACPI
> subsystem, so CONFIG_ACPI_EC=n wouldn't make sense.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/Kconfig        |    8 --------
>  drivers/acpi/Makefile       |    2 +-
>  drivers/acpi/bus.c          |    3 +--
>  drivers/char/sonypi.c       |    4 ++--
>  drivers/misc/Kconfig        |    4 ++--
>  include/acpi/acpi_drivers.h |    2 --
>  include/linux/acpi.h        |    4 ----
>  7 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 20f4574..768bb07 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -330,14 +330,6 @@ config ACPI_DEBUG_FUNC_TRACE
>  	  ACPI Debug Statements slow down ACPI processing. Function trace
>  	  is about half of the penalty and is rarely useful.
>  
> -config ACPI_EC
> -	bool
> -	default y
> -	help
> -	  This driver is required on some systems for the proper operation of
> -	  the battery and thermal drivers.  If you are compiling for a 
> -	  mobile system, say Y.
> -
>  config ACPI_PCI_SLOT
>  	tristate "PCI slot detection driver"
>  	default n
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 8017f63..fc62231 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -39,7 +39,7 @@ obj-y				+= sleep/
>  obj-y				+= bus.o glue.o
>  obj-y				+= scan.o
>  # Keep EC driver first. Initialization of others depend on it.
> -obj-$(CONFIG_ACPI_EC)		+= ec.o
> +obj-y				+= ec.o
>  obj-$(CONFIG_ACPI_AC) 		+= ac.o
>  obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
>  obj-$(CONFIG_ACPI_BUTTON)	+= button.o
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index c797c64..765fd1c 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -774,7 +774,7 @@ static int __init acpi_bus_init(void)
>  		       "Unable to initialize ACPI OS objects\n");
>  		goto error1;
>  	}
> -#ifdef CONFIG_ACPI_EC
> +
>  	/*
>  	 * ACPI 2.0 requires the EC driver to be loaded and work before
>  	 * the EC device is found in the namespace (i.e. before acpi_initialize_objects()
> @@ -785,7 +785,6 @@ static int __init acpi_bus_init(void)
>  	 */
>  	status = acpi_ec_ecdt_probe();
>  	/* Ignore result. Not having an ECDT is not fatal. */
> -#endif
>  
>  	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
>  	if (ACPI_FAILURE(status)) {
> diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
> index 2457b07..f437443 100644
> --- a/drivers/char/sonypi.c
> +++ b/drivers/char/sonypi.c
> @@ -523,7 +523,7 @@ static int acpi_driver_registered;
>  
>  static int sonypi_ec_write(u8 addr, u8 value)
>  {
> -#ifdef CONFIG_ACPI_EC
> +#ifdef CONFIG_ACPI
>  	if (SONYPI_ACPI_ACTIVE)
>  		return ec_write(addr, value);
>  #endif
> @@ -539,7 +539,7 @@ static int sonypi_ec_write(u8 addr, u8 value)
>  
>  static int sonypi_ec_read(u8 addr, u8 *value)
>  {
> -#ifdef CONFIG_ACPI_EC
> +#ifdef CONFIG_ACPI
>  	if (SONYPI_ACPI_ACTIVE)
>  		return ec_read(addr, value);
>  #endif
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 9494400..4494ad2 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -230,7 +230,7 @@ config HP_WMI
>  config MSI_LAPTOP
>          tristate "MSI Laptop Extras"
>          depends on X86
> -        depends on ACPI_EC
> +        depends on ACPI
>          depends on BACKLIGHT_CLASS_DEVICE
>          ---help---
>  	  This is a driver for laptops built by MSI (MICRO-STAR
> @@ -260,7 +260,7 @@ config PANASONIC_LAPTOP
>  config COMPAL_LAPTOP
>  	tristate "Compal Laptop Extras"
>  	depends on X86
> -	depends on ACPI_EC
> +	depends on ACPI
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	---help---
>  	  This is a driver for laptops built by Compal:
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 818215f..b3c40dc 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -97,10 +97,8 @@ extern int acpi_power_nocheck;
>  /* --------------------------------------------------------------------------
>                                    Embedded Controller
>     -------------------------------------------------------------------------- */
> -#ifdef CONFIG_ACPI_EC
>  int acpi_ec_ecdt_probe(void);
>  int acpi_boot_ec_enable(void);
> -#endif
>  
>  /* --------------------------------------------------------------------------
>                                      Processor
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index fd6a452..d7846bd 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -163,8 +163,6 @@ struct acpi_pci_driver {
>  int acpi_pci_register_driver(struct acpi_pci_driver *driver);
>  void acpi_pci_unregister_driver(struct acpi_pci_driver *driver);
>  
> -#ifdef CONFIG_ACPI_EC
> -
>  extern int ec_read(u8 addr, u8 *val);
>  extern int ec_write(u8 addr, u8 val);
>  extern int ec_transaction(u8 command,
> @@ -172,8 +170,6 @@ extern int ec_transaction(u8 command,
>                            u8 *rdata, unsigned rdata_len,
>  			  int force_poll);
>  
> -#endif /*CONFIG_ACPI_EC*/
> -
>  #if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
>  
>  typedef void (*wmi_notify_handler) (u32 value, void *context);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
