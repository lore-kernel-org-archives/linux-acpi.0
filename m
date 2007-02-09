From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 02/13] ACPI, i686, x86_64: fix laptop bootup hang in init_acpi()
Date: Fri, 9 Feb 2007 01:14:31 -0500
Message-ID: <200702090114.32041.lenb@kernel.org>
References: <200702060010.l160AB6R003718@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52612 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946131AbXBIGQI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 01:16:08 -0500
In-Reply-To: <200702060010.l160AB6R003718@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, mingo@elte.hu, ak@suse.de

resuming our previous discussion on this topic...

I'd rather see nmi watchdog disabled by default.

But if that battle isn't going to be concluded in my natural
life-time, then I'm okay with a workaround for that bug
in the interest of functioning systems.

> +	acpi_nmi_disable();
>  	status = acpi_ns_evaluate(info);
> +	acpi_nmi_enable();

My concern is that while this may make a T60 work, we have
no assurance if it is sufficient for other systems which might
suffer a similar fate.

Maybe we should consider shutting off nmi_watchdog whenever we
interpret AML, eg hook into acpi_ex_enter_interpreter/acpi_ex_exit_interpreter(),
or maybe we should shut off nmi_watchdog whenever we
touch hardware registers, eg. hook entry and exit
from acpi_gbl_hardware_lock.  Or maybe we should simply
disable nmi_watchdog by default and use it only for debugging.

Oh, I already said that.

-Len

