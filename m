From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC 4/6]Add kconfig for S3 SMP
Date: Mon, 4 Apr 2005 10:59:32 +0200
Message-ID: <20050404085932.GE14642@elf.ucw.cz>
References: <1112580364.4194.342.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1112580364.4194.342.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Add kconfig for IA32 S3 SMP.
> 
> Thanks,
> Shaohua
> 
> ---
> 
>  linux-2.6.11-root/kernel/power/Kconfig |    7 +++++++
>  1 files changed, 7 insertions(+)
> 
> diff -puN kernel/power/Kconfig~smp_s3_kconfig kernel/power/Kconfig
> --- linux-2.6.11/kernel/power/Kconfig~smp_s3_kconfig	2005-03-31 10:49:57.156487160 +0800
> +++ linux-2.6.11-root/kernel/power/Kconfig	2005-03-31 10:49:57.158486856 +0800
> @@ -72,3 +72,10 @@ config PM_STD_PARTITION
>  	  suspended image to. It will simply pick the first available swap 
>  	  device.
>  
> +config STR_SMP
> +	bool "Suspend to RAM SMP support (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL && ACPI_SLEEP && !X86_64
> +	depends on HOTPLUG_CPU
> +	default y
> +	---help---
> +	 enable Suspend to RAM SMP support. Some HT systems require this.

Should this be config option? If we have ACPI_SLEEP and SMP set, we
should probably require this one (so that user does not have to
care).... Also name is "interesting", perhaps CONFIG_SMP_SLEEP or
something?

							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
