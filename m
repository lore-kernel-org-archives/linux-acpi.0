From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2]cpuidle: makes AMD C1E works in suspend/resume path
Date: Tue, 19 May 2009 15:07:08 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0905191456050.5983@localhost.localdomain>
References: <20090519080954.GB12117@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:50863 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776AbZESNI3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 May 2009 09:08:29 -0400
In-Reply-To: <20090519080954.GB12117@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com, thisistempbox@yahoo.com, lenb@kernel.org

On Tue, 19 May 2009, Shaohua Li wrote:

> When AMD C1E is enabled, local APIC timer will stop even in C1. To avoid
> suspend/resume hang, this patch removes C1 and replace it with a cpu_relax() in
> suspend/resume path. This hasn't any impact in runtime path.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=13233
> 
> [ impact: avoid suspend/resume hang in AMD CPU with C1E enabled ]
> 
> Tested-by: Dmitry Lyzhyn <thisistempbox@yahoo.com>
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/acpi/processor_idle.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux.orig/drivers/acpi/processor_idle.c	2009-05-19 09:56:59.000000000 +0800
> +++ linux/drivers/acpi/processor_idle.c	2009-05-19 10:01:23.000000000 +0800
> @@ -834,8 +834,8 @@ static int acpi_idle_enter_c1(struct cpu
>  
>  	/* Do not access any ACPI IO ports in suspend path */
>  	if (acpi_idle_suspend) {
> -		acpi_safe_halt();
>  		local_irq_enable();
> +		cpu_relax();
>  		return 0;
>  	}

Hmm, we removed the pm_idle_safe logic which took care of that in
older kernel versions :(

        if (!cx || acpi_idle_suspend) {
                if (pm_idle_save)
                        pm_idle_save();
                else
                        acpi_safe_halt();
                return;
        }

That's what took care of the broadcast on those AMD C1E machines as
well.

But yeah, that cpu_relax() loop is probably fine for the suspend path.

Thanks,

	tglx
