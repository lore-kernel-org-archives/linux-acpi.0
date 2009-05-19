From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]cpuset: add new API to change cpuset top group's cpus
Date: Tue, 19 May 2009 15:01:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905191429440.29241@localhost.localdomain>
References: <20090519073942.GA10864@sli10-desk.sh.intel.com>
 <1242722454.26820.461.camel@twins>
 <20090519084852.GA13682@sli10-desk.sh.intel.com>
 <1242723364.26820.466.camel@twins> <1242729538.26820.497.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:41648 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbZESTCa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 15:02:30 -0400
In-reply-to: <1242729538.26820.497.camel@twins>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Shaohua Li <shaohua.li@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "menage@google.com" <menage@google.com>

> ... the point is, we
> don't need a new interface to force a cpu idle. Hotplug does that.
>
> Furthermore, we should not want anything outside of that, either the cpu
> is there available for work, or its not -- halfway measures don't make
> sense.
> 
> Furthermore, we already have power aware scheduling which tries to
> aggregate idle time on cpu/core/packages so as to maximize the idle time
> power savings. Use it there.

Some context...

In the past, server room power and thermal issues were handled
either by spending too much money to provision power and
thermals for theoretical worst case, or by abruptly shutting off
servers when hard limits were reached.

Going forward, platforms are getting smarter, measuring how
much power is drawn from the power supply, measuring the room
thermals etc. so that real dollars can be saved by deploying
systems that exceed the theoretical worst case if the power
and thermal limits are enforced.

So if server approaches a budget, the platform
will notify the OS to limit its P-states, and limit its T-states
in order to draw less power.

If that is not sufficient, the platform will ask us to take
processors off-line.  These are not processors that are otherwise idle
-- those are already saving as much power as they can --
these are processors that are fully utilized.

So power-aware scheduling is moot here, this isn't the
partially idle case, this is the fully utilized case.

If power draw continues to be too high, the platform
will simply ask us to take more processors off line.

If this dance doesn't reduce power below that required,
the platform will be shut off.

So it is sufficient to simply not schedule cpu burners
on the 'idled' processor.  Interrupts should generally
not matter -- and if they do, we'll end up simply idling
an additional processor.

> > > Besides, a hot removed cpu will do a dead loop halt, which isn't power saving
> > > efficient. To make hot removed cpu enters deep C-state is in whish list for a
> > > long time, but still not available. The acpi_processor_idle is a module, and
> > > cpuidle governor potentially can't handle offline cpu.
> > 
> > Then fix that hot-unplug idle loop. I agree that the hlt thing is silly,
> > and I've no idea why its still there, seems like a much better candidate
> > for your efforts than this.

CONFIG_HOTPLUG_CPU has been problematic in the past.
It does more than what we need here, so we thought
a lighter-weight and lower-latency method that simply
didn't schedule to the idled cpu would suffice.

Personally, I don't think that CONFIG_HOTPLUG_CPU should exist,
taking processors on and off-line should be part of CONFIG_SMP.

A while back when I selected CONFIG_HOTPLUG_CPU from ACPI && SMP,
there was a torrent of outrage that it infringed on user's right's
to save that additional 18KB of memory that CONFIG_HOTPLUG_CPU
includes that SMP does not...

We are fixing the hotplug-unplug idle loop, but there
turns out to be some issues with it related to idle
processors with interrupts disabled that don't actually
get down into the deep C-states we request:-(

So this is why you see a patch for a "halfway measure",
it does what is necessary, and does nothing more.

-Len

