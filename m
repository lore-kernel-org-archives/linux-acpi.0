From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Handle disabled local apic better
Date: 24 Mar 2004 02:12:54 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080112373.18504.67.camel@dhcppc4>
References: <20040323213551.4789bbae.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040323213551.4789bbae.ak-l3A5Bk7waGM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-03-23 at 15:35, Andi Kleen wrote:
> When a kernel is compiled with local and io apic code, but the local APIC
> is disabled before ACPI starts ACPI gets confused.  The situation
> can occur in a mainline kernel too, e.g. when a dmi_scan entry disables
> the local apic early.
> 
> The problem is that the ACPI code will do all the setup assuming there
> is a IO-APIC because the IO-APIC is not disabled, but the machine really runs in 
> PIC mode. This usually leads to lost network (devices get an unreachable interrupt) 
> or IDE hangs or other problems.
> 
> This patch adds checks for local apic enabled to all paths that need it
> (basically everybody who has a #ifdef CONFIG_X86_LOCAL_APIC needs this
> check instead)

oof, and there are lots of CONFIG_X86_LOCAL_APIC uses apparently
un-guarded at run-time...

> 
> It just handles the case there the up apic is disabled before ACPI boot,
> it can actually be disabled later too (e.g. when the APIC initialisation
> fails). This is probably still broken.
> 
> Also removes an bogus error message - this path can trigger just with
> software disabled APIC.
> 
> -Andi
> 
> diff -u linux/arch/i386/kernel/acpi/boot.c-o linux/arch/i386/kernel/acpi/boot.c
> --- linux/arch/i386/kernel/acpi/boot.c-o	2004-03-23 17:32:22.000000000 +0100
> +++ linux/arch/i386/kernel/acpi/boot.c	2004-03-23 17:34:23.000000000 +0100
> @@ -685,6 +685,13 @@
>  #ifdef CONFIG_X86_LOCAL_APIC
>  	int count, error;
>  
> +	/* it's still wrong when the apic is disabled later */
> +	extern int enable_local_apic;
> +	if (enable_local_apic < 0) { 
> +		printk(KERN_INFO "ACPI: local apic disabled\n");
> +		return;
> +	}
> +
>  	count = acpi_table_parse(ACPI_APIC, acpi_parse_madt);
>  	if (count == 1) {

Looks like i386 lacks the parse_cmdline_early() check for "nolapic" to
make this test effective.

(why the heck is the parse_args() so late, anyway?)

Looks like x86_64 has it, but then does it again at __setup() time --
which should probably be removed; along with the redundant variable
"disable_apic".

>  
> diff -u linux/arch/i386/kernel/apic.c-o linux/arch/i386/kernel/apic.c
> --- linux/arch/i386/kernel/apic.c-o	2004-03-23 17:32:22.000000000 +0100
> +++ linux/arch/i386/kernel/apic.c	2004-03-23 18:01:21.000000000 +0100
> @@ -41,6 +41,8 @@
>  
>  #include "io_ports.h"
>  
> +extern int enable_local_apic;
> +

how about declare in asm/apic.h instead?

>  static void apic_pm_activate(void);
>  
>  void __init apic_intr_init(void)
> @@ -190,6 +192,9 @@
>  {
>  	unsigned long value;
>  
> +	if (enable_local_apic < 0) 
> +		return;
> +
>  	clear_local_APIC();
>  
>  	/*
> @@ -1172,8 +1193,6 @@
>  	 * Complain if the BIOS pretends there is one.
>  	 */
>  	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid])) {
> -		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
> -			boot_cpu_physical_apicid);
>  		return -1;
>  	}
>  
> diff -u linux/arch/i386/kernel/setup.c-o linux/arch/i386/kernel/setup.c
> --- linux/arch/i386/kernel/setup.c-o	2004-03-23 17:32:00.000000000 +0100
> +++ linux/arch/i386/kernel/setup.c	2004-03-23 18:01:14.000000000 +0100
> @@ -50,6 +50,10 @@
>  #include "setup_arch_pre.h"
>  #include "mach_resources.h"
>  
> +#ifdef CONFIG_X86_LOCAL_APIC
> +extern int enable_local_apic;
> +#endif
> +

asm/apic.h

>  /* This value is set up by the early boot code to point to the value
>     immediately after the boot time page tables.  It contains a *physical*
>     address, and must not be in the .bss segment! */
> @@ -917,6 +925,7 @@
>  	acpi_reserve_bootmem();
>  #endif
>  #ifdef CONFIG_X86_FIND_SMP_CONFIG
> +	if (enable_local_apic >= 0) 
>  	/*
>  	 * Find and reserve possible boot-time SMP configuration:
>  	 */

Here we're disabling MPS with "nolapic" -- something that "maxcpus=0"
and "nosmp" never effectively did before...

> @@ -1232,7 +1241,7 @@
>  	acpi_boot_init();
>  
>  #ifdef CONFIG_X86_LOCAL_APIC
> -	if (smp_found_config)
> +	if (smp_found_config && enable_local_apic >= 0)
>  		get_smp_config();

i guess this is for the case where DMI disables the lapic, because
"nolapic" would have prevented smp_found_config from getting set in the
first place.  maybe the DMI routine should simply clear
smp_found_config?

>  #endif
>  
> diff -u linux/arch/x86_64/kernel/apic.c-o linux/arch/x86_64/kernel/apic.c
> --- linux/arch/x86_64/kernel/apic.c-o	2004-03-23 17:32:01.000000000 +0100
> +++ linux/arch/x86_64/kernel/apic.c	2004-03-23 18:41:58.000000000 +0100
> @@ -970,6 +970,7 @@
>  }
>  
>  int disable_apic; 
> +int enable_local_apic = 1;
>  
asm/apic.h;-)

>  /*
>   * This initializes the IO-APIC and APIC hardware if this is
> @@ -1009,12 +1010,14 @@
>  
>  static __init int setup_disableapic(char *str) 
>  { 
> +	enable_local_apic = -1;
>  	disable_apic = 1;
>  	return 0;
>  } 
>  
>  static __init int setup_nolapic(char *str) 
>  { 
> +	enable_local_apic = -1;
>  	disable_apic = 1;
>  	return 0;
>  } 

these routines should be deleted, since they duplicate the earlier
parse_cmdline_early().  the ambiguous "disable_lapic" should go also,
since "enable_local_apic" is on the scene, yes?

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
