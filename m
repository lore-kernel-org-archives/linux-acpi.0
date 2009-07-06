From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Mon, 6 Jul 2009 23:33:12 +0530
Message-ID: <20090706180312.GC26831@dirshya.in.ibm.com>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com> <1245825558.19816.1861.camel@twins> <20090624074703.GA28458@sli10-desk.sh.intel.com> <1245830585.31755.11.camel@twins> <20090624082112.GA20844@sli10-desk.sh.intel.com> <20090626181623.GF7717@dirshya.in.ibm.com> <20090629025455.GA20614@sli10-desk.sh.intel.com>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:34427 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbZGFSDr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2009 14:03:47 -0400
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n673rOSC031843
	for <linux-acpi@vger.kernel.org>; Tue, 7 Jul 2009 13:53:24 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n66I3lhq1282224
	for <linux-acpi@vger.kernel.org>; Tue, 7 Jul 2009 04:03:47 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n66I3kth030498
	for <linux-acpi@vger.kernel.org>; Tue, 7 Jul 2009 04:03:47 +1000
Content-Disposition: inline
In-Reply-To: <20090629025455.GA20614@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "lenb@kernel.org" <lenb@kernel.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

* Shaohua Li <shaohua.li@intel.com> [2009-06-29 10:54:55]:

[snip]

> > 
> > How do we handle interrupts and timers during this interval?  You seem
> > to disable interrupts and hold the cpu at idle for 0.95 sec.  It may
> > cause timeouts and overflows for network interrupts right?
> The x86 mwait/monitor instruction can detect interrupt and complete execution
> even interrupt is disabled, so this isn't an issue.

Cool, this will save a lot of trouble :)
 
> > Next issue is halting sibling threads belonging to a core at the same
> > time to have any power/thermal benefit.  Who does the coordination for
> > forced idle in this approach?
> Nobody does the coordination. Halt some threads even they belong to a core
> is the best we can provide now. For future, if the scheduler approach really
> works, we will happily use it.

Do you have some indicative data to show that arbitrary force-idling
of hardware threads reduce power and heat?  It will be very good if
this works without coordination among siblings.  Basically what you
are saying is that running one or two of the force-idle threads in
a 16-thread system provides significant reduction in power even
without explicit methods to ensure that they idle sibling threads
belonging to same core.

--Vaidy

