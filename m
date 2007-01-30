From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: + acpi-keep-track-of-timer-broadcasting-fix.patch added to -mm
	tree
Date: Tue, 30 Jan 2007 01:12:55 +0100
Message-ID: <1170115975.29240.111.camel@localhost.localdomain>
References: <200701282247.l0SMl3rG005194@shell0.pdx.osdl.net>
	 <200701282153.29132.lenb@kernel.org> <20070129065540.GB23785@elte.hu>
	 <200701291855.36352.lenb@kernel.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:55210 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964783AbXA3AMO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Jan 2007 19:12:14 -0500
In-Reply-To: <200701291855.36352.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, mm-commits@vger.kernel.org, ak@muc.de, johnstul@us.ibm.com, zippel@linux-m68k.org, linux-acpi@vger.kernel.org, asit.k.mallick@intel.com, Arjan van de Ven <arjan@infradead.org>

On Mon, 2007-01-29 at 18:55 -0500, Len Brown wrote:
> My understanding is that
> 1. All existing and future Intel systems have a FUNCTIONAL LAPIC timer in C2.
> 2. All existing Intel systems have a BROKEN LAPIC timer in C3.
> 
> If you've found a system that defies these rules, then I'm extremely
> interested to know about it.

Ask akpm. His vaio has this problem since ages. As well as other Intel
based boxen. Yes, they have broken BIOSes ....

Adding a commandline option like "c2works" might be appropriate. This
would also keep TSC alive on C2, where we default to not use it when C2
is reached right now for the very same reason (break as few boxen as
possible). Say thanks to AMD for that invention.

> > note that with the new clockevents code the workaround can fall back not 
> > just to the PIT but to hpet as well - if it's available. The T60 
> > core2duo laptop i have does that for example. That gives much 
> > higher-quality dynticks behavior. (the PIT is limited to a maximum of 27 
> > msecs interval - resulting in a minimum rate of 37 timer irqs per 
> > second)
> 
> The fact that the HPET can interrupt at a very high rate is moot
> from a power management point of view.
> If we are focusing on the region above O(40H) HZ, then we already
> blew it from a power savings point of view, as the very deep C-states
> will not save any power at high interrupt rates.

You misunderstood. HPET is much better than PIT for dynticks, as the
maximum timeout with HPET is way longer than with PIT (PIT maximum is
27ms). We can idle sleep longer with HPET than with PIT.

> Another alternative would be for systems with C3 to fall-back to a
> periodic tick scheme that we have today.  From a power point of view,
> HZ=100 would be only a little bit worse than Windows HZ=64.
> However, FC6 seems to have marched off an built with
> HZ=1000 -- so we'd have some challenges with static HZ too...

With dyntick enabled kernels you get ~ HZ=37 as the worst case with PIT,
while we go down to ~4HZ with HPET / apic timer (as long as it works)

	tglx


