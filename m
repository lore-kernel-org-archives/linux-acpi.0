From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/5]add .match method for ACPI
Date: 28 Oct 2004 02:31:07 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098945067.5403.4.camel@d845pe>
References: <1098327565.6132.224.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1098327565.6132.224.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu <castet.matthieu-GANU6spQydw@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied,

thanks,
-Len

On Wed, 2004-10-20 at 22:59, Li Shaohua wrote:
> Hi,
> The idea of the patch is from Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>'s
> ACPI
> video extension patch. Since the video extension patch hasn't been
> merged and the ACPI PNP driver requires it, I attached it here.
> 
> Thanks,
> Shaohua
> 
> --- 2.6/drivers/acpi/scan.c.stg4        2004-10-18 16:49:57.926042680
> +0800
> +++ 2.6/drivers/acpi/scan.c     2004-10-18 16:57:30.572230000 +0800
> @@ -161,7 +161,7 @@ acpi_bus_get_power_flags (
>         return 0;
>  }
> 
> -static int
> +int
>  acpi_match_ids (
>         struct acpi_device      *device,
>         char                    *ids)
> @@ -314,6 +314,8 @@ acpi_bus_match (
>         struct acpi_device      *device,
>         struct acpi_driver      *driver)
>  {
> +       if (driver && driver->ops.match)
> +               return driver->ops.match(device, driver);
>         return acpi_match_ids(device, driver->ids);
>  }
> 
> @@ -495,9 +497,6 @@ acpi_bus_find_driver (
> 
>         ACPI_FUNCTION_TRACE("acpi_bus_find_driver");
> 
> -       if (!device->flags.hardware_id &&
> !device->flags.compatible_ids)
> -               goto Done;
> -
>         spin_lock(&acpi_device_lock);
>         list_for_each_safe(node,next,&acpi_bus_drivers) {
>                 struct acpi_driver * driver = container_of(node,struct
> acpi_driver,node);
> --- 2.6/include/acpi/acpi_bus.h.stg4    2004-10-18 16:50:31.522935176
> +0800
> +++ 2.6/include/acpi/acpi_bus.h 2004-10-18 16:55:11.474376088 +0800
> @@ -104,6 +104,8 @@ typedef int (*acpi_op_suspend)      (struct a
>  typedef int (*acpi_op_resume)  (struct acpi_device *device, int
> state);
>  typedef int (*acpi_op_scan)    (struct acpi_device *device);
>  typedef int (*acpi_op_bind)    (struct acpi_device *device);
> +typedef int (*acpi_op_match)   (struct acpi_device *device,
> +       struct acpi_driver *driver);
> 
>  struct acpi_device_ops {
>         acpi_op_add             add;
> @@ -115,6 +117,7 @@ struct acpi_device_ops {
>         acpi_op_resume          resume;
>         acpi_op_scan            scan;
>         acpi_op_bind            bind;
> +       acpi_op_match           match;
>  };
> 
>  struct acpi_driver {
> @@ -322,6 +325,7 @@ int acpi_bus_receive_event (struct acpi_
>  int acpi_bus_register_driver (struct acpi_driver *driver);
>  int acpi_bus_unregister_driver (struct acpi_driver *driver);
> 
> +int acpi_match_ids (struct acpi_device *device, char   *ids);
>  int acpi_create_dir(struct acpi_device *);
>  void acpi_remove_dir(struct acpi_device *);
> 
> 
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
