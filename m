From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] acpi_bus_register_driver conflict fix in acpi
 drivers
Date: 12 Nov 2004 01:39:50 -0500
Message-ID: <1100241590.5520.936.camel@d845pe>
References: <9DE394C12A921946AEECE1F71944ECD58E4126@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <9DE394C12A921946AEECE1F71944ECD58E4126@pdsmsx404>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Zhenyu Z Wang <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Michael Fu <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu, Bing Wei" <bing.wei.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

If every driver that probed out printed messages about how it failed to
discover a device, then a typical distro would have about a million
failed driver probe messages...


On Fri, 2004-11-12 at 01:29, Wang, Zhenyu Z wrote:
> a01-acpi_devices_fix.patch
> 
> This patch is accord with acpi_bus_register_driver return value fix.
> acpi driver won't cause any side effect if no device found to that
> driver. 
> After this patch, output on my dell looks like:
> ACPI: AC [not found]
> ACPI: Asus_acpi [not found]
> ACPI: Battery [not found]
> ACPI: Power Button (FF) [PWRF]
> ACPI: Fan [not found]
> ACPI: Processor [CPU0] (supports C1)
> ACPI: Thermal [not found]
> 
> which tell "not found" devices that acpi can't handle on that box.
> 
> Signed-off-by: Wang, Zhenyu <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> ---
> 
>  a/drivers/acpi/ac.c             |    5 ++++-
>  a/drivers/acpi/asus_acpi.c      |    4 +++-
>  a/drivers/acpi/battery.c        |    5 ++++-
>  a/drivers/acpi/button.c         |    5 ++++-
>  a/drivers/acpi/fan.c            |    5 ++++-
>  a/drivers/acpi/processor.c      |    5 ++++-
>  acpi-2.6/drivers/acpi/thermal.c |    7 +++++--
>  7 files changed, 28 insertions(+), 8 deletions(-)
> 
> --- a/drivers/acpi/ac.c~fix	2004-11-12 10:02:28.000000000 +0800
> +++ a/drivers/acpi/ac.c	2004-11-12 13:05:44.000000000 +0800
> @@ -328,8 +328,11 @@ acpi_ac_init (void)
>  	acpi_ac_dir->owner = THIS_MODULE;
>  
>  	result = acpi_bus_register_driver(&acpi_ac_driver);
> -	if (result < 0) {
> +	if (result < 1) {
> +		if (result != -ENOENT)
> +			acpi_bus_driver_del(&acpi_ac_driver);
>  		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
> +		printk (KERN_INFO PREFIX "AC [not found]\n");
>  		return_VALUE(-ENODEV);
>  	}
>  
> --- a/drivers/acpi/battery.c~fix	2004-11-12 11:09:37.000000000
> +0800
> +++ a/drivers/acpi/battery.c	2004-11-12 13:05:25.000000000 +0800
> @@ -827,8 +827,11 @@ acpi_battery_init (void)
>  	acpi_battery_dir->owner = THIS_MODULE;
>  
>  	result = acpi_bus_register_driver(&acpi_battery_driver);
> -	if (result < 0) {
> +	if (result < 1) {
> +		if (result != -ENOENT)
> +			acpi_bus_driver_del(&acpi_battery_driver);
>  		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
> +		printk (KERN_INFO PREFIX "Battery [not found]\n");
>  		return_VALUE(-ENODEV);
>  	}
>  
> --- a/drivers/acpi/asus_acpi.c~fix	2004-11-12 11:37:38.000000000
> +0800
> +++ a/drivers/acpi/asus_acpi.c	2004-11-12 13:05:34.000000000 +0800
> @@ -1213,8 +1213,10 @@ static int __init asus_acpi_init(void)
>  
>  	result = acpi_bus_register_driver(&asus_hotk_driver);
>  	if (result < 1) {
> -		acpi_bus_unregister_driver(&asus_hotk_driver);
> +		if (result != -ENOENT)
> +			acpi_bus_driver_del(&asus_hotk_driver);
>  		remove_proc_entry(PROC_ASUS, acpi_root_dir);
> +		printk (KERN_INFO PREFIX "Asus_acpi [not found]\n");
>  		return -ENODEV;
>  	}
>  
> --- a/drivers/acpi/button.c~fix	2004-11-08 13:45:07.000000000 +0800
> +++ a/drivers/acpi/button.c	2004-11-12 12:42:30.000000000 +0800
> @@ -532,8 +532,11 @@ acpi_button_init (void)
>  	acpi_button_dir->owner = THIS_MODULE;
>  
>  	result = acpi_bus_register_driver(&acpi_button_driver);
> -	if (result < 0) {
> +	if (result < 1) {
> +		if (result != -ENOENT)
> +			acpi_bus_driver_del(&acpi_button_driver);
>  		remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
> +		printk (KERN_INFO PREFIX "Button [not found]\n");
>  		return_VALUE(-ENODEV);
>  	}
>  
> --- a/drivers/acpi/fan.c~fix	2004-11-12 09:46:30.000000000 +0800
> +++ a/drivers/acpi/fan.c	2004-11-12 12:43:04.000000000 +0800
> @@ -280,8 +280,11 @@ acpi_fan_init (void)
>  	acpi_fan_dir->owner = THIS_MODULE;
>  
>  	result = acpi_bus_register_driver(&acpi_fan_driver);
> -	if (result < 0) {
> +	if (result < 1) {
> +		if (result != -ENOENT)
> +			acpi_bus_driver_del(&acpi_fan_driver);
>  		remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
> +		printk (KERN_INFO PREFIX "Fan [not found]\n");
>  		return_VALUE(-ENODEV);
>  	}
>  
> --- a/drivers/acpi/processor.c~fix	2004-11-12 11:40:00.000000000
> +0800
> +++ a/drivers/acpi/processor.c	2004-11-12 12:43:25.000000000 +0800
> @@ -2465,8 +2465,11 @@ acpi_processor_init (void)
>  	acpi_processor_dir->owner = THIS_MODULE;
>  
>  	result = acpi_bus_register_driver(&acpi_processor_driver);
> -	if (result < 0) {
> +	if (result < 1) {
> +		if (result != -ENOENT)
> +			acpi_bus_driver_del(&acpi_processor_driver);
>  		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> +		printk (KERN_INFO PREFIX "processor [not found]\n");
>  		return_VALUE(-ENODEV);
>  	}
>  
> --- acpi-2.6/drivers/acpi/thermal.c	2004-11-12 13:41:51.539769280
> +0800
> +++ acpi-2.6/drivers/acpi/thermal.c.fix	2004-11-12 13:14:40.263760928
> +0800
> @@ -1305,7 +1305,7 @@ acpi_thermal_add (
>  
>  	result = acpi_thermal_add_fs(device);
>  	if (result)
> -		return_VALUE(result);
> +		goto end;
>  
>  	init_timer(&tz->timer);
>  
> @@ -1389,8 +1389,11 @@ acpi_thermal_init (void)
>  	acpi_thermal_dir->owner = THIS_MODULE;
>  
>  	result = acpi_bus_register_driver(&acpi_thermal_driver);
> -	if (result < 0) {
> +	if (result < 1) {
> +		if (result != -ENOENT)
> +			acpi_bus_driver_del(&acpi_thermal_driver);
>  		remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
> +		printk (KERN_INFO PREFIX "Thermal [not found]\n");
>  		return_VALUE(-ENODEV);
>  	}
>  



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
