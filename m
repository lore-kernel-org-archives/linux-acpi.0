From: Dave Jones <davej@redhat.com>
Subject: Re: [patch 2/8] arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c: avoid
	cross-CPU interrupts by using smp_call_function_any()
Date: Fri, 18 Sep 2009 15:59:53 -0400
Message-ID: <20090918195953.GB7413@redhat.com>
References: <200909181941.n8IJf5oR002397@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5853 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757258AbZIRUDd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Sep 2009 16:03:33 -0400
Content-Disposition: inline
In-Reply-To: <200909181941.n8IJf5oR002397@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, efault@gmx.de, jaswinder@kernel.org, len.brown@intel.com, mingo@elte.hu, rusty@rustcorp.com.au, tglx@linutronix.de, venkatesh.pallipadi@intel.com, yakui.zhao@intel.com, yanmin_zhang@linux.intel.com

On Fri, Sep 18, 2009 at 12:41:05PM -0700, Andrew Morton wrote:

 > diff -puN arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c~arch-x86-kernel-cpu-cpufreq-acpi-cpufreqc-avoid-cross-cpu-interrupts-by-using-smp_call_function_any arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
 > --- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c~arch-x86-kernel-cpu-cpufreq-acpi-cpufreqc-avoid-cross-cpu-interrupts-by-using-smp_call_function_any
 > +++ a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
 > @@ -192,9 +192,11 @@ static void do_drv_write(void *_cmd)
 >  
 >  static void drv_read(struct drv_cmd *cmd)
 >  {
 > +	int err;
 >  	cmd->val = 0;
 >  
 > -	smp_call_function_single(cpumask_any(cmd->mask), do_drv_read, cmd, 1);
 > +	err = smp_call_function_any(cmd->mask, do_drv_read, cmd, 1);
 > +	WARN_ON_ONCE(err);	/* smp_call_function_any() was buggy? */
 >  }
 >  
 >  static void drv_write(struct drv_cmd *cmd)

I'm ok with this going in, but I still wonder if we could have done it
all a lot easier, by making cpumask_any pick the current cpu if it was
in the mask instead of introducing yet another variant to an already
enormous api.

	Dave

