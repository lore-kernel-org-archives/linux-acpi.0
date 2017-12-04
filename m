From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] thinkad_acpi: Support the battery wear control
Date: Mon, 04 Dec 2017 15:53:32 +0100
Message-ID: <3171660.sUGE0a2FEN@aspire.rjw.lan>
References: <20171203225640.GA11655@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171203225640.GA11655@thinkpad>
Sender: linux-doc-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Sunday, December 3, 2017 11:56:40 PM CET Ognjen Galic wrote:
> Add support for the ACPI batteries on newer thinkpad models
> (>Sandy Bridge) that support the setting of start and stop
> thresholds.
> 
> The actual interface to the driver is a extension for the
> existing ACPI battery driver. This was done so that users
> can write transparently to the interface of the ACPI battery
> driver and dont have to use some private interface
> (for ex. /sys/devices/platform/thinkpad_acpi/).
> 
> Two new interfaces are created:
> 
> /sys/class/power_supply/BAT{0,1}/charge_start_threshold
> /sys/class/power_supply/BAT{0,1}/charge_stop_threshold
> 
> The ACPI battery driver won't expose the interface unless
> DMI says that the machine is a Lenovo ThinkPad. This was done
> so that distributions that distribute thinkpad_acpi don't
> expose the API on non-ThinkPad laptops.
> 
> v2: Forgot to signoff, fixed that
> 
> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
> ---
>  Documentation/laptops/thinkpad-acpi.txt |  16 ++
>  drivers/acpi/battery.c                  | 227 +++++++++++++++++++
>  drivers/platform/x86/Kconfig            |  11 +
>  drivers/platform/x86/thinkpad_acpi.c    | 376 ++++++++++++++++++++++++++++++++
>  include/linux/thinkpad_acpi.h           |  16 ++
>  5 files changed, 646 insertions(+)
> 
> diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
> index 00b6dfe..9aca62d 100644
> --- a/Documentation/laptops/thinkpad-acpi.txt
> +++ b/Documentation/laptops/thinkpad-acpi.txt
> @@ -46,6 +46,7 @@ detailed description):
>  	- Fan control and monitoring: fan speed, fan enable/disable
>  	- WAN enable and disable
>  	- UWB enable and disable
> +	- Battery Wear Control (BWC)
>  
>  A compatibility table by model and feature is maintained on the web
>  site, http://ibm-acpi.sf.net/. I appreciate any success or failure
> @@ -1376,6 +1377,21 @@ For more details about which buttons will appear depending on the mode, please
>  review the laptop's user guide:
>  http://www.lenovo.com/shop/americas/content/user_guides/x1carbon_2_ug_en.pdf
>  
> +Battey Wear Control (BWC)
> +-------------------------
> +
> +The driver supports control for the embedded controller ACPI battery configuration.
> +This means that you can set start and stop charge thresholds for batteries in
> +ThinkPads that have a processor newer than Sandy Bridge.
> +
> +The actual sysfs interface is an extension of the standard ACPI battery interface.
> +The interface is usually in:
> +
> +Start thresholds:	/sys/class/power_supply/BATN/charge_start_threshold
> +Stop threshold:		/sys/class/power_supply/BATN/charge_stop_threshold
> +
> +These attributes support reading and writing.
> +
>  Multiple Commands, Module Parameters
>  ------------------------------------
>  
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 13e7b56..4852a76 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -41,6 +41,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/power_supply.h>
> +#include <linux/thinkpad_acpi.h>
>  
>  #include "battery.h"
>  
> @@ -70,6 +71,7 @@ static async_cookie_t async_cookie;
>  static bool battery_driver_registered;
>  static int battery_bix_broken_package;
>  static int battery_notification_delay_ms;
> +static int has_thinkpad_extension = 0;
>  static unsigned int cache_time = 1000;
>  module_param(cache_time, uint, 0644);
>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> @@ -626,6 +628,189 @@ static const struct device_attribute alarm_attr = {
>  	.store = acpi_battery_alarm_store,
>  };
>  
> +/* --------------------------------------------------------------------------
> +                ThinkPad Battery Wear Control ACPI Extension
> +   -------------------------------------------------------------------------- */
> +
> +#ifdef CONFIG_THINKPAD_ACPI_BWC

Not really.

This is generic code, so no thinkpad_acpi-specific stuff in this file, please,
even under #ifdefs.

> +
> +/*
> + * Because the thinkpad_acpi module usually is loaded right after
> + * the disk is mounted, we will lazy-load it on demand when any of the
> + * sysfs methods is read or written if it is not loaded.
> + */
> +static int thinkpad_acpi_lazyload(void)
> +{
> +    void* func;
> +
> +    func = symbol_get(tpacpi_battery_get_functionality);
> +
> +    if (func) {
> +	// thinkpad_acpi is loaded

Please clean up these comments (they should be in C format and formatted
as described in the coding style doc).

> +	return 0;
> +    }

Thanks,
Rafael

