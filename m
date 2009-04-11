From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Re: [patch for 2.6.30 2/2]
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c: avoid cross-CPU interrupts
Date: Sat, 11 Apr 2009 12:07:11 +0530
Message-ID: <1239431831.4418.22.camel@localhost.localdomain>
References: <200904110617.n3B6HJ7W026502@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755669AbZDKGi5@vger.kernel.org>
In-Reply-To: <200904110617.n3B6HJ7W026502@imap1.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com, efault@gmx.de, len.brown@intel.com, mingo@elte.hu, rusty@rustcorp.com.au, tglx@linutronix.de, venkatesh.pallipadi@intel.com, yakui.zhao@intel.com, yanmin_zhang@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On Fri, 2009-04-10 at 23:17 -0700, akpm@linux-foundation.org wrote:
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

+ 	int target_cpu; 	/* The CPU on which to perform the rdmsr() */

--
JSR
