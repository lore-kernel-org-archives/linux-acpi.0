From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] ACPI: cpuidle: port idle timer suspend/resume workaround
 to cpuidle
Date: Tue, 9 Oct 2007 00:17:12 +0200 (CEST)
Message-ID: <alpine.LFD.0.9999.0710090012130.25146@localhost.localdomain>
References: <200710040122.43759.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42237 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbXJHWqn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Oct 2007 18:46:43 -0400
In-Reply-To: <200710040122.43759.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI List <linux-acpi@vger.kernel.org>

Len,

sorry for answering late. Your mail got into the wrong folder after I had 
to restructure my procmail crap due to a dead server disk. :(

On Thu, 4 Oct 2007, Len Brown wrote:

> From: Len Brown <len.brown@intel.com>
> 
> Some timers stop during C2 and C3, and so there are various
> generations of timer broadcast workarounds to deal with that.
> But that (already complex) code gets confused during suspend.
> 
> As it is unlikely that deep C-states would save much power
> during the actual suspend/resume process anyway, deep C-states
> were disabled via the addition of .suspend/.resume hooks
> in to the ACPI processor driver.
> 
> Here that workaround is ported to the cpuidle version of
> the ACPI idle loop.  Technically, ACPI could un-register
> itself from cpuidle on .suspend, but that code path
> is currently quite cumbersome.  So instead,
> we simply invoke C1 from the C2 and C3 handlers
> for the duration of .suspend/.resume.

That's basically what I did in my -hrt patch set. I just wonder whether 
this decision should be moved into the cpuidle code.

> Signed-off-by: Len Brown <len.brown@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  processor_idle.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index d924aa3..3b62632 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1373,6 +1373,10 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
>  	if (unlikely(!pr))
>  		return 0;
>  
> + 	if (acpi_idle_suspend)
> + 		return(acpi_idle_enter_c1(dev, state));
> + 
> +
>  	local_irq_disable();
>  	current_thread_info()->status &= ~TS_POLLING;
>  	/*
> @@ -1431,6 +1435,9 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
>  	if (unlikely(!pr))
>  		return 0;
>  
> +	if (acpi_idle_suspend)
> +		return(acpi_idle_enter_c1(dev, state));
> +
>  	local_irq_disable();
>  	current_thread_info()->status &= ~TS_POLLING;
>  	/*
> 
