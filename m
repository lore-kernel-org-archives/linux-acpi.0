From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 10/12] acpi_power_off bug fix
Date: 02 Mar 2005 14:10:16 -0500
Message-ID: <1109790616.2101.584.camel@d845pe>
References: <200502230953.j1N9rNKX020717@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502230953.j1N9rNKX020717-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, marado-oe7qfRrRQfcmha6Ds7sm0l6hYfS7NtTn@public.gmane.org, barryn-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Alexey Y Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I've got a couple versions of this patch
and will apply it when it is cleaned up a bit.

thanks,
-Len


On Wed, 2005-02-23 at 04:53, akpm-3NddpPZAyC0@public.gmane.org wrote:
> From: "Marcos D. Marado Torres" <marado-oe7qfRrRQfcmha6Ds7sm0l6hYfS7NtTn@public.gmane.org>
> 
> From: "Barry K. Nathan" <barryn-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
> 
> On Tue, Feb 08, 2005 at 08:54:06PM -0800, Andrew Morton wrote:
> > "Marcos D. Marado Torres" <marado-oe7qfRrRQfcmha6Ds7sm0l6hYfS7NtTn@public.gmane.org> wrote:
> > >
> > > Please add to -mm the patch in attachment, since it solves the old
> > >  acpi_power_off bug...
> >
> > What acpi_power_off bug?  And how does it solve it?
> 
> Here's the observed bug that the patch is trying to fix:
> http://bugme.osdl.org/show_bug.cgi?id=4041
> 
> What Marcos posted is a typo-corrected version of Eric Biederman's
> patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110665542929525&w=2
> 
> In Eric's own words, the patch "needs some work before it goes into a
> mainline kernel". AFAICT it's more of a proof-of-concept, just to see
> if
> Eric's on the right track...
> 
> This is the motivation behind the patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110665405402747&w=2
> 
> 
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-akpm/drivers/acpi/sleep/poweroff.c |   23 +++++++++++++++++++++--
>  25-akpm/drivers/base/power/shutdown.c |    7 +++++++
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/sleep/poweroff.c~acpi_power_off-bug-fix
> drivers/acpi/sleep/poweroff.c
> --- 25/drivers/acpi/sleep/poweroff.c~acpi_power_off-bug-fix    
> 2005-02-23 01:48:08.000000000 -0800
> +++ 25-akpm/drivers/acpi/sleep/poweroff.c       2005-02-23
> 01:48:08.000000000 -0800
> @@ -7,18 +7,37 @@
> 
>  #include <linux/pm.h>
>  #include <linux/init.h>
> +#include <linux/kernel.h>
>  #include <acpi/acpi_bus.h>
>  #include <linux/sched.h>
>  #include "sleep.h"
> 
>  static void
> +acpi_power_off_prepare(void)
> +{
> +       if (system_state == SYSTEM_POWER_OFF) {
> +               acpi_wakeup_gpe_poweroff_prepare();
> +               acpi_enter_sleep_state_prep(ACPI_STATE_S5);
> +       }
> +}
> +
> +void
> +do_acpi_power_off_prepare(void)
> +{
> +       if (!acpi_disabled) {
> +               acpi_power_off_prepare();
> +       }
> +}
> +
> +
> +static void
>  acpi_power_off (void)
>  {
>         printk("%s called\n",__FUNCTION__);
> +#if 0  /* This should be made redundant by other patches.. */
>         /* Some SMP machines only can poweroff in boot CPU */
>         set_cpus_allowed(current, cpumask_of_cpu(0));
> -       acpi_wakeup_gpe_poweroff_prepare();
> -       acpi_enter_sleep_state_prep(ACPI_STATE_S5);
> +#endif
>         ACPI_DISABLE_IRQS();
>         acpi_enter_sleep_state(ACPI_STATE_S5);
>  }
> diff -puN drivers/base/power/shutdown.c~acpi_power_off-bug-fix
> drivers/base/power/shutdown.c
> --- 25/drivers/base/power/shutdown.c~acpi_power_off-bug-fix    
> 2005-02-23 01:48:08.000000000 -0800
> +++ 25-akpm/drivers/base/power/shutdown.c       2005-02-23
> 01:48:08.000000000 -0800
> @@ -62,6 +62,13 @@ void device_shutdown(void)
>         }
>         up_write(&devices_subsys.rwsem);
> 
> +#ifdef CONFIG_ACPI
> +       {
> +               extern void do_acpi_power_off_prepare(void);
> +               do_acpi_power_off_prepare();
> +       }
> +#endif
> +
>         sysdev_shutdown();
>  }
> 
> _
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
