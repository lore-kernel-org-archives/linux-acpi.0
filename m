From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Sat, 12 May 2007 13:52:06 +0200
Message-ID: <1178970726.22481.150.camel@localhost.localdomain>
References: <20070430102837.748238000@linutronix.de>
	 <20070511132846.5ebf4437.akpm@linux-foundation.org>
	 <200705112302.47726.rjw@sisk.pl> <200705112309.15996.rjw@sisk.pl>
	 <20070511235607.83ad0eb5.akpm@linux-foundation.org>
	 <1178959563.22481.126.camel@localhost.localdomain>
	 <20070512020056.a24cf472.akpm@linux-foundation.org>
	 <1178961489.22481.133.camel@localhost.localdomain>
	 <20070512030754.90488f79.akpm@linux-foundation.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:40274 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754323AbXELLtC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2007 07:49:02 -0400
In-Reply-To: <20070512030754.90488f79.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Sat, 2007-05-12 at 03:07 -0700, Andrew Morton wrote:
> On Sat, 12 May 2007 11:18:09 +0200 Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > It's peculiar that the hang happens when acpi_evaluate_object() hits its
> > > return statement.  Any theories there?
> > 
> > Only stack or memory corruption come into mind, but I have no clue how
> > this is related to the resume logic changes.
> 
> So I had the brilliant idea of turning on some kernel debugging.  It's
> a shame that CONFIG_SOFTWARE_SUSPEND disables CONFIG_DEBUG_PAGEALLOC.

...

> I don't really know what lockdep is complaining about there.  I assume I'm
> not supposed to, given that whoever wrote that couldn't be bothered
> documenting any of it.
> 
> I _think_ it means that lockdep believes that local irqs are enabled
> (according to its state tracking), only it turns out that they're not.

Right. Lockdep checks, whether the tracked interrupt disabled/enabled
state is the same as the state in the hardware. When the check triggers,
then we disabled / enabled interrupts somewhere without going through
lockdeps state tracker. 

/me suspects ASM code missing the TRACE_IFQS_OFF macro in some place,
which was recently modified.

	tglx


