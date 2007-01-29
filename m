From: Len Brown <lenb@kernel.org>
Subject: Re: + acpi-keep-track-of-timer-broadcasting-fix.patch added to -mm tree
Date: Mon, 29 Jan 2007 18:55:35 -0500
Message-ID: <200701291855.36352.lenb@kernel.org>
References: <200701282247.l0SMl3rG005194@shell0.pdx.osdl.net> <200701282153.29132.lenb@kernel.org> <20070129065540.GB23785@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39288 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964865AbXA3ADp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Jan 2007 19:03:45 -0500
In-Reply-To: <20070129065540.GB23785@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, mm-commits@vger.kernel.org, ak@muc.de, johnstul@us.ibm.com, tglx@linutronix.de, zippel@linux-m68k.org, linux-acpi@vger.kernel.org, asit.k.mallick@intel.com, Arjan van de Ven <arjan@infradead.org>

On Monday 29 January 2007 01:55, Ingo Molnar wrote:
> 
> * Len Brown <lenb@kernel.org> wrote:
> 
> > > -     if(cx->type == ACPI_STATE_C3 ||
> > > -        boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> > > +	if (cx->type >= ACPI_STATE_C2)
> > >  		pr->power.timer_broadcast_on_state = state;
> > > -		return;
> > > -	}
> > 
> > This is going to be a problem. Do you have a pointer to an Intel box 
> > who's LAPIC timer stops in C2?
> 
> btw., why is it going to be a problem? It basically activates the 
> fall-back-to-PIT-broadcasting workaround for all C2-capable systems. 
> Given that most modern laptops do C3, and C3 definitely turns off the 
> lapic, is this a big issue? I'd rather default to the more conservative 
> behavior on C2 too.

Why don't we activate the fall-back-to-PIT-broadcasting always --
even for systems which have just C1?

The answer to that question is the same as the answer to the question you ask.

I don't think the above patch is conservative, AFAIK it is simply erroneous.

My understanding is that
1. All existing and future Intel systems have a FUNCTIONAL LAPIC timer in C2.
2. All existing Intel systems have a BROKEN LAPIC timer in C3.

If you've found a system that defies these rules, then I'm extremely
interested to know about it.

> note that with the new clockevents code the workaround can fall back not 
> just to the PIT but to hpet as well - if it's available. The T60 
> core2duo laptop i have does that for example. That gives much 
> higher-quality dynticks behavior. (the PIT is limited to a maximum of 27 
> msecs interval - resulting in a minimum rate of 37 timer irqs per 
> second)

The fact that the HPET can interrupt at a very high rate is moot
from a power management point of view.
If we are focusing on the region above O(40H) HZ, then we already
blew it from a power savings point of view, as the very deep C-states
will not save any power at high interrupt rates.

Another alternative would be for systems with C3 to fall-back to a
periodic tick scheme that we have today.  From a power point of view,
HZ=100 would be only a little bit worse than Windows HZ=64.
However, FC6 seems to have marched off an built with
HZ=1000 -- so we'd have some challenges with static HZ too...

-Len
