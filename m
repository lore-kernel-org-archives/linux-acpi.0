From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 2/2] new C-state policy
Date: Wed, 11 Jan 2006 10:00:54 +0800
Message-ID: <1136944855.5750.61.camel@sli10-desk.sh.intel.com>
References: <1136866376.5750.29.camel@sli10-desk.sh.intel.com>
	 <20060110231711.GB30356@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060110231711.GB30356-JwFqNg2GrOVrgjWwlLH9qw@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2006-01-11 at 00:17 +0100, Dominik Brodowski wrote:
> Hi,
> 
> On Tue, Jan 10, 2006 at 12:12:56PM +0800, Shaohua Li wrote:
> > Enhancements:
> > 1. it does all policy calculation before going into idle, so other tasks
> > can be quickly scheduled after idle.
> 
> This is much more tricky:
> 
> if CONFIG_PREEMPTION isn't set, this is (mostly) correct.
> 
> IDLE:
> 	acpi_processor_idle()
> 	{
> 		local_irq_disable()
> 		... -> pre_cx()
> 		? need_resched()
> 		ENTER_CSTATE
> 		local_irq_enable()
> 		... -> post_cx()
> 	}
> 
> However: all calculations are done with IRQs -- needlessly -- off. All IRQs
> appearing between local_irq_disable() and ENTER_CSTATE will cause a failed
> transition, and only be handled afterwards. And that's bad for two reasons:
> firstly it took some time until we handled the IRQ, secondly because failed
> transitions into C-States cost time and power and thus energy. Therefore,
> the span between the putting IRQs off and entering the C-State must be quite
> small.
> 
> Also, if CONFIG_PREEMTPION is set, something else happens: the idle task's
> instruction pointer points right after the "local_irq_enable()" call. As
> once we enabled IRQs, we also allowed the lowest-priority idle thread to be
> preempted by any other process wanting to run. Therefore, once the system
> becomes idle, we'll first do the "->post_cx()" calculation (with IRQs
> off!) before going back to the loop which calls acpi_processor_idle()
> again, and only then IRQs are disabled, "->pre_cx()" is called, and so on.
> 
> As the behaviour is so totally different whether CONFIG_PREEMPTION is set or
> not, I'd suggest the following (untested): add a "schedule()" right after
> "local_irq_enable()". This will force the same behaviour as
> CONFIG_PREEMPTION does currently also for the !CONFIG_PREEMTPION case.
I only do bm check with irq disabled. promotion/demotion calculation is
done with irq enabled. As I said, idle currently can't be preempted at
any places.

> > It's still not very good. Comments/suggestions are highly appreciated.
> Take a look at my four patches, please, and all the tricks and tweaks they
> do ;-)
Sure, I did look at your patches. They did have many good staffs. As I
said, Len hopes smooth move, so adding a new module might be better. 

> > +	while (diff) {
> > +		/* if we didn't get called, assume there was busmaster activity */
> ... this turned out to be a bad  idea, especially with dyn ticks enabled.
I only did this when there is bus activity. With this trick, dyn ticks
works fine in my test.

> > +		diff --;
> > +		if (diff)
> > +			pr->power.bm_activity |= 0x1;
> > +		pr->power.bm_activity <<= 1;
> > +	}
> > +
> > +	if (bm_status) {
> > +		pr->power.bm_activity++;
> |= 0x1 not ++;
Ok.

> 
> Also, the actual checking for bm_activity should be common code, e.g.
It's policy specific. Each policy could have its own method to calculate
bm_activity.

Thanks,
Shaohua


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
