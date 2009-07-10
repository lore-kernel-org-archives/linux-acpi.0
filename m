From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Fri, 10 Jul 2009 16:29:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907101548200.9103@localhost.localdomain>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com>
 <1245825558.19816.1861.camel@twins>
 <20090624074703.GA28458@sli10-desk.sh.intel.com>
 <1245830585.31755.11.camel@twins>
 <alpine.LFD.2.00.0906241239440.20716@localhost.localdomain>
 <1246002370.31755.187.camel@twins>
 <alpine.LFD.2.00.0906261209370.4148@localhost.localdomain>
 <20090626194908.GA11492@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:51268 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbZGJU3c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jul 2009 16:29:32 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KML00GH6294V5C2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Jul 2009 15:29:29 -0500 (CDT)
In-reply-to: <20090626194908.GA11492@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Shaohua Li <shaohua.li@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

> > Low Frequency Mode (LFM), aka Pn - the deepest P-state,
> > is the lowest energy/instruction because it is this highest
> > frequency available at the lowest voltage that can still
> > retire instructions.
> > 
> > That is why it is the first method used -- it returns the
> > highest power_savings/performance_impact.
> 
> For a straightforward workload on a dual package system, do you get more 
> performance from two packages running at their lowest P state or from 
> one package at its highest P state and a forced-idle package?
>
> Which consumes more power?

For simplicity, lets say...

Pn = P1/2  eg. P1=3GHz, and Pn=1.5 GHz.
Lets assume that the application
has zero cache and memory footprint
and performance = CPU cycles.

In that case, we could choose to either cut the
frequency of 8 threads in half, or cut the frequency
of 4 threads to 0 -- and we have a "cycle count"
performance wash.

Reality is that applications do care about memory,
and so doubling the available cache is a performance
win for P-states.  If the application is something that
notices latency of multiple threads sharing a CPU
vs a thread/CPU, then P-states would again win
because of more available cores.

Current Intel multi-package systems don't quite get
down to P1/2 -- so the deepest P-state would actually
not have quite as much performance impact.
Last AMD system I saw got down to 1GHz, so on that
system P-state could (potentially) have a performance
impact greater than off-lining.

Power is more complicated.

We discussed not saving much when an HT sibling is taken
off line, right?  The converse is also true, HT siblings
are almost free in terms of power.  So even though an HT
sibling doesn't have the performance of a dedicated core,
it is actually one of the best performance/watt parts
of the system on many workloads.  So you want to disable
this last, not first; by exhausting p-states before
you take your siblings off line.

Lets discuss turbo-mode.
Think of turbo in these terms...
The ideal system to the HW designers is one that can
spend a fixed power+electrical budget in any way
on performance.
ie. when some cores are idle, spend that budget
to make the other cores go faster -- faster even
than the advertised P0 frequency.

As turbo has the highest voltage, it has the lowest
efficiency in terms of instruction/energy.
Thus it is very important that in power limited secarios
that turbo (aka P0) be disabled first.

There is a cross-over where a C-state that is highly
optimized will be less impact on total system efficiency
than a reduced P-state.  However, we don't see that
cross over on current Intel systems on workloads measured.
The reason is that they set Pn to the minimum voltage
where P-states are useful and run as fast as they
can at that voltage.  If the system were throttled
say via T-states, down to an extremely low clock rate,
then C-states would win sooner.

-Len Brown, Intel Open Source Technolgy Center



