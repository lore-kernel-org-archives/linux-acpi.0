From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH] acpi-20030916-2.6.0-pre5.diff
Date: 18 Sep 2003 23:41:38 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1063942898.2676.391.camel@linux.local>
References: <20030823150219.21c951aa.akpm@osdl.org>
	 <1063926206.2680.200.camel@linux.local>
	 <20030918155715.61a41697.akpm@osdl.org>
	 <20030919011149.GB20844@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030919011149.GB20844-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andi,
Good hunting!

This fix has been integrated with others in the ACPI patch,
and is available now in these bitkeeper trees:

http://linux-acpi.bkbits.net/linux-acpi-test-2.4.22
http://linux-acpi.bkbits.net/linux-acpi-test-2.4.23
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.0

thanks,
-Len

On Thu, 2003-09-18 at 21:11, Andi Kleen wrote:
> On Thu, Sep 18, 2003 at 03:57:15PM -0700, Andrew Morton wrote:
> > Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > >
> > > This patch updates 2.6.0-test5 to the current ACPI in 2.4.22-pre5
> > > If nothing explodes, I'll be releasing it to Linus shortly via BK.
> > 
> > And it doesn't include this fix.
> 
> This fix is also missing.
> 
> -Andi
> 
> 
> -----------------------------------------------------------------
> 
> ACPI modules check acpi_disabled at module load time. This 
> fixes random failures to load battery.o et.al.
> 
> 
> diff -u linux-2.6.0test5-work/arch/i386/kernel/setup.c-ACPIINIT linux-2.6.0test5-work/arch/i386/kernel/setup.c
> --- linux-2.6.0test5-work/arch/i386/kernel/setup.c-ACPIINIT	2003-09-09 20:55:26.000000000 +0200
> +++ linux-2.6.0test5-work/arch/i386/kernel/setup.c	2003-09-15 18:12:23.000000000 +0200
> @@ -64,9 +64,9 @@
>  EXPORT_SYMBOL_GPL(mmu_cr4_features);
>  
>  #ifdef	CONFIG_ACPI
> -	int acpi_disabled __initdata = 0;
> +	int acpi_disabled = 0;
>  #else
> -	int acpi_disabled __initdata = 1;
> +	int acpi_disabled = 1;
>  #endif
>  EXPORT_SYMBOL(acpi_disabled);
>  
> diff -u linux-2.6.0test5-work/arch/ia64/kernel/acpi.c-ACPIINIT linux-2.6.0test5-work/arch/ia64/kernel/acpi.c
> --- linux-2.6.0test5-work/arch/ia64/kernel/acpi.c-ACPIINIT	2003-09-19 03:10:10.000000000 +0200
> +++ linux-2.6.0test5-work/arch/ia64/kernel/acpi.c	2003-09-19 03:10:19.000000000 +0200
> @@ -56,7 +56,7 @@
>  
>  unsigned char acpi_kbd_controller_present = 1;
>  
> -int acpi_disabled __initdata;	/* XXX this shouldn't be needed---we can't boot without ACPI! */
> +int acpi_disabled;	/* XXX this shouldn't be needed---we can't boot without ACPI! */
>  
>  const char *
>  acpi_get_sysname (void)
> diff -u linux-2.6.0test5-work/arch/x86_64/kernel/setup.c-ACPIINIT linux-2.6.0test5-work/arch/x86_64/kernel/setup.c
> --- linux-2.6.0test5-work/arch/x86_64/kernel/setup.c-ACPIINIT	2003-09-19 03:09:33.000000000 +0200
> +++ linux-2.6.0test5-work/arch/x86_64/kernel/setup.c	2003-09-15 18:16:36.000000000 +0200
> @@ -64,7 +64,7 @@
>  unsigned long mmu_cr4_features;
>  EXPORT_SYMBOL_GPL(mmu_cr4_features);
>  
> -int acpi_disabled __initdata = 0;
> +int acpi_disabled = 0;
>  
>  /* For PCI or other memory-mapped resources */
>  unsigned long pci_mem_start = 0x10000000;



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