On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> During kernel bootup, a new T60 laptop (CoreDuo, 32-bit) hangs about
> 10%-20% of the time in acpi_init():
> 
>  Calling initcall 0xc055ce1a: topology_init+0x0/0x2f()
>  Calling initcall 0xc055d75e: mtrr_init_finialize+0x0/0x2c()
>  Calling initcall 0xc05664f3: param_sysfs_init+0x0/0x175()
>  Calling initcall 0xc014cb65: pm_sysrq_init+0x0/0x17()
>  Calling initcall 0xc0569f99: init_bio+0x0/0xf4()
>  Calling initcall 0xc056b865: genhd_device_init+0x0/0x50()
>  Calling initcall 0xc056c4bd: fbmem_init+0x0/0x87()
>  Calling initcall 0xc056dd74: acpi_init+0x0/0x1ee()
> 
> It's a hard hang that not even an NMI could punch through!  Frustratingly,
> adding printks or function tracing to the ACPI code made the hangs go away
> ...
> 
> After some time an additional detail emerged: disabling the NMI watchdog
> made these occasional hangs go away.
> 
> So i spent the better part of today trying to debug this and trying out
> various theories when i finally found the likely reason for the hang: if
> acpi_ns_initialize_devices() executes an _INI AML method and an NMI
> happens to hit that AML execution in the wrong moment, the machine would
> hang.  (my theory is that this must be some sort of chipset setup method
> doing stores to chipset mmio registers?)
> 
> Unfortunately given the characteristics of the hang it was sheer
> impossible to figure out which of the numerous AML methods is impacted
> by this problem.
> 
> As a workaround i wrote an interface to disable chipset-based NMIs while
> executing _INI sections - and indeed this fixed the hang.  I did a
> boot-loop of 100 separate reboots and none hung - while without the patch
> it would hang every 5-10 attempts.  Out of caution i did not touch the
> nmi_watchdog=2 case (it's not related to the chipset anyway and didnt
> hang).
> 
> I implemented this for both x86_64 and i686, tested the i686 laptop both
> with nmi_watchdog=1 [which triggered the hangs] and nmi_watchdog=2, and
> tested an Athlon64 box with the 64-bit kernel as well. Everything builds
> and works with the patch applied.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Cc: Andi Kleen <ak@suse.de>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/i386/kernel/nmi.c          |   28 ++++++++++++++++++++++++++++
>  arch/x86_64/kernel/nmi.c        |   27 +++++++++++++++++++++++++++
>  drivers/acpi/namespace/nsinit.c |    9 +++++++++
>  include/linux/nmi.h             |    9 ++++++++-
>  4 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff -puN arch/i386/kernel/nmi.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi arch/i386/kernel/nmi.c
> --- a/arch/i386/kernel/nmi.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi
> +++ a/arch/i386/kernel/nmi.c
> @@ -369,6 +369,34 @@ void enable_timer_nmi_watchdog(void)
>  	}
>  }
>  
> +static void __acpi_nmi_disable(void *__unused)
> +{
> +	apic_write_around(APIC_LVT0, APIC_DM_NMI | APIC_LVT_MASKED);
> +}
> +
> +/*
> + * Disable timer based NMIs on all CPUs:
> + */
> +void acpi_nmi_disable(void)
> +{
> +	if (atomic_read(&nmi_active) && nmi_watchdog == NMI_IO_APIC)
> +		on_each_cpu(__acpi_nmi_disable, NULL, 0, 1);
> +}
> +
> +static void __acpi_nmi_enable(void *__unused)
> +{
> +	apic_write_around(APIC_LVT0, APIC_DM_NMI);
> +}
> +
> +/*
> + * Enable timer based NMIs on all CPUs:
> + */
> +void acpi_nmi_enable(void)
> +{
> +	if (atomic_read(&nmi_active) && nmi_watchdog == NMI_IO_APIC)
> +		on_each_cpu(__acpi_nmi_enable, NULL, 0, 1);
> +}
> +
>  #ifdef CONFIG_PM
>  
>  static int nmi_pm_active; /* nmi_active before suspend */
> diff -puN arch/x86_64/kernel/nmi.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi arch/x86_64/kernel/nmi.c
> --- a/arch/x86_64/kernel/nmi.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi
> +++ a/arch/x86_64/kernel/nmi.c
> @@ -360,6 +360,33 @@ void enable_timer_nmi_watchdog(void)
>  	}
>  }
>  
> +static void __acpi_nmi_disable(void *__unused)
> +{
> +	apic_write(APIC_LVT0, APIC_DM_NMI | APIC_LVT_MASKED);
> +}
> +
> +/*
> + * Disable timer based NMIs on all CPUs:
> + */
> +void acpi_nmi_disable(void)
> +{
> +	if (atomic_read(&nmi_active) && nmi_watchdog == NMI_IO_APIC)
> +		on_each_cpu(__acpi_nmi_disable, NULL, 0, 1);
> +}
> +
> +static void __acpi_nmi_enable(void *__unused)
> +{
> +	apic_write(APIC_LVT0, APIC_DM_NMI);
> +}
> +
> +/*
> + * Enable timer based NMIs on all CPUs:
> + */
> +void acpi_nmi_enable(void)
> +{
> +	if (atomic_read(&nmi_active) && nmi_watchdog == NMI_IO_APIC)
> +		on_each_cpu(__acpi_nmi_enable, NULL, 0, 1);
> +}
>  #ifdef CONFIG_PM
>  
>  static int nmi_pm_active; /* nmi_active before suspend */
> diff -puN drivers/acpi/namespace/nsinit.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi drivers/acpi/namespace/nsinit.c
> --- a/drivers/acpi/namespace/nsinit.c~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi
> +++ a/drivers/acpi/namespace/nsinit.c
> @@ -45,6 +45,7 @@
>  #include <acpi/acnamesp.h>
>  #include <acpi/acdispat.h>
>  #include <acpi/acinterp.h>
> +#include <linux/nmi.h>
>  
>  #define _COMPONENT          ACPI_NAMESPACE
>  ACPI_MODULE_NAME("nsinit")
> @@ -534,7 +535,15 @@ acpi_ns_init_one_device(acpi_handle obj_
>  	info->parameter_type = ACPI_PARAM_ARGS;
>  	info->flags = ACPI_IGNORE_RETURN_VALUE;
>  
> +	/*
> +	 * Some hardware relies on this being executed as atomically
> +	 * as possible (without an NMI being received in the middle of
> +	 * this) - so disable NMIs and initialize the device:
> +	 */
> +	acpi_nmi_disable();
>  	status = acpi_ns_evaluate(info);
> +	acpi_nmi_enable();
> +
>  	if (ACPI_SUCCESS(status)) {
>  		walk_info->num_INI++;
>  
> diff -puN include/linux/nmi.h~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi include/linux/nmi.h
> --- a/include/linux/nmi.h~acpi-i686-x86_64-fix-laptop-bootup-hang-in-init_acpi
> +++ a/include/linux/nmi.h
> @@ -17,8 +17,15 @@
>  #ifdef ARCH_HAS_NMI_WATCHDOG
>  #include <asm/nmi.h>
>  extern void touch_nmi_watchdog(void);
> +extern void acpi_nmi_disable(void);
> +extern void acpi_nmi_enable(void);
>  #else
> -# define touch_nmi_watchdog() touch_softlockup_watchdog()
> +static inline void touch_nmi_watchdog(void)
> +{
> +	touch_softlockup_watchdog();
> +}
> +static inline void acpi_nmi_disable(void) { }
> +static inline void acpi_nmi_enable(void) { }
>  #endif
>  
>  #ifndef trigger_all_cpu_backtrace
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
