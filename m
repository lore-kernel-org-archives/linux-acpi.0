From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Fri, 26 Jun 2009 12:46:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906261209370.4148@localhost.localdomain>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com>
 <1245825558.19816.1861.camel@twins>
 <20090624074703.GA28458@sli10-desk.sh.intel.com>
 <1245830585.31755.11.camel@twins>
 <alpine.LFD.2.00.0906241239440.20716@localhost.localdomain>
 <1246002370.31755.187.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:35274 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZFZQra (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 12:47:30 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLU00HM7UME4GN9@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 26 Jun 2009 11:47:07 -0500 (CDT)
In-reply-to: <1246002370.31755.187.camel@twins>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Shaohua Li <shaohua.li@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

> > ACPI is just the messenger here - user policy in in charge,
> > and everybody agrees, user policy is always right.
> > 
> > The policy may be a thermal cap to deal with thermal emergencies
> > as gracefully as possible, or it may be an electrical cap to
> > prevent a rack from approaching the limits of the provisioned
> > electrical supply.
> > 
> > This isn't about a brain dead administrator, doomed thermal policy,
> > or a broken ACPI spec.  This mechanism is about trying to maintain
> > uptime in the face of thermal emergencies, and spending limited
> > electrical provisioning dollars to match, rather than grosely exceed,
> > maximum machine room requirements.
> > 
> > Do you have any fundamental issues with these goals?
> > Are we agreement that they are worth goals?
> 
> As long as we all agree that these will be rare events, yes.
> 
> If people think its OK to seriously overcommit on thermal or electrical
> (that was a new one for me) capacity, then we're in disagreement.

As with any knob, there is a reasonable and an un-reasonable range...

The most obvious and reasonable is to use this mechanism as a guarantee
that the rack shall not exceed provisioned power.  In the past,
IT would add up the AC/CD name-plates inside the rack and call facilities
to provision that total.  While this was indeed a "guaranteed not to 
exceed" number, the margin of that number over actual peak actual was
often over 2x, causing IT to way over-estimate and way over-spend.
So giving IT a way to set up a guarantee that is closer to measured
peak consumption saves them a bundle of $$ on electrical provisioning.

The next most useful scenario is when the cooling fails.
Many machine rooms have multiple units and and when one goes off line,
the temperature rises.  Rather than having to either power off the
servers or provision fully redundant cooling, it is extremely 
valuableuseful to be able to ride-out cooling issues, preserving uptime.

Could somebody cut it too close and have these mechanisms cut in 
frequently?  Sure, and they'd have a mesurable impact on performance,
likely impacting their users and their job security...

> > The forced-idle technique is employed after the processors have
> > all already been forced to their lowest performance P-state
> > and the power/thermal problem has not been resolved.
> 
> Hmm, would fully idling a socket not be more efficient (throughput wise)
> than forcing everybody into P states?

Nope.

Low Frequency Mode (LFM), aka Pn - the deepest P-state,
is the lowest energy/instruction because it is this highest
frequency available at the lowest voltage that can still
retire instructions.

That is why it is the first method used -- it returns the
highest power_savings/performance_impact.

> Also, who does the P state forcing, is that the BIOS or is that under OS
> control?

Yes.
The platform (via ACPI) tells the OS that the highest
performance p-state is off limites, and cpufreq responds
to that by keeping the frequency below that limit.

The platform monitors the cause of the issue and if it doesn't
go away, tells us to limit to successively deeper P-states
until if necessary, we arrive at Pn, the deepest (lowest 
performance) P-state.

If the OS does not respond to these requests in a timely manner
some platforms have the capability to make these P-state
changes behind the OS's back.

> > No, this isn't a happy scenario, we are definately impacting
> > performance.  However, we are trying to impact system performance
> > as little as possible while saving as much energy as possible.
> > 
> > After P-states are exhausted and the problem is not resolved,
> > the rack (via ACPI) asks Linux to idle a processor.
> > Linux has full freedom to choose which processor.
> > If the condition does not get resolved, the rack will ask us
> > to offline more processors.
> 
> Right, is there some measure we can tie into a closed feedback loop?

The power and thermal monitoring are out-of-band in the platform,
so Linux is not (currently) part of a closed control loop.
However, Linux is part of the control, and the loop is indeed closed:-)

> The thing I'm thinking off is vaidy's load-balancer changes that take an
> overload packing argument.
> 
> If we can couple that to the ACPI driver in a closed feedback loop we
> have automagic tuning.

I think that those changes are probably fancier than we need for
this simple mechanism right now -- though if they ended up being different
ways to use the same code in the long run, that would be fine.

> We could even make an extension to cpusets where you can indicate that
> you want your configuration to be able to support thermal control which
> would limit configuration in a way that there is always some room to
> idle sockets.
> 
> This could help avoid the: Oh my, I've melted my rack through
> mis-configuration, scenario.

I'd rather it be more idiot proof.

eg. it doesn't matter _where_ the forced idle thread lives,
it just matters that it exists _somewhere_.  So if we could
move it around with some granuarity such that its penalty
were equally shared across the system, then that would
be idiot proof.

> > If this technique fails, the rack will throttle the processors
> > down as low as 1/16th of their lowest performance P-state.
> > Yes, that is about 100MHz on most multi GHz systems...
> 
> Whee :-)
> 
> > If that fails, the entire system is powered-off.
> 
> I suppose if that fails someone messed up real bad anyway, that's a
> level of thermal/electrical overcommit that should have corporal
> punishment attached.
> 
> > Obviously, the approach is to impact performance as little as possible
> > while impacting energy consumption as much as possible.  Use the most
> > efficieint means first, and resort to increasingly invasive measures
> > as necessary...
> > 
> > I think we all agree that we must not break the administrator's
> > cpuset policy if we are asked to force a core to be idle -- for
> > whent the emergency is over,the system should return to normal
> > and bear not permanent scars.
> > 
> > The simplest thing that comes to mind is to declare a system
> > with cpusets or binding fundamentally incompatible with
> > forced idle, and to skip that technique and let the hardware
> > throttle all the processor clocks with T-states.
> 
> Right, I really really want to avoid having thermal management and
> cpusets become an exclusive feature. I think it would basically render
> cpusets useless for a large number of people, and that would be an utter
> shame.
> 
> > However, on aggregate, forced-idle is a more efficient way
> > to save energy, as idle on today's processors is highly optimized.
> > 
> > So if you can suggest how we can force processors to be idle
> > even when cpusets and binding are present in a system,
> > that would be great.
> 
> Right, so I think the load-balancer angle possibly with a cpuset
> extension that limits partitioning so that there is room for idling a
> few sockets should work out nicely.
> 
> All we need is a metric to couple that load-balancer overload number to.
> 
> Some integration with P states might be interesting to think about. But
> as it stands getting that load-balancer placement stuff fixed seems like
> enough fun ;-)

I think that we already have an issue with scheduler vs P-states,
as the scheduler is handing out buckets of time assuming that 
they are all equal.  However, a high-frequency bucket is more valuable
than a low frequency bucket.  So probably the scheduler should be tracking
cycles rather than time...

But that is independent of the forced-idle thread issue at hand.

We'd like to ship the forced-idle thread as a self-contained driver,
if possilbe.  Because that would enable us to easily back-port it
to some enterprise releases that want the feature.  So if we can
implement this such that it is functional with existing scheduler
facilities, that would be get us by.  If the scheduler evolves
and provides a more optimal mechanism in the future, then that is
great, as long as we don't have to wait for that to provide
the basic version of the feature.

thanks,
Len Brown, Intel Open Source Technology Center

