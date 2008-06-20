From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH3/4] ACPI :  Add boot option of "idle=nomwait" to disable
 mwait for CPU C-states
Date: Fri, 20 Jun 2008 02:35:39 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806200235260.22284@localhost.localdomain>
References: <1213685035.19901.15.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:60463 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYFTGf5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 02:35:57 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R00DZI0ZGS8B1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 01:35:41 -0500 (CDT)
In-reply-to: <1213685035.19901.15.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org


applied. (found it:-)
thanks,
-Len

On Tue, 17 Jun 2008, Zhao Yakui wrote:

> Subject:[ACPI]:Add boot option of "idle=nomwait" to disable mwait for CPU C-states
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> Add the boot option of "idle=nomwait" to disable Mwait for CPU C-states.
> If the boot option of "idle=nomwait" is added , OSPM should not 
> use mwait for cpu idle even when the mwait is supported. In such case the 
> C2C3_FFH access mode will be disabled.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=10807
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> ---
>  Documentation/kernel-parameters.txt |    4 +++-
>  arch/ia64/kernel/process.c          |    2 ++
>  arch/x86/kernel/process.c           |   14 ++++++++++++++
>  drivers/acpi/processor_core.c       |   12 ++++++++++++
>  include/asm-ia64/processor.h        |    1 +
>  include/asm-x86/processor.h         |    1 +
>  6 files changed, 33 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/Documentation/kernel-parameters.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/kernel-parameters.txt
> +++ linux-2.6/Documentation/kernel-parameters.txt
> @@ -785,7 +785,7 @@ and is between 256 and 4096 characters. 
>  			See Documentation/ide/ide.txt.
>  
>  	idle=		[X86]
> -			Format: idle=poll or idle=mwait, idle = halt
> +			Format: idle=poll or idle=mwait, idle = halt, idle=nomwait
>  			Poll forces a polling idle loop that can slightly improves the performance
>  			of waking up a idle CPU, but will use a lot of power and make the system
>  			run hot. Not recommended.
> @@ -795,6 +795,8 @@ and is between 256 and 4096 characters. 
>  			as idle=poll.
>  			idle = halt . Halt is forced to be used for CPU idle.
>  			In such case C2/C3 won't be used again.
> +			idle = nomwait. disable Mwait for CPU C-state.
> +			In such case C2C3_FFH access mode will be disabled.
>  
>  	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
>  			Claim all unknown PCI IDE storage controllers.
> Index: linux-2.6/arch/ia64/kernel/process.c
> ===================================================================
> --- linux-2.6.orig/arch/ia64/kernel/process.c
> +++ linux-2.6/arch/ia64/kernel/process.c
> @@ -55,6 +55,8 @@ void (*ia64_mark_idle)(int);
>  
>  unsigned long boot_option_idle_override = 0;
>  EXPORT_SYMBOL(boot_option_idle_override);
> +unsigned long idle_nomwait;
> +EXPORT_SYMBOL(idle_nomwait);
>  
>  void
>  ia64_do_show_stack (struct unw_frame_info *info, void *arg)
> Index: linux-2.6/arch/x86/kernel/process.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/process.c
> +++ linux-2.6/arch/x86/kernel/process.c
> @@ -7,6 +7,10 @@
>  #include <linux/module.h>
>  #include <linux/pm.h>
>  #include <asm/system.h>
> +#include <asm/processor.h>
> +
> +unsigned long idle_nomwait;
> +EXPORT_SYMBOL(idle_nomwait);
>  
>  struct kmem_cache *task_xstate_cachep;
>  
> @@ -172,6 +176,16 @@ static int __init idle_setup(char *str)
>  		force_mwait = 1;
>  	else if (!strcmp(str, "halt"))
>  		pm_idle = default_idle;
> +	else if (!strcmp(str, "nomwait")) {
> +		/*
> +		 * If the boot option of "idle=nomwait" is added,
> +		 * it means that mwait will be disabled for CPU C2/C3
> +		 * states. In such case it won't touch the variable
> +		 * of boot_option_idle_override.
> +		 */
> +		idle_nomwait = 1;
> +		return 0;
> +	}
>  	else
>  		return -1;
>  
> Index: linux-2.6/include/asm-ia64/processor.h
> ===================================================================
> --- linux-2.6.orig/include/asm-ia64/processor.h
> +++ linux-2.6/include/asm-ia64/processor.h
> @@ -763,6 +763,7 @@ prefetchw (const void *x)
>  #define spin_lock_prefetch(x)	prefetchw(x)
>  
>  extern unsigned long boot_option_idle_override;
> +extern unsigned long idle_nomwait;
>  
>  #endif /* !__ASSEMBLY__ */
>  
> Index: linux-2.6/include/asm-x86/processor.h
> ===================================================================
> --- linux-2.6.orig/include/asm-x86/processor.h
> +++ linux-2.6/include/asm-x86/processor.h
> @@ -732,6 +732,7 @@ extern int			force_mwait;
>  extern void select_idle_routine(const struct cpuinfo_x86 *c);
>  
>  extern unsigned long		boot_option_idle_override;
> +extern unsigned long		idle_nomwait;
>  
>  extern void enable_sep_cpu(void);
>  extern int sysenter_setup(void);
> Index: linux-2.6/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/processor_core.c
> +++ linux-2.6/drivers/acpi/processor_core.c
> @@ -267,6 +267,18 @@ static int acpi_processor_set_pdc(struct
>  	if (!pdc_in)
>  		return status;
>  
> +	if (idle_nomwait) {
> +		/*
> +		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
> +		 * mode will be disabled in the parameter of _PDC object.
> +		 */
> +		union acpi_object *obj;
> +		u32 *buffer = NULL;
> +
> +		obj = pdc_in->pointer;
> +		buffer = (u32 *)(obj->buffer.pointer);
> +		buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH);
> +	}
>  	status = acpi_evaluate_object(pr->handle, "_PDC", pdc_in, NULL);
>  
>  	if (ACPI_FAILURE(status))
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
