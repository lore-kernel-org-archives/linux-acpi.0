From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Fri, 26 Jun 2009 09:46:10 +0200
Message-ID: <1246002370.31755.187.camel@twins>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com>
	 <1245825558.19816.1861.camel@twins>
	 <20090624074703.GA28458@sli10-desk.sh.intel.com>
	 <1245830585.31755.11.camel@twins>
	 <alpine.LFD.2.00.0906241239440.20716@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([62.179.121.38]:21707 "EHLO
	viefep18-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbZFZHqF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 03:46:05 -0400
In-Reply-To: <alpine.LFD.2.00.0906241239440.20716@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

On Wed, 2009-06-24 at 13:20 -0400, Len Brown wrote:
> > Any thermal facility that doesn't take cpusets into account, or worse
> > destroys user policy (the hotplug road), is a full stop in my book.
> >
> > Is similar to the saying the customer is always right, sure the admin
> > can indeed configure the machine so that any thermal policy is indeed
> > doomed to fail, and in that case I would print some warnings into syslog
> > and let the machine die of thermal overload -- not our problem.
> >
> > The thing is, the admin configures it in a way, and then expects it to
> > work like that. If any random event can void the guarantees what good
> > are they?
> > 
> > Now, if ACPI-4.0 is so broken that it simply cannot support a sane
> > thermal model, then I suggest we simply not support this feature and
> > hope they will grow clue for 4.1 and try again next time.
> 
> Peter,
> ACPI is just the messenger here - user policy in in charge,
> and everybody agrees, user policy is always right.
> 
> The policy may be a thermal cap to deal with thermal emergencies
> as gracefully as possible, or it may be an electrical cap to
> prevent a rack from approaching the limits of the provisioned
> electrical supply.
> 
> This isn't about a brain dead administrator, doomed thermal policy,
> or a broken ACPI spec.  This mechanism is about trying to maintain
> uptime in the face of thermal emergencies, and spending limited
> electrical provisioning dollars to match, rather than grosely exceed,
> maximum machine room requirements.
> 
> Do you have any fundamental issues with these goals?
> Are we agreement that they are worth goals?

As long as we all agree that these will be rare events, yes.

If people think its OK to seriously overcommit on thermal or electrical
(that was a new one for me) capacity, then we're in disagreement.

> The forced-idle technique is employed after the processors have
> all already been forced to their lowest performance P-state
> and the power/thermal problem has not been resolved.

Hmm, would fully idling a socket not be more efficient (throughput wise)
than forcing everybody into P states?

Also, who does the P state forcing, is that the BIOS or is that under OS
control?

> No, this isn't a happy scenario, we are definately impacting
> performance.  However, we are trying to impact system performance
> as little as possible while saving as much energy as possible.
> 
> After P-states are exhausted and the problem is not resolved,
> the rack (via ACPI) asks Linux to idle a processor.
> Linux has full freedom to choose which processor.
> If the condition does not get resolved, the rack will ask us
> to offline more processors.

Right, is there some measure we can tie into a closed feedback loop?

The thing I'm thinking off is vaidy's load-balancer changes that take an
overload packing argument.

If we can couple that to the ACPI driver in a closed feedback loop we
have automagic tuning.

We could even make an extension to cpusets where you can indicate that
you want your configuration to be able to support thermal control which
would limit configuration in a way that there is always some room to
idle sockets.

This could help avoid the: Oh my, I've melted my rack through
mis-configuration, scenario.

> If this technique fails, the rack will throttle the processors
> down as low as 1/16th of their lowest performance P-state.
> Yes, that is about 100MHz on most multi GHz systems...

Whee :-)

> If that fails, the entire system is powered-off.

I suppose if that fails someone messed up real bad anyway, that's a
level of thermal/electrical overcommit that should have corporal
punishment attached.

> Obviously, the approach is to impact performance as little as possible
> while impacting energy consumption as much as possible.  Use the most
> efficieint means first, and resort to increasingly invasive measures
> as necessary...
> 
> I think we all agree that we must not break the administrator's
> cpuset policy if we are asked to force a core to be idle -- for
> whent the emergency is over,the system should return to normal
> and bear not permanent scars.
> 
> The simplest thing that comes to mind is to declare a system
> with cpusets or binding fundamentally incompatible with
> forced idle, and to skip that technique and let the hardware
> throttle all the processor clocks with T-states.

Right, I really really want to avoid having thermal management and
cpusets become an exclusive feature. I think it would basically render
cpusets useless for a large number of people, and that would be an utter
shame.

> However, on aggregate, forced-idle is a more efficient way
> to save energy, as idle on today's processors is highly optimized.
> 
> So if you can suggest how we can force processors to be idle
> even when cpusets and binding are present in a system,
> that would be great.

Right, so I think the load-balancer angle possibly with a cpuset
extension that limits partitioning so that there is room for idling a
few sockets should work out nicely.

All we need is a metric to couple that load-balancer overload number to.

Some integration with P states might be interesting to think about. But
as it stands getting that load-balancer placement stuff fixed seems like
enough fun ;-)

