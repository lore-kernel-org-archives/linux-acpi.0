From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Thu, 11 Oct 2012 19:21:26 +0200
Message-ID: <9187353.riJYJYPsk3@vostro.rjw.lan>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org> <2357350.9DgMVa61GL@vostro.rjw.lan> <507699B5.3010702@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:43260 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759004Ab2JKRRs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Oct 2012 13:17:48 -0400
In-Reply-To: <507699B5.3010702@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, pdeschrijver@nvidia.com, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Thursday 11 of October 2012 12:04:37 Daniel Lezcano wrote:
> On 10/07/2012 11:26 PM, Rafael J. Wysocki wrote:
> > On Tuesday 25 of September 2012 00:43:54 Daniel Lezcano wrote:
> >> With the tegra3 and the big.LITTLE [1] new architectures, several cpus
> >> with different characteristics (latencies and states) can co-exists on the
> >> system.
> >>
> >> The cpuidle framework has the limitation of handling only identical cpus.
> >>
> >> This patch removes this limitation by introducing the multiple driver support
> >> for cpuidle.
> >>
> >> This option is configurable at compile time and should be enabled for the
> >> architectures mentioned above. So there is no impact for the other platforms
> >> if the option is disabled. The option defaults to 'n'. Note the multiple drivers
> >> support is also compatible with the existing drivers, even if just one driver is
> >> needed, all the cpu will be tied to this driver using an extra small chunk of
> >> processor memory.
> >>
> >> The multiple driver support use a per-cpu driver pointer instead of a global
> >> variable and the accessor to this variable are done from a cpu context.
> 
> Thanks Rafael for the review.
> 
> I took into account all your remarks for the V2.
> 
> [ cut ]
> 
> >> +static int __cpuidle_register_all_cpu_driver(struct cpuidle_driver *drv)
> >> +{
> >> +	int ret = 0;
> >> +	int i, cpu;
> >> +
> >> +	for_each_present_cpu(cpu) {
> >> +		ret = __cpuidle_register_driver(drv, cpu);
> >> +		if (!ret)
> >> +			continue;
> >> +		for (i = cpu - 1; i >= 0; i--)
> > I wonder if this is going to work in all cases.  For example, is there any
> > guarantee that the CPU numbers start from 0 and that there are no gaps?
> 
> AFAICS, the cpumask.h is not assuming the cpu numbers start from zero
> and they are contiguous.
> 
> I will fix this reverse loop, thanks for spotting this.
> 
> [ cut ]
> 
> >>  void cpuidle_unregister_driver(struct cpuidle_driver *drv)
> >>  {
> >>  	spin_lock(&cpuidle_driver_lock);
> >> -	__cpuidle_unregister_driver(drv);
> >> +#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
> >> +	__cpuidle_unregister_all_cpu_driver(drv);
> >> +#else
> >> +	__cpuidle_unregister_driver(drv, smp_processor_id());
> >> +#endif
> > I'm slightly cautious about using smp_processor_id() above.
> > get_cpu()/put_cpu() is the preferred way of doing this nowadays (although
> > this particular code is under the spinlock, so it should be OK).
> yes, get_cpu does preempt_disable() and smp_processor_id()
> As spin_lock does also preempt_disable() that should be ok.
> But I changed the code to use the preferred way.

Cool, thanks!

I've seen your new version and I'm going to look deeper into it in the next
few days, but I will be travelling from tomorrow through the end of the next
week, so I may be even slower to respond than usually. Sorry about that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
