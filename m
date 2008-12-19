From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 2.6.28-rc6] ACPICA: don't cond_resched() when
	irqs_disabled()
Date: Fri, 19 Dec 2008 15:02:00 +0800
Message-ID: <1229670120.3990.11.camel@yakui_zhao.sh.intel.com>
References: <20081126135508.GA1891@localhost>
	 <alpine.LFD.2.00.0812190016120.6312@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64956 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbYLSGwv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 01:52:51 -0500
In-Reply-To: <alpine.LFD.2.00.0812190016120.6312@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Wu, Fengguang" <fengguang.wu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2008-12-19 at 13:22 +0800, Len Brown wrote:
> On Wed, 26 Nov 2008, Wu Fengguang wrote:
> 
> > [add CC to <stable@kernel.org>, since this bug was introduced in the
> > 2.6.27-rcX time frame, and should help 2.6.28 and 2.6.27.x alike]
> 
> Actually, ACPI_PREEMPTION_POINT() went in to 2.6.28-rc1,
> it is not present in 2.6.27.stable so this patch
> does not apply to 27.stable.
Hi, Len
    The issue on Fengguang's laptop is different with that on the box of
T61.  On Fengguang's laptop after evaluating one ACPI object(GPE
_L18object), the irq is disabled mystically. After some investigations
we find that it is caused by SMI(The SMI will be triggered while
evaluating the ACPI object. And this issue is also related with Video). 
       
    If the boot option of "noapic" is added on the box of bug12252, the
irq_router_resume will be called, in which the _CRS/_SRS object will be
evaluated. But unfortunately the irq is disabled when irq_router_resume
is called. 

    
Thanks.      
> 
> > The ACPI routines could be called from run_workqueue() with irqs disabled.
> > So we should test irqs_disabled() before calling cond_resched().
> 
> I don't know how you provoked this failure.
> The ACPI interpreter should always be run with interrupts enabled.
> If it isn't then that is a (different) bug.
> 
> There is, however, one exception, and it is during suspend/resume;
> and that _is_ a legal way to provoke this bug:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=12252
> 
> and thus the fix is actually correct, and I'll apply it.
> 
> thanks,
> -- Len Brown, Intel Open Source Technology Center
> 
> 
> > --- a/include/acpi/platform/aclinux.h
> > +++ b/include/acpi/platform/aclinux.h
> > @@ -141,6 +141,10 @@ static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
> >  /*
> >   * We need to show where it is safe to preempt execution of ACPICA
> >   */
> > -#define ACPI_PREEMPTION_POINT()	cond_resched()
> > +#define ACPI_PREEMPTION_POINT()		\
> > +	do {				\
> > +		if (!irqs_disabled())	\
> > +			cond_resched();	\
> > +	} while (0)
> >  
> >  #endif				/* __ACLINUX_H__ */
> > --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

