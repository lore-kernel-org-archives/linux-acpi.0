From: Len Brown <lenb@kernel.org>
Subject: Re: [patch for 2.6.30 2/2] arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c:
 avoid cross-CPU interrupts
Date: Sun, 19 Apr 2009 22:57:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904192252550.10996@localhost.localdomain>
References: <200904110617.n3B6HJ7W026502@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:61012 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZDTC5e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Apr 2009 22:57:34 -0400
In-reply-to: <200904110617.n3B6HJ7W026502@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com, efault@gmx.de, len.brown@intel.com, mingo@elte.hu, rusty@rustcorp.com.au, tglx@linutronix.de, venkatesh.pallipadi@intel.com, yakui.zhao@intel.com, yanmin_zhang@linux.intel.com



> From: Andrew Morton <akpm@linux-foundation.org>
> 
> In drv_read(), check to see whether we can run the rdmsr() on the current
> CPU.  If so, do that.  So smp_call_function_single() can avoid the IPI.
> 
> Arguably, cpumask_any() should do this.
> 
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Zhao Yakui <yakui.zhao@intel.com>
> Cc: Dave Jones <davej@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Mike Galbraith <efault@gmx.de>
> Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> ---
> 
>  arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff -puN arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c~arch-x86-kernel-cpu-cpufreq-acpi-cpufreqc-avoid-cross-cpu-interrupts arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> --- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c~arch-x86-kernel-cpu-cpufreq-acpi-cpufreqc-avoid-cross-cpu-interrupts
> +++ a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> @@ -197,9 +197,22 @@ static void do_drv_write(void *_cmd)
>  
>  static void drv_read(struct drv_cmd *cmd)
>  {
> -	cmd->val = 0;
> +	int target_cpu;		/* The CPU on which to perform thr rdmsr() */
> +	int this_cpu;
> +
> +	/*
> +	 * If the current CPU is in cmd->mask then run the rdmsr() on this
> +	 * CPU to avoid the cross-cpu interrupt.
> +	 */
> +	this_cpu = get_cpu();
> +	if (cpu_isset(this_cpu, *(cmd->mask)))
> +		target_cpu = this_cpu;
> +	else
> +		target_cpu = cpumask_any(cmd->mask);
>  
> -	smp_call_function_single(cpumask_any(cmd->mask), do_drv_read, cmd, 1);
> +	cmd->val = 0;
> +	smp_call_function_single(target_cpu, do_drv_read, cmd, 1);
> +	put_cpu();
>  }
>  
>  static void drv_write(struct drv_cmd *cmd)
> _

Rather than this patch I would expect we would want to either:

A. as we went to the trouble to detect the local case
   in drv_read, why call smp_call_function at all for that case?

or

B. optimize smp_call_function_single to beneift all users
   instead of just this customer.

thanks,
-Len Brown, Intel Open Source Technology Center

