From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] processor: jiffies-based bm_check, bugfixes
Date: 23 Dec 2004 15:11:24 -0500
Message-ID: <1103832683.4376.24.camel@d845pe>
References: <20041223140849.GE7973@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041223140849.GE7973-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied the promotion/demotion bugfix part.

Didn't apply the jiffies part yet.

thanks,
-Len



On Thu, 2004-12-23 at 09:08, Dominik Brodowski wrote:
> Make the bm_activity depend on "jiffies", instead of numbers
> of the check being called. This means bus mastering activity
> is assumed if bm_check isn't called; and multiple calls during
> one jiffy will be |='ed.
> 
> Also, two fixups where promotion and demotion were mixed up.
> 
> Signed-off-by: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
> ---
> 
>  drivers/acpi/processor_idle.c |   19 ++++++++++++++++---
>  include/acpi/processor.h      |    1 +
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-2.6.10-rc3+bk-acpi.orig/drivers/acpi/processor_idle.c
> 2004-12-23 14:25:32.385908579 +0100
> +++ linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c     
> 2004-12-23 14:39:58.360081349 +0100
> @@ -193,8 +193,18 @@
>          */
>         if (pr->flags.bm_check) {
>                 u32             bm_status = 0;
> +               unsigned long   diff = jiffies -
> pr->power.bm_check_timestamp;
> 
> -               pr->power.bm_activity <<= 1;
> +               if (diff > 32)
> +                       diff = 32;
> +
> +               while (diff) {
> +                       /* if we didn't get called, assume there was
> busmaster activity */
> +                       diff--;
> +                       if (diff)
> +                               pr->power.bm_activity |= 0x1;
> +                       pr->power.bm_activity <<= 1;
> +               }
> 
>                 acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
>                         &bm_status, ACPI_MTX_DO_NOT_LOCK);
> @@ -213,6 +223,9 @@
>                                 || (inb_p(errata.piix4.bmisx + 0x0A) &
> 0x01))
>                                 pr->power.bm_activity++;
>                 }
> +
> +               pr->power.bm_check_timestamp = jiffies;
> +
>                 /*
>                  * Apply bus mastering demotion policy.  Automatically
> demote
>                  * to avoid a faulty transition.  Note that the
> processor
> @@ -439,13 +452,13 @@
> 
>                 if (higher) {
>                         cx->promotion.state  = higher;
> -                       cx->demotion.threshold.ticks =
> cx->latency_ticks;
> +                       cx->promotion.threshold.ticks =
> cx->latency_ticks;
>                         if (cx->type >= ACPI_STATE_C2)
>                                 cx->promotion.threshold.count = 4;
>                         else
>                                 cx->promotion.threshold.count = 10;
>                         if (higher->type == ACPI_STATE_C3)
> -                               cx->demotion.threshold.bm = 0x0F;
> +                               cx->promotion.threshold.bm = 0x0F;
>                 }
> 
>                 higher = cx;
> Index: linux-2.6.10-rc3+bk-acpi/include/acpi/processor.h
> ===================================================================
> --- linux-2.6.10-rc3+bk-acpi.orig/include/acpi/processor.h     
> 2004-12-23 13:21:12.000000000 +0100
> +++ linux-2.6.10-rc3+bk-acpi/include/acpi/processor.h   2004-12-23
> 14:41:47.558845116 +0100
> @@ -54,6 +54,7 @@
> 
>  struct acpi_processor_power {
>         struct acpi_processor_cx *state;
> +       unsigned long           bm_check_timestamp;
>         u32                     default_state;
>         u32                     bm_activity;
>         int                     count;
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
