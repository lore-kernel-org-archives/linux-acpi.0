From: Ingo Molnar <mingo@elte.hu>
Subject: Re: + acpi-keep-track-of-timer-broadcasting-fix.patch added to -mm tree
Date: Tue, 30 Jan 2007 21:31:18 +0100
Message-ID: <20070130203118.GC1246@elte.hu>
References: <200701282247.l0SMl3rG005194@shell0.pdx.osdl.net> <200701282153.29132.lenb@kernel.org> <20070129065540.GB23785@elte.hu> <200701291855.36352.lenb@kernel.org> <1170115975.29240.111.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:43117 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbXA3Ueo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Jan 2007 15:34:44 -0500
Content-Disposition: inline
In-Reply-To: <1170115975.29240.111.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>, akpm@osdl.org, mm-commits@vger.kernel.org, ak@muc.de, johnstul@us.ibm.com, zippel@linux-m68k.org, linux-acpi@vger.kernel.org, asit.k.mallick@intel.com, Arjan van de Ven <arjan@infradead.org>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 2007-01-29 at 18:55 -0500, Len Brown wrote:
> > My understanding is that
> > 1. All existing and future Intel systems have a FUNCTIONAL LAPIC timer in C2.
> > 2. All existing Intel systems have a BROKEN LAPIC timer in C3.
> > 
> > If you've found a system that defies these rules, then I'm extremely
> > interested to know about it.
> 
> Ask akpm. His vaio has this problem since ages. As well as other Intel 
> based boxen. Yes, they have broken BIOSes ....

my HP nx9030 is one such box too. [ I sent the BIOS info - Len, did you 
get those? ]

	Ingo
