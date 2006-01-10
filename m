From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: [RFC 2/2] new C-state policy
Date: Wed, 11 Jan 2006 00:17:11 +0100
Message-ID: <20060110231711.GB30356@isilmar.linta.de>
References: <1136866376.5750.29.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1136866376.5750.29.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Tue, Jan 10, 2006 at 12:12:56PM +0800, Shaohua Li wrote:
> Enhancements:
> 1. it does all policy calculation before going into idle, so other tasks
> can be quickly scheduled after idle.

This is much more tricky:

if CONFIG_PREEMPTION isn't set, this is (mostly) correct.

IDLE:
	acpi_processor_idle()
	{
		local_irq_disable()
		... -> pre_cx()
		? need_resched()
		ENTER_CSTATE
		local_irq_enable()
		... -> post_cx()
	}

However: all calculations are done with IRQs -- needlessly -- off. All IRQs
appearing between local_irq_disable() and ENTER_CSTATE will cause a failed
transition, and only be handled afterwards. And that's bad for two reasons:
firstly it took some time until we handled the IRQ, secondly because failed
transitions into C-States cost time and power and thus energy. Therefore,
the span between the putting IRQs off and entering the C-State must be quite
small.

Also, if CONFIG_PREEMTPION is set, something else happens: the idle task's
instruction pointer points right after the "local_irq_enable()" call. As
once we enabled IRQs, we also allowed the lowest-priority idle thread to be
preempted by any other process wanting to run. Therefore, once the system
becomes idle, we'll first do the "->post_cx()" calculation (with IRQs
off!) before going back to the loop which calls acpi_processor_idle()
again, and only then IRQs are disabled, "->pre_cx()" is called, and so on.

As the behaviour is so totally different whether CONFIG_PREEMPTION is set or
not, I'd suggest the following (untested): add a "schedule()" right after
"local_irq_enable()". This will force the same behaviour as
CONFIG_PREEMPTION does currently also for the !CONFIG_PREEMTPION case.

> It's still not very good. Comments/suggestions are highly appreciated.
Take a look at my four patches, please, and all the tricks and tweaks they
do ;-)

> +	while (diff) {
> +		/* if we didn't get called, assume there was busmaster activity */
... this turned out to be a bad  idea, especially with dyn ticks enabled.

> +		diff --;
> +		if (diff)
> +			pr->power.bm_activity |= 0x1;
> +		pr->power.bm_activity <<= 1;
> +	}
> +
> +	if (bm_status) {
> +		pr->power.bm_activity++;
|= 0x1 not ++;


Also, the actual checking for bm_activity should be common code, e.g.

int acpi_processor_is_there_bm_activity()
{
	if (...)
		return 1;
	return 0;
}


Thanks,
	Dominik
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
