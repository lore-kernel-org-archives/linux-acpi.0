From: Ingo Molnar <mingo@elte.hu>
Subject: Re: + acpi-keep-track-of-timer-broadcasting-fix.patch added to -mm tree
Date: Tue, 30 Jan 2007 21:34:15 +0100
Message-ID: <20070130203415.GD1246@elte.hu>
References: <200701282247.l0SMl3rG005194@shell0.pdx.osdl.net> <200701282153.29132.lenb@kernel.org> <20070129065540.GB23785@elte.hu> <200701291855.36352.lenb@kernel.org> <1170115975.29240.111.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46610 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbXA3UhX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Jan 2007 15:37:23 -0500
Content-Disposition: inline
In-Reply-To: <1170115975.29240.111.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>, akpm@osdl.org, mm-commits@vger.kernel.org, ak@muc.de, johnstul@us.ibm.com, zippel@linux-m68k.org, linux-acpi@vger.kernel.org, asit.k.mallick@intel.com, Arjan van de Ven <arjan@infradead.org>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > Another alternative would be for systems with C3 to fall-back to a
> > periodic tick scheme that we have today.  From a power point of view,
> > HZ=100 would be only a little bit worse than Windows HZ=64.
> > However, FC6 seems to have marched off an built with
> > HZ=1000 -- so we'd have some challenges with static HZ too...
> 
> With dyntick enabled kernels you get ~ HZ=37 as the worst case with 
> PIT, while we go down to ~4HZ with HPET / apic timer (as long as it 
> works)

s/worst case/best case

the lower we can make the timer irq rate on an idle system, the better. 
HPET allows us to go from 37 Hz down to 4 Hz.

	Ingo
