From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] processor.ko: use kobject_hotplug() to notify user
 agent
Date: 11 Nov 2004 03:56:54 -0500
Message-ID: <1100163414.6091.698.camel@d845pe>
References: <20041110182213.B15383@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041110182213.B15383-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developer <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Wed, 2004-11-10 at 21:22, Keshavamurthy Anil S wrote:
> Hi Len,
>         This is again due to "hotplug_path" getting un-exported from
> mm3, this below code which was
> depending on hotlpug_path was breaking from compiling. Now using
> kobject_hotplut() to notify user agenet.
> This patch fixes the undefined "hotplug_path" warning.
> 
> Please apply this fix.
> 
> ---
> 
>  linux-2.6.10-rc1-mm4-askeshav/drivers/acpi/processor.c |   58
> +----------------
>  1 files changed, 4 insertions(+), 54 deletions(-)
> 
> diff -puN drivers/acpi/processor.c~processor_u1_hotplug_path_fix
> drivers/acpi/processor.c
> ---
> linux-2.6.10-rc1-mm4/drivers/acpi/processor.c~processor_u1_hotplug_path_fix 2004-11-10 13:33:38.143298918 -0800
> +++ linux-2.6.10-rc1-mm4-askeshav/drivers/acpi/processor.c     
> 2004-11-10 13:33:38.220447354 -0800
> @@ -2628,56 +2628,6 @@ static struct dmi_system_id __initdata p
>  static int is_processor_present(acpi_handle handle);
> 
>  static int
> -processor_run_sbin_hotplug(struct acpi_device *device,
> -              int cpu, char *action)
> -{
> -       char *argv[3], *envp[7], action_str[32], cpu_str[15];
> -       int i, ret;
> -       int len;
> -       char pathname[ACPI_PATHNAME_MAX] = {0};
> -       acpi_status status;
> -       char *processor_str;
> -       struct acpi_buffer buffer = {ACPI_PATHNAME_MAX, pathname};
> -
> -       ACPI_FUNCTION_TRACE("processor_run_sbin_hotplug");
> -
> -
> -       status = acpi_get_name(device->handle, ACPI_FULL_PATHNAME,
> &buffer);
> -       if (ACPI_FAILURE(status)) {
> -               return(-ENODEV);
> -       }
> -
> -       len = strlen("PROCESSOR=") + strlen(pathname) + 1;
> -       processor_str = kmalloc(len, GFP_KERNEL);
> -       if (!processor_str)
> -               return(-ENOMEM);
> -
> -       sprintf(processor_str, "PROCESSOR=%s",pathname);
> -       sprintf(action_str, "ACTION=%s", action);
> -       sprintf(cpu_str, "CPU=%d", cpu);
> -
> -       i = 0;
> -       argv[i++] = hotplug_path;
> -       argv[i++] = "cpu";
> -       argv[i] = NULL;
> -
> -       i = 0;
> -       envp[i++] = "HOME=/";
> -       envp[i++] = "PATH=/sbin;/bin;/usr/sbin;/usr/bin";
> -       envp[i++] = action_str;
> -       envp[i++] = processor_str;
> -       envp[i++] = cpu_str;
> -       envp[i++] = "PLATFORM=ACPI";
> -       envp[i] = NULL;
> -
> -       ret = call_usermodehelper(argv[0], argv, envp, 0);
> -
> -       kfree(processor_str);
> -       return_VALUE(ret);
> -}
> -
> -
> -static int
>  is_processor_present(
>         acpi_handle handle)
>  {
> @@ -2726,7 +2676,7 @@ int acpi_processor_device_add(
>                 return_VALUE(-ENODEV);
> 
>         if ((pr->id >=0) && (pr->id < NR_CPUS)) {
> -               processor_run_sbin_hotplug(*device, pr->id, "add");
> +               kobject_hotplug(&(*device)->kobj, KOBJ_ONLINE);
>         }
>         return_VALUE(0);
>  }
> @@ -2770,13 +2720,13 @@ acpi_processor_hotplug_notify (
>                 }
>                
>                 if (pr->id >= 0 && (pr->id < NR_CPUS)) {
> -                       processor_run_sbin_hotplug(device, pr->id,
> "remove");
> +                       kobject_hotplug(&device->kobj, KOBJ_OFFLINE);
>                         break;
>                 }
> 
>                 result = acpi_processor_start(device);
>                 if ((!result) && ((pr->id >=0) && (pr->id < NR_CPUS)))
> {
> -                       processor_run_sbin_hotplug(device, pr->id,
> "add");
> +                       kobject_hotplug(&device->kobj, KOBJ_ONLINE);
>                 } else {
>                         ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>                                 "Device [%s] failed to start\n",
> @@ -2797,7 +2747,7 @@ acpi_processor_hotplug_notify (
>                 }
> 
>                 if ((pr->id < NR_CPUS) && (cpu_present(pr->id)))
> -                       processor_run_sbin_hotplug(device, pr->id,
> "remove");
> +                       kobject_hotplug(&device->kobj, KOBJ_OFFLINE);
>                 break;
>         default:
>                 ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> _
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
