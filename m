From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Fri, 10 Jul 2009 15:47:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907101534310.9103@localhost.localdomain>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com>
 <1245825558.19816.1861.camel@twins>
 <20090624074703.GA28458@sli10-desk.sh.intel.com>
 <1245830585.31755.11.camel@twins>
 <alpine.LFD.2.00.0906241239440.20716@localhost.localdomain>
 <1246002370.31755.187.camel@twins>
 <alpine.LFD.2.00.0906261209370.4148@localhost.localdomain>
 <20090626184203.GG7717@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:43833 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbZGJTsQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jul 2009 15:48:16 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KML00L030BL22Z1@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Jul 2009 14:47:51 -0500 (CDT)
In-reply-to: <20090626184203.GG7717@dirshya.in.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Shaohua Li <shaohua.li@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>


> > > Hmm, would fully idling a socket not be more efficient (throughput wise)
> > > than forcing everybody into P states?
> > 
> > Nope.
> > 
> > Low Frequency Mode (LFM), aka Pn - the deepest P-state,
> > is the lowest energy/instruction because it is this highest
> > frequency available at the lowest voltage that can still
> > retire instructions.
> 
> This is true if you want to retire instructions.  But in case you want
> to stop retiring instructions and hold cores in idle, then idling
> complete package will be more efficient right?


No.  Efficiency = Work/Energy
Thus if Work=0, then Efficiency=0.

>  Atleast you will need
> to idle all the sibling threads at the same time to save power in
> a core.

Yes.  Both HT siblings need to be idled in a core
for it to significantly reduce power.

> > That is why it is the first method used -- it returns the
> > highest power_savings/performance_impact.
> 
> Depending on what is running in the system, force idling cores may
> help reduce average power as compared to running all cores at lowest
> P-state.

The workloads that we've measured show that reducing p-states
has a smaller impact to average performance than idling cores.

> > The power and thermal monitoring are out-of-band in the platform,
> > so Linux is not (currently) part of a closed control loop.
> > However, Linux is part of the control, and the loop is indeed closed:-)
> 
> The more we could include Linux in the control loop, we can better
> react to the situation with least performance impact.

Some vendors prever to control things in-band,
some prefer to control them out-of-band.

I'm agnostic.  Vendors should be free to provision, and customers
should be free to run systems in the way that they choose.

> > > The thing I'm thinking off is vaidy's load-balancer changes that take an
> > > overload packing argument.
> > > 
> > > If we can couple that to the ACPI driver in a closed feedback loop we
> > > have automagic tuning.
> > 
> > I think that those changes are probably fancier than we need for
> > this simple mechanism right now -- though if they ended up being different
> > ways to use the same code in the long run, that would be fine.
> 
> I agree that the load-balancer approach is more complex and has
> challenges.

The main challenge of the load-balancer approach is
that it it not available to be shipped today.

> But it does have long term benefits because we can
> utilise the scheduler's knowledge of system topology and current
> system load to arrive at what is best.

> > > Some integration with P states might be interesting to think about. But
> > > as it stands getting that load-balancer placement stuff fixed seems like
> > > enough fun ;-)
> > 
> > I think that we already have an issue with scheduler vs P-states,
> > as the scheduler is handing out buckets of time assuming that 
> > they are all equal.  However, a high-frequency bucket is more valuable
> > than a low frequency bucket.  So probably the scheduler should be tracking
> > cycles rather than time...
> > 
> > But that is independent of the forced-idle thread issue at hand.
> > 
> > We'd like to ship the forced-idle thread as a self-contained driver,
> > if possilbe.  Because that would enable us to easily back-port it
> > to some enterprise releases that want the feature.  So if we can
> > implement this such that it is functional with existing scheduler
> > facilities, that would be get us by.  If the scheduler evolves
> > and provides a more optimal mechanism in the future, then that is
> > great, as long as we don't have to wait for that to provide
> > the basic version of the feature.
> 
> ok, so if you want a solution that would work on older distros also,
> then your choices are limited.  For backports, perhaps this module
> will work, but should not be a baseline solution for future.

The current driver receives the number of cpu's to idle from
the system, and spawns that many forced-idle threads.

When Linux has a method better than spawning forced-idle-threads,
we'll gladly update the driver to us it...

thanks,
-Len Brown, Intel Open Source Technology Center

