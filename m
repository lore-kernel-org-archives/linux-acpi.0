From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 09/12] acpi: fix container's notify handler to handle
 proper cases properly
Date: 02 Mar 2005 14:08:27 -0500
Message-ID: <1109790506.2103.582.camel@d845pe>
References: <200502230953.j1N9rMN2020714@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502230953.j1N9rMN2020714-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.
thanks,
-Len

On Wed, 2005-02-23 at 04:53, akpm-3NddpPZAyC0@public.gmane.org wrote:
> From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> 
> This is to fix container's ACPI notify handler to handle proper cases
> properly.
> 
> Previously, the handler tried to make a container device be offline if
> an
> ACPI_NOTIFY_BUS/DEVICE_CHECK notification is performed on the device
> was
> present and has its acpi_device.  But, the condition is weird. 
> Whenever
> the notification is performed, there should be only the following two
> conditions:
> 
>   1. the device is present, but does not have its acpi_device.
>   2. the device is not present, but has its acpi_device.
> 
> #1 is a hot-addition case, which was handled properly also in previous
> handler.  #2 is a surprising hot-removal case, which was not handled
> in
> previous handler.
> 
> Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-akpm/drivers/acpi/container.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff -puN
> drivers/acpi/container.c~acpi-fix-containers-notify-handler-to-handle-proper-cases-properly drivers/acpi/container.c
> ---
> 25/drivers/acpi/container.c~acpi-fix-containers-notify-handler-to-handle-proper-cases-properly      2005-02-23 01:48:06.000000000 -0800
> +++ 25-akpm/drivers/acpi/container.c    2005-02-23 01:48:06.000000000
> -0800
> @@ -177,13 +177,18 @@ container_notify_cb(acpi_handle handle,
>                 printk("Container driver received %s event\n",
>                         (type == ACPI_NOTIFY_BUS_CHECK)?
>                        
> "ACPI_NOTIFY_BUS_CHECK":"ACPI_NOTIFY_DEVICE_CHECK");
> +               status = acpi_bus_get_device(handle, &device);
>                 if (present) {
> -                       status = acpi_bus_get_device(handle, &device);
>                         if (ACPI_FAILURE(status) || !device) {
>                                 result = container_device_add(&device,
> handle);
>                                 if (!result)
> -                                       kobject_hotplug(&device->kobj,
> KOBJ_ONLINE);
> -                       } else {
> +                                       kobject_hotplug(&device->kobj,
> +                                                       KOBJ_ONLINE);
> +                               else
> +                                       printk("Failed to add
> container\n");
> +                       }
> +               } else {
> +                       if (ACPI_SUCCESS(status)) {
>                                 /* device exist and this is a remove
> request */
>                                 kobject_hotplug(&device->kobj,
> KOBJ_OFFLINE);
>                         }
> _
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
