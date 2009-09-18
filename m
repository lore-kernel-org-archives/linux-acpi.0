From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/8] arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c: avoid
 cross-CPU interrupts by using smp_call_function_any()
Date: Fri, 18 Sep 2009 13:11:31 -0700
Message-ID: <20090918131131.786e2fcc.akpm@linux-foundation.org>
References: <200909181941.n8IJf5oR002397@imap1.linux-foundation.org>
	<20090918195953.GB7413@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53719 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758582AbZIRUNB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Sep 2009 16:13:01 -0400
In-Reply-To: <20090918195953.GB7413@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, efault@gmx.de, jaswinder@kernel.org, len.brown@intel.com, mingo@elte.hu, rusty@rustcorp.com.au, tglx@linutronix.de, venkatesh.pallipadi@intel.com, yakui.zhao@intel.com, yanmin_zhang@linux.intel.com

On Fri, 18 Sep 2009 15:59:53 -0400
Dave Jones <davej@redhat.com> wrote:

> On Fri, Sep 18, 2009 at 12:41:05PM -0700, Andrew Morton wrote:
> 
>  > diff -puN arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c~arch-x86-kernel-cpu-cpufreq-acpi-cpufreqc-avoid-cross-cpu-interrupts-by-using-smp_call_function_any arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
>  > --- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c~arch-x86-kernel-cpu-cpufreq-acpi-cpufreqc-avoid-cross-cpu-interrupts-by-using-smp_call_function_any
>  > +++ a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
>  > @@ -192,9 +192,11 @@ static void do_drv_write(void *_cmd)
>  >  
>  >  static void drv_read(struct drv_cmd *cmd)
>  >  {
>  > +	int err;
>  >  	cmd->val = 0;
>  >  
>  > -	smp_call_function_single(cpumask_any(cmd->mask), do_drv_read, cmd, 1);
>  > +	err = smp_call_function_any(cmd->mask, do_drv_read, cmd, 1);
>  > +	WARN_ON_ONCE(err);	/* smp_call_function_any() was buggy? */
>  >  }
>  >  
>  >  static void drv_write(struct drv_cmd *cmd)
> 
> I'm ok with this going in, but I still wonder if we could have done it
> all a lot easier, by making cpumask_any pick the current cpu if it was
> in the mask instead of introducing yet another variant to an already
> enormous api.
> 

Yeah, I wondered about that.  But iirc Rusty had a good-sounding reason
for adding a new function but that reason didn't get into the changelog so
it's lost.

