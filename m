From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] acpi_bus_register_driver conflict fix patches
 announce
Date: 12 Nov 2004 01:37:11 -0500
Message-ID: <1100241430.5517.932.camel@d845pe>
References: <9DE394C12A921946AEECE1F71944ECD58E4114@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <9DE394C12A921946AEECE1F71944ECD58E4114@pdsmsx404>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Zhenyu Z Wang <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Michael Fu <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu, Bing Wei" <bing.wei.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

this patch is in direct conflict with bjorn's proposal to make
acpi_bus_register_driver() consistent (again) with 
pci_register_driver().

We can't have it both ways...

-Len

On Fri, 2004-11-12 at 01:22, Wang, Zhenyu Z wrote:
> a00-acpi_bus_register_driver_fix.patch
> 
> This patch is for correct the return value flaw of
> acpi_bus_register_driver.
> It should return the number of devices claimed by the driver, or
> negative error code.
> I've also seperate out acpi_bus_driver_add/acpi_bus_driver_del, which
> will be 
> used by acpi drivers on error condition handling. 
> 
> Signed-off-by: Wang, Zhenyu <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> ---
> 
> drivers/acpi/acpi_ksyms.c |    2 ++
>  drivers/acpi/scan.c       |   42
> ++++++++++++++++++++++++++++++------------
>  include/acpi/acpi_bus.h   |    2 ++
>  3 files changed, 34 insertions(+), 12 deletions(-)
> 
> --- a/drivers/acpi/scan.c~driver_attach	2004-11-12 11:34:14.000000000
> +0800
> +++ a/drivers/acpi/scan.c	2004-11-12 12:39:34.000000000 +0800
> @@ -372,7 +372,7 @@ acpi_bus_driver_init (
>  static int acpi_driver_attach(struct acpi_driver * drv)
>  {
>  	struct list_head * node, * next;
> -	int count = 0;
> +	int count = 0, result = 0;
>  
>  	ACPI_FUNCTION_TRACE("acpi_driver_attach");
>  
> @@ -384,18 +384,23 @@ static int acpi_driver_attach(struct acp
>  			continue;
>  		spin_unlock(&acpi_device_lock);
>  
> -		if (!acpi_bus_match(dev, drv)) {
> -			if (!acpi_bus_driver_init(dev, drv)) {
> +		if (!(result = acpi_bus_match(dev, drv))) {
> +			if (!(result = acpi_bus_driver_init(dev, drv)))
> {
>  				atomic_inc(&drv->references);
>  				count++;
>  				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found
> driver [%s] for device [%s]\n",
>  						  drv->name,
> dev->pnp.bus_id));
> +			} else { 
> +				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Attach
> driver [%s] for device [%s] fail!\n", drv->name, dev->pnp.bus_id));
>  			}
>  		}
>  		spin_lock(&acpi_device_lock);
>  	}
>  	spin_unlock(&acpi_device_lock);
> -	return_VALUE(count);
> +	if (result != -ENOENT && !count)
> +		return_VALUE(result);
> +	else
> +		return_VALUE(count);
>  }
>  
>  static int acpi_driver_detach(struct acpi_driver * drv)
> @@ -422,6 +427,24 @@ static int acpi_driver_detach(struct acp
>  	return_VALUE(0);
>  }
>  
> +void
> +acpi_bus_driver_add(
> +	struct acpi_driver *driver)
> +{
> +	spin_lock(&acpi_device_lock);
> +	list_add_tail(&driver->node, &acpi_bus_drivers);
> +	spin_unlock(&acpi_device_lock);
> +}
> +
> +void
> +acpi_bus_driver_del(
> +	struct acpi_driver *driver)
> +{
> +	spin_lock(&acpi_device_lock);
> +	list_del_init(&driver->node);
> +	spin_unlock(&acpi_device_lock);
> +}
> +
>  /**
>   * acpi_bus_register_driver 
>   * ------------------------ 
> @@ -444,9 +467,7 @@ acpi_bus_register_driver (
>  	if (!driver)
>  		return_VALUE(-EINVAL);
>  
> -	spin_lock(&acpi_device_lock);
> -	list_add_tail(&driver->node, &acpi_bus_drivers);
> -	spin_unlock(&acpi_device_lock);
> +	acpi_bus_driver_add(driver);
>  	count = acpi_driver_attach(driver);
>  
>  	return_VALUE(count);
> @@ -470,11 +491,8 @@ acpi_bus_unregister_driver (
>  	if (driver) {
>  		acpi_driver_detach(driver);
>  
> -		if (!atomic_read(&driver->references)) {
> -			spin_lock(&acpi_device_lock);
> -			list_del_init(&driver->node);
> -			spin_unlock(&acpi_device_lock);
> -		} 
> +		if (!atomic_read(&driver->references)) 
> +			acpi_bus_driver_del(driver);
>  	} else 
>  		error = -EINVAL;
>  	return_VALUE(error);
> --- a/drivers/acpi/acpi_ksyms.c~fix	2004-11-12 12:40:12.000000000
> +0800
> +++ a/drivers/acpi/acpi_ksyms.c	2004-11-12 12:40:50.000000000 +0800
> @@ -135,6 +135,8 @@ EXPORT_SYMBOL(acpi_bus_generate_event);
>  EXPORT_SYMBOL(acpi_bus_receive_event);
>  EXPORT_SYMBOL(acpi_bus_register_driver);
>  EXPORT_SYMBOL(acpi_bus_unregister_driver);
> +EXPORT_SYMBOL(acpi_bus_driver_add);
> +EXPORT_SYMBOL(acpi_bus_driver_del);
>  
>  #endif /*CONFIG_ACPI_BUS*/
>  
> --- a/include/acpi/acpi_bus.h~fix	2004-11-12 12:38:53.000000000
> +0800
> +++ a/include/acpi/acpi_bus.h	2004-11-12 12:37:50.000000000 +0800
> @@ -319,6 +319,8 @@ int acpi_bus_get_power (acpi_handle hand
>  int acpi_bus_set_power (acpi_handle handle, int state);
>  int acpi_bus_generate_event (struct acpi_device *device, u8 type, int
> data);
>  int acpi_bus_receive_event (struct acpi_bus_event *event);
> +void acpi_bus_driver_add (struct acpi_driver *driver);
> +void acpi_bus_driver_del (struct acpi_driver *driver);
>  int acpi_bus_register_driver (struct acpi_driver *driver);
>  int acpi_bus_unregister_driver (struct acpi_driver *driver);
>  



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
